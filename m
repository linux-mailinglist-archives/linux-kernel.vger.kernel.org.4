Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0EA6DA08D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbjDFTBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbjDFTBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6314C01
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:01:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-504718a2282so295030a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680807662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45/7TKpTCK5h6ilh1LUuYviPKiZpP9rCbl++IuI078M=;
        b=AJvUwHrCIdJ0dugZeaXPR9QOmXg1fGP9y7UZ0f2s8f9oAcsuhPGeYFOo7n2XS2BDP3
         w1XG9rv95+HdYppKZu+EXeUbWxDEzBgXDc3O87lWERYFnHv9dAxrdzDKTieu914+curg
         9Y4zxXZ2XbcTQWJxc3SLoHX2fXd2IsQ6dtonVY+aEIfYsnLvfUVjPF+NxSnfWFpG8nfO
         e/M7RrqCvv4/a3fiTBHYliRDaKNazhAQcLeNRA5hmVuWb+q/X2T49Bd7BuJDwFJncxBm
         hQNpi7RT32yy2Jp5oEzg9CV3JctwMyx7SG8KG4I7h6ebOEEbZdUBjZ1l76vEX/piYcLl
         dbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45/7TKpTCK5h6ilh1LUuYviPKiZpP9rCbl++IuI078M=;
        b=mLlkqxGmCZY/4Psm3FRYrV/XWUihF+NzEbZp30LZIc9RBnZ3VWe+xIU7deM2NRhY/W
         LsrYsRcbDBeFqVhWBePcagGMpBAfai2oma1AUlSpbTaUgTeMieHRZ5yWRrDas+mnDzSS
         aAdeA8vdFfD+xkylmVTVBRDcZ62r75dTZ7IP89MIpFJ3gfpgSuoT7wW94XKIOssZ/8e3
         REg4IRa2UT4yY5QrKrDq/kUNUyY/KaedNpkFXioFK7TEIdib98z+DLXIKmNu2tVXaiFd
         /RQRXeFz75L0WanaevAcizxLv3qnvjR/L3FUcV+RWGT2xF8c01YOM78x1ypaFoYOF5NV
         2y6w==
X-Gm-Message-State: AAQBX9fO4hpuSHvpVZkMsjzm1wwg5GxMLHLAsoteptpC1cv/IfRRU/sW
        DgJAp24/u8y12EWbRtoAd4icOQ==
X-Google-Smtp-Source: AKy350YprH2WnV7+jiFkLh1Q5wGRZkgpCiVtUPg4XJUg3nVkktNIL9AJ0vmKPH7xXC9eO0PeALpsZw==
X-Received: by 2002:aa7:d556:0:b0:4fa:ad62:b1a0 with SMTP id u22-20020aa7d556000000b004faad62b1a0mr445160edr.41.1680807662032;
        Thu, 06 Apr 2023 12:01:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id d20-20020a50cd54000000b005027dd7c403sm1056008edj.66.2023.04.06.12.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:01:01 -0700 (PDT)
Message-ID: <b30f8159-e2b0-8a1a-1feb-507c3a9b37ee@linaro.org>
Date:   Thu, 6 Apr 2023 21:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/7] dt-bindings: net: dsa: mediatek,mt7530: improve MCM
 and MT7988 information
Content-Language: en-US
To:     arinc9.unal@gmail.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230406080141.22924-1-arinc.unal@arinc9.com>
 <20230406080141.22924-2-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406080141.22924-2-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 10:01, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Improve the description of the schema.
> 
> The MT7620 SoCs described are not part of the multi-chip module but rather
> built into the SoC. Mention the MT7530 MMIO driver not supporting them.
> 
> Move information for the switch on the MT7988 SoC below MT7531, and improve
> it.
> 
> List maintainers in alphabetical order by first name.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

