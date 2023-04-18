Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76256E601E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjDRLmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDRLmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:42:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF2555AC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:42:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso867756wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681818157; x=1684410157;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf1nCJGusTAIOpEPNj5fpve7PAaHYQTZE2JQsmwt9QE=;
        b=w3nI2CDX9CeRVgn1dRxz2X4TSiIDruazqTgdqI1sA7z9a7Y8jyin1MVYqucWkaOKvZ
         BFPDITjKQ2HL6usuqGssWtCL82IXyslu1ebFHM1uPsuDu8Yl0prht6fumyR5mRzFscor
         Vaxeasi8y7/R8NAMifCwJvWRg94rN2x7IMBZd4yjUFApJAYFVSkPY7nfT6fbivBsNFLf
         GAeee9q4MtcgEebqt3Gvl0olQU8QWkSCu1iW79baFgWfymVIEbK2kgYP4VvddWfcB8NE
         5bZcgUYajFel7635QhHI3v5CulDxgzol5KHO5A719p2q1MPYyuTryk2mzvCKQtlH7px5
         OGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681818157; x=1684410157;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uf1nCJGusTAIOpEPNj5fpve7PAaHYQTZE2JQsmwt9QE=;
        b=bhIz97u2IvfbXh8mWpih2eRrGb9jcGMn3zv+X1HfG83yedQkciMlR3StVrIHMbLOmH
         NLYvEX/rQGDHK3CeWDV+2VTQSXAdTesDNeCRnW3WcZ22rX1ZZwrw4DCHnamJ+/I7mjEU
         8xD1p38HB651x1OYcLXwLm761s7c83jcy1vZUjZRPTBlFvIYVBWgzlee3LAWKzMch8AQ
         +h0zc4I6iF4sz6XjsEKJZtps2xa9kIuDDZKlVT/IIKBIu/7cBzdInjT76+23eZpw4dK2
         +YUGrk+kcctJGaesxKRxAp/k1tnitTo+pJ6L4CbMuY94TQABoha5c6JI8/rB/TdAwmDL
         ZGwA==
X-Gm-Message-State: AAQBX9f7mjMfbjtPD5vJ8t/Q2BCAG05X+4UlIJqZhsPNCnY8tsurKIes
        632aN/2DOawq/sRbC4R0ix5fmw==
X-Google-Smtp-Source: AKy350Yn5hCJE11Ubo7BR00id4iO5r+7lkv33PiTuxH90oyrI5SyibVgb9voWIQK+uDeNtimhqUY7g==
X-Received: by 2002:a1c:f315:0:b0:3f1:6757:6245 with SMTP id q21-20020a1cf315000000b003f167576245mr8650275wmq.7.1681818157128;
        Tue, 18 Apr 2023 04:42:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7a02:f867:7c56:79a0? ([2a01:e0a:982:cbb0:7a02:f867:7c56:79a0])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003f07ef4e3e0sm2665744wmn.0.2023.04.18.04.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 04:42:36 -0700 (PDT)
Message-ID: <1acdf7b3-cbe4-5689-7c35-5146bc1f07f4@linaro.org>
Date:   Tue, 18 Apr 2023 13:42:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/5] phy: amlogic: enable/disable clkin during Amlogic
 USB PHY init/exit
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        mturquette@baylibre.com, vkoul@kernel.org, kishon@kernel.org,
        hminas@synopsys.com, Thinh.Nguyen@synopsys.com
Cc:     yue.wang@amlogic.com, hanjie.lin@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-phy@lists.infradead.org
References: <20230418111612.19479-1-ddrokosov@sberdevices.ru>
 <20230418111612.19479-2-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230418111612.19479-2-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 13:16, Dmitry Rokosov wrote:
> Previously, all Amlogic boards used the XTAL clock as the default board
> clock for the USB PHY input, so there was no need to enable it.
> However, with the introduction of new Amlogic SoCs like the A1 family,
> the USB PHY now uses a gated clock. Hence, it is necessary to enable
> this gated clock during the PHY initialization sequence, or disable it
> during the PHY exit, as appropriate.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   drivers/phy/amlogic/phy-meson-g12a-usb2.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> index 9d1efa0d9394..80938751da4f 100644
> --- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> @@ -172,10 +172,16 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>   	int ret;
>   	unsigned int value;
>   
> -	ret = reset_control_reset(priv->reset);
> +	ret = clk_prepare_enable(priv->clk);
>   	if (ret)
>   		return ret;
>   
> +	ret = reset_control_reset(priv->reset);
> +	if (ret) {
> +		clk_disable_unprepare(priv->clk);
> +		return ret;
> +	}
> +
>   	udelay(RESET_COMPLETE_TIME);
>   
>   	/* usb2_otg_aca_en == 0 */
> @@ -277,8 +283,11 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>   static int phy_meson_g12a_usb2_exit(struct phy *phy)
>   {
>   	struct phy_meson_g12a_usb2_priv *priv = phy_get_drvdata(phy);
> +	int ret = reset_control_reset(priv->reset);
> +
> +	clk_disable_unprepare(priv->clk);
>   
> -	return reset_control_reset(priv->reset);
> +	return ret;
>   }
>   
>   /* set_mode is not needed, mode setting is handled via the UTMI bus */

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
