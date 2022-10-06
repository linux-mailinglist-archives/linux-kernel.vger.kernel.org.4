Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15F65F6103
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 08:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiJFGYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 02:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJFGYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 02:24:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3DB89AEC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 23:24:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w10so1380337edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 23:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=hcwsr+gxsxYhjpD2bB7DUVncJgwA9R5/DlEljscp2s0=;
        b=NJri+RJsCQX1v6PEjp7l9HpnrU7itfxe3i3yU/37dNWDDBhMgv6eSv9aaKcC/efLqJ
         aeJbPSl5Bby1+28sixlaa+qCs6LYgYw/8L+LyPgleIQDG2xH9hKayZe2nZr03G6UQ60U
         Kd6Bsitsbk71avsoS8gmrNpfQGKGnX8PjQWra1hlR+9MqurTuTiKve6So6Yauy6ne5ld
         g8ogpv6fx1mVWtxpIZKWec/4nvRtWcY6I81kXqDehFrTZeouiMNGPh2vOYYoRbK5CKtz
         b7cOcqQXFIh2mPH+OgF+AtNtLT4aOv3XKHnZMQwR7YKMmrf1Bw1NOpvAfIDH/mX8iCsY
         vaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hcwsr+gxsxYhjpD2bB7DUVncJgwA9R5/DlEljscp2s0=;
        b=t9gcSsGOMFnL6WthBhUtxwv9j24h3nl4aMrCVr6gWYVQxc+imkezDUx1mTPQdt964i
         EP0b1KxQMz3bXqGfnGbAAqSrTCAWVQ2Y1CQ1PBMaPeAKsvoj1cPMAMHidJ22gV44DeRP
         6kTvuj92UnqtZGfVWWgqTaXkb+l9DhRZInDw4/zytD0+1vgXpsZH7Tp14240aC332L9R
         FFRlpXPltVGg+kqYAWXgmlYwTzTEk7NQSOWl56F4G+2IqKFexjkKZL6zW7YrruA0WmU5
         OnK1jaw9SQjUzZMIf9TiTvH/NWFv7/TPNftpyBVSKirtaMHLCTcjOyBq+JMXDDTlXvp1
         aJ1w==
X-Gm-Message-State: ACrzQf1XjGAqdCFAoPdi6tgnB61hxmVxfivhXatTjHtX31rdUdkcgBv6
        RE9P3CAswo+VMvlUcnukc3OI1iRDrCqF9eAAuFeg/A==
X-Google-Smtp-Source: AMsMyM45Fo5EqDCOTvGzAIiJi6QN5VCakFhFt5Khq+dHMnxFOxnAznWVaQOOFUO5stJANfFH4Rz6OIlSSFIqJiIJ/Dc=
X-Received: by 2002:a05:6402:1856:b0:458:db1e:20ec with SMTP id
 v22-20020a056402185600b00458db1e20ecmr3214007edy.14.1665037447118; Wed, 05
 Oct 2022 23:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221002002326.946620-1-ira.weiny@intel.com> <20221002002326.946620-3-ira.weiny@intel.com>
 <CAFA6WYOGT1sJLA4c_B88NaXgxv4fm-idi5QMYvXdXB0acCF3sw@mail.gmail.com> <TYZPR03MB65279558CC22F5130B710EA8FB5D9@TYZPR03MB6527.apcprd03.prod.outlook.com>
In-Reply-To: <TYZPR03MB65279558CC22F5130B710EA8FB5D9@TYZPR03MB6527.apcprd03.prod.outlook.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 6 Oct 2022 11:53:55 +0530
Message-ID: <CAFA6WYMT9S1Di6DN_UXc823f0ZTkqerE1PB=oG6wmfx28vEbDg@mail.gmail.com>
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
To:     =?UTF-8?B?UGhpbCBDaGFuZyAo5by15LiW5YuzKQ==?= 
        <Phil.Chang@mediatek.com>
Cc:     "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

Please don't top-post in the OSS mailing list.

On Wed, 5 Oct 2022 at 08:59, Phil Chang (=E5=BC=B5=E4=B8=96=E5=8B=B3) <Phil=
.Chang@mediatek.com> wrote:
>
> Hi Sumit
>
> Thanks for mentioning that, in fact, our product is low memory devices, a=
nd continuous pages are extremely valuable.
> Although our driver is not upstream yet but highly dependent on tee shm v=
malloc support,

Sorry but you need to get your driver mainline in order to support
vmalloc interface. As otherwise it's a maintenance nightmare to
support interfaces in the mainline for out-of-tree drivers.

-Sumit

