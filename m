Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9EF6DEB84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjDLGGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDLGGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:06:07 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7C8F7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:06:04 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230412060600epoutp02adbf0cf7f3b8c990b992750b795e0278~VGtpFX-n72087420874epoutp02h
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:06:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230412060600epoutp02adbf0cf7f3b8c990b992750b795e0278~VGtpFX-n72087420874epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681279560;
        bh=yq5mp7GhrYcBNCC0qI9amcCJzqtuRuAuGhzeC4ILyrg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ffKsvTjlGbA+RYBnZFNOm3FcNISYu957csyrAD0X/DJwHvqkyrmq9jajd13buvzkP
         SM+gyGKs8cbyLtc5vlX01sk+dDeAsHPCP1BpiL7nfEhdaDBdVEcdqIaNA6nPq6WK76
         2QgGEmsFNZnYWkSroMVVZ3v3y/03ywKxPLgSnTa8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230412060559epcas2p421d7d2d3d01b9209c3ecc2889b0d07b8~VGtoUSRsm2238022380epcas2p4R;
        Wed, 12 Apr 2023 06:05:59 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.70]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PxBzC299Sz4x9Px; Wed, 12 Apr
        2023 06:05:59 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.DF.10686.74A46346; Wed, 12 Apr 2023 15:05:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230412060558epcas2p254358bbd869eec9fb9907db6abac459a~VGtnJANbP1322213222epcas2p2H;
        Wed, 12 Apr 2023 06:05:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230412060558epsmtrp23b01e7a0419ddd199bf75900699e1de6~VGtnIJin82679626796epsmtrp2j;
        Wed, 12 Apr 2023 06:05:58 +0000 (GMT)
