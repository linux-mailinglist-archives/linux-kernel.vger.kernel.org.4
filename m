Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FC46B9FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjCNTsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCNTsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:48:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA73126C4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:48:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o12so66663153edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678823283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZD3zckyQZWvplvlXVnSPBziJb37x7ZxPChIy7trN/1Q=;
        b=wSzEvcxGyX83038ZycV44iXNEslzvCK7PBf6/7j7g+/tooB7tbc/w8eWp68nHrKdAe
         6WXRS/NNHoGomifjp+7ofiJSRgNq05PF3hLP8PXje8SonemrCFKs+3ksRSdMfLpU9Lb4
         rCGC2ddJGApH9UzXqdHm9p3PfYFmEO/qM7qY/bVlPzxfIoD5L8635I41eW5afCcFKaRP
         ONnBBWBPBw8WtGbxztVW8bJyQrY7gZs3CWqcrGOfs/ySUVPh5Jjno0cFpgLMuMtJ1TX4
         d0uI89yh4u8FQU1ieeqpFYIs0I+w1fPtHGJrNEDNCfHVmCsrzv9FErZtGlIFkATjlhrA
         vtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678823283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZD3zckyQZWvplvlXVnSPBziJb37x7ZxPChIy7trN/1Q=;
        b=wsnll9MhTirT1LPfHv8zD16tamNOZIjzn/0SHkKGWC7sGjg8urxteoJQwHZW3z1BmN
         NTk4dwovOeXo015+qL3mOqZfGhwMp6X1Vyud6egHeZbfJOdhtyOXsuX045t9JQ8KjbSE
         wRZRTGvWudECY6BKs+fdgLNML8DdRKi7HkTNEbe9ZQOtLXkQJPDtHUsvQyDFP6o68frb
         AtkZmKR8CxC+TK6lARvYoFyexfxSCRCnG+bTRbIbqqY0qu2ht+I3acSjgG4BZIN49924
         equGwz/fsjrheBn1KLU+ao6sBMYzz4/qiKRLkfo8uYkNGblZ5sDECQqc4L1BMg8Lrlb8
         yMzw==
X-Gm-Message-State: AO0yUKUuw1k832UaKwxNioHiuxeBYx6iYfTZJcV34aYhfWQ/asBxxB+l
        S16kZxWKE35JGsedUHlJc5K0QQ==
X-Google-Smtp-Source: AK7set+0TR8DrYzzVV9JTZ2by1wDIYSgRuV+phFSkAc8QfOiSVLRDyV2soyHd4jmn/m3rMYYGoA2pA==
X-Received: by 2002:aa7:de96:0:b0:4fa:ac78:7f2a with SMTP id j22-20020aa7de96000000b004faac787f2amr207216edv.41.1678823283655;
        Tue, 14 Mar 2023 12:48:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:642b:87c2:1efc:c8af? ([2a02:810d:15c0:828:642b:87c2:1efc:c8af])
        by smtp.gmail.com with ESMTPSA id b21-20020a170906709500b009268d94c9dasm1519530ejk.152.2023.03.14.12.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 12:48:03 -0700 (PDT)
Message-ID: <84e70393-9137-faa0-0e55-f9d89ab5cafb@linaro.org>
Date:   Tue, 14 Mar 2023 20:48:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add compatible for
 Starry 2081101QFH032011-53G
Content-Language: en-US
To:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230314085034.6380-1-zhouruihai@huaqin.corp-partner.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314085034.6380-1-zhouruihai@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
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

On 14/03/2023 09:50, Ruihai Zhou wrote:
> The STARRY 2081101QFH032011-53G is a 10.1" WUXGA TFT LCD panel,
> which fits in nicely with the existing panel-boe-tv101wum-nl6
> driver. Hence, we add a new compatible with panel specific config.
> 
> Signed-off-by: Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
> ---
>  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

