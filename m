Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AF86DC6BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjDJMZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDJMZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:25:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3511B524C;
        Mon, 10 Apr 2023 05:25:46 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B83666015EC;
        Mon, 10 Apr 2023 13:25:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681129544;
        bh=/RVh0dF7TlKpEKSukKX6XhJ5f7HG7CyPyfJnYGJ2eq8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n8Ma5Eku/5McQqNsu8IwFYxw9KnoVuC23Rj6LAtvNIsToqBsfeh0EUFCd/RWqEnwQ
         i4qJQCTKRp1n6d/poomD2CDLmPg1CyS5APgoZYLfXybo50KhK47D7fUdEotp1WwIxn
         Qfl++XOIdVvDwXxTV6YTO6/TBGuYdkbYWYtpqTuD1KWIrByMgUz1i1bHhotfQR+jDX
         ZlWYpAr8oi8u6eUSd5j6H/g+mVk82Ujm4ESzZjwnyLO8vHX5xB6/LWSf5hMcXG3CLl
         tc0pcpRzfS1C1oGS7iXJpQK+p8n3vHZU1wILmBTNtcfkLgYB0H/k+C2ue2DXRq0tMZ
         PY9Eus4cb4YFw==
Message-ID: <b6c315f7-cc14-4506-6102-e52413848f81@collabora.com>
Date:   Mon, 10 Apr 2023 15:25:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 06/10] riscv: dts: allwinner: d1: Switch dma-names
 order for snps,dw-apb-uart nodes
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
References: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
 <20230321215624.78383-7-cristian.ciocaltea@collabora.com>
 <1945003.usQuhbGJ8B@jernej-laptop>
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <1945003.usQuhbGJ8B@jernej-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/23 15:36, Jernej Škrabec wrote:
> Dne torek, 21. marec 2023 ob 22:56:20 CEST je Cristian Ciocaltea napisal(a):
>> Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
>> dma-names properties") documented dma-names property to handle Allwinner
>> D1 dtbs_check warnings, but relies on the rx->tx ordering, which is the
>> reverse of what a bunch of different boards expect.
>>
>> The initial proposed solution was to allow a flexible dma-names order in
>> the binding, due to potential ABI breakage concerns after fixing the DTS
>> files. But luckily the Allwinner boards are not affected, since they are
>> using a shared DMA channel for rx and tx.
>>
>> Hence, the first step in fixing the inconsistency was to change
>> dma-names order in the binding to tx->rx.
>>
>> Do the same for the snps,dw-apb-uart nodes in the DTS file.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> Applied patches 2-6, thanks!

Hi Jernej,

Please note the patches have been already picked by Greg and were merged
in next-20230331.

Regards,
Cristian
