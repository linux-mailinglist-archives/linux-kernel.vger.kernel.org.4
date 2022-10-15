Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D65FF955
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 11:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiJOJC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 05:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiJOJCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 05:02:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754AB56BB1;
        Sat, 15 Oct 2022 02:02:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r14so9711736edc.7;
        Sat, 15 Oct 2022 02:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hgn4WdQWLSI7cmvgAKeRgRqj8UF4rbqA4eiKcisVFTU=;
        b=bPyYkDHWwoQG7pYYU4nU65RS2RV35G/soZ6QcHbqokdYXmGCJ1+OggW9GHMUSHYCUU
         5rt7zWMMxCa32EG/v959hzGRmDGMqWJMztwbQP1yklwmcfhDQ8q5nxBNezVjZGlSSJ8H
         yRfOYyWh3x9KxcBSPiNMJDgK1C/k8KtV1AI9b/HjqUfCKDLAeMFRkpH4ktBAKKxIwt+W
         UKBYvh7q5kkBpoxwMFygbHoPpcrOn2fmaKhSyfYg3qWcBQrYcURJBejOA6vBWngf4ELv
         ZvUrcflIRIYhKpLnUmCQX4l9Y07QhUI3eOtTjVEB0/ZnQYKCttVP75LVXvOqgKRJmyO1
         uqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hgn4WdQWLSI7cmvgAKeRgRqj8UF4rbqA4eiKcisVFTU=;
        b=ONaNbpZKtQ7anVz85N6TPELPDX8LjqiOWIbyrZ+EBKWxPLS2Mb+xc58QJUGpHEcObq
         HdCgGfQc9TxtqWYzCZ/z200liJsjr+dExtG6YT7GT5IIHW6UjWBVhCEauCUsY4FepHWT
         Rp2G6u8NUT6ID/4EsEMixSecrjeFKH5cp2SnCl+w1Gftf8qfs9aAcv7j2gxgZHPzEVuZ
         YUqFmCPHHCFa42MExzItwx/9E7FBLihJYB+0cFRM9BV6A7gkCwlNAQaA+EjnYcK7+dXG
         3I2Nu9TTvONLqcl7t8+T2iXRDNsDi8QlvVAI2DnFc4JLuOPVkfTUzhvY17UC/bYNqwND
         X3dg==
X-Gm-Message-State: ACrzQf1Pl8g8IXmxR+jxxsK+yJrdYk6q1ABsK4X08HIF7/uNkPZ/xlZl
        xTvKR1MhkYXdn7oUdj6FfsyI95ljvpt0qlgKCx0=
X-Google-Smtp-Source: AMsMyM7J8cQIhXmjuXqbiIXrKUMM+TuhLxe1ybbGAjs+Tjiu++y54QCFzZy+o9a1k+ybzNoDI3ZL4PKoOjVGkQdU9FU=
X-Received: by 2002:a05:6402:f83:b0:458:8c97:29af with SMTP id
 eh3-20020a0564020f8300b004588c9729afmr1529213edb.210.1665824542949; Sat, 15
 Oct 2022 02:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221013214639.31054-1-palmer@rivosinc.com>
In-Reply-To: <20221013214639.31054-1-palmer@rivosinc.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Sat, 15 Oct 2022 11:02:11 +0200
Message-ID: <CAOi1vP-dMp4pEMuUxQV4Ro73TNioGi9sagYU6j_AxWOpPbuKwA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for ceph
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     xiubli@redhat.com, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 11:49 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3699b2256dc2..8da92ff58b9d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4771,7 +4771,7 @@ R:        Jeff Layton <jlayton@kernel.org>
>  L:     ceph-devel@vger.kernel.org
>  S:     Supported
>  W:     http://ceph.com/
> -T:     git git://github.com/ceph/ceph-client.git
> +T:     git https://github.com/ceph/ceph-client.git
>  F:     include/linux/ceph/
>  F:     include/linux/crush/
>  F:     net/ceph/
> @@ -4783,7 +4783,7 @@ R:        Jeff Layton <jlayton@kernel.org>
>  L:     ceph-devel@vger.kernel.org
>  S:     Supported
>  W:     http://ceph.com/
> -T:     git git://github.com/ceph/ceph-client.git
> +T:     git https://github.com/ceph/ceph-client.git
>  F:     Documentation/filesystems/ceph.rst
>  F:     fs/ceph/
>
> @@ -17028,7 +17028,7 @@ R:      Dongsheng Yang <dongsheng.yang@easystack.cn>
>  L:     ceph-devel@vger.kernel.org
>  S:     Supported
>  W:     http://ceph.com/
> -T:     git git://github.com/ceph/ceph-client.git
> +T:     git https://github.com/ceph/ceph-client.git
>  F:     Documentation/ABI/testing/sysfs-bus-rbd
>  F:     drivers/block/rbd.c
>  F:     drivers/block/rbd_types.h
> --
> 2.38.0
>

Applied.

Thanks,

                Ilya
