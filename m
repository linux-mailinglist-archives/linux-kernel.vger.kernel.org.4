Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8B867DD27
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 06:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjA0Fjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 00:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjA0Fjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 00:39:44 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5B224498
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 21:39:43 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-50112511ba7so53530777b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 21:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7GiQ7w1X2hhFSR7NAHawrhOM+1bixV1+YFnoXy42vGU=;
        b=QVl2mReNZWpLX20IPMiqSZF9jDaiI62lV6nbC4xS2ZQ0+ObGDve/qVNNBlnqQ5Tvls
         d1gDBrRB17QYETlrVwh4qMiMYLiz1+2bw06RLaZtuxtdZ2DnTyouIcUQXyI9ydyxaP8l
         Pd8a35a9B86U2rajp2eNZCL0lNhf0VeFYF/ddJAFoe2K1/RprOOBjM/Dax11DDxZ/w4l
         HdVi1U8z6ziXzGQYMrbI5TLDeVTN1nFzMylQ5XdQhUe05W3N0Zv35LvNKs3G92ZLUACA
         f6kDF2jZIZ2BPLhjMs3TURmadw8LHz5FZF6vd5XJ+pGRNDXaKswxXsUrkT+K3k1DqxOm
         iauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GiQ7w1X2hhFSR7NAHawrhOM+1bixV1+YFnoXy42vGU=;
        b=Aqotb3S78598kx6WjwdNXXvn8XbTsrVKKZjzAoIeo8GYGRP3oBKkdB73wm5PCFQ6gS
         EAGAL8TvKyGcFLf7FXaFcEPcik38B9+WPehrVpAHTClybT5tO69N8v5G3rXiNOYBB/Fv
         jxtYS9PV5EEC8eg3fEMiTzt6RAIfmKEh08iAKcci0h+HjM1fm6uQxiHSJ8CbIoCZ+Ncn
         9nqwTWIbvW+/W8tx2/az9SH52fb1KMqIg71WIqntMdNHcZP1byr4Gz0eIxiStdXVyD99
         NENvDNrBWW8b4evSvvN0aJcZ9LI198RowuxzLY1aFx8He5ZjOFnBvETprA3kCmpAm5Fk
         Ia4Q==
X-Gm-Message-State: AO0yUKW0NOuf1kXDYqykhrvDSGVLevy2sDfmApUbd8iL0E+Fd+z3ECmc
        erXHErh4HSOJc75RtE9AYyEns7ZI4OxTg4Rs8CKGjA==
X-Google-Smtp-Source: AK7set91Hj+5JRIUMgFdCdTiKxYQbRYY0lmNdodkcHw8zPBgiHAgAOtNrL4ORfklzYuu+CmGMvnIJgOvZY5W8zbJr9s=
X-Received: by 2002:a0d:cb41:0:b0:507:e228:fd85 with SMTP id
 n62-20020a0dcb41000000b00507e228fd85mr956460ywd.132.1674797982893; Thu, 26
 Jan 2023 21:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20230127162143.1a3bc64b@canb.auug.org.au>
In-Reply-To: <20230127162143.1a3bc64b@canb.auug.org.au>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 26 Jan 2023 21:39:31 -0800
Message-ID: <CAJuCfpGSQk45mvCxCUhWTD1GjKs=XYmjOeZTEUerpo-ZKnTByA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mm tree with the rdma tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 9:21 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the mm tree got a conflict in:
>
>   drivers/infiniband/hw/hfi1/file_ops.c
>
> between commit:
>
>   1ec82317a1da ("IB/hfi1: Use dma_mmap_coherent for matching buffers")
>
> from the rdma tree and commit:
>
>   6fe0afd07701 ("mm: replace vma->vm_flags direct modifications with modifier calls")
>
> from the mm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Hi Stephen,
Conflict resolution for 6fe0afd07701 looks good to me.
Thanks,
Suren.

>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/infiniband/hw/hfi1/file_ops.c
> index e03b0207856e,c6e59bc480f9..000000000000
> --- a/drivers/infiniband/hw/hfi1/file_ops.c
> +++ b/drivers/infiniband/hw/hfi1/file_ops.c
> @@@ -424,17 -403,8 +424,17 @@@ static int hfi1_file_mmap(struct file *
>                         ret = -EPERM;
>                         goto done;
>                 }
> -               vma->vm_flags &= ~VM_MAYWRITE;
> +               vm_flags_clear(vma, VM_MAYWRITE);
>  -              addr = vma->vm_start;
>  +              /*
>  +               * Mmap multiple separate allocations into a single vma.  From
>  +               * here, dma_mmap_coherent() calls dma_direct_mmap(), which
>  +               * requires the mmap to exactly fill the vma starting at
>  +               * vma_start.  Adjust the vma start and end for each eager
>  +               * buffer segment mapped.  Restore the originals when done.
>  +               */
>  +              vm_start_save = vma->vm_start;
>  +              vm_end_save = vma->vm_end;
>  +              vma->vm_end = vma->vm_start;
>                 for (i = 0 ; i < uctxt->egrbufs.numbufs; i++) {
>                         memlen = uctxt->egrbufs.buffers[i].len;
>                         memvirt = uctxt->egrbufs.buffers[i].addr;
> @@@ -560,9 -528,11 +560,9 @@@
>                 goto done;
>         }
>
> -       vma->vm_flags = flags;
> +       vm_flags_reset(vma, flags);
>  -      hfi1_cdbg(PROC,
>  -                "%u:%u type:%u io/vf:%d/%d, addr:0x%llx, len:%lu(%lu), flags:0x%lx\n",
>  -                  ctxt, subctxt, type, mapio, vmf, memaddr, memlen,
>  -                  vma->vm_end - vma->vm_start, vma->vm_flags);
>  +      mmap_cdbg(ctxt, subctxt, type, mapio, vmf, memaddr, memvirt, memdma,
>  +                memlen, vma);
>         if (vmf) {
>                 vma->vm_pgoff = PFN_DOWN(memaddr);
>                 vma->vm_ops = &vm_ops;
