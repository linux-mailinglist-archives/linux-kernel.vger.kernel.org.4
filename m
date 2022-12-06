Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50AF643E6D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiLFIX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiLFIXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:23:25 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F17D6418
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:23:24 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id s8so22500732lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95bE7p5WUY0ReK4sxIpN1wl6NEoUe1D+WDUlHeSwWZ8=;
        b=Ehs2D9v8wmDWCxqFsfUL9Hy2Rf8HXEyftG06ZLjH95zNFFnKj+taRAjt/k+TcUGi4/
         wNt2PrC10BlUeR7fx38zwpsxel9YXnGVZeqiaA9BqcEi/otnZmULsjkzqXqKDfyZOGu6
         YE/Yxp3nWui+/CSUISFyroiS299v+o0Ik3uFOm4HizsM0mkVGgm3CXAwy4pViBmWXPVG
         TwRJdo4oHvpIw7Wn6TQ+eR0T6BpM3YIKC4k5GORIDgYxzOcREL5XMi8Y1gwgHztcVJbD
         L20va2K8zVQxPcwNupKq5EE61QaV+MQKe0WC6iyojOR3B0Ie84sPRGEpVaNX5nK6A2Ne
         bzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95bE7p5WUY0ReK4sxIpN1wl6NEoUe1D+WDUlHeSwWZ8=;
        b=CwkOgQJS6e3Tbtnp9r6zV3P3vNFZlyZZ4dXztI0HP1BMoAHDrH5YrjMuQCHiufHWcQ
         dJ+SzOpqaCFjC684v4dzYkcFAc5tbKrYsDO/8VeSzeMDNecrBn8TKBZWUcudCOQ0mkpe
         83xaoDr+fjTEt5tuJDsObkCXvNKszYkdMnDqNl22ss7PVevHtcaIKAIlVfKGaaJk6gi4
         MgX24O8glNGV8Rug5bMsdQk6BPsvTmWo8fJvR2E86V6g6XaJEIrbt5qwgfZOLs7mGU5v
         0AfsOn6Pk6kIcd8oYPQ4brzdVqw5uiskq2DZWmUEwY37GPgnlytzA7tLOM0yS/0d9u+8
         rBqg==
X-Gm-Message-State: ANoB5pn3r3ySTh+Psk62+FB4nRWmBFsPAtpR+22THEMjgs8brb1RlnvR
        AIjHgWIBPlCtnz81I/MVREbzoQ==
X-Google-Smtp-Source: AA0mqf7/Edef7H+wj1o2DgC4/r+KooEY9i1FLS7SOT10dAjuSsDQC5taTN90dU+DpU962BvjcBXzKA==
X-Received: by 2002:a05:6512:3ca0:b0:4a2:2c4b:8138 with SMTP id h32-20020a0565123ca000b004a22c4b8138mr22685051lfv.14.1670315002789;
        Tue, 06 Dec 2022 00:23:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g8-20020a19ee08000000b004aa0870b5e5sm2396208lfb.147.2022.12.06.00.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:23:22 -0800 (PST)
Message-ID: <82bd3be3-3f0b-deef-718b-0780716f2ff4@linaro.org>
Date:   Tue, 6 Dec 2022 09:23:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 2/6] dt-bindings: usb: Add binding for Genesys Logic
 GL850G hub controller
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20221206055228.306074-1-uwu@icenowy.me>
 <20221206055228.306074-3-uwu@icenowy.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221206055228.306074-3-uwu@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2022 06:52, Icenowy Zheng wrote:
> The Genesys Logic GL850G is a USB 2.0 Single TT hub controller that
> features 4 downstream ports, an internal 5V-to-3.3V LDO regulator (can
> be bypassed) and an external reset pin.

If there is going to be resend:
Subject: drop second, redundant "binding for" (so: "Add Genesys Logic....")

> 
> Add a device tree binding for its USB protocol part. The internal LDO is
> not covered by this and can just be modelled as a fixed regulator.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

