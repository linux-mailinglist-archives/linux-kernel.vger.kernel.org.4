Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12EB6A876B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCBQzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCBQzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:55:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCDB17CCE;
        Thu,  2 Mar 2023 08:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=AUBDDw7Nqbnm0w1FvorVxn1rzYs+CIAdfSAqMk4EzQ4=; b=R6yGvig9Ts9hZ9YwIX7jE+KDXP
        t31zY8KiwuOsRoiwpeGfE+OrMOFm4gTOnw4nyKd6TM3bSAhrlb1PLEjRa00eW8Kf1wdRRpZ8NQkhk
        a7rdnzajEhXBPW6gLQxVymspP49NBrj2KAVp5JPdx40sKNzrVmVNyUNDhTq1qi24PgcGc2iLUhkD8
        d5LRLYrUUx9JoX7ha8djnfD4E0CnW4f9f+hG4otHypje/2R55Oa4NlVa12HbSq2DZVdDXNK1U9sRB
        slhEZ8ACbxzjqLBPTT6w2i7xP56Pep5DYBsgQHZVPtgM82CQPCzpES7klG728dqqGq2vOYuwWEahF
        scVLpqEQ==;
Received: from [54.239.6.186] (helo=[192.168.10.135])
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXmDE-002WtU-Us; Thu, 02 Mar 2023 16:55:25 +0000
Message-ID: <65d872db2e1be29bb03b43ed606e7cc9e74ec08d.camel@infradead.org>
Subject: Re: [PATCH v2 0/2] [RFC] virtio-rng entropy leak reporting feature
From:   Amit Shah <amit@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Babis Chalios <bchalios@amazon.es>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        amit@kernel.org, graf@amazon.de, xmarcalx@amazon.co.uk
Date:   Thu, 02 Mar 2023 17:55:23 +0100
In-Reply-To: <Y9lBeymca9eFaJ33@zx2c4.com>
References: <20230131145543.86369-1-bchalios@amazon.es>
         <Y9lBeymca9eFaJ33@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey=C2=A0all,

On Tue, 2023-01-31 at 17:27 +0100, Jason A. Donenfeld wrote:
> You sent a v2, but I'm not back until the 11th to provide comments on
> v1. I still think this isn't the right direction, as this needs tie-ins
> to the rng to actually be useful. Please stop posting new versions of
> this for now, so that somebody doesn't accidentally merge it; that'd be
> a big mistake. I'll paste what I wrote you prior:

I sat down to review the patchset but looks like there's some
background I'm not aware of.

It looks like Babis has implemented the guest side here according to
the spec change that Michael has posted.

Jason, do you have an alternative in mind?  In that case, we should
pick this up in the spec update thread instead.

Somehow it feels like I don't have the complete story for this feature
set, having missed the discussion during LPC.

	Amit
