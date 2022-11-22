Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A165A6336A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiKVII0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiKVIIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:08:20 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE22A391F0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:08:18 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id d20so17024173ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4m37A/talNp70vF+VxLy7ZtvPFBex/6NeMS3n0jrH1c=;
        b=MJDKF7emETjRP4WxOUeK+8WxHTtIFN9TRN3WN5LZSt+tHwjEe8v77uDnH3dA2vAeHn
         O3o3nFC9xT+YTQfREbF3Qc62b7n1f0DduhKAh5/dCM0I7GfqgkIXFj+msOG6kJ31/EhL
         rpxeds0cDmgjMficvEiXs+eructqToNd1kNKxQt+/Cso5I/GT6LXlK6ugCRMzxnjU/KQ
         gT6OcGlaToVvFA7v6AZdkjnhswDRvyMt/GU3PJLXJrIQr72H+8kT8WqvxXr2LEHa+2LR
         hpaNu/uX4hUIrrmCQJnFPq7wTvGzGpMwxl1Tn6nsRf0Ir4nI0K2pR2G/ExP8UuaT5Nk/
         RJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4m37A/talNp70vF+VxLy7ZtvPFBex/6NeMS3n0jrH1c=;
        b=wGbcPeSBfMCq8IpdrEuuOZI7jC97AYy3OfnKH6uZ5Ljz++KOc8Z/kpLGBJ5NkqOrg8
         smxl4PoUtJbohoHJTiSKHN2ZTK7ZwpJCeZDEIrZYZQZXIhvLYi2XOlEIcZ916A17j9OE
         TZ2aCGOThCmaKJAz6C3/LZ0sJ/hvdONBhsVbAMQn3EP/PBlvvqgF+Ii+EKpR7MS+t61O
         os0X33jBwLJeyOIGmy3GtONAGrgePjipxsiBw2HLR7sUM3seDONTyxMF4hs7PaOFacUh
         4jWbt09vYqK1oOi6EY1l1PxosUDl2CJ4IGVpakACf1MnIPWNAwn0V2gN/MMmfRRCiyPC
         co0g==
X-Gm-Message-State: ANoB5pn8kNJxg/GZwDS1ZKjozQFjLj+wYc6IBjpIHR2g2Fjdaq0YN0Pz
        i8n9YB8SksglvWLC+UqKgVJOiw==
X-Google-Smtp-Source: AA0mqf4RQelr2ivp3d2aUuGU6ED6ob6F1q0qEAwy3uK5D9ZUOLJG1rQtMbHRUVpHb6Y2mol6tZrOJQ==
X-Received: by 2002:a2e:a374:0:b0:279:4e82:9010 with SMTP id i20-20020a2ea374000000b002794e829010mr2823296ljn.295.1669104497279;
        Tue, 22 Nov 2022 00:08:17 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g24-20020a0565123b9800b0049464d89e40sm2359967lfv.72.2022.11.22.00.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:08:16 -0800 (PST)
Message-ID: <4f8c1ba3-f62b-136a-42da-68406dce5ab0@linaro.org>
Date:   Tue, 22 Nov 2022 09:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCHv3 6/9] dt-bindings: arm: rockchip: add Rock 5 Model B
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20221121175814.68927-1-sebastian.reichel@collabora.com>
 <20221121175814.68927-7-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121175814.68927-7-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 18:58, Sebastian Reichel wrote:
> From: Christopher Obbard <chris.obbard@collabora.com>
> 
> Add DT binding documentation for the Radxa Rock 5 Model B.

One binding change per new board is a lot. This should be rather squashed.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

