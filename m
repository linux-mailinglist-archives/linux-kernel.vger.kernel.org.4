Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FB0666D83
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbjALJJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbjALJH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:07:57 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EB75471C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:03:10 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qk9so43139365ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVQDEVhmqO4sgcOXdj4mcnu6JqTblyj60RYXipJ+fRY=;
        b=yRgKjWr9Nv0UFBLyj0uDXk928R3LCKNkJldBI8nbkDYuUhXAjiPCmrSj4OCZSMq4bZ
         UXZjppYpkTGDjv8o/1tYhkE8hDp5fYDOUR+DVmPLtCN7naGdTo1YjhWqXpsp+hLbfptb
         Cb9+hJkXDL/lSuCPTkO6ugHzIJleuTXVM8aIF5alsEbtvEiugts8ZXGtp/pAu42UjJZv
         +r6cAOdFx68r8B86PwoCYBwTrku479xxrmQdxtmYMtnMOvIkIZ7616PcGM4B7sN0Vvnc
         ioBtrdJAcgJyHQLVHO/13KwcM64NQs92JqY/AKmSbpu0PlnZbpr4lkCvsTHx5KATBoHa
         YL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVQDEVhmqO4sgcOXdj4mcnu6JqTblyj60RYXipJ+fRY=;
        b=NLC51Z7ClXMySzqHZuwBX76fya1Grvk0ZeN+tHC8tnGXQCjCAoRYv31USc5IFviq5G
         Iislo/rbUQm9WS9EyuXEsx5YfeuEkC5u7U7y8TgO+TtaHvo1EOkVJ1z/0BxtgAxaDBqd
         aUNPGjcCY+VcJtBLhVEK8tCrrr6VasvUlDVPrca/X0WRue4Ahb5en5mazHnipesz6r5x
         zzB2N8C/j34v6lK4N7KpRNZGkDBWYXzEKc3mr8RH430s1j3uFf7jUNlc2SIAYs3Iipqk
         FSmeJxOlusOrf9U/a33XXJkzJPhLszq8GJl0n3iCWyjqotSaBmPPT/6IGt5OsW6Xegih
         mHVg==
X-Gm-Message-State: AFqh2krg6Fkd9TQ/hbb9Xhj7elah1OgtqJPjPaJqkFSkeqi2CUhoqbD5
        WC4vbOHUTUsaq+3/B925lNOFtA==
X-Google-Smtp-Source: AMrXdXtXL/qJQ+0tabMkwVX+Mi6xriBlWoHWdL9LJKoT7hxFrLQ1toZowaBk1Vanz5nmWRIlNt0DOQ==
X-Received: by 2002:a17:906:3ec8:b0:846:cdd9:d23 with SMTP id d8-20020a1709063ec800b00846cdd90d23mr61180807ejj.19.1673514189146;
        Thu, 12 Jan 2023 01:03:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v19-20020a509553000000b0046cbcc86bdesm7065250eda.7.2023.01.12.01.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 01:03:08 -0800 (PST)
Message-ID: <e1f9b552-cdcb-11fd-c90b-4e9aef2124c4@linaro.org>
Date:   Thu, 12 Jan 2023 10:03:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 5/6] dt-bindings: pinctrl: rt305x: add proper function
 muxing binding
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, erkin.bozoglu@xeront.com
References: <20221231160849.40544-1-arinc.unal@arinc9.com>
 <20221231160849.40544-6-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221231160849.40544-6-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2022 17:08, Arınç ÜNAL wrote:
> Not every function can be muxed to a group. Add proper binding which
> documents which function can be muxed to a group or set of groups.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/ralink,rt305x-pinctrl.yaml        | 236 ++++++++++++++++--
>  1 file changed, 211 insertions(+), 25 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

