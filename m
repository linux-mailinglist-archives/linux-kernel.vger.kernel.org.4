Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B958E6E6021
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDRLnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjDRLm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:42:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAE586AD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:42:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2fddb442d47so272865f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681818167; x=1684410167;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DcagkLGH6ZUHuOuJsg0XYh/tLtTQW2kywcT7xAak0Uc=;
        b=VJEGSliUJ1jFsZaOXkFd/SM8WredewL8AjConyayXoQxCNk20QUGuLMOfp3swmk5Fe
         JDMy/qOSpRdvtAbJR7xvUT5gOjb+dSVn70RtfNd1dZSucxOVyRBiGcsR1NT+Yq9MxoRB
         cnQ45noXCIfwbJjSxO6CIfJKfq6lyjUaVI0OOfWBtGBfNSucJXP42DnEIVMGNoswo77+
         y5ByQMquNDeCgupZ563LDkMBUZ4IzFXINMdCDfNwsMd47Dr0ScYbS5lFqiXHH+ZymK/e
         HsVITJf0UHwf1KIv8DpFoiDKozeKHnRnLoKCh/syKQU8268PwvfkWx8fePVReTvjyOE6
         Iaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681818167; x=1684410167;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcagkLGH6ZUHuOuJsg0XYh/tLtTQW2kywcT7xAak0Uc=;
        b=L0NUcUvX7sqN2stvpGchlPFn3I+9khRatCdCHANJ8vtAX3+bhqbw6z7xT33j14DOdP
         0iHNu8aDZPnESIuDo4e+Ecy4xqg2wfI70INb5t17K6xUMLGdR3mG7maNnx8xLai6xBXC
         JyUlMl2l4XMzKrKLNE+ify+BP1ILe0wu6JwSAsWeOLdC18rJCbTXTOxCT+7nXTA9qV2v
         Ubhp+SDgoWe/uQK+brL8gtH8ZKQf374FOScLYDQFlPF2uoOHA/7tg6U5zrJcXHhQgF1O
         v4m7o/UpwZ6qsJ+6SeDsaLRzuFjovLAoEvIEwU7oTG7VDlTCMmjhpA8AXO8bB9seuaxu
         axwg==
X-Gm-Message-State: AAQBX9e8n0EMH4dp9VVNbKyyCkLOj6NDSBYAutpiINBMrkteYy0Wf3Zq
        THOqeBw2v+nK6P3hhlWpBTstNg==
X-Google-Smtp-Source: AKy350ackhhCBc0yds/Ze67p3i/fZipb9ZS+j9xLtF86Se+PsHLaBshzI4clUNbRHKIJ+qzXbbGuVw==
X-Received: by 2002:adf:ea4f:0:b0:2da:2aa0:13e8 with SMTP id j15-20020adfea4f000000b002da2aa013e8mr1680346wrn.26.1681818166847;
        Tue, 18 Apr 2023 04:42:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7a02:f867:7c56:79a0? ([2a01:e0a:982:cbb0:7a02:f867:7c56:79a0])
        by smtp.gmail.com with ESMTPSA id q17-20020a5d61d1000000b002faaa9a1721sm4614584wrv.58.2023.04.18.04.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 04:42:46 -0700 (PDT)
