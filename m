Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8670D097
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjEWBiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEWBiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:38:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591088E
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:37:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-510b4e488e4so524683a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684805878; x=1687397878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NL8vu8VBVPDg4x9BcHt1EVriPSKQTsOTL4qlCVnshw=;
        b=wTpwRB6UoOOPzch2bukvysP5VjZ+AbcBIlgsG/SqE45ZxBbf2nXV/11IP7HP820SNT
         93OmpccUwJkgBtq9us2bSqCgpb1OwgY4s7QsmOsCl74L/3x30+K+4oUS1JUyzjor16jA
         RAbdPGALr9MG0L2IHsZTCCXmSWkm/BaWovUgIhpfU2hFoinM+ztpxEw/WYN0p1v3dnt5
         1VR6zDRIZfxuNy1GPP36jnvmwVy1DULydYrh+i+PqpJsr9yOfIFrDlsTUQN0LVoQ+ops
         pNS1PKyDTG+Y+rdm7zbHPiget97OyE9ueAWrzs1PGND9mGRBVbexxMmkUNwI4PXzaqyr
         ocgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684805878; x=1687397878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NL8vu8VBVPDg4x9BcHt1EVriPSKQTsOTL4qlCVnshw=;
        b=XoRdm+MZztdqqwwh9ulAcdjhOMeUp6tLNKDpUgOv9GAn4JNCU5VmIpo1h3Sbs4zXMN
         ztsW4SqE3okWP9X1QOSBJNtnGpM0wktxigk44mjAl9HFEgn3T/hj3VZNoJ6+RTEXmFIm
         GgVuoihQrKrNqBTdLUSv5LTFGkGNVy/O/f8pInNCOaDJBWkbKBuHeurHOuFSsvzXCW4z
         TLr/YJONhd4hM2Yd0GAWDSZO4anvWsE4PcCbStcRzuoxdG6hehe6MrkKJidshpkZtNbj
         Hz2qtaCgVZK1w49D3nIgW1M1Fke6wWUSjSkTwEzl8hexbiz9nvo55PcKkKMTy3ln1ESB
         gqEg==
X-Gm-Message-State: AC+VfDzLe9A2XMqLaOvmeoneokvb0LrzhA/g5HEd1x2J66NVRBonIEa2
        Eu2bpUD6zwJVIx0WrgT9Cr6sY1sEB6+DphS98e3ZeA==
X-Google-Smtp-Source: ACHHUZ5kUzwUSGf4F6uXfzN4mxvSFIq6nOPaFYpP9NQsoqdanwYd4KHOtQf1Ky9F8NwZItK6VPWk7oPjCtqDRvAoQ5s=
X-Received: by 2002:a17:907:2d28:b0:970:d85:59e9 with SMTP id
 gs40-20020a1709072d2800b009700d8559e9mr3706447ejc.5.1684805877754; Mon, 22
 May 2023 18:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230522070905.16773-1-ying.huang@intel.com> <20230522070905.16773-6-ying.huang@intel.com>
In-Reply-To: <20230522070905.16773-6-ying.huang@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 22 May 2023 18:37:21 -0700
Message-ID: <CAJD7tkaTm+YRPyh2ew2KoL=vruFnAMb6TM1OR1g0u-CqdUYi0w@mail.gmail.com>
Subject: Re: [PATCH -V2 5/5] swap: comments get_swap_device() with usage rule
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
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

On Mon, May 22, 2023 at 12:09=E2=80=AFAM Huang Ying <ying.huang@intel.com> =
wrote:
>
> The general rule to use a swap entry is as follows.
>
> When we get a swap entry, if there isn't some other way to prevent
> swapoff, such as page lock for swap cache, page table lock, etc., the
> swap entry may become invalid because of swapoff.  Then, we need to
> enclose all swap related functions with get_swap_device() and
> put_swap_device(), unless the swap functions call
> get/put_swap_device() by themselves.
>
> Add the rule as comments of get_swap_device().
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---
>  mm/swapfile.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4dbaea64635d..0c1cb935b2eb 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1219,6 +1219,13 @@ static unsigned char __swap_entry_free_locked(stru=
ct swap_info_struct *p,
>  }
>
>  /*
> + * When we get a swap entry, if there isn't some other way to prevent
> + * swapoff, such as page lock for swap cache, page table lock, etc.,
> + * the swap entry may become invalid because of swapoff.  Then, we
> + * need to enclose all swap related functions with get_swap_device()
> + * and put_swap_device(), unless the swap functions call
> + * get/put_swap_device() by themselves.
> + *
>   * Check whether swap entry is valid in the swap device.  If so,
>   * return pointer to swap_info_struct, and keep the swap entry valid
>   * via preventing the swap device from being swapoff, until
> @@ -1227,9 +1234,8 @@ static unsigned char __swap_entry_free_locked(struc=
t swap_info_struct *p,
>   * Notice that swapoff or swapoff+swapon can still happen before the
>   * percpu_ref_tryget_live() in get_swap_device() or after the
>   * percpu_ref_put() in put_swap_device() if there isn't any other way
> - * to prevent swapoff, such as page lock, page table lock, etc.  The
> - * caller must be prepared for that.  For example, the following
> - * situation is possible.
> + * to prevent swapoff.  The caller must be prepared for that.  For
> + * example, the following situation is possible.
>   *
>   *   CPU1                              CPU2
>   *   do_swap_page()
> --
> 2.39.2
>
>

Thanks for clarifying the code!

With David's comments:
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
