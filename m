Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A1F676612
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjAULmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjAULmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:42:42 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A0B1027A;
        Sat, 21 Jan 2023 03:42:40 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id dw9so7856106pjb.5;
        Sat, 21 Jan 2023 03:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHJDkBvlNstfz18vvoahKce6VuIb6P55yo97+y6lwa0=;
        b=UGWEpCN2IvqEPN7jbkvyVdInxTySPOiWUMas/9ZJPPmKhQ6wXHhFTt/RAeYb0YrL/x
         9thVJPjEnQf7F9QODIF5G/mUOXj/U7QYoyL54DNSXwTJ/XM6LwRfRNV6hf7EBhMwnbAr
         XkTG1Z80zd7CPTaEzGqcXxSEkzztqebatkciMEk2M7qnN3vIHpT3YZHItUEzXTOTtJmA
         /dHIhcxMqgYpNArH2o8sh/XvF7WyYz+oY9+W++REGjwPOF/h14bLgGfKLQhzs+eoBsGn
         vMSRkvvOZwEOW0GZ+dzJb3fAUKf8EkByIeEL6volnGoV/S3YSaYfIRaEjmRGpCB1spIe
         LvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHJDkBvlNstfz18vvoahKce6VuIb6P55yo97+y6lwa0=;
        b=OqSbuihCRiaLbdBeEtmTdAAQmsUH9X0iKBkthnxmGSjER/nDvrOHe3eUoe/5xEqpJa
         wFS3Dih+7VDQLBHnksfl/hXqmhHdUSA4xx2wnToUN/Guq7sxRuvph/B9mnDNFmM1LSVk
         qYIr8NzrXrGdO6bJO6UrONWwgWYjX62ImMtgKmJUUdj2Pmfix1LwagW7sR//FmaAb63H
         1D2zNI1pcaMEGCHEA6mHve1KgwrUFvok/HwMVSwEiqbvS6cY4NhM4BpOO3Jcu3YjyAuf
         Hy85T9CQyd7QfWHE7j/cZYoZah3xhlJSYWs/6cpXRFvbhKxoKaForS6xTZKZOKgG0wWf
         atBg==
X-Gm-Message-State: AFqh2krqthocJkbfhUvvL2cUBm1uSuKWHMke7pA78hsMYhMbpSQw5WsE
        Y7aM+p3tnPwnKnDzbpUuDrNkCWXIXP1H6p1M5UU=
X-Google-Smtp-Source: AMrXdXvotOY0y8RjovwfKKxFVDmVxaajAoAYRRWqCebJeKEiTAo2xCcSC2K71D/24/RcR4cRF2T4o/jFGftm+YVGr+M=
X-Received: by 2002:a17:90b:3110:b0:229:d5ce:64ce with SMTP id
 gc16-20020a17090b311000b00229d5ce64cemr1175773pjb.142.1674301359908; Sat, 21
 Jan 2023 03:42:39 -0800 (PST)
MIME-Version: 1.0
References: <20230121112947.53433-1-robimarko@gmail.com> <9956151e-d678-646f-b82e-fcf98ad25a1f@wanadoo.fr>
In-Reply-To: <9956151e-d678-646f-b82e-fcf98ad25a1f@wanadoo.fr>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sat, 21 Jan 2023 12:42:28 +0100
Message-ID: <CAOX2RU71caFrGT++AOm_yJzwUCGU033PEqxXew+sed1QdA4M6g@mail.gmail.com>
Subject: Re: [PATCH 1/4] soc: qcom: socinfo: move SMEM item struct and defines
 to a header
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
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

On Sat, 21 Jan 2023 at 12:33, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 21/01/2023 =C3=A0 12:29, Robert Marko a =C3=A9crit :
> > Move SMEM item struct and related defines to a header in order to be ab=
le
> > to reuse them in the Qualcomm NVMEM CPUFreq driver instead of duplicati=
ng
> > them.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >   drivers/soc/qcom/socinfo.c       | 65 +-----------------------------
> >   include/linux/soc/qcom/socinfo.h | 68 +++++++++++++++++++++++++++++++=
+
> >   2 files changed, 69 insertions(+), 64 deletions(-)
> >   create mode 100644 include/linux/soc/qcom/socinfo.h
> >
> > diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> > index 3b970a80f3aa..5919f863f369 100644
> > --- a/drivers/soc/qcom/socinfo.c
> > +++ b/drivers/soc/qcom/socinfo.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/random.h>
> >   #include <linux/slab.h>
> >   #include <linux/soc/qcom/smem.h>
> > +#include <linux/soc/qcom/socinfo.h>
> >   #include <linux/string.h>
> >   #include <linux/stringify.h>
> >   #include <linux/sys_soc.h>
> > @@ -32,15 +33,6 @@
> >   #define qcom_board_id(id) QCOM_ID_ ## id, __stringify(id)
> >   #define qcom_board_id_named(id, name) QCOM_ID_ ## id, (name)
> >
> > -#define SMEM_SOCINFO_BUILD_ID_LENGTH           32
> > -#define SMEM_SOCINFO_CHIP_ID_LENGTH            32
> > -
> > -/*
> > - * SMEM item id, used to acquire handles to respective
> > - * SMEM region.
> > - */
> > -#define SMEM_HW_SW_BUILD_ID            137
> > -
> >   #ifdef CONFIG_DEBUG_FS
> >   #define SMEM_IMAGE_VERSION_BLOCKS_COUNT        32
> >   #define SMEM_IMAGE_VERSION_SIZE                4096
> > @@ -121,62 +113,7 @@ static const char *const pmic_models[] =3D {
> >       [58] =3D "PM8450",
> >       [65] =3D "PM8010",
> >   };
> > -#endif /* CONFIG_DEBUG_FS */
>
> This removal is spurious.

