Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B5A6E601B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjDRLmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjDRLma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:42:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91777E58
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:42:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f178da21b2so6142155e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681818147; x=1684410147;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VJhrrZF5F7exwMqfs2F/DYr7C0jvoevmcUqXzH/feoc=;
        b=jzOxsEqTJ/vE+PNHw+7MNs45SrWRcRdILs3o1jpljWGpevnUNsNzBP/Hne7QfimK1N
         5DY3mrppe8X+jaKRQ/IbtfjvpPf0q1020JOjEX1gd+PJibeizTsiuvO1XMk66ZORWC5j
         lktslAieZyrktZZaXs1VOo2OOCgxt87ehbK80gCy9qUt7TMKk/oMtNdCpNzsBRcHtUHv
         pdIYAJyMglfkqtZfx3wGsJZhLPh/cD+9cMXyQcewLh2XXi8p4vxi1ohxB/1/S2ROicgZ
         L0tbdVXl1JS4tDWSNKnrMrEgWR+inwerTf5sMqNXCyLiSgJyyWx9sNlODMPpzC76QPwC
         a4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681818147; x=1684410147;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJhrrZF5F7exwMqfs2F/DYr7C0jvoevmcUqXzH/feoc=;
        b=OS0/X0ILK6HBnDg2f4DmhTeTh6Q48146rGkxYUDH564/k293H7YZn8tcO861tK13gq
         0RNCpzobNz8uUFi8tND0yCpqgOMYp1LKVqcMSzUNGcIqUYtEQwBZHLd+qk+WUhAtU+sa
         +LLiboIOcwEQoZf/PFaXQzOMjRXnguEkRq3i3jHrSlbEHubwIsyVRlsn+W7/eDuPeU9g
         2nONTaQWSmNp0tC63LySDH8jYv1EVlZ2WEexJ9zJSRa6VoVuJyuKpCBk6M+R2WJHYtd7
         N2v9GxrfMtxFH62uwska8g5vdayU5k+ExYL+QvOEMo3AIDj72dRERxxuCKoK6E6P0Vwx
         ySdA==
X-Gm-Message-State: AAQBX9fwzEL32+yH/+7Nev4p+0wnX/JjhOnYFsTK61i8InScosImz/az
        mgYBsd+cMCW4cDie8FXYv3lhkA==
X-Google-Smtp-Source: AKy350aDCnbeQs57GbmYsqxCTQZFjV3+gfLDfWNsHSqoL5o8sOpUjfnH5UipDVxMtKi6RxmnWS+aFA==
X-Received: by 2002:a5d:698e:0:b0:2d2:f3e3:115d with SMTP id g14-20020a5d698e000000b002d2f3e3115dmr1702788wru.59.1681818146993;
        Tue, 18 Apr 2023 04:42:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7a02:f867:7c56:79a0? ([2a01:e0a:982:cbb0:7a02:f867:7c56:79a0])
        by smtp.gmail.com with ESMTPSA id h12-20020adffa8c000000b002d322b9a7f5sm12934813wrr.88.2023.04.18.04.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 04:42:26 -0700 (PDT)
Message-ID: <e4540877-5874-92a0-f15f-bdefc8dc5f8b@linaro.org>
Date:   Tue, 18 Apr 2023 13:42:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/5] usb: dwc2: support dwc2 IP for Amlogic A1 SoC
 family
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
 <20230418111612.19479-3-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230418111612.19479-3-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 13:16, Dmitry Rokosov wrote:
> The Amlogic A1 uses dwc2 Synopsys IP as its USB peripheral (gadget)
> endpoint, with different DWC2 parameters when compared to previous
> Amlogic SoCs.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   drivers/usb/dwc2/params.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index 9ed9fd956940..098fbfc774ab 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -161,6 +161,25 @@ static void dwc2_set_amlogic_g12a_params(struct dwc2_hsotg *hsotg)
>   	p->hird_threshold_en = false;
>   }
>   
> +static void dwc2_set_amlogic_a1_params(struct dwc2_hsotg *hsotg)
> +{
> +	struct dwc2_core_params *p = &hsotg->params;
> +
> +	p->otg_caps.hnp_support = false;
> +	p->otg_caps.srp_support = false;
> +	p->speed = DWC2_SPEED_PARAM_HIGH;
> +	p->host_rx_fifo_size = 192;
> +	p->host_nperio_tx_fifo_size = 128;
> +	p->host_perio_tx_fifo_size = 128;
> +	p->phy_type = DWC2_PHY_TYPE_PARAM_UTMI;
> +	p->phy_utmi_width = 8;
> +	p->ahbcfg = GAHBCFG_HBSTLEN_INCR8 << GAHBCFG_HBSTLEN_SHIFT;
> +	p->lpm = false;
> +	p->lpm_clock_gating = false;
> +	p->besl = false;
> +	p->hird_threshold_en = false;
> +}
> +
>   static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)
>   {
>   	struct dwc2_core_params *p = &hsotg->params;
> @@ -258,6 +277,8 @@ const struct of_device_id dwc2_of_match_table[] = {
>   	  .data = dwc2_set_amlogic_params },
>   	{ .compatible = "amlogic,meson-g12a-usb",
>   	  .data = dwc2_set_amlogic_g12a_params },
> +	{ .compatible = "amlogic,meson-a1-usb",
> +	  .data = dwc2_set_amlogic_a1_params },
>   	{ .compatible = "amcc,dwc-otg", .data = dwc2_set_amcc_params },
>   	{ .compatible = "apm,apm82181-dwc-otg", .data = dwc2_set_amcc_params },
>   	{ .compatible = "st,stm32f4x9-fsotg",

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
