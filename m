Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B849A6BABBD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjCOJKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjCOJJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:09:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2815B97
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:09:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c8-20020a05600c0ac800b003ed2f97a63eso610634wmr.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678871376;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GVNg+gj+UlQPWX9hB6iUs2/jQBX0Jkfv9x/YYWmxK+c=;
        b=BlzI1ULaSKUP5pJa+4admRr2X8mpQCSL0bNlbwKzyLa8LfTh47KyDQGvBTnAzHVDrA
         +xCnPnnmP1iOMPU7Y5vfBxcey+nDS8AlpvTn59jJeJrc6yLVkzxAzN7VXNhMXHfEdArz
         YtQ93Nee4Xr0Zc7UdpoxHq2HlPfgKNrtE0Qcq7sTblZreYziBQt8E45a28PstZiLskR1
         3dtKwVU4SJJo+v4trlXTwy8dyhVR68HOmGv6FhhH5k/eGgJp33miVVpj4reLOyaiAZ9q
         bkYLlcM59UepXHVARrPkIAmXxfxJ3I6dFHATmEqq2gH2plhWkw5IrXf/rsUPhPxmJsVH
         4neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678871376;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVNg+gj+UlQPWX9hB6iUs2/jQBX0Jkfv9x/YYWmxK+c=;
        b=h4q5y4PZRK3ZkXUSE42yAfc4hj6qVgTrjnMkVzG/T61Y0lrxBMLSrmp3P9Ch9olejg
         A4hara7nngad/riVKXrIRyhYtYOPukPvJY5fUwWZ7UlSfteN6ghp3a7DIYr5gUQYQaVJ
         lxCVAq1pkoD8Emv9o5XRSpIm4CBwzD6Es+i4daWfL4IZfC1fdTPJdRThVTRwsFyMmt8s
         J5l85Ce0HgS7BiMv+v5nuPqa/CeZCPyPuVcW6uWekkI0ALHPkyvceyg4NqbX4Nh1tTiQ
         7wem4mqmC7zi49w8hRBfBAQ1zI5AQErTaOoBh9MY7qqbnG+YA642+w2otAg+PexglbDt
         bE+w==
X-Gm-Message-State: AO0yUKWajswJpaakcked/MK41nlE3RE4S4JZFDnYlox728SV2GOy8gMf
        dGoXhB4xdFqYIwlU9sJCngSVxnH83eN7DVbGFqRMGw==
X-Google-Smtp-Source: AK7set9nfvyF2bFDbE/3/KN5unE9MXU+3XxeVgWp0fgN4W5/+AQGLoMmk4p3GJMFtTadQUw5GgO1YQ==
X-Received: by 2002:a05:600c:4707:b0:3eb:29fe:f912 with SMTP id v7-20020a05600c470700b003eb29fef912mr16537330wmo.36.1678871376616;
        Wed, 15 Mar 2023 02:09:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5d2d:8427:397b:8fe7? ([2a01:e0a:982:cbb0:5d2d:8427:397b:8fe7])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003ed1f6878a5sm1228383wmc.5.2023.03.15.02.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 02:09:36 -0700 (PDT)
Message-ID: <7e220b1f-d68f-05ff-bd1e-7cefe06eb2b4@linaro.org>
Date:   Wed, 15 Mar 2023 10:09:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/panel: support for STARRY 2081101QFH032011-53G
 MIPI-DSI panel
