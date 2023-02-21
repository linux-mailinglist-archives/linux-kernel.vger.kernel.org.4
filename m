Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EC569D7AE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 01:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjBUArt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 19:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBUArr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 19:47:47 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025F71C7F1;
        Mon, 20 Feb 2023 16:47:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m7so3601026lfj.8;
        Mon, 20 Feb 2023 16:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YUYO8E9O6ODuJMvaLPRZa6MMp8VX9JxblM5j/UG0tI8=;
        b=f8ZIo8vNCNCQuOQ88sg7/nVSh6iZjpYt8b4J7ArdWqIzKGUeQT4JUHXTBMah7cvcq7
         iEpdop6Up/38Bi/GEtxaJ4HPsqGOIgl0L5Br0su3btk9uMxVYIN1Be2sXQ0Rf4ThqFS9
         K/9/czmjAsxFykTJLn6GQEnz57obC4l9Y2YJhFImzNOhvqkv8gA00n55WDafCvOvxi3s
         xIY+SRFCCsQbv1g0UKLqVBiX3qB5xHTu+DWXhBhC1V1+PoZ38GZX3rkJEn2RRTmH83ZC
         ADuXY75mcJT/R+nBr4BTOEZ5WaqIwlXh3iq5g9OrZzhAOCLcyYLf/0zcsYIn9tixizj+
         EIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUYO8E9O6ODuJMvaLPRZa6MMp8VX9JxblM5j/UG0tI8=;
        b=QIBgMzEghACYu3V2fZpZga0wn8Ch7xRbKVp6Xe8eDk1RWg79VERXqGi0v9N2xeClyl
         /mxV4v2kqdg4F0Gmj2zmr/9wWlFHKr2Cvt15v5j+30LQvC29HjGvx6cv6g6N42h+Dw0A
         RlNa9stMot3KiNGU+mW74XFbgSbBDknFLIiZ0GpQL/+Bv04vSBFGVJrWrAgK9Lll7qE8
         QFM9cfDOBEybbK79v7IW7OCE8bW25ImQq5jp0SB+FCMgzrVoXylREaQ7WSloYidx7L72
         sFox6gWZ66KiciqQUBd4gMKopSGIin57e79/Fi5cHg2qDFehS8uq1t4ErQXmjkW4BIh+
         zBlw==
X-Gm-Message-State: AO0yUKWGGLbAe8rzDCACPSBHLFvL1hfFkO4mVHDPssTUURVVMYxaJQiE
        8yramwZl7nN2p4qqUZDDiuv37YQDneTX2ujjx+3UuInMa8k=
X-Google-Smtp-Source: AK7set9hY4nprlqYsh+SRppL45xiTx/FRnmHRpvTiSSb44KajRfLchJpvPtkFWpqFBz30rYlLu25EaV26LNHs8QYYjc=
X-Received: by 2002:ac2:50da:0:b0:4db:2554:93a6 with SMTP id
 h26-20020ac250da000000b004db255493a6mr1104224lfm.10.1676940464179; Mon, 20
 Feb 2023 16:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20230220115056.22751cf6@canb.auug.org.au> <20230221113942.0d0ca13c@canb.auug.org.au>
In-Reply-To: <20230221113942.0d0ca13c@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 20 Feb 2023 18:47:33 -0600
Message-ID: <CAH2r5msX0HOjqHLmkpXOx0PQdjFAZgqeb22kHQ_F2RpUKBWG7A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the block tree with the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>, CIFS <linux-cifs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Paulo Alcantara <pc@cjr.nz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should I rebase my cifs for-next branch on Christoph's patch (now in
mainline) to make it easier to merge my branch later in the week?

       cifs: use bvec_set_page to initialize bvecs
         Use the bvec_set_page helper to initialize bvecs.
       Signed-off-by: Christoph Hellwig <hch@lst.de>

This would avoid merge conflicts in various of David Howell's patches
in my tree.

Thoughts?

On Mon, Feb 20, 2023 at 6:39 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Mon, 20 Feb 2023 11:50:56 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the block tree got a conflict in:
> >
> >   fs/cifs/smb2ops.c
> >
> > between commit:
> >
> >   8378eea2e41f ("cifs: Change the I/O paths to use an iterator rather than a page list")
> >
> > from the cifs tree and commit:
> >
> >   220ae4a5c2ba ("cifs: use bvec_set_page to initialize bvecs")
> >
> > from the block tree.
> >
> > I fixed it up (the former removed the code updated by the latter) and
> > can carry the fix as necessary. This is now fixed as far as linux-next
> > is concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflicting
> > tree to minimise any particularly complex conflicts.
>
> This is now a conflict between the cifs tree and Linus' tree.
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
