Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D106BF031
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCQRwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCQRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:52:39 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6793D3E1C1;
        Fri, 17 Mar 2023 10:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679075524; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=X0J4EYxYIVPhTMYsdMCQ/bOf3JPwMJPq2Bww0bVG/WzKdchpPqBQ6MsXfYrVwouRzHUCiCnxiZ1/GQIcKB00GcOd8Caa+mNM1SmnMuTNmqGDBuXfVFmBzvcFcJyJrrxelgjNI4qCgEYTukVGTCV8VRAw37a9YWsvNa62UpDVYUU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679075524; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=HboPBjjnAW7lExCT3DDX52v29WYH5jeE8ulOkVKDL0Y=; 
        b=GGLKaviRG5rETCqxAwvdy5dVln06W8cZ46sGLupCY6sq72TbljuJQXVPYMoT0MWLr8aKsrs1/XRCcH63kqsXHBYFCke4vbuSBqPJ4gmFjMAkQXkA1Xyjvt/OxlKygdpN5AWN1qsA3LkV5POhcGTgitYeB83dkurUqaB/kNOtaF8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679075524;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=HboPBjjnAW7lExCT3DDX52v29WYH5jeE8ulOkVKDL0Y=;
        b=ceosCciEBnu79CIoBxUtyCwsRoYpjA2pjeX30QSUJqBKiRu8ymEcw3zOAZD0ltn0
        OCKNt5HuFi2wiplDnqvGiLTlwuCgD4otYeLRlCj/R5wJGfOMa5XYsS2gUaW+qodcyd3
        yMH1JiYS6OkBoDdm+fIfoJ4ILLwZw9DRcMWRihNw=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679075522087770.3623448757124; Fri, 17 Mar 2023 10:52:02 -0700 (PDT)
Message-ID: <690e29ee-5e40-5f57-59d7-7c1167852cfb@arinc9.com>
Date:   Fri, 17 Mar 2023 20:51:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 15/21] dt-bindings: pinctrl: {mediatek,ralink}: fix
 formatting
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        erkin.bozoglu@xeront.com, linux-gpio@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Andy Teng <andy.teng@mediatek.com>,
        William Dean <williamsukatube@gmail.com>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        DENG Qingfang <dqfext@gmail.com>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
 <20230313205921.35342-16-arinc.unal@arinc9.com>
 <167880254685.25972.15349420182231511267.robh@kernel.org>
 <c64d9f88-75ca-3a6c-b5c2-6e4b1a161d5f@arinc9.com>
Content-Language: en-US
In-Reply-To: <c64d9f88-75ca-3a6c-b5c2-6e4b1a161d5f@arinc9.com>
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

On 14.03.2023 18:38, Arınç ÜNAL wrote:
> On 14.03.2023 17:10, Rob Herring wrote:
>>
>> On Mon, 13 Mar 2023 23:59:15 +0300, arinc9.unal@gmail.com wrote:
>>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>
>>> Change the style of description properties to plain style where 
>>> there's no
>>> need to preserve the line endings, and vice versa.
>>>
>>> Fit the schemas to 80 columns for each line.
>>>
>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> ---
>>>   .../pinctrl/mediatek,mt65xx-pinctrl.yaml      | 22 +++---
>>>   .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 33 +++++----
>>>   .../pinctrl/mediatek,mt6795-pinctrl.yaml      | 33 +++++----
>>>   .../pinctrl/mediatek,mt7620-pinctrl.yaml      |  2 +-
>>>   .../pinctrl/mediatek,mt7621-pinctrl.yaml      |  2 +-
>>>   .../pinctrl/mediatek,mt7622-pinctrl.yaml      | 26 +++----
>>>   .../pinctrl/mediatek,mt7981-pinctrl.yaml      | 33 +++++----
>>>   .../pinctrl/mediatek,mt7986-pinctrl.yaml      | 68 ++++++++---------
>>>   .../pinctrl/mediatek,mt8183-pinctrl.yaml      | 26 ++++---
>>>   .../pinctrl/mediatek,mt8186-pinctrl.yaml      | 47 ++++++------
>>>   .../pinctrl/mediatek,mt8188-pinctrl.yaml      | 74 ++++++++++---------
>>>   .../pinctrl/mediatek,mt8192-pinctrl.yaml      | 47 ++++++------
>>>   .../pinctrl/mediatek,mt8195-pinctrl.yaml      | 41 +++++-----
>>>   .../pinctrl/mediatek,mt8365-pinctrl.yaml      | 28 +++----
>>>   .../pinctrl/ralink,rt2880-pinctrl.yaml        |  2 +-
>>>   .../pinctrl/ralink,rt305x-pinctrl.yaml        |  2 +-
>>>   .../pinctrl/ralink,rt3883-pinctrl.yaml        |  2 +-
>>>   17 files changed, 254 insertions(+), 234 deletions(-)
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>> ./Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml:103:16: [warning] wrong indentation: expected 14 but found 15 (indentation)
>> ./Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml:113:16: [warning] wrong indentation: expected 14 but found 15 (indentation)
>>
>> dtschema/dtc warnings/errors:
>>
>> doc reference errors (make refcheckdocs):
>>
>> See 
>> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230313205921.35342-16-arinc.unal@arinc9.com
>>
>> The base for the series is generally the latest rc1. A different 
>> dependency
>> should be noted in *this* patch.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit after running the above command yourself. Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>> your schema. However, it must be unset to test all examples with your 
>> schema.
> 
> I do see the warning. Looks like the wrong indentation was there before 
> my patch series. I'll address that as well on this patch on v3.
> 
> Will you review the rest of v2?

I guess that's a no. I'll send v3 soon.

Arınç
