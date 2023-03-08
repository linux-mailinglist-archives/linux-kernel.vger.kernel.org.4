Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E54C6B13AF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCHVUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCHVUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:20:10 -0500
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD7F9270D;
        Wed,  8 Mar 2023 13:20:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678310386; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IlewZnIEKWFEliNnbQhlM3XxjcdxJc1sExS3qbuWVf8WzHfvQbgBjWcMHe7uag/fyXRUXpCX0LfI2nUJ1GSobwk8R8uPI2Zz5cO4rUcLJS293b15d/IktHBs9kb4f6sbImZFSVtYR6ezLSE6k2eMi7ssIa8vpMQuwxHOY0bmLBI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1678310386; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=UicRHgLzSizGtHUVoeMPzE5j8IO+zQmZP4ZlSEftCVY=; 
        b=oHK+tQXUd2tUHo55qWF2iTZyHAN7cziSdbbN6Y0p7Q4gXBSCvWLzXZTDhbNYDxwCmLBAxtN0qzu4iwOFJkEd0HQlk/gDBRZ/Hpi/VA5ak1hjkdv83TFmw68T2qmTjw7UGZAfBTFuyY8WdRZp8qPOvZzBEyZVM9lXudXBDJjuWmw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1678310386;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=UicRHgLzSizGtHUVoeMPzE5j8IO+zQmZP4ZlSEftCVY=;
        b=AOhSxpZZoKp6bleeRyPFfLX2b12niMXt+BDCLVgKfGiskc/BhHDlavPHrkcV4O0o
        ehiuR4OeaTq+hRV5GnmFG5PO54GaP4MaftRaX7h/fcKUqz6LiAfLGae2xP41gSrQGIW
        tE1mSqNQtCiPP2L1S3aEErwIqW3wwa9yXUdoHu6s=
Received: from [10.10.10.3] (212.68.60.226 [212.68.60.226]) by mx.zohomail.com
        with SMTPS id 1678310384500541.0956739193977; Wed, 8 Mar 2023 13:19:44 -0800 (PST)
Message-ID: <12be053e-b70a-faca-71c8-d8eef69a3b73@arinc9.com>
Date:   Thu, 9 Mar 2023 00:19:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 09/20] dt-bindings: pinctrl: ralink: {mt7620,mt7621}:
 rename to mediatek
Content-Language: en-US
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
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230308210514.GA3767521-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.03.2023 00:05, Rob Herring wrote:
> On Fri, Mar 03, 2023 at 03:28:38AM +0300, arinc9.unal@gmail.com wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> This platform from Ralink was acquired by MediaTek in 2011. Then, MediaTek
>> introduced these SoCs which utilise this platform. Rename the schemas to
>> mediatek to address the incorrect naming.
> 
> I said we don't do renames due to acquistions, you said that wasn't the
> reason, but then that's your reasoning here.

It's not a marketing/acquistion rename as the name of these SoCs were 
wrong from the get go. The information on the first sentence is to give 
the idea of why these SoCs were wrongfully named as the base platform 
that these new MediaTek SoCs share code with was called Ralink.

> 
> To give you another example, *new* i.MX things are still called
> 'fsl,imx...' and it has been how many years since merging with NXP?

Ok this is a point I see now. Though, I fail to see how this is called 
renaming when there's only new SoCs (from NXP in this case) to be added.

Arınç