Hi,
Its intentional as only the socinfo struct was not guarded with an
debugfs ifdef,
so after moving it to a separate header you would have:

#endif /* CONFIG_DEBUG_FS */
#ifdef CONFIG_DEBUG_FS

This doesn't really make sense to me, so that is why endif is removed.

Regards,
Robert
>
> CJ
>
>
> > -
> > -/* Socinfo SMEM item structure */
> > -struct socinfo {
> > -     __le32 fmt;
> > -     __le32 id;
> > -     __le32 ver;
> > -     char build_id[SMEM_SOCINFO_BUILD_ID_LENGTH];
> > -     /* Version 2 */
> > -     __le32 raw_id;
> > -     __le32 raw_ver;
> > -     /* Version 3 */
> > -     __le32 hw_plat;
> > -     /* Version 4 */
> > -     __le32 plat_ver;
> > -     /* Version 5 */
> > -     __le32 accessory_chip;
> > -     /* Version 6 */
> > -     __le32 hw_plat_subtype;
> > -     /* Version 7 */
> > -     __le32 pmic_model;
> > -     __le32 pmic_die_rev;
> > -     /* Version 8 */
> > -     __le32 pmic_model_1;
> > -     __le32 pmic_die_rev_1;
> > -     __le32 pmic_model_2;
> > -     __le32 pmic_die_rev_2;
> > -     /* Version 9 */
> > -     __le32 foundry_id;
> > -     /* Version 10 */
> > -     __le32 serial_num;
> > -     /* Version 11 */
> > -     __le32 num_pmics;
> > -     __le32 pmic_array_offset;
> > -     /* Version 12 */
> > -     __le32 chip_family;
> > -     __le32 raw_device_family;
> > -     __le32 raw_device_num;
> > -     /* Version 13 */
> > -     __le32 nproduct_id;
> > -     char chip_id[SMEM_SOCINFO_CHIP_ID_LENGTH];
> > -     /* Version 14 */
> > -     __le32 num_clusters;
> > -     __le32 ncluster_array_offset;
> > -     __le32 num_defective_parts;
> > -     __le32 ndefective_parts_array_offset;
> > -     /* Version 15 */
> > -     __le32 nmodem_supported;
> > -     /* Version 16 */
> > -     __le32  feature_code;
> > -     __le32  pcode;
> > -     __le32  npartnamemap_offset;
> > -     __le32  nnum_partname_mapping;
> > -};
> >
> > -#ifdef CONFIG_DEBUG_FS
> >   struct socinfo_params {
> >       u32 raw_device_family;
> >       u32 hw_plat_subtype;
> > diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/=
socinfo.h
> > new file mode 100644
> > index 000000000000..6a175d635617
> > --- /dev/null
> > +++ b/include/linux/soc/qcom/socinfo.h
> > @@ -0,0 +1,68 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __QCOM_SOCINFO_H__
> > +#define __QCOM_SOCINFO_H__
> > +
> > +/*
> > + * SMEM item id, used to acquire handles to respective
> > + * SMEM region.
> > + */
> > +#define SMEM_HW_SW_BUILD_ID          137
> > +
> > +#define SMEM_SOCINFO_BUILD_ID_LENGTH 32
> > +#define SMEM_SOCINFO_CHIP_ID_LENGTH  32
> > +
> > +/* Socinfo SMEM item structure */
> > +struct socinfo {
> > +     __le32 fmt;
> > +     __le32 id;
> > +     __le32 ver;
> > +     char build_id[SMEM_SOCINFO_BUILD_ID_LENGTH];
> > +     /* Version 2 */
> > +     __le32 raw_id;
> > +     __le32 raw_ver;
> > +     /* Version 3 */
> > +     __le32 hw_plat;
> > +     /* Version 4 */
> > +     __le32 plat_ver;
> > +     /* Version 5 */
> > +     __le32 accessory_chip;
> > +     /* Version 6 */
> > +     __le32 hw_plat_subtype;
> > +     /* Version 7 */
> > +     __le32 pmic_model;
> > +     __le32 pmic_die_rev;
> > +     /* Version 8 */
> > +     __le32 pmic_model_1;
> > +     __le32 pmic_die_rev_1;
> > +     __le32 pmic_model_2;
> > +     __le32 pmic_die_rev_2;
> > +     /* Version 9 */
> > +     __le32 foundry_id;
> > +     /* Version 10 */
> > +     __le32 serial_num;
> > +     /* Version 11 */
> > +     __le32 num_pmics;
> > +     __le32 pmic_array_offset;
> > +     /* Version 12 */
> > +     __le32 chip_family;
> > +     __le32 raw_device_family;
> > +     __le32 raw_device_num;
> > +     /* Version 13 */
> > +     __le32 nproduct_id;
> > +     char chip_id[SMEM_SOCINFO_CHIP_ID_LENGTH];
> > +     /* Version 14 */
> > +     __le32 num_clusters;
> > +     __le32 ncluster_array_offset;
> > +     __le32 num_defective_parts;
> > +     __le32 ndefective_parts_array_offset;
> > +     /* Version 15 */
> > +     __le32 nmodem_supported;
> > +     /* Version 16 */
> > +     __le32  feature_code;
> > +     __le32  pcode;
> > +     __le32  npartnamemap_offset;
> > +     __le32  nnum_partname_mapping;
> > +};
> > +
> > +#endif
>
