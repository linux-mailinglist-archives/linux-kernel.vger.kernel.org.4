Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE0D711D54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbjEZCDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEZCDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:03:16 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F618D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:03:14 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-33828a86ee2so75585ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685066594; x=1687658594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNtWvPa28u8wZV0f4gpjr4fry1u8z+TX9d18m7U9c/Y=;
        b=qWdwWqkCCTrSBfiqEXFlPREbqH9nZcRKo8eUTletLcLKGRfEd8BVHPYe6UHX/gvwE5
         miVrAiLJEcZdAICpaldRssz9r8HdxlCrAh114QYxjrmTn6IGRCfhb2Hv5J1Oeu3fy/SF
         7z+tw19d0oZdlyEH3kaTpOpEgoJ0jVXi+sl+5uhTsfr+i4f0gNx2IpMn7DsXa/eDyW7+
         lPNp09CxaZW14hXdDcH0MVYt5kN5tKRPhSn4XJ0KH+VLs+kG7DmmiC7igkEq+TrVl+q9
         qGRSI8gpv+Tfvu4yQyCeG60+FxbGNCF6cKkFvVJwNnynFUyHvVJUccJXZLSARhxIY6Af
         EPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685066594; x=1687658594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNtWvPa28u8wZV0f4gpjr4fry1u8z+TX9d18m7U9c/Y=;
        b=C1zTwuT1uk27nlV9teeE4VpF4B3gH6fimI3d94gnl7dpzYtijAeyI9g/uw68S0CTcW
         aodPPSo4Az13DXn+eCc62kfx40xABBHt0qUiQJbRyfxfOZWMAlCriGpAVaTl5NGPY6R7
         tt2a+Wl2HBBYLm1g4PWVeBhp1xyS6y2EQahj29ZC54pW8GT54vPWsCv5kmPZdgG24NZ9
         tmNc4//zCAoW/f/PZOs4hPnAk2R0aQJ3vxEH0MY4lEQsvNQLvBqX07ifkggx/YrwSlBu
         IfGyxrO5LJAfd8Pp62hoI1pkJB31SmMb8XqXnAv5Zk3AoXALJg4FGrQIfnmH9HhhZYOd
         O6Yw==
X-Gm-Message-State: AC+VfDykEZ+MSpQ4YwZNX+96pj3vuxKf9hZavMbiTIQnW8Ny8kNY8/bj
        JQ4c8BBxXFNnu1DgHyj1PwbP2S1sBMJX68FFOr+Bcg==
X-Google-Smtp-Source: ACHHUZ4iI2JJ36IHzsm7dTn9A+Vj+4OycDbPHRLJ+FJ28mIjDg1G3+RBJ+IHC1KZvYl8wi08Yr+oSlfn4P76WrDoK0A=
X-Received: by 2002:a05:6e02:1c2e:b0:33a:e716:a76c with SMTP id
 m14-20020a056e021c2e00b0033ae716a76cmr399ilh.26.1685066593951; Thu, 25 May
 2023 19:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
 <20230518110727.2106156-5-ryan.roberts@arm.com> <CAOUHufZaiTCxk4M4w5GaA-+5FoMnHZt+fzoU=cYCA1Ldk7CVEQ@mail.gmail.com>
 <692e9e7e-ee00-368b-6a31-60a895f7011c@arm.com>
In-Reply-To: <692e9e7e-ee00-368b-6a31-60a895f7011c@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 25 May 2023 20:02:37 -0600
Message-ID: <CAOUHufZDYB_9QBau+9w-ZQWjFTQpnMf-i-jJn-T7=nFizYGDhw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: Add new ptep_deref() helper to fully
 encapsulate pte_t
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev
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

On Fri, May 19, 2023 at 3:12=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 18/05/2023 20:28, Yu Zhao wrote:
> > On Thu, May 18, 2023 at 5:07=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> There are many call sites that directly dereference a pte_t pointer.
> >> This makes it very difficult to properly encapsulate a page table in t=
he
> >> arch code without having to allocate shadow page tables. ptep_deref()
> >> aims to solve this by replacing all direct dereferences with a call to
> >> this function.
> >>
> >> The default implementation continues to just dereference the pointer
> >> (*ptep), so generated code should be exactly the same. However, it is
> >> possible for the architecture to override the default with their own
> >> implementation, that can (e.g.) hide certain bits from the core code, =
or
> >> determine young/dirty status by mixing in state from another source.
> >>
> >> While ptep_get() and ptep_get_lockless() already exist, these are
> >> implemented as atomic accesses (e.g. READ_ONCE() in the default case).
> >> So rather than using ptep_get() and risking performance regressions,
> >> introduce an new variant.
> >
> > We should reuse ptep_get():
> > 1. I don't think READ_ONCE() can cause measurable regressions in this c=
ase.
> > 2. It's technically wrong without it.
>
> Can you clarify what you mean by technically wrong? Are you saying that t=
he
> current code that does direct dereferencing is buggy?

Sorry for not being clear.

I think we can agree that *ptep is volatile. Not being treated as such
seems a bad idea to me. I don't think it'd cause any real problems --
most warnings KCSAN reported didn't either, but we fixed them anyway.
So should we fix this case as well while we are at it.

> I previously convinced myself that the potential for the compiler generat=
ing
> multiple loads was safe because the code in question is under the PTL so =
there
> are no concurrent stores. And we shouldn't see any tearing for the same r=
eason.
>
> That said, if there is concensus that we can just use ptep_get() (=3D=3D
> READ_ONCE()) everywhere, then I agree that would be cleaner. Does anyone =
object?

(No objection to NOT using it either. Just a recommendation, since
it's already there.)
