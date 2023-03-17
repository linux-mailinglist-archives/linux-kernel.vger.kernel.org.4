Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1606BEA28
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCQNfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCQNfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:35:00 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A95732CF6;
        Fri, 17 Mar 2023 06:34:59 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bm1so1712493qkb.13;
        Fri, 17 Mar 2023 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679060098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wYD2tZNMuLD2tLDq6uC02rKNtsvqsc5Llw9/64tTP4=;
        b=p0jdlxrQwAq5VTw3187WfCRTXWZemohRsAg1qcIe0IOUbzfqIdYMY7uHaJRH/tXbBU
         vqqAGi7zvAPNUAWmGRICb+1muFiKVtw8TRmoRMJs6hkaBPaItAlGQr8qKtEAZXMhRHL8
         a6i20HGiUZ02DeQHZylFzTOOn7bM8bOhiHjuCxvKL3O3zxtzK4B8g4WP/9poxTxeKrn9
         /SK56qSTtIT+l+0dr0MYUcAuv1scuJYVVDQLXId2mkokaiMUimTIcJj4e33ZTGr6w6zV
         hu1Ej1gRBJpKJoe40vlm7bFAUOXCfe7FiHqFb2OBDyChlOkduEhX2LKs3rVp5qKbo3pL
         qwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679060098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wYD2tZNMuLD2tLDq6uC02rKNtsvqsc5Llw9/64tTP4=;
        b=F8KxyZNOg8sZ8GzDYh5D7TGeSNPKfvSiD5v5tR9rkSItaNl7/ibcOoAA8POIPszNeV
         0lfYpMWNtVfmNVhjpS4zUNSBvfPGQJzI8LGMNAhp44hhAhcUhSGiWHVGwwSYdZzNHITq
         a1Ab63/4JG2Bd5AD5k8o9PqiYaZulGoknVnnimIrIgT8mLlS/uPX40PR9vTTxj5bjOAJ
         Z63RjO3jTORivYuCHls3B+nbjUR/fNO6R0KH7wx9hma4udgSKJOgZH2m8znaavhCfXlY
         v0/hHRGD9Iyq8YvHnxVSMZsc0f3QdBgeHoFoUWDKoYiU271n/0ENH3U1sDfxEFColqaX
         Ah6A==
X-Gm-Message-State: AO0yUKXHpo64WGS1gSzv5HzWt4PVX15Ez561VtUmTRTLkGH5JkU+8SMH
        q01KCGDSR5bBUZgSQtoxijtsNF9OoUyC4xY16E4=
X-Google-Smtp-Source: AK7set/soQZodLw0OJK1WAvQBTaXWyS/o3WUYrJrNRFUjTe0WwIZIYA4cfwGHnQSJyxjOOMi5jNDu7y9MM0DEkT1F8c=
X-Received: by 2002:a05:620a:c81:b0:743:6092:91b4 with SMTP id
 q1-20020a05620a0c8100b00743609291b4mr7040184qki.14.1679060097764; Fri, 17 Mar
 2023 06:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230316225736.2856521-1-david.e.box@linux.intel.com>
In-Reply-To: <20230316225736.2856521-1-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Mar 2023 15:34:21 +0200
Message-ID: <CAHp75VcB9vokGSZ6ZCqyuNGfVWpn8vdTeLyHSO9MiuSoXR8tqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86/intel/pmt: Add INTEL_PMT module namespace
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

On Fri, Mar 17, 2023 at 12:57=E2=80=AFAM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Since the currently exported symbols in pmt_class are only used by other
> Intel PMT drivers, create an INTEL_PMT module namespace for them.

Makes sense.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmt/class.c     | 6 +++---
>  drivers/platform/x86/intel/pmt/crashlog.c  | 1 +
>  drivers/platform/x86/intel/pmt/telemetry.c | 1 +
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x8=
6/intel/pmt/class.c
> index 46598dcb634a..0b96d75f5924 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -33,7 +33,7 @@ bool intel_pmt_is_early_client_hw(struct device *dev)
>          */
>         return !!(ivdev->info->quirks & VSEC_QUIRK_EARLY_HW);
>  }
> -EXPORT_SYMBOL_GPL(intel_pmt_is_early_client_hw);
> +EXPORT_SYMBOL_NS_GPL(intel_pmt_is_early_client_hw, INTEL_PMT);
>
>  static inline int
>  pmt_memcpy64_fromio(void *to, const u64 __iomem *from, size_t count)
> @@ -327,7 +327,7 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entr=
y, struct intel_pmt_namespa
>         return intel_pmt_dev_register(entry, ns, dev);
>
>  }
> -EXPORT_SYMBOL_GPL(intel_pmt_dev_create);
> +EXPORT_SYMBOL_NS_GPL(intel_pmt_dev_create, INTEL_PMT);
>
>  void intel_pmt_dev_destroy(struct intel_pmt_entry *entry,
>                            struct intel_pmt_namespace *ns)
> @@ -343,7 +343,7 @@ void intel_pmt_dev_destroy(struct intel_pmt_entry *en=
try,
>         device_unregister(dev);
>         xa_erase(ns->xa, entry->devid);
>  }
> -EXPORT_SYMBOL_GPL(intel_pmt_dev_destroy);
> +EXPORT_SYMBOL_NS_GPL(intel_pmt_dev_destroy, INTEL_PMT);
>
>  static int __init pmt_class_init(void)
>  {
> diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform=
/x86/intel/pmt/crashlog.c
> index ace1239bc0a0..bbb3d61d09f4 100644
> --- a/drivers/platform/x86/intel/pmt/crashlog.c
> +++ b/drivers/platform/x86/intel/pmt/crashlog.c
> @@ -328,3 +328,4 @@ module_exit(pmt_crashlog_exit);
>  MODULE_AUTHOR("Alexander Duyck <alexander.h.duyck@linux.intel.com>");
>  MODULE_DESCRIPTION("Intel PMT Crashlog driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(INTEL_PMT);
> diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platfor=
m/x86/intel/pmt/telemetry.c
> index 5e4009c05ecf..71cdef42084a 100644
> --- a/drivers/platform/x86/intel/pmt/telemetry.c
> +++ b/drivers/platform/x86/intel/pmt/telemetry.c
> @@ -160,3 +160,4 @@ module_exit(pmt_telem_exit);
>  MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
>  MODULE_DESCRIPTION("Intel PMT Telemetry driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(INTEL_PMT);
>
> base-commit: 79df06733435e2773eb5e9ab9c0ce13c23e4cd88
> --
> 2.34.1
>


--=20
With Best Regards,
Andy Shevchenko
