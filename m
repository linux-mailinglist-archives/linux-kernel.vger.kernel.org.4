Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1645B6162
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiILS7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiILS7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:59:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725122A2;
        Mon, 12 Sep 2022 11:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AB11B80C9E;
        Mon, 12 Sep 2022 18:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41B9C433D6;
        Mon, 12 Sep 2022 18:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663009165;
        bh=gQERToyoR+we9iRqhwVNNiPWNJQcfMSQCfh6JMvWehA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OysA/0QSAc+wDlSfnLT3hTbjjkIIyVhZOw6hKfR3FDTuqwFzNSj+4iJfSWIjy6p1L
         oze5uBTB7q8Ou9IbRcE7+qshsiQGLEaaiQ8fIpDoRo31DAeK2XdkTBsOue+X7vBU+y
         m0KAhs+SKFQDLlUu6p+IF1M+4cxnDwa3GGLUHIkE=
Date:   Mon, 12 Sep 2022 11:59:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Elliott <elliott@hpe.com>
Subject: Re: linux-next: manual merge of the mm tree with the crypto tree
Message-Id: <20220912115924.e04b9505994c3053232bbb8a@linux-foundation.org>
In-Reply-To: <CAG_fn=V1utoSbPK6Jhnzyy3Fj47k1YS1DZc5M094Bp1GpP5kFQ@mail.gmail.com>
References: <20220906202017.5093fd23@canb.auug.org.au>
        <YxfFzGObDWsylCK+@quark>
        <CAG_fn=UcWy+gbYLDM2WQZ=BZuVRML17KJ0L+=zsSg7+yDo4oGA@mail.gmail.com>
        <20220907134107.bcb8b9c22b9ae517e3b43711@linux-foundation.org>
        <CAG_fn=V1utoSbPK6Jhnzyy3Fj47k1YS1DZc5M094Bp1GpP5kFQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2022 11:37:56 +0200 Alexander Potapenko <glider@google.com> wrote:

> On Wed, Sep 7, 2022 at 10:41 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 7 Sep 2022 11:18:24 +0200 Alexander Potapenko <glider@google.com> wrote:
> >
> > > What's the best way to handle this? Send another patch series? Or
> > > maybe just an update for "crypto: kmsan: disable accelerated configs
> > > under KMSAN"?
> >
> > I'd prefer the minimal update, please.
> 
> As a heads-up, I mailed "x86: crypto: kmsan: revert !KMSAN
> dependencies" and "crypto: x86: kmsan: disable accelerated configs in
> KMSAN builds" last week. No rush though, guess you're busy with LPC
> this week.

oop.  sorry, things starting with "x86: " and "crypto: " tend to hit my
not-for-akpm brainfilter.  I have them now.

