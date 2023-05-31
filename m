Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6870071879D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjEaQiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjEaQiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:38:11 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13567E4C
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:37:39 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-62603efd2e3so32811896d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685551058; x=1688143058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjg7ATpl7VoZqUHF1Mhzj4Gq7ctPuYHs7vKRTJDLnJg=;
        b=evZ3sCt2GuNl8d4ckGo4cB+AFEOqA53JM74vQUFyBUkY91nHpch3Sf+0slxb9s456T
         g+wA9AHPb8kXFzgvTmKZEkkTSeWEm5zxzg+MBjXCRDXSaKNn12Bm3pAkOrPbpAJ393zn
         oM/m1gsXGl1sVIGgJUsOR8J0FaACoUjz3KPR2WNyt00DNn3EJZKt1JtLDCBWCeVZcacc
         g43Otdiv0636E0hkUzfTh8q30a7SH9STtK8SOqjGjpCxZ8vkCq518RN3sS3w2u2rvr9g
         4AXSRfdy+6I2gFZKpctTvdn8iHGorGTMlBxaCJquAkwMpoVlUG5fuXgk3csBYg8bjYjW
         hN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685551058; x=1688143058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjg7ATpl7VoZqUHF1Mhzj4Gq7ctPuYHs7vKRTJDLnJg=;
        b=Rvg0tl0N7leAImuC2/1lVPdPEpDUGTImLV1CnpfeKaoTcOzZL9wGJb0sfW50BWqpo8
         8WVK8a+999F3KPWiWIQ5rJbDBelkKCzHQ2rY93FyGf97tQcjY7+4850ZEiTwhaVZpIC8
         11L7iQIILfMjCfdYHQsi0Hy5CfKjde5P3jgqqGXmVtEQMmaKCiZEf5kMaw2QgYHxEJN0
         ot35o2MozK9kED+avjyEu1KN5zRUd/UyYD2mA0CbzEVJdpeYUi8YK8cMRakMEnN0SSlI
         D6HPWcV4tVxVLGTkI4X7SHOGytPZk3clDDCYEyIVQ5rCywGC+FrRZOQvOOM/HUaZq/7g
         gcbA==
X-Gm-Message-State: AC+VfDzfPGVLuYHZwxcW83+k1XGzXgMcfYtS0CoLn+HELHPTx5BIQzsk
        SFKuy00eqIhdqowFfkWEPfxPyAUVJ34iuDoKe2sR+Q==
X-Google-Smtp-Source: ACHHUZ7OQYcBLESi3+AWNMJzseVA3TTXzpYCG2G1qkVeeINEY3MFtLGW9X+2Vp06MV/k/5fL/w0a+jBSxDeRAUIQxqk=
X-Received: by 2002:ad4:4eae:0:b0:625:aa49:19f3 with SMTP id
 ed14-20020ad44eae000000b00625aa4919f3mr7178487qvb.64.1685551057971; Wed, 31
 May 2023 09:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <b59d1bfe-15b1-4318-a12f-a38143ba35bd@kili.mountain>
 <4716f9fd-0e09-4e69-a802-09ddecff2733@app.fastmail.com> <6b1a0ee6-c78b-4873-bfd5-89798fce9899@kili.mountain>
 <2fce7746-6d63-4853-9b20-8fa0b24d6f32@app.fastmail.com> <41c61895-59f4-449c-9e2e-d127d7f95be5@app.fastmail.com>
 <33173e7b-0ec0-4a1e-9533-0d3b6eb4c8ce@app.fastmail.com>
In-Reply-To: <33173e7b-0ec0-4a1e-9533-0d3b6eb4c8ce@app.fastmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 31 May 2023 09:37:26 -0700
Message-ID: <CAKwvOd=ATzs8JruqK=LbszDamasmyaYQJ=4feMB_ZJJ3if=GaA@mail.gmail.com>
Subject: Re: randconfig fixes for 5.10.y
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org,
        "laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 3:12=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, May 30, 2023, at 21:20, Arnd Bergmann wrote:
> > On Tue, May 30, 2023, at 21:02, Arnd Bergmann wrote:
> >>
> >> CONFIG_COMPILE_TEST=3Dy forces a number of options to be
> >> hidden from build tests, which is generally super useful.
> >> The one that ended up hiding the stack growth above is
> >> CONFIG_GCOV_PROFILE_ALL. I'll try enabling it for a few
> >> builds to see what else shows up with it.
> >
> > Update: you already pointed to UBSAN_SANITIZE_ALL causing
> > this, I can confirm that this is also the case. With your
> > config, the combination of CONFIG_GCOV_PROFILE_ALL and
> > CONFIG_UBSAN_SANITIZE_ALL causes the compiler to completely
> > mess up register allocation in this code, disabling either
> > of the two gets it below the boundary.
>
> After a night of randconfig builds with both UBSAN_SANITIZE_ALL
> and GCOV_PROFILE_ALL force-enabled, these are the ones I found,
> listing only the worst size for each function (using gcc-13.1).

In LLVM, a recent change we made was when the sanitizers are enabled,
the GCOV instrumentation is not checked by the sanitizers as that
results in excessive code growth.
https://reviews.llvm.org/D150460

> None of these show up without GCOV though:
>
> crypto/twofish_common.c:683:1: error: the frame size of 2040 bytes is lar=
ger than 1024 bytes [-Werror=3Dframe-larger-than=3D]
> crypto/twofish_common.c:683:1: error: the frame size of 2336 bytes is lar=
ger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
> drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:1589:1:=
 error: the frame size of 1696 bytes is larger than 1400 bytes [-Werror=3Df=
rame-larger-than=3D]
> drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c:754:1: error: the =
frame size of 1260 bytes is larger than 1024 bytes [-Werror=3Dframe-larger-=
than=3D]
> drivers/staging/media/ipu3/ipu3-css-params.c:1206:1: error: the frame siz=
e of 1080 bytes is larger than 1024 bytes [-Werror=3Dframe-larger-than=3D]
> drivers/staging/media/rkvdec/rkvdec-vp9.c:1042:1: error: the frame size o=
f 1660 bytes is larger than 1024 bytes [-Werror=3Dframe-larger-than=3D]
> drivers/staging/media/rkvdec/rkvdec-vp9.c:1042:1: error: the frame size o=
f 2176 bytes is larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
> drivers/staging/media/rkvdec/rkvdec-vp9.c:995:1: error: the frame size of=
 1656 bytes is larger than 1024 bytes [-Werror=3Dframe-larger-than=3D]
>
>       Arnd



--=20
Thanks,
~Nick Desaulniers
