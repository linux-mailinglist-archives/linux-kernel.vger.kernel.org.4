Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C88C6E990B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjDTQEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjDTQEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:04:30 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA9040EF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:04:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 03449320090A;
        Thu, 20 Apr 2023 12:04:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 20 Apr 2023 12:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1682006665; x=
        1682093065; bh=WnqW5lTsFmOJoys1Yjhzu2IcedZK/KQuMl4HGgkfhP8=; b=j
        MBtxGeYDg+UMn9mJmBHmd64W8PKfgu/LIFXt62pel8zLPOc05U+22AxD+X5X6KnX
        kBGGskqepP9QFkNr7mqaqe941VwSUc4idN4aFOj1TcOtlKyl+nZjlOctLPAo4Ja6
        B9mnQooFKF/3nXh+0m4wyNZhx4+tnHyRz5/HK5osgav6CqBBLTC2ymo0HE2+1EK4
        d9PWoHgfGpRtyqgnYwQywFpbCzazV9NXFjSSBNqCI4rt8zsDJOgxVgx/uEArulb9
        gNOc0NyVBQ1P2Y9kP0BoFMy0RZKRgiBgGNNlTTzXi4BRnmZNB0dBbbGxVI/2qQgi
        yQV4PSXIUZSSgh0dmdIJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682006665; x=1682093065; bh=WnqW5lTsFmOJo
        ys1Yjhzu2IcedZK/KQuMl4HGgkfhP8=; b=amVXc/ua87R0bB/6BxRHBl1JwcL95
        d/6vAATBNJxTWwa/m1BxU/eKdRrLOTPQ+0VRvs7jTNW6Jje1BZX/sCfBM3+rryMS
        hV5g3/ctW0JkVJJAa0Yo/cUGN/G84tRi3RdU6zZxJ929SPfca6VXufL0FuIzpCp1
        wX/4SeVLR0afzUZAUKdRgKS63HLjQ/FipwqypU7lm6BuOIrJOOJhgIxQxyHdsNhL
        j6bAPXaYdOnpkCa2l5lE4NypHZc0TPmbB63YljxZgT+dlsat2BSKF/ON7Q62kKsu
        0J/qHE5cWUOuKE5wZDR8llnZgA9E1uSGiVS2R/0TLsku6Y1hF0dufmimQ==
X-ME-Sender: <xms:iGJBZE_ryf6SvFLyMXxA7rhXRl2VCh69FFRejz3z6tPSj6eYKg1n6w>
    <xme:iGJBZMtGLJwIIfAT3mgz25_SqUwQmGF0H-7c1C0KwK4b8bqWWsTd1nwmoKnxZGEYW
    1cZhENhsjoOB8voxSE>
X-ME-Received: <xmr:iGJBZKDe-Iq3L3cTj0tNv7ma0ORBbOq0eVglspzGwFp-KKYuEdarqdQoa7iZBSkE_oUnM9-buk2VWVkOlhdRkxBWb8CF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtvddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:iGJBZEf2XQTK03ZAlA0nU5ph50UWiAcfgJKoa7nitGlJEv8-iIqQ6A>
    <xmx:iGJBZJNq_R4E4zJyXZEVGr9LNV78sZ1cCivM00B8da1s1P4nRaL-_A>
    <xmx:iGJBZOkOERo4lJBePr8r0Q0PCZaDtE_E1-Lshax0C5XcruEq1eZKPQ>
    <xmx:iWJBZKoIy7hkhJXjvBc-o72Ki26OxCJXvaQrsPrKN7P7HanWXMfdNw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Apr 2023 12:04:22 -0400 (EDT)
Date:   Fri, 21 Apr 2023 01:04:19 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] firewire: init_ohci1394_dma: use correct function
 names in comments
Message-ID: <20230420160419.GC33275@workstation>
Mail-Followup-To: Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230410011306.26268-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410011306.26268-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2023 at 06:13:06PM -0700, Randy Dunlap wrote:
> Prevent kernel-doc complaints by using the correct function names in
> kernel-doc comments:
> 
> drivers/firewire/init_ohci1394_dma.c:258: warning: expecting prototype for debug_init_ohci1394_dma(). Prototype was for init_ohci1394_dma_on_all_controllers() instead
> drivers/firewire/init_ohci1394_dma.c:289: warning: expecting prototype for setup_init_ohci1394_early(). Prototype was for setup_ohci1394_dma() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Cc: linux1394-devel@lists.sourceforge.net
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
> v2: rebase/resend, add note to Andrew
> v3: add Takashi-san
> 
>  drivers/firewire/init_ohci1394_dma.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The patch is applied to for-next branch for v6.4 kernel:

* https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git/

You can see the patch in linux-next integration as well.


Thanks for your patience

Takashi Sakamoto

