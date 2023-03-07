Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B79B6AF332
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjCGTB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjCGTBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:01:34 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168421B561;
        Tue,  7 Mar 2023 10:47:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id l1so14181693pjt.2;
        Tue, 07 Mar 2023 10:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678214877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwJJAAvs/O2Ca860Au7W009ZUX+Nz2nCyjxJ9JUiC9c=;
        b=SVrq4PHqefwMBQ12zcN68KF1qUQUGalmroUn03q8CKB5uCanpnIky7V5MDAywkhaQc
         rfWePlJqpiUUwUwthCl/WtukJCqbZ3JuBI6+eknfA2XEIvuYaOuDamtx6Cik85H8b6DU
         Z2/2ZBP/J1Ln5/l0/TyZr1ElRzuXl8bhd+x9ODtYviTiXhes7D43f2o0HtFBVHVzHYxy
         9Ntl3rJ/L3TNCVUMSU5CspoGFDxDe+eIYSvCx028dYAPtCcp3FI8T5MPZOuxNjWDhsqd
         NQC1T5n+foWtRctX8F79tp6bxw3EvDEot4Ud02NZ0L2O5nr3XCwjV+i7mebrg+mo0B+G
         06zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwJJAAvs/O2Ca860Au7W009ZUX+Nz2nCyjxJ9JUiC9c=;
        b=bebGyWhttjUFOXEi7xgrAlwErTEicWjBBEfPiXDm14nuam0MedDpQLMoWOrwb9dNtC
         x7bzjA6B21RBZgspRFA/xnQjgHIiccRdi47FgMaeELicqa9duVKs2rwDTdV11IWlSlyU
         +/ZADFtYPmgOxSS3/R4fPIYj9SxnT8CpIDlSn4g7Yh1UxVl3KK9rG8ikUAbCqSsNXU6h
         fn5yZ05E8p9dNUb5K/YfR6zZ51nDgSvusq9HMiBa0ZcgaX9PVU4YWzz3mr7I//hXmOwE
         rUYYBlGWP6O3xuSlsRvwnmydzNGYuLpipnS/li1bpFamKXH9Ni4SakdDdC4dYwb1A3LX
         nH3Q==
X-Gm-Message-State: AO0yUKWdCl601PThNlqsqjubqp0ZrtfkhFnNtjGIMrK2XjNO17iY61Y3
        00OG3/Gj9cN2BBVhF5xqLhNy1/TpVSRhxt9yIAQ=
X-Google-Smtp-Source: AK7set+RWbXBtnhVn5pdmO9M9UUd3hPQ/2kW4nJHVBb8wuIz7KYo9ibEge6VEuCkpeefEFX3i8aWJxysRMlUJCdmgf0=
X-Received: by 2002:a17:902:efc3:b0:19a:6b55:a44d with SMTP id
 ja3-20020a170902efc300b0019a6b55a44dmr8397723plb.1.1678214877558; Tue, 07 Mar
 2023 10:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20230307174627.23787-1-rdunlap@infradead.org>
In-Reply-To: <20230307174627.23787-1-rdunlap@infradead.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 7 Mar 2023 15:47:46 -0300
Message-ID: <CAOMZO5DDH=9MMbJX3O8yU7RQjudeC-oXhoT-nu91p1arqHcBGg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: fix PM_DEVFREQ kconfig dependency warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org
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

On Tue, Mar 7, 2023 at 2:46=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Since DEVFREQ_GOV_SIMPLE_ONDEMAND depends on PM_DEVFREQ, the latter
> should either be selected or DRM_MSM should depend on PM_DEVFREQ.
> Since most drivers select PM_DEVFREQ instead of depending on it,
> add a select here to satisfy kconfig.
>
> WARNING: unmet direct dependencies detected for DEVFREQ_GOV_SIMPLE_ONDEMA=
ND
>   Depends on [n]: PM_DEVFREQ [=3Dn]
>   Selected by [y]:
>   - DRM_MSM [=3Dy] && HAS_IOMEM [=3Dy] && DRM [=3Dy] && (ARCH_QCOM || SOC=
_IMX5 || COMPILE_TEST [=3Dy]) && COMMON_CLK [=3Dy] && IOMMU_SUPPORT [=3Dy] =
&& (QCOM_OCMEM [=3Dn] || QCOM_OCMEM [=3Dn]=3Dn) && (QCOM_LLCC [=3Dn] || QCO=
M_LLCC [=3Dn]=3Dn) && (QCOM_COMMAND_DB [=3Dy] || QCOM_COMMAND_DB [=3Dy]=3Dn=
)
>
> Fixes: 6563f60f14cb ("drm/msm/gpu: Add devfreq tuning debugfs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: lore.kernel.org/r/202303071922.wJqDWQpe-lkp@intel.com
> Cc: Rob Clark <robdclark@chromium.org>
> Cc: Paul Gazzillo <paul@pgazz.com>
> Cc: Necip Fazil Yildiran <fazilyildiran@gmail.com>
> Cc: Chia-I Wu <olvaffe@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org

This fixes the warning after running 'make imx_v6_v7_defconfig', thanks:

Tested-by: Fabio Estevam <festevam@gmail.com>
