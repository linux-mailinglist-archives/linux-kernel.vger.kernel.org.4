Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3134734B94
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjFSGLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFSGLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:11:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4256983;
        Sun, 18 Jun 2023 23:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687155086; x=1687759886; i=deller@gmx.de;
 bh=P+Esof1YkoJviOw/O1LMFwIZDYvJjAHEzRBugaxqQ08=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=BePiKZC93rn8fb3tdbAg2dfQTQDxM6OtIMabvFnND5NRxQw6VZJb13KN4qydEIBwaWhzg/A
 7tIqj/ORg5X9/EuzaJCTIxMFpWd2E4BQqEhxd/CxItD5CrezVgnPqteX73hVcGhpicPyYTcw9
 8QjVD3qMKtJoUBeyKfzgI2TG1hJVTGT2tmT/i7yPHrF/jQ2Zcgceq+5sPgX//0JykMWXupXOY
 pqkl8PiSLisNPWmpwd9q/jJ3NowUA2ZdqYJTGtr4C/VDrQ/2TOTW4bNHQSDcLMOIcWubvPV3V
 JEMT8cf48Yke8Awy1ZRodTcazyDEtLVRQNmRJew29K3YkBMNfRew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.204]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacSY-1pZ3Su09tK-00c7D5; Mon, 19
 Jun 2023 08:11:26 +0200
Message-ID: <761b02d9-d2a8-ffd0-d7aa-0b3160fc9e5c@gmx.de>
Date:   Mon, 19 Jun 2023 08:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] fbdev: broadsheetfb: Add MODULE_FIRMWARE macro
Content-Language: en-US
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
References: <20230616120705.1030177-1-juerg.haefliger@canonical.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230616120705.1030177-1-juerg.haefliger@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hfcVO7x5PoJ9wUPo2VY6PYhbeY5iIVs48mMTqC1se1qLyRYGVMI
 v8u+3EYAQ4/jGacPPv9n/hkejCM6bFQ0WP225Gx1wOHL44MfTzupQevSiIgHIj0viuFGCvk
 GUzWPx5+a0gb4RaW7dYPclN5U78ijHXyuwrb06P3edefeA6cXni1L3FZ5qFhvjTlh0Mj9Lj
 ues2EfwxB03uyM3NNZIWA==
UI-OutboundReport: notjunk:1;M01:P0:0Ag5jfjhGsQ=;qdlVMD8TfhfR7aT+8a6uoU3+c1H
 JI+t0bkgiHlhSYEKHpnTmj8Cjh9NtQXIkeWKVn2DFp7DxSkXdGHF1Lqn0yhcKNYProLIx5CsD
 Y6UyQJv7uULHiLZjd2LK9z/eyFZ3QJxmwxSHpk+3Ws3kKI9sODia9gGgX3nSzyVGtgN2cBJxd
 vmPIjkFlw5hc88iuHL19BV1mxIDtXeRlqzYJRIHhqLVJPPvcXznerkGcO6YnOq1ZPogFUztli
 n7ntROY2iiU+dKQuDIS0svPWcKtmgjMit9io52puP8yrHWqBo1KUCKfmKNnD6X40d4lqfv5Kr
 Nfuc9jVj3hq7iSY40VYSjt+G20DjnqmxYHEHuA/JFuaQXOI6ZFf2ioU5jyoGd7fF+gXhDiIQK
 +w5uzdtPlC5Ljz+zbBuOyMI4K8tChIyqdKNi9RBnBHdh6JYyGnPlxATCTfccscMui6QJRHfHk
 qOYx7XG9OBDVQ6FlQIyqMIoXs+uE4xhDNTUoe6YgI+Z/jLyhpsdTtFvRBP5LD40oAqyNd9LQF
 PXlngLbpZTy+vXqH1jko3m0azI230OPJtg5kX5oMK624iioGwPVRw4rax//p8ZJrdD4z8QwAd
 Zk+C9HajA38ODObt4fuc+ThWoFm3TVBxiyYst8wEnn6HURNknW2XlXyQCVKVwgPymgmaJk7Ki
 ZftUXPFR5jWoXdQZDYZ8qGdnFWVds1cNbnTwdmvqyjXiV+qhChHJsZozSHNz3WFMhbMe3SLvM
 xO9dvv1sD0Usae6aScmJ8gKBFFJwWYZ/0RedWX6vVGFcwnMQNRq80I3M68v6tIap2mNcMLSRO
 MTkw/534DZc71UVMWQxL0+XvMU0LOZOXgLpx5dGiW79b+OxRfZ8kBGo/n/e83nQjgHyIWLp4a
 S9bMSu71pugLRQSqgTEJXRiLB5nArYPa0/YeXQCLXj6/s8vUcHGnpkVVKa7eQphjYly13994P
 SCL9xo3RdX4rWlQV9Oqv/X74ozo=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 14:07, Juerg Haefliger wrote:
> The module loads firmware so add a MODULE_FIRMWARE macro to provide that
> information via modinfo.
>
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>

I applied both of your patches to the fbdev git tree.

Thanks!
Helge


> ---
>   drivers/video/fbdev/broadsheetfb.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/br=
oadsheetfb.c
> index b518cacbf7cd..678d182d187d 100644
> --- a/drivers/video/fbdev/broadsheetfb.c
> +++ b/drivers/video/fbdev/broadsheetfb.c
> @@ -1223,3 +1223,5 @@ module_platform_driver(broadsheetfb_driver);
>   MODULE_DESCRIPTION("fbdev driver for Broadsheet controller");
>   MODULE_AUTHOR("Jaya Kumar");
>   MODULE_LICENSE("GPL");
> +
> +MODULE_FIRMWARE("broadsheet.wbf");

