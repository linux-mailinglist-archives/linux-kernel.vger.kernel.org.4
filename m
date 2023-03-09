Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4FB6B1D04
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCIHyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCIHyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:54:13 -0500
X-Greylist: delayed 37824 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 23:53:54 PST
Received: from sender3-op-o17.zoho.com (sender3-op-o17.zoho.com [136.143.184.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48EE6B957;
        Wed,  8 Mar 2023 23:53:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678348406; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nzz/SZmrVGDdioH8gd2ceSR5S33TJJH1SOWXyGiilM4kIIYmJDlDBzMtTQ+VoPAiKa3na2dZEWt10SamAIAm3IPtth/hbtRgABWsXdeh9IeTC6iRNqa5Hux+9ShYkfPMJySSKZ9LNs6+nEOV6pkV734PZyM+f/b2WWup8sN71wU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1678348406; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=1fd7a9BQQqeefatGkptmpq6+Xp+BD4kDPIyZZcKeqWo=; 
        b=PBivApT/Xh8cQ5OYjSTQ4L1H1J0tTBWlnsbY/K9fFNglEdtqU0KiZzIqwrSWCami65hEklncFHjgkGy/Qc4bC918kPplGxjcw0qkFYby4bh6jt8LIBJVdvGIePL+H8cqr8GS8kHC49i9+BTx+6P1WSHL6MBqdyeYAZdKMqt+6uU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1678348406;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=1fd7a9BQQqeefatGkptmpq6+Xp+BD4kDPIyZZcKeqWo=;
        b=LCrfBHk2uzlnL8inI09VTobjR/W4aJWYPiPnu+/P5ig6K+WNHIsWVAL1LpengfMp
        xulJpbe0jGodtkiggMHWyMmT8ZDaz/PLdOrFsk3hIL1/5qpiouFgb5iZKoNMSi6EeVd
        kp28eEcce2u0hDMWNR4OU0pboJv2ub6Fai1hlLjk=
Received: from [10.10.10.3] (212.68.60.226 [212.68.60.226]) by mx.zohomail.com
        with SMTPS id 167834840432473.9346941163709; Wed, 8 Mar 2023 23:53:24 -0800 (PST)
Message-ID: <ccdfd262-eaf3-dbbe-7a3c-a911a5ec0fc4@arinc9.com>
Date:   Thu, 9 Mar 2023 10:53:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 09/20] dt-bindings: pinctrl: ralink: {mt7620,mt7621}:
 rename to mediatek
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
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
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
 <20230303002850.51858-10-arinc.unal@arinc9.com>
 <20230308210514.GA3767521-robh@kernel.org>
 <12be053e-b70a-faca-71c8-d8eef69a3b73@arinc9.com>
Content-Language: en-US
In-Reply-To: <12be053e-b70a-faca-71c8-d8eef69a3b73@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.03.2023 00:19, Arınç ÜNAL wrote:
> On 9.03.2023 00:05, Rob Herring wrote:
>> On Fri, Mar 03, 2023 at 03:28:38AM +0300, arinc9.unal@gmail.com wrote:
>>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>
>>> This platform from Ralink was acquired by MediaTek in 2011. Then, 
>>> MediaTek
>>> introduced these SoCs which utilise this platform. Rename the schemas to
>>> mediatek to address the incorrect naming.
>>
>> I said we don't do renames due to acquistions, you said that wasn't the
>> reason, but then that's your reasoning here.
> 
> It's not a marketing/acquistion rename as the name of these SoCs were 
> wrong from the get go. The information on the first sentence is to give 
> the idea of why these SoCs were wrongfully named as the base platform 
> that these new MediaTek SoCs share code with was called Ralink.
> 
>>
>> To give you another example, *new* i.MX things are still called
>> 'fsl,imx...' and it has been how many years since merging with NXP?
> 
> Ok this is a point I see now. Though, I fail to see how this is called 
> renaming when there's only new SoCs (from NXP in this case) to be added.

If I understand correctly, i.MX is a family from Freescale so the name 
was kept the same on new SoC releases from NXP. I believe it's different 
in this case here. There's no family name. The closest thing on the name 
of the SoC model is, it's RT for Ralink, MT for MediaTek.

On top of that, mediatek strings already exist for MT SoCs already, at 
least for MT7621.

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/Documentation/devicetree/bindings/mips/ralink.yaml?id=dd3cb467ebb5659d6552999d6f16a616653f9933#n83

Arınç
