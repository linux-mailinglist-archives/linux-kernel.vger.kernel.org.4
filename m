Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF21D6D3333
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDASl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDASl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:41:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE2D729A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 11:41:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w9so102301820edc.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680374485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3CX0tphHwucVQy/XBMHzMB2OpwqIu91GQKmtAUHW5M=;
        b=mHydUQdLtrrja7rpwWgXxy5mypWihyqXUP8jESwZXYQ+UMo6cyf4ARIpqPZt9seg3I
         viD8SINsrNFJTY+slyuegQUNoXoyUgGWNqNVbcgVwIxihQmrdkXVXvGZpaqvQ4qtGyhn
         ZaTg1OeZqPsnFvfI8KPO2vXotEmS84P8VD/aowhwkz4zu+Gs1dEz5PvvBG0+IBWouKmw
         L9yNjPA4eb8unexMMTlJIKBjfLSGvMAEBV5YJysQGgz7iV0MwdSCRo2BfI7N8tG2RPXh
         lG0tgpCZrnrW6gB1CVl7u9EUrxINDXJztBVjy4PIQQuPu/r7NvVibcJma2TtbIX2gDp/
         sApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680374485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3CX0tphHwucVQy/XBMHzMB2OpwqIu91GQKmtAUHW5M=;
        b=H12TsooWTBplirjc8JW21MPa/dHW7ZoJ6FpatdKEim3xC7tU9Twh9lweKXbSuwUnCl
         lQG1Gp5fuv0wDy8MdQjRWI7og3QJsb0JAN/QBDUCJlzw+pwrHoWuoZ5McxSqSE/HpDUW
         m1klh1gYtnBQU8rahatffriXNrSTAGvYHE2LaAjD1/eSAnWffOtmpWZg9aXgn2Jtj9c3
         Ev8vvRT5Hx3UW6s/R81VmH2JM9j+hROwUVeAY+tG21jyXTGX7002otXQb0XqbNxLPM1z
         FWTmJg6sdjIP3WX7p6UV3FOnWEqANXm+LreTbkyC0FKDMaA32yjBXQKIeR/4SZvHMZFQ
         R0Bw==
X-Gm-Message-State: AAQBX9enTAAio0WheBQs/av2tiuGgE8NOUhIueooaxypYjNQbExVu7Sf
        R34yc7oefiQ/FiM/oXv12fDTdQ==
X-Google-Smtp-Source: AKy350ZiZuxr3nGNpPlOhGyuV5/ZXciTT5jaK/TheV5lAt/QXLE6MfBHCobXTB/i0A5limdD5B7WdA==
X-Received: by 2002:aa7:c94c:0:b0:4fc:eee9:417 with SMTP id h12-20020aa7c94c000000b004fceee90417mr27190427edt.18.1680374484789;
        Sat, 01 Apr 2023 11:41:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ec00:3acd:519:c7c2? ([2a02:810d:15c0:828:ec00:3acd:519:c7c2])
        by smtp.gmail.com with ESMTPSA id p9-20020a50cd89000000b004c0c5864cc5sm2389927edi.25.2023.04.01.11.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 11:41:24 -0700 (PDT)
Message-ID: <5b0f9fc9-45ef-e501-6840-df4b03d9dab7@linaro.org>
Date:   Sat, 1 Apr 2023 20:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] ASoC: dt-bindings: maxim,max98371: Convert to DT
 schema
To:     =?UTF-8?Q?Andr=c3=a9_Morishita?= <andremorishita@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        anish kumar <yesanishhere@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
        daniel.baluta@nxp.com
References: <20230401181930.533067-1-andremorishita@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230401181930.533067-1-andremorishita@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2023 20:19, André Morishita wrote:
> Convert the Maxim Integrated MAX98371 audio codec bindings to DT schema.
> 
> Signed-off-by: André Morishita <andremorishita@gmail.com>
> ---
> Changes in v3:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

