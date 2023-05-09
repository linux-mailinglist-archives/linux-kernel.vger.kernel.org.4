Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF66FC724
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjEIMx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjEIMxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:53:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39314E66
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:53:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-956ff2399b1so1094362466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 05:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683636830; x=1686228830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQ1fu2WVit0XpFYJO1HVXZdtM09g9xg4NWdbjKfjcdw=;
        b=NRJa4wR0L5sxYiBYsjvaSotaEAr3i/z5gi+yJfZyMbQ9M1G3IZF2Vg+1deYmCTWkeq
         sKoIpW1DstIc1l7EsIA5+Xviu/cOAXuZ944ggjj338Z1SOs4WjNv35C+Oiipi8IEuo3R
         QfLJm9Rk7r+efYiB53saEWK5bhdifTQKOFwDtQsSsDEhmCSrUp0CaEX0j+la+X05qCzu
         USi6IROBozT9gZ8Lr2FzpHkxrdCpkKIxUqP7WoOvJ1zfuwWM921C8uW19ygPCfIBVYPw
         vq30JP/lg7Bebnh0vdQYH27930zpQoTYp1Zk2tNFcoNOjDpUCm2Po5IXcAD2Jcu+1o0h
         sh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683636830; x=1686228830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ1fu2WVit0XpFYJO1HVXZdtM09g9xg4NWdbjKfjcdw=;
        b=j0VeJp702ofyVMXUKeqBqBsIZcuvY13zExuYFMG2vnXOy+eblM/LLXkYlPiHkHbvTQ
         PcU4qXTzBdmMuW7o+k3TXwrrxLmgA59I1RRXU8Qat+LJpY36PFtzOqkSe60UY52w5u/Z
         paEL6cwoHsh3ueduquMslbMq3+wGnKXyymO+MzpBxOGTrX+tsiEIN0e6iuw/eJCWMbEJ
         rASNd//nOlm7yIeUVwkIP+12zKJfmVWeO2nJzeQCTniTw8u4Q7Xa/iyYnNgqmz6b00QC
         XFyQ8O5mBrssgWQn0zuH2TlCML/nz3ja3AhTE552nXXTN85tjmNyU7a+WyVv8f1Oedfy
         qQGQ==
X-Gm-Message-State: AC+VfDykYTze53BbPaFp8w8468C+mzqQ1QkP+SWlNcWOO8EtTdkLa3mK
        KDPhCEjM1v+q7JvPgBSVFK2DbA==
X-Google-Smtp-Source: ACHHUZ5rMdpsKWEvTTEh/DvsOL9NDyPEkz0z+m31zmJLkkf82u2ZmFAqnlUjBTnJ0ThDeANQb8DwXg==
X-Received: by 2002:a17:907:9454:b0:953:291a:6705 with SMTP id dl20-20020a170907945400b00953291a6705mr12123308ejc.17.1683636830597;
        Tue, 09 May 2023 05:53:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id gz4-20020a170907a04400b009571293d6acsm1294306ejc.59.2023.05.09.05.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 05:53:48 -0700 (PDT)
Message-ID: <ffa9077a-db13-8272-fea1-93290f8bcd6b@linaro.org>
Date:   Tue, 9 May 2023 14:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/3] ASoC: ingenic: Add compatible string for X1000 SoC
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tsbogend@alpha.franken.de,
        paul@crapouillou.net
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
References: <20230509124238.195191-1-aidanmacdonald.0x0@gmail.com>
 <20230509124238.195191-2-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509124238.195191-2-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 14:42, Aidan MacDonald wrote:
> The audio controller in the X1000 is similar to the JZ47xx SoCs.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/ingenic,aic.yaml | 1 +

Subject: missing dt-bindings prefix (second).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

