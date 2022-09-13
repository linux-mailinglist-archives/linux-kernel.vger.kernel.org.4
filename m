Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD395B7613
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiIMQFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbiIMQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:04:45 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F29697ED4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:00:59 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id E75862B059BE;
        Tue, 13 Sep 2022 10:59:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 13 Sep 2022 10:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663081190; x=1663084790; bh=6WDVl+FxeN
        DCcpynjpOQNvlmq++3+t9EkUarQBFJbEg=; b=dyQyV+88NtFBn91R8cEh1EA7Jb
        dZi/IJx3lavBUXHvadO9QHL3OgKi+Va2Qf3D081GvS60G7MbDJCUFiQvEVDOS352
        pILLLnnMapMZ0xFIA0EOJc+nM5GzvOVemArYdrkgaa+scfZRanMu6XimPZyfOvrF
        u+3f62NN2/xiOQ/Tt23JXEC3dii8lfZdnyZ2oOrxZDpQ4T2iTRERydY8218Wp+TS
        7MpLEtTMSBMOitYi7ZyeAbInO4bsvpN1dn0S8Xm5Innb8B4On5Pts6n7mAoj6C/5
        HnqocnuUvTt4MxY/kmzfn5pxxNPgC6x1w2IfUo+GAeoNAKmO4HMXvGQ8Xx7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663081190; x=1663084790; bh=6WDVl+FxeNDCcpynjpOQNvlmq++3
        +t9EkUarQBFJbEg=; b=T0oWltYnjvCzxlO4eXzmefuYUZUgd08phr1TMP/YIJJY
        F/6/UvYTTmPnOYM2I3xELnOaRscmMis4SXLKfza7Mf7nVa/vRhsWjtdIzRLFjtym
        owEAN5XD3c3+SmRwab2gppq7Rq7deA01qnFOPxMoFgFBaXfqMQfu2oWzvqom1ja8
        KKhYVkx4V+75XJSuZKcrtx8fZsIbTbwK7Eoki/a8+L+pMuMdzBmrDnpSI57dCngj
        nFVoiC8Y0PjJj4KUUw/TN17Mnpc5Rlue5HDye0be7GyUAbJ4T1HEYenn8WunZBXe
        ZXaECj1xj0safDu8m3uJ0VgqMLzQNNnU4XayJAFHNA==
X-ME-Sender: <xms:5ZogYxF-5kCAYO1nHfjMNT2MHcBqEuJTVt2v-sM8V4lQGaxc-vnIPw>
    <xme:5ZogY2UPCfXeMDgixhdlX644hmv5mQX_FuGPiPi_pns2t5g7sEqfacqt2zPac78JM
    lEzLe45IdqHeOJV24E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedugedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:5ZogYzKkLDdFe1aet4RnjftiOh5VSKyAXxFMIkQmMx-wRcZ8TJaR5A>
    <xmx:5ZogY3FBgpjbfKZKmdcdLtkSVd5BuoHNQMaeLu0v1-mHye5X3fzKFQ>
    <xmx:5ZogY3UnsYTzlkChIbG_Osgc_XcCgEXryG2aqkiJWiOEvfc4ccFF8w>
    <xmx:5pogYySOuq-jx5l_MO56rIsQXRnj5jZsWtB_lOIszIKZw0g3y-CvkU5xN5Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8B601B60086; Tue, 13 Sep 2022 10:59:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-934-g6274855a4c-fm-20220913.002-g6274855a
Mime-Version: 1.0
Message-Id: <a8a9fd74-4ee5-4619-8492-be7139e6d48e@www.fastmail.com>
In-Reply-To: <20220913052020.GA85241@ubuntu>
References: <20220913052020.GA85241@ubuntu>
Date:   Tue, 13 Sep 2022 16:59:29 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Hyunwoo Kim" <imv4bel@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        "Paul Fulghum" <paulkf@microgate.com>
Subject: Re: [PATCH] pcmcia: synclink_cs: Fix use-after-free in mgslpc_ioctl()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022, at 7:20 AM, Hyunwoo Kim wrote:
> A race condition may occur if the user physically removes
> the pcmcia device while calling ioctl() for this tty device node.
>
> This is a race condition between the mgslpc_ioctl() function and
> the mgslpc_detach() function, which may eventually result in UAF.
>
> So, add a refcount check to mgslpc_detach() to free the structure
> after the tty device node is close()d.
>
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

I think both your analysis and your patch are correct.

You might want to spell out use-after-free in the changelog
text, especially if you have a tool that finds more of these.
 
> I think I've probably found a race-condition-to-UAF vulnerability in
> drivers/char/pcmcia/synclink_cs.c.
> However, this device driver is a pcmcia_driver based driver.
> I haven't been able to get this old pcmcia adapter/device.
>
> If you don't mind, I'd like to ask the Linux kernel community to test if
> this vulnerability actually triggers.

Adding Paul Fulghum as the original driver author and Dominik
Brodowski as the PCMCIA maintainer to Cc, if anyone still has
the hardware, it would be one of them.
https://lore.kernel.org/lkml/20220913052020.GA85241@ubuntu/
has the full email for reference.

Even if nobody has the hardware, we could just apply the patch
anyway. Alternatively, we could take a pass at removing most
of the pcmcia_driver instances from the kernel including this
one. Dominik has previously brought up phasing out the
16-bit PCMCIA support altogether at some point, and we may
as well start by removing the ones that have no apparent users
any more, at least that might avoid spending much time on
fixing bugs that nobody cares about.

I'm fairly sure the embedded users mostly care about CF storage
cards, which is the one driver that definitely has to stay.
Most other pcmcia drivers predate the git history, though there
are a few that were only added in the past decade, these would
be the most likely to still be in use:

v5.2-rc1-82-g8674a8aa2c39 scsi: fdomain: Add PCMCIA support
v4.9-rc3-54-gf2ed287bcc90 char/pcmcia: add scr24x_cs chip card interface driver
v3.3-rc5-882-g2b61972b7421 can: sja1000: add support for PEAK-System PCMCIA card
v3.1-rc7-1048-gfd734c6f25ae can/sja1000: add driver for EMS PCMCIA card
v2.6.37-3908-g0a0b7a5f7a04 can: add driver for Softing card

   Arnd
