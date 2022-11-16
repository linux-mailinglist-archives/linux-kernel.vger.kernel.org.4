Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CD462CB61
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiKPUsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiKPUsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:48:11 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7FA61757;
        Wed, 16 Nov 2022 12:48:10 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id x21so23406348ljg.10;
        Wed, 16 Nov 2022 12:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6JrqJ6Sbn/mpwug3ot31DQ5jlBaAKyV9UfORVKR2Mss=;
        b=ae8G2P4a+COzSBWklcw0bHYPAGArR/ipKsW+u7fiYxLC5RpiZCMPR1nP6paPHPtTU+
         ixAtrPPkYXbQrKfG9JJYkVYljE/UarocqtY2NdpjfKE/yG+428aRbIWnx8d23Nbgngem
         03e0erDFegoKeZ43KUMQmwfav4coOnd7KBBFBNxo/+2jdxIkFW/kgI3aW8cwEaDubHWz
         VW6GaCciKF2TAdB14poivTQIW0ORCgyvavOMn59cxTTT7hkGEXlT1JRgnxxWahYX3oCj
         zFfb2hQCOlTpnhIxRLUJq3uz7DGJW4p/zHMlSmf1UqgBuzLCY3UyXYDvx9/fs5eBxPWR
         VBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JrqJ6Sbn/mpwug3ot31DQ5jlBaAKyV9UfORVKR2Mss=;
        b=GkUsu7oxRD8SKkiAUIJJRIRCIksqN8MszfjMH4A9Hyb6tmDsXAE6nfv5ymIGKts8fv
         bt0dRmT3FXmZe+oZwZu064HqszysEegJrVT1V9/MxzYMT5tJkMVMkCui2O4iQOOuDTJM
         6yldyFD5Z2jfOsOWfqoPzrMQZznSJuD5ICkX0Xz3z/PczBM+hE0nxslybIDcSSCK4XAu
         fxLf0W425vHwD7mfHZkes3TJrNKjuS2L+bWn+03mxpp+kxjBXNFw7eIia1LdKBEQ2g+n
         XEXfOQd1Jbgq42q69goRKPLlVDRoPeINUhEZ/EzCVpEUtOBNr/qaKv0tMOseKvCJtfvG
         sotQ==
X-Gm-Message-State: ANoB5pnbvsatvchgY6OexzyhvjYV02EcxYhMzNN35kcQ40gVXrGHEEF3
        XilQ9Ik6hbY6gZFEU4668HkTn5E/5jM1oQ==
X-Google-Smtp-Source: AA0mqf7c2zjF447ne46/zGiLbIu4u1JQD5e98fP8HM3pjr3ANuBHPVYOBUVr94QMa4CkrW+Ny/1oPw==
X-Received: by 2002:a2e:9103:0:b0:278:fa62:bc90 with SMTP id m3-20020a2e9103000000b00278fa62bc90mr6506ljg.360.1668631688223;
        Wed, 16 Nov 2022 12:48:08 -0800 (PST)
Received: from thinkpad-p72 (user-5-173-65-115.play-internet.pl. [5.173.65.115])
        by smtp.gmail.com with ESMTPSA id n1-20020ac24901000000b004b4823f02b0sm2759613lfi.152.2022.11.16.12.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:48:07 -0800 (PST)
From:   Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>
X-Google-Original-From: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
Date:   Wed, 16 Nov 2022 21:48:04 +0100
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        kernel test robot <lkp@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] udmabuf: add vmap and vunmap methods to udmabuf_ops
Message-ID: <20221116204804.GA22663@thinkpad-p72>
References: <20221115200426.4801-1-lukasz.wiecaszek@gmail.com>
 <b715cb83-32f1-a33b-a0c2-b779011151c0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b715cb83-32f1-a33b-a0c2-b779011151c0@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 01:01:46PM +0100, Christian König wrote:
