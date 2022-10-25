Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10BE60CCED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiJYNFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiJYNFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:05:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E354B841
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:04:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 192so4579814pfx.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3GufzH9w45pf5d7Evwe36+BNoT3I5gsi20mN82myB/U=;
        b=VhWEh0p89sUiaYM2kR9t8UB/lBXf1RVdQlfNf/QdALqBuGxG9oLPh6zidI5nqGr8Yl
         DqYRuLpvTGaOQIS2za22JQa2SBHLPvFMlUCJ99bE+nr7QaXUZLxerdaSwQlxe+ds4x5I
         uPCQRUFqQos2Sey9hmiCrbw6VSpvFJJaEK7+kOWsMYoCIw2iGRw5Sbjs7TOTKn4k1ojH
         3fZsHjr/PNaUBF2q9avR59z0mSxiUUFo/NIKK+ExcRkRdhqDjfd0rXBZGHIji6wjwOWt
         adgXMHWu//zXi0M1i3o3EA/DeMHc11bNJeA5sxPmPKRQn0iWdtgNAnkgl/WCDi+tYpJ6
         8ZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GufzH9w45pf5d7Evwe36+BNoT3I5gsi20mN82myB/U=;
        b=mW19aVIL2TcdEdjHCAJs4ZpctdikFqaX6BAcUfr2zJrdn8v3cMbY/RyUaGpKyJ1FDc
         PTV4N3+plzxfUqGC92RUKPTwN6ErQpDk5WXd+WAbao8lHmpMvrNvmy4Rl9QP1X5ixW/O
         MTGxUpC07FU2dlqW61stPBgBcooYZAMRAR090fGsNE1tFfFjPKfoFVZn+noPEFUDrDuE
         NcwTrIKZajJL7b+fiUvy+CTvBT3X0yFkbhWiSFXHbQcvsV3y0KWQbUE7ytd1XHotWysu
         gNzrmVFsjmk+a+TnY586mJsUGFfzC35GwHwhq7t8qUXwv+d55mFYZqegCsQt7u9ObIKz
         oSKQ==
X-Gm-Message-State: ACrzQf0FnVSwoNPd+g8MKl5mVxVs7VRQrnLJKLwn4BQmoWaHBjGGzK13
        TA0zc0Y7VM3snbbMS7q0u3WlSWukrJWAe89z5gPD+A==
X-Google-Smtp-Source: AMsMyM6ouqMMmrfjtnABefulicoUFpqVkUc8PftelxE3HVDZJSJ60G4SQtjFZhcrK7Rf4ciV4Yopm/Rex+Mbljo4/7k=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr33813912pgk.595.1666703073045; Tue, 25
 Oct 2022 06:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221024143417.11463-1-johan+linaro@kernel.org>
In-Reply-To: <20221024143417.11463-1-johan+linaro@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Oct 2022 15:03:56 +0200
Message-ID: <CAPDyKFqN_2jiRReL9dkMZeUg3jK2+TqHRHziYz9=baGzbDO+Ng@mail.gmail.com>
Subject: Re: [PATCH] firmware/psci: demote suspend-mode warning to debug level
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 at 16:36, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> On some Qualcomm platform, like SC8280XP, the attempt to set PC mode
> during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
> ("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
> is now logged at warning level:
>
>         psci: failed to set PC mode: -3
>
> As there is nothing users can do about the firmware behaving this way,
> demote the warning to debug level.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

FYI, I would be fine with a pr_info() too.

Kind regards
Uffe

> ---
>
> Note that a separate change to the cpuidle driver will start logging the
> mode actually used:
>
>         https://lore.kernel.org/all/20221020115513.93809-1-ulf.hansson@linaro.org/
>
> Johan
>
>
>  drivers/firmware/psci/psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index e7bcfca4159f..462f37fa6a86 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -165,7 +165,7 @@ int psci_set_osi_mode(bool enable)
>
>         err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
>         if (err < 0)
> -               pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
> +               pr_debug("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
>         return psci_to_linux_errno(err);
>  }
>
> --
> 2.37.3
>
