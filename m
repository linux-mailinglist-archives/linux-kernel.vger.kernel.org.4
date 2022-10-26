Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848D160DF83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiJZL0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiJZL0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:26:24 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2748D8E791
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:26:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h2so8349851pgp.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X39jUhEZgZifFR/vv5lEeG2QMFhvU0R8f6aekPYqBWA=;
        b=gphVIrg81EtYYywi+G+nK+6YaojesNFW6oqgahTGwqEuGbctiEERecPF5gFFjuzMs6
         xl0N8xLb4hnhQ4vNsg4oHU/mMf02ZtDTpWCBgohnLrTTU0aZOJS+XnCUJsudzUIE1kBw
         8RHT/92RSoaTo0pBddudhEr6A3JCIzOjDZcSevpXtf6AlBtLqjitMsIXFpmOn0xMPCDY
         Lhh4hhJdy0PDHz/bMC5tc9zK1uc9b5Euo4mjMzNjCBgwW15wt7taHFRTk3rLBgmETlYn
         w5nV8XrlGo7kiZpQPMDBbsB/Vlmu2QrR2DfX7/PtQE9maajq7iKD9Pm3p8CrjLfsZ49/
         Aitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X39jUhEZgZifFR/vv5lEeG2QMFhvU0R8f6aekPYqBWA=;
        b=WWKcuFRXYRFa8r4EsT3xL9J3jpxE81Cje2uvTQ8fA5tfypdIdJtID5L7cxBHzQQUa1
         pVhfDx9sB/S0JBRcOc5j74xtLTMw7GCZfpnkrAKhQSHvo767lQB3E5nBJAbHjjsOtTPl
         Ihk2Xya+MN759PzkSUDdcHZy0C3dKUWfmKE8dHMKZTBXyHQPtvsmj8qAacPZh/8Dj4Zl
         kKk0/iMUIxugORgGHMF3NuCRpozkJPtzXnbUI6QQQVUa2rTdpQ3Z7p/IqDsA0SkrqZwA
         +zkAKc5NanvQA4qYV7goRTLhEUsOfJOiV79cAGzJbNyww3r6ozTAQ9WdCvqjzeRZ58Sa
         dvCw==
X-Gm-Message-State: ACrzQf2zPGDWvL3UHld+Ud4Uekz0R8Ay3vjLlCwVp6j+VtMi5h/x6EbX
        HJMIHOf6ATRO7o0d9i7KxsZwGWWdgHhAedAfyRjFRw==
X-Google-Smtp-Source: AMsMyM7Us9Ko9zWWL6OVuIx8zluZVYRms/TaSTeS6EVp4Yq4bg20aLKgbGMHCFYG5k/CKabd4tBR5SyLLngc0fyhMgs=
X-Received: by 2002:a05:6a00:170a:b0:563:a40a:b5e1 with SMTP id
 h10-20020a056a00170a00b00563a40ab5e1mr43327754pfc.40.1666783581306; Wed, 26
 Oct 2022 04:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221017235602.86250-1-giulio.benetti@benettiengineering.com> <20221017235602.86250-3-giulio.benetti@benettiengineering.com>
In-Reply-To: <20221017235602.86250-3-giulio.benetti@benettiengineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Oct 2022 13:25:44 +0200
Message-ID: <CAPDyKFrkAi4-BUz=qKB4S9v1gKijUt8btu=0BVbF5HDEuH6YYQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] mmc: sdhci-esdhc-imx: improve imxrt1050 data
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 at 01:56, Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
>
> i.MXRT1050 usdhc is not affected by ESDHC_FLAG_ERR004536 so let's remove
> it. It supports ESDHC_FLAG_STD_TUNING and ESDHC_FLAG_HAVE_CAP1 so let's add
> them.
>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 55981b0f0b10..4bc0a2914a95 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -306,7 +306,8 @@ static struct esdhc_soc_data usdhc_imx7ulp_data = {
>                         | ESDHC_FLAG_STATE_LOST_IN_LPMODE,
>  };
>  static struct esdhc_soc_data usdhc_imxrt1050_data = {
> -       .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_HS200 | ESDHC_FLAG_ERR004536,
> +       .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +                       | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
>  };
>
>  static struct esdhc_soc_data usdhc_imx8qxp_data = {
> --
> 2.34.1
>