X-AuditID: b6c32a46-ed1f8700000029be-96-64364a47ef4a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.DB.08279.64A46346; Wed, 12 Apr 2023 15:05:58 +0900 (KST)
Received: from KORCO118546 (unknown [10.229.38.108]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230412060558epsmtip24a1b3366139bb249225b7e43fc4990a5~VGtm6ssYS0489104891epsmtip27;
        Wed, 12 Apr 2023 06:05:58 +0000 (GMT)
From:   "hoyoung seo" <hy50.seo@samsung.com>
To:     <andrey.konovalov@linux.dev>
Cc:     <akpm@linux-foundation.org>, <andreyknvl@gmail.com>,
        <andreyknvl@google.com>, <elver@google.com>, <eugenis@google.com>,
        <glider@google.com>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <vbabka@suse.cz>, <bhoon95.kim@samsung.com>, <sc.suh@samsung.com>
Subject: Re: [PATCH v2 10/18] lib/stackdepot: rename handle and pool
 constants
Date:   Wed, 12 Apr 2023 15:05:58 +0900
Message-ID: <000401d96d04$d991ad40$8cb507c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adls/lQR+xwTsUp4SriSKyfuc/JN4w==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRmVeSWpSXmKPExsWy7bCmha67l1mKwf5z3BZz1q9hs3h68jKb
        xfeJ09ktenbvZLL4uvQZq0Xbme2sFgcXvGOxaP+4l9lixbP7TBaXd81hs7i35j+rRdfdG4wW
        sxv7GB14PXbOusvusWBTqceeiSfZPDZ9msTucWLGbxaPhQ1TmT36tqxi9Diz4Ai7x+dNcgGc
        Udk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUB3KymU
        JeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOy
        M94eOslcMMG44uDipUwNjJN1uxg5OSQETCTev1rHBGILCexglNi3yqmLkQvI/gRk//vOAuF8
        Y5TYuWciUBUHWMfEqfIQ8b2MEhvP7mOGcF4ySvzs62cDGcUmoCXR/3YLmC0ioCAx9cMedpAi
        ZoF1TBIvpv5gAUkICwRI/F1+gBHEZhFQlZjcuQXsDl4BS4nrH06zQtiCEidnPgGrZxbQlli2
        8DUzxN0KEj+fLmOFWKAn8aWlmxmiRkRidmcb2EUSAkc4JJ5M6WeFaHCRaDp3mB3CFpZ4dXwL
        lC0l8fndXjYIO1uicc9aqHiFxNzNkxkhbGOJWc/aGUHeZxbQlFi/Sx8SEsoSR25BncYn0XH4
        LztEmFeio00IolFJ4szc21BhCYmDs3Mgwh4Sa6Z/Z5zAqDgLyY+zkPw4C8kvsxDWLmBkWcUo
        llpQnJueWmxUYASP6uT83E2M4ASt5baDccrbD3qHGJk4GA8xSnAwK4nw/nAxTRHiTUmsrEot
        yo8vKs1JLT7EaAoM9YnMUqLJ+cAckVcSb2hiaWBiZmZobmRqYK4kzittezJZSCA9sSQ1OzW1
        ILUIpo+Jg1Oqgck6465g5Ua1ym+uSx8kvPyWZ6eulKrku7XIzSZHKdS4NHlb+KOiTcdrLq2T
        kV8o11FwIzq0p6QyfM0r+VM/jATdvW3yA67VHdXX+NaxwsxXM/yhguXiUy8DLaIq2R+9vhvx
        edGm/wGmbtVhTBvmvGjb+0dCv6do2a5fse9uf71zep2FaEqZbGL8Ridvo28WL+w5DwStD1lV
        PleFce6f62rftifIbl+xPefmnLvmk/fM31hbXDk7+n8mb57G2rllky63zlP0K/VTqZ2xzXS+
        CAf36u9Laq+csNB7aW0ZmMfPU6q612HDl+zJj9lmvhZ3f+sc/lXiVsivaQXhHyU0Hn+YnfFX
        cdWHz/mpqjZ3zZVYijMSDbWYi4oTAej10KlZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvK6bl1mKweKFMhZz1q9hs3h68jKb
        xfeJ09ktenbvZLL4uvQZq0Xbme2sFgcXvGOxaP+4l9lixbP7TBaXd81hs7i35j+rRdfdG4wW
        sxv7GB14PXbOusvusWBTqceeiSfZPDZ9msTucWLGbxaPhQ1TmT36tqxi9Diz4Ai7x+dNcgGc
        UVw2Kak5mWWpRfp2CVwZt08vZS/YYFCx/X9lA+NmrS5GDg4JAROJiVPluxi5OIQEdjNKrHz7
        iq2LkRMoLiHxf3ETE4QtLHG/5QgrRNFzRomll5tYQBJsAloS/W+3gDWICChITP2whx2kiFlg
        D5PE49U/wRLCAn4SC89/ALNZBFQlJnduAZvKK2Apcf3DaVYIW1Di5MwnYEOZBbQleh+2MsLY
        yxa+Zoa4QkHi59NlrBDL9CS+tHQzQ9SISMzubGOewCg4C8moWUhGzUIyahaSlgWMLKsYJVML
        inPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYLjT0tzB+P2VR/0DjEycTAeYpTgYFYS4f3hYpoi
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9OVxKV3vXo8
        DtwLuGVw2e/1PPsuKYP060snb1ucpvc5i33uIa51B1WNhZ58lPgpOM9xrtKko2dNnx9l2p5Z
        ZZq2c6dd+QnXfzOZnfIbJ63Zuuzq3GsLdmqlrm02NuYz9plff/NPVlRBbFOH4qLv/3wEP+ut
        jp+s2TE52uYEg96VI2WbDMRX5Am82s/unbH2FKt9rEh4/f2v9x1Mn0jd912za/nL22dcJ1k8
        qp56c2/mY31+s56MKy6bi5g2rPwvvnR/WNNJ1Ty5JEVLO02PCt6NuccNPzHdWvfmchj3YWet
        9XcqSpkSV++3D1T77WTztlggrFKD3+9MTTJf5aa6mLN11mzvd2w+m8Mm7vcg464SS3FGoqEW
        c1FxIgC3INncLgMAAA==
X-CMS-MailID: 20230412060558epcas2p254358bbd869eec9fb9907db6abac459a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230412060558epcas2p254358bbd869eec9fb9907db6abac459a
References: <CGME20230412060558epcas2p254358bbd869eec9fb9907db6abac459a@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+=23define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
+
+=23define DEPOT_VALID_BITS 1
+=23define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages */
+=23define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT + DEPOT_POOL_ORDER))
+=23define DEPOT_STACK_ALIGN 4
+=23define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_A=
LIGN)
+=23define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_VALID_BITS - =
=5C
+			       DEPOT_OFFSET_BITS - STACK_DEPOT_EXTRA_BITS)
+=23define DEPOT_POOLS_CAP 8192

Increase DEPOT_POOLS_CAP size to 32768