> some scenarios are driver alloc high order pages but system memory is fra=
gmentation so that alloc failed.
> In this situation, vmalloc support is important and gives flexible usage =
to user.
>
>
> -----Original Message-----
> From: Sumit Garg <sumit.garg@linaro.org>
> Sent: Monday, October 3, 2022 2:57 PM
> To: ira.weiny@intel.com
> Cc: Jens Wiklander <jens.wiklander@linaro.org>; Andrew Morton <akpm@linux=
-foundation.org>; Al Viro <viro@zeniv.linux.org.uk>; Fabio M. De Francesco =
<fmdefrancesco@gmail.com>; Christoph Hellwig <hch@lst.de>; Linus Torvalds <=
torvalds@linux-foundation.org>; op-tee@lists.trustedfirmware.org; linux-ker=
nel@vger.kernel.org; linux-mm@kvack.org; Phil Chang (=E5=BC=B5=E4=B8=96=E5=
=8B=B3) <Phil.Chang@mediatek.com>
> Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
>
> + Phil
>
> Hi Ira,
>
> On Sun, 2 Oct 2022 at 05:53, <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > The kernel pages used by shm_get_kernel_pages() are allocated using
> > GFP_KERNEL through the following call stack:
> >
> > trusted_instantiate()
> >         trusted_payload_alloc() -> GFP_KERNEL
> >         <trusted key op>
> >                 tee_shm_register_kernel_buf()
> >                         register_shm_helper()
> >                                 shm_get_kernel_pages()
> >
> > Where <trusted key op> is one of:
> >
> >         trusted_key_unseal()
> >         trusted_key_get_random()
> >         trusted_key_seal()
> >
> > Remove the vmalloc page support from shm_get_kernel_pages().  Replace
> > with a warn on once.
> >
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
> > ---
> > Jens I went with the suggestion from Linus and Christoph and rejected
> > vmalloc addresses.  I did not hear back from you regarding Linus'
> > question if the vmalloc page support was required by an up coming
> > patch set or not.  So I assumed it was something out of tree.
>
> It looks like I wasn't CC'd to that conversation. IIRC, support for vmall=
oc addresses was added recently by Phil here [1]. So I would like to give h=
im a chance if he is planning to post a corresponding kernel driver upstrea=
m.
>
> [1] https://urldefense.com/v3/__https://lists.trustedfirmware.org/archive=
s/list/op-tee@lists.trustedfirmware.org/thread/M7HI3P2M66V27SK35CGQRICZ7DJZ=
5J2W/__;!!CTRNKA9wMg0ARbw!wGOKR9k3khZJlPt1K_xBCXX4EBM5ZCfWKuruFgSP45H8wTvJr=
x4_St3Fb5ZrljD5QQ$
>
> -Sumit
>
> > ---
> >  drivers/tee/tee_shm.c | 36 ++++++++++++------------------------
> >  1 file changed, 12 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c index
> > 27295bda3e0b..527a6eabc03e 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -24,37 +24,25 @@ static void shm_put_kernel_pages(struct page
> > **pages, size_t page_count)  static int shm_get_kernel_pages(unsigned l=
ong start, size_t page_count,
> >                                 struct page **pages)  {
> > +       struct kvec *kiov;
> >         size_t n;
> >         int rc;
> >
> > -       if (is_vmalloc_addr((void *)start)) {
> > -               struct page *page;
> > -
> > -               for (n =3D 0; n < page_count; n++) {
> > -                       page =3D vmalloc_to_page((void *)(start + PAGE_=
SIZE * n));
> > -                       if (!page)
> > -                               return -ENOMEM;
> > -
> > -                       get_page(page);
> > -                       pages[n] =3D page;
> > -               }
> > -               rc =3D page_count;
> > -       } else {
> > -               struct kvec *kiov;
> > -
> > -               kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL)=
;
> > -               if (!kiov)
> > -                       return -ENOMEM;
> > +       if (WARN_ON_ONCE(is_vmalloc_addr((void *)start)))
> > +               return -EINVAL;
> >
> > -               for (n =3D 0; n < page_count; n++) {
> > -                       kiov[n].iov_base =3D (void *)(start + n * PAGE_=
SIZE);
> > -                       kiov[n].iov_len =3D PAGE_SIZE;
> > -               }
> > +       kiov =3D kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> > +       if (!kiov)
> > +               return -ENOMEM;
> >
> > -               rc =3D get_kernel_pages(kiov, page_count, 0, pages);
> > -               kfree(kiov);
> > +       for (n =3D 0; n < page_count; n++) {
> > +               kiov[n].iov_base =3D (void *)(start + n * PAGE_SIZE);
> > +               kiov[n].iov_len =3D PAGE_SIZE;
> >         }
> >
> > +       rc =3D get_kernel_pages(kiov, page_count, 0, pages);
> > +       kfree(kiov);
> > +
> >         return rc;
> >  }
> >
> > --
> > 2.37.2
> >
