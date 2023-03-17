Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979E46BE9C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCQM7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjCQM7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:59:19 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DEBA8C44;
        Fri, 17 Mar 2023 05:59:17 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c18so5401644qte.5;
        Fri, 17 Mar 2023 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679057957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0jJi3/3o5+UsDeZckrwCaYcdVgtZCA0iNilQ+fn514=;
        b=LIN5kQaQ7jfR84kB+aIvJZ1W7ae1fi++RILUxrS50tq8LmcCyzu+WCkZgtC5GXyrdp
         qkN21szKv06UpkcJ6p0ynBQuAOaQOFgjJP8tE9wLIpSs9/XYCrvFmX/1EF0vaYT7PI53
         SpMt6JVbNqVILMT8/9AvQ9JF9A7sqeqEwv+JiR1vUcdnYGvjPiz29O94wa8CBIYIi14N
         D37NrPmQz6o8RTYqL+EhDWIDks9mBXaplPbIo57GA3YKer5IyFwwkwJy+DTPxZq4hw2m
         Zoksdp7Lk5sLoApLJW80svzKBPTbhcY79SCjnftnukcEMvhzykWxfNyfty7/533VgZxc
         NbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679057957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0jJi3/3o5+UsDeZckrwCaYcdVgtZCA0iNilQ+fn514=;
        b=WDN+VUQ9fnt+S22gjwN7XPjV06ADJ/zTyn1prFVAyzFRpeN2b74z4wIyeUYtoSYDvb
         e9xz4TNRgQ1QKUYdEGpMz6/LYvtgfD2EJpcKMHuwKOYYdT09+LABXWNNyOYd4+mW7RFU
         dKZ4YBlWRz7aYN5E65jEqT0x4nwmNyVuUuLoFxyN7zfsm6cX6RaKyzNT3YMAqpqejHbj
         YrZBjjnshV128c2m3JIgT7ZrQxCNdeU9I5q0pNMeO/bYJjrHmoHRZTuknWrczVNDsz7p
         t1PwNR2UgTXXeZ9y9MSqINXoDYal08969ZGxCCo5MiTc7H7qda2htRfLUjeVDdJjzKWr
         gq5Q==
X-Gm-Message-State: AO0yUKUE8rd8OtlljInIKn6qUOcsF7pbIDUrJwkF0gy/flrbLWBvXKgG
        TEYxKDjEO8oKH29TXV7rGNJON4G4RyxNBVCe8Tg=
X-Google-Smtp-Source: AK7set+EkdNXyvthPFb5i9ewk7OjGcJq5Fxx9JBuvOBWZ3MZlR6jIfvzD9YFggkYo5xWTeKPYKy5FaZhb+4Wno7Q2mg=
X-Received: by 2002:ac8:4142:0:b0:3bf:fe82:7525 with SMTP id
 e2-20020ac84142000000b003bffe827525mr2090235qtm.0.1679057956816; Fri, 17 Mar
 2023 05:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230316224628.2855884-1-david.e.box@linux.intel.com>
In-Reply-To: <20230316224628.2855884-1-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Mar 2023 14:58:40 +0200
Message-ID: <CAHp75Vd6ee_uqPLHiOa8DX4huf7bB0CmWf4yRPN=0TQw_5JvgA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86/intel/vsec: Explicitly enable capabilities
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
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

On Fri, Mar 17, 2023 at 12:46=E2=80=AFAM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Discovered Intel VSEC/DVSEC capabilities are enabled by default and only
> get disabled by quirk. Instead, remove such quirks and only enable suppor=
t
> for capabilities that have been explicitly added to a new capabilities
> field. While here, also reorder the device info structures alphabetically=
.

