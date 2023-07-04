Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABCF746A55
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGDHLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGDHLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:11:51 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A92BFB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:11:50 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40371070eb7so54761cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688454709; x=1691046709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwbZIzQvk26i3CiKr+ou8Vd2tamJaYv2XqL+VObr8Oo=;
        b=nfAUOZ6GBTCembuc+7TJeZjhFynsYIaOL3YYoBv0gGCmBVQ+lgkvZIzdYF8xEQvluX
         Ccqse6Lusr7PriYGaKZT7/GiGmBdRAAs3Z+JOv3aGMSrpSsSGbPUN6gXPdb5OCUf9U40
         +nO0tCz19IB4x8EsSDIeqF55fnffrZL3CKwkOeP2fNwPwsLdIrMJUX6h7eKpa0TCzbOB
         VZdJDOrVhQFT4hOVxioVPbi9+qJ+V+iFPMhmffbmN7MMq7Qq6OYhZ4MN4h8uTt+xjD0A
         m2VWFSrTP9fHtizv7olFsLTPti4+c7l65IJLWpcLUnVTxfu9T8pLRq4RI2aabru0+O/M
         YSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688454709; x=1691046709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwbZIzQvk26i3CiKr+ou8Vd2tamJaYv2XqL+VObr8Oo=;
        b=i2o3UGkArCOKm/0SVWWr7gQP7Htuc3QBoXixv1VO18cTWE1ZkHVwT5ZLMFUS+wsiUt
         PhTy2P4S8kMdjdeeTfIL3Z5YvDnpA/UWpfH5xYsokjk3sKClSdXDq14Ix2xzHZZ84sdL
         Yc8AQo5V5VWDl+FF6RCKjlZ00XaBzcHRcAKL2p2Ntz632+6/bU2tD3+xwxwzH97ODdyJ
         nozTkmwy8rTeVRAZzp/jUYboXmBUXLIzUmQ187p0sbMOK6sKm9+C1aLyxUUba5B4psIh
         5XNMPpZcIciz9UkE3GASV+Ukgh1UcUmqPU1F+uCa0xa9rmLvIwVuVhiKzBW/RNndn98J
         nKzg==
X-Gm-Message-State: ABy/qLZ2CoWT7IvlB4T4U1gYSMirzFQvt4k0BEx3QX1H/ca5hmHq//qT
        2gV32tWHf89sQynn3Uuj0bSMcnLDGfjkXwpDNVs/Yw==
X-Google-Smtp-Source: APBJJlGQVPweFXxkxiOxLO8wpewZiGr/Zfo58d7NkDfhJIN4+SwzmiQa53m54nW31M0YQ3nx1JivC83/e516ZifpHn0=
X-Received: by 2002:a05:622a:188b:b0:3f5:49b6:f18d with SMTP id
 v11-20020a05622a188b00b003f549b6f18dmr52585qtc.11.1688454709502; Tue, 04 Jul
 2023 00:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <CAOUHufYB2kB0r9hhSbzfEzdF85MkXVfWoFOhy3LwLfJ5Qo8H6g@mail.gmail.com> <69aada71-0b3f-e928-6413-742fe7926576@intel.com>
In-Reply-To: <69aada71-0b3f-e928-6413-742fe7926576@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 4 Jul 2023 01:11:13 -0600
Message-ID: <CAOUHufYsOdywAJMxdh6W-=uLykD=7JrUwgBvUJWvfWJeQ5XxnA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 12:22=E2=80=AFAM Yin, Fengwei <fengwei.yin@intel.com=
> wrote:
>
> On 7/4/2023 10:18 AM, Yu Zhao wrote:
> > On Mon, Jul 3, 2023 at 7:53=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> Hi All,
> >>
> >> This is v2 of a series to implement variable order, large folios for a=
nonymous
> >> memory. The objective of this is to improve performance by allocating =
larger
> >> chunks of memory during anonymous page faults. See [1] for background.
> >
> > Thanks for the quick response!
> >
> >> I've significantly reworked and simplified the patch set based on comm=
ents from
> >> Yu Zhao (thanks for all your feedback!). I've also renamed the feature=
 to
> >> VARIABLE_THP, on Yu's advice.
> >>
> >> The last patch is for arm64 to explicitly override the default
> >> arch_wants_pte_order() and is intended as an example. If this series i=
s accepted
> >> I suggest taking the first 4 patches through the mm tree and the arm64=
 change
> >> could be handled through the arm64 tree separately. Neither has any bu=
ild
> >> dependency on the other.
> >>
> >> The one area where I haven't followed Yu's advice is in the determinat=
ion of the
> >> size of folio to use. It was suggested that I have a single preferred =
large
> >> order, and if it doesn't fit in the VMA (due to exceeding VMA bounds, =
or there
> >> being existing overlapping populated PTEs, etc) then fallback immediat=
ely to
> >> order-0. It turned out that this approach caused a performance regress=
ion in the
> >> Speedometer benchmark.
> >
> > I suppose it's regression against the v1, not the unpatched kernel.
> From the performance data Ryan shared, it's against unpatched kernel:
>
> Speedometer 2.0:
>
> | kernel                         |   runs_per_min |
> |:-------------------------------|---------------:|
> | baseline-4k                    |           0.0% |
> | anonfolio-lkml-v1              |           0.7% |
> | anonfolio-lkml-v2-simple-order |          -0.9% |
> | anonfolio-lkml-v2              |           0.5% |

I see. Thanks.

A couple of questions:
1. Do we have a stddev?
2. Do we have a theory why it regressed?
Assuming no bugs, I don't see how a real regression could happen --
falling back to order-0 isn't different from the original behavior.
Ryan, could you `perf record` and `cat /proc/vmstat` and share them?
