Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26E46C0F96
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjCTKrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCTKrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:47:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C454746A6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:45:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o40-20020a05600c512800b003eddedc47aeso1770203wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679309033;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cpovqAD+8TpVtFMnyoL4JisxUGVryrFReZuxy2PqaME=;
        b=xRHJSJ5/Zw7Xu4SNZARW3d9maNaE2C5+vNuqqTBWvi4rgKOBACAJl20JH89axVqYwQ
         TLziOV/vunS9dsi9X3qzSaN1/KZlc+Zv0QFRoSFB/DI4lwJk/+MFEBd8TpNhssscoxTA
         3JG589zmUKYKcUgSt+UbvHjt+Qd9UWlpgrXVeCSOWuMIFycWCrTP0wSVLke7fgKeOkRE
         BlG2vijAKpO0uuYL0sU4U0nXNH3g1sI9Q+BSvPFByFY8NQxQ+/xDNBJfxGN1+/LYw4L1
         nEHStH0nrEQ1Lxh2VsYhb09lwrDwaC0v2TqMKDaHdxS0dkAZAOj733tL9HpZrrxdatTA
         JMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679309033;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpovqAD+8TpVtFMnyoL4JisxUGVryrFReZuxy2PqaME=;
        b=z2STG8VR9oT5SO3QlgA4kqDmMoi8Fvccd90NE3ofcLNwshqUZBqPEUFf18n2B6dWLD
         Lt/wzUzkKlMrZ1RGcU4xZF329mHFsUaOuK9Lqzzzvs4FM/6NC4FfeHpRiQk9W9TNOqy9
         qtGI7xGuYHHzGQlVn5/IWgPYoV25ltOpXzkq3HzGllQM9QsTpRiq+Xjqpe0J0F3+l5G8
         fr7bngDk/LcL26WAEMXPfma5JO/gi9+iIvyxa0yfKvyx1Sy0ipxVdiDbQKaOza9o6qLE
         yDZMpgAaiX1iOW7fFVzPwhRSOL4A5uILH7xpmA277GiWOdmli7sm655Ig8iL4B1iQSKw
         DIrw==
X-Gm-Message-State: AO0yUKWwzNkRw8vRLGJvANEkRRDEn2oH40jCeNMGT71+jtgGkQBi1GBl
        /extvvpL4vG4ihkEeF4Ch/44Rw==
X-Google-Smtp-Source: AK7set+KgAqimOf7QtJlmloTkty2fvIWumLlyaoQLs6yC7xmeHqBG1brzNXme6Tkc5AbxHW5OUVK5g==
X-Received: by 2002:a05:600c:4fcb:b0:3eb:2e32:72c3 with SMTP id o11-20020a05600c4fcb00b003eb2e3272c3mr33542049wmq.22.1679309033321;
        Mon, 20 Mar 2023 03:43:53 -0700 (PDT)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c468900b003ed5909aab2sm12802826wmo.25.2023.03.20.03.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:43:52 -0700 (PDT)
Message-ID: <0f183988-f100-c4ff-056e-a737767a772d@linaro.org>
Date:   Mon, 20 Mar 2023 11:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: nwl-dsi: implement
 MIPI_DSI_MODE_NO_EOT_PACKET
Content-Language: en-US
To:     Kevin Groeneveld <kgroeneveld@lenbrook.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230318223357.3899-1-kgroeneveld@lenbrook.com>
Organization: Linaro Developer Services
In-Reply-To: <20230318223357.3899-1-kgroeneveld@lenbrook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/03/2023 23:33, Kevin Groeneveld wrote:
> Previously EOT packets were only being enabled when
> MIPI_DSI_CLOCK_NON_CONTINUOUS was set in the dsi_mode_flags. However this
> really should be based on MIPI_DSI_MODE_NO_EOT_PACKET instead.
> 
> Some displays require EOT packets and a continuous clock which was an
> impossible combination to achieve with the current driver.
> 
> Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>


Thanks for the patch, can you provide a Fixes tag ?

Neil

> ---
>   drivers/gpu/drm/bridge/nwl-dsi.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 6dc2a4e191d7..bb8404ffd3f5 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -211,7 +211,7 @@ static u32 us2lp(u32 lp_clk_rate, unsigned long us)
>   
>   static int nwl_dsi_config_host(struct nwl_dsi *dsi)
>   {
> -	u32 cycles;
> +	u32 val, cycles;
>   	struct phy_configure_opts_mipi_dphy *cfg = &dsi->phy_cfg.mipi_dphy;
>   
>   	if (dsi->lanes < 1 || dsi->lanes > 4)
> @@ -220,13 +220,8 @@ static int nwl_dsi_config_host(struct nwl_dsi *dsi)
>   	DRM_DEV_DEBUG_DRIVER(dsi->dev, "DSI Lanes %d\n", dsi->lanes);
>   	nwl_dsi_write(dsi, NWL_DSI_CFG_NUM_LANES, dsi->lanes - 1);
>   
> -	if (dsi->dsi_mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
> -		nwl_dsi_write(dsi, NWL_DSI_CFG_NONCONTINUOUS_CLK, 0x01);
> -		nwl_dsi_write(dsi, NWL_DSI_CFG_AUTOINSERT_EOTP, 0x01);
> -	} else {
> -		nwl_dsi_write(dsi, NWL_DSI_CFG_NONCONTINUOUS_CLK, 0x00);
> -		nwl_dsi_write(dsi, NWL_DSI_CFG_AUTOINSERT_EOTP, 0x00);
> -	}
> +	val = (dsi->dsi_mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0x01 : 0x00;
> +	nwl_dsi_write(dsi, NWL_DSI_CFG_NONCONTINUOUS_CLK, val);
>   
>   	/* values in byte clock cycles */
>   	cycles = ui2bc(cfg->clk_pre);
> @@ -241,6 +236,8 @@ static int nwl_dsi_config_host(struct nwl_dsi *dsi)
>   	DRM_DEV_DEBUG_DRIVER(dsi->dev, "cfg_tx_gap: 0x%x\n", cycles);
>   	nwl_dsi_write(dsi, NWL_DSI_CFG_TX_GAP, cycles);
>   
> +	val = (dsi->dsi_mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET) ? 0x00 : 0x01;
> +	nwl_dsi_write(dsi, NWL_DSI_CFG_AUTOINSERT_EOTP, val);
>   	nwl_dsi_write(dsi, NWL_DSI_CFG_EXTRA_CMDS_AFTER_EOTP, 0x01);
>   	nwl_dsi_write(dsi, NWL_DSI_CFG_HTX_TO_COUNT, 0x00);
>   	nwl_dsi_write(dsi, NWL_DSI_CFG_LRX_H_TO_COUNT, 0x00);

