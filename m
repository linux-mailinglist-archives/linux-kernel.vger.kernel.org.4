Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BA36C2034
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCTSny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjCTSn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:43:28 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDBED31E;
        Mon, 20 Mar 2023 11:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679337260; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=anXf6Am1T9NK86qA90SdIAMl71YV8UEjW1td0WDHnxZ/E/dRM8Q3BCorHNS/IC15sfb/AdecuYXdTOvasyAXXqoFo9AtM2RRcrd0mGma9tPv20CqJKO6S7vWT9FhvMruTMUzob08GI+BiIlT8jQjHoAWaJZBu0B89lqz5eug/4U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679337260; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=a9RwxvXHbJPa9t8iHG3Uau7EBpBE/ftRSWJKTpfTPy4=; 
        b=LfgwroXGyHQYOGq7lkQNQRDzCEIOMW8Qv9hSef7taXVC7lX+Ckc7UZDSQKL9vR85ot3EuUx74IcjOGRWjIerz0PNk8mYnpfi8dhy0myKYhGCujbCPgnXCxiyfQSMTh+Yhx8ccuAeKYZfENcj1poDw7023RN6jomoobkk5bNe2C4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679337260;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=a9RwxvXHbJPa9t8iHG3Uau7EBpBE/ftRSWJKTpfTPy4=;
        b=N0LHOty5yjqwZcpgt8lT3Im2xOyWYTyvJAYjCNapnpQ9stZeI4pyeIfY3v3Y46Wm
        2WEWlmfRt7pplAwSkSI5A2s0H1bKWNlMxFpeF8wp9FyGS51QpTHLvrZJA9pqMJatVdN
        F/g0nIyL8NC2kCzZc5MOKV+lLxnUpJLg/kOMIqyk=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 16793372581171015.9762932646127; Mon, 20 Mar 2023 11:34:18 -0700 (PDT)
Message-ID: <4eed7059-128c-f614-625a-5ab596351ce8@arinc9.com>
Date:   Mon, 20 Mar 2023 21:34:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 20/21] dt-bindings: pinctrl: mediatek: mt7620: split
 binding
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
References: <20230317213011.13656-1-arinc.unal@arinc9.com>
 <20230317213011.13656-21-arinc.unal@arinc9.com>
 <1d0c0e49-4f50-7fc8-d514-b19cf4054066@collabora.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <1d0c0e49-4f50-7fc8-d514-b19cf4054066@collabora.com>
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

On 20.03.2023 18:00, AngeloGioacchino Del Regno wrote:
> Il 17/03/23 22:30, arinc9.unal@gmail.com ha scritto:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> The MT7628 and MT7688 SoCs contain different pin muxing information,
>> therefore, should be split. This can be done now that there are 
>> compatible
>> strings to distinguish them from other SoCs.
>>
>> Split the schema out to mediatek,mt76x8-pinctrl.yaml.
>>
>> Remove mediatek,mt76x8-pinctrl from mt7620.
>>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../pinctrl/mediatek,mt7620-pinctrl.yaml      | 379 +--------------
>>   .../pinctrl/mediatek,mt76x8-pinctrl.yaml      | 450 ++++++++++++++++++
> 
> AFAIK, wildcards aren't allowed, so the new file should instead be called
> "mediatek,mt7628-pinctrl.yaml", the compatible string 
> "ralink,mt76x8-pinctrl"
> should be deprecated (but still present as to not break ABI), and the 
> driver
> updated to accept the compatible string "ralink,mt7628-pinctrl".
> 
> At that point, you could update the devicetrees as well: for MT7628, you'd
> have a node using
> 
> compatible = "ralink,mt7628-pinctrl";
> 
> while for MT7688, you'd have
> 
> compatible = "ralink,mt7688-pinctrl", "ralink,mt7628-pinctrl";
> 
> If you don't want to go through those lengths, you could still do the
> cleanup that you wanted to perform, but with a filename containing no
> wildcards - anyway.

I was able to have it accepted by Rob, and the patches are already 
applied so I'm going to leave it as is for now.

Arınç
