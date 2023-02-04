Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A9668AAAF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjBDOtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjBDOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:49:49 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D535273;
        Sat,  4 Feb 2023 06:49:45 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B1115C00EC;
        Sat,  4 Feb 2023 09:49:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 04 Feb 2023 09:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1675522185; x=
        1675608585; bh=gMF2GYBH1UtrzPcwansQiHlAFbQcqh9mttTQYrPJ6Fk=; b=L
        xUMCZHVeWVpTjgMEckVHJJ2xwG8302Y+EFEninU5mI5Az3XieJ+wFnic4r78V5BC
        BdioDdnnpsaCQTptXOMCBfAVVwcNmqcPooinD2woY96DRkDMSUFMHgExRDWSaN1K
        ITjRktPngy2YIsL/uLYxMfzkRAI24SYqqJvd7eQ0q8qFSEmoZM6RiXbINYV9Bb8S
        YjYtQzCeWkkh90K1iY9fxGq7GGeCX9E1/a+TCAbVPBOdNnRogZAe+zrnQ0aJngW3
        2gePpo0d6JtXMrcQ1T1fXRlYalrPiMTv97V+4CaSCcHMojSun91iZlNqD4AYLUz3
        jrHZ4RboTqHSCCyvbnZYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1675522185; x=
        1675608585; bh=gMF2GYBH1UtrzPcwansQiHlAFbQcqh9mttTQYrPJ6Fk=; b=j
        4Hwd0wmVUOsbmo/ozZmsrivkhAeC8BAmMSEp9MDCPkNDTJjrjns/Ah24Cbqf4TgR
        XHvY/XI0ZAQFryw37+szzVGHk39mTNPlY7fcxeARNXLqlHwSuJPUTdxDElbxe8nO
        hg53hgu0s1oP7KeqtVv9X931nW8qYqMmDNkZbMCjPypxtH61s3NUpG9VX8Z74y4K
        6p9p6cuvgkTFwP8tgU2Wz107xsTJ+6dq5QzM3VMVTGgPn9wMpNF111jRVRRQDMco
        wt/FAY1/s2/HGyI4l1Wms87w39uk4YylfrJsn/pvaZU/3aKqfncJMvCtZzXwIeG9
        PlAs4cEbbX1VHbbbMQG4g==
X-ME-Sender: <xms:iHDeYx4LV1QEi-Tjgm-rM6U07FpVIdikQEOQAd5yLx2oDWqtERxk9Q>
    <xme:iHDeY-7LqqjHEN3YORxLqrti-j9radWayFGESMZeMbb2JA_T5omStAoTkXbBKmKhU
    fv-8sS6MJkZ5cqk5g>
X-ME-Received: <xmr:iHDeY4cAuZ5uuruZ6ncS4JmS3IjKZYvTbUlrSv3wxmOWwawE0JlstrZWfzzftv1aOIVcDBESnWRcFh7k-86zAi5Ox5EV5jaRBwOJ2ao8YXGqtXTMSCPVsDfb1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegvddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejgfffhfdujeeftdeuudeguedttefgieetffffheejuefguedv
    heejteeftdfftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:iHDeY6LvlZ7wOnTn0YYcH7j-jKc6jrnqVUe09Y0LJwIZ2oOFFD22bw>
    <xmx:iHDeY1JYvtxYbdCaZrzOP7ert_TxMPV2hJNqb5L2BhKyjoK_ud05VA>
    <xmx:iHDeYzzj4wglxWykOC-5YLfBikH-jJJ9IHM9N_ZSU_IQvK-x6FtAtA>
    <xmx:iXDeY_w8ab8XNThP-41BpYCbGop_9p0l9YFQQSgdDyz4p-dWbb27iA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Feb 2023 09:49:43 -0500 (EST)
Message-ID: <6302b081-fab5-2eea-1a56-5ad903ff7d54@sholland.org>
Date:   Sat, 4 Feb 2023 08:49:48 -0600
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
 <Y8qvIRXcCdLZjDCK@8bytes.org> <Y9zgKUUjjPq8ifPn@8bytes.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 0/6] iommu/sun50i: Allwinner D1 support
In-Reply-To: <Y9zgKUUjjPq8ifPn@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 2/3/23 04:21, Joerg Roedel wrote:
> On Fri, Jan 20, 2023 at 04:11:30PM +0100, Joerg Roedel wrote:
>> There is a conflict between these patches and changes in the IOMMU
>> core branch. With those merged in there is a compile warning about 
>> sun50i_iommu_detach_domain() being unused. Fixing that requires
>> removing of 3-4 functions, which I am not sure is the right
>> solution.
>>
>> Once this is fixed I will include the arm/allwinner branch into my
>> next branch again.
> 
> Since there was no reply to this I nuked the patches from the IOMMU 
> tree. If this is still relevant please resubmit them after the next 
> merge window.

I am not sure what the right solution is here either, and I have not had
the chance to look at it again. With my limited understanding of how the
default domain logic works, and the fact that the IOMMU driver only
supports one domain, it seems the driver should keep that domain enabled
permanently, regardless of which devices are attached. So my patch 2
would be wrong. I will investigate and send a v3 after the merge window.

Regards,
Samuel