+=23define DEPOT_MAX_POOLS =5C
+	(((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? =5C
+	 (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)


Hi Andrey.

I have some question about DEPOT_MAX_POOLS.
Actually I didn't know where to post my question, so here it is.
I'm testing a feature of the UFS4.0 specification called MCQ,=20
the call stack looks like this and __stack_depot_save keeps printing warnin=
g messages.

=5B7:  OST-Normal-13:17476=5D ------------=5B cut here =5D------------
=5B7:  OST-Normal-13:17476=5D Stack depot reached limit capacity
=5B7:  OST-Normal-13:17476=5D pc : __stack_depot_save+0x464/0x46c
=5B7:  OST-Normal-13:17476=5D lr : __stack_depot_save+0x460/0x46c
=5B7:  OST-Normal-13:17476=5D sp : ffffffc008077730
=5B7:  OST-Normal-13:17476=5D x29: ffffffc008077750 x28: ffffffd00b78a000 x=
27: 0000000000000000
=5B7:  OST-Normal-13:17476=5D x26: 000000000009a7a4 x25: ffffff8914750000 x=
24: 000000004379a7a4
=5B7:  OST-Normal-13:17476=5D x23: 00000000000001f8 x22: 0000000000000210 x=
21: 000000000000003f
=5B7:  OST-Normal-13:17476=5D x20: ffffffc0080777b0 x19: 0000000000000000 x=
18: 0000000000001000
=5B7:  OST-Normal-13:17476=5D x17: 2065726568207475 x16: 00000000000000c3 x=
15: 2d2d2d2d2d2d2d20
=5B7:  OST-Normal-13:17476=5D x14: 5d36373437313a33 x13: 000000000059a740 x=
12: 000000000059a6f8
=5B7:  OST-Normal-13:17476=5D x11: 00000000ffffffff x10: ffffffb90aba9000 x=
9 : 008c3feffad60900
=5B7:  OST-Normal-13:17476=5D x8 : 008c3feffad60900 x7 : 000000000059a740 x=
6 : 000000000059a6f8
=5B7:  OST-Normal-13:17476=5D x5 : ffffffc008077438 x4 : ffffffd00b196970 x=
3 : ffffffd0092b313c
=5B7:  OST-Normal-13:17476=5D x2 : 0000000000000001 x1 : 0000000000000004 x=
0 : 0000000000000022
=5B7:  OST-Normal-13:17476=5D Call trace:
=5B7:  OST-Normal-13:17476=5D  __stack_depot_save+0x464/0x46c
=5B7:  OST-Normal-13:17476=5D  kasan_save_stack+0x58/0x70
=5B7:  OST-Normal-13:17476=5D  save_stack_info+0x34/0x138
=5B7:  OST-Normal-13:17476=5D  kasan_save_free_info+0x18/0x24
=5B7:  OST-Normal-13:17476=5D  ____kasan_slab_free+0x16c/0x170
=5B7:  OST-Normal-13:17476=5D  __kasan_slab_free+0x10/0x20
=5B7:  OST-Normal-13:17476=5D  kmem_cache_free+0x238/0x53c
=5B7:  OST-Normal-13:17476=5D  mempool_free_slab+0x1c/0x28
=5B7:  OST-Normal-13:17476=5D  mempool_free+0x7c/0x1a0
=5B7:  OST-Normal-13:17476=5D  sg_pool_free+0x6c/0x84
=5B7:  OST-Normal-13:17476=5D  __sg_free_table+0x88/0xbc
=5B7:  OST-Normal-13:17476=5D  sg_free_table_chained+0x40/0x4c
=5B7:  OST-Normal-13:17476=5D  scsi_free_sgtables+0x3c/0x7c
=5B7:  OST-Normal-13:17476=5D  scsi_mq_uninit_cmd+0x20/0x7c
=5B7:  OST-Normal-13:17476=5D  scsi_end_request+0xd8/0x304
=5B7:  OST-Normal-13:17476=5D  scsi_io_completion+0x88/0x160
=5B7:  OST-Normal-13:17476=5D  scsi_finish_command+0x17c/0x194
=5B7:  OST-Normal-13:17476=5D  scsi_complete+0xcc/0x158
=5B7:  OST-Normal-13:17476=5D  blk_mq_complete_request+0x4c/0x5c
=5B7:  OST-Normal-13:17476=5D  scsi_done_internal+0xf4/0x1e0
=5B7:  OST-Normal-13:17476=5D  scsi_done+0x14/0x20
=5B7:  OST-Normal-13:17476=5D  ufshcd_compl_one_cqe+0x578/0x71c
=5B7:  OST-Normal-13:17476=5D  ufshcd_mcq_poll_cqe_nolock+0xc8/0x150
=5B7:  OST-Normal-13:17476=5D  vendor_mcq_irq+0x74/0x88 =5Bufs-core=5D
=5B7:  OST-Normal-13:17476=5D  __handle_irq_event_percpu+0xd0/0x348
=5B7:  OST-Normal-13:17476=5D  handle_irq_event_percpu+0x24/0x74
=5B7:  OST-Normal-13:17476=5D  handle_irq_event+0x74/0xe0
=5B7:  OST-Normal-13:17476=5D  handle_fasteoi_irq+0x174/0x240
=5B7:  OST-Normal-13:17476=5D  handle_irq_desc+0x7c/0x2c0
=5B7:  OST-Normal-13:17476=5D  generic_handle_domain_irq+0x1c/0x28
=5B7:  OST-Normal-13:17476=5D  gic_handle_irq+0x64/0x158
=5B7:  OST-Normal-13:17476=5D  call_on_irq_stack+0x2c/0x54
=5B7:  OST-Normal-13:17476=5D  do_interrupt_handler+0x70/0xa0
=5B7:  OST-Normal-13:17476=5D  el1_interrupt+0x34/0x68
=5B7:  OST-Normal-13:17476=5D  el1h_64_irq_handler+0x18/0x24
=5B7:  OST-Normal-13:17476=5D  el1h_64_irq+0x68/0x6c
=5B7:  OST-Normal-13:17476=5D  __hwasan_check_x0_67043363+0xc/0x30
=5B7:  OST-Normal-13:17476=5D  ufshcd_queuecommand+0x5f8/0x7b4
=5B7:  OST-Normal-13:17476=5D  scsi_queue_rq+0xb88/0xea4
=5B7:  OST-Normal-13:17476=5D  blk_mq_dispatch_rq_list+0x640/0xe18
=5B7:  OST-Normal-13:17476=5D  blk_mq_do_dispatch_sched+0x47c/0x530
=5B7:  OST-Normal-13:17476=5D  __blk_mq_sched_dispatch_requests+0x158/0x1cc
=5B7:  OST-Normal-13:17476=5D  blk_mq_sched_dispatch_requests+0x68/0x9c
=5B7:  OST-Normal-13:17476=5D  __blk_mq_run_hw_queue+0x9c/0x11c
=5B7:  OST-Normal-13:17476=5D  __blk_mq_delay_run_hw_queue+0xa4/0x234
=5B7:  OST-Normal-13:17476=5D  blk_mq_run_hw_queue+0x130/0x150
=5B7:  OST-Normal-13:17476=5D  blk_mq_sched_insert_requests+0x208/0x3a0
=5B7:  OST-Normal-13:17476=5D  blk_mq_flush_plug_list+0x21c/0x4f0
=5B7:  OST-Normal-13:17476=5D  __blk_flush_plug+0x180/0x1d8
=5B7:  OST-Normal-13:17476=5D  blk_finish_plug+0x40/0x5c
=5B7:  OST-Normal-13:17476=5D  read_pages+0x420/0x4ac
=5B7:  OST-Normal-13:17476=5D  page_cache_ra_unbounded+0xec/0x288
=5B7:  OST-Normal-13:17476=5D  do_page_cache_ra+0x60/0x6c
=5B7:  OST-Normal-13:17476=5D  page_cache_ra_order+0x318/0x364
=5B7:  OST-Normal-13:17476=5D  do_sync_mmap_readahead+0x1a0/0x3c8
=5B7:  OST-Normal-13:17476=5D  filemap_fault+0x260/0x68c
=5B7:  OST-Normal-13:17476=5D  __do_fault+0x80/0x1b4
=5B7:  OST-Normal-13:17476=5D  handle_mm_fault+0x6b4/0x1530
=5B7:  OST-Normal-13:17476=5D  do_page_fault+0x3ec/0x5d4
=5B7:  OST-Normal-13:17476=5D  do_translation_fault+0x44/0x5c
=5B7:  OST-Normal-13:17476=5D  do_mem_abort+0x54/0xd8
=5B7:  OST-Normal-13:17476=5D  el0_ia+0x68/0xf4
=5B7:  OST-Normal-13:17476=5D  el0t_64_sync_handler+0xd0/0x114
=5B7:  OST-Normal-13:17476=5D  el0t_64_sync+0x190/0x194

After analyzing it, it seems that the stack buffer is running out of memory=
,=20
so what do you think about increasing the size of DEPOT_POOLS_CAP to 32768?
Tell us, your opinion

Thanks.

