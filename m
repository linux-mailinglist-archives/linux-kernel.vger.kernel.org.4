Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C723E6ADBE1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCGK2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCGK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:27:15 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206165293B;
        Tue,  7 Mar 2023 02:27:12 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id ACA0F5C00BC;
        Tue,  7 Mar 2023 05:27:10 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 07 Mar 2023 05:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678184830; x=1678271230; bh=Nm
        HqRYp6yAhcV+Ytb7Zr7mo9BQW3Ju//Dis9Km0g2bU=; b=I6tr/SD1k/QYr+50AB
        vtg3dpmKpdrwM/G3hisW7VApCJAOWluC4SdJo9PrvAvXkLMiyBuhjaldqDxjLcJf
        7JqJl24f/7cY1xoCeWbg7rX1PeLYQoKXPWxPWGTeun7GvmfBvJIYwwk5fmD3VaRO
        HLGwGgGxHrAQB6Vg1AcfDCx7TAKREphqDowTwztFUUuZ0Ri+VN1EL6mn+P2j+Osv
        q/M6Stigr9DvnLw/s3TkArp0AyMgfdc2Lzb+8pFf9hKMD/uEGc+zP5b0zDdGkmbq
        8mBEQeNyvO4BcpPhs9ajBcv+CbFksjE4+eM2dcr4nIqyJbFtSG9inILcOdAYi/w2
        VMYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678184830; x=1678271230; bh=NmHqRYp6yAhcV
        +Ytb7Zr7mo9BQW3Ju//Dis9Km0g2bU=; b=RURfB6xdSPXr+nTbpgaI7KnNi2xdN
        z5HD0/slt182A0H5TDhwsgA84EQZ4npIV+mTBtSfpg1t6bnCfqNNgyH+X6YsyOLr
        wse4JlYq1v+7LdLWr57kp6Wlj8M0YmRxszU+0mU0EKyAEYNzqeCn9EltxLcsuORx
        oB5iJvA9uszy5ju23iP2LDBY0si2n0sWcs6lXRm9stD++ASKDMrCbqKKoYZg4Tbj
        7elhGJ1hjzoSoKsB6jx/VK+24D5OAIhG5vf0yG+2Kh8N/k2rxXRIZ32oMKgYyV6S
        PFEJZjXmgsx19C9v+e4/gVmiRW4S7yLvA88tXhevYAltQ0Ki7Wy2Z0cmg==
X-ME-Sender: <xms:fhEHZGiHao4MkUIu6IrXHkxP8PCZYL1ZJxtKNTJum07Vxvt6EN0I1Q>
    <xme:fhEHZHAz2aT2iQGw7HCx3sYWAL2B7SoXMdw0THu77Xy7VG-jSha-OFYT7bQeq1aC6
    8d1iSLAmRlFic9W4Io>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddutddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:fhEHZOHeUdc9HfHJ-JaUu4qa2CkngOjaOY75JiCRNrg7lHXzg9SUVA>
    <xmx:fhEHZPR3aRaYMy9g05Ef2vx7LScYY_tzWnrJwtIiLBgYi-LKGXlyxw>
    <xmx:fhEHZDwP4bUU_tz8pnvUedHyToDWTfLNKGSI2fPzAtribmqwPatBwA>
    <xmx:fhEHZFvo_IzbvEsOogY7XPVWFzevDGFCKIgMiaR0ZM1xhMUy1z_j0g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 293CEB60086; Tue,  7 Mar 2023 05:27:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-206-g57c8fdedf8-fm-20230227.001-g57c8fded
Mime-Version: 1.0
Message-Id: <1e321754-5bdd-4019-8524-2222ee369502@app.fastmail.com>
In-Reply-To: <20230307100350.1c0af7b9@xps-13>
References: <20230307074038.17391-1-lukas.bulwahn@gmail.com>
 <20230307100350.1c0af7b9@xps-13>
Date:   Tue, 07 Mar 2023 11:26:48 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>
Cc:     "Richard Weinberger" <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: parsers: remove reference to config MTD_NAND_TMIO
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023, at 10:03, Miquel Raynal wrote:
> Hi Lukas,
>
> lukas.bulwahn@gmail.com wrote on Tue,  7 Mar 2023 08:40:38 +0100:
>
>> Commit 568494db6809 ("mtd: remove tmio_nand driver") removes the config
>> MTD_NAND_TMIO and its corresponding driver.
>> 
>> Remove the reference in MTD_SHARPSL_PARTS to that removed config.
>> 
>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> ---
>> Arnd, please ack.
>> Miquel, please pick this minor non-urgent patch on top of the commit above.
>
> Actually I guess the SHARPSL driver is not selectable right now, so
> this should be sent as part of my next fixes PR.

I don't see why not, it just depends on 'ARCH_PXA||COMPILE_TEST' and
should work fine with CONFIG_MACH_SPITZ PDAs.

     Arnd
