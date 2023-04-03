Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7746D466B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjDCOEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjDCOEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:04:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D8210F2;
        Mon,  3 Apr 2023 07:04:46 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 60AF66601F5E;
        Mon,  3 Apr 2023 15:04:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680530684;
        bh=GKaAx3+5Ax97RQ4VPVq2IxeRpyITun/3Pzk7Dq/QVuI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MvR6/K8jhi+hHTg5bGz2zLgrghp4HW92etYaUQO0wiSu+gYJE9Q/B/6TRkVmjBaq9
         tre03Ee/Z10cziGDjOSbkeCPQjQmgG0sPcCVtKy/whRB1/RZYT3DSy3+XEildhXBQe
         cJ5eqt9GibrNb82boxgMwwtuxoceUs8xzRzd7OaAIzV5su8D+3kRg9lDvAbPw+Stz4
         WR9b5G4wn+qwGYlmvavgxlSS+5E78nSzl25MloSqjZaq1lpmp3pKp74DItfTp/dLw2
         wOAjKCpZxYof9sHblByTDDdfm6mpwIc4+IKiPc470IVlPlsSrcK9MxEuT92+BF81Wg
         dwNJe/jbZuhAg==
Message-ID: <0f43fa98-4fe6-bc9c-ed8d-be7cec0dda42@collabora.com>
Date:   Mon, 3 Apr 2023 16:04:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Aw: Re: [RFC] arm64: dts: use size of reserved partition for bl2
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230403105818.29624-1-linux@fw-web.de>
 <601a8435-8e2a-2c25-5fe3-40be62269469@collabora.com>
 <trinity-f48dda5c-6787-4732-978a-a409bbb0a74d-1680530175673@3c-app-gmx-bap35>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <trinity-f48dda5c-6787-4732-978a-a409bbb0a74d-1680530175673@3c-app-gmx-bap35>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/04/23 15:56, Frank Wunderlich ha scritto:
>> Gesendet: Montag, 03. April 2023 um 14:43 Uhr
>> Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
>> Il 03/04/23 12:58, Frank Wunderlich ha scritto:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> To store uncompressed bl2 more space is required than partition is
>>> actually defined.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>
>> If this doesn't get changed anymore, I'm fine with it... but a question arises:
>> did you send patches to add your BPI-r3 board(s) to upstream u-boot?
> 
> currently i use the rfb dts for r3 in uboot: arch/arm/dts/mt7986a-sd-rfb.dts
> 
> this file in upstream uboot has no partitions defined
> 
> https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/mt7986a-sd-rfb.dts#L144
> 
> but i added them there too and i wrote content by offsets to main device (not to partitions).
> 
> https://github.com/frank-w/u-boot/blob/2023-04-bpi/arch/arm/dts/mt7986a-sd-rfb.dts#L154
> 
> so yes basicly it needs to be send there too, maybe as additional dts.
> 

I strongly encourage you to send this change to u-boot as well as changing the
kernel devicetree... and when you do, you can add a reference to the list and/or
commit @ u-boot on the commit that you'll send here for the kernel... but there's
another question...

...what happens if you run the kernel on a device with an older partition layout?
Does anything break?
I don't think that anything does, since this is read-only anyway, but just to be
sure... :-)

Besides, you have to fix the commit description, but you knew that already.

P.S.: When you post a RFC, giving it the right commit title helps sometimes! :-P

Regards,
Angelo


