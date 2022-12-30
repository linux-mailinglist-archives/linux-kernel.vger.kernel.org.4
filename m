Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9857A659A61
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiL3QIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3QIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:08:22 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A9810B59
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:08:17 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6B3D75C00A1;
        Fri, 30 Dec 2022 11:08:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 30 Dec 2022 11:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672416495; x=
        1672502895; bh=b741EFPUe1bgAIlEI2cslsqKpSL7Wg+QlqeM91Vlh98=; b=l
        EFgSDAwiywCzxUJV4uL3vhG4slnO3cYQMQC6yJeFf1po6uxEpbwnWGhVOQkpUE3H
        p0uS7qrboke+SXqOf0ernKkxGgHEkTU6eFyrfFyh68xryfjR9nw2ALtiwWm1szE/
        ZlEiGA0aO3U6b2Yd4HNiU25Knq/bS9pES/PqlbTLXvdgCMGRi24hnFHOuiQ9wJRm
        nJbHyF+SA5CZs0J/yTz4IW5txlVf3FC2gS7A/1WB1hgjumxOAoq0Fwyv4CyheSeO
        FSE7bdd/Dm5zS4EcaGWJ944XYn6mKlCMftfM4Lphz6qK/E6A6jjC3/i1t3ef/NmW
        OTttM+Q+y0HOBXxv4QNiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672416495; x=
        1672502895; bh=b741EFPUe1bgAIlEI2cslsqKpSL7Wg+QlqeM91Vlh98=; b=a
        E2Z174njBnauv7Q9n15SAK4kUdJPGRpVPzACYQPXVAxeCGT6NHOEmHgh4rYLU+LH
        XtTOlQk6ewXfsrKOLL1SJ+ny7/mg+HYnHSAj8F83ykhOPCIDf0BGdyeV0cDp0D0x
        SWaK7ABNjRtz5BOtPSS2ic1DB4w1kES6xk9MeYUGTPoRT/VLagMKRp/UMRryMyy1
        GeHcdTJDIRHqkPBi+eomtaoSN07Dw+7eX7z2y3GQMsVSuTjEniJTmnpPGGsFSN/A
        pvBbj8IDRhET2o8HzdPs0LZcG+sIIWeP6szz7JuHvZuebh0y9mpuvvywwh1zpMIH
        LjEAkgybOgZL91lgd4d5g==
X-ME-Sender: <xms:7gyvY-0ld52a0_XV3DuTBcncUJqfo6X5fKDEL-ozYdU2lBrqp8LDjg>
    <xme:7gyvYxEwQNzlYUpny-Ki0knoeQPkooTiIukacoJWfV8Jd8foBO0ykg4AWCEcNPPH7
    9T-md1afgk_1dzOLA>
X-ME-Received: <xmr:7gyvY24VkHfu1nkB3ffPdj_CIHE6yE9gBh24tn3moHbrUfTdN-1WHyog2ufUKMb4pjK-Vs7LcqGrUI6pmSim6cBDm15TZ7U00YkKZQ4Z0Jjj-YWliRKH_4WLTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeigdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdegheektdejgfelgeeljeefteevffeggeejledtffffkeeghfeh
    tedvffefgeeinecuffhomhgrihhnpehsthgrtghkphgrthhhtggunhdrtghomhdpiihsoh
    hnghdrtghomhdrtghnpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorh
    hg
X-ME-Proxy: <xmx:7gyvY_1f5cWrKhOB8rXaR-Db7wMAma-aC--EbWxuZvSGVJrgfRH2qg>
    <xmx:7gyvYxHxZnYKrxwcepT5iv9G-uek4BiEd9BNuDPbJmjogj9RdfBK0g>
    <xmx:7gyvY4-G_GBnr2nh3z6XaBUucZg-ZlTcFY-zHeRqbJ34VzC2XQzWow>
    <xmx:7wyvYxCPc4HNAeOg41oY4aUy_z3J1pvvlpsoYwU_xoXYiyHak4XCLg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Dec 2022 11:08:14 -0500 (EST)
