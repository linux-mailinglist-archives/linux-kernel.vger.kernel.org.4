Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2105E6035
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiIVKxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiIVKxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:53:04 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D681ED12F3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:53:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id C28772B059A3;
        Thu, 22 Sep 2022 06:52:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 22 Sep 2022 06:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663843979; x=1663847579; bh=cSRj8m6//S
        4nzmuhOOEsOKmR8Il0fc1BoRQKLeM0xek=; b=dz6wqdl4kZMoMtAMLClFD0INx0
        7BAEmvn72swpQTyghCbvkZB4LYJNkruxi/ppf7Lrwgm8vb1W4+LbllC1KGbzaWY2
        PE86tTzsN1ewHNSHAymcLdhaw+XwGN7gTNvXvjN87lYMHQ1DemnYCPdWivehLCbz
        87RaN5hSObbN1oarfbyiJS8/4NxFy1MrrtZ0T12r3H5x8TRNGZzOIh5rnp1xat+G
        Xl3FCpDrl5swixCJG1iWh23LQPyurL9bPPo2xbFHYN6VdrC7euXNngVQ7jrNBYoP
        e927ZI2w4ox5WspWtg5lSPjMKWzIoeP18UMNfiDGldIIU7MswNZN8xo7tqlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663843979; x=1663847579; bh=cSRj8m6//S4nzmuhOOEsOKmR8Il0
        fc1BoRQKLeM0xek=; b=R3d+pTy37CMSCYZ3dpdDqVRJxPO0PC54qMOr35F2FIbl
        yPTw1pLoLZn57bz9vTy2+rpBenU3LvxYfvL/Ve8fNz1nEosK0wBntg0XNS9/V/6d
        uhxPOBJv8IMxSArMS2SB+uhTbaulBzhAOKo1t7D4L6KgP1+aKRI6kh80zamNE4s4
        saBPddd42SmNnq+FrpLbPGaeA/IoPgXHMI5u+ThXFeOjKMRBezQ2htdUNDyiYLal
        BLq1ZSJwtzwoh/uDUCy2wU0Wi8pOZT9mRP3EUspE/AS13Igz3EzpDD+tQIriHk4x
        uLSHCIEwIYDbf1dUxsOM1Ert01YC5XFJn0dDyvSCBQ==
X-ME-Sender: <xms:ij4sY1qlCUU4DRf2BNE8Nfb4CfJrmnGtkLLOQmD_8jZPX_xYl0bioQ>
    <xme:ij4sY3pfmNILoMPn1zUPGDBJ0lPbQ0KnBB_XTd8ggJ6iX_8c9PFN054hNDIeDAPRY
    307bxklvBewlk_faVE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeffedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ij4sYyObgFgEWFxQGj8z7jtbkPn5IY458-A4LuIWaoBfeWv-RksRlQ>
    <xmx:ij4sYw7sSt3sRE4VFq-kJO3H1CDrIj4hyhj6zBkA3LxrauWIUDpT-A>
    <xmx:ij4sY07aJoYTu8ZfC-269EayKROvMw7PH1y6Js9s-0bS1rsOoHhDDA>
    <xmx:iz4sYyny0aUeTm686xh9w0JAkjcbGN2VDR3Gos9uDYNVIkMn_sLLNGYJVX4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 68050B60086; Thu, 22 Sep 2022 06:52:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <01210adb-ff77-4ec5-8d10-ab56ae986d58@www.fastmail.com>
In-Reply-To: <20220922113613.4d7273c8@xps-13>
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
Date:   Thu, 22 Sep 2022 12:52:36 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Valentin Korenblit" <vkorenblit@sequans.com>
Cc:     "kernel test robot" <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:nand/next 11/31]
 drivers/mtd/nand/raw/cadence-nand-controller.c:1893:4: error: implicit
 declaration of function 'ioread64_rep' is invalid in C99
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022, at 11:36 AM, Miquel Raynal wrote:
> vkorenblit@sequans.com wrote on Thu, 22 Sep 2022 10:18:46 +0200:
>> 
>> Correct, this was my initial idea. However, this driver should work
>> with every architecture or do we limit the scope to arm/arm64/x86_64?
>
> The driver should work on ARM and aarch64, I'm not aware of other
> architectures with this IP.
>
> The driver should compile when COMPILE_TEST=y.

It should also be written in a way that makes it plausible to
use elsewhere. Since this is just a licensed IP core, there is
a good chance that someone reused it on mips or riscv, or
anything else.

>> >> I believe what Valentin wanted to achieve in the first place, was to
>> >> use 64-bit accesses when relevant (otherwise it does not work).  
>> > The width is read from a device specific register at
>> > runtime, it is not related to the architecture you are
>> > running on, presumably this is hardwired during the
>> > design of an SoC, based on the capabilities of the DMA
>> > engine:
>
> Well, yes, but in the mean time 64-bit DMA width will never be
> used on 32-bit platforms.

Why? Most architectures (including x86 and arm) allow you to
run a 32-bit kernel on a 64-bit SoC. While this is almost always
a bad idea to actually do, a driver should be written to
work correctly in this setup.

>> > This usually means the largest access that is valid for
>> > reading from the FIFO, but usually smaller accesses work
>> > as well, just slower.  
>
> Mmh, ok, that's interesting, thanks for the pointer.
>
> But in the mean time I am only half satisfied, because we plan to do
> twice more accesses than needed _just_ because of a the COMPILE_TEST
> constraint.

In my example, I had an #ifdef so it would only fall back
to 32-bit accesses on the 64-bit register when running an
actual 32-bit kernel, but leaving the 64-bit case efficient.

    Arnd
