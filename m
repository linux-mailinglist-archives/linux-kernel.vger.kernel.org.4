Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F2560C231
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiJYDV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJYDVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:21:24 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0354D48E9E;
        Mon, 24 Oct 2022 20:21:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b29so6266881pfp.13;
        Mon, 24 Oct 2022 20:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Saad1VjrLJJL1LCehZ/TBtzn4EaztroRijG8WoCeQ9A=;
        b=ol0sHz7nMuqHFSby3FCnHCnQjENY3wKm6wi4zM2ZZVkElhNDD/iGsUbLH1rJSA2Ou+
         8rvndA+vl5JI3nGCKH0cDOHoBgAKdO18ck6vYkT3Tnrs4A0qGz5qkFPhD+2PhHexpstS
         Pe710Ua0r7ojFspKVtnI10c4xEdZ2T7iTm9exeYLZZhcVFYh/6m75RCuxhjGY+n9OE2q
         FvUyEZt/8aFQz857++JfGd8KN5wFlA0wXjeuYcsy6e072aMksUJe9UF0eowo7kmy6KZE
         a/FZ0wriyC+Kn3EPUCIMsC/+eydAR1uBK3riWh9HJuR4LMJTsUPWpk68WNZmlQY6Kyrd
         vtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Saad1VjrLJJL1LCehZ/TBtzn4EaztroRijG8WoCeQ9A=;
        b=dO1WXuZfmebtdcImyKrWcps+f3HsuwwZruymwa5zDfXnwnPQggW0zJ5Uc/sTFgUP6G
         E0nusMz0MnmNdb3LruF4viGtilsot70ph2rjTg7VmpLjqzdL1nc7RTEsTKvNFVphCrVO
         JSHqhLt78DoxzpQOJ2nAjRUJnisNyCg09thnzaOrcMOAo/T06yyw2LkOuOTs/bH67qEy
         ypu5xUhA2p9pQU0JhCcAnuN6HifvtirlN4uFi29IVQVsi2Cg4m2JyCbVEd84NyBdvwCb
         cLlKU0P79snR6qaC8HMaMMhXyeVLS50Y1IYbvuUO7xrlthH/DgrYiKUFquTNEALh5vsP
         tEyg==
X-Gm-Message-State: ACrzQf09Q86S5t3b67HGz70uWk+PUeOeIOsEQVE8TI+5n0i4gEoyt/ru
        F56IB/NIjQSTARlgOnvC09g=
X-Google-Smtp-Source: AMsMyM5pAZNaiWZrUBklX7+jX1N4m1Eel9ABmXtXCdL8xiJSqdUOToEX59zveNnEjfbbYyznb4BHVQ==
X-Received: by 2002:a05:6a00:849:b0:56b:a2d5:8019 with SMTP id q9-20020a056a00084900b0056ba2d58019mr12659788pfk.47.1666668083473;
        Mon, 24 Oct 2022 20:21:23 -0700 (PDT)
Received: from [10.10.4.41] (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709026bc800b00179c9219195sm410826plt.16.2022.10.24.20.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 20:21:22 -0700 (PDT)
Message-ID: <75b4faa2-d1af-17ee-6a2c-a39b59adca6c@gmail.com>
Date:   Tue, 25 Oct 2022 11:19:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/1] ARM: dts: aspeed: bletchley: add aliases for mdio0
 and mdio3
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>
References: <20221025024145.1561047-1-potin.lai.pt@gmail.com>
 <CACPK8XdpeKVaxFki3GRyo30bWYNF6Q5wL706j5deaqi8P=ssdA@mail.gmail.com>
Content-Language: en-US
From:   Potin Lai <potin.lai.pt@gmail.com>
In-Reply-To: <CACPK8XdpeKVaxFki3GRyo30bWYNF6Q5wL706j5deaqi8P=ssdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/25/22 11:05, Joel Stanley wrote:
> On Tue, 25 Oct 2022 at 02:43, Potin Lai <potin.lai.pt@gmail.com> wrote:
>> Add aliases for mdio0 and mdio3 so that we can use name to lookup the
>> address of Aspeed SOC.
>>
>> For example:
>> root@bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio0
>> /ahb/mdio@1e650000
>> root@bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio3
>> /ahb/mdio@1e650018
>>
>> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
>> ---
>>  arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
>> index c02c15f15465..2825d5f3f78b 100644
>> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
>> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
>> @@ -15,6 +15,8 @@ / {
>>
>>         aliases {
>>                 serial4 = &uart5;
>> +               mdio0 = &mdio0;
>> +               mdio3 = &mdio3;
> Should this go into the dtsi instead?
Thanks for suggestion, I will move this to aspeed-g6.dtsi in next version.
>>         };
>>
>>         chosen {
>> --
>> 2.31.1
>>
