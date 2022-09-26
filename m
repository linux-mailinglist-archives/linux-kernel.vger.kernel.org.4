Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3CF5E982B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 05:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiIZDQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 23:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIZDQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 23:16:45 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A351525EB4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 20:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1664162200;
        bh=j9SSpreHKvKfroYfmbuT3oTsBVOFOzVT/lwKwVPfe1A=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=D7AWuTw3lR4m+A7mpzpqfjoU3dX7aFaJQMOiyRL06CrBI+x9c7t8tvsg51sFULcqG
         RmusVNbVjYHIMtLdc5JAsBS2EmChYGJvV/Xgi2/sBstTk8yvf380zGW9Fyp+4hEaLy
         Zi2FTW//Cah2Vrcb4izdwi4vg/AggYsncF9+27rU=
Received: from helloworld ([59.172.176.225])
        by newxmesmtplogicsvrsza30.qq.com (NewEsmtp) with SMTP
        id 4252604B; Mon, 26 Sep 2022 11:16:37 +0800
X-QQ-mid: xmsmtpt1664162197tr12jpg81
Message-ID: <tencent_F9A4327FE4DE726C503C873F2871FF0F810A@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8lZX/8QmW4y6DiQoTbz6jyRTCWGspqq1eTU6oBJ0g/l+wrNdPSW
         zTk/a7+RVEfKdGMdSnyXtkfffONBr/XwTQ3F/FKxCa4osVR6GCSkBbi5KS/YVcCR2WarQ0YeLn1L
         mCHoTrVch/yEq58jTgwUmPEsmBe+GMMVMdNfQgV1RcKkuLfhypMwAe/CDqmWMCD2GQ4gXbRNAQ2g
         D3glvW+Ne/Swyi0WXlSN/KNSQvuxuxx73u46q+yrzPXncIJUEbMZFDs4B3elPTyzp+UC67oftV2D
         PJoiHsCfcmlLqNZX+2zT9FJ++6lIIBnNZ0pPcCQ1eYjpvRVTWSUAv7I5tA6Iev0gMM/I9aYB23Dm
         C3DzLMFRnmdmiuUl8tbtz1crDZr56jX1po85ISKLkQtExqt4bXoHxEivcOqolQsjAoxfPy0b2oV+
         TOjC7E62NduH2JKJyLTO7VKJokEjaK3UTiiQ3qgPXErvU71HgU6NgJbLqgR2EuCU7PhRkXhaUvUV
         MS1DoTGbIUOjOaUYrfy6SEb+hS48VjzztmLA1x+kCJeo8ppkTTFaaRNgfWBvU8uTe5bviq8x4QYr
         wruMeUARxxQEmRnZ6I0CiLWwgwawYBonzUCZoTxqJiUFRk6NTt1q1P/P+Rz/1Rh0xg0EH6f/M4C/
         txwnEASMy5UpAe0X/+0dyZ6d/o/pOT756Cr4vLAZQMk+9fZID6t8WrLkb4MU+3k+QHVp25gOjTZ4
         sOg+maUf1BrORWeWk89yJfFffpdLhmasPHiI7wJjAZ/QRFujbuuKx/jlSuQbTQZBTIa/mjCGFScu
         SkMFMYvBbonak8QWRSWUAr8r1JeNJXBBHuXNUQa37HGmipHMG9eCCKwLaqZi4VZz79QW/Com9tfZ
         ukCRrZ+MBPCVDPcx2nxcKbIuQacpBy5J208J917/+XGZB7O0F1+/siyyM2t0aWqlAge+IcQE4L1e
         W+PLen60CB9ba+HDcNALpxks/RQ2CLFJZAk6g/l1dJ4U6RyEuEm8q4A+2583i8
From:   <xkernel.wang@foxmail.com>
To:     <akpm@linux-foundation.org>
Cc:     <glider@google.com>, <andreyknvl@gmail.com>, <elver@google.com>,
        <dvyukov@google.com>, <ryabinin.a.a@gmail.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <xkernel.wang@foxmail.com>
References: <tencent_D44A49FFB420EDCCBFB9221C8D14DFE12908@qq.com>
In-Reply-To: <tencent_D44A49FFB420EDCCBFB9221C8D14DFE12908@qq.com>
Subject: Re: [PATCH] lib/test_meminit: add checks for the allocation functions
Date:   Mon, 26 Sep 2022 11:16:37 +0800
X-OQ-MSGID: <000301d8d156$648e0010$2daa0030$@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ0HYwArhWftIfEaS2bvHNj7adm+ay6bDcw
Content-Language: zh-cn
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patch seems to have been forgotten.

Regards,
Xiaoke Wang

On Friday, March 4, 2022 5:12 PM, <xkernel.wang@foxmail.com> wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>=20
> alloc_pages(), kmalloc() and vmalloc() are all memory allocation
> functions which can return NULL when some internal memory failures
> happen. So it is better to check the return of them to catch the =
failure
> in time for better test them.
>=20
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  lib/test_meminit.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/lib/test_meminit.c b/lib/test_meminit.c
> index e4f706a..2f4c4bc 100644
> --- a/lib/test_meminit.c
> +++ b/lib/test_meminit.c
> @@ -67,17 +67,24 @@ static int __init do_alloc_pages_order(int order, =
int
> *total_failures)
>  	size_t size =3D PAGE_SIZE << order;
>=20
>  	page =3D alloc_pages(GFP_KERNEL, order);
> +	if (!page)
> +		goto err;
>  	buf =3D page_address(page);
>  	fill_with_garbage(buf, size);
>  	__free_pages(page, order);
>=20
>  	page =3D alloc_pages(GFP_KERNEL, order);
> +	if (!page)
> +		goto err;
>  	buf =3D page_address(page);
>  	if (count_nonzero_bytes(buf, size))
>  		(*total_failures)++;
>  	fill_with_garbage(buf, size);
>  	__free_pages(page, order);
>  	return 1;
> +err:
> +	(*total_failures)++;
> +	return 1;
>  }
>=20
>  /* Test the page allocator by calling alloc_pages with different =
orders. */
> @@ -100,15 +107,22 @@ static int __init do_kmalloc_size(size_t size, =
int
> *total_failures)
>  	void *buf;
>=20
>  	buf =3D kmalloc(size, GFP_KERNEL);
> +	if (!buf)
> +		goto err;
>  	fill_with_garbage(buf, size);
>  	kfree(buf);
>=20
>  	buf =3D kmalloc(size, GFP_KERNEL);
> +	if (!buf)
> +		goto err;
>  	if (count_nonzero_bytes(buf, size))
>  		(*total_failures)++;
>  	fill_with_garbage(buf, size);
>  	kfree(buf);
>  	return 1;
> +err:
> +	(*total_failures)++;
> +	return 1;
>  }
>=20
>  /* Test vmalloc() with given parameters. */
> @@ -117,15 +131,22 @@ static int __init do_vmalloc_size(size_t size, =
int
> *total_failures)
>  	void *buf;
>=20
>  	buf =3D vmalloc(size);
> +	if (!buf)
> +		goto err;
>  	fill_with_garbage(buf, size);
>  	vfree(buf);
>=20
>  	buf =3D vmalloc(size);
> +	if (!buf)
> +		goto err;
>  	if (count_nonzero_bytes(buf, size))
>  		(*total_failures)++;
>  	fill_with_garbage(buf, size);
>  	vfree(buf);
>  	return 1;
> +err:
> +	(*total_failures)++;
> +	return 1;
>  }
>=20
>  /* Test kmalloc()/vmalloc() by allocating objects of different sizes. =
*/
> --

