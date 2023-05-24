Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB0170EDCE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjEXGYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjEXGYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:24:05 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CA0184;
        Tue, 23 May 2023 23:24:04 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 084645C02A9;
        Wed, 24 May 2023 02:24:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 24 May 2023 02:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684909442; x=1684995842; bh=dH
        m7bIEbtQbvTyNRbjYc7MhOpq3YlFAWeKPIPfyLMXE=; b=CQNv/Py9bPOeXFtfJA
        iPNHBlfTlhZZSAMmLbDxynrvS3tEWlK7/bulpumeTTrVwTlX1lQikRoMIMuFv3da
        F46nmmzeXqmN9Xg60lVbeXNHl8z7sbL2Fwa+2U5LHpZV/muOrmT4fxIZZ284LmfO
        telwEO33bjsYnyE39YQ4laugu5r+ze6UeAVwhXhWNa1ekWTCYpaH/xWU5leaW3wt
        FqVSIpqQnMj1Lg1f0ASsDJ4q97w4q0IyVSskKfe5xv6UkzmgLjiQe0OZUXeokSMp
        yOT0W4LWTJXyEwBNI3GNHVOjBUhH0THnMkbYX05lGTlLXtJgX4lXIWeY44m3wl35
        cXOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684909442; x=1684995842; bh=dHm7bIEbtQbvT
        yNRbjYc7MhOpq3YlFAWeKPIPfyLMXE=; b=M9yzp7o1YzepRdNTDTftmD9+ebDkI
        wvFEkOFw/mwlbOZsagRShgx4i2zxEECH5JAwbkZGftI+knlcxJYrvDnJW64OTNpi
        f0GT6dfotEJD002JSML/ckY1phlKq/1D+DgJxVDu7hsc5rqCs8yk0mxRu845oe2G
        KVO00+Tb0GoqjQtyWv7km/9BGxgeSeHCHJH37OWMJ8VMXFqa8CqvdjOkxy6dmW5M
        OQfR/aIBzlGCyxfbpog/Qy0G4OMjiQ4UzHFY3pRPbuti2IFZQJR69kDnnRDnXcVk
        uDSGtvvniIVLeHoZOdgQaeiXLZivTNTMcCx7qXqbklIXT0pI4hftTvY8w==
X-ME-Sender: <xms:ga1tZCJRbvSNJUKg0qIJsfZZwrSMi0PjmJ4gjavwv5UwXTpxFZw6BA>
    <xme:ga1tZKIzK78V_aR_5LztumPm55DoWLxA91xRLXli-t9k_ZcD_Z6IviLDnVNc1OtRc
    luGYlnv3Ut-OkzTOdc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejgedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ga1tZCvggELx8Cm8nz6QjZomnKX2f-f9Hd6CmnK5p62CbQf_pgbMfg>
    <xmx:ga1tZHaAzVDKtNskHbgIODwllkWH-KxZpbCNL4K7D2vsu2EWAwSK2Q>
    <xmx:ga1tZJZ69QXZJfrQEcbnCndWTXRClrSNKLPmnc5rG2jeDEPK27YLhA>
    <xmx:gq1tZF7qMPhTuZD_jjbDXjamDL2sIgZZ2zlrRphwYjZXeZ03smFcbA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5D93EB60086; Wed, 24 May 2023 02:24:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <65124759-26de-4111-bc54-545a00620d75@app.fastmail.com>
In-Reply-To: <mhng-e172207d-d67d-46ab-ab95-85f0a854ace2@palmer-ri-x1c9a>
References: <mhng-e172207d-d67d-46ab-ab95-85f0a854ace2@palmer-ri-x1c9a>
Date:   Wed, 24 May 2023 08:23:41 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Randy Dunlap" <rdunlap@infradead.org>
Cc:     "Alexandre Ghiti" <alex@ghiti.fr>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        linux-next <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, "Conor Dooley" <conor@kernel.org>
Subject: Re: linux-next: Tree for May 15 (several RV64 build errors)
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023, at 03:29, Palmer Dabbelt wrote:
> On Tue, 23 May 2023 17:22:20 PDT (-0700), rdunlap@infradead.org wrote:
>> On 5/23/23 06:07, Alexandre Ghiti wrote:
>>> On 23/05/2023 04:28, Randy Dunlap wrote:
>>>> On 5/19/23 03:42, Alexandre Ghiti wrote:
>>>>>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: section .data LMA [000000000041a000,00000000075bffd7] overlaps section .text LMA [00000000000f09d4,00000000033562ab]
>>>>>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: section .init.pi.text LMA [00000000033562ac,0000000003359137] overlaps section .data LMA [000000000041a000,00000000075bffd7]
>>>>>>
>>>>>> I'll check this one too which seems to be related to kernel/pi introduction.
>>>>>
>>>>> Thanks to Bjorn: this is caused by XIP_KERNEL, which is known to have limited size, hence the overlap, so no fix for this one. Is there a way to exclude this config from randconfig?
>>>> Does this mean exclude XIP_KERNEL or something else from randconfigs?
>>>
>>>
>>> I meant excluding XIP_KERNEL from randconfigs: it has very strict constraints regarding what can/can't be enabled then it needs human intervention to make sure the error above does not happen. So I would not bother testing this in randconfigs if possible.
>>
>> I can exclude it from my randconfig builds, but I don't know of a way to exclude it from randconfig builds in general (i.e., for everyone).
>
> Arnd had suggested a trick related to menus that would result in 
> randconfig never enabling some config.  It'd suggested for 
> CONFIG_NONPORTABLE, but we didn't use it because it'd reduce randconfig 
> coverage.
>
> Maybe we should add a CONFIG_VERYSPECIAL of some sort and hide things 
> like XIP behind it (maybe M-mode too)?

I usually add 'depends on !COMPILE_TEST', that excludes it from most
build bots.

    Arnd
