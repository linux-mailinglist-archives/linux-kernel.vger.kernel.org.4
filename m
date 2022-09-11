Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828DA5B4CE1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 11:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIKJJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 05:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiIKJI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 05:08:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDBA3A16F;
        Sun, 11 Sep 2022 02:08:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e16so10670254wrx.7;
        Sun, 11 Sep 2022 02:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=51+6g2H4IMDHj+sU7xTxYoeo5wF1+JRvy8PW2Gghvnk=;
        b=Zo0vEjkQi7WyD3p916qXn2EtpJG/Me/29Jan97sf8p1ia94iW7c4XgektQR48fcLlI
         3VsfvlwnO8IvIpaBEfWh2lum50fngrlUvQvpuS0tldKFF2aOC41PMhARWVm+xPFO2SZ/
         02N7HkhZ/BLERjnPKPyp2Fd7Jc5G1e4YrmCGOsXUqvNafY+SCpAQjczApbNFXqGwMt5T
         zzjUrZdT7LsDCUJzrU+DWn8CBRwGt3eIq1eHqNTdicW9iC3l0IJlOIrI8CPQvpBdWwTa
         A8gizFgZOR73FrDX6YhFkirfgB+UNbAz08ukw7VWQcA191IM6kZ4u1Hn642Qy0WNiOho
         JyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=51+6g2H4IMDHj+sU7xTxYoeo5wF1+JRvy8PW2Gghvnk=;
        b=Ph3+v7AhW6NCDL718H+jKD8c5KMaSyDbshCNi+nIqWGY26Q6df/5hjRBbwMNfHhqA2
         cLX2FiOHlcoBjEGSgSzGBlICavKC2xl+27+sLPew0jbLDq2u/JeVc3wQdR4BRY4Yd5E6
         7V5ABQHvE+g4P2rZkR4wszk0szoib8VSDwdf4Q/xhylz076EXOlVzjA7Zn7gHry5eo5Y
         ClNDWn3F/6WYUgnXwvCUNEesGskxHajSTGrvF+qZA2Ytc6rHxKrhEyExhEqSG8es1TqD
         rv9IKhIBToduFGm1ox5Aby+9GD3ICAle312sPRIEZw3GnNaAwTituLfTWsNLu122E/YO
         sxPw==
X-Gm-Message-State: ACgBeo2n2bRpxXpxoHeN1K6lI9GFc0WCLQmrT6HJWs4NafUN77Gz0kny
        PQWbDfUpqCfZeztxk31k6npn+5P5kNvouA==
X-Google-Smtp-Source: AA6agR4y7jgI10wcJFzL0Tg+WC3aqKqllygRkCquiMHYVk8AE8NvUcdHuhiz8nh1Qjm/FPqeyU/s4A==
X-Received: by 2002:a5d:48d1:0:b0:225:3ee8:e5b8 with SMTP id p17-20020a5d48d1000000b002253ee8e5b8mr11475929wrs.105.1662887336922;
        Sun, 11 Sep 2022 02:08:56 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id z11-20020a7bc7cb000000b003b3401f1e24sm5863263wmk.28.2022.09.11.02.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 02:08:56 -0700 (PDT)
Message-ID: <ad940df1-6876-0c38-81c8-7d7ca97046de@gmail.com>
Date:   Sun, 11 Sep 2022 12:09:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 7/9] arm64: dts: qcom: sm6115: Add basic soc dtsi
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220910143213.477261-1-iskren.chernev@gmail.com>
 <20220910143213.477261-8-iskren.chernev@gmail.com>
 <d51b0a89-a151-dd5b-b026-4291031fe1ea@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <d51b0a89-a151-dd5b-b026-4291031fe1ea@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/22 11:40, Krzysztof Kozlowski wrote:
> On 10/09/2022 16:32, Iskren Chernev wrote:
>> Add support for Qualcomm SM6115 SoC. This includes:
>> - GCC
>> - Pinctrl
>> - RPM (CC+PD)
>> - USB
>> - MMC
>> - UFS
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>> ---
>> pending issues with dtschema:
>> - for some reason, using pinctrl phandles (in mmc) breaks the pinctrl
>>   schema (4 times)
>>       .output/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: pinctrl@500000: sdc1-on-state: 'oneOf' conditional failed, one must be fixed:
>>             'pins' is a required property
>>             'clk', 'cmd', 'data', 'rclk' do not match any of the regexes: 'pinctrl-[0-9]+'
>>             [[26]] is not of type 'object'
>>             From schema: /home/iskren/src/pmos/linux-postmarketos/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
>
> It's the same as 06367559766b7c9bd96d2baef8bfc5a9bb451e25. I propose to
> fix it the same way. I can do a biger change for all pinctrls, so here
> you would need to add "-pins" prefix to entries (see patch
> 4fcdaf4b0320f93d0ccb4d36b795ed258fb07b27).

OK, that makes sense. One thing that is a bit odd -- the current pattern
"(pinconf|-pins)$" matches anything that ends in pinconf OR -pins (so it could
be sth-pinconf). Also, if you only have a single block, isn't the idea to just
list it in the -states node.  I mean we either force everybody to nest with
a pinconf, or we allow -pins for nested stuff and directly in -state for the
non-nested. Just my 2c.

> Best regards,
> Krzysztof
