Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13A46BF00F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjCQRoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCQRoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:44:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58E933CDE;
        Fri, 17 Mar 2023 10:44:05 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.156.231])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B80866030BF;
        Fri, 17 Mar 2023 17:43:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679075037;
        bh=shPYMuCODMkFNZjlOGCzX1xSspkhpTtkW3qN+SA5vgY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dwBoIYsLp+X4EZ5VGBf9C8ruKohVTzsEh46ctOJfM+2uehmidYGbx2ySpEG6S8XPi
         PfHEP9cIkHFIDTg/MFj+btE06jGlnQcmTZJy2q/UB+iC9kSbbsm9j1jEGdyk3QDmvG
         juJn5aJnBZwJVPTXz/VaXKg4bCiAaAfpd3tWNPaEa8wcxtdti81O0x3v+JsC+zwORH
         2nmd6vw7ir1lsEERedx3pV2T9+xrGXk9wZSOIaDjv7pc6fsqk9p4fnSsp9WpuctEQ7
         6eTCFCeMGePzaUWoYdEPL/Qntt+hvlfI+a8Yasyqw9Fy2Az0o0IUji6LpEC2reJ9Ls
         Of5YYPuUEuh9w==
Message-ID: <e81f02f2-e692-e4ef-1510-fdc285dd5964@collabora.com>
Date:   Fri, 17 Mar 2023 19:43:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 02/11] dt-bindings: serial: snps-dw-apb-uart: Relax
 dma-names order constraint
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-3-cristian.ciocaltea@collabora.com>
 <3679f2d0-55f0-1710-abc2-b268b6fc6969@linaro.org>
 <8ae57fe3-56aa-7e50-3eaa-a12a40657baf@collabora.com>
 <80796828-7b38-184a-2e8e-3cfe9158b67f@linaro.org>
 <13cb8dbd-994c-4b38-b715-44a3bf3d278d@spud>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <13cb8dbd-994c-4b38-b715-44a3bf3d278d@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/23 18:26, Conor Dooley wrote:
> On Fri, Mar 17, 2023 at 04:54:47PM +0100, Krzysztof Kozlowski wrote:
>> On 17/03/2023 11:21, Cristian Ciocaltea wrote:
>>> On 3/17/23 10:31, Krzysztof Kozlowski wrote:
>>>> On 15/03/2023 12:47, Cristian Ciocaltea wrote:
>>>>> Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
>>>>> dma-names properties") documented dma-names property to handle Allwiner
>>>>> D1 dtbs_check warnings, but relies on a strict rx->tx ordering, which is
>>>>> the reverse of what a different board expects:
>>>>>
>>>>>     rk3326-odroid-go2.dtb: serial@ff030000: dma-names:0: 'rx' was expected
>>>>>
>>>>> A quick and incomplete check shows the inconsistency is present in many
>>>>> other DT files:
>>>>
>>>> Why not fixing the DTS? The properties should have fixed order.
>>>
>>> I was initially concerned about the risk of a potential ABI breakage,
>>> but I think that's not really a problem since dma-names is not directly
>>> accessed in the driver and DT Kernel API doesn't rely on a particular order.
>>>
>>> If there are no objections, I would switch the order in the binding to
>>> tx->rx, since that's what most of the DTS use, and fix the remaining ones.
>>
>> Since we added the order recently, I rather assume it is the correct or
>> preferred one.
> 
> IIRC I checked around the other serial bindings & there was not a
> consistent order that all serial bindings used, so I picked the order that
> was used across the various allwinner boards that do use dma-names.

Thanks for clarifying this, Conor! Would it be fine to switch to tx->rx 
order as it requires less changes to fix the inconsistencies?

> Before changing dts files, it's probably a good idea to make sure that
> the dma-names are not used somewhere outside of Linux.

Right, that means we cannot exclude the ABI breakage concern. Not sure 
how easy would be to actually verify this. Hence I wonder if there is 
really no chance to allow the flexible order in the binding..

> Cheers,
> Conor
