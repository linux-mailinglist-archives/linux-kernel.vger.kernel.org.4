Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A64720DC8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 06:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjFCE0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 00:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjFCEZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 00:25:13 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DA8135
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 21:25:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 79B8732005BC;
        Sat,  3 Jun 2023 00:25:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 03 Jun 2023 00:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685766309; x=
        1685852709; bh=SG6SzE6G37+beV/GsQpq/96obshNRyq9IKpQsfb/sD4=; b=n
        0KInLtzJGZ90RTdTAYWN79/u2fuBDgk4hEblVWKk3liHhIKZIEFNKxsohIUpwKEg
        mPdBLFsGPDoXXsNm2BMS/25pgieOz6naAvkcM6lX7eShdY7D4IXDzfOmJfbg180F
        OPbNmc0aB+vK4INx0FP17mFmqQhGoQXEP2u7flr0zWqgxWqOYSwcdvYGMqGBSJqq
        IgwG5OE5k7IKQud2zUcCMG6BgS5nqp96YMOpH3rt4u+vvkq97Sl6DaQefidnqne8
        xHpBDXlhLB2QqSKeVcLPcc+g9qhE5cHnEtRJLJAHujV6fNid9jdPhrKM1evINSC6
        XP67aMhZlxMV0w6v1cnWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685766309; x=1685852709; bh=SG6SzE6G37+be
        V/GsQpq/96obshNRyq9IKpQsfb/sD4=; b=OYbKQrUUSy15d12jhfvySax+weEw9
        vSrBozxobEDm0i2H5GlL07+KgFSfKyYWJA39AG+MTLPbpqfE2eAc0oVVyHXYzdeJ
        0GLhAElWAeXX6Q1XlSIXjraEn1ESnzP6BGGIZgVsR3J9c6ExDHhAAZQH7Vfr01J+
        FbIzqLppj14KBAho3dPzwqgxvhOl799SYQOKnqJC79C/V1EMZm17FBvnDHECPZ2c
        TSbmPbgS3quEgIQziOx5gkdGdOQAtVxeQP7eP1bknTfRCQoUHOd03aZRQSIJr1Aj
        RiU78X0KE08kP48BXeBdVt3CFcDeFFHpzCppDkjObJYMWpzyYV6dW0H5g==
X-ME-Sender: <xms:pMB6ZOCj2qIpotdIPiNKI4dvIrbyist-Qmb9652vS57aNknzcU_2-A>
    <xme:pMB6ZIgiyWDs7hzEws5tUP0cfCdlkWw1vhffGhyNFK63mURRLqDnO6xop4ghu3uSI
    pmvjROgdNoQ_45_ZCw>
X-ME-Received: <xmr:pMB6ZBk8aqd2K7m7HiNHE9b1UxqYbkFQBAf2qwljRIi-2RRP4cLN1rWNpPsEfIc3Pk8RrWpTONqgDmVNZAWtXlpt66PEBQ_7EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelgedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:pMB6ZMx4KRSjHtFCMGm8QRWRUYX7GnTMauimwa2iLXwD2hwH7VD46Q>
    <xmx:pMB6ZDR7g1iw8umgiuobRjoBfsKMObFWAzny35Rxc6nBMajaUaYDHQ>
    <xmx:pMB6ZHbJgv1_4HR5-U0kGkclt6U-X7_syW-pzJwCFND4CuM7B6rZZA>
    <xmx:pcB6ZOc6x-lPsgfGR0AZ9-NPKAi0ztCFyxs6VPafJvdkdxzUfP1qOQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jun 2023 00:25:07 -0400 (EDT)
Date:   Sat, 3 Jun 2023 13:25:04 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] firewire: fix warnings to generate UAPI documentation
Message-ID: <20230603042504.GA135015@workstation.local>
Mail-Followup-To: Randy Dunlap <rdunlap@infradead.org>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230601144937.121179-1-o-takashi@sakamocchi.jp>
 <c9770ddc-d1fe-d49f-adec-a413a7bf65ec@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9770ddc-d1fe-d49f-adec-a413a7bf65ec@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Thu, Jun 01, 2023 at 01:23:27PM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 6/1/23 07:49, Takashi Sakamoto wrote:
> > Any target to generate UAPI documentation reports warnings to missing
> > annotation for padding member in structures added recently.
> > 
> > This commit suppresses the warnings.
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Closes: https://lore.kernel.org/lkml/20230531135306.43613a59@canb.auug.org.au/
> > Fixes: 7c22d4a92bb2 ("firewire: cdev: add new event to notify request subaction with time stamp")
> > Fixes: fc2b52cf2e0e ("firewire: cdev: add new event to notify response subaction with time stamp")
> > Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> > ---
> >  include/uapi/linux/firewire-cdev.h | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> 
> You can do it as this patch shows, or you can hide those padding fields as
> described in Documentation/doc-guide/kernel-doc.rst:
> 
> Inside a struct or union description, you can use the ``private:`` and
> ``public:`` comment tags. Structure fields that are inside a ``private:``
> area are not listed in the generated output documentation.
> 
> The ``private:`` and ``public:`` tags must begin immediately following a
> ``/*`` comment marker. They may optionally include comments between the
> ``:`` and the ending ``*/`` marker.
> 
> See below.
> (snip) 

Thanks for your review and suggestion. Indeed, the private/public
annotation is one of our options and I have realized it.

I think it my preference to reduce load when reading structure layout.
The usage of private/public requires readers' brain to switch context
of access modifier. I guess that I would like to avoid such load if I were
the reader.

If the structure definition includes many annotations, it also increases
such load. In my experience, it is likely that annotation in structure
definition does not necessarily include enough information about the
member itself, especially when writing applications. I think it my
preference as well that member annotation of structure is in document,
(but it would be case-by-case.) It seems to be explicit way, vaguely.

Anyway thanks for your comment. It is fun to me;)


Takashi Sakamoto
