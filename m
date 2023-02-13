Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1F669436C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjBMKtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjBMKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:48:41 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA374C2E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:48:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m10so2769413wrn.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3TD34vPQZyiidhF1zkU6GCwiTZaGYr8zPWkji6mfAo=;
        b=tIoLRNPjIuHeQWvUCCLKuYJfO5Q6G7tv8ssA+oxX00bP4qd5RCVEohrG4QZPbWnjw9
         7d/t4l9LHtIwGIT7M1R8xPn1Z1fRBZpzQ2I0hC3+X743PQ1Z1Go3vmfJpMXkBVDvRphi
         Dkt2q2WhhM1vvIGkb9kXD6jhv4F6QGMi8Unw7PXgPEo0J/U5OyNXTGIfIihh3Tf0ycDf
         nfd6JQzPW2LTrs8BZ8kiQqcAvygoRqqAoPInVXvDXUicVStg4QbBc2eWgHd4lhguV2Zh
         s8pC//RNGd8Ax8vVVT2m2b3sXWnpmpw79ZdzL078/54szk8a7xmORmhZLwILyQNwFjUa
         8Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3TD34vPQZyiidhF1zkU6GCwiTZaGYr8zPWkji6mfAo=;
        b=JJVXMEPOfDCW9LEQTxub82pc2nCuLauXNl2AxFmVpTdHn3MKqNy2ppU/Ob+hw+q8NZ
         HX83H90MKSghCsDoLJrWZXaN12OOMiqxnmz7RnaTVZAgW442rCl5amDUARTvUgqcFMzP
         UdoTIVckNA2lEhW2Bj5BqXYF1kHBy+vQt72FOGnkWTqTftpGrSRjYqJ/8a041odlPvcR
         9BbJGoiHXdPB5GvuEJ9N3MJIrF8GfIXbaesERfixWClZ+r8IMQGa6Yk2EI5FF4QOYkat
         Yr7VroOMktmrySCTaah5heMlamUMvKjjN5lJ7z+s38GePRQ3LBNvbSeUkNtF5X1LceD/
         WdAg==
X-Gm-Message-State: AO0yUKXZMEO7hODm7uquTibv+zxiaI/WgBmE+CSL+jkbTpZ09aD3Dj73
        X5IyCDy20qr757oQVH21S65aZCYamKDdeLES
X-Google-Smtp-Source: AK7set9JoeUT6UsF53tPOHgWzJ42AN1vOeyM1T1JG78R13UMithB6CVkZkXgY5gsq8Ll9FVc0eDF0g==
X-Received: by 2002:adf:d0c2:0:b0:2bf:e443:ea70 with SMTP id z2-20020adfd0c2000000b002bfe443ea70mr20501532wrh.1.1676285296828;
        Mon, 13 Feb 2023 02:48:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003dfefe115b9sm14931286wmc.0.2023.02.13.02.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:48:16 -0800 (PST)
Message-ID: <0c54d39b-59e1-2e58-21b4-405851211d03@linaro.org>
Date:   Mon, 13 Feb 2023 11:48:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: net: dsa: mediatek,mt7530: improve binding
 description
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
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
References: <20230212131258.47551-1-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230212131258.47551-1-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2023 14:12, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Fix inaccurate information about PHY muxing, and merge standalone and
> multi-chip module MT7530 configuration methods.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