This looks better indeed.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/vsec.c | 69 ++++++++++++++-----------------
>  drivers/platform/x86/intel/vsec.h |  9 +++-
>  2 files changed, 38 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/int=
el/vsec.c
> index 13decf36c6de..01b1f6480e5c 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -67,14 +67,6 @@ enum intel_vsec_id {
>         VSEC_ID_TPMI            =3D 66,
>  };
>
> -static enum intel_vsec_id intel_vsec_allow_list[] =3D {
> -       VSEC_ID_TELEMETRY,
> -       VSEC_ID_WATCHER,
> -       VSEC_ID_CRASHLOG,
> -       VSEC_ID_SDSI,
> -       VSEC_ID_TPMI,
> -};
> -
>  static const char *intel_vsec_name(enum intel_vsec_id id)
>  {
>         switch (id) {
> @@ -98,26 +90,19 @@ static const char *intel_vsec_name(enum intel_vsec_id=
 id)
>         }
>  }
>
> -static bool intel_vsec_allowed(u16 id)
> -{
> -       int i;
> -
> -       for (i =3D 0; i < ARRAY_SIZE(intel_vsec_allow_list); i++)
> -               if (intel_vsec_allow_list[i] =3D=3D id)
> -                       return true;
> -
> -       return false;
> -}
> -
> -static bool intel_vsec_disabled(u16 id, unsigned long quirks)
> +static bool intel_vsec_supported(u16 id, unsigned long caps)
>  {
>         switch (id) {
> +       case VSEC_ID_TELEMETRY:
> +               return !!(caps & VSEC_CAP_TELEMETRY);
>         case VSEC_ID_WATCHER:
> -               return !!(quirks & VSEC_QUIRK_NO_WATCHER);
> -
> +               return !!(caps & VSEC_CAP_WATCHER);
>         case VSEC_ID_CRASHLOG:
> -               return !!(quirks & VSEC_QUIRK_NO_CRASHLOG);
> -
> +               return !!(caps & VSEC_CAP_CRASHLOG);
> +       case VSEC_ID_SDSI:
> +               return !!(caps & VSEC_CAP_SDSI);
> +       case VSEC_ID_TPMI:
> +               return !!(caps & VSEC_CAP_TPMI);
>         default:
>                 return false;
>         }
> @@ -205,7 +190,7 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, s=
truct intel_vsec_header *he
>         unsigned long quirks =3D info->quirks;
>         int i;
>
> -       if (!intel_vsec_allowed(header->id) || intel_vsec_disabled(header=
->id, quirks))
> +       if (!intel_vsec_supported(header->id, info->caps))
>                 return -EINVAL;
>
>         if (!header->num_entries) {
> @@ -260,14 +245,14 @@ static int intel_vsec_add_dev(struct pci_dev *pdev,=
 struct intel_vsec_header *he
>  static bool intel_vsec_walk_header(struct pci_dev *pdev,
>                                    struct intel_vsec_platform_info *info)
>  {
> -       struct intel_vsec_header **header =3D info->capabilities;
> +       struct intel_vsec_header **header =3D info->headers;
>         bool have_devices =3D false;
>         int ret;
>
>         for ( ; *header; header++) {
>                 ret =3D intel_vsec_add_dev(pdev, *header, info);
>                 if (ret)
> -                       dev_info(&pdev->dev, "Could not add device for DV=
SEC id %d\n",
> +                       dev_info(&pdev->dev, "Could not add device for VS=
EC id %d\n",
>                                  (*header)->id);
>                 else
>                         have_devices =3D true;
> @@ -402,14 +387,8 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev=
, const struct pci_device_id
>         return 0;
>  }
>
> -/* TGL info */
> -static const struct intel_vsec_platform_info tgl_info =3D {
> -       .quirks =3D VSEC_QUIRK_NO_WATCHER | VSEC_QUIRK_NO_CRASHLOG |
> -                 VSEC_QUIRK_TABLE_SHIFT | VSEC_QUIRK_EARLY_HW,
> -};
> -
>  /* DG1 info */
> -static struct intel_vsec_header dg1_telemetry =3D {
> +static struct intel_vsec_header dg1_header =3D {
>         .length =3D 0x10,
>         .id =3D 2,
>         .num_entries =3D 1,
> @@ -418,19 +397,31 @@ static struct intel_vsec_header dg1_telemetry =3D {
>         .offset =3D 0x466000,
>  };
>
> -static struct intel_vsec_header *dg1_capabilities[] =3D {
> -       &dg1_telemetry,
> +static struct intel_vsec_header *dg1_headers[] =3D {
> +       &dg1_header,
>         NULL
>  };
>
>  static const struct intel_vsec_platform_info dg1_info =3D {
> -       .capabilities =3D dg1_capabilities,
> +       .caps =3D VSEC_CAP_TELEMETRY,
> +       .headers =3D dg1_headers,
>         .quirks =3D VSEC_QUIRK_NO_DVSEC | VSEC_QUIRK_EARLY_HW,
>  };
>
>  /* MTL info */
>  static const struct intel_vsec_platform_info mtl_info =3D {
> -       .quirks =3D VSEC_QUIRK_NO_WATCHER | VSEC_QUIRK_NO_CRASHLOG,
> +       .caps =3D VSEC_CAP_TELEMETRY,
> +};
> +
> +/* OOBMSM info */
> +static const struct intel_vsec_platform_info oobmsm_info =3D {
> +       .caps =3D VSEC_CAP_TELEMETRY | VSEC_CAP_SDSI | VSEC_CAP_TPMI,
> +};
> +
> +/* TGL info */
> +static const struct intel_vsec_platform_info tgl_info =3D {
> +       .caps =3D VSEC_CAP_TELEMETRY,
> +       .quirks =3D VSEC_QUIRK_TABLE_SHIFT | VSEC_QUIRK_EARLY_HW,
>  };
>
>  #define PCI_DEVICE_ID_INTEL_VSEC_ADL           0x467d
> @@ -445,7 +436,7 @@ static const struct pci_device_id intel_vsec_pci_ids[=
] =3D {
>         { PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
>         { PCI_DEVICE_DATA(INTEL, VSEC_MTL_M, &mtl_info) },
>         { PCI_DEVICE_DATA(INTEL, VSEC_MTL_S, &mtl_info) },
> -       { PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &(struct intel_vsec_platfor=
m_info) {}) },
> +       { PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &oobmsm_info) },
>         { PCI_DEVICE_DATA(INTEL, VSEC_RPL, &tgl_info) },
>         { PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
>         { }
> diff --git a/drivers/platform/x86/intel/vsec.h b/drivers/platform/x86/int=
el/vsec.h
> index ae8fe92c5595..0fd042c171ba 100644
> --- a/drivers/platform/x86/intel/vsec.h
> +++ b/drivers/platform/x86/intel/vsec.h
> @@ -5,6 +5,12 @@
>  #include <linux/auxiliary_bus.h>
>  #include <linux/bits.h>
>
> +#define VSEC_CAP_TELEMETRY     BIT(0)
> +#define VSEC_CAP_WATCHER       BIT(1)
> +#define VSEC_CAP_CRASHLOG      BIT(2)
> +#define VSEC_CAP_SDSI          BIT(3)
> +#define VSEC_CAP_TPMI          BIT(4)
> +
>  struct pci_dev;
>  struct resource;
>
> @@ -27,7 +33,8 @@ enum intel_vsec_quirks {
>
>  /* Platform specific data */
>  struct intel_vsec_platform_info {
> -       struct intel_vsec_header **capabilities;
> +       struct intel_vsec_header **headers;
> +       unsigned long caps;
>         unsigned long quirks;
>  };
>
>
> base-commit: 02c464b73645404654359ad21f368a13735e2850
> --
> 2.34.1
>


--=20
With Best Regards,
Andy Shevchenko
