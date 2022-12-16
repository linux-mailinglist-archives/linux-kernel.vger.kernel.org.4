Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205AA64EC2D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiLPNlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLPNlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:41:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A9915822;
        Fri, 16 Dec 2022 05:41:30 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so4190668wmh.0;
        Fri, 16 Dec 2022 05:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1IlblvpnO7CSOWQj+7J4s/fz7C1yYlNNGDJxB7We2hA=;
        b=l5M1f0pOBkmHqIHK8QlDap356wn8I5JzUaV0DA9P2ir7oswCyW7K98S5QstlO2bGAO
         QSVxyLGF7cqizCMcK+EwqcbxSpDqOBVvzfoCOucsb143oIo3OnD8nsV4qKPa18NNxtXm
         cPtdg1GUzVvACSkBuvcC/2YJknHF/b4+TtKND5oF1ek2xIA176ps1DA+Uhmpe+THlH/S
         DVOswRJWaZyWzx0emEcHeSh9DEnvfW5FTF0pVwZC+Fj9bJAFPnUqtUElWvkdt5qUzr2Q
         +UyOKEkylE4CEXl1SEHWJz9khl5SpVh8anzRe+kYTMaJMB++B1LydNBC0z93wCkqBGE5
         yeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IlblvpnO7CSOWQj+7J4s/fz7C1yYlNNGDJxB7We2hA=;
        b=3pAJ5KPujq6RaPUn675/GdbcspJxwh4vaq1U8+V8fGUF49IRLXO6s2hV38+l0NtFCz
         dWP2rHBIaWDtglfpbDI7cq2Q84W0XWrRgO0QGx3hqwZS389Dmeg0Fm4KCz+0+yjdByF1
         V/OOaPeas1NRpFcNOFugetzWxoPx/hHKSVWVL1evkjyJJKsmOyHncecRm1+t2o7b8Akh
         J3IiCKVvIxWoMPFS0usDFmas/Yiv0I5hT+ccApnKQanbQKynfRNNkXvyc9CgbCvpKAft
         b78OzSLBnyf0iJkzhM36KVPjj/BIz84uN/ELjWJzQQWF/7X3b/iE90oI/Ub44EFCM8jj
         rYuw==
X-Gm-Message-State: ANoB5pkg2Ze7LrR7LBw/zG01Na37s97q+mZrGSYODfzyMFwlVqXjOqaQ
        HsSnxE3MSeobBTKdlL3aIVs=
X-Google-Smtp-Source: AA0mqf6CslQw0OazAvUOHIG5QEuLgxypZua22r4ikFgU6guOuUIoyPBwKBoc9MqvVUThoob2iDiW6A==
X-Received: by 2002:a05:600c:1ca8:b0:3cf:7dc1:f424 with SMTP id k40-20020a05600c1ca800b003cf7dc1f424mr26250843wms.3.1671198088868;
        Fri, 16 Dec 2022 05:41:28 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c354c00b003cfd64b6be1sm13227152wmq.27.2022.12.16.05.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 05:41:27 -0800 (PST)
Message-ID: <ece3a933-e278-fc7e-093a-4689d1c3bf3b@gmail.com>
Date:   Fri, 16 Dec 2022 14:41:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/4] MT8195 Acer Tomato - Audio support
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org
References: <20220922094908.41623-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220922094908.41623-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whole series applied, thanks a lot.

Matthias

On 22/09/2022 11:49, AngeloGioacchino Del Regno wrote:
> This series enables full support for audio, with DSP, on the Cherry
> Chromebooks.
> Related ALSA UCM2 configuration was already merged in its upstream
> repository [1]: this is fully tested and working as-is since all of
> the required fixes for MT8195 SOF drivers were picked and are present
> since `next-20220908`.
> 
> [1]: https://github.com/alsa-project/alsa-ucm-conf/commit/a59c3b1a57de8eb424c4f754bb031265e856260e
> 
> ______________________________________
> _________ Platform overview: _________
> 
> What's still missing?
> 
> * Format:    feature  (location)
> *
> * MediaTek vcodec enc/dec (mt8195.dtsi only)
> * PCI-Express WiFi card (mt8195 and mt8195-cherry)
> * VDOSYS1 (mt8195.dtsi and mediatek-drm/mmsys drivers)
> * DP/eDP outputs for external/internal display (mt8195 and mt8195-cherry)
> * LVTS Thermal Sensors (mt8195.dtsi, driver is missing)
> * GPU support (clocks and mtk-regulator-coupler are awaiting for review/pick)
> 
> AngeloGioacchino Del Regno (4):
>    arm64: dts: mediatek: cherry: Add Audio Front End (AFE) support
>    arm64: dts: mediatek: cherry: Enable the Audio DSP for SOF
>    arm64: dts: mediatek: cherry: Add external codecs and speaker
>      amplifier
>    arm64: dts: mediatek: cherry: Add sound card configuration
> 
>   .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |  10 ++
>   .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |  10 ++
>   .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |  10 ++
>   .../boot/dts/mediatek/mt8195-cherry.dtsi      | 109 ++++++++++++++++++
>   4 files changed, 139 insertions(+)
> 
