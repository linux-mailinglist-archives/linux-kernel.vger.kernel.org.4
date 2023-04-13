Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33FE6E1098
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjDMPGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjDMPF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:05:59 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52324901B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:05:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id w38so1488503qtc.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1681398357; x=1683990357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfzHe58YhokPe0JZwdIWaRO+RRdS5beb3bGyF0eQI9A=;
        b=ROi6rVGibUkfVQXcAw/Kwi1xI2WfRMJgPG2NUJeFIY2uOZByDvOWQTlLa/Y6+kKDcY
         dNNMh3mM+4ApvVjcVlwAERWhnO5BDySYjFYfZLwFVO0HQkXM9BPN4DFV+7BIij4XxZD8
         65Pa4x4izsTNV5dmby3WRo5KRsZ4zFkKHBVkle31d6I3vbVj1Y1iKm5mi1sL7U7SEhC1
         bFAWLHYKxUK6lClgZthZJZpBGrubbzb55KRMK4vIX5aSbOBnbziq2o/ASWMeGtRc8DaY
         DRTarurhmkMhBCIAaU5zgxQq8TvuXsteIGRjRfk+Cy+wXM0B6YpPsmpKZX+vtPjy6e/F
         C67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681398357; x=1683990357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfzHe58YhokPe0JZwdIWaRO+RRdS5beb3bGyF0eQI9A=;
        b=Bm78Y7k6UvuNJloloMyL/MCot2HF6l4EoAI0U8PR9CgLIEgG9ke0Mm5xpGlMWEAyBA
         gXY+SyvPw/JZ/TOpAD/jDBV33G/Nqg+k1v+RfNKAMnIQQaGL+uCySZQegSjzQ4v8sRCe
         F30eSx/RnGt2wJhZdMFozBMwnItzh6dcBhu18XKp0hN7n3tn2L0rKK9+Mb9aqGLZ3MsE
         MIDSrbKc2HmYzKvcy7tXD4UboWH+dE3QzM8yS4KfJYCZQANGby2vh6UsJgU9L2mMD775
         1D+5qqLlAZ8c/Po5MiWEnQtzLtuZVmJh2Z6KR+jC2MJMzhFTWyGKnrX8B6P258ZFLyDx
         meFg==
X-Gm-Message-State: AAQBX9cjrfPrzO1uJ+MQp4W9cv8Te4ngjavdCUDIm5/IBWHedX/azH8e
        50ZOgvlU7rS3RXOs8UOJ7WV/k9L0eEaUsPxrdUAb1Q==
X-Google-Smtp-Source: AKy350aPdF4g6Xc9Hanz4/44uPGz+bFRHccMJR3Zup7sfa2XJpWrLNMyIG6PWH/6XB+zuQgvn0zLwc+R4Y9a7Rf3TWU=
X-Received: by 2002:a05:622a:1a99:b0:3de:bafb:82b0 with SMTP id
 s25-20020a05622a1a9900b003debafb82b0mr764770qtc.6.1681398357504; Thu, 13 Apr
 2023 08:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230412195939.1242462-1-pasha.tatashin@soleen.com>
 <20230412131302.cf42a7f4b710db8c18b7b676@linux-foundation.org> <ZDcSG2t3/sVuZc67@dhcp22.suse.cz>
In-Reply-To: <ZDcSG2t3/sVuZc67@dhcp22.suse.cz>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 13 Apr 2023 11:05:20 -0400
Message-ID: <CA+CK2bCZEKsocuwN4Na1+YyviERztGdGDoQgWhxQF-9WxVVW5Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: hugetlb_vmemmap: provide stronger vmemmap
 allocation guarantees
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        rientjes@google.com, souravpanda@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 4:18=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 12-04-23 13:13:02, Andrew Morton wrote:
> > Lots of questions (ie, missing information!)
> >
> > On Wed, 12 Apr 2023 19:59:39 +0000 Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
> >
> > > HugeTLB pages have a struct page optimizations where struct pages for=
 tail
> > > pages are freed. However, when HugeTLB pages are destroyed, the memor=
y for
> > > struct pages (vmemmap) need to be allocated again.
> > >
> > > Currently, __GFP_NORETRY flag is used to allocate the memory for vmem=
map,
> > > but given that this flag makes very little effort to actually reclaim
> > > memory the returning of huge pages back to the system can be problem.
> >
> > Are there any reports of this happening in the real world?
> >
> > > Lets
> > > use __GFP_RETRY_MAYFAIL instead. This flag is also performs graceful
> > > reclaim without causing ooms, but at least it may perform a few retri=
es,
> > > and will fail only when there is genuinely little amount of unused me=
mory
> > > in the system.
> >
> > If so, does this change help?
> >
> > If the allocation attempt fails, what are the consequences?
> >
> > What are the potential downsides to this change?  Why did we choose
> > __GFP_NORETRY in the first place?
> >
> > What happens if we try harder (eg, GFP_KERNEL)?
>
> Mike was generous enough to make me remember
> https://lore.kernel.org/linux-mm/YCafit5ruRJ+SL8I@dhcp22.suse.cz/.
> GFP_KERNEL wouldn't make much difference becauset this is
> __GFP_THISNODE. But I do agree that the changelog should go into more
> details about why do we want to try harder now. I can imagine that
> shrinking hugetlb pool by a large amount of hugetlb pages might become a
> problem but is this really happening or is this a theoretical concern?

This is a theoretical concern. Freeing a 1G page requires 16M of free
memory. A machine might need to be reconfigured from one task to
another, and release a large number of 1G pages back to the system if
allocating 16M fails, the release won't work.

In an ideal scenario we should guarantee that this never fails: that
we always can free HugeTLB pages back to the system. At the very least
we could steal the memory for vmemmap from the page that is being
released.

Pasha
