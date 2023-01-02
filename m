Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D361B65B474
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbjABPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjABPu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:50:27 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AC8A1B6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:50:25 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 271505C009D;
        Mon,  2 Jan 2023 10:50:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 02 Jan 2023 10:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672674623; x=
        1672761023; bh=oam6oYNXzGzzi4tbonArhmHD8y1RakV46ObBlel23fw=; b=s
        2k4aSZOJJK2KsTxRxnDZIOkLJPaj6tUhSv7phv+Is7DcdeKaFSWCNYp3ph42rdCH
        MobYPj1FwY19O4tr6TRy8RhrMFPTIq5/iJGz4naPVkgM1dmIHUm/S55cefK/SYAV
        /ON9wm+ksdvN4Yg+03+ZzVtia43Yw42OtlRCSuTA7O9oqELZQ8zJVuxpA0EFrHLv
        uFOV9pXgGemy6q+of2qi4Z9HeQIqlevLqBDzlmtDkBzeaCOW2Py5wjvv29It4xgq
        hUFDscvgufgSOX7aWPSKGhAQXg1wVvZCunY3gytZcYZoYMj2TO9PfFn6+hHZMBOv
        GagI2dht14mZkEu3CPggw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672674623; x=
        1672761023; bh=oam6oYNXzGzzi4tbonArhmHD8y1RakV46ObBlel23fw=; b=f
        0SXB6YrpUvcdCMF9S+0K9CKhLqxBkvly7toyF8f0o0tgoypRqfVorpHkRAE/Py07
        /Y4QmFgMlhx52PTb1ThySuTQZvekn5QkRtMvVo5T35EwkmWvDDdQ86w1UqlVPC6v
        f6ZnNSUfwcpjNAhG9eOYDocywJbo/TtVoQSGZs7wvTK19C+NRtjh9n1HPf5s7ZM1
        nl5YBacLXBFWhcZsQZtleMT+K2C9hqZJnJeiP/FG9vIEZY1wj4xtbJlR4aFbs/l3
        +wdMoPwkTRW9awQeaW4RfohMj5WKYbQeEu9me8GOVOUF2JzLVGWrIDSYWJi0h4Xi
        T3oPe/qUmIKQlwKIrztcg==
X-ME-Sender: <xms:Pv2yY2BPQic8p3fWT1sQHpwEwfVb9Q6G0b4pxg1-M3VAhyTNQVb8rQ>
    <xme:Pv2yYwgoAv-cFrxVZvNEyLzJvoHaTQw-eRTILc6hNyKEY24vC3Y5hx7JP6iwjAHog
    kyd2rSzB9rFpfogkA>
X-ME-Received: <xmr:Pv2yY5mTolIIvSs0uoN7SGeZvHOMSdSH5XHm7klvhTVYUSmGcCIsx-lXYHaa32hguGRPi2O5YlLa5YVM1T4r2FSP7036jGsOGVCiEojxUEfalk6Wv2dZTRA4Qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedvgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdegheektdejgfelgeeljeefteevffeggeejledtffffkeeghfeh
    tedvffefgeeinecuffhomhgrihhnpehsthgrtghkphgrthhhtggunhdrtghomhdpiihsoh
    hnghdrtghomhdrtghnpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorh
    hg
X-ME-Proxy: <xmx:Pv2yY0y6w0PAvC7xOjDk1vHTvLqe_Y8jhZqJSD19gN-rSc0AfAtxJQ>
    <xmx:Pv2yY7ReCpa2qkQ5yFfvY0Ij3QJIts0ttAZ5ayU_Kpd_i5UzsH9wfQ>
    <xmx:Pv2yY_amVhqe27UDLWidxsq5LDWEqpquUhlLWhtY0-cML-_cjlt_wQ>
    <xmx:P_2yY1e1FAiHdc9pgWDhgRJVCMJp224rgYjJcHrOhZbePnOI16bQjQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 10:50:22 -0500 (EST)
Message-ID: <bfc81317-3c63-cabe-f43f-c1ec216749e4@sholland.org>
Date:   Mon, 2 Jan 2023 09:50:21 -0600
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
 <1b17f332-827b-c8b1-807c-9c6e38caf173@sholland.org>
 <20230102110630.4c68e038@xps-13>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/3] mtd: rawnand: hynix: Add support for H27UCG8T2FTR-BC
 MLC NAND
