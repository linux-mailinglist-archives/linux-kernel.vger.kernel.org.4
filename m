Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2AF658C30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 12:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiL2Ldh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 06:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiL2Lde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 06:33:34 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A36E13DE4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 03:33:33 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id r18so12211296pgr.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 03:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qTVxiGDTHL6hg1UtFQZfca+oAw3eSFaWQe0kuo3tP9Q=;
        b=d65eMAGGk3tndOjyb0lT2sYt7tsemWRwoQqx4ooPMj0H+EA01kJ15xOPX4X+AmkZa/
         x9Jc69lBdrTWFxI1uCuMx7QrRByzMJxs4vkW69MwKe7d6/A7GMVx6JgswuJ/lM+zbQJG
         aUnWu1GZA+jNg+4USaM37ZlA/MpyZA+69zji0o/pKdvo1rtWlJhcuqco6ZB+96p5P3kK
         rSt46jw3rfyfiYC0XH1iE5csFT8LSp4zoc62xHezweFq4mk3ZZ1VeaoX5fbZ2OkEm+EM
         6/gLo0q3Cy1m2mETPNxJ9CTugIfAPAfTnvz8rwomFWgfek9q7jy/9/ID75afCbZ1nzql
         /xOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTVxiGDTHL6hg1UtFQZfca+oAw3eSFaWQe0kuo3tP9Q=;
        b=2bphoWlNKa8Kae7ZWK3kAzjFQ1wn1jJdMW+ZeyVzTKLf7rCvH9rOdfeKKyDpqNIUiy
         gV31noMoGuh1G4KN0AmPnJTDwUZpSpZipmmTSFhsRaA0p3HQ2J7NvsSypd4FyCfXXWeJ
         8gSp81Lh5iGp/baSaK+33vwUHG01ekYCehnZ0wMS7jIbTmaea7W9gK6YF3BiGEVlcYwT
         0PxJBwQvrtxvtrsHQsTY6gyG7w9mHi1rSoDH0Ztl62E8g15MYYzKGfG1P0G9aTb7MVOr
         0Xwe35KICcwgpkA+kA1AT0eXhBGtxeJep1x8Q0tPjEe9yJXYNqZNr4GbkKTAG7/OdMq1
         zBTg==
X-Gm-Message-State: AFqh2kpergk6yJYsBc5LIMD1tedlzkERGpFrrXv+YFqoPIRWW34P06Du
        94zbwIcnRxPkvq6meDVfh7N3D7/3evFdjD+W
X-Google-Smtp-Source: AMrXdXvnmF6f+NEOc+uLAfGZASLXPlvHzt3wKi9SEnxPBOt39NwwQbkr3lgpYgOEiMhDZKciV49qIg==
X-Received: by 2002:a62:4e93:0:b0:57f:ef11:acf9 with SMTP id c141-20020a624e93000000b0057fef11acf9mr27300836pfb.10.1672313612386;
        Thu, 29 Dec 2022 03:33:32 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id d188-20020a6236c5000000b0057a9b146592sm11871081pfa.186.2022.12.29.03.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 03:33:31 -0800 (PST)
Date:   Thu, 29 Dec 2022 20:33:26 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-mm@kvack.org, liam.howlett@oracle.com, willy@infradead.org,
        ldufour@linux.ibm.com, michel@lespinasse.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] about the maple tree and current status of mmap_lock
 scalability
Message-ID: <Y617Bgn1slh+BqwO@hyeyoo>
References: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
 <CAJuCfpFUh4qGqePueUd5snz27nxLUPehQeAmbkshheno==KtcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFUh4qGqePueUd5snz27nxLUPehQeAmbkshheno==KtcA@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 09:10:20AM -0800, Suren Baghdasaryan wrote:
> Hi Hyeonggon,
> 
> On Wed, Dec 28, 2022 at 4:49 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >
> > Hello mm folks,
> >
> > I have a few questions about the current status of mmap_lock scalability.
> >
> > =============================================================
> > What is currently causing the kernel to use mmap_lock to protect the maple tree?
> > =============================================================
> >
> > I understand that the long-term goal is to remove the need for mmap_lock in readers
> > while traversing the maple tree, using techniques such as RCU or SPF.
> > What is the biggest obstacle preventing this from being achieved at this time?
> 
> Maple tree has an RCU mode which does not need mmap_lock for
> traversal. Liam and I were testing it recently and Liam fixed a number
> of issues to enable it. It seems stable now and the fixes are
> incorporated into the "per-vma locks" patchset which I prepared in
> this branch: https://github.com/surenbaghdasaryan/linux/tree/per_vma_lock.

Thank you for the link. I didn't realize how far the discussion had progressed.

Let me check if I understand correctly:

To allow non-overlapping page faults while writers are performing VMA operations,
per-VMA locking moves from the mmap_lock to the VMA lock on the reader
side during page fault.

While maple tree traversal is done without locking, readers must take
VMA lock in read mode within RCU read section (or retry taking mmap_lock
if failed) to process page fault.

This ensures that readers are not racing with writers for access to the same
VMA.

Am I getting it right?

> I haven't posted this patchset upstream yet but it's pretty much ready
> to go. I'm planning to post it in early January.

Looking forward to that,
thank you for working on this.

-- 
Thanks,
Hyeonggon
