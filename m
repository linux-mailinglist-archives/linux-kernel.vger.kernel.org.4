Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642DB7416C7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjF1QxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjF1QxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:53:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5656C19B9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=om+kWUo4HQwJaY7BR4O0yR+Zkf6CHrydbLfUPhhJQCo=; b=SVuJLw/IYiAyuVX50Uk/7jjKBY
        vOzrcE8pHF+2bzmPhNt+bFUnCf1aotZRJv2XVDc7HqI2/XSxsF5dlLlAnlsX/1WfMe3MTdxou5g+r
        Zuyi/eKIhwrvqgaTnEskqse61Q1yLFERwpUmgQ5bD+LQwtBpJWHidasXvR378ZyZMtpkpE1Mf+VCh
        Odh6x4+yivvDGMG/9p+FbWEGGDpzvsB9mP21sWUYBZWo7TAQwyHsC8R6Qh0PA8VvLwzD84dZyLUQM
        oVDcS4CO3Ayp/4LKihTTk935JTvAPY6yLGltHR/IZ8Xf6Y0T3kE0eMJOV+1jt1kg238hIkpCj7i4H
        2YbbHFLA==;
Received: from [54.239.6.184] (helo=freeip.amazon.com)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEYPi-0040eA-4Y; Wed, 28 Jun 2023 16:53:06 +0000
Message-ID: <3028b04b24936efcde760a3cd01844409962dc53.camel@infradead.org>
Subject: Re: [PATCH 0/1] User space notifications about VM cloning
From:   Amit Shah <amit@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Graf <graf@amazon.de>
Cc:     Babis Chalios <bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, mzxreary@0pointer.de,
        xmarcalx@amazon.co.uk, Amit Shah <amit@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Date:   Wed, 28 Jun 2023 18:53:02 +0200
In-Reply-To: <CAHmME9pxc-nO_xa=4+1CnvbnuefbRTJHxM7n817c_TPeoxzu_g@mail.gmail.com>
References: <20230531095119.11202-1-bchalios@amazon.es>
         <20f65557-766d-d954-f3ef-c26ad2b661dc@amazon.es>
         <6ccec434-42f0-0ae8-8c7b-bea4646c5e7d@amazon.de>
         <CAHmME9pxc-nO_xa=4+1CnvbnuefbRTJHxM7n817c_TPeoxzu_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-28 at 18:27 +0200, Jason A. Donenfeld wrote:
> Just so you guys know, roughly the order of operations here are going to =
be:
>=20
> - vdso vgetrandom v+1
> - virtio fork driver
> - exposing fork events to userspace
>=20
> I'll keep you posted on those.

Thank you!

One of the things I've struggled with is the lack of updates or
direction from Jason to Babis - he's had patches out for a while, and
Jason has said he's going to drive it, but we didn't see follow-ups.

At least this conversation has the signs of progress.

Thanks!

		Amit