Message-ID: <1b17f332-827b-c8b1-807c-9c6e38caf173@sholland.org>
Date:   Fri, 30 Dec 2022 10:08:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221229190906.6467-1-samuel@sholland.org>
 <20221229190906.6467-2-samuel@sholland.org> <20221230134507.719edeae@xps-13>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/3] mtd: rawnand: hynix: Add support for H27UCG8T2FTR-BC
 MLC NAND
In-Reply-To: <20221230134507.719edeae@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquèl,

On 12/30/22 06:45, Miquel Raynal wrote:
> Hi Samuel,
> 
> samuel@sholland.org wrote on Thu, 29 Dec 2022 13:09:03 -0600:
> 
>> H27UCG8T2FTR-BC is similar to the already-supported H27UCG8T2ETR-BC, but
>> reports a different ID.
> 
> Can you provide a datasheet for this part? I am surprised by the page
> size. In general anyway, it's best to provide a link when adding
> support for a new component.

I was unable to find a datasheet for specifically H27UCG8T2FTR-BC. The
best datasheet I could find is for H27UCG8T2ETR-BC[0][1]. However, there
are layout parameters for H27UCG8T2FTR-BC in some versions of the vendor
NAND driver[2][3][4]. The Hynix chip is packaged as Essencore
I3T-8GQ8T2H5TARC, as referenced in that NAND ID table, which is the
actual package on the board I have.

Regards,
Samuel

[0]:
https://z3d9b7u8.stackpathcdn.com/pdf-down/H/2/7/H27UCG8T2ETR-BC-Hynix.pdf
[1]: http://www.zsong.com.cn/userfiles/H27UC(D)G8T(U)2ETR-BC_Rev1.0_0826.pdf
[2]:
https://github.com/engSinteck/A133_Image/blob/main/longan/kernel/linux-4.9/modules/nand/sun8iw15p1/phy-nand/physic_v2/nand_id2.c#L1592
[3]:
https://github.com/launchfur/rg818-kernel/blob/master/modules/nand/sun8iw15p1/phy-nand/physic_v2/nand_id2.c#L1592
[4]: Adding member names to that table entry:

{.nand_id               = {0xad, 0xde, 0x14, 0xab, 0x42, 0x4a,
                           0xff, 0xff},
 .die_cnt_per_chip      = 1,
 .sect_cnt_per_page     = 32,
 .page_cnt_per_blk      = 256,
 .blk_cnt_per_die       = 2112,
 #define NAND_MULTI_PROGRAM (1 << 3)
 #define NAND_RANDOM        (1 << 7)
 #define NAND_READ_RETRY    (1 << 8)
 #define NAND_LSB_PAGE_TYPE (0xff << 12)
 .operation_opt         = 0x00002188,
 .valid_blk_ratio       = 896,
 .access_freq           = 40,
 .ecc_mode              = 8,
 .read_retry_type       = 0x050804,
 .ddr_type              = 0,
 .option_phyisc_op_no   = 14,
 .ddr_info_no           = 0,
 .id_number             = 0x010026,
 .max_blk_erase_times   = 3000,
 .driver_no             = 1,
 .access_high_freq      = 40,
 .random_cmd2_send_flag = 0,
 .random_addr_num       = 0,
 .nand_real_page_size   = 16384 + 1664},

".option_phyisc_op_no = 14" references this entry:
{
    /* 14 */
    .multi_plane_read_cmd = {0x60, 0x30},
    .multi_plane_write_cmd = {0x11, 0x81},
    .multi_plane_copy_read_cmd = {0x60, 0x60, 0x35},
    .multi_plane_copy_write_cmd = {0x85, 0x11, 0x81},
    .multi_plane_status_cmd = 0x78,
    .inter_bnk0_status_cmd = 0x78,
    .inter_bnk1_status_cmd = 0x78,
    .bad_block_flag_position = 0x00,
    .multi_plane_block_offset = 1024,
},

