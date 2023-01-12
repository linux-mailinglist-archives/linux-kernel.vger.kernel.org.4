Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138F1667EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbjALTIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240292AbjALTHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:07:22 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF36D13B;
        Thu, 12 Jan 2023 10:49:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673549341; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=VVwndzmZa3T9qUUdXmyL13LbeRcCo5aJtQeRb7eBu+6OetmVkzSyFwgModVSbrGppw9715GZvPbcVBY//a3GKP0rFb8M7FXFYw6ZhmG6a0aXrqwtQlAZ6o2fQQad9XwefwqXhkYzcrvDeVobMcewjY0dNVne811j2LoXV9YGDgo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1673549341; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=xj1EqQifssBoeW2Mu0UMZouBhzUVXH9Qqd8rb3GME8I=; 
        b=HjiaFjlPWYVDLgKpYM4LqTr6gdRXwjI8kdYbj83mbYvEzLluLd8ekB27EXQQXx2rKqz0yWxRttqk6rgO0zL857+7R4HYBxldp82pqPDHc/h0Ddp8EXEeQjIT1SZGEjOWFe9Lavv2WDJfun4fNhKEY5TXVAkYk/RgEtU6OT4A/6k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673549341;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=xj1EqQifssBoeW2Mu0UMZouBhzUVXH9Qqd8rb3GME8I=;
        b=MVVnnKfETDgCzyJ71jmAq0v6KG9MyoQ61/n28O/AOxxL50oAeLv599dp3ckuEkks
        51maUW8rNrzLygfhxYZqnOXoqtZJuZa0ms6JcL0SJHezSd9qrbC3YObzlQa7AbVKyA1
        DeQrTFmoYmu7mRK2OMYHgeJbOHyWzTqpDwLC7HF8=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1673549337883457.0526498585821; Thu, 12 Jan 2023 10:48:57 -0800 (PST)
Message-ID: <c5412e5c-97ff-ba79-fd78-895889c129d2@arinc9.com>
Date:   Thu, 12 Jan 2023 21:48:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 3/6] dt-bindings: pinctrl: mt7621: add proper function
 muxing binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <20221231160849.40544-4-arinc.unal@arinc9.com>
 <1b5880bb-d0ce-9dde-2fe6-e058f6efb6f1@linaro.org>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <1b5880bb-d0ce-9dde-2fe6-e058f6efb6f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.2023 12:01, Krzysztof Kozlowski wrote:
> On 31/12/2022 17:08, Arınç ÜNAL wrote:
>> Not every function can be muxed to a group. Add proper binding which
>> documents which function can be muxed to a group or set of groups.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Didn't I already ack it?
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I believe you only did for mt7620.

Thanks.
Arınç
