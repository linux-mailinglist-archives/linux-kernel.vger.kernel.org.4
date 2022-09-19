Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEC15BD57C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiISUBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISUBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:01:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20130474E0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:01:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x94so761073ede.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=c6IevqNtnbzDiyRW7lXrEEgvxj4Paf+m3wyLUyOvFtQ=;
        b=epci3gXBx4eNQy87EnDQu11gF+cAEifb7rt203TmCic0Ep9FJVtcb5J7Uu7TnDwDl5
         tS6P4WfN7fXyLtIrA4RqEEpKCdRmv08qtKO4CDQt0gKXAlrVcl5fvjtSrcaZsmkXPx9o
         eQ0z5rplExVByY4WmTjk9gjfoIH9xh3l3fAW8BYPVv8gS3myMCj4bvnB1lsDPm22rXmH
         bQ8Xx6+jrAxy9AlEy8uhJuaDikRH5RljlTB4kwfH6OzRuTB6V0Edz8BcnkAZPHuRhLJQ
         OqcN7FkW9x2T4lu0F78uuRZmDb1BNceEpqQpbE8XIAwefYlGQRNBxMM46Lj63Cv3a+Nj
         8Bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=c6IevqNtnbzDiyRW7lXrEEgvxj4Paf+m3wyLUyOvFtQ=;
        b=fgLT0q45SAlLJ9dbcBSGNf8nB6kuVTPUWaCAgctlLrZRmbMqQhwxDNGneSLrrPyFhq
         bRFE2fbqzmlwsB1AAghvqT4LlZeip4lPbD+A+EZPlLNF5Qd7/9+odlF4g9TzZQXyWxGm
         +RBXEciPIM6wsMWH6pWKnYzDABA1Qq6EHdnV+NMPctBeKyINrRsvUgGBtM34IkbDZk9B
         mUPm41HJTP5RTnazFzXGFayyobjjHPOA5KPGdrk4BIER8ilEUdCJ0Be2txFr6B8OkHD0
         rKpPLHx8QcrfnXYI5gUGQi0AVtE1sHX5vPaAouJehjuCae4lKzwXZUS7+VCVkLwrXEBm
         FE+g==
X-Gm-Message-State: ACrzQf0VXquR8WJ8WZnNs6ufR+fAn6DYkvDG6FdPSR6pQHkWVSt8ZLZO
        QrRXBmpNa4Uhe7T9PQvc+C06eTpveXdn25Ku4n70dKy6YttW/g==
X-Google-Smtp-Source: AMsMyM432GTXJhu24+w3FQMmERRfp729bj1EIHB/O8nuXWhMtT+Ob1WPXBBNwwxfi2g1/JQHKt5juU6/7MYNcs++8ms=
X-Received: by 2002:a05:6402:270d:b0:452:2b68:90a0 with SMTP id
 y13-20020a056402270d00b004522b6890a0mr17213072edd.132.1663617665567; Mon, 19
 Sep 2022 13:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220916090434.701194-1-shiyn.lin@gmail.com>
In-Reply-To: <20220916090434.701194-1-shiyn.lin@gmail.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 19 Sep 2022 16:00:29 -0400
Message-ID: <CA+CK2bCuZ2wiDMD3P=xAuqKQCtrSuy5VVN4cOSvgeVjg1_zGzQ@mail.gmail.com>
Subject: Re: [PATCH] mm/page_table_check: Fix typos
To:     Chih-En Lin <shiyn.lin@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 5:02 AM Chih-En Lin <shiyn.lin@gmail.com> wrote:
>
> Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha

> ---
>  mm/page_table_check.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index e2062748791a..ecec2c7c8f44 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -53,7 +53,7 @@ static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
>  }
>
>  /*
> - * An enty is removed from the page table, decrement the counters for that page
> + * An entry is removed from the page table, decrement the counters for that page
>   * verify that it is of correct type and counters do not become negative.
>   */
>  static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
> @@ -86,7 +86,7 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
>  }
>
>  /*
> - * A new enty is added to the page table, increment the counters for that page
> + * A new entry is added to the page table, increment the counters for that page
>   * verify that it is of correct type and is not being mapped with a different
>   * type to a different process.
>   */
> --
> 2.37.1
>
