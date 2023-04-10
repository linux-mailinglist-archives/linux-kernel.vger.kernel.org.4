Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95276DCA9D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjDJSVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:21:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1031FCD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 11:21:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gb34so14564048ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681150866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVIcOWWATDcmahsrKugnwUqJFiGpoNmPF9dN2ibO5JU=;
        b=Jkhl6+O3WuZHCbWvctenwizKp4ziE3rOkKGlqetDkOjya5Z39fHjGpZPhVS8jccrAk
         zDnCN4uLq5YgW6q+0CHMSQ6Ifw49T1DYbFz1U+vcoFVhR0CaCFU+P04amT625AyyDpzE
         tqjmZ5COQy/L1viVaYFtBCHkW7+HyZVHp8oyJI5d/zypxlCrJI0mB62dLCaTlUrto/5X
         ysfPod26tNsvdamlchD+M+3NLdfSElFzTVWyuD5slVhJ+qbw0EJth1vTuey8l/82SojU
         kbce24ab03p872pTwVJfRqkEabZYQ9KP8yX1Tk5wkC8xKRBwYB6QHtVbWq03xIhCqnX2
         PL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681150866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVIcOWWATDcmahsrKugnwUqJFiGpoNmPF9dN2ibO5JU=;
        b=6fsRBNYA2mJzQB8d2AiVlAZcCCwwZ9AJJiF/A8f+JqToM1VMW2+i3IzmeUU+zcasAj
         tG3v4gq4de6PP355Hweubq5UwZVQ5FYCz/hwQ598SrQXzGIVismBORtsYkT9tOxwYmvh
         zBrmJgBUdJkvmsgvuYDc2wXAhzzw8ZiuSUAsqt07VgNyV4j9pjONZFwngUKZx6oaz4Cd
         AMF3NVqjyvakQgaPROGmNG2rxLRDDH/6w5jGUkZFqDV/1shmqU4mXs5ZSX+sCIroRwfV
         rJM5hYIrdjUJXGFjQoTTEloFLmpr7HrbJh1J3JpN1DPQalGolI25UVNqLpqpBpsMuHFm
         p7pw==
X-Gm-Message-State: AAQBX9ctnzQv06hW13mQ/VJyy5BP6e3FpGi/AY07X9ha6VoJuy63D/RC
        DbuS3Y3w1NUcqDJo6yl49mBnvA==
X-Google-Smtp-Source: AKy350a48PYGq+bhWSYqUcpZzVIdt9ujd8R2nSrpLN6+ZnrZ1xw7GXS1YlIIMTm1RaUmySnBmEIf1Q==
X-Received: by 2002:a17:906:1ec8:b0:8b1:3467:d71b with SMTP id m8-20020a1709061ec800b008b13467d71bmr7889493ejj.48.1681150866220;
        Mon, 10 Apr 2023 11:21:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1a6c:6968:e633:48df? ([2a02:810d:15c0:828:1a6c:6968:e633:48df])
        by smtp.gmail.com with ESMTPSA id ty11-20020a170907c70b00b0094abc0f633dsm720252ejc.135.2023.04.10.11.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 11:21:05 -0700 (PDT)
Message-ID: <a3c37c31-6587-e723-05aa-32f2741fff30@linaro.org>
Date:   Mon, 10 Apr 2023 20:21:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/2] arm64: dts: meson-gxl: add support for Xiaomi
 Mibox 3
Content-Language: en-US
To:     Karl Chan <exkcmailist@inbox.lv>, linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230410180728.30332-1-exkcmailist@inbox.lv>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410180728.30332-1-exkcmailist@inbox.lv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 20:07, Karl Chan wrote:
> From: "Karl Chan"  <exkcmailist@inbox.lv>
> 
> The Xiaomi Mibox 3 is a TV box based on the Amlogic S905X chipset.
> There are two variants:
> - 2 GiB/8GIB
> - 1 GiB/4GIB
> 
> Both variants come with:
> - 802.11a/b/g/n/ac wifi (BCM4345)
> - HDMI , AV (CVBS) and S/PDIF optical output
> - 1x USB (utilizing both USB ports provided by the SoC)
> 
> Karl Chan (2):
>   dt-bindings: arm: amlogic: add Xiaomi Mibox 3 binding
>   arm64: dts: meson-gxl: add support for Xiaomi Mibox 3

Your patches are missing...

Best regards,
Krzysztof

