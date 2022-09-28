Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265E55ED84D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiI1I53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiI1I50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:57:26 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD56D69F0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:57:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 95CD25804D1;
        Wed, 28 Sep 2022 04:57:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 28 Sep 2022 04:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664355445; x=1664359045; bh=vqR5+C+Tzk
        aoeHdqD765eNkb3ETfrMpccjTI4Cwg6kc=; b=mB6doVpcuceD/WYjeftxIZqcRG
        xbp3ZVGh1r06xbK8sFBXNTc1Xa0HhNMUoQmIBnDcFQCwmBYVP0BTtYhyw6MtmvZK
        DFkZcJEgOFDO83cm/mtbOHBemJTkDGHBiOQ/4a1D1GNM7vi7cfO+T7DD3DKgehyB
        dgpi98xzgSXGGWWVMiXb/k01mfs6uJ8KvVi28pBsAYaASxPoZFQ03ogxKFcECK/U
        16MXzS3ZdMDQtSG/Y6ppeMy/4wBxyPrssLGj0AzkUVAEPAQc4R0qPPvpltJMCKhY
        PffeHzK3mkBkYZ6Q8xZlDT+aAps1/hIZPMX+0Vyx/vo/s+rWGKFGJ5tJNo/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664355445; x=1664359045; bh=vqR5+C+TzkaoeHdqD765eNkb3ETf
        rMpccjTI4Cwg6kc=; b=XgRyCA68Ja0Rm87PxBmA9CqavmhjUokdaqcinu1bqMZ/
        pQy13rSSqOOSwybx7x5p8j3GIlKCiwLVtcyQ7JNhmlvCCXWWIFmY11EBgXwv5Ixv
        ZKBCACcAJoz3BUuKjnvKlGMq4qz580/GM0QqMKBqDyFizcssgT7MJETr9mlN4a0o
        7tsKvvblC5oB2rRurYYfPG6OMF7snj7+GBCldHC3Xvql2xjqiZJMJ1VHiBjZcubs
        MXyyX203suS2qeKljR6DSSusMTKygq19ADgdcFbU82vO3oakbSSeMP1H8qF6jCrB
        9wVBOhPwmGg3EKAYY+jL7O3s31F6j7A4LtA4H+hnAA==
X-ME-Sender: <xms:dQw0YyVm-RI7dDf6k2feIGVLucL8cIp6qRGzVuaU-mr2fQG379g4Iw>
    <xme:dQw0Y-nXB67D8_sPoUu8o6dGsK0OUWfkjdvhmqWSNbR6LdyKYoXMmWhIdEAF0plWa
    5kU4sK2CfMxyKIpBls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:dQw0Y2acfjUTsr_FzbXBKng-XX0knC8B_fwbn44qH1nL9E8Q1xGxuQ>
    <xmx:dQw0Y5WnV24iAj5fDAbzCDXJ4Hgx6BN-XbVvpgvqGoBdXrCohwxIqw>
    <xmx:dQw0Y8n8gatex3IH4cvcDQd20Id0yJYsKNK8uEMSI-bBm_FcmfGTmA>
    <xmx:dQw0Y2gvStjpiHj4VBJAd6-8mEzo1inrJhmDLeVgseB6WSEGM5_lUw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1FA9CB60086; Wed, 28 Sep 2022 04:57:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-968-g04df58079d-fm-20220921.001-g04df5807
Mime-Version: 1.0
Message-Id: <16c470b0-0a69-4182-9676-2367a7fd831d@www.fastmail.com>
In-Reply-To: <6fe0fecc-0636-67be-c5c9-ebd5aacc3f0e@sequans.com>
References: <202209210641.MziHAbW7-lkp@intel.com>
 <20220921104002.226ff3f6@xps-13>
 <ffde44bc-d4ae-4052-c60c-35c8775a5101@sequans.com>
 <7074197c-aa8d-f763-cb0f-03ea5335b923@sequans.com>
 <20220921164720.6bbc56d5@xps-13>
 <ef9a2618-2dd0-4d1b-b9d2-37d59506f004@www.fastmail.com>
 <20220921183807.241e2518@xps-13>
 <b7e5ebb4-0de8-4958-9bc4-fe06ec4c3635@www.fastmail.com>
 <6b5a2b19-39c6-5116-60c2-d292ae2e7bae@sequans.com>
 <20220922113613.4d7273c8@xps-13>
 <01210adb-ff77-4ec5-8d10-ab56ae986d58@www.fastmail.com>
 <da19f271-6ad6-7158-2ebe-e54fa5c91f6b@sequans.com>
 <e0a3bc54-a1be-4e10-afcb-bee1888c4066@www.fastmail.com>
 <6fe0fecc-0636-67be-c5c9-ebd5aacc3f0e@sequans.com>
Date:   Wed, 28 Sep 2022 10:56:55 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Valentin Korenblit" <vkorenblit@sequans.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     "kernel test robot" <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:nand/next 11/31]
 drivers/mtd/nand/raw/cadence-nand-controller.c:1893:4: error: implicit
 declaration of function 'ioread64_rep' is invalid in C99
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022, at 10:41 AM, Valentin Korenblit wrote:
> On 9/27/22 22:02, Arnd Bergmann wrote:
>> On Tue, Sep 27, 2022, at 4:56 PM, Valentin Korenblit wrote:
>>>>> But in the mean time I am only half satisfied, because we plan to do
>>>>> twice more accesses than needed _just_ because of a the COMPILE_TEST
>>>>> constraint.
>>
>> It's also possible you have to read from the second word first,
>> like
>>
>>    u32 *buf;
>>    do {
>>       buf[1] = __raw_readl(reg + 4);
>>       buf[0] = __raw_readl(reg);
>>       buf += 2;
>>    }  while (buf < end);

>
> Same result with pairs of readl at OFF0 and when reading at OFF1 first too,
> I still see sdma_err. I've just opened a case to Cadence to see if there
> is any workaround for this or if it is just not possible.

I think this just means that the access has to be done with the exact
width that is configured, and you cannot implement the access on
32-bit architectures. The only possibility is that you can reconfigure
the nand controller to 32-bit mode at runtime, which is what Cadence
should be able to tell you.

    Arnd