Message-ID: <f8c68794-0588-14e7-27b4-cb53ec257697@linaro.org>
Date:   Tue, 18 Apr 2023 13:42:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 4/5] usb: dwc3-meson-g12a: support OTG switch for all
 IP versions
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
 <20230418111612.19479-5-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230418111612.19479-5-ddrokosov@sberdevices.ru>
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
>  From now, the Amlogic A1 USB controller is capable of switching between
> host and gadget modes based on the status of the OTG_ID signal or via
> manual USB role change.
> Previously, only the Amlogic A1 IP version did not use OTG support for
> host only mode, but this is no longer applicable.
> Therefore, the 'otg_switch_supported' option can now be removed as
> it is no longer required.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   drivers/usb/dwc3/dwc3-meson-g12a.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index b282ad0e69c6..a13afdb219e8 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -140,7 +140,6 @@ static const char * const meson_a1_phy_names[] = {
>   struct dwc3_meson_g12a;
>   
>   struct dwc3_meson_g12a_drvdata {
> -	bool otg_switch_supported;
>   	bool otg_phy_host_port_disable;
>   	struct clk_bulk_data *clks;
>   	int num_clks;
> @@ -189,7 +188,6 @@ static int dwc3_meson_gxl_usb_post_init(struct dwc3_meson_g12a *priv);
>    */
>   
>   static const struct dwc3_meson_g12a_drvdata gxl_drvdata = {
> -	.otg_switch_supported = true,
>   	.otg_phy_host_port_disable = true,
>   	.clks = meson_gxl_clocks,
>   	.num_clks = ARRAY_SIZE(meson_g12a_clocks),
> @@ -203,7 +201,6 @@ static const struct dwc3_meson_g12a_drvdata gxl_drvdata = {
>   };
>   
>   static const struct dwc3_meson_g12a_drvdata gxm_drvdata = {
> -	.otg_switch_supported = true,
>   	.otg_phy_host_port_disable = true,
>   	.clks = meson_gxl_clocks,
>   	.num_clks = ARRAY_SIZE(meson_g12a_clocks),
> @@ -217,7 +214,6 @@ static const struct dwc3_meson_g12a_drvdata gxm_drvdata = {
>   };
>   
>   static const struct dwc3_meson_g12a_drvdata axg_drvdata = {
> -	.otg_switch_supported = true,
>   	.clks = meson_gxl_clocks,
>   	.num_clks = ARRAY_SIZE(meson_gxl_clocks),
>   	.phy_names = meson_a1_phy_names,
> @@ -230,7 +226,6 @@ static const struct dwc3_meson_g12a_drvdata axg_drvdata = {
>   };
>   
>   static const struct dwc3_meson_g12a_drvdata g12a_drvdata = {
> -	.otg_switch_supported = true,
>   	.clks = meson_g12a_clocks,
>   	.num_clks = ARRAY_SIZE(meson_g12a_clocks),
>   	.phy_names = meson_g12a_phy_names,
> @@ -242,7 +237,6 @@ static const struct dwc3_meson_g12a_drvdata g12a_drvdata = {
>   };
>   
>   static const struct dwc3_meson_g12a_drvdata a1_drvdata = {
> -	.otg_switch_supported = false,
>   	.clks = meson_a1_clocks,
>   	.num_clks = ARRAY_SIZE(meson_a1_clocks),
>   	.phy_names = meson_a1_phy_names,
> @@ -307,7 +301,7 @@ static int dwc3_meson_g12a_usb2_init_phy(struct dwc3_meson_g12a *priv, int i,
>   			U2P_R0_POWER_ON_RESET,
>   			U2P_R0_POWER_ON_RESET);
>   
> -	if (priv->drvdata->otg_switch_supported && i == USB2_OTG_PHY) {
> +	if (i == USB2_OTG_PHY) {
>   		regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
>   				   U2P_R0_ID_PULLUP | U2P_R0_DRV_VBUS,
>   				   U2P_R0_ID_PULLUP | U2P_R0_DRV_VBUS);
> @@ -490,7 +484,7 @@ static int dwc3_meson_g12a_otg_mode_set(struct dwc3_meson_g12a *priv,
>   {
>   	int ret;
>   
> -	if (!priv->drvdata->otg_switch_supported || !priv->phys[USB2_OTG_PHY])
> +	if (!priv->phys[USB2_OTG_PHY])
>   		return -EINVAL;
>   
>   	if (mode == PHY_MODE_USB_HOST)
> @@ -589,9 +583,6 @@ static int dwc3_meson_g12a_otg_init(struct platform_device *pdev,
>   	int ret, irq;
>   	struct device *dev = &pdev->dev;
>   
> -	if (!priv->drvdata->otg_switch_supported)
> -		return 0;
> -
>   	if (priv->otg_mode == USB_DR_MODE_OTG) {
>   		/* Ack irq before registering */
>   		regmap_update_bits(priv->usb_glue_regmap, USB_R5,
> @@ -841,8 +832,7 @@ static int dwc3_meson_g12a_remove(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	int i;
>   
> -	if (priv->drvdata->otg_switch_supported)
> -		usb_role_switch_unregister(priv->role_switch);
> +	usb_role_switch_unregister(priv->role_switch);
>   
>   	of_platform_depopulate(dev);
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
