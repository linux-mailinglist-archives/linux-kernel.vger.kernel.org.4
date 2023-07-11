Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8099474FAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjGKWXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKWXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:23:11 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95A910FA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:23:05 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5700b15c12fso71725357b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689114185; x=1691706185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/GtFb0EqNYu9Ozo0dSp+bce5y10je/SnpQEJxWby1c=;
        b=PA+wbm1/vKXTWoURcR4YLVKRbPS4NYL89xg1LcdSjSXGTOIbJsyPT0jnF5DAtptEjs
         HlUQ2PCyfmiLOAeXyc7/PGo7uTaOQr3Gi85X78rf0hchLpcHH/eOk9MMv2S9adwTtieu
         xf9fy1r+AYNS/LmNYZyoamQOHp8cItfQ7nmo+F0PLRPPSJBBB3tas3aXYlVwiHLqhAVy
         0VT+CRUdGLwJtXbZQ6QCpP0VZtTB6fsru0GYFIAhwXUjYYxOk0GwXVqEdDVmGyjB5cXl
         g4TADxuLnA4kC+wve/uLFqvdGulI74qIhETkD4T2SBS30WfwyF7QRx23+/i+ySAFYi9v
         dfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689114185; x=1691706185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/GtFb0EqNYu9Ozo0dSp+bce5y10je/SnpQEJxWby1c=;
        b=HZhpzHDtJFLdcVhUy+MelINp+Oj7ZfB9yxP40OmJiNsbP8adDinVZTB/nTpfDfRy//
         lRY0bMiaNNMkbe4/0okttRMKNHx+oSmQKy1Q8pl56pN2RVfM7qZ49VP+L8DBOJQje1oZ
         L93jsoIlS+hBx1JZYAJ6QifMTL1sTvM6OrjD2oDOeeM0jDRiN+xMnffKPqWM/VYy73z8
         rnZm9tlurU8/wiNnnx4Mk8MRGpY/gRMAEHB0Em57Fabtbv/6/VWTzVSgBABI7qEGiW1S
         xUkTmgvxtU2wwXKUg1AToZwD51S9Sb4FJwRdKr2tdR//Cd/tvkzshHCbhNwWsF0p9IaH
         pSOQ==
X-Gm-Message-State: ABy/qLYFtEKSo3/ljxTlVJGWFdh9c174+B5AnexPftH5g/FOrffzEmWY
        CfgzAMysQgzW9mPRR2Nc0KxmvhTyyVCbXbg+SD0SEg==
X-Google-Smtp-Source: APBJJlHSGSxkeoM3MDBUA7qbKDAppZt0q6fwagWhE8zrPKtjQWQ5EfKY2no5Q3+nwz29jpL/GgjTtCayWVPy55OSBkw=
X-Received: by 2002:a81:6ad6:0:b0:56d:297e:7c8c with SMTP id
 f205-20020a816ad6000000b0056d297e7c8cmr15936031ywc.8.1689114184945; Tue, 11
 Jul 2023 15:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230707201904.953262-1-jiaqiyan@google.com> <20230707201904.953262-3-jiaqiyan@google.com>
 <6682284d-7ad3-9b59-687d-899f4d08d911@huawei.com> <CACw3F50k9WJr7WgHS-dRxJRfuXPbq2adUBLeFcKRjmm2D6qf-g@mail.gmail.com>
 <CACw3F52Pj+SeB+dD2Cjkr-bX-OZkmCpL1s6SO1aHDvaD37YZBg@mail.gmail.com> <20230711180159.GA3887@monkey>
In-Reply-To: <20230711180159.GA3887@monkey>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Tue, 11 Jul 2023 15:22:52 -0700
Message-ID: <CACw3F53s6pX50TV3Lq79=THsxff0T1eS2wUdLZSp1JL8gFHQyg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/hwpoison: check if a subpage of a hugetlb folio
 is raw HWPOISON
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, songmuchun@bytedance.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:02=E2=80=AFAM Mike Kravetz <mike.kravetz@oracle.=
com> wrote:
>
> On 07/11/23 10:05, Jiaqi Yan wrote:
> > On Mon, Jul 10, 2023 at 8:16=E2=80=AFAM Jiaqi Yan <jiaqiyan@google.com>=
 wrote:
> > > On Fri, Jul 7, 2023 at 7:57=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.c=
om> wrote:
> > > > On 2023/7/8 4:19, Jiaqi Yan wrote:
> > > >
> > > > > +             if (subpage =3D=3D p->page) {
> > > > > +                     ret =3D true;
> > > > > +                     break;
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     return ret;
> > > > >  }
> > > >
> > > > It seems there's a race between __is_raw_hwp_subpage and unpoison_m=
emory:
> > > >   unpoison_memory               __is_raw_hwp_subpage
> > > >                                   if (!folio_test_hwpoison(folio)) =
-- hwpoison is set
> > > >     folio_free_raw_hwp            llist_for_each_entry_safe raw_hwp=
_list
> > > >       llist_del_all                 ..
> > > >     folio_test_clear_hwpoison
> > > >
> > >
> > > Thanks Miaohe for raising this concern.
> > >
> > > > But __is_raw_hwp_subpage is used in hugetlbfs, unpoison_memory coul=
dn't reach here because there's a
> > > > folio_mapping =3D=3D NULL check before folio_free_raw_hwp.
> > >
> > > I agree. But in near future I do want to make __is_raw_hwp_subpage
> > > work for shared-mapping hugetlb, so it would be nice to work with
> > > unpoison_memory. It doesn't seem to me that holding mf_mutex in
> > > __is_raw_hwp_subpage is nice or even absolutely correct. Let me think
> > > if I can come up with something in v4.
> >
> > At my 2nd thought, if __is_raw_hwp_subpage simply takes mf_mutex
> > before llist_for_each_entry, it will introduce a deadlock:
> >
> > unpoison_memory                       __is_raw_hwp_subpage
> >   held mf_mutex                         held hugetlb_lock
> >   get_hwpoison_hugetlb_folio            attempts mf_mutex
> >     attempts hugetlb lock
> >
> > Not for this patch series, but for future, is it a good idea to make
> > mf_mutex available to hugetlb code? Then enforce the order of locking
> > to be mf_mutex first, hugetlb_lock second? I believe this is the
> > current locking pattern / order for try_memory_failure_hugetlb.
>
> I think only holding mf_mutex in __is_raw_hwp_subpage would be sufficient
> to prevent races with unpoison_memory.  memory failure code needs to take
> both mf_mutex and hugetlb_lock.  The hugetlb lock is to prevent hugetlb
> page state changes.  IIUC, __is_raw_hwp_subpage is only taking hugetlb_lo=
ck
> to prevent races with memory failure code.

Thanks Mike, I think mf_mutex is a simple and correct solution. I will
drop hugetlb_lock from __is_raw_hwp_subpage in v4.

>
> Of course, I could be missing something as there are subtle issues with
> locking in the memory failure code.
> --
> Mike Kravetz
