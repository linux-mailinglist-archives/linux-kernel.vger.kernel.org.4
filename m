Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE98C6EC7B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjDXINz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjDXINy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:13:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA1199;
        Mon, 24 Apr 2023 01:13:52 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2248D6603284;
        Mon, 24 Apr 2023 09:13:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682324031;
        bh=JAwvVEqwtoFNuCe2pt5CT0Xo4i8K/F43W7FlOkm5Sks=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DEtra85tnDonxl9vUfuEs9Z2Je0MsBN6ouVRa+GkEF22zUmatqhWh1ZI23i9vT7UI
         PoCnU3rDkutjFFcC/A79r91jJW/Dchhmwo5Tye5OOWudNPBrFdLfJAAHUa1OG7iyol
         E7VZGtEqari1SLk4FonnQjZLGeXr6lumsyc+DaFC+q2IKoxnv/7vjK2e2LR7FOtpPe
         IC1Q2EYpMLx0gsk3Eqc395ZX4c4eHSgc2q+VBH/eGasyiYOIcw32Il14FIzfLKkZkK
         NVPPNgGg4uByH7bTL8NJmotOMleCeWs9ruimmCt7ccy498t6z0AFxtJr3bPUpn/KEG
         iYaECEANNWs0w==
Message-ID: <eb78450a-1eed-f914-58be-ee18d85a2d62@collabora.com>
Date:   Mon, 24 Apr 2023 10:13:47 +0200
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5GJroyKkj8oZw+BQxiUkiGCb-RBOxnKRkURQz5T6=EvNQ@mail.gmail.com>
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

Il 21/04/23 09:59, Chen-Yu Tsai ha scritto:
> On Thu, Apr 20, 2023 at 5:45 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> On Tomato rev1 the PCIe0 controller is used for NVMe storage.
> 
> This was slightly confusing for me. AFAIK rev1 is not an actual Tomato
> device. It should be the prototype board, which is the original Cherry
> reference design by Google [1].
> 
> There is an actual Cherry derived device that has NVMe, though it's under
> another brand and another name.
> 

If revision 1 is not an actual Tomato device, and you can confirm that it is
the prototype board... I can send a commit to entirely drop R1 as having it
upstream would be of no use at all.

Cheers,
Angelo

> ChenYu
> 
> [1] Much like Kukui & Jacuzzi (MT8183), and Asurada (MT8192) are the
>      reference designs.  I don't think we ever upstream the reference
>      boards because they don't really end up in the hands of people
>      outside of the project, and the ones we do have tend to be quite
>      beaten up or no longer working due to extensive testing.
> 
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>> index 2d5e8f371b6d..11fc83ddf236 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>> @@ -20,6 +20,13 @@ &sound {
>>          model = "mt8195_r1019_5682";
>>   };
>>
>> +&pcie0 {
>> +       status = "okay";
>> +
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pcie0_pins_default>;
>> +};
>> +
>>   &ts_10 {
>>          status = "okay";
>>   };
>> --
>> 2.40.0
>>
>>

