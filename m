Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3DF6A5D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjB1QrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjB1QrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:47:21 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073FD34F40;
        Tue, 28 Feb 2023 08:47:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677602805; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bq2Q8ygL/SEUX6cgcpwKrWziBtCDM/1IyP1Bgqp4n/3yvzLpkGRt7eQBgYDMx0OHYx6oF829Rf7nUJTL+fgDj16Tej2RUqb7gcIqmL+AYtYF2sVOCOv8IDsqe9+mdEODYNHOSqbssLZ7rzec9nddA7bhNsViYCAHhTx6ivMPiYg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1677602805; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YzP0t2qNfnd3V6PK1d7LQSBOy5pePAV5wJ9vr1fobF0=; 
        b=lZIygUMLbMVTtXXx6MBZkWDnMik2/GkFQIURsEyey+wf7fPUujaeBrDdAjN9vIKzGV02VK1e27euViDv22GKRko5yHFDH7xJioBw9qQEFb9LQ+MZO2WAu/5ZiHDcRX3x/RYzMZ+EuAmqIs8BDgk49BRv06x8fgnFM3I/o1hiCtA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1677602805;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=YzP0t2qNfnd3V6PK1d7LQSBOy5pePAV5wJ9vr1fobF0=;
        b=MS9/DjXzffLDauoiF3iu8V30lwh6+BRt3Nb1ESoJ8UABM5AQs2FrN0oPDNIpDag6
        tAbI2EtXCNtY+5T00swlN5ZrYFr7nn3vlW3COsvzRbWfGw/C/kRkyLOK1P65A0rfMUl
        IRLyIIqRcqW6yAwuC2vOiqXhWn+qOVJD1II6eeGs=
Received: from [10.10.10.3] (212.68.60.226 [212.68.60.226]) by mx.zohomail.com
        with SMTPS id 1677602802848981.7442252849089; Tue, 28 Feb 2023 08:46:42 -0800 (PST)
Message-ID: <d7aea90f-d077-3a41-996c-804c95d72e24@arinc9.com>
Date:   Tue, 28 Feb 2023 19:46:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 07/16] dt-bindings: pinctrl: ralink: add new
 compatible strings
To:     Rob Herring <robh@kernel.org>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
 <20230222183932.33267-8-arinc.unal@arinc9.com>
 <20230227173333.GA496999-robh@kernel.org>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230227173333.GA496999-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 20:33, Rob Herring wrote:
> On Wed, Feb 22, 2023 at 09:39:23PM +0300, arinc9.unal@gmail.com wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Add the ralink,rt2880-pinmux compatible string. It had been removed from
>> the driver which broke the ABI.
>>
>> Add the mediatek compatible strings. Change the compatible string on the
>> examples with the mediatek compatible strings.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml | 7 +++++--
>>   .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml | 7 +++++--
>>   .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml | 7 +++++--
>>   .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml | 7 +++++--
>>   .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml | 7 +++++--
>>   5 files changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>> index 1e63ea34146a..531b5f616c3d 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
>> @@ -17,7 +17,10 @@ description:
>>   
>>   properties:
>>     compatible:
>> -    const: ralink,mt7620-pinctrl
>> +    enum:
>> +      - mediatek,mt7620-pinctrl
>> +      - ralink,mt7620-pinctrl
> 
> We don't update compatible strings based on acquistions nor marketing
> whims. If you want to use 'mediatek' for new things, then fine.

Understood. Only the SoCs with rtXXXX were rebranded, the mtXXXX SoCs 
share the same architecture from Ralink, so they were incorrectly called 
Ralink SoCs.

I can remove the new strings from Ralink SoCs and add them only for 
MediaTek SoCs. Or you could make an exception for this one, regarding 
the situation. Whatever you think is best.

Arınç
