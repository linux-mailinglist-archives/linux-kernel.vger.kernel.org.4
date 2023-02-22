Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5137A69F2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBVKom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjBVKoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:44:34 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0839A37F02
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:44:32 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f13so27986968edz.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzO36xcFKCsDz9emB0ii8Ix0nj2SnY6adDGqiFZxsWA=;
        b=FOFjqxzv7otNb/Bhs32onm+cVr3Z+HSHluN5DyMdMFFxMUGsZm/A917jXTKgFCommA
         LhyEY07JyaXO2PbcIb1P8MpPyJwujzsS/dbdxq4bWe7Fs2vWrl00ZjNoeR8N+5oYLLkQ
         KGqpBZb53tBQGLUqkADf0IfRakmtC2lMr+IV0an+x1lT66CGlh5EouSsBnLoBnBBWrqI
         42EuvieUePBQaoR6cvY0bGfuWDqntr8PgSSVNsGNdCgQmOyuuQ3pE36mtT4ITYENA3pv
         mr9cHUAPJZ5T2iLXyZkWoAHBkDHXgk/jOR06wbPBLZA1aGpdURn1PSgFwn5CuM0AAVKY
         gNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzO36xcFKCsDz9emB0ii8Ix0nj2SnY6adDGqiFZxsWA=;
        b=gGICFapCRpjpT8pCcIlrdi1mdpEd0NHqbPL19nYgQ83aVmuisgB+WR6Guyuqx7yCoU
         CMBjM8KtxzKDUgax8lwJpGONPv61KLdgccp4Fp6DocwbagSMAnq36+wPtq5uEK2EoOKV
         uECVL1/mo+GKlHHH3k351KV6XXND71kasqc4sg1U2iV+lMkXw6CxSEPJP1p0cu5h3H5C
         uo4p9kz5LENsvhRKtHrbaZXZDaC9bjFaqCDr8IpQ5JRr7vYOLwjEcPc2wyDPzoUbq9ct
         QLGBa7X/ZairavtPnQ/6Yv5wF4dyg2k5A+9KcvV7uojaiG/Fm1b7XgQQ8JbUUmgftfM1
         UcZA==
X-Gm-Message-State: AO0yUKVP+7ysd4krdNGWkHqa5iLyyiYH/F91ZnjB8uonI9b+3jZgIFzd
        SaXa2vTahQhLU7eADvuhR3fP8yPOlg9mrRmPE+LaSQ==
X-Google-Smtp-Source: AK7set8JsoC+HI/BdAzA/PhGKp9VlBhkwwnETeYznXMWZQSuX9dNWeeM54IT78n6bi2eZkg4hBzTXniZ9OKPO7ic9Ew=
X-Received: by 2002:a50:f619:0:b0:4ac:b74b:a6a3 with SMTP id
 c25-20020a50f619000000b004acb74ba6a3mr3415436edn.0.1677062670271; Wed, 22 Feb
 2023 02:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com> <CABb0KFEgsk+YidSXBYQ9mM8nVV6PuEOQf=bbNn7hsoG1hUeLZg@mail.gmail.com>
 <36ddfd75-5c58-197b-16c9-9f819099ea6d@collabora.com> <CABb0KFGWi0dtgXZ-AeUuHb55EgnwTu3JfJ9cW3ftCqezKi8dAQ@mail.gmail.com>
 <6d2b40c6-bed9-69a6-e198-537b50953acd@collabora.com>
In-Reply-To: <6d2b40c6-bed9-69a6-e198-537b50953acd@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 22 Feb 2023 11:44:18 +0100
Message-ID: <CABb0KFF+AEKijaXMjDpQLKyAdueJ93kf9QLfOouKHaPPwvfw_w@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrei Vagin <avagin@gmail.com>, Mike Rapoport <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Danylo Mocherniuk <mdanylo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 at 11:11, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 2/21/23 5:42=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Tue, 21 Feb 2023 at 11:28, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> Hi Micha=C5=82,
> >>
> >> Thank you so much for comment!
> >>
> >> On 2/17/23 8:18=E2=80=AFPM, Micha=C5=82 Miros=C5=82aw wrote:
> > [...]
> >>> For the page-selection mechanism, currently required_mask and
> >>> excluded_mask have conflicting
> >> They are opposite of each other:
> >> All the set bits in required_mask must be set for the page to be selec=
ted.
> >> All the set bits in excluded_mask must _not_ be set for the page to be
> >> selected.
> >>
> >>> responsibilities. I suggest to rework that to:
> >>> 1. negated_flags: page flags which are to be negated before applying
> >>> the page selection using following masks;
> >> Sorry I'm unable to understand the negation (which is XOR?). Lets look=
 at
> >> the truth table:
> >> Page Flag       negated_flags
> >> 0               0                       0
> >> 0               1                       1
> >> 1               0                       1
> >> 1               1                       0
> >>
> >> If a page flag is 0 and negated_flag is 1, the result would be 1 which=
 has
> >> changed the page flag. It isn't making sense to me. Why the page flag =
bit
> >> is being fliped?
> >>
> >> When Anrdei had proposed these masks, they seemed like a fancy way of
> >> filtering inside kernel and it was straight forward to understand. The=
se
> >> masks would help his use cases for CRIU. So I'd included it. Please ca=
n you
> >> elaborate what is the purpose of negation?
> >
> > The XOR is a way to invert the tested value of a flag (from positive
> > to negative and the other way) without having the API with invalid
> > values (with required_flags and excluded_flags you need to define a
> > rule about what happens if a flag is present in both of the masks -
> > either prioritise one mask over the other or reject the call).
> At minimum, one mask (required, any or excluded) must be specified. For a
> page to get selected, the page flags must fulfill the criterion of all th=
e
> specified masks.

[Please see the comment below.]

[...]
> Lets translate words into table:
[Yes, those tables captured the intent correctly.]

> > BTW, I think I assumed that both conditions (all flags in
> > required_flags and at least one in anyof_flags is present) need to be
> > true for the page to be selected - is this your intention?
> All the masks are optional. If all or any of the 3 masks are specified, t=
he
> page flags must pass these masks to get selected.

This explanation contradicts in part the introductory paragraph, but
this version seems more useful as you can pass all masks zero to have
all pages selected.

> > The example
> > code has a bug though, in that if anyof_flags is zero it will never
> > match. Let me fix the selection part:
> >
> > // calc. a mask of flags that have expected ("active") values
> > tested_flags =3D page_flags ^ negated_flags;
> > // are all required flags in "active" state? [=3D=3D all zero when nega=
ted]
> > if (~tested_flags & required_mask)
> >   skip page;
> > // is any extra flag "active"?
> > if (anyof_flags && !(tested_flags & anyof_flags))
> >   skip page;
> >
> After taking a while to understand this and compare with already present
> flag system, `negated flags` is comparatively difficult to understand whi=
le
> already present flags seem easier.

Maybe replacing negated_flags in the API with matched_values =3D
~negated_flags would make this better?

We compare having to understand XOR vs having to understand ordering
of required_flags and excluded_flags.
IOW my proposal is to replace branches in the masks interpretation (if
in one set then matches but if in another set then doesn't; if flags
match ... ) with plain calculation (flag is matching when equals
~negated_flags; if flags match the masks ...).

Best Regards
Micha=C5=82 Miros=C5=82aw
