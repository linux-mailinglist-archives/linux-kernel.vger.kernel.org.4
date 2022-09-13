Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83695B78E0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiIMRx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiIMRwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:52:41 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BB371720
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:52:24 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id e187so12481119ybh.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CAUHAKvsliDqt6Bith7BoZVpURh1bCvkOtmvTYLFN94=;
        b=GEgSCNg5HmYJ4ERFLxTXHVSrDewcSpNo6KSQQtQd4onLJNSCMdYM0UgxwjfCxZSqjl
         ZMLTaEGWcQFtF+qiAH0g8YpfD5lStrL3EJ28Qy2KuTx3ipLWZ1/CVx92UI8GHlS86yfW
         CoYE+eZhVkClgNGW9t5dXws31eOi/5RQCIY6ZdCqw6OdoogqVsZ7du9r4EdBu+e+Yvhx
         CfBfmWZHeF9W+oeCgpNL6xNwu62QOsfm6CA6MH4ZrbmQkZsZjigM85CMF/Vgl7o43MRP
         IyWBn9JsLuCRJFDHqlEbyGMp6uq+LtI4qIsswrb1FoYi/cWD+ZUiCT7rq3IWGvQQyugD
         ZH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CAUHAKvsliDqt6Bith7BoZVpURh1bCvkOtmvTYLFN94=;
        b=tR+9sjqz5thNIe7aiF35g0Av2izhkxrZAtMKAgwk7su3XXwq2+0SzAPPfowaCiINxD
         Lvpiv2r0Mq9DwsX2sVqfqMbH+aqNKj6h+kWsGl1Zlg7zOs2pDepoKvvgsfjCqFMmid4m
         jEkBc6PEh0D7VriddpBYgUFj/XP0agvM84x1gWJfHrzO/o0pinwwIc1258Kl+LTJy6lU
         RH43Jn4b51xnjR1uJRh/vYtZopU11CkPihsfK0LCPV94NUxICvBAQcPDo5dnbTs6e/dw
         k4ktx1a4Q9qFRx/R1C0y8iGCMF9s/DL7cHPv0JEtr0ZXiM8C8VXbCEpkEHCIFiythHRc
         jhmQ==
X-Gm-Message-State: ACgBeo2cg3w51FazbtAbm9oU8Gqv9fRUfI9YClvplqYN7B7maajwIfNg
        G5EzKrO1xKPykBM+c112eYbLBZjy19/cLZAM9r++do0yMZ0=
X-Google-Smtp-Source: AA6agR6W986Sl3YkCKIGso9iEy5VyE1ic/Mx10Iso5iivFtJnBsPgRN21CKXWch+AY1iGVom6ZR0doWkpT/b6MOU390=
X-Received: by 2002:a25:230d:0:b0:6a9:1d4d:6594 with SMTP id
 j13-20020a25230d000000b006a91d4d6594mr28014766ybj.616.1663087943592; Tue, 13
 Sep 2022 09:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662724786.git.namcaov@gmail.com> <c3a7d9963b1c38c5f493786d7268c430617412dd.1662724786.git.namcaov@gmail.com>
 <Yxt/3FOysEbwCm9T@kroah.com> <CA+sZ8B8Y1ZGou1Y4tQYJC1Wp_2MVdYKO0Bd3SfxMAU1DF+mz_g@mail.gmail.com>
 <Yx2NY0RBWLqH3rDK@kroah.com>
In-Reply-To: <Yx2NY0RBWLqH3rDK@kroah.com>
From:   Nam Cao <namcaov@gmail.com>
Date:   Tue, 13 Sep 2022 18:52:12 +0200
Message-ID: <CA+sZ8B8-hsNXY-nFffvGMLJXmsAa9L+gnEK1ZdC7PztG1dd03Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] staging: vt6655: remove unnecessary volatile qualifier
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 9:25 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Sep 11, 2022 at 09:12:44AM +0200, Nam Cao wrote:
> > On Fri, Sep 9, 2022 at 8:03 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Sep 09, 2022 at 02:17:55PM +0200, Nam Cao wrote:
> > > > Remove volatile qualifier for the member rd0 of struct vnt_rx_desc,
> > > > because there is no reason it must be volatile.
> > > >
> > > > Signed-off-by: Nam Cao <namcaov@gmail.com>
> > > > ---
> > > >  drivers/staging/vt6655/desc.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/staging/vt6655/desc.h b/drivers/staging/vt6655/desc.h
> > > > index 17a40c53b8ff..3f0f287b1693 100644
> > > > --- a/drivers/staging/vt6655/desc.h
> > > > +++ b/drivers/staging/vt6655/desc.h
> > > > @@ -182,7 +182,7 @@ struct vnt_rdes1 {
> > > >
> > > >  /* Rx descriptor*/
> > > >  struct vnt_rx_desc {
> > > > -     volatile struct vnt_rdes0 rd0;
> > > > +     struct vnt_rdes0 rd0;
> > >
> > > You can not just remove this without describing _WHY_ it is ok to do so.
> > >
> > > Have you properly determined why it is, or is not, ok to use volatile
> > > here?
> >
> > I did not carefully look at the volatile usage here. After looking at it
> > again, using volatile is actually valid: the structure resides on coherent
> > memory.
>
> Are you sure?  That's a very odd thing for a driver to need.  Looks like
> they are allocating some dma memory and then pointing structures on top
> of that memory.  Why would you need to have "volatile" markings on a
> structure definition for that?

These structures are the ring buffer descriptors, which are dma-mapped and
their values may be changed by the hardware. For example, the field "owner" of
struct vnt_rdes0 is set to OWNED_BY_NIC by CPU, and then set to OWNED_BY_HOST
by hardware when new data arrives (at least that's why I can guess based on
the codes). So I think volatile is needed.

Please let me know if you think I'm wrong, because I have just recently
educated myself on DMA mapping.

Best regards,
Nam
