Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D745274A627
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGFVxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGFVxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:53:21 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45881BEE;
        Thu,  6 Jul 2023 14:53:20 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-766fd5f9536so103447685a.3;
        Thu, 06 Jul 2023 14:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688680400; x=1691272400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBxUFQm+Fi2nfK6JwAktFvqvGOaZfQCpQcGkegfNKWA=;
        b=IdwYkOkQgpfEOoBHEabk9hjQtHzBsF6ZeF9SD6dm87+oBCmYkcLIlUY8np6XZm3KWd
         I7RIwMxH5MMGnDFYNcEIYMXVJ+5EKg89pSzAwA5BK3vDXu+CygwHmIX9qW63Rwe+zzaA
         a2AGeJTgXLZsZwwOSbaxSswTYyQ/+mKiRaCgAIA03AehpeQG71JDkhmaMvB+dS7Ojdyd
         /lGVv6dpqLvOyKQx/sOTHDlYxIsqv3esCU7h0IReQA3Zkca1ixjjqCq8GGp6604KroDm
         Ndn+srE9Gmpn468LzjoX0KuV7vqj958pM8qZXQTzXT/5pLc0Cs0r49r1GFv/COYVcOIY
         Diag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688680400; x=1691272400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBxUFQm+Fi2nfK6JwAktFvqvGOaZfQCpQcGkegfNKWA=;
        b=JauSM7TpH2GhBhlvHDhb00wXjD5CbApQYfiNq+RaMQ3x4Q4IjH9dLPQNM2jNgwHucc
         r5MjYyycXJAR4R7VjGM9mIVa1hcwodMkX4dAkjwTMyhKWkMZzR8M/7IXnijlD2ReZ+hx
         qQnpqU07w5R/ki8cugPG+mpweHXx7ul8J4NS+I0nGngC/JY1VRirFuF2W0jeW45Zq/yu
         MZpFS3MxLEfzs6sN6AU083kBVZ/YxcduDdBElmmBemVKlEzHO87RG7DzFXLABkHBdwG3
         wn3SLOcmMSP0W7WCm4Ae2vI25ZwtSLLxrrPwiA8mW0l/oMhdi4l7T1LzeN6US3a7Dtrt
         9mWw==
X-Gm-Message-State: ABy/qLbKmtjIJlSgKWduTW+8xEOfughIAnEVkZziMp3ePTKA6NcWPOUD
        4JqLp88h9R2rBlVaq2TVHinpBI77vFZM88SymRY=
X-Google-Smtp-Source: APBJJlGOP1AXpGFdZDFE3UAD3VyP7xlxaQsokLGHTP1lR8hT5XwQ8vbLB5qiIdhGtjSdyH+n2FfHNFCBgPIK/LJexpg=
X-Received: by 2002:a0c:e54d:0:b0:634:7c34:6c96 with SMTP id
 n13-20020a0ce54d000000b006347c346c96mr2615436qvm.7.1688680399878; Thu, 06 Jul
 2023 14:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
 <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
 <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com> <20230706-barcode-front-5bed954740a7@spud>
In-Reply-To: <20230706-barcode-front-5bed954740a7@spud>
From:   ron minnich <rminnich@gmail.com>
Date:   Thu, 6 Jul 2023 14:53:09 -0700
Message-ID: <CAP6exYLPq__LeMk43uh3CCb5cG8Vc2PWDPoY2U6spb=Fgd=7eg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Ard Biesheuvel <ardb@kernel.org>, cuiyunhui@bytedance.com,
        jrtc27@jrtc27.com, kernel@esmil.dk, sunilvl@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oh, gmail, it popped back into html mode for some reason. I kinda wish
it would stop doing me so many favors.


On Thu, Jul 6, 2023 at 2:47=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> Hey Ron,
>
> On Thu, Jul 06, 2023 at 02:39:13PM -0700, ron minnich wrote:
>
> Please do not top-post or send HTML mails to LKML, they are rejected by
> the list services.
>
> Thanks,
> Conor.
