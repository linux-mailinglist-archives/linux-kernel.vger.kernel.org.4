Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC906F0A84
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbjD0RIC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Apr 2023 13:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242835AbjD0RIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:08:00 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E153581;
        Thu, 27 Apr 2023 10:07:59 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-94f59fbe2cbso255250666b.1;
        Thu, 27 Apr 2023 10:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682615277; x=1685207277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjOpVjvquwyY1SEaFRHZAoEffaspjHDd7Yo+RjYyGuU=;
        b=X5CsRmfB2K5KCZ50l+MCrJGMDz4TDiSJ+oJttajUlASYNt9z/zHbjkTm5euXx6rG+4
         rdmMbZVXh0bkPpUezyr5HXlHg2TReqQYDlaaIHhM3DEv/fDaJfFEjKM0xqd7XGzRlqxS
         vcUCnS3b4u58nZbYkbRZSKvAJDh3P/1SLF+//JGOXnHD/fiEnWD8indAWZsDprUgBPJC
         IFtHHBpejSItxFXdLBgGE+Vi1KJu9TcKfUcho255iymOJg7Z3x2fzsZ5RngxrYMQuAcr
         wN5LmYjA8IXjzhBJIQ1pnToAMSyMf3xQIe9J1a0yDPkz0U7dKiYrBBUZrMUcEMTWp32b
         SlIQ==
X-Gm-Message-State: AC+VfDw0sTMHgetZVTovbLE8/Isw8d23YRnGRZ6vvtzIQPKQhD93AeIe
        Q/htUQCJ1RWFhhnHXjh1kQ6kNcnVbTd3BrFqqGQ=
X-Google-Smtp-Source: ACHHUZ4tBlvm0opj/pK1iMQ6NuedVtxngbbHpepllg32OXF6a69Ajgg0b0dwMx7NSxh4pirwiSQ2aWCmg64HBpvIfJo=
X-Received: by 2002:a17:906:51d2:b0:933:2e79:4632 with SMTP id
 v18-20020a17090651d200b009332e794632mr2397796ejk.1.1682615277567; Thu, 27 Apr
 2023 10:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230321054714.76287-1-rui.zhang@intel.com>
In-Reply-To: <20230321054714.76287-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Apr 2023 19:07:46 +0200
Message-ID: <CAJZ5v0ha1TDPV7auMt-xNiM03ShLdA-SgWTrffx=CLxnvZijxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/governors/step_wise: delete obsolete comment
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 6:47 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Commit 4102c4042a33 ("thermal/core: Remove DROP_FULL and RAISE_FULL")
> removes support for THERMAL_TREND_RAISE_FULL/DROP_FULL but leaves the
> comment unchanged.
>
> Delete the obsolte comment about THERMAL_TREND_RAISE_FULL/DROP_FULL.
>
> Fixes: 4102c4042a33 ("thermal/core: Remove DROP_FULL and RAISE_FULL")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/gov_step_wise.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
> index 31235e169c5a..7a760b6a4279 100644
> --- a/drivers/thermal/gov_step_wise.c
> +++ b/drivers/thermal/gov_step_wise.c
> @@ -21,19 +21,11 @@
>   *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
>   *       state for this trip point
>   *    b. if the trend is THERMAL_TREND_DROPPING, do nothing
> - *    c. if the trend is THERMAL_TREND_RAISE_FULL, use upper limit
> - *       for this trip point
> - *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit
> - *       for this trip point
>   * If the temperature is lower than a trip point,
>   *    a. if the trend is THERMAL_TREND_RAISING, do nothing
>   *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
>   *       state for this trip point, if the cooling state already
>   *       equals lower limit, deactivate the thermal instance
> - *    c. if the trend is THERMAL_TREND_RAISE_FULL, do nothing
> - *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit,
> - *       if the cooling state already equals lower limit,
> - *       deactivate the thermal instance
>   */
>  static unsigned long get_target_state(struct thermal_instance *instance,
>                                 enum thermal_trend trend, bool throttle)
> --

Applied as 6.4-rc material along with the [2/2], thanks!
