Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D24653CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiLVIUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiLVIUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:20:33 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFA610FF5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:20:32 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id a19so1197784ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GB9nooY/0032I7QDBEim1H1M5FPjYvPHgEiEZnFAGNg=;
        b=YH07lTfDGxT6wtN4QaJAAd9N/6D/HPQa3m1hJOxREFURbaCV+t7j/rqOs4fjVX2ykg
         3bCko3vyjZcz5T3gPAQAcNe5ilQz5YD3hKyvlJCVlcp+ZysgXbxAnB4crLyoHp6eU1Mw
         Jwtg3g41w65NPQaorOcwOkyf6WffOdNoIru7f7q9fO1dUvOjoGZXtHMwrCk0ri7pzOAw
         I8utGFGHKUH5+cywjEZp38ZJuuYIYQ4A1dk9U2vgk/zm/Ldv6jw5xIrqqR4C1LPW7Tjz
         Hdve7Rzhke0FA8wg//hejy8Kq+zr8FTPZsHY1hd3z+7X1U2bLbMV6oeASHPxFAD3dNCC
         q4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GB9nooY/0032I7QDBEim1H1M5FPjYvPHgEiEZnFAGNg=;
        b=LOeNlN4vwPYqoDvvPQqSe5SHS9Jz+SEh6crLF8BAc6H83GP9zd4rDn8is3Psk81otB
         QOn2pqJ2KH8owY6O+GZtKY4VbWowc0STjJubQj633cJeP/dP5vh3xfT70Cw+pjc1OHCp
         +ZEgx01RVCSiRFIA5UjSkNlYKDrEbfqxD3J1L4JzVw/jqHnWV5Q9ta6JUSBpgwetvze5
         WPeq9Mtb1lPD51X+qBBl8RCdCl2pcvvx4roeSBJ+z80hT3KI/HvFYHaFY00woqxx40xz
         y7OPKUD4YKWk1az7mK5Xj2RPDV5hyBDg964vVA8huhI8V7+wj1Ahk7aqIkH3bCKIhpLf
         2k4A==
X-Gm-Message-State: AFqh2krOr6sSdjC6VPs5mq97I4iZhHNKDq4XIuYZLEhJJI1GfuCmiR3A
        zmK+KxQsW+bgHJAY1+RH53Pniw==
X-Google-Smtp-Source: AMrXdXvYiqUilarfeeG5Coha/8Bw53Qje4MaEoZX7uWcPV3+8BALSVPlJ3LcoT+8Z9TPXUlNIL2nHQ==
X-Received: by 2002:a05:651c:c8e:b0:27f:500b:47d3 with SMTP id bz14-20020a05651c0c8e00b0027f500b47d3mr1330473ljb.46.1671697230892;
        Thu, 22 Dec 2022 00:20:30 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bj27-20020a2eaa9b000000b002797892025csm1537922ljb.137.2022.12.22.00.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 00:20:30 -0800 (PST)
Message-ID: <e9dc3019-af82-3848-b282-99ff0287775f@linaro.org>
Date:   Thu, 22 Dec 2022 09:20:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 2/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat
 1
To:     Yuteng Zhong <zonyitoo@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Wenhao Cui <lasstp5011@gmail.com>
References: <Y6MmDmbCDGtl3xQd@VM-66-53-centos>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y6MmDmbCDGtl3xQd@VM-66-53-centos>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 16:28, Yuteng Zhong wrote:
> From: Wenhao Cui <lasstp5011@gmail.com>
> 
> Add devicetree binding documentation for the EmbedFire LubanCat 1.
> 
> Signed-off-by: Wenhao Cui <lasstp5011@gmail.com>
> Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

