Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88B6EC9A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjDXJ7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjDXJ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:59:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A381FCC;
        Mon, 24 Apr 2023 02:59:39 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2E10F660324B;
        Mon, 24 Apr 2023 10:59:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682330377;
        bh=d4/ywTBBYaIdjKCxRKNX5qZ5Mog0dm0wH5iUfUYbv2M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gUlACtRVAMqeFR53ajNoYxRLdl3NeUNwell40eVgBz/jW8mDh4DyWz7/BiNlyPYXc
         8E62BuLw3e+7K/zeVd5iAUXJNVbOHiVAXs7KfPpwCwfRRiXeExInvFrcnoEYcRvNmO
         UWs8m27DaQ3mVENoOWt73ozjNnWPeVAASIUekBbdIAQGHBlC2reRR1ejCuET+1xX+Y
         Qotg8gu7tryiUqifKtqcW9PGzTyAGKN5wWE3dH23KNEaK56YBFo4xzuajlTYPFL5cb
         5r7o2EHmVfq+NGd5H0jO+Y2+CJC0YWA2PbBcdKCtTTrIqy0GY7svNrDiJW+Oien2Sm
         XeyXw7Z5J7RoQ==
Message-ID: <db95dbbd-d740-2c78-e0dc-55c17d5b9a04@collabora.com>
Date:   Mon, 24 Apr 2023 11:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/5] arm64: dts: mediatek: cherry-tomato-r1: Enable NVMe
 PCI-Express port
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230420094433.42794-1-angelogioacchino.delregno@collabora.com>
 <20230420094433.42794-6-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GJroyKkj8oZw+BQxiUkiGCb-RBOxnKRkURQz5T6=EvNQ@mail.gmail.com>
 <eb78450a-1eed-f914-58be-ee18d85a2d62@collabora.com>
 <CAGXv+5E5Ei9YffWQednLcmWBr2eXfsfjXBFRzxKJd+=O290xdQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5E5Ei9YffWQednLcmWBr2eXfsfjXBFRzxKJd+=O290xdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/04/23 11:40, Chen-Yu Tsai ha scritto:
> On Mon, Apr 24, 2023 at 4:13 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 21/04/23 09:59, Chen-Yu Tsai ha scritto:
>>> On Thu, Apr 20, 2023 at 5:45 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> On Tomato rev1 the PCIe0 controller is used for NVMe storage.
>>>
>>> This was slightly confusing for me. AFAIK rev1 is not an actual Tomato
>>> device. It should be the prototype board, which is the original Cherry
>>> reference design by Google [1].
>>>
>>> There is an actual Cherry derived device that has NVMe, though it's under
>>> another brand and another name.
>>>
>>
>> If revision 1 is not an actual Tomato device, and you can confirm that it is
>> the prototype board... I can send a commit to entirely drop R1 as having it
>> upstream would be of no use at all.
> 
>  From what I gathered from my colleagues, revision 1 was a Tomato prototype,
> and also the second Cherry prototype board. There shouldn't be any of these
> out in the wild.
> 
> FTR, the production version of Tomato is revision 4. Rev 2 and rev 3
> engineering samples are available to partners, but otherwise limited.
> 

Good! Thanks for the information.

> ChenYu
> 
>> Cheers,
>> Angelo
>>
>>> ChenYu
>>>
>>> [1] Much like Kukui & Jacuzzi (MT8183), and Asurada (MT8192) are the
>>>       reference designs.  I don't think we ever upstream the reference
>>>       boards because they don't really end up in the hands of people
>>>       outside of the project, and the ones we do have tend to be quite
>>>       beaten up or no longer working due to extensive testing.
>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>>>> index 2d5e8f371b6d..11fc83ddf236 100644
>>>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>>>> @@ -20,6 +20,13 @@ &sound {
>>>>           model = "mt8195_r1019_5682";
>>>>    };
>>>>
>>>> +&pcie0 {
>>>> +       status = "okay";
>>>> +
>>>> +       pinctrl-names = "default";
>>>> +       pinctrl-0 = <&pcie0_pins_default>;
>>>> +};
>>>> +
>>>>    &ts_10 {
>>>>           status = "okay";
>>>>    };
>>>> --
>>>> 2.40.0
>>>>
>>>>
>>

-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

