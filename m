Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF9A6C3D96
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCUWRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCUWRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:17:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E081717E;
        Tue, 21 Mar 2023 15:17:34 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.179.102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A31A866030D8;
        Tue, 21 Mar 2023 22:17:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679437052;
        bh=kISYc8jF93sURnyHntnC1OZ2p4p1sWgcPPfEJiI3pho=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DAlF+kqBJ+TEevV3l2dvq4UP4emcgYVVXEzpExVl2nEEZQG5wPo/gPGRhrebUJ4jB
         6UuwSHDZL7gQadG/0pX/QwT7ZZZFuhysxpycz/tYEs+BX1pZC9hNMfwaFnJ8FI718S
         HX3dybyqVznpzuASOX/4MQKrkzxdElPKo0R0J7/oCJbOGQbBgfu15V3g2EEsCgKg3O
         I7C7YYalHMeiFiBzzMhgrgJqZtMzR9T1ai92Kz63OL3ffXAXSla6rJHdZbhEmEzNB6
         EftcQErQx9ncAjS18lQI5SGVnMHuwCrZxx0b1cCZ3EZvTR5On2hyhy1IxBeDicRKnm
         r++47+MMC+UQA==
Message-ID: <7cd34af7-94e7-b5e2-053c-4cc831e4cfc4@collabora.com>
Date:   Wed, 22 Mar 2023 00:17:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 01/10] dt-bindings: serial: snps-dw-apb-uart: Switch
 dma-names order
To:     Conor Dooley <conor@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
References: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
 <20230321215624.78383-2-cristian.ciocaltea@collabora.com>
 <5287504e-c0f7-4964-8a61-fd49b7ee9547@spud>
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <5287504e-c0f7-4964-8a61-fd49b7ee9547@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 00:09, Conor Dooley wrote:
> On Tue, Mar 21, 2023 at 11:56:15PM +0200, Cristian Ciocaltea wrote:
>> Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
>> dma-names properties") documented dma-names property to handle Allwinner
>> D1 dtbs_check warnings, but relies on the rx->tx ordering, which is the
>> reverse of what a different board expects:
>>
>>    rk3326-odroid-go2.dtb: serial@ff030000: dma-names:0: 'rx' was expected
>>
>> A quick and incomplete check shows the inconsistency is present in many
>> other DTS files:
> 
>> The initial proposed solution was to allow a flexible dma-names order in
>> the binding, due to potential ABI breakage concerns after fixing the DTS
>> files. But luckily the Allwinner boards are not really affected, since
>> all of them are using a shared DMA channel for rx and tx:
> 
>> Switch dma-names order to tx->rx as the first step in fixing the
>> inconsistency. The remaining DTS fixes will be handled by separate
>> patches.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks for doing all of the switch overs too. I should've probably
> broadened my searching beyond the allwinner platforms when I initially
> added this, so yeah, thanks.

Thanks for the quick review! And no worries, I'm glad I could help, 
hopefully I didn't miss anything..
