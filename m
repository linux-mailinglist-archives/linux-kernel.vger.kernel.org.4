Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5F16C9F23
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjC0JP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjC0JPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:15:24 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477AF3C26;
        Mon, 27 Mar 2023 02:15:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E602D5C00FE;
        Mon, 27 Mar 2023 05:15:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 27 Mar 2023 05:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679908520; x=1679994920; bh=A5
        +gI2srvfn+f8eE2nwKRdqo4mc6G9sjufQGQbcwNyg=; b=aXkRMHccd8a4geZ+52
        uwp9RwQecgEi3YJNVgKAQ+ZqZyt4Y2dAVO2gdQunyAGOPra/SG5mU0XkziDtZJay
        VKAK4oMU7QQ27FHnmCpEkLRnsYbCi56S0ORgv3zejaQjAPrP71SGhq0kXH43ovCR
        l+wHsqbP3+flivnMycP7t56gsJKFc2jMUG+rHdT+K3Nlb0v0gU3lObSvaxFJLO6+
        TEDT8REeOTTbVifNqqkIpyQTckwg8r7oXwfN+MxIunr7mncxCRdI+HuWr7Lkm6Kn
        ahdgbnUgOrFIXc2G5iJ7lKf+10an8VR8AMRxRm7C7sjKYqlrFHzRUzXJBUsZP56V
        Yojg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679908520; x=1679994920; bh=A5+gI2srvfn+f
        8eE2nwKRdqo4mc6G9sjufQGQbcwNyg=; b=CMiPOPKE7dMI3gBff9OWxR9YwKMrk
        AVvjTC2iDWQppJUw/3VTompsO19d8EmtSxPwMeJ+vF0bqS6k4/AJJDOL/+kMqL4t
        r1lsAl+O+0Alp2P8lKU8jZPiIkE7UH/y/gQ06Z+YYInlkdl9d2gd+8M+lDukZTr8
        KGF8Az1v197Twkb3PsBiN1E2U7V2xFBtnPgoiSbERcapCdK07ZE0zA8zg3HjUd11
        xPnasqVVLo1JX+N8uW9FLJCmSA+hXZp8u1ERm4Znnw7njsMTyi78PqrWo2tzcaTY
        noThQoYVa0G80lVKvUCVgyMxOlPD9SpD1y6HYSv+B5/MMsiW2Yo2Dq0Jg==
X-ME-Sender: <xms:qF4hZL8qs4JNn2r7UeRwkjWyMnRfg-HWYDfdN9tKr3ooSDl0RGxGaw>
    <xme:qF4hZHvpuvBEUPcCbnDTWuRoKzfOSPqmoox9ps5PGbrLfeYXBHGoh2EzSlTur3tAA
    NuM5zLzFQ_iDA>
X-ME-Received: <xmr:qF4hZJBDHkze57I9_RU04Dz45sRxI1ruco1MSJ5kYx4GEYbG7quMTqdSsCyhLGT6_HPLB6FkAoCDw-P5MD_mr_cI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:qF4hZHeQOQcAHiJN-hsOKvbtxbGOhWWliYvq8XnpHNMOY-tdf5QyWA>
    <xmx:qF4hZAMxRWcPNlGml6sIH40E55ZykBemkiHuGLM6J4oJK7iDoUGN6w>
    <xmx:qF4hZJksKWzyAiZJOQ_bAO2E7eiZnM_zvHABP1tzDxeBcasmb8qFTw>
    <xmx:qF4hZMmFNQRKONQoa9llhLlr4X1_HTa6AUyN0PCrcAa3C4A0NusMuQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 05:15:19 -0400 (EDT)
Date:   Mon, 27 Mar 2023 11:15:16 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <ZCFepL_u27Dxq9jd@kroah.com>
References: <20230327154655.58dd627d@canb.auug.org.au>
 <ZCFG1hUpsoB9acpi@kroah.com>
 <20230327192215.060fd858@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327192215.060fd858@canb.auug.org.au>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 07:22:15PM +1100, Stephen Rothwell wrote:
> Hi All,
> 
> On Mon, 27 Mar 2023 09:33:42 +0200 Greg KH <greg@kroah.com> wrote:
> >
> > Patch is correct, thank you.
> 
> Thanks for checking.
> 
> > s390 developers, if you have a persistent tag/branch, I can suck this
> > into the driver core tree and apply this fixup there so that you don't
> > have to deal with any merge issues for 6.4-rc1 if you want.  Or I can
> > provide one for you if you need/want that instead.  Or we can just leave
> > it alone and deal with it during the 6.4-rc1 merge window, your choice.
> 
> Or (it being pretty trivial) you could both just let Linus know when
> you send your merge requests ...

True, that works for me!
