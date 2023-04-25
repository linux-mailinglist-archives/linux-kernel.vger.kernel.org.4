Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ABC6EE9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 23:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbjDYVvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 17:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjDYVvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 17:51:13 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6026BB8D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 14:51:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E61D5C00E9;
        Tue, 25 Apr 2023 17:51:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 25 Apr 2023 17:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682459472; x=1682545872; bh=Q0
        nzMIL9J1DjTJF8V79wook06vhKzjXIK3anlxaXiXI=; b=GDc/RoLbFkvoGPSQ/W
        66mNY5lY/V8N2mlX4mu2RY70HKCIw3N0cMQ1igucTzc5f1APepurvZVv8ZYt5q73
        JgckPPR55SSc+Mufqt9N/FjppjNVa53k3oQ3w7ef5KGB6sOmt6GVCOpBFwfcFII9
        WHgXlQD0L2hnrAVUkk8wuIM68SCeMR3FwcMl/DWA4aeLxjayFI+S1ttYAHYysJUc
        CD5Bs7Xh+hCYtyVsDEf8pKO5AIfitxipBCCBrMH/ryKem5Nzm1tjuFTw5scnHwlQ
        s8Wq3Yz03HrcjK0qUlBv9R/VKMkLAaBUj0dXvrklYcUz7gO/liuUghVTafxE+XCi
        YWqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682459472; x=1682545872; bh=Q0nzMIL9J1DjT
        JF8V79wook06vhKzjXIK3anlxaXiXI=; b=gpkQP/jnCLnfQxEw6FZDtXIgDg44u
        vaCFTAaaU7DL2eO2s/jeUHAJT3/a1P+D0bqToERzdYxAKBJLdAh97uOu6TgumrU8
        OqCFWUk8/XdQntCzRUffc/X78i8pFbI37SL9W6NhHeZ2LjUWBIiJOJTYJy7aIoa3
        IaiA9iSjXtJ755RZSesJWIHSrtTKMXf5iisoEwmy31l81E+YRUb2lf25Q3MH5GxI
        5nLeIpN3r8F7NrzLDV+N+NnUuucyO1Ym4dIJL005dU8V00oFcPwVM5QbMsVInQ6I
        cw2xJMky+LGkr4/XbDOQTqouwN2TrTN6OT3UVBdZA+7sk2DeX3Sbt9Jgw==
X-ME-Sender: <xms:T0tIZFd9XPiudzm9JBWtyudS6BgsW4gTZfAHZRyS9aLruiluNPetxQ>
    <xme:T0tIZDOkJx5x4XOuuZKWaJUXd9GRXmPjQHEOUePFdNV0w9C80TEB3gqxd3mvbtpyV
    funLVSTmyymz24E6z4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedufedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:T0tIZOgTywTE2HYtYawAsA6Ep34aJk854FQbnycGbdMVVtsAw8yXgA>
    <xmx:T0tIZO9VHU3LaUfV-bUIvo-KIwJLTt0h8DjuKv1YtyJLSEtNY7mS9Q>
    <xmx:T0tIZBsVSucz5PzrAm0gQmITHSRlW0uRPmzaljWOuuY-ywGxFRR1Og>
    <xmx:UEtIZK6KWmJDQVbo29Gmro4IjCVj-rHCKKDwGhkkyu-GRIU-h0K8og>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A5E55B60086; Tue, 25 Apr 2023 17:51:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <a8840c41-6245-4531-8b23-5c4e594c1ca9@app.fastmail.com>
In-Reply-To: <20230425152720.GA4155584@angband.pl>
References: <20230423135124.55196-1-kilobyte@angband.pl>
 <MN2PR11MB409305D13E46C371321AC2F0E5649@MN2PR11MB4093.namprd11.prod.outlook.com>
 <20230425115210.GA4151911@angband.pl>
 <2023042502-resolute-divisible-fbff@gregkh>
 <20230425152720.GA4155584@angband.pl>
Date:   Tue, 25 Apr 2023 22:51:01 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Adam Borowski" <kilobyte@angband.pl>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
Subject: Re: [PATCH] mei: make hdcp and pxp depend on X86 && PCI
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023, at 16:27, Adam Borowski wrote:
> On Tue, Apr 25, 2023 at 03:40:10PM +0200, Greg Kroah-Hartman wrote:
>> On Tue, Apr 25, 2023 at 01:52:10PM +0200, Adam Borowski wrote:
>> > On Tue, Apr 25, 2023 at 04:39:23AM +0000, Winkler, Tomas wrote:
>> > > What is the exact issue you are experiencing, can you add the error message this fixes? 
>> > 
>> > The problem doesn't trigger in mainline
>> 
>> Then it's nothing we need to worry about in mainline.  If/when other
>> changes ever happen to need it here in mainline, we will gladly take the
>> change.
>> 
>> For obvious reasons, we can't take patches for issues outside of our
>> codebase.  Nor do you want us to, as that way lies madness and an
>> unmaintainable mess.
>
> The problem in mainline is inconsistency: out of 6 config items, 4 repeat
> the "depends on X86 && PCI" line, the other 2 do not.  There's indeed no
> immediate functional issue, but I'd argue that a dormant bug is still a bug.
>
> So we can fix the cosmetic (currently) issue on its own, or as part of the
> large patchset -- the latter having a side effect of stuffing your mailboxes
> more than needed (neither Greg, Arnd, nor Tomas are involved in other bits).
>
> But do the selects really require so much duplication?  Perhaps I'm trying
> to fix the underlying issue wrong? 

I think something along these lines would do (untested):

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index d21486d69df2..8e5d79cff80b 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
-config INTEL_MEI
+menuconfig INTEL_MEI
        tristate "Intel Management Engine Interface"
        depends on X86 && PCI
        help
@@ -13,8 +13,6 @@ config INTEL_MEI
 
 config INTEL_MEI_ME
        tristate "ME Enabled Intel Chipsets"
-       select INTEL_MEI
-       depends on X86 && PCI
        help
          MEI support for ME Enabled Intel chipsets.
 
@@ -38,8 +36,6 @@ config INTEL_MEI_ME
 
 config INTEL_MEI_TXE
        tristate "Intel Trusted Execution Environment with ME Interface"
-       select INTEL_MEI
-       depends on X86 && PCI
        help
          MEI Support for Trusted Execution Environment device on Intel SoCs
 
@@ -48,9 +44,7 @@ config INTEL_MEI_TXE
 
 config INTEL_MEI_GSC
        tristate "Intel MEI GSC embedded device"
-       depends on INTEL_MEI
        depends on INTEL_MEI_ME
-       depends on X86 && PCI
        depends on DRM_I915
        help
          Intel auxiliary driver for GSC devices embedded in Intel graphics devices.
@@ -63,3 +57,4 @@ config INTEL_MEI_GSC
 source "drivers/misc/mei/hdcp/Kconfig"
 source "drivers/misc/mei/pxp/Kconfig"
 
+endmenu