In-Reply-To: <20230102110630.4c68e038@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/23 04:06, Miquel Raynal wrote:
> Hi Samuel,
> 
> samuel@sholland.org wrote on Fri, 30 Dec 2022 10:08:13 -0600:
> 
>> Hi Miquèl,
>>
>> On 12/30/22 06:45, Miquel Raynal wrote:
>>> Hi Samuel,
>>>
>>> samuel@sholland.org wrote on Thu, 29 Dec 2022 13:09:03 -0600:
>>>   
>>>> H27UCG8T2FTR-BC is similar to the already-supported H27UCG8T2ETR-BC, but
>>>> reports a different ID.  
>>>
>>> Can you provide a datasheet for this part? I am surprised by the page
>>> size. In general anyway, it's best to provide a link when adding
>>> support for a new component.  
>>
>> I was unable to find a datasheet for specifically H27UCG8T2FTR-BC. The
>> best datasheet I could find is for H27UCG8T2ETR-BC[0][1]. However, there
>> are layout parameters for H27UCG8T2FTR-BC in some versions of the vendor
>> NAND driver[2][3][4]. The Hynix chip is packaged as Essencore
>> I3T-8GQ8T2H5TARC, as referenced in that NAND ID table, which is the
>> actual package on the board I have.
>>
>> Regards,
>> Samuel
>>
>> [0]:
>> https://z3d9b7u8.stackpathcdn.com/pdf-down/H/2/7/H27UCG8T2ETR-BC-Hynix.pdf
> 
> Pointing to [0] or [1] in the commit log would be nice at least, even
> though we cannot get our hands on the real datasheet...

OK, I will do that for v2.

>> [1]: http://www.zsong.com.cn/userfiles/H27UC(D)G8T(U)2ETR-BC_Rev1.0_0826.pdf
>> [2]:
>> https://github.com/engSinteck/A133_Image/blob/main/longan/kernel/linux-4.9/modules/nand/sun8iw15p1/phy-nand/physic_v2/nand_id2.c#L1592
>> [3]:
>> https://github.com/launchfur/rg818-kernel/blob/master/modules/nand/sun8iw15p1/phy-nand/physic_v2/nand_id2.c#L1592
>> [4]: Adding member names to that table entry:
>>
>> {.nand_id               = {0xad, 0xde, 0x14, 0xab, 0x42, 0x4a,
>>                            0xff, 0xff},
>>  .die_cnt_per_chip      = 1,
>>  .sect_cnt_per_page     = 32,
>>  .page_cnt_per_blk      = 256,
>>  .blk_cnt_per_die       = 2112,
>>  #define NAND_MULTI_PROGRAM (1 << 3)
>>  #define NAND_RANDOM        (1 << 7)
>>  #define NAND_READ_RETRY    (1 << 8)
>>  #define NAND_LSB_PAGE_TYPE (0xff << 12)
>>  .operation_opt         = 0x00002188,
>>  .valid_blk_ratio       = 896,
>>  .access_freq           = 40,
>>  .ecc_mode              = 8,
>>  .read_retry_type       = 0x050804,
>>  .ddr_type              = 0,
>>  .option_phyisc_op_no   = 14,
>>  .ddr_info_no           = 0,
>>  .id_number             = 0x010026,
>>  .max_blk_erase_times   = 3000,
>>  .driver_no             = 1,
>>  .access_high_freq      = 40,
>>  .random_cmd2_send_flag = 0,
>>  .random_addr_num       = 0,
>>  .nand_real_page_size   = 16384 + 1664},
> 
> This and what is displayed in the two datasheets pointed above looks
> very much like out-of-band data to me, I don't get why we should treat
> this part of the array differently? The OOB area is not only supposed to
> be used for ECC bytes (even though that's how UBI make use of it), you
> can store all the data you want there (but it's not necessarily
> protected by the ECC engine, which, in general, matters a lot.
> 
> I don't see how this datasheet would be different than the others. They
> don't detail the geometry, I would have expected them to do it if the
> page size was anything different than the standard?

Maybe we are misunderstanding each other. The page size I have declared
in the table is SZ_16K, which I believe is a standard value. The
non-power-of-two chip size comes from the number of blocks in the chip;
the ".blk_cnt_per_die = 2112" above corresponds to the "8448" in patch 3.

For H27UCG8T2ETR this is described in the datasheet on page 3 as "1,060
blocks x 2 plane" and "(1,024 blocks + 36 block)/1plane". These extra
blocks are separate from the OOB area inside each page.

Regards,
Samuel

>> ".option_phyisc_op_no = 14" references this entry:
>> {
>>     /* 14 */
>>     .multi_plane_read_cmd = {0x60, 0x30},
>>     .multi_plane_write_cmd = {0x11, 0x81},
>>     .multi_plane_copy_read_cmd = {0x60, 0x60, 0x35},
>>     .multi_plane_copy_write_cmd = {0x85, 0x11, 0x81},
>>     .multi_plane_status_cmd = 0x78,
>>     .inter_bnk0_status_cmd = 0x78,
>>     .inter_bnk1_status_cmd = 0x78,
>>     .bad_block_flag_position = 0x00,
>>     .multi_plane_block_offset = 1024,
>> },
>>
> 
> Thanks,
> Miquèl

