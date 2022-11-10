Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86A5624D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiKJV7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiKJV71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:59:27 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4129E50F3F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:59:26 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 4so2728645pli.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jNWaN3dEjHl6Nm3gi9RJ1BK8vy/skk8/JeblCzZOSI=;
        b=EEdJtAy0ezUiXp++ZNKTmWOT/7HzhLqSKx0NnpVXPtPgPV7SO1RMfTjs38xeFTAPHt
         pHaFnvLiYyuBj3tbhgajicj0WrDBHUHJVybN5oXHgiizgof1l7ufurujrBN2luz/8n8q
         qJzW68+h8DFMH8Uls81hupZm8JcJlTfW5juDlrqyeEp+jY+CjWTWmfujKJkLUpihYq27
         1rvenYkJOHS3blVFhXzoDPeuL7x+HMEe6Kn9P4UL8/Lgfl16Y1m6a5NpsCt2JsGKzjzP
         uRvxdLxScpSBeraqOMZoO7qNSq0kQympbMWPHsn7dV+NDOUitUIUVEq/7269XGWztEO8
         BEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jNWaN3dEjHl6Nm3gi9RJ1BK8vy/skk8/JeblCzZOSI=;
        b=SBN/Mn5mocYRwTqhZrF2jzKq1x7hcYSJ+yVnv/zByTxG09zTshK0G2lVbYi6ZmlmCb
         k1FMdXBnUEUO+XUcHSSLgtThyh9aZX7lRVvSYdL4RplMOG2AuC1PrHlc2DGEzaVbMV81
         oxIhyykOYuVxjx8SxIkPy9qXEbPymxoNfImrBfRQ+ZQH3I5RmqL9/7N2w+eHvdgfhruR
         WdDk7UmlfRC2QvxGUQJcJGNl9UQ7kzAkoe68G+hwXz7rkkaWD9ksqLwK51CPjiSLKBbI
         G8SOVKfTT0vhsvzoCVCpg+uRK4ABUG7RwRQ72U5R7CTDJdZ0z3pK+Rlmum65/iGyAsqf
         90yw==
X-Gm-Message-State: ACrzQf15Mg32i87nVYZc+rkKVGMLlIilVHw37IkII5PcZmurVXoKQTsP
        KNrT01LBcHc56iD7GHQ1Cyw=
X-Google-Smtp-Source: AMsMyM4bfnaYJa0u4391mWf+ygx1t2VIwhEDx7GwYvwtHhr8ZWXgTO/Ii6sAbVECowvud5T7ZikCmA==
X-Received: by 2002:a17:90b:1d0c:b0:213:3521:f83a with SMTP id on12-20020a17090b1d0c00b002133521f83amr2184928pjb.84.1668117565225;
        Thu, 10 Nov 2022 13:59:25 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8c0b:3260:c81c:119d])
        by smtp.gmail.com with ESMTPSA id h16-20020a635310000000b0046f56534d9fsm114515pgb.21.2022.11.10.13.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 13:59:24 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 10 Nov 2022 13:59:22 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zsmalloc: turn zspage order into runtime variable
