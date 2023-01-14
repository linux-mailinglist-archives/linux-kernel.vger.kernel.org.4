Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF6066ACF0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 18:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjANRRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 12:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjANRRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 12:17:13 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCCEB745;
        Sat, 14 Jan 2023 09:17:12 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 295BC32005BC;
        Sat, 14 Jan 2023 12:17:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 14 Jan 2023 12:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1673716627; x=
        1673803027; bh=dmv4ZW2RwPvwVF0AI49ZY16g/43x6QFqBEzDKnk951c=; b=X
        YFU2mVOdpocGPguQe811pw7iJ+MLOCRxXsLtYdfa5bSnS1TTPIFF2OOdvPUx5tZV
        s69uPNHu/EFMVCnI1dkjXfGlvgOav6Ke46RQ6f1DYRPktB5SFdnTV4leLJnFWgMI
        mSXQCHkvuPY/HV2BiG8qJ3dOP2VjydqK5NpIDDfI6NH57iXwrbdhXj6Q2j/u11+f
        W+n+vJHwJsc6UhdCpkRe1O3nnb4O4bkKiO6/x+/rPPwesX5FTg43b/xkl4EP4yEV
        LUM6ly86fxp7mIoKb31l9/tR2W0MPqXWApFImW9wtL0M3/jN874d4/WWnYejO39y
        7gPf5HAQVz4NDtDCwiR2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1673716627; x=
        1673803027; bh=dmv4ZW2RwPvwVF0AI49ZY16g/43x6QFqBEzDKnk951c=; b=C
        Vw+BLjwDPfydH4Vf7Ga++V/AkGeEIWU27X07vuIroUYe4+sE7xSlJyEl5dbLYHkL
        ENB32gs2VpjVQCTujETQJAKIJjJSlCkbPUFNWCHns7CvRfCxWc0nVmzzSeytRmxd
        VyyjBgjSKrLITMfstW4EdVuHEePtlzVYKThfUldXHaNwDsHLudJV87M2ZPGzaWiG
        zfCq/LKQ9VwtQ6AC1vw+8BODsfaflSYJLjZyT3u/HCdW0yXxZBcR6uj5if52u9yM
        cujq0kCz6Gx1Ln8WKrVXKewk5jzFnEEhc+0dN277dtg6sa0UyHHe2iCbivtjw1JV
        YRplmSpZfee2ijfUnfK8A==
X-ME-Sender: <xms:kuPCYwEntTza7b5Hg7ZqzJGaVzvGQ13yujXUDLA2mWg5gOeLFT11EA>
    <xme:kuPCY5WdDrX-A46fWH8cuTpuhbpSOZwwqDIcJPWqpB5egNK2vIo1XfFsW-iFYqzXf
    u09dAC4UKUUbgCVeA>
X-ME-Received: <xmr:kuPCY6JOiav7X-A64h6dJa8zZWi-cRZoidaLH-wU_rVXDAvwc2qUsrgmSO6vmDm7dLE-uGSeu_vLozBqEvvS3UZNQkQyxnRm45nPBLPa_UGMhqadvMipcIAdzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddttddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeehtedtfeegueduledvffeljeehjeeuleduudeivdekffegteeu
    vedvledvteefjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:kuPCYyFzV6Q9sO7d8ygrs4K51tZIVcIGA9eSpyR-9DTT7BrsJDS76w>
    <xmx:kuPCY2VvW4eT-sYf0V4PnAdBoAPY8jGla9gWo_12873x73Bi_mJFyg>
    <xmx:kuPCY1PIBZBm0XOUEaJWeZZxMtUFUQxAQuH6ugY-H60cJ2_AZjDNgA>
    <xmx:k-PCY9OVOsEUuHvY9xjDc1MgvMMNko7upbISd6klGiyZSScTr0NBNw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Jan 2023 12:17:06 -0500 (EST)
Message-ID: <9a36551c-225c-137c-9376-ad7306c7f3d0@sholland.org>
Date:   Sat, 14 Jan 2023 11:17:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
References: <20230103010903.11181-1-samuel@sholland.org>
 <20230103010903.11181-7-samuel@sholland.org> <Y8F6NxYpJELbvogC@8bytes.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 6/6] riscv: dts: allwinner: d1: Add the IOMMU node
In-Reply-To: <Y8F6NxYpJELbvogC@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 1/13/23 09:35, Joerg Roedel wrote:
> On Mon, Jan 02, 2023 at 07:09:03PM -0600, Samuel Holland wrote:
>>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 10 ++++++++++
> 
> This file does not exist in v6.2-rc3, what tree ist this patch-set based
> on?

The D1/D1s/T113 devicetree is added by this series[1], which will be
merged through the sunxi -> soc tree. That patch is included to show how
the new compatible string is used, and that the driver changes have been
tested. You can ignore it when merging the binding/driver changes. The
rest of the series should apply cleanly to v6.2-rc3.

Regards,
Samuel

[1]:
https://lore.kernel.org/linux-sunxi/20221231233851.24923-1-samuel@sholland.org/

