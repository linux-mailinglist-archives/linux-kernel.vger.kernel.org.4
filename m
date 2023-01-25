Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3653B67B255
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjAYMIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjAYMIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:08:02 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700E31B8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:08:00 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 97B6A5C0176;
        Wed, 25 Jan 2023 07:07:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 25 Jan 2023 07:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1674648479; x=1674734879; bh=DF
        Ne9qYghXCug/YdqS/utMFk4bq0M24IOJ8OklWGuG8=; b=jrhR6Yg0brTuTCvdcJ
        F7v0psCXcOqVU1GBBdLGMR9oOEobP2kENS7BHME5pAiitRdUow68419BKzeSLfK3
        SUuD7BDuGVcy6Hg2hxOxhXVfDYXa/Arix3I0d89UP25DtRHpK24Y70wAtDpfFOZ+
        r1kZhoMk/2Ck6ggersrkyCrk9Qomd5gopztUek8hHSyF0zsITUvCIl2861fFOx2X
        reuoDTi1vzFZmomffGcYFE/e0ChskLB3jv9u0fgRVRDWw1hsZ5tca6rFsGOaCrAW
        +fGPmmfJB5NzHHfgfBg7Q+1tHcZC20inWNAJM21guYbqpIgV3L0IorsR/iPcxngp
        UXbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674648479; x=1674734879; bh=DFNe9qYghXCug/YdqS/utMFk4bq0
        M24IOJ8OklWGuG8=; b=Nh5CSV4qyllDh0XwusdKRvHn+YQ79vFCYShS/UPZ3CcJ
        mXmfuYzswj+in+Zve01+xkMg7joX+xw2V7a8ERFcg9gR1L58eN3+qm++TYFpxvLn
        oDnbQ/Jn+jaAAKXVYBJwEA/pzHlN1ZfwMZb/aK077j7qJ3o7bnqb5qz21wXavgGH
        TavNmMl9y8RD4tKxB/2nFf4lOAvnOf1QDtjwod3YcqpBTInyBxANBsksyXpapMwf
        d1kTDciS48wwBhWLmGaGq9rj12mr7iOEWVLpAbmaZ+vi8TRm2eKQ1WW16tzdYVtk
        iIaKo8DhhUT7Tn9c1YSNKki44U5QH6NvecuLWgX3rw==
X-ME-Sender: <xms:nxvRY-rcUyX_BiD3uRcBpIMHwSMffzEsvNPvIq2Rl_56br6mpnum2A>
    <xme:nxvRY8pn3RhiwgUrDnK64lPIa379hkArHhLAeVl2bji6hHIS23XiPgXNuxFXIsF7T
    GGueZbOv2Ft4jI_z24>
X-ME-Received: <xmr:nxvRYzMFHVOBSPeql0FfMeReTTNhMhGlvbWOp7lw72jfGB35_Nzui16Xjywt8bnACVihTLG3BNjvJdgEp5u6X8EcY7Aov-NHzn6X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:nxvRY9507r_LbQ3YVXioK4Upgm-h-AjOasZ1mtoC365C9sc74HCKiQ>
    <xmx:nxvRY976cnIVSPwQgx3BBNlZPYHIr-mm0-hvqrxklrVJj4lcv15mRw>
    <xmx:nxvRY9jg5lFDXM7rp8iGq6WeY9Kf3bP5mAuPn9J42XhE1VVXuJvqcA>
    <xmx:nxvRY3mJSYEYdGSmFvXGgbvF9xRDuYDjcdNBLDWCdXJXCWxcsJ-qfA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 07:07:57 -0500 (EST)
Date:   Wed, 25 Jan 2023 21:07:55 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     stefanr@s5r6.in-berlin.de, linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 0/3] firewire: use single object for user space listeners
 to dispatch request to IEC 61883-1 FCP region
Message-ID: <Y9Ebm7Yw9XT06Hx6@workstation>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, stefanr@s5r6.in-berlin.de,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20230120090344.296451-1-o-takashi@sakamocchi.jp>
 <873581r76s.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873581r76s.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 23, 2023 at 09:22:51AM +0100, Takashi Iwai wrote:
> On Fri, 20 Jan 2023 10:03:41 +0100,
> Takashi Sakamoto wrote:
> > 
> > Hi,
> > 
> > This patch solves long standing issue mentioned by code comment[1] and a
> > commit 281e20323ab7 ("firewire: core: fix use-after-free regression in FCP
> > handler")[2]. This patchset is based on the kernel tree to which another
> > fix is applied[3].
> > 
> > To Iwai-san, I would like to ask you picking them to your local
> > tree, then send them to mainline tree as well as sound patches when
> > the merge window is open for v6.3 kernel, unless any question and
> > objection is posted. (Additionally, I have prepared the other patchset for
> > the subsystem.)
> 
> As those are spontaneous small fixes, now I merged all three patches
> on topic/firewire branch (on top of the for-linus including your
> previous FireWire core fix), merged back to for-next branch for 6.3.

Thanks for your applying.

> But, I have no will to keep doing this in a long term.  I suppose the
> best would be that you'd step up as a maintainer for FireWire
> stack...

Indeed. The next patchset is beyond your courtesy. I posted it to LKML
with my concern. I'm pleased if you follow to it.

* https://lore.kernel.org/lkml/20230125120301.51585-1-o-takashi@sakamocchi.jp/

> thanks,
> 
> Takashi


Thanks

Takashi Sakamoto
