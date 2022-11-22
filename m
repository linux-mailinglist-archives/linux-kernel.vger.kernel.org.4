Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0FD6339B7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiKVKT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiKVKTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:19:02 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0863543847
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:17:58 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id n189so4351062yba.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAU3eLi14ypt2c7b62+uOHX4p+XY4P0OQzHd4hzoaDg=;
        b=I8sHtJ1VMGWbKADlghW+RXorMBoSoGjLES4pamIlTJ84wNBgwc8sYMtmY465DWhztX
         8T6TnLw+/ULQud/T+NeuVkPEFI2IbCg9VAga/SULPq5Nq/ZrU1KWxBjhWgSV7d+TikqR
         vploUK08ERDl4Ku/AOx/5xoK2Qou94qqW0nOH63KbmfBRr5L4kAsvt1aWsX12n58DwZZ
         JNVKU17khlLyeudPe3qFAs5NIKyB4B3OV41S7mlmAziAJmVlcvJGVMv5AWfcgNwIM8Qo
         PcS4IxvqboaMcDSFM1z5mbr1Fcdsb4U2c985YnUeuWjIRWww8+Cs2B5likipDQqp4fag
         lDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAU3eLi14ypt2c7b62+uOHX4p+XY4P0OQzHd4hzoaDg=;
        b=j2L/aXWDOcr+wjt/8vmTsljEvAH9ZSTd9H2KlmYh4clnec8+q0eRZasoX/fcsAW/a4
         zQ49w173txFrLiFYuKHHg48tTn6NCSwhDRAANlezAc5k4wPLb71ySzYnPtr38hYD4W92
         M9kMti9CN5S1nFJr5vF7zpSrhPceKI69F71uS9Ayubwq8iAbBjJ8g63hlPtvS3ag60cU
         Fzfc1e8knwHrQtJiQLvs3Eip64BHv6eGejk4miyWXj0zPgsR87LheyMNlEFNUnjCrXq2
         2Ywzgik0SLBVfhe6GfGtgTfaHN3cZeFWytV0qOCEwgUg4MD1/SLPGKwzjuUmph4FM/J1
         wddA==
X-Gm-Message-State: ANoB5pkz8X2KH1GYk8xuS6cfs8/72xGuOeiQTvaVDgzRmP104luqV22F
        sM4JSFIW9oirT5yneh97P9jznsjSK57DR0X0TJ2Mlw==
X-Google-Smtp-Source: AA0mqf4EfspKpQlvvPQVNU9csb2/qWXEm/ETQb7S4hZogc+BxdwSf49gtnOks6esC5AGsgUhblJGlve+hpHsdaKYmCs=
X-Received: by 2002:a25:cc0a:0:b0:6e6:f85a:da48 with SMTP id
 l10-20020a25cc0a000000b006e6f85ada48mr19451585ybf.369.1669112277056; Tue, 22
 Nov 2022 02:17:57 -0800 (PST)
MIME-Version: 1.0
References: <TYCP286MB2323873BBDF88020781FB986CA3B9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB2323894F9939C27291FD998CCA0A9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <56393e84-485b-42ba-5fce-d4a0d0017653@amd.com>
In-Reply-To: <56393e84-485b-42ba-5fce-d4a0d0017653@amd.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 22 Nov 2022 15:47:42 +0530
Message-ID: <CAO_48GFU+bWBm5BmzZx1r5z4U+7pME3MVtsCu73FHSNy0KDx0A@mail.gmail.com>
Subject: Re: [PATCH v4] dma-buf: fix racing conflict of dma_heap_add()
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Dawei Li <set_pte_at@outlook.com>, benjamin.gaignard@collabora.com,
        labbott@redhat.com, Brian.Starkey@arm.com, jstultz@google.com,
        afd@ti.com, sspatil@android.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dawei Li,

