Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9365F470
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbjAET2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbjAET1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:27:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ABF1DF39
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:22:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6102C61BE9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 19:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEABC433EF;
        Thu,  5 Jan 2023 19:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672946551;
        bh=uDTXg//jnhC1cEEdsL2GkEsxKCTxHUqxIHNt0OO9yE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCCbo3FzMEXkDFGFnYfnDDzLZ2JFrFAcSAU5KhvphE6lzY3VGW4zqsaSRlWz/gs0E
         4ermUfHut3e0bY+f0oSVUdCOyJyTLGXHBMCGJ4ZmVTX0Sx2XPlg7XgtOhhNoQtJSx8
         had1pOOj0dn0xd8Iwcs8147tDGvJ+DP+0PhmPpQuBO3IEj9aSTbudnxp8BWV2y5QSx
         N5767wSwH4I8qQoFzvvpA0VAuEpMPhWK+03nJ5yLgvHtNwe4VHi0ZsBRFDd1JrslBR
         Rmxt+gueiXY3IIwjz40kCnoRexNedJdLoux8Ga26G5eHG36Yp3TWg+MQmF45mGLNVJ
         Fin45YqXZkl0Q==
Received: by pali.im (Postfix)
        id 8A088AC9; Thu,  5 Jan 2023 20:22:28 +0100 (CET)
Date:   Thu, 5 Jan 2023 20:22:28 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.2-rc1
Message-ID: <20230105192228.flyoihnts32dgi5t@pali>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20230104190115.ceglfefco475ev6c@pali>
 <CAHk-=wh1x-gbmE72xBPcEnchvmPn=13mU--+7Cfay0dNHCxxuw@mail.gmail.com>
 <20230104205640.o2uy2jk4v6yfm4w3@pali>
 <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
 <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk>
 <20230105174210.jbjoqelllcrd57q6@pali>
 <58d3649f-3c8c-8b12-1930-f06f59837ad5@kernel.dk>
 <CAHk-=wiKUWm3VoYHK-oKixc9nF5Qdwp598MPSoh=jdxKAU1bOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiKUWm3VoYHK-oKixc9nF5Qdwp598MPSoh=jdxKAU1bOw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2023 11:06:21 Linus Torvalds wrote:
> > As mentioned, I don't think this kind of code belongs in the kernel. sr
> > or cdrom could easily be modified to support the necessary bits to
> > handle a writeable open, but the grunt of the pktcdvd code deals with
> > retrieving and writing out bigger chunks of data. And that part really
> > does belong in userspace imho.
> 
> Well, it's the UDF write support that is the issue.. I didn't even
> realize people did that.
> 
> You'd presumably have to re-do it as a FUSE thing.

It is not UDF / filesystem specific stuff. You can use any other
filesystem which you like, for example ext4. And in past some people
really used ext2 on CD-RWs. And on Windows systems before Vista, only
FAT32 was supported in read-write mode on CD-RW. UDF even on CD-RW was
read-only.

So FUSE here really does not help. As we are talking about block
storage, not filesystem storage.
