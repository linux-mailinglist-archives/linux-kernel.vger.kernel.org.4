Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC83C5F4DB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJECaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJECaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:30:00 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875FCE0C7;
        Tue,  4 Oct 2022 19:29:54 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id x18so9507665qkn.6;
        Tue, 04 Oct 2022 19:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DH5rQi2gKCWVxF/UdTT3Pt9lu19qfj4nBn9r1FjX+YI=;
        b=paaudFZ6Vr3L4pp17zGBi4V8FzeImBFik2rhM1956UBDSklriKzHZ0gmdxtqulR5nG
         xNXXJ+jpi0wzO5IJ9aWAbXc5Km0R+n2fFFoOWKm/8fOK1+ETyBXZmHFqv2g/qUSZidPW
         Wr5LPAEH58Rqxt3Fa7zk8qCw13/O+TNlsVo4R9bM6tFjwLRBIpYqQm90La3pqY1BIZMm
         vCXWj3+8WX+udIXDEvtQ+GdDViCtJ6VEhaKiCsXhsX0SZAewovhm4lytoFgG8W3325GP
         0dIZI2Z6MjMRshJghjnfobYaLtfk7WlevoWIy8Bbyd9iCvhQX6e1FgNI8q7D6q7eGGLh
         aUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DH5rQi2gKCWVxF/UdTT3Pt9lu19qfj4nBn9r1FjX+YI=;
        b=KPjhJ5xkjASAGrxhEDSuBvTDOycLyv4vYDVkBNj5urEbMbBl3KQAe0WXOE9RBVWUCm
         5E6gT+YPIleu8zwzyP2JgQx3LJueQbZcvQqS7D+IOA84bFkIqSbI3VX3gtqe3lne2Oq9
         IHgEyoxICCpgKB3be9ArmMzl8NheNPyURoZdQJkoJ3f3yV0bhv3wyovM735S0j0KfreY
         jVa77JQP3zb3B8M9qS9NK8u6wBPw6LxXL3KwRPgSFAorhwWZicN9oLeKua/nQ4gVqS2O
         1BOh3b7nPN/dtW4sWG+arzT+oZKTLXxPxZA6LD0foUETe2bNG8AGY8+uCi+tXVjaWO5t
         FDhQ==
X-Gm-Message-State: ACrzQf1ozGKpQTPrYnIyh3VLWGfrK04u55oEgbtj7uuiAhNOP3H+VCxT
        VoGO52rWr4AgsWZ3Im9PxM0=
X-Google-Smtp-Source: AMsMyM6BtQhI0S8XoTCsOZmWORrstDxHcn+485rJZr9ccLPLH07taTl4gXKVzn0D+ehEn0xhQ+t2GQ==
X-Received: by 2002:a05:620a:318d:b0:6ce:d8de:bab2 with SMTP id bi13-20020a05620a318d00b006ced8debab2mr18923141qkb.456.1664936993131;
        Tue, 04 Oct 2022 19:29:53 -0700 (PDT)
Received: from [192.168.1.102] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id w2-20020a05620a444200b006dfa0891397sm3524746qkp.32.2022.10.04.19.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 19:29:52 -0700 (PDT)
Message-ID: <abbe10d1-4c2a-5fad-3f92-e55c514d3ce2@gmail.com>
Date:   Tue, 4 Oct 2022 19:29:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: linux-next: build warnings after merge of the broadcom tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>
References: <20220725095913.31e859ec@canb.auug.org.au>
 <df8f4765-a804-cb50-bbb5-475925ba2036@milecki.pl>
 <20220815105419.4df1005b@canb.auug.org.au>
 <20220831091654.45d5ed41@canb.auug.org.au>
 <20221005114841.4540d325@canb.auug.org.au>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221005114841.4540d325@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/2022 5:48 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 31 Aug 2022 09:16:54 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> On Mon, 15 Aug 2022 10:54:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>
>>> On Mon, 25 Jul 2022 12:33:48 +0200 Rafał Miłecki <rafal@milecki.pl> wrote:
>>>>
>>>> On 25.07.2022 01:59, Stephen Rothwell wrote:
>>>>> After merging the broadcom tree, today's linux-next build (arm
>>>>> multi_v7_defconfig) produced these warnings:
>>>>>
>>>>> arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
>>>>> arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
>>>>> arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
>>>>
>>>> This is expected. My commit ef126d3f58d25 ("ARM: dts: BCM5301X: Add
>>>> basic PCI controller properties") reduced following warnings:
>>>>
>>>> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'device_type' is a required property
>>>>           From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
>>>> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'ranges' is a required property
>>>>           From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
>>>> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: '#address-cells' is a required property
>>>>           From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
>>>> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: '#size-cells' is a required property
>>>>           From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
>>>>
>>>>
>>>> down to this one:
>>>>
>>>> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'ranges' is a required property
>>>>           From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
>>>>
>>>>
>>>> and basically does the right thing (adds required properties).
>>>>
>>>>
>>>> I'm fully aware "ranges" need to be added (it's mentioned in the commit)
>>>> and it's one of next things on my BCM5301X list.
>>>>
>>>> So while my commits triggers that problem it also reduces warnings so
>>>> I'd say it's acceptable.
>>
>> Not from my point of view:  I was not getting any warnings and now I am
>> getting 254 lines of warnings :-(
>>    
>>> So, is something being done about these introduced warnings?
>>
>> I am still seeing these warnings.
>>
>> The above commit is now
>>
>>    61dc1e3850a6 ("ARM: dts: BCM5301X: Add basic PCI controller properties")
> 
> Has any progress been made with this?  This commit is now in the
> arm-soc tree.

Yes, I was hoping to get some feedback on this patch:

https://lore.kernel.org/all/20220920210213.3268525-1-f.fainelli@gmail.com/

but I suppose being the ARM SoC maintainer I can just go ahead and push it.
-- 
Florian
