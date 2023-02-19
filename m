Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0E869C373
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 00:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBSX4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 18:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBSX4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 18:56:08 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4941DB471;
        Sun, 19 Feb 2023 15:56:04 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-171dd24195fso1615709fac.13;
        Sun, 19 Feb 2023 15:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RC6aVqKrLzD33x45uoZ7a3CktqmJcQ/IxPDaR/VQw4g=;
        b=De6Qr1LZH4+TfC/gmnhiltof1tAlRfIAIhkRAmVSq8E4Azeqd4rjEUAqX6judBCaJq
         VR14GGF8cq5a022N/pk+1aCCP9kPBWJdIJSIY1UmWfQqyxpeQnPIjcBPqWqWEoe2pPQC
         tsgLS8FiuTbWkUoxxRGyopNRAED1NBwklTPIZxzjEofB9fah733zdTTDRDQBacb1Zb8m
         dgjJo9dAc6kubVnmPJaqMuxl/pMMy/nZPoX6UwPZrx7oYZV9CnvoQ25yPyTBqt1PRC1a
         AZ52G8Tij+TbaNG05Y2bT7CxDOAQ0Nf+wVnd1HabhiJV1Wqv+sDxthhb4IqFFuq8VIqA
         VFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RC6aVqKrLzD33x45uoZ7a3CktqmJcQ/IxPDaR/VQw4g=;
        b=AjHv76a35ycbrTC7Vv3iog3i0wBIUBoCItae/EwEfsxRhpx49PB16CeHjk0Tj6P+VU
         k4kCUT5N9h2e9eLpuO+BP6Q0vZHldS0c7zIuQfd4lUOBiu/4e2hVYnhR+v0CZzqUvOem
         o1ZFoar30BOtH8lZALAIBCPTEmG5VHRcwQ9vKastpfDqsdXy6ZKt38JT27m/R2Sh5DfP
         6aSrJBP0dFCzE5vNVgz+cBVDDHlz4/9ZNYqXnj86MD7EGxu62GA5A3qalKzagrPrJfLl
         oUpivfJLF41gK8/dYfUjX0HfBBnAaiLEkPrLfYUDOIxygDP2umrGbbe5w2o1BNp3kx7D
         H/aA==
X-Gm-Message-State: AO0yUKWJ9RyxVE+OB1SYKco0JSMSC4oxeuz8lq2n8AqAnT1e0tOh2u4z
        m0LhL9BwEpDi5DLJ55RKb0rBk2DfwVaWf0SMwQXPrTGw
X-Google-Smtp-Source: AK7set9WTZ82dxivrETnVY64xFK9P7XrJ894qguvydR411g1XCPs9htBO48ENAuaz6iUY1lT9pGcUOgN4dN/L3j9LSs=
X-Received: by 2002:a05:6870:32d4:b0:16e:5e5a:49da with SMTP id
 r20-20020a05687032d400b0016e5e5a49damr1017498oac.58.1676850963555; Sun, 19
 Feb 2023 15:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20230219185401.10479-1-rdunlap@infradead.org> <CAF6AEGv7xU2vhSi95MbsjzpRv4ANQ-vOOrchjJ=-uwW9f2q6Eg@mail.gmail.com>
 <c10c0003-fd36-96f8-73d1-1a975330eb53@infradead.org>
In-Reply-To: <c10c0003-fd36-96f8-73d1-1a975330eb53@infradead.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 19 Feb 2023 15:55:53 -0800
Message-ID: <CAF6AEGv3d2vk2WdLp8CQhbR3gvWvT890NzKikO2i5++r4snYcQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix new Konfig dependency warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 3:12 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 2/19/23 15:09, Rob Clark wrote:
> > On Sun, Feb 19, 2023 at 10:54 AM Randy Dunlap <rdunlap@infradead.org> w=
rote:
> >>
> >> DEVFREQ_GOV_SIMPLE_ONDEMAND depends on PM_DEVFREQ, so in order to
> >> select the former safely, this symbol should also depend on
> >> PM_DEVFREQ to avoid a Kconfig dependency warning.
> >>
> >> WARNING: unmet direct dependencies detected for DEVFREQ_GOV_SIMPLE_OND=
EMAND
> >>   Depends on [n]: PM_DEVFREQ [=3Dn]
> >>   Selected by [m]:
> >>   - DRM_MSM [=3Dm] && HAS_IOMEM [=3Dy] && DRM [=3Dm] && (ARCH_QCOM || =
SOC_IMX5 || COMPILE_TEST [=3Dy]) && COMMON_CLK [=3Dy] && IOMMU_SUPPORT [=3D=
y] && (QCOM_OCMEM [=3Dn] || QCOM_OCMEM [=3Dn]=3Dn) && (QCOM_LLCC [=3Dy] || =
QCOM_LLCC [=3Dy]=3Dn) && (QCOM_COMMAND_DB [=3Dn] || QCOM_COMMAND_DB [=3Dn]=
=3Dn)
> >>
> >
> > Actually, I fixed devfreq[1] so that we no longer depend on
> > DEVFREQ_GOV_SIMPLE_ONDEMAND .. probably we should just drop
> > DEVFREQ_GOV_SIMPLE_ONDEMAND from the kconfig instead, sorry I forgot
> > to do that already
>
> OK, I'll resend the patch with that change, unless you want to handle it.=
..

Go for it, thx

BR,
-R

> Thanks.
>
> > BR,
> > -R
> >
> > [1] https://patchwork.freedesktop.org/series/113232/
> >
> >> Fixes: 6563f60f14cb ("drm/msm/gpu: Add devfreq tuning debugfs")
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Rob Clark <robdclark@gmail.com>
> >> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> Cc: Sean Paul <sean@poorly.run>
> >> Cc: David Airlie <airlied@gmail.com>
> >> Cc: Daniel Vetter <daniel@ffwll.ch>
> >> Cc: linux-arm-msm@vger.kernel.org
> >> Cc: dri-devel@lists.freedesktop.org
> >> Cc: freedreno@lists.freedesktop.org
> >> ---
> >>  drivers/gpu/drm/msm/Kconfig |    1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff -- a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> >> --- a/drivers/gpu/drm/msm/Kconfig
> >> +++ b/drivers/gpu/drm/msm/Kconfig
> >> @@ -9,6 +9,7 @@ config DRM_MSM
> >>         depends on QCOM_OCMEM || QCOM_OCMEM=3Dn
> >>         depends on QCOM_LLCC || QCOM_LLCC=3Dn
> >>         depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=3Dn
> >> +       depends on PM_DEVFREQ
> >>         select IOMMU_IO_PGTABLE
> >>         select QCOM_MDT_LOADER if ARCH_QCOM
> >>         select REGULATOR
>
> --
> ~Randy
