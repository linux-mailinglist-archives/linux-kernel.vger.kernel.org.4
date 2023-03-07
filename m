Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FD36AF5C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjCGTfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbjCGTew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:34:52 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6C8AFBAA;
        Tue,  7 Mar 2023 11:21:47 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-17638494edbso16177893fac.10;
        Tue, 07 Mar 2023 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678216907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhRiVT/qBtmkjy7WxqhkqSdjANQulevS1fkYVnIeB8I=;
        b=Od1ozCy+5nFpaAn16UDS5EgVldYYsLMTpa5G8VLkLZclgAPeP8UfHk2L0ntM8oJAN8
         h4KAv2HFOE2i2y5BSReAp9mO2KOun1n4OT/or29Dx92Og088SGbykzTjyDGlfgxin4E9
         kb40QGVp01EPScKCduxS58CqLUM4Gtnzmr/RY2ADMv2uQLVggPgL5H1eQtGssPEyL1KF
         G3jDosjwHNKBFiBsn4FdCppC9Bx/nKdWzmbroCQFy0kfJQkA3m4ba3cIxZzzskpYivXD
         X4IOXkyIqvMS0Mga5d1qXhOVDerHeY7w+Lo4EyKIrhgHSJ4o1kN+LNkMYIySgJG5n2kg
         u3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678216907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhRiVT/qBtmkjy7WxqhkqSdjANQulevS1fkYVnIeB8I=;
        b=kqAMwKdrGT5AKwdtvgFCa7byHKNlk0n/vS3zuSf17EfyXMGYIeon3hcstQBTyFTYmI
         GtkIB3GEEyzRU2aLflhxNG634GVSznZpfHa49JF2MKVa5UOLT+4MqnF8EG1tsd0eGpMQ
         R+0RH0coeY3jIjyxFOuE3tjgwrsIye7dOGbHNDGYvTpq4aelQV0gVL7pEKx09O0qusO/
         Z3jnVzEQqDpWugR3ZEsczHEsYijki/G/Cq61ZQm80UzF8t98ow8kdgN7lH8tuoEVWFQn
         wiimWaK6TMMd3G8bqTjRbBgvwu0N6o98UyE8ypD7O9efUMHEprE89ZuAZNHvbR4CnxNr
         pmvg==
X-Gm-Message-State: AO0yUKVICulnalsBlRQJnX+zcNJRYW2Yes3+yop+0HYW0/VMDQ3MQqbU
        Kr7LIevYYsv5BNm4gEDT2KAlMgwecYjFEVZXnko=
X-Google-Smtp-Source: AK7set/z3NJWfYPgz3oGl/RPEjJKQCI8IMnZlfRg60l9fl5OgNDCuxjK5GrQrqP6rkl81nleyRQqyvXI5sxEKvhuZaI=
X-Received: by 2002:a05:6870:d346:b0:172:426c:8304 with SMTP id
 h6-20020a056870d34600b00172426c8304mr4153366oag.3.1678216907057; Tue, 07 Mar
 2023 11:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20230307174627.23787-1-rdunlap@infradead.org> <CAOMZO5DDH=9MMbJX3O8yU7RQjudeC-oXhoT-nu91p1arqHcBGg@mail.gmail.com>
In-Reply-To: <CAOMZO5DDH=9MMbJX3O8yU7RQjudeC-oXhoT-nu91p1arqHcBGg@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 7 Mar 2023 11:21:35 -0800
Message-ID: <CAF6AEGtgMtRbP9OLh4P+2xL4SnyhP5ROgg2Yt=ZcoAY_+=S7rg@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH] drm/msm: fix PM_DEVFREQ kconfig dependency warning
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Clark <robdclark@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 10:48=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Tue, Mar 7, 2023 at 2:46=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
> >
> > Since DEVFREQ_GOV_SIMPLE_ONDEMAND depends on PM_DEVFREQ, the latter
> > should either be selected or DRM_MSM should depend on PM_DEVFREQ.
> > Since most drivers select PM_DEVFREQ instead of depending on it,
> > add a select here to satisfy kconfig.
> >
> > WARNING: unmet direct dependencies detected for DEVFREQ_GOV_SIMPLE_ONDE=
MAND
> >   Depends on [n]: PM_DEVFREQ [=3Dn]
> >   Selected by [y]:
> >   - DRM_MSM [=3Dy] && HAS_IOMEM [=3Dy] && DRM [=3Dy] && (ARCH_QCOM || S=
OC_IMX5 || COMPILE_TEST [=3Dy]) && COMMON_CLK [=3Dy] && IOMMU_SUPPORT [=3Dy=
] && (QCOM_OCMEM [=3Dn] || QCOM_OCMEM [=3Dn]=3Dn) && (QCOM_LLCC [=3Dn] || Q=
COM_LLCC [=3Dn]=3Dn) && (QCOM_COMMAND_DB [=3Dy] || QCOM_COMMAND_DB [=3Dy]=
=3Dn)
> >
> > Fixes: 6563f60f14cb ("drm/msm/gpu: Add devfreq tuning debugfs")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: lore.kernel.org/r/202303071922.wJqDWQpe-lkp@intel.com
> > Cc: Rob Clark <robdclark@chromium.org>
> > Cc: Paul Gazzillo <paul@pgazz.com>
> > Cc: Necip Fazil Yildiran <fazilyildiran@gmail.com>
> > Cc: Chia-I Wu <olvaffe@gmail.com>
> > Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Cc: linux-arm-msm@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: freedreno@lists.freedesktop.org
>
> This fixes the warning after running 'make imx_v6_v7_defconfig', thanks:
>
> Tested-by: Fabio Estevam <festevam@gmail.com>

https://patchwork.freedesktop.org/patch/523353 is the fix we actually
want.. I thought I'd already pulled that into msm-fixes but it seems
like it got lost somewhere.. I'll rectify that

BR,
-R
