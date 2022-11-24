Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023A26374C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiKXJGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKXJFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:05:49 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A7410EA2F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:05:47 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vp12so1409457ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKlbdr0ixds4paIOPKsA175xamTIxoec9jBfY1XMP/c=;
        b=ManxrbJva+RcaZ1pgy61KlOXet2k5tNGPxzxLAtn07OZAKYM9J+CI9fCmoBZYuuuIV
         F1+ga8J+vsvrrp2+r7zT5RH3Dg51n5GslIyFLmWG/YOHjmYrhZg8pOo3ACajMl9zYV8R
         VWV91495k6gOZuLxLWiqrXwu0Bhi4Ddd7n210=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKlbdr0ixds4paIOPKsA175xamTIxoec9jBfY1XMP/c=;
        b=YsV5AplDGzKEdVMtmqGUOmMSiC1FxNHLo1nQRztl58mGEI2kKWR7wIwJGV9l8vtjMR
         w5NBgKuNMxiZL2iisIKmXB7NoR48R81QkT28Wotbta66ZVecyuoMmYHjlBK+nRnwZaCL
         SpkYByOANNZ9EYxFnnbyciweS0vz9NJLPj3IPekrZpgTushZi8cLaWRkvObtwfyssPQl
         aFn6nXMdqi6q5NA8r65Q9oR5I4AcdI365PrtCHTCtt2dtXnI2KiKrVI5UYGLRihZlQg1
         qNssFcifDscY7hJK1k3TD8QSUwgPfqrgOK8MRxcfoz0DqFZpWKksgQgaNA4+E9Q8U95V
         iCpw==
X-Gm-Message-State: ANoB5pkDSAWQfVafWUza62UnNtB7QP+FqfueI4pE1RRaVPEmd5DdPPVX
        DfjdVqlPoakBNQPbFG4wciC2jA==
X-Google-Smtp-Source: AA0mqf7p10lzEx8VmXSg9+u5DLJIGEhK1NGmIuP+ia7oyyWd4DAtEakvIkIFE8FUqgbTHM1igSNn/g==
X-Received: by 2002:a17:906:524f:b0:7ae:59dd:e3f4 with SMTP id y15-20020a170906524f00b007ae59dde3f4mr15723133ejm.755.1669280746416;
        Thu, 24 Nov 2022 01:05:46 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090639cd00b0078d957e65b6sm211642eje.23.2022.11.24.01.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 01:05:45 -0800 (PST)
Date:   Thu, 24 Nov 2022 10:05:44 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] dma-buf: A collection of typo and documentation fixes
Message-ID: <Y38z6A5IF/BlXVPp@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
References: <20221123193519.3948105-1-tjmercier@google.com>
 <260a86f0-057e-e235-ac38-abeb922d0dc1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <260a86f0-057e-e235-ac38-abeb922d0dc1@amd.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 08:03:09AM +0100, Christian König wrote:
> Am 23.11.22 um 20:35 schrieb T.J. Mercier:
> > I've been collecting these typo fixes for a while and it feels like
> > time to send them in.
> > 
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> 
> Acked-by: Christian König <christian.koenig@amd.com>

Will you also push this? I think tj doesn't have commit rights yet, and I
somehow can't see the patch locally (I guess it's stuck in moderation).
-Daniel

> 
> > ---
> >   drivers/dma-buf/dma-buf.c | 14 +++++++-------
> >   include/linux/dma-buf.h   |  6 +++---
> >   2 files changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index dd0f83ee505b..614ccd208af4 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1141,7 +1141,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_unmap_attachment, DMA_BUF);
> >    *
> >    * @dmabuf:	[in]	buffer which is moving
> >    *
> > - * Informs all attachmenst that they need to destroy and recreated all their
> > + * Informs all attachments that they need to destroy and recreate all their
> >    * mappings.
> >    */
> >   void dma_buf_move_notify(struct dma_buf *dmabuf)
> > @@ -1159,11 +1159,11 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_move_notify, DMA_BUF);
> >   /**
> >    * DOC: cpu access
> >    *
> > - * There are mutliple reasons for supporting CPU access to a dma buffer object:
> > + * There are multiple reasons for supporting CPU access to a dma buffer object:
> >    *
> >    * - Fallback operations in the kernel, for example when a device is connected
> >    *   over USB and the kernel needs to shuffle the data around first before
> > - *   sending it away. Cache coherency is handled by braketing any transactions
> > + *   sending it away. Cache coherency is handled by bracketing any transactions
> >    *   with calls to dma_buf_begin_cpu_access() and dma_buf_end_cpu_access()
> >    *   access.
> >    *
> > @@ -1190,7 +1190,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_move_notify, DMA_BUF);
> >    *   replace ION buffers mmap support was needed.
> >    *
> >    *   There is no special interfaces, userspace simply calls mmap on the dma-buf
> > - *   fd. But like for CPU access there's a need to braket the actual access,
> > + *   fd. But like for CPU access there's a need to bracket the actual access,
> >    *   which is handled by the ioctl (DMA_BUF_IOCTL_SYNC). Note that
> >    *   DMA_BUF_IOCTL_SYNC can fail with -EAGAIN or -EINTR, in which case it must
> >    *   be restarted.
> > @@ -1264,10 +1264,10 @@ static int __dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
> >    * preparations. Coherency is only guaranteed in the specified range for the
> >    * specified access direction.
> >    * @dmabuf:	[in]	buffer to prepare cpu access for.
> > - * @direction:	[in]	length of range for cpu access.
> > + * @direction:	[in]	direction of access.
> >    *
> >    * After the cpu access is complete the caller should call
> > - * dma_buf_end_cpu_access(). Only when cpu access is braketed by both calls is
> > + * dma_buf_end_cpu_access(). Only when cpu access is bracketed by both calls is
> >    * it guaranteed to be coherent with other DMA access.
> >    *
> >    * This function will also wait for any DMA transactions tracked through
> > @@ -1307,7 +1307,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_begin_cpu_access, DMA_BUF);
> >    * actions. Coherency is only guaranteed in the specified range for the
> >    * specified access direction.
> >    * @dmabuf:	[in]	buffer to complete cpu access for.
> > - * @direction:	[in]	length of range for cpu access.
> > + * @direction:	[in]	direction of access.
> >    *
> >    * This terminates CPU access started with dma_buf_begin_cpu_access().
> >    *
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 71731796c8c3..1d61a4f6db35 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -330,7 +330,7 @@ struct dma_buf {
> >   	 * @lock:
> >   	 *
> >   	 * Used internally to serialize list manipulation, attach/detach and
> > -	 * vmap/unmap. Note that in many cases this is superseeded by
> > +	 * vmap/unmap. Note that in many cases this is superseded by
> >   	 * dma_resv_lock() on @resv.
> >   	 */
> >   	struct mutex lock;
> > @@ -365,7 +365,7 @@ struct dma_buf {
> >   	 */
> >   	const char *name;
> > -	/** @name_lock: Spinlock to protect name acces for read access. */
> > +	/** @name_lock: Spinlock to protect name access for read access. */
> >   	spinlock_t name_lock;
> >   	/**
> > @@ -402,7 +402,7 @@ struct dma_buf {
> >   	 *   anything the userspace API considers write access.
> >   	 *
> >   	 * - Drivers may just always add a write fence, since that only
> > -	 *   causes unecessarily synchronization, but no correctness issues.
> > +	 *   causes unnecessary synchronization, but no correctness issues.
> >   	 *
> >   	 * - Some drivers only expose a synchronous userspace API with no
> >   	 *   pipelining across drivers. These do not set any fences for their
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
