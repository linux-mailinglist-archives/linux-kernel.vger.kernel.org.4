Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD3960F5CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiJ0LAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiJ0K7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:59:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798A54F6B6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:59:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9so1049846pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hlaoocS4MZnDHm38p7D1UovyrWTozjBn8G/40n9AuA8=;
        b=QJSiT2HKg5jD6mBZnvsY7HHtyFz2Td3oi6rU4UGF3pg+NfJNR6EXeurVFyTNbTAvOE
         UQ2fEtgLr1opfzi36d9LbmnhQYyBgVhnTJL1a48i7V0Ix9sZRbBs6LhXuUK5yo49n6Kw
         LwNoKDb2eJkSMKjuidW182+Mi/Q9lJZTsvliKtAIBBtd4V+ACi9sW7K6EmuO93exDaB1
         94OPyMnhz//b4ILi/eInpA3dlmaPRgkUN5IhV3jNMJN1KDAqU2I+/MkiYlfeW7wzfXJA
         TQbl1o7Qm68LfnFMOZVA/NVp73YsFCKnvzUTl+Vf+qZhZADNCYaEe1yETSfY4UOA949p
         iwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlaoocS4MZnDHm38p7D1UovyrWTozjBn8G/40n9AuA8=;
        b=4YPPVh9cBnKXdLxUSTtiraEiDOfE6GicvlDflAX5RyDOEEzL/tviWmYIaQjxHBQOCJ
         tB2sZi90Cm/M9TrJaCwlDbaooUS5Vwebm9RBVUf/ifo4IJz/WriCd3JxqtQjfqX3UTWP
         viPqEJeHoFOJkvOUTyYk4JQC8jM/166IaJalXtqfpV+eOR6UCDrZqk3HAOebLJZArk+D
         JVUYkgoGeCHqATzTN9a81H7tqwiSftFitYwcfxYa7kJlzBdCs7iLfex8ACOBlWJ/6TJ3
         rc3TWh5kue6gJP4PlvFJtH+5au0gqgF6iU0TBwU6YJxH5/ciKuMQVvqOU8ZvLPQUxGSV
         hVbA==
X-Gm-Message-State: ACrzQf1nF7Vo6mwCW5T8J1qcI4Iutv++0SGBDd2W5olcuByjGG5Bqp7n
        NOIkIAkQQox1NImIOgfuTkqqf8uU9r6jcusY2qYD3g==
X-Google-Smtp-Source: AMsMyM6brKXTwhz+LlKZ5dmUXqSeN0EF6c7z6wBZGb9qzrSsXWlYKaBI1+6azdsMk7oe2imayfPugvSTnzc3mF/EwEQ=
X-Received: by 2002:a17:903:246:b0:179:96b5:1ad2 with SMTP id
 j6-20020a170903024600b0017996b51ad2mr48234592plh.37.1666868390941; Thu, 27
 Oct 2022 03:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221026135445.8004-1-johan+linaro@kernel.org>
In-Reply-To: <20221026135445.8004-1-johan+linaro@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 27 Oct 2022 12:59:14 +0200
Message-ID: <CAPDyKFo0JJQ-vwU2Ht7OKM3REQ6ehxTWhZD4Nibpz=rWgmfM2A@mail.gmail.com>
Subject: Re: [PATCH v2] firmware/psci: demote suspend-mode warning to info level
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 at 15:57, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> On some Qualcomm platforms, like SC8280XP, the attempt to set PC mode
> during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
> ("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
> is now logged at warning level:
>
>         psci: failed to set PC mode: -3
>
> As there is nothing users can do about the firmware behaving this way,
> demote the warning to info level and clearly mark it as a firmware bug:
>
>         psci: [Firmware Bug]: failed to set PC mode: -3
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Using the info level seems like a good compromise to me! So,

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/firmware/psci/psci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index e7bcfca4159f..f8fa32f0a130 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -165,7 +165,8 @@ int psci_set_osi_mode(bool enable)
>
>         err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
>         if (err < 0)
> -               pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
> +               pr_info(FW_BUG "failed to set %s mode: %d\n",
> +                               enable ? "OSI" : "PC", err);
>         return psci_to_linux_errno(err);
>  }
>
> --
> 2.37.3
>