Message-ID: <Y210OrSgrqWPr0DT@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <20221031054108.541190-3-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031054108.541190-3-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 02:41:01PM +0900, Sergey Senozhatsky wrote:
> zsmalloc has 255 size classes. Size classes contain a number of zspages,
> which store objects of the same size. zspage can consist of up to four
> physical pages. The exact (most optimal) zspage size is calculated for
> each size class during zsmalloc pool creation.
> 
> As a reasonable optimization, zsmalloc merges size classes that have
> similar characteristics: number of pages per zspage and number of
> objects zspage can store.
> 
> For example, let's look at the following size classes:
> 
> class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
> ..
>    94  1536           0            0             0          0          0                3        0
>   100  1632           0            0             0          0          0                2        0
> ..
> 
> Size classes #95-99 are merged with size class #100. That is, each time
> we store an object of size, say, 1568 bytes instead of using class #96
> we end up storing it in size class #100. Class #100 is for objects of
> 1632 bytes in size, hence every 1568 bytes object wastes 1632-1568 bytes.
> Class #100 zspages consist of 2 physical pages and can hold 5 objects.
> When we need to store, say, 13 objects of size 1568 we end up allocating
> three zspages; in other words, 6 physical pages.
> 
> However, if we'll look closer at size class #96 (which should hold objects
> of size 1568 bytes) and trace get_pages_per_zspage():
> 
>     pages per zspage      wasted bytes     used%
>            1                  960           76
>            2                  352           95
>            3                 1312           89
>            4                  704           95
>            5                   96           99
> 
> We'd notice that the most optimal zspage configuration for this class is
> when it consists of 5 physical pages, but currently we never let zspages
> to consists of more than 4 pages. A 5 page class #96 configuration would
> store 13 objects of size 1568 in a single zspage, allocating 5 physical
> pages, as opposed to 6 physical pages that class #100 will allocate.
> 
> A higher order zspage for class #96 also changes its key characteristics:
> pages per-zspage and objects per-zspage. As a result classes #96 and #100
> are not merged anymore, which gives us more compact zsmalloc.
> 
> Of course the described effect does not apply only to size classes #96 and
> We still merge classes, but less often so. In other words classes are grouped
> in a more compact way, which decreases memory wastage:
> 
> zspage order               # unique size classes
>      2                                69
>      3                               123
>      4                               191
> 
> Let's take a closer look at the bottom of /sys/kernel/debug/zsmalloc/zram0/classes:
> 
> class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
> ...
>   202  3264           0            0             0          0          0                4        0
>   254  4096           0            0             0          0          0                1        0
> ...
> 
> For exactly same reason - maximum 4 pages per zspage - the last non-huge
> size class is #202, which stores objects of size 3264 bytes. Any object
> larger than 3264 bytes, hence, is considered to be huge and lands in size
> class #254, which uses a whole physical page to store every object. To put
> it slightly differently - objects in huge classes don't share physical pages.
> 
> 3264 bytes is too low of a watermark and we have too many huge classes:
> classes from #203 to #254. Similarly to class size #96 above, higher order
> zspages change key characteristics for some of those huge size classes and
> thus those classes become normal classes, where stored objects share physical
> pages.
> 
> Hence yet another consequence of higher order zspages: we move the huge
> size class watermark with higher order zspages, have less huge classes and
> store large objects in a more compact way.
> 
> For order 3, huge class watermark becomes 3632 bytes:
> 
> class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
> ...
>   202  3264           0            0             0          0          0                4        0
>   211  3408           0            0             0          0          0                5        0
>   217  3504           0            0             0          0          0                6        0
>   222  3584           0            0             0          0          0                7        0
>   225  3632           0            0             0          0          0                8        0
>   254  4096           0            0             0          0          0                1        0
> ...
> 
> For order 4, huge class watermark becomes 3840 bytes:
> 
> class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
> ...
>   202  3264           0            0             0          0          0                4        0
>   206  3328           0            0             0          0          0               13        0
>   207  3344           0            0             0          0          0                9        0
>   208  3360           0            0             0          0          0               14        0
>   211  3408           0            0             0          0          0                5        0
>   212  3424           0            0             0          0          0               16        0
>   214  3456           0            0             0          0          0               11        0
>   217  3504           0            0             0          0          0                6        0
>   219  3536           0            0             0          0          0               13        0
>   222  3584           0            0             0          0          0                7        0
>   223  3600           0            0             0          0          0               15        0
>   225  3632           0            0             0          0          0                8        0
>   228  3680           0            0             0          0          0                9        0
>   230  3712           0            0             0          0          0               10        0
>   232  3744           0            0             0          0          0               11        0
>   234  3776           0            0             0          0          0               12        0
>   235  3792           0            0             0          0          0               13        0
>   236  3808           0            0             0          0          0               14        0
>   238  3840           0            0             0          0          0               15        0
>   254  4096           0            0             0          0          0                1        0
> ...
> 
> TESTS
> =====
> 
> Test untars linux-6.0.tar.xz and compiles the kernel.
> 
> zram is configured as a block device with ext4 file system, lzo-rle
> compression algorithm. We captured /sys/block/zram0/mm_stat after
> every test and rebooted the VM.
> 
> orig_data_size       mem_used_total     mem_used_max       pages_compacted
>           compr_data_size         mem_limit         same_pages       huge_pages
> 
> ORDER 2 (BASE) zspage
> 
> 1691791360 628086729 655171584        0 655171584       60        0    34043
> 1691787264 628089196 655175680        0 655175680       60        0    34046
> 1691803648 628098840 655187968        0 655187968       59        0    34047
> 1691795456 628091503 655183872        0 655183872       60        0    34044
> 1691799552 628086877 655183872        0 655183872       60        0    34047
> 
> ORDER 3 zspage
> 
> 1691803648 627792993 641794048        0 641794048       60        0    33591
> 1691787264 627779342 641708032        0 641708032       59        0    33591
> 1691811840 627786616 641769472        0 641769472       60        0    33591
> 1691803648 627794468 641818624        0 641818624       59        0    33592
> 1691783168 627780882 641794048        0 641794048       61        0    33591
> 
> ORDER 4 zspage
> 
> 1691803648 627726635 639655936        0 639655936       60        0    33435
> 1691811840 627733348 639643648        0 639643648       61        0    33434
> 1691795456 627726290 639614976        0 639614976       60        0    33435
> 1691803648 627730458 639688704        0 639688704       60        0    33434
> 1691811840 627727771 639688704        0 639688704       60        0    33434
> 
> Order 3 and order 4 show statistically significant improvement in
> `mem_used_max` metrics.
> 
> T-test for order 3:
> 
> x order-2-maxmem
> + order-3-maxmem
>     N           Min           Max        Median           Avg        Stddev
> x   5 6.5517158e+08 6.5518797e+08 6.5518387e+08  6.551806e+08     6730.4157
> +   5 6.4170803e+08 6.4181862e+08 6.4179405e+08 6.4177684e+08     42210.666
> Difference at 95.0% confidence
> 	-1.34038e+07 +/- 44080.7
> 	-2.04581% +/- 0.00672802%
> 	(Student's t, pooled s = 30224.5)
> 
> T-test for order 4:
> 
> x order-2-maxmem
> + order-4-maxmem
>     N           Min           Max        Median           Avg        Stddev
> x   5 6.5517158e+08 6.5518797e+08 6.5518387e+08  6.551806e+08     6730.4157
> +   5 6.3961498e+08  6.396887e+08 6.3965594e+08 6.3965839e+08     31408.602
> Difference at 95.0% confidence
> 	-1.55222e+07 +/- 33126.2
> 	-2.36915% +/- 0.00505604%
> 	(Student's t, pooled s = 22713.4)
> 
> This test tends to benefit more from order 4 zspages, due to test's data
> patterns.
> 
> zsmalloc object distribution analysis
> =============================================================================
> 
> Order 2 (4 pages per zspage) tends to put many objects in size class 2048,
> which is merged with size classes #112-#125:
> 
> class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
> ...
>     71  1168           0            0          6146       6146       1756                2        0
>     74  1216           0            1          4560       4552       1368                3        0
>     76  1248           0            1          2938       2934        904                4        0
>     83  1360           0            0         10971      10971       3657                1        0
>     91  1488           0            0         16126      16126       5864                4        0
>     94  1536           0            1          5912       5908       2217                3        0
>    100  1632           0            0         11990      11990       4796                2        0
>    107  1744           0            1         15771      15768       6759                3        0
>    111  1808           0            1         10386      10380       4616                4        0
>    126  2048           0            0         45444      45444      22722                1        0
>    144  2336           0            0         47446      47446      27112                4        0
>    151  2448           1            0         10760      10759       6456                3        0
>    168  2720           0            0         10173      10173       6782                2        0
>    190  3072           0            1          1700       1697       1275                3        0
>    202  3264           0            1           290        286        232                4        0
>    254  4096           0            0         34051      34051      34051                1        0
> 
> Order 3 (8 pages per zspage) changed pool characteristics and unmerged
> some of the size classes, which resulted in less objects being put into
> size class 2048, because there are lower size classes are now available
> for more compact object storage:
> 
> class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
> ...
>     71  1168           0            1          2996       2994        856                2        0
>     72  1184           0            1          1632       1609        476                7        0
>     73  1200           1            0          1445       1442        425                5        0
>     74  1216           0            0          1510       1510        453                3        0
>     75  1232           0            1          1495       1479        455                7        0
>     76  1248           0            1          1456       1451        448                4        0
>     78  1280           0            1          3040       3033        950                5        0
>     79  1296           0            1          1584       1571        504                7        0
>     83  1360           0            0          6375       6375       2125                1        0
>     84  1376           0            1          1817       1796        632                8        0
>     87  1424           0            1          6020       6006       2107                7        0
>     88  1440           0            1          2108       2101        744                6        0
>     89  1456           0            1          2072       2064        740                5        0
>     91  1488           0            1          4169       4159       1516                4        0
>     92  1504           0            1          2014       2007        742                7        0
>     94  1536           0            1          3904       3900       1464                3        0
>     95  1552           0            1          1890       1873        720                8        0
>     96  1568           0            1          1963       1958        755                5        0
>     97  1584           0            1          1980       1974        770                7        0
>    100  1632           0            1          6190       6187       2476                2        0
>    103  1680           0            0          6477       6477       2667                7        0
>    104  1696           0            1          2256       2253        940                5        0
>    105  1712           0            1          2356       2340        992                8        0
>    107  1744           1            0          4697       4696       2013                3        0
>    110  1792           0            1          7744       7734       3388                7        0
>    111  1808           0            1          2655       2649       1180                4        0
>    114  1856           0            1          8371       8365       3805                5        0
>    116  1888           1            0          5863       5862       2706                6        0
>    117  1904           0            1          2955       2942       1379                7        0
>    118  1920           0            1          3009       2997       1416                8        0
>    126  2048           0            0         25276      25276      12638                1        0
>    128  2080           0            1          6060       6052       3232                8        0
>    129  2096           1            0          3081       3080       1659                7        0
>    134  2176           0            1         14835      14830       7912                8        0
>    135  2192           0            1          2769       2758       1491                7        0
>    137  2224           0            1          5082       5077       2772                6        0
>    140  2272           0            1          7236       7232       4020                5        0
>    144  2336           0            1          8428       8423       4816                4        0
>    147  2384           0            1          5316       5313       3101                7        0
>    151  2448           0            1          5445       5443       3267                3        0
>    155  2512           0            0          4121       4121       2536                8        0
>    158  2560           0            1          2208       2205       1380                5        0
>    160  2592           0            0          1133       1133        721                7        0
>    168  2720           0            0          2712       2712       1808                2        0
>    177  2864           1            0          1100       1098        770                7        0
>    180  2912           0            1           189        183        135                5        0
>    184  2976           0            1           176        166        128                8        0
>    190  3072           0            0           252        252        189                3        0
>    197  3184           0            1           198        192        154                7        0
>    202  3264           0            1           100         96         80                4        0
>    211  3408           0            1           210        208        175                5        0
>    217  3504           0            1            98         94         84                6        0
>    222  3584           0            0           104        104         91                7        0
>    225  3632           0            1            54         50         48                8        0
>    254  4096           0            0         33591      33591      33591                1        0
> 
> Note, the huge size watermark is above 3632 and there are a number of new
> normal classes available that previously were merged with the huge class.
> For instance, size class #211 holds 210 objects of size 3408 and uses 175
> physical pages, while previously for those objects we would have used 210
> physical pages.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  include/linux/zsmalloc.h | 12 +++++++
>  mm/zsmalloc.c            | 73 +++++++++++++++++++++++-----------------
>  2 files changed, 54 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> index a48cd0ffe57d..6cd1d95b928a 100644
> --- a/include/linux/zsmalloc.h
> +++ b/include/linux/zsmalloc.h
> @@ -33,6 +33,18 @@ enum zs_mapmode {
>  	 */
>  };
>  
> +#define ZS_PAGE_ORDER_2		2
> +#define ZS_PAGE_ORDER_4		4
> +
> +/*
> + * A single 'zspage' is composed of up to 2^N discontiguous 0-order (single)
> + * pages. ZS_MAX_PAGE_ORDER defines upper limit on N, ZS_MIN_PAGE_ORDER
> + * defines lower limit on N. ZS_DEFAULT_PAGE_ORDER is recommended value.

It gives the impression:

   2^2 <= the page nubmer of zspage <= 2^4

I think that's not what you want to describe. How about?

A single 'zspage' is composed of up to 2^N discontiguous 0-order (single)
pages and the N can be from ZS_MIN_PAGE_ORDER to ZS_MAX_PAGE_ORDER.

> + */
> +#define ZS_MIN_PAGE_ORDER	ZS_PAGE_ORDER_2
> +#define ZS_MAX_PAGE_ORDER	ZS_PAGE_ORDER_4
> +#define ZS_DEFAULT_PAGE_ORDER	ZS_PAGE_ORDER_2

#define ZS_MIN_PAGE_ORDER	2

We can use the number directly instead of another wrapping at least
in this patch(Just in case: if you want to extent it later patch,
please do it in the patch)

> +
>  struct zs_pool_stats {
>  	/* How many pages were migrated (freed) */
>  	atomic_long_t pages_compacted;
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 065744b7e9d8..a9773566f85b 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -74,12 +74,7 @@
>   */
>  #define ZS_ALIGN		8
>  
> -/*
> - * A single 'zspage' is composed of up to 2^N discontiguous 0-order (single)
> - * pages. ZS_MAX_ZSPAGE_ORDER defines upper limit on N.
> - */
> -#define ZS_MAX_ZSPAGE_ORDER 2
> -#define ZS_MAX_PAGES_PER_ZSPAGE (_AC(1, UL) << ZS_MAX_ZSPAGE_ORDER)
> +#define ZS_MAX_PAGES_PER_ZSPAGE	(_AC(1, UL) << ZS_MAX_PAGE_ORDER)
>  
>  #define ZS_HANDLE_SIZE (sizeof(unsigned long))
>  
> @@ -124,10 +119,8 @@
>  #define ISOLATED_BITS	3
>  #define MAGIC_VAL_BITS	8
>  
> -#define MAX(a, b) ((a) >= (b) ? (a) : (b))
> -/* ZS_MIN_ALLOC_SIZE must be multiple of ZS_ALIGN */
> -#define ZS_MIN_ALLOC_SIZE \
> -	MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BITS))
> +#define ZS_MIN_ALLOC_SIZE	32U

Let's have some comment here to say that's not the final vaule which
is supposed to be pool->min_alloc_size.

> +
>  /* each chunk includes extra space to keep handle */
>  #define ZS_MAX_ALLOC_SIZE	PAGE_SIZE
>  
> @@ -141,12 +134,10 @@
>   *    determined). NOTE: all those class sizes must be set as multiple of
>   *    ZS_ALIGN to make sure link_free itself never has to span 2 pages.
>   *
> - *  ZS_MIN_ALLOC_SIZE and ZS_SIZE_CLASS_DELTA must be multiple of ZS_ALIGN
> - *  (reason above)
> + *  pool->min_alloc_size (ZS_MIN_ALLOC_SIZE) and ZS_SIZE_CLASS_DELTA must
> + *  be multiple of ZS_ALIGN (reason above)
>   */
>  #define ZS_SIZE_CLASS_DELTA	(PAGE_SIZE >> CLASS_BITS)
> -#define ZS_SIZE_CLASSES	(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - ZS_MIN_ALLOC_SIZE, \
> -				      ZS_SIZE_CLASS_DELTA) + 1)
>  
>  enum fullness_group {
>  	ZS_EMPTY,
> @@ -230,12 +221,15 @@ struct link_free {
>  struct zs_pool {
>  	const char *name;
>  
> -	struct size_class *size_class[ZS_SIZE_CLASSES];
> +	struct size_class **size_class;
>  	struct kmem_cache *handle_cachep;
>  	struct kmem_cache *zspage_cachep;
>  
>  	atomic_long_t pages_allocated;
>  
> +	u32 num_size_classes;
> +	u32 min_alloc_size;

Please use int. From this patch, I couldn't figure why we need
variable in the pool. Let's have the change in the patch where
you really need to have the usecase.

> +
>  	struct zs_pool_stats stats;
>  
>  	/* Compact classes */
> @@ -523,15 +517,15 @@ static void set_zspage_mapping(struct zspage *zspage,
>   * classes depending on its size. This function returns index of the
>   * size class which has chunk size big enough to hold the given size.
>   */
> -static int get_size_class_index(int size)
> +static int get_size_class_index(struct zs_pool *pool, int size)
>  {
>  	int idx = 0;
>  
> -	if (likely(size > ZS_MIN_ALLOC_SIZE))
> -		idx = DIV_ROUND_UP(size - ZS_MIN_ALLOC_SIZE,
> +	if (likely(size > pool->min_alloc_size))
> +		idx = DIV_ROUND_UP(size - pool->min_alloc_size,
>  				ZS_SIZE_CLASS_DELTA);
>  
> -	return min_t(int, ZS_SIZE_CLASSES - 1, idx);
> +	return min_t(int, pool->num_size_classes - 1, idx);
>  }
>  
>  /* type can be of enum type class_stat_type or fullness_group */
> @@ -591,7 +585,7 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
>  			"obj_allocated", "obj_used", "pages_used",
>  			"pages_per_zspage", "freeable");
>  
> -	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
> +	for (i = 0; i < pool->num_size_classes; i++) {
>  		class = pool->size_class[i];
>  
>  		if (class->index != i)
> @@ -777,13 +771,13 @@ static enum fullness_group fix_fullness_group(struct size_class *class,
>   * link together 3 PAGE_SIZE sized pages to form a zspage
>   * since then we can perfectly fit in 8 such objects.
>   */
> -static int get_pages_per_zspage(int class_size)
> +static int get_pages_per_zspage(u32 class_size, u32 num_pages)

Let's just use int instead of u32

Why do you need num_pages argument instead of using 1UL << ZS_DEFAULT_PAGE_ORDER?
It looks like static value.

>  {
>  	int i, max_usedpc = 0;
>  	/* zspage order which gives maximum used size per KB */
>  	int max_usedpc_order = 1;
>  
> -	for (i = 1; i <= ZS_MAX_PAGES_PER_ZSPAGE; i++) {
> +	for (i = 1; i <= num_pages; i++) {
>  		int zspage_size;
>  		int waste, usedpc;
>  
> @@ -1220,7 +1214,7 @@ unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size)
>  {
>  	struct size_class *class;
>  
> -	class = pool->size_class[get_size_class_index(size)];
> +	class = pool->size_class[get_size_class_index(pool, size)];
>  
>  	return class->index;
>  }
> @@ -1431,7 +1425,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
>  
>  	/* extra space in chunk to keep the handle */
>  	size += ZS_HANDLE_SIZE;
> -	class = pool->size_class[get_size_class_index(size)];
> +	class = pool->size_class[get_size_class_index(pool, size)];
>  
>  	/* class->lock effectively protects the zpage migration */
>  	spin_lock(&class->lock);
> @@ -1980,7 +1974,7 @@ static void async_free_zspage(struct work_struct *work)
>  	struct zs_pool *pool = container_of(work, struct zs_pool,
>  					free_work);
>  
> -	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
> +	for (i = 0; i < pool->num_size_classes; i++) {
>  		class = pool->size_class[i];
>  		if (class->index != i)
>  			continue;
> @@ -2129,7 +2123,7 @@ unsigned long zs_compact(struct zs_pool *pool)
>  	struct size_class *class;
>  	unsigned long pages_freed = 0;
>  
> -	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
> +	for (i = pool->num_size_classes - 1; i >= 0; i--) {
>  		class = pool->size_class[i];
>  		if (class->index != i)
>  			continue;
> @@ -2173,7 +2167,7 @@ static unsigned long zs_shrinker_count(struct shrinker *shrinker,
>  	struct zs_pool *pool = container_of(shrinker, struct zs_pool,
>  			shrinker);
>  
> -	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
> +	for (i = pool->num_size_classes - 1; i >= 0; i--) {
>  		class = pool->size_class[i];
>  		if (class->index != i)
>  			continue;
> @@ -2215,11 +2209,27 @@ struct zs_pool *zs_create_pool(const char *name)
>  	int i;
>  	struct zs_pool *pool;
>  	struct size_class *prev_class = NULL;
> +	unsigned long num_pages;
>  
>  	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
>  	if (!pool)
>  		return NULL;
>  
> +	num_pages = 1UL << ZS_DEFAULT_PAGE_ORDER;
> +	/* min_alloc_size must be multiple of ZS_ALIGN */
> +	pool->min_alloc_size = num_pages << PAGE_SHIFT >> OBJ_INDEX_BITS;
> +	pool->min_alloc_size = max(pool->min_alloc_size, ZS_MIN_ALLOC_SIZE);
> +
> +	pool->num_size_classes =
> +		DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - pool->min_alloc_size,
> +			     ZS_SIZE_CLASS_DELTA) + 1;
> +
> +	pool->size_class = kmalloc_array(pool->num_size_classes,
> +					 sizeof(struct size_class *),
> +					 GFP_KERNEL | __GFP_ZERO);
> +	if (!pool->size_class)
> +		goto err;
> +
>  	init_deferred_free(pool);
>  	rwlock_init(&pool->migrate_lock);
>  
> @@ -2234,17 +2244,17 @@ struct zs_pool *zs_create_pool(const char *name)
>  	 * Iterate reversely, because, size of size_class that we want to use
>  	 * for merging should be larger or equal to current size.
>  	 */
> -	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
> +	for (i = pool->num_size_classes - 1; i >= 0; i--) {
>  		int size;
>  		int pages_per_zspage;
>  		int objs_per_zspage;
>  		struct size_class *class;
>  		int fullness = 0;
>  
> -		size = ZS_MIN_ALLOC_SIZE + i * ZS_SIZE_CLASS_DELTA;
> +		size = pool->min_alloc_size + i * ZS_SIZE_CLASS_DELTA;
>  		if (size > ZS_MAX_ALLOC_SIZE)
>  			size = ZS_MAX_ALLOC_SIZE;
> -		pages_per_zspage = get_pages_per_zspage(size);
> +		pages_per_zspage = get_pages_per_zspage(size, num_pages);
>  		objs_per_zspage = pages_per_zspage * PAGE_SIZE / size;
>  
>  		/*
> @@ -2328,7 +2338,7 @@ void zs_destroy_pool(struct zs_pool *pool)
>  	zs_flush_migration(pool);
>  	zs_pool_stat_destroy(pool);
>  
> -	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
> +	for (i = 0; i < pool->num_size_classes; i++) {
>  		int fg;
>  		struct size_class *class = pool->size_class[i];
>  
> @@ -2348,6 +2358,7 @@ void zs_destroy_pool(struct zs_pool *pool)
>  	}
>  
>  	destroy_cache(pool);
> +	kfree(pool->size_class);
>  	kfree(pool->name);
>  	kfree(pool);
>  }
> -- 
> 2.38.1.273.g43a17bfeac-goog
> 