On Mon, 21 Nov 2022 at 23:53, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Hi Dawei,
>
> from the technical description, coding style etc.. it looks clean to me,
> but I'm the completely wrong person to ask for a background check.
>
> I have a high level understanding of how dma-heaps work, but not a
> single line of this code is from me.
>
> Feel free to add my Acked-by, but Laura, John and others do you have any
> opinion?
>
> Regards,
> Christian.
>
> Am 21.11.22 um 16:28 schrieb Dawei Li:
> > On Sat, Nov 05, 2022 at 12:05:36AM +0800, Dawei Li wrote:
> >
> > Hi Christian,
> > May I have your opinion on this change?
> >
> > Thanks,
> > Dawei
> >
> >> Racing conflict could be:
> >> task A                 task B
> >> list_for_each_entry
> >> strcmp(h->name))
> >>                         list_for_each_entry
> >>                         strcmp(h->name)
> >> kzalloc                kzalloc
> >> ......                 .....
> >> device_create          device_create
> >> list_add
> >>                         list_add
> >>
> >> The root cause is that task B has no idea about the fact someone
> >> else(A) has inserted heap with same name when it calls list_add,
> >> so a potential collision occurs.
> >>
> >> Fixes: c02a81fba74f ("dma-buf: Add dma-buf heaps framework")
> >> Signed-off-by: Dawei Li <set_pte_at@outlook.com>

Looks good to me as well. I will apply it over on drm-misc.

Best,
Sumit.
> >> ---
> >> v1: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Flore.kernel.org%2Fall%2FTYCP286MB2323950197F60FC3473123B7CA349%40TYCP286M=
B2323.JPNP286.PROD.OUTLOOK.COM%2F&amp;data=3D05%7C01%7Cchristian.koenig%40a=
md.com%7C1989f31257fc458a27c508dacbd5078e%7C3dd8961fe4884e608e11a82d994e183=
d%7C0%7C0%7C638046413707443203%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D=
OWPUPrIHGnzwXyQE4WlIthThwSuSK2y3Eq2Wq5zAzbo%3D&amp;reserved=3D0
> >> v1->v2: Narrow down locking scope, check the existence of heap before
> >> insertion, as suggested by Andrew Davis.
> >> v2->v3: Remove double checking.
> >> v3->v4: Minor coding style and patch formatting adjustment.
> >> ---
> >>   drivers/dma-buf/dma-heap.c | 28 +++++++++++++++-------------
> >>   1 file changed, 15 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> >> index 8f5848aa144f..59d158873f4c 100644
> >> --- a/drivers/dma-buf/dma-heap.c
> >> +++ b/drivers/dma-buf/dma-heap.c
> >> @@ -233,18 +233,6 @@ struct dma_heap *dma_heap_add(const struct dma_he=
ap_export_info *exp_info)
> >>              return ERR_PTR(-EINVAL);
> >>      }
> >>
> >> -    /* check the name is unique */
> >> -    mutex_lock(&heap_list_lock);
> >> -    list_for_each_entry(h, &heap_list, list) {
> >> -            if (!strcmp(h->name, exp_info->name)) {
> >> -                    mutex_unlock(&heap_list_lock);
> >> -                    pr_err("dma_heap: Already registered heap named %=
s\n",
> >> -                           exp_info->name);
> >> -                    return ERR_PTR(-EINVAL);
> >> -            }
> >> -    }
> >> -    mutex_unlock(&heap_list_lock);
> >> -
> >>      heap =3D kzalloc(sizeof(*heap), GFP_KERNEL);
> >>      if (!heap)
> >>              return ERR_PTR(-ENOMEM);
> >> @@ -283,13 +271,27 @@ struct dma_heap *dma_heap_add(const struct dma_h=
eap_export_info *exp_info)
> >>              err_ret =3D ERR_CAST(dev_ret);
> >>              goto err2;
> >>      }
> >> -    /* Add heap to the list */
> >> +
> >>      mutex_lock(&heap_list_lock);
> >> +    /* check the name is unique */
> >> +    list_for_each_entry(h, &heap_list, list) {
> >> +            if (!strcmp(h->name, exp_info->name)) {
> >> +                    mutex_unlock(&heap_list_lock);
> >> +                    pr_err("dma_heap: Already registered heap named %=
s\n",
> >> +                           exp_info->name);
> >> +                    err_ret =3D ERR_PTR(-EINVAL);
> >> +                    goto err3;
> >> +            }
> >> +    }
> >> +
> >> +    /* Add heap to the list */
> >>      list_add(&heap->list, &heap_list);
> >>      mutex_unlock(&heap_list_lock);
> >>
> >>      return heap;
> >>
> >> +err3:
> >> +    device_destroy(dma_heap_class, heap->heap_devt);
> >>   err2:
> >>      cdev_del(&heap->heap_cdev);
> >>   err1:
> >> --
> >> 2.25.1
> >>
>


--=20
Thanks and regards,

Sumit Semwal (he / him)
Tech Lead - LCG, Vertical Technologies
Linaro.org =E2=94=82 Open source software for ARM SoCs
