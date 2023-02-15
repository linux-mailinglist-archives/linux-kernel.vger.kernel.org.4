Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657B6697F95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBOPgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBOPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:36:43 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C7EB74C;
        Wed, 15 Feb 2023 07:36:42 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 493365C00E5;
        Wed, 15 Feb 2023 10:36:42 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 15 Feb 2023 10:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676475402; x=1676561802; bh=/+AY5MLteh
        +gp5SxAJhrwrOn2f6ku5HUXyh4rA6eBwc=; b=B4niN/HdeJhRTsKOX5Gt/QrD1t
        L4LYFxQ7xSTd+c2T6GyN49pDP6/Z9r/bkxloz1cYLmnaX5wkGDKESu0KFHrNclyq
        7b+cVwII4lhtuTYazGg5JlI3FZUWKDPsvTpAti+W84LExh4YKhrEDDBNIz+6MoSZ
        Xs5Izc9h/dVV86hbn/r7yA6p2JOsL6E30VUJhEQjMcgdB/4DO1x2enRNtVDUIkJj
        EK7AGL/7bSN+3EARJ1yt4tTv8dVbzExvCvmmTWg/L42UrX8JOa1Jk1TkSl5/jilU
        vSxtj3c447ddd9ljQY/12PyZS4ghgRHlQdT2PgAF8iMU+Whp1Dor/WMYVdgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676475402; x=1676561802; bh=/+AY5MLteh+gp5SxAJhrwrOn2f6k
        u5HUXyh4rA6eBwc=; b=a/F1ttNEYCJeSoP4PCglZZ1+bGzoJqX7/cFEqxDgg3GD
        ln1cQtsB81i+asSclR8MOJNUjfsdcmgeScU/TL8sDnhLybsMxFiFmMSwo+J8d0d4
        1Y0FhChLPuhJ8zlm/driGHekt6xBQ4SeAgGfXvxxyssbQukMil0Fr9UAiPI9CRq6
        9enzkXAKN3167Qgzb+kFgo9DoyPcqsRIOmcpfGCTqDDiiQDfd4KVmKArJa4Mcz08
        yoYCrwd3fmH1aye1I1S5eJNw0LaoJPQVO1XkI8F3G1Da4Yx3PvcOnek0cgm3/R4o
        R8CqRnI5oyH6pKi/Vzokq12N5mtxbQ7OOE4kkxOplg==
X-ME-Sender: <xms:CfzsY0KOWZIH6xL5Eu3oMzzFYiuMMIGsCzcsYffzFOBPjNv9xiUP7A>
    <xme:CfzsY0L6vm6IQ3LKoS9zz4HBP2mtBuQ1jSkO-k7ny27z3br2nxMUb_D1KbwwKDFf_
    YbJfscY5G0Iegtx5uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:CfzsY0syYKSKSjD8nRLbt65DzAXQdOJjal6-3krmv0_BWvR32PhiCw>
    <xmx:CfzsYxY4LBbluJ_Z9vF1cTU61-ObUpbH-TPIYgOGTewjYDoHAkt6Jg>
    <xmx:CfzsY7Zpwy-lseS9YA0Bheasp5BB3cJ-9tckBlImWYtH6sJp6VR5LA>
    <xmx:CvzsY5NDfJ5CRzqtfvPdBOp-X485L_zWB1EMuql9896p7xleqciFuw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4F71BB60086; Wed, 15 Feb 2023 10:36:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <33201710-a18b-44a6-8e09-364f4a9ca5e5@app.fastmail.com>
In-Reply-To: <20230215151547.GA3766362@roeck-us.net>
References: <20230128122904.1345120-1-ardb@kernel.org>
 <20230215151547.GA3766362@roeck-us.net>
Date:   Wed, 15 Feb 2023 16:36:23 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        "Ard Biesheuvel" <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "Jonathan Corbet" <corbet@lwn.net>,
        "Tony Luck" <tony.luck@intel.com>,
        "Jessica Clarke" <jrtc27@jrtc27.com>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Marc Zyngier" <maz@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [RFC PATCH] MAINTAINERS: Mark Itanium/IA64 as 'dead'
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023, at 16:15, Guenter Roeck wrote:
> On Sat, Jan 28, 2023 at 01:29:04PM +0100, Ard Biesheuvel wrote:
>> Create a new status 'dead' which conveys that a subsystem is
>> unmaintained and scheduled for removal, and developers are free to
>> behave as if it's already gone. Also, automated build tests should
>> ignore such subsystems, or at least notify only those who are known to
>> have an interest in the subsystem in particular.
>> 
>> Given that Itanium/IA64 has no maintainer, is no longer supported in
>> QEMU (for boot testing under emulation) and does not seem to have a user
>> base beyond a couple of machines used by distros to churn out packages,
>> let's mark it as dead. This shall mean that any treewide changes (such
>> as changes to the EFI subsystem, which I maintain) can be made even if
>> they might cause build or boot time regressions on IA64 machines. Also,
>> mark the port as scheduled for removal after the next LTS release.
>> 
>
> Since this just came up, I very much prefer complete removal. I don't
> see the point of keeping dead code in the tree. That is still hidden
> maintenance effort.
>
> If this proliferates, we'll end up having to parse the MAINTAINERS file
> for code marked "Dead" to ensure that we don't accidentally send e-mails
> to the wrong people, or we risk getting complaints about sending reports
> for such code. That puts extra burden on maintainers of automated test
> beds, which I think is not really appropriate. If the code is dead,
> remove it, period.
>
> For my part, I'll drop my test bed support immediately after this patch
> made it in, following the guidance above.

I agree. While the idea of waiting for an LTS release makes sense
in general (and I did just that for the unused Arm board files), I
don't see how that would help with the timing here: The only remaining
distro with kernel updates is now Debian-ports, and the coming Bookwork
release will apparently use the 6.1-LTS kernel, but as I understand,
the mentioned (late-2023) LTS kernel will not be part either of the
following (mid-2025) Debian release or this one, so keeping it
for a year longer has all the extra cost without any real benefit.

      Arnd
