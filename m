Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1A973B81A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjFWMuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjFWMtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:49:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E191FE3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:49:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f86bc35f13so758843e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687524591; x=1690116591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhlfjvXk50HY0dxxS/o40p/sBacIVTPIf3d4yaE8nRk=;
        b=cv1kJNtSxIFXCpvg1E8j4TAg5Wwsz8w8ZT0uk+BNv4h8FcIk4U0QOrNyVqzz09BiqZ
         e3uu2CCW9uLUbZIzcydiViU7GcqqsWsDwIzx/cjQGfIy0kpQJ2ZwaV4aEEZ4K4Ve4a5X
         jJQCNsxRTto/1P5YUXUJmRMd8qwD18t4NK9veNLuxEIxZKc3eKcf1SGZWetDaXG8cYyb
         C4H1XXcBXZIE926Vi50vlBlLhMCI/NA91O4g9V0a926sIWLX4SI/p8AM6aRT4sR2e9KX
         flEgspUWAkpkqH2jVf00h2MhTDtsDk8aq2ReQ98Jwo5gb1vU5iWnq0zw0tdvUHVCg6qn
         5pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524591; x=1690116591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhlfjvXk50HY0dxxS/o40p/sBacIVTPIf3d4yaE8nRk=;
        b=i2wi9T7wFto3cLCj3ggsKo/V4jgrRrAGvnums8ORAt1Ejd1XQ0Q1F4/OAS7Gj8yK6y
         S38dcyCE7cLxFNRfjUKs5PkUVZBWnU6AeGJtGNIxdONvSCtvfNeb83/D03Sq2/Z8SAyC
         f5446xj76m09kNexKFK2FkAM8Mb2XEfszJje4t5jzEm31y9ol7bYkjJPM5y+AjPogIxH
         xJ7ATI9ATRYlrd21wqc0WtFPAt0vDZjye/nkoYXjW91HS2hZXSOy2O8h+SiJH7vnCjw6
         UOkNCyf+peOuMbtc+8OnL3G464WwumYh6Czf1yLT3iI3PyhHImh4ixi0j6PrXlcdej+9
         iBTQ==
X-Gm-Message-State: AC+VfDz91lJEzh65lww/2AJmWIXDUStpUb8tdYZhz92s9bL1RwsIpnwy
        wQCC7fevydYZcWyweGNJC2ARTg==
X-Google-Smtp-Source: ACHHUZ5v+H4dOh7wk2wa/5G/ITOXbVtQpt1meXROCzcGDQTezN95zKQV28voSkTaaIZmBhSPFVQq/w==
X-Received: by 2002:a19:5004:0:b0:4f8:7503:2041 with SMTP id e4-20020a195004000000b004f875032041mr9171058lfb.37.1687524591350;
        Fri, 23 Jun 2023 05:49:51 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id f2-20020a056000128200b003062c0ef959sm9550892wrx.69.2023.06.23.05.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 05:49:50 -0700 (PDT)
Message-ID: <6c71deca-112e-2ef6-9098-902bc4b92324@baylibre.com>
Date:   Fri, 23 Jun 2023 14:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] MediaTek DRM: Clean up CMDQ support and ifdefs
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, wenst@chromium.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20230623094931.117918-1-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230623094931.117918-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/06/2023 11:49, AngeloGioacchino Del Regno wrote:
> This series changes MediaTek CMDQ support to use the mtk-cmdq-helper
> functions, removing duplicated cmdq setup code in mtk-drm and also
> removing all instances of `#if IS_REACHABLE(CONFIG_MTK_CMDQ)` while
> keeping compatibility with both CONFIG_MTK_CMDQ=n and =m/=y.
> 
> This applies on top of [1] and [2].
> 
> [1]:https://lore.kernel.org/lkml/20230524093412.92211-1-angelogioacchino.delregno@collabora.com
> [2]:https://lore.kernel.org/lkml/20230608084727.74403-1-angelogioacchino.delregno@collabora.com

Hi Angelo,

Can you provide a public branch to test it please ?
I tried to apply the dependencies but still have an issue with the 3rd one:

https://lore.kernel.org/lkml/20230523104234.7849-1-angelogioacchino.delregno@collabora.com
OK

https://lore.kernel.org/lkml/20230524093412.92211-1-angelogioacchino.delregno@collabora.com
OK

https://lore.kernel.org/lkml/20230608084727.74403-1-angelogioacchino.delregno@collabora.com
KO

Thanks

-- 
Regards,
Alexandre