Content-Language: en-US
To:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        sam@ravnborg.org, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230314090549.11418-1-zhouruihai@huaqin.corp-partner.google.com>
Organization: Linaro Developer Services
In-Reply-To: <20230314090549.11418-1-zhouruihai@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 10:05, Ruihai Zhou wrote:
> The STARRY 2081101QFH032011-53G is a 10.1" WUXGA TFT LCD panel,
> which fits in nicely with the existing panel-boe-tv101wum-nl6
> driver. Hence, we add a new compatible with panel specific config.
> 
> Signed-off-by: Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
> ---
>   .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 126 ++++++++++++++++++
>   1 file changed, 126 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index c924f1124ebc..783234ae0f57 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -1131,6 +1131,103 @@ static const struct panel_init_cmd auo_b101uan08_3_init_cmd[] = {
>   	{},
>   };
>   
> +static const struct panel_init_cmd starry_qfh032011_53g_init_cmd[] = {
> +	_INIT_DCS_CMD(0xB0, 0x01),
> +	_INIT_DCS_CMD(0xC3, 0x4F),
> +	_INIT_DCS_CMD(0xC4, 0x40),
> +	_INIT_DCS_CMD(0xC5, 0x40),
> +	_INIT_DCS_CMD(0xC6, 0x40),
> +	_INIT_DCS_CMD(0xC7, 0x40),
> +	_INIT_DCS_CMD(0xC8, 0x4D),
> +	_INIT_DCS_CMD(0xC9, 0x52),
> +	_INIT_DCS_CMD(0xCA, 0x51),
> +	_INIT_DCS_CMD(0xCD, 0x5D),
> +	_INIT_DCS_CMD(0xCE, 0x5B),
> +	_INIT_DCS_CMD(0xCF, 0x4B),
> +	_INIT_DCS_CMD(0xD0, 0x49),
> +	_INIT_DCS_CMD(0xD1, 0x47),
> +	_INIT_DCS_CMD(0xD2, 0x45),
> +	_INIT_DCS_CMD(0xD3, 0x41),
> +	_INIT_DCS_CMD(0xD7, 0x50),
> +	_INIT_DCS_CMD(0xD8, 0x40),
> +	_INIT_DCS_CMD(0xD9, 0x40),
> +	_INIT_DCS_CMD(0xDA, 0x40),
> +	_INIT_DCS_CMD(0xDB, 0x40),
> +	_INIT_DCS_CMD(0xDC, 0x4E),
> +	_INIT_DCS_CMD(0xDD, 0x52),
> +	_INIT_DCS_CMD(0xDE, 0x51),
> +	_INIT_DCS_CMD(0xE1, 0x5E),
> +	_INIT_DCS_CMD(0xE2, 0x5C),
> +	_INIT_DCS_CMD(0xE3, 0x4C),
> +	_INIT_DCS_CMD(0xE4, 0x4A),
> +	_INIT_DCS_CMD(0xE5, 0x48),
> +	_INIT_DCS_CMD(0xE6, 0x46),
> +	_INIT_DCS_CMD(0xE7, 0x42),
> +	_INIT_DCS_CMD(0xB0, 0x03),
> +	_INIT_DCS_CMD(0xBE, 0x03),
> +	_INIT_DCS_CMD(0xCC, 0x44),
> +	_INIT_DCS_CMD(0xC8, 0x07),
> +	_INIT_DCS_CMD(0xC9, 0x05),
> +	_INIT_DCS_CMD(0xCA, 0x42),
> +	_INIT_DCS_CMD(0xCD, 0x3E),
> +	_INIT_DCS_CMD(0xCF, 0x60),
> +	_INIT_DCS_CMD(0xD2, 0x04),
> +	_INIT_DCS_CMD(0xD3, 0x04),
> +	_INIT_DCS_CMD(0xD4, 0x01),
> +	_INIT_DCS_CMD(0xD5, 0x00),
> +	_INIT_DCS_CMD(0xD6, 0x03),
> +	_INIT_DCS_CMD(0xD7, 0x04),
> +	_INIT_DCS_CMD(0xD9, 0x01),
> +	_INIT_DCS_CMD(0xDB, 0x01),
> +	_INIT_DCS_CMD(0xE4, 0xF0),
> +	_INIT_DCS_CMD(0xE5, 0x0A),
> +	_INIT_DCS_CMD(0xB0, 0x00),
> +	_INIT_DCS_CMD(0xCC, 0x08),
> +	_INIT_DCS_CMD(0xC2, 0x08),
> +	_INIT_DCS_CMD(0xC4, 0x10),
> +	_INIT_DCS_CMD(0xB0, 0x02),
> +	_INIT_DCS_CMD(0xC0, 0x00),
> +	_INIT_DCS_CMD(0xC1, 0x0A),
> +	_INIT_DCS_CMD(0xC2, 0x20),
> +	_INIT_DCS_CMD(0xC3, 0x24),
> +	_INIT_DCS_CMD(0xC4, 0x23),
> +	_INIT_DCS_CMD(0xC5, 0x29),
> +	_INIT_DCS_CMD(0xC6, 0x23),
> +	_INIT_DCS_CMD(0xC7, 0x1C),
> +	_INIT_DCS_CMD(0xC8, 0x19),
> +	_INIT_DCS_CMD(0xC9, 0x17),
> +	_INIT_DCS_CMD(0xCA, 0x17),
> +	_INIT_DCS_CMD(0xCB, 0x18),
> +	_INIT_DCS_CMD(0xCC, 0x1A),
> +	_INIT_DCS_CMD(0xCD, 0x1E),
> +	_INIT_DCS_CMD(0xCE, 0x20),
> +	_INIT_DCS_CMD(0xCF, 0x23),
> +	_INIT_DCS_CMD(0xD0, 0x07),
> +	_INIT_DCS_CMD(0xD1, 0x00),
> +	_INIT_DCS_CMD(0xD2, 0x00),
> +	_INIT_DCS_CMD(0xD3, 0x0A),
> +	_INIT_DCS_CMD(0xD4, 0x13),
> +	_INIT_DCS_CMD(0xD5, 0x1C),
> +	_INIT_DCS_CMD(0xD6, 0x1A),
> +	_INIT_DCS_CMD(0xD7, 0x13),
> +	_INIT_DCS_CMD(0xD8, 0x17),
> +	_INIT_DCS_CMD(0xD9, 0x1C),
> +	_INIT_DCS_CMD(0xDA, 0x19),
> +	_INIT_DCS_CMD(0xDB, 0x17),
> +	_INIT_DCS_CMD(0xDC, 0x17),
> +	_INIT_DCS_CMD(0xDD, 0x18),
> +	_INIT_DCS_CMD(0xDE, 0x1A),
> +	_INIT_DCS_CMD(0xDF, 0x1E),
> +	_INIT_DCS_CMD(0xE0, 0x20),
> +	_INIT_DCS_CMD(0xE1, 0x23),
> +	_INIT_DCS_CMD(0xE2, 0x07),
> +	_INIT_DCS_CMD(0X11),
> +	_INIT_DELAY_CMD(120),
> +	_INIT_DCS_CMD(0X29),
> +	_INIT_DELAY_CMD(80),
> +	{},
> +};
> +
>   static inline struct boe_panel *to_boe_panel(struct drm_panel *panel)
>   {
>   	return container_of(panel, struct boe_panel, base);
> @@ -1497,6 +1594,32 @@ static const struct panel_desc boe_tv105wum_nw0_desc = {
>   	.init_cmds = boe_init_cmd,
>   };
>   
> +static const struct drm_display_mode starry_qfh032011_53g_default_mode = {
> +	.clock = 165731,
> +	.hdisplay = 1200,
> +	.hsync_start = 1200 + 100,
> +	.hsync_end = 1200 + 100 + 10,
> +	.htotal = 1200 + 100 + 10 + 100,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 14,
> +	.vsync_end = 1920 + 14 + 10,
> +	.vtotal = 1920 + 14 + 10 + 15,
> +};
> +
> +static const struct panel_desc starry_qfh032011_53g_desc = {
> +	.modes = &starry_qfh032011_53g_default_mode,
> +	.bpc = 8,
> +	.size = {
> +		.width_mm = 135,
> +		.height_mm = 216,
> +	},
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +		      MIPI_DSI_MODE_LPM,
> +	.init_cmds = starry_qfh032011_53g_init_cmd,
> +};
> +
>   static int boe_panel_get_modes(struct drm_panel *panel,
>   			       struct drm_connector *connector)
>   {
> @@ -1667,6 +1790,9 @@ static const struct of_device_id boe_of_match[] = {
>   	{ .compatible = "innolux,hj110iz-01a",
>   	  .data = &inx_hj110iz_desc
>   	},
> +	{ .compatible = "starry,2081101qfh032011-53g",
> +	  .data = &starry_qfh032011_53g_desc
> +	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, boe_of_match);


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
