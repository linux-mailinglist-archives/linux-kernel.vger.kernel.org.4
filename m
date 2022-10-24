Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BBB60B94B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiJXUII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiJXUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:07:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC58457E30;
        Mon, 24 Oct 2022 11:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666635988;
        bh=AHsSRYOn624aglQzBbLTGeMMeK4dqdkEWBCmG0Qjo0c=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Xb99oPI3Bv8y0+6+AzNe69kBOwgCKvpWHOeW/bYLY3GZmZukYvqliSJMnJYILnc1/
         ReV2JzC2EHdkXqGrtPwmxCimb+JTYTMK/b2niqBb0SwtI6P8ZklMTq9KvA+hwOHpXe
         zu+HmZt/61Z8/NgrHkacRPfShKyaD1K4yamtETfU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.136.30]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1osH8Z1Abf-00HKCF; Mon, 24
 Oct 2022 20:21:12 +0200
Message-ID: <703cb0e6-a98a-a8cf-880b-c86a456f57b2@gmx.de>
Date:   Mon, 24 Oct 2022 20:21:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] MAINTAINERS: adjust entry after renaming parisc serial
 driver
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-parisc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024132223.9697-1-lukas.bulwahn@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221024132223.9697-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X+RkhzcAKeJ4LaBz452qdQRxK7w7nMwo0/N8QXvkyA8rTCrO51P
 ykRVIZVpAJLLv93RHCxL/KHLh4Gh8aVPmN0BVFkgbdf6cuMI64plWRW2ZUiqJqyfaQleS8j
 m+/XwtREHojiolHMxnQo335Q/ksZ65VvtAaduvY91Mv0jvSQOTFNhxPJ8ZU+U4E18DqrHi2
 bQo2nu3DamlzL2sqXwlwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ckw8bMAx+o0=:buDpt2fWNcjgKDH3O+qEgm
 zxBePrRCZyai4uxYvYVr/TmdkAE5uO+TV5qZfRsqjFX2xOfmTCJWlAIwWrs4ncsjqS/conkmR
 QQtzxJwo6rJ6FyEvBiNwZEsLh+OI+WyUfb+fsIH9YOC+wZhuWD+bV2qmkX2Cl0644golveWt8
 REy51jWubVH8Y1lXSyPaQcEMzo1Fiso8M4bseFnVZKgdJ8wPqvdAG/drQ0fvDxTdL0kLyv4mT
 VpAgJALpDduI2KCxicF8f89ZZg9H7MSizAWkOROqlxlOh4PpAa94e3GHv/HJa0ucTlBkvubDB
 CsNMi/FNQE8zkvdvL1PMth1KcuVceFv4qtMEuQwJeKylS07QWchZGo9y9qVQR3lMsGiJ+4olI
 9meyWIBVOmAkrQE9Vs3oXFWukuizYu6pR78FjXvI9tB7J6KMi6n+5rLeT80F0Um3TbTv8FvmC
 3Tev97gzjR1nmfBDS/reHi4qjkbs0pBIUtyQU5Z4JFZRRIzeMPdvj5pBLhaw0yf4iCr3h60Zc
 +xJQppc+o4x/YHGdbciF0xPBr8jf+sMksmZ7bVOFwWXrr5QIXThD/LW6S6dPZFGZvO9MF6omR
 BgEriNDTvvdzc9ceQOoEFilLS0cJs9NP5Gl7xWmXFH+kluDWQ7xqAEqtF05ZuqdgMUR+yuSXr
 s9mLaRs1KHGCek/TeX0yoPXOMAx7PjYGJCKc/UQ2oSIMXVDJWrc0C6dfzr+sfY/kDh3yxNKyb
 TaPdHBVYMVyDtn8QzLMICLzjPsetsbbE55eE2+i5LpTE10d8tf3WNaqtmILNvYSwr6+L/lc3s
 sWS2yAAIx4y8/it+Eua1gEB1rfCv8Un6ZRnzKe0Wueml4kXTgrdTkiIEs/6ia87GInnFv9Iuq
 X+daJOzuRmyt0TvmDAzxmb066G5C/xGBUb6ACyE8J4W+QO8nXb4hE07LbeoEvql+jy54AdHFL
 duC++sZB94m3AI7GM/f0oXVcQchNjgtuhAgj67sVOtE4ehMcAEhRHa0IbwiWr+DOIXNF6jEWa
 aVigZ+4U3X1HquQiXlxndUGqS+jPaJeD3fJXNdb4yQ+2GI81TzNvilhVjJthrFTUXuWx1rSMS
 IDZxX3zHleOWFV9VEwjo82HX8R0eiAqkBJdSwtunopeFMhUpi37hH3ZkLGh1RCaR6CpREn402
 WprwsTPvFxkPFTGvdqCzxmK9ro+Y8QCwE9cKOtGIVytwS454m+Adzj6t9tW+IFUPXBH6daBmC
 oZsfDX8sxeXoJciYCGqkXDUw2vB1VppMPq3rE1bYmzW7iSzh+Rmist4khJOVYPTyIm65ETP84
 afFNxCUF/xzdRMq/HF20L8E4iFSrAZxOoxDhIza9O9w/Jhv44w0cdG+d/9KB9Mrvnf5mDJpUv
 hsrNEJuXOW2Yqu9eIaRLrq8rRZX/d1QtTSZ2elZ3rNPQBj26zcoG0nd3nyiznpxTHIDTrDNLs
 3fs2seKkapg8375H6gN7s/pZLzdOXKWtD0xj+AcCk2KqIainPX/hCtgzzgIY4kcYwVdVySIYT
 DfWcEEtyehAZolUgVAixKU5vCJKPfl/hujgcFDbMtQxBT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 15:22, Lukas Bulwahn wrote:
> Commit 9e4e2ce1a78e ("parisc/serial: Rename 8250_gsc.c to 8250_parisc.c"=
)
> renames the parisc serial driver file, but does not adjust the entry in
> MAINTAINERS.
>
> Hence, ./scripts/get_maintainer.pl --self-test=3Dpatterns complains abou=
t a
> broken reference.
>
> Repair this file reference in PARISC ARCHITECTURE.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Nice catch, Lukas!
Applied to the parisc git tree.

Thanks,
Helge


> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 91d95924cff4..0c8198b3329a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15637,7 +15637,7 @@ F:	drivers/input/serio/gscps2.c
>   F:	drivers/input/serio/hp_sdc*
>   F:	drivers/parisc/
>   F:	drivers/parport/parport_gsc.*
> -F:	drivers/tty/serial/8250/8250_gsc.c
> +F:	drivers/tty/serial/8250/8250_parisc.c
>   F:	drivers/video/console/sti*
>   F:	drivers/video/fbdev/sti*
>   F:	drivers/video/logo/logo_parisc*

