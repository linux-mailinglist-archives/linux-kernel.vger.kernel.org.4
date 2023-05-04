Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278056F64F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjEDG2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjEDG2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:28:35 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44224E65
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:28:34 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9967B5C0195;
        Thu,  4 May 2023 02:28:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 04 May 2023 02:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1683181711; x=
        1683268111; bh=nTHXfZvsKH6NImQKdo/JKzYWy+5g9P8ww+u3FrTSJDk=; b=I
        jXgf9/jm5NzTWuGXad1eJ5T5bthKlUf/yVG2RTGHmQPa056XIB66TQqL8cU92wXg
        gfQm/K+x3Rg8iVx+RUBMawjqwveR8owUiOCMOiPVmCW1FqSQYjrBHB4wlg49l5/M
        i5eDkJGKVQ2pd72NCjnooIwOL0StargaYU63IKOUBLa+jT8uI0yzU58xD/nledTf
        tT0Acrfzkh8SjA7SS0S9UtaKc0uPxnWxbjV58svEBOxPLOYzu1ObWCZeY3TgkDvf
        Alp7M7Q5oJGxc+dpy31TEbmVGNPaE8rVNmLxQ4FvIRIEJ2a8Hj5DP6DXuOAL+ouJ
        QFdZUwAsc4glvn0bYSDIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683181711; x=1683268111; bh=nTHXfZvsKH6NI
        mQKdo/JKzYWy+5g9P8ww+u3FrTSJDk=; b=VCJMS6hFuG8G/ZmBGtXm++o+3HPSO
        TK1p6GGLtULE+zBeA9X6/erKexMYZjI4Dp95kKIu9+9tcUkWGvV8CbfPcyMgduey
        G/0k7kvHvDb69fdg7h2Qg8BQXSQl82bYawHLD6BGjblRSvCmFZ/kSaK943cvwcMU
        9KfC8bOd6wn4F4QyU6CwfJ4wKYhrLXF0cVsWTNPuQDG+ujQaaZ8pqAe+1Gn4ZUxh
        Xgc7asc9QbEGO3mX9Q3/YOTNH3eeVvvPaN0XSYasC1tlBhp5jJqvj4tillro7/fZ
        z4ABkRgC4yWRj0ogsP3YYGtSSKxQFOOd6pChfrJQkv5uP5JPydMTluPsg==
X-ME-Sender: <xms:jlBTZNLdW3OSyWTpJdMJBAeLwoO3CzFAvAbXZjieo0Ecb40UGYeflw>
    <xme:jlBTZJI69oijDerdwHjhc9d-PCmnfvgFyUmoEwvfhaMFPKxGKbYARwQEDk95u1stm
    w1JjIDqogaw24I7_Ec>
X-ME-Received: <xmr:jlBTZFt0bhvFFPSc9o37KRhFH7hDCm0ISr5tCUDWsXlYbqe1mlF5hHFrUeAjmuE4YYtbaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvledguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:jlBTZOa4WF05AgAWgwN_zDrBf754ZOPlEynEF2acEnA9dqfi1f4KlQ>
    <xmx:jlBTZEYiMZkyaZUvb2HM8Wxvp1PAeV84e6TwoL96bVfL1ERjcPVQ7g>
    <xmx:jlBTZCAYJSz4k_MmymHz5Yd_EUSpsOgi8K7WtXnbM-Wt-KHezCvcGw>
    <xmx:j1BTZDy1HbCca3z3eCA_Ylkrlbc5SBwxx-2ZpGM7w6zxOix55egN-Q>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 May 2023 02:28:30 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2AF5010CE5A; Thu,  4 May 2023 09:28:27 +0300 (+03)
Date:   Thu, 4 May 2023 09:28:27 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] x86/mm for 6.4
Message-ID: <20230504062827.algltnmlddtzmfz5@box.shutemov.name>
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
 <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name>
 <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
 <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com>
 <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
 <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com>
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

On Wed, May 03, 2023 at 09:38:03AM -0700, Linus Torvalds wrote:
> > Why does it do that "shift-by-63" game there, instead of making
> > tlbstate_untag_mask just have bit #63 always set?
> 
> And it turns out that bit #63 really _is_ always set, so I think the
> solution to this all is to remove the sign games in untag_addr()
> entirely.

Untagging kernel pointer with LAM enabled will land it in the canonical
hole which is safe as it leads to #GP on dereference.

> Untagging a kernel address will "corrupt" it, but it will stay a
> kernel address (well, it will stay a "high bit set" address), which is
> all we care about anyway.

The interesting case to consider is untagging kernel pointer when LAM_U48
is enabled (not part of current LAM enabling). LAM_U48 would make the
untagging mask wider -- ~GENMASK(62, 48). With 5-level paging and LAM_SUP
enabled (also not supported yet) untagging kernel may transform it to
other valid kernel pointer.

So we cannot rely on #GP as backstop here. The kernel has to exclude
kernel pointer by other means. It can be fun to debug.

Looks like you are not worried about this kind of corruption. Hm.

Maybe it worth to indicate in the helper name that it is intended only for
userspace addresses? Rename it to untagged_uaddr() or something?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
