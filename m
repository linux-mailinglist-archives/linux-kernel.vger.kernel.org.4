Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92C26C8483
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjCXSIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjCXSHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:07:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715D4271F;
        Fri, 24 Mar 2023 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wzvqTaj0sJDg6M/9ZjKpciY9FiONvjYfn1KEyYVkY0Y=; b=vbGGL4KNT9ISqGGPR25foYHUxA
        Uv+xyp+0ZB4y4P/10HX/N7IXUWCYObKQOy1K5RJ8qKejyL3gyaq6ArEauif6Bh9sMT/cZTKt1ZB1J
        5YmiZwdOl4k5tdyUcbBwbkEut5vRzJAe5NMl4T6lA+x1jXudimarhwxy4oidpBfcZkTIRCWrVzKjg
        3VZQsFnjo3jfIkoeZ5tTHApEY2+1M7BRuH949I6dgnCnpeUJG4rz5CQJz7rtko80vqUOMzeRVbsZn
        3MDo/q5jE8TLtuAVWtztTimqQW023fhZKBp4DeC6VLdPNbv8ZUqZkRRfEHDXoP3aF54X0azm4hzrc
        mvYsLgoQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfloZ-005Fm7-17;
        Fri, 24 Mar 2023 18:06:59 +0000
Date:   Fri, 24 Mar 2023 11:06:59 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
Message-ID: <ZB3mw4G8GdGwSP41@bombadil.infradead.org>
References: <20230302211759.30135-11-nick.alcock@oracle.com>
 <ZAoGLhRpTr5f7AD/@kroah.com>
 <ZApf0iNOsSAUbhMz@bombadil.infradead.org>
 <ZArc0ib697JIwKou@kroah.com>
 <ZAuGE2ay3q0MT4Yi@bombadil.infradead.org>
 <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
 <ZB1p5zRp7rlGGuCP@kroah.com>
 <CAMuHMdVRXQupFEoU0EbSkBnS21QXGJQ4ZOYVy-Ntwjnw7er0nA@mail.gmail.com>
 <87h6uamdzw.fsf@esperi.org.uk>
 <ZB2zrHSzmi8FXABI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB2zrHSzmi8FXABI@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 03:29:00PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 24, 2023 at 02:16:03PM +0000, Nick Alcock wrote:
> > On 24 Mar 2023, Geert Uytterhoeven uttered the following:
> > > I (still) agree with that, and I saw similar comments from others as well.
> > > Unfortunately these comments are spread across tens of threads :-(
> > 
> > Ugh. Should I do this sort of thing in one big commit next time? That
> > would fix that problem, but at the cost of others. Lumping seems to me
> > to be troublesome because it makes it harder to accept/reject different
> > bits, but would it be *as* troublesome as this much splitting?
> 
> The problem is, some of us disagree that this should be done at all, so
> reverting all of the individual parts is going to be hard now.
> 
> Please put back the license bits that you removed, as it is not a good
> idea to remove that if the file does not have a SPDX entry at the very
> least.

Nick, I've just dropped your series. Please only re-submit only for
files where the license is clear. The effort of clarifying licenses
on files where one doesn't have an SPDX tag is welcomed but can take
time and we'll need this anyway in the future to help later strive to
see if we can automatically generate the MODULE_LICENSE() from the
SPDX tags.

  Luis
