Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C873F614455
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 06:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKAFjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 01:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKAFjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 01:39:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD148FD27
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:39:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d24so12648161pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GooxocOMqoXlKVZTwGoGZ/Eyf8dLJyIprbhLabvf/YY=;
        b=bVUoBx6xICMR9Hhh1/Zth+k71EuBM78A0dyKnNRgRzmWnY9eaayexFtY5QGLbrjlTe
         0ZTf6aVADDunFYrFPg2FPXZGMGCJXmCYeg9ZpFh98LV+LRkR3HHhBVqkHDag4oyNOvZe
         DBnxjxLFhfONizT+kOgUKdptg44w+1dgu1Li1t5BPZGZ9LnVYSmo8QPOCUF591qFWhnx
         s3Zc6J30F1AS5kfT+seGjeCK+JXJGr1hcC6N1L/mx1OJz3NiJOWiGHFR8TnvTXZGTa+Z
         s7nq+CqmoaSAT5nLaTFSpBs1RnpC6zj5ZAkdVr16+9nfltxneunAl3iK+N7NJdqvfV0C
         9Npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GooxocOMqoXlKVZTwGoGZ/Eyf8dLJyIprbhLabvf/YY=;
        b=yOZy0XYpx4cuD+RhWyr9sJ02OuR0P9wB0fhtsrj3LCOVQicBdv0IeAZ3TmOoIjj+zt
         ytIkm+RaE2SK07IZNoUoWduho1A8W5XgJbexAC60CraNCwxsZMTvPH3JN3QzE6Phi+R3
         ocR52uO+4Qd7BU4T6c2CYX6DpULHTgeBkZ/L0yGQFzG9GVjvV5OPnag/PHk3APQB0JBA
         Kez/42Yr+b3b+UpKiPuw2kajze4bAhebBfSPFd1hxoPndX2x6GxpunRtAA2ldYSXTAss
         TqBf9m8gmFxeNZM/rtqNbNhnzcw1zeyr51Vn6VgLPdr2RSgQoleub3UJMb7jWFrRxEKk
         EpAg==
X-Gm-Message-State: ACrzQf36NmQuT+2Ha3AbyXw9hGl6P+I065Rb1c8nSyJ9aA5S/HvqLCEx
        /361n7M7lsJ6fRMXdggLVZw=
X-Google-Smtp-Source: AMsMyM4UVgMrxIzU+XbzR5BB5pUNNdkwI7lrtNtDtfuV+w2acIw49L5bZT7c6Hw0qNZZcClC+vJ9bw==
X-Received: by 2002:a17:90a:2bc9:b0:212:8210:c92d with SMTP id n9-20020a17090a2bc900b002128210c92dmr18433376pje.38.1667281175018;
        Mon, 31 Oct 2022 22:39:35 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902c60a00b0017f48a9e2d6sm5345373plr.292.2022.10.31.22.39.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2022 22:39:34 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH RFC 10/10] mm/hugetlb: Comment at rest huge_pte_offset()
 places
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20221030213045.335680-1-peterx@redhat.com>
Date:   Mon, 31 Oct 2022 22:39:33 -0700
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D896ED0-5600-4E55-8509-3F0E355FF692@gmail.com>
References: <20221030212929.335473-1-peterx@redhat.com>
 <20221030213045.335680-1-peterx@redhat.com>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30, 2022, at 2:30 PM, Peter Xu <peterx@redhat.com> wrote:

> +		/* With vma lock held, safe without RCU */
> 		src_pte =3D huge_pte_offset(src, addr, sz);

Just another option to consider: you can create an inline function
huge_pte_offset_locked_mm(), which would do the lockdep_assert_held_*().

I personally would prefer it, since it would clarify exactly the lock =
you
care about and "make the code document itself=E2=80=9D.
=20=
