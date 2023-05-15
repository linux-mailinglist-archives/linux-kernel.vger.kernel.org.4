Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F25E7024B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbjEOGaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjEOGaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:30:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F203A9F
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:30:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc37e1525so22884899a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684132205; x=1686724205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kn6XWJzZPydQzgeYFrbx1sjz6cI4FNY/Nw1YMTWWXts=;
        b=vTV9+PWsfUPU7o08VeoQmeKFuq8m7s3IRuW05VJyXuqYKuJ7amYwepiDfoHIV1VJT+
         WGi77C7zj6COr+62ipQCwVCUjfzuo08LwrjvPj9Gl/KBrQxUsEegX7TJW657UmXUBXKG
         NbP4IrQ8lRw5+nALXjh3YOzvaL7TATxkqpiGt2zMEi9q++hKSRVDmcd4yEwJKFgcTMzC
         S4Vsjs6PS5P4PcycbvaQZ2sfFBQVYQJ5kg/rkTknfPdXgWJ/STPi7SX59iLt7PvHtino
         kITk9gNo2f4t03SSpL912ciUlrNlNr6XHE5h33r+rkeTP6TjA2dRbtNed5azNZ4Mavca
         nfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684132205; x=1686724205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kn6XWJzZPydQzgeYFrbx1sjz6cI4FNY/Nw1YMTWWXts=;
        b=g0SMB/ukwvP6VTe74J/J3ReE1lt2MTaa2ogDCSyAj8NFAMK5Pzw16cziz9C7E98eMU
         z+hnzlk+8l94RPmK5MwaitJdFJIm1ALipFGkL1dg2On6Fmhk7HTcoBUncg+pRgNy1Y0I
         ykXuVIN5RYMbeaL86lwZVnNj4qqX6Hz0GqBDTG/ZShiL0ws6H5zkrMeHL57CnNTyIyS4
         6aUSoaz0CGicRDK/hGLiwYtYLxmSinBEnphvrXoNeeXWIpmyZuyMyfSsZk0E7X9ZuMfG
         ggLPsM4jeSZ8UE7an1lYzmKaNI7/2JY10FHHFaqXi4v1D5+EPk/la1CBGJwL2NivODxe
         Zzrg==
X-Gm-Message-State: AC+VfDxrQ4YtMu/ApYUTgxITmhnJ3ILmKR92xGxwe+XG+peqzu6ftUqj
        zpyrUfVRIJ/p/rmHlNU7cQc1cA==
X-Google-Smtp-Source: ACHHUZ7dHL7i65f2PEn0cQstrqSEa3FO60Q0LgeDTKAXZXkqJuHJJSR3AzQ/G8l3t/el+OGTHrOk9A==
X-Received: by 2002:aa7:d5ce:0:b0:50b:cf07:ad0 with SMTP id d14-20020aa7d5ce000000b0050bcf070ad0mr24238090eds.37.1684132205445;
        Sun, 14 May 2023 23:30:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id b4-20020aa7df84000000b0050673b13b58sm6766923edy.56.2023.05.14.23.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 23:30:04 -0700 (PDT)
Message-ID: <5530a1f3-ae89-29e9-dab5-c93f617edbff@linaro.org>
Date:   Mon, 15 May 2023 08:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Content-Language: en-US
To:     alison@she-devel.com, johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, achaiken@aurora.tech,
        Rob Herring <robh@kernel.org>
References: <20230515004025.1133572-1-alison@she-devel.com>
 <20230515004025.1133572-3-alison@she-devel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230515004025.1133572-3-alison@she-devel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 02:40, alison@she-devel.com wrote:
> From: Alison Chaiken <achaiken@aurora.tech>
> 
> Add support for the U-Blox Zed-F9P GNSS device.
> 
> Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
> ---
> Acked-by: Rob Herring <robh@kernel.org>

Not a correct placement. Apply the patch yourself and you will see.

Also, this is not v1, but v6.

Best regards,
Krzysztof

