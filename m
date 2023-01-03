Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCF065BC15
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbjACIWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbjACIWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:22:00 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E64E273
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:21:59 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id cf42so44655193lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 00:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ifCo5FOIwokCxO0n+MVhGa5ic/79OUh35i/SK2lVaA=;
        b=kM1Xdn4x5u6DrIrS/Lk4CaxK0H3MZ4Xp/ynvK1cN29tFo8bDKerM/ZQKiYqxpqY9PH
         nlzMLn8ProPaLuBjJbDnbGjOSiWb+I7LAceEs8MygPjHLyKU7GYQenpv5h1e4rsZHBAx
         y7lpwEEU9ofPxj+lOSkdri4oTD8h/6Ay13EB8ZuAXYJaj931itWDGFWUyX9FmBzzPpBa
         yzegMbb9ZM3AaO9+EspKdwrAyRuZTd0QEthQZUd74xx1An9Z8HmA96R94ntQ3dwwtmLq
         uVNMB4du7aOPVeNwxPx+YdWIhe2vImH5zh0ZV28Ur3ClE75235Cv2XpEkZLfhDBlfDpg
         4OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ifCo5FOIwokCxO0n+MVhGa5ic/79OUh35i/SK2lVaA=;
        b=QWbewkcunfa1+W8vQdH0e9xIi5w2yZgaIQgiwYc3nazqwFD6axmkZHQoMpBRfeyGP3
         YbQtlBGofOnmCkXqo9OpEwhQt6/QjZhq5c4RNajtm/oLZ/xn5vIRVot977ednRIUFb4N
         mG/tFCH2t9CkK0j5xv4jlD/BVWrNrgJYS/CrBll3hxvB9pjOa4uCC5m+jMhN45mOqNZ1
         WLYFWoDuHXjDL6Y/e/4uaRJB8Lum38CMQtpc2jXG+idjLmdhgalVyxzjLlQup+aMhkn+
         M1pndkHGnPm6SSFMc9n0GFKgJ4SECJms1spPkIrneGSg/xfNH0mbqSbNh2n6REFbGEZA
         3o5Q==
X-Gm-Message-State: AFqh2koQjXs/TEilKrOwAOypXAB7iOQxXEVwLfmOVpWdFB+CPqHOuRjm
        DQbDO+6GGsGr7p840S2lMq8v3g==
X-Google-Smtp-Source: AMrXdXtsbVV3d08q2p6h3Fhxh5/w6BwJ0fVyFb+0dMKZcc2dYyw/NiHcC+TEEXH5jwusbWDSDl+m1A==
X-Received: by 2002:a05:6512:b0c:b0:4b5:97cf:8f1a with SMTP id w12-20020a0565120b0c00b004b597cf8f1amr14197071lfu.40.1672734117561;
        Tue, 03 Jan 2023 00:21:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c19-20020a056512075300b004cafa01ebbfsm4286973lfs.101.2023.01.03.00.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 00:21:57 -0800 (PST)
Message-ID: <3f484fa3-680a-5f7f-c824-ec0cbd305d55@linaro.org>
Date:   Tue, 3 Jan 2023 09:21:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 1/4] dt-bindings: vendor-prefixes: Add microtips
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guo Ren <guoren@kernel.org>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux RISC-V List <linux-riscv@lists.infradead.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Mediatek List <linux-mediatek@lists.infradead.org>,
        Linux C-SKY Arch List <linux-csky@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230103064615.5311-1-a-bhatia1@ti.com>
 <20230103064615.5311-2-a-bhatia1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103064615.5311-2-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 07:46, Aradhya Bhatia wrote:
> Add document vendor prefix for Microtips Technology USA (microtips).
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

