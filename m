Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EA161A385
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiKDVmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiKDVms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:42:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C304B4046F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:42:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a13so9563207edj.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jg1nxhSdhqb33g9FGYVmWNSbcGrJaakkVgN/anXR2c0=;
        b=I4ZmiKvKu0bh4DTyzybENVVIYCZGuwq0+49NaEj/XSYsn+s3QCEWWrIqWbtHHXESQF
         1x8xBzAiiwBdM6cR8+WElgHkEBBhfnZzHTfrEBWgwDdtrYl7kvxzPO8Rn8LFSzYlh2w3
         CNYBmsXg5HLUFA1g0RGO2aAmA05j4+NvweGz2kcTriHY26+oHLlGhyi+w//UIYT9LNj8
         GKyC6vtPeJ8r8kGP4dvlJEyBcMWqX+F3xCAKE3H3YaCLUs8vDqGyLXAhGy+nrclMUPxD
         XAJmTp6wZ8uPlYXP3NirtPxDgyLhMOawKDzeaM5bG3B/C12WuJk6h7HrLdieBzL7u5Wt
         oSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jg1nxhSdhqb33g9FGYVmWNSbcGrJaakkVgN/anXR2c0=;
        b=m4X2XPFGrezGKRDegjJduxLg0myAgb8I6WIejbay396tDtscKon1CqglDlZ7OXBvwE
         eArW936b3fKrkwNnDCdE5oa3K/VJPVbvDPCZlMzaVG+JVEUsg/FJSuwM1mTkHyQ8tSuA
         7L1/CuCWmplx3y1cdYnm7Fdx9WZjMY0ZX4aZb2Tjy8vV1zi0oyEyIqVsvrQmYBH8rZc4
         emRsVKCc71od5z8P8H9zBD6LsF0ivpven8hS1tlQBj8RrfGt5JmdsMNmxE431tDUhpj3
         uXO8T0n/Wx399SIHUT6F8ARhXMP98TU+ksYFk3efxHofhm6ElLMB3vxISLJlL3qb2lKo
         H5mg==
X-Gm-Message-State: ACrzQf0KMVGkY2dT+JCAiRCHKdhdl6heTxfG0jWAq4yRIBxRAhi+etBT
        KWZ7KarsLdbLX9jSDdf5ROICOQ==
X-Google-Smtp-Source: AMsMyM7NAVrlIA+aTC7iR7/ZUaiCNJPc93qZ04EZdIH1JhZ0afooHByDqqY6uqAlqM2FidFx0AkUew==
X-Received: by 2002:a05:6402:440d:b0:450:de54:3fcf with SMTP id y13-20020a056402440d00b00450de543fcfmr36865871eda.312.1667598165334;
        Fri, 04 Nov 2022 14:42:45 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090623e200b007adaccb9d83sm36789ejg.193.2022.11.04.14.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:42:44 -0700 (PDT)
Date:   Fri, 4 Nov 2022 23:42:43 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     shengjiu.wang@gmail.com, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marex@denx.de
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: imx8mp: Add ids for the audio
 shared gate
Message-ID: <Y2WHU4pKDbDLT3Oz@linaro.org>
References: <1666935144-7364-1-git-send-email-shengjiu.wang@nxp.com>
 <1666935144-7364-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666935144-7364-2-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-28 13:32:23, Shengjiu Wang wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> All these IDs are for one single HW gate (CCGR101) that is shared
> between these root clocks.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  include/dt-bindings/clock/imx8mp-clock.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
> index 9d5cc2ddde89..2f6fec299662 100644
> --- a/include/dt-bindings/clock/imx8mp-clock.h
> +++ b/include/dt-bindings/clock/imx8mp-clock.h
> @@ -324,8 +324,17 @@
>  #define IMX8MP_CLK_CLKOUT2_SEL			317
>  #define IMX8MP_CLK_CLKOUT2_DIV			318
>  #define IMX8MP_CLK_CLKOUT2			319
> +#define IMX8MP_CLK_AUDIO_AHB_ROOT		320
> +#define IMX8MP_CLK_AUDIO_AXI_ROOT		321
> +#define IMX8MP_CLK_SAI1_ROOT			322
> +#define IMX8MP_CLK_SAI2_ROOT			323
> +#define IMX8MP_CLK_SAI3_ROOT			324
> +#define IMX8MP_CLK_SAI5_ROOT			325
> +#define IMX8MP_CLK_SAI6_ROOT			326
> +#define IMX8MP_CLK_SAI7_ROOT			327
> +#define IMX8MP_CLK_PDM_ROOT			328
>  
> -#define IMX8MP_CLK_END				320
> +#define IMX8MP_CLK_END				329
>  
>  #define IMX8MP_CLK_AUDIOMIX_SAI1_IPG		0
>  #define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1		1
> -- 
> 2.34.1
> 
