Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E696B13E0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCHVbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCHVbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:31:18 -0500
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3CDB854D;
        Wed,  8 Mar 2023 13:31:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678311053; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=KjmsOf7ehx4jTfl0riJMXnxP8FB+uRfC7t7inEZq8N4/RkJrqCT6fmm7BnQs+zHQ2vvwR3qcZ0iORKk7ykik2rmogrwU9nkEEese/foHmoA8UjEt4WRDd/5CR35C1EAVu3oq5snlbws7V1pFjSyVREaYwvRhMn0Q/n2n2jVhKxw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1678311053; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/MSYDbYWejPMXjOcwjxkiS5EHblGlIiGqrapEhAoCso=; 
        b=kaH75wBKImbQlnsYiASJ2kubDY8c9UEzwFcmMy9CJQ9GIhGCEg7YpKgC+IrDmFXR2tMyh0NE2QxgxkMyN05fmQ8B6Y/5qJm8qCdpHC4Raq+mwbKj76ov7ETq6tidzLUptpPOLsKz0gVCFG5hJGiLdNf8s9GgLawSwTsSjjN4/CY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1678311053;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=/MSYDbYWejPMXjOcwjxkiS5EHblGlIiGqrapEhAoCso=;
        b=iqcpeSZS/8ACGqcTYiZlf7fR4wnhrFjcsfmVJkqUT4r94IIjrgutIKc37/Dzvo92
        mc6bYk1a5bZ9DBNxtqBT/IPAYMyE5STLkqTBLixEHIRAlABt+Voqrnp9vOLC/EK56Dk
        r+sxiPiZGGli2Fn12pb3HMD/2hYwMIienABDW9rM=
Received: from [10.10.10.3] (212.68.60.226 [212.68.60.226]) by mx.zohomail.com
        with SMTPS id 1678311052439170.96243035381804; Wed, 8 Mar 2023 13:30:52 -0800 (PST)
Message-ID: <4e3919ff-0488-c89e-2ab4-0fc5c5d47f95@arinc9.com>
Date:   Thu, 9 Mar 2023 00:30:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 15/20] dt-bindings: pinctrl: {mediatek,ralink}: fix
 formatting
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
 <20230303002850.51858-16-arinc.unal@arinc9.com>
 <20230308211131.GA3803811-robh@kernel.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230308211131.GA3803811-robh@kernel.org>
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

On 9.03.2023 00:11, Rob Herring wrote:
> On Fri, Mar 03, 2023 at 03:28:44AM +0300, arinc9.unal@gmail.com wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Change the style of description properties to plain style where there's no
>> need to preserve the line endings, and vice versa.
>>
>> Fit the schemas to 80 columns for each line.
> 
> I would just leave the enum cases alone and make this patch just about
> reformatting 'description' entries. Either way:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

I guess I've got a bit of OCD so it would really annoy me knowing that 
I've kept some lines exceeding 80 columns. It seems OK with you either 
way so I'm going to keep it. ;)

Arınç