> Am 15.11.22 um 21:04 schrieb Lukasz Wiecaszek:
> > The reason behind that patch is associated with videobuf2 subsystem
> > (or more genrally with v4l2 framework) and user created
> > dma buffers (udmabuf). In some circumstances
> > when dealing with V4L2_MEMORY_DMABUF buffers videobuf2 subsystem
> > wants to use dma_buf_vmap() method on the attached dma buffer.
> > As udmabuf does not have .vmap operation implemented,
> > such dma_buf_vmap() natually fails.
> > 
> > videobuf2_common: __vb2_queue_alloc: allocated 3 buffers, 1 plane(s) each
> > videobuf2_common: __prepare_dmabuf: buffer for plane 0 changed
> > videobuf2_common: __prepare_dmabuf: failed to map dmabuf for plane 0
> > videobuf2_common: __buf_prepare: buffer preparation failed: -14
> > 
> > The patch itself seems to be strighforward.
> > It adds implementation of .vmap and .vunmap methods
> > to 'struct dma_buf_ops udmabuf_ops'.
> > .vmap method itself uses vm_map_ram() to map pages linearly
> > into the kernel virtual address space.
> > .vunmap removes mapping created earlier by .vmap.
> > All locking and 'vmapping counting' is done in dma_buf.c
> > so it seems to be redundant/unnecessary in .vmap/.vunmap.
> > 
> > Signed-off-by: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
> 
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> Please drop this line, the kernel test robot should only be mentioned if the
> original report came from it.
> 
> And keep in mind that it might be necessary to implement begin/end cpu
> access callbacks as well.
> 
> Apart from that the patch is Acked-by: Christian König
> <christian.koenig@amd.com>.
> 
> Regards,
> Christian.

Thanks for that lesson with the 'kernel test robot' line.
The second issue with begin/end cpu access callbacks is more complicated
to me. My understaning is that memory allocated for udambuf will be the 
memory obtained most likely (if not always) by memfd_create(). 
So this will be the anonymous system memory which is 'by definition' 
coherent for cpu access. So no need for begin/end callbacks.
But if I miss something, plese let me/us know.

> 
> > ---
> > v1: https://lore.kernel.org/linux-media/202211120352.G7WPASoP-lkp@intel.com/T/#t
> > v2: https://lore.kernel.org/linux-media/20221114052944.GA7264@thinkpad-p72/T/#t
> > 
> > v2 -> v3: Added .vunmap to 'struct dma_buf_ops udmabuf_ops'
> > v1 -> v2: Patch prepared and tested against 6.1.0-rc2+
> > 
> >   drivers/dma-buf/udmabuf.c | 28 ++++++++++++++++++++++++++++
> >   1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> > index 283816fbd72f..740d6e426ee9 100644
> > --- a/drivers/dma-buf/udmabuf.c
> > +++ b/drivers/dma-buf/udmabuf.c
> > @@ -13,6 +13,8 @@
> >   #include <linux/slab.h>
> >   #include <linux/udmabuf.h>
> >   #include <linux/hugetlb.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/iosys-map.h>
> >   static int list_limit = 1024;
> >   module_param(list_limit, int, 0644);
> > @@ -60,6 +62,30 @@ static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
> >   	return 0;
> >   }
> > +static int vmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
> > +{
> > +	struct udmabuf *ubuf = buf->priv;
> > +	void *vaddr;
> > +
> > +	dma_resv_assert_held(buf->resv);
> > +
> > +	vaddr = vm_map_ram(ubuf->pages, ubuf->pagecount, -1);
> > +	if (!vaddr)
> > +		return -EINVAL;
> > +
> > +	iosys_map_set_vaddr(map, vaddr);
> > +	return 0;
> > +}
> > +
> > +static void vunmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
> > +{
> > +	struct udmabuf *ubuf = buf->priv;
> > +
> > +	dma_resv_assert_held(buf->resv);
> > +
> > +	vm_unmap_ram(map->vaddr, ubuf->pagecount);
> > +}
> > +
> >   static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
> >   				     enum dma_data_direction direction)
> >   {
> > @@ -162,6 +188,8 @@ static const struct dma_buf_ops udmabuf_ops = {
> >   	.unmap_dma_buf	   = unmap_udmabuf,
> >   	.release	   = release_udmabuf,
> >   	.mmap		   = mmap_udmabuf,
> > +	.vmap		   = vmap_udmabuf,
> > +	.vunmap		   = vunmap_udmabuf,
> >   	.begin_cpu_access  = begin_cpu_udmabuf,
> >   	.end_cpu_access    = end_cpu_udmabuf,
> >   };
> 
