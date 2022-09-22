Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F115E6B65
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiIVTDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiIVTC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:02:58 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72208F960A;
        Thu, 22 Sep 2022 12:02:55 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id f26so6971327qto.11;
        Thu, 22 Sep 2022 12:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PG7ysh4ioWP0KhhQ5IxzyuZoQeN9BWk1s+R/SHxkGzE=;
        b=cBoWxpAjBueBSr0khDJ2p1UvaWFXnN7k9pL4KZOz5xzUDmiezB9IG0V4fVg5mzjUI9
         0AI38lxxT9yEC4/kqHEH9CBnIzexSjwpZydNI4PeCoDbc/GZz0wXPNpeyGHjc4tBNbKn
         YYpgwc9XaUB5iyva0u/G6gFxNvEGGwq5YzjZNiYDQdf3LZrAm50JSdjfnEMqKhdfW3zh
         PdcDtrFbEfRE6VeMbPguokPiKswM0QQqHtPpv/WYEz5yVDo1ebBPUrFOQwN6xgb37ri8
         rUwiuT3QY4OoPurPowfJDdGlLM+Ow0E1M6NqItHK9xAqpCtLc77AZE51FeYrPlFgnRQt
         DjvA==
X-Gm-Message-State: ACrzQf1bupMkuOVcaMlMhBB9uVSFNRE9pRknewPOncsQ/o8UH2Li4umV
        JerLt6t1EvEr+uQdubpbBzxilM1UJgejdcqUGkc=
X-Google-Smtp-Source: AMsMyM7aD+iPDfles5HFP6Yp54CbcPhkeJ4ebl2AM+dn3j+3RDsEGQdLTzkbuwkDpZf9U1mnskBrCMK0ptAvKANF3iE=
X-Received: by 2002:a05:622a:11c8:b0:35c:e912:a8ea with SMTP id
 n8-20020a05622a11c800b0035ce912a8eamr4158122qtk.17.1663873374486; Thu, 22 Sep
 2022 12:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220909095624.3719051-1-liushixin2@huawei.com>
In-Reply-To: <20220909095624.3719051-1-liushixin2@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Sep 2022 21:02:43 +0200
Message-ID: <CAJZ5v0jCutvsjW8Pjhq2GdsDb+-5W=f_UWLkuA0ndrOhQApxog@mail.gmail.com>
Subject: Re: [PATCH] ACPI: HMAT: remove unused dev_fmt() and redundant
 prefixing 'HMAT'
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 11:22 AM Liu Shixin <liushixin2@huawei.com> wrote:
>
> Remove unused macro dev_pmt() and redundant prefixing 'HMAT' from pr_*() calls.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/acpi/numa/hmat.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index c3d783aca196..23f49a2f4d14 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -9,7 +9,6 @@
>   */
>
>  #define pr_fmt(fmt) "acpi/hmat: " fmt
> -#define dev_fmt(fmt) "acpi/hmat: " fmt
>
>  #include <linux/acpi.h>
>  #include <linux/bitops.h>
> @@ -302,7 +301,7 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>         u8 type, mem_hier;
>
>         if (hmat_loc->header.length < sizeof(*hmat_loc)) {
> -               pr_notice("HMAT: Unexpected locality header length: %u\n",
> +               pr_notice("Unexpected locality header length: %u\n",
>                          hmat_loc->header.length);
>                 return -EINVAL;
>         }
> @@ -314,12 +313,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
>         total_size = sizeof(*hmat_loc) + sizeof(*entries) * ipds * tpds +
>                      sizeof(*inits) * ipds + sizeof(*targs) * tpds;
>         if (hmat_loc->header.length < total_size) {
> -               pr_notice("HMAT: Unexpected locality header length:%u, minimum required:%u\n",
> +               pr_notice("Unexpected locality header length:%u, minimum required:%u\n",
>                          hmat_loc->header.length, total_size);
>                 return -EINVAL;
>         }
>
> -       pr_info("HMAT: Locality: Flags:%02x Type:%s Initiator Domains:%u Target Domains:%u Base:%lld\n",
> +       pr_info("Locality: Flags:%02x Type:%s Initiator Domains:%u Target Domains:%u Base:%lld\n",
>                 hmat_loc->flags, hmat_data_type(type), ipds, tpds,
>                 hmat_loc->entry_base_unit);
>
> @@ -363,13 +362,13 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>         u32 attrs;
>
>         if (cache->header.length < sizeof(*cache)) {
> -               pr_notice("HMAT: Unexpected cache header length: %u\n",
> +               pr_notice("Unexpected cache header length: %u\n",
>                          cache->header.length);
>                 return -EINVAL;
>         }
>
>         attrs = cache->cache_attributes;
> -       pr_info("HMAT: Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
> +       pr_info("Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
>                 cache->memory_PD, cache->cache_size, attrs,
>                 cache->number_of_SMBIOShandles);
>
> @@ -424,24 +423,24 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>         struct memory_target *target = NULL;
>
>         if (p->header.length != sizeof(*p)) {
> -               pr_notice("HMAT: Unexpected address range header length: %u\n",
> +               pr_notice("Unexpected address range header length: %u\n",
>                          p->header.length);
>                 return -EINVAL;
>         }
>
>         if (hmat_revision == 1)
> -               pr_info("HMAT: Memory (%#llx length %#llx) Flags:%04x Processor Domain:%u Memory Domain:%u\n",
> +               pr_info("Memory (%#llx length %#llx) Flags:%04x Processor Domain:%u Memory Domain:%u\n",
>                         p->reserved3, p->reserved4, p->flags, p->processor_PD,
>                         p->memory_PD);
>         else
> -               pr_info("HMAT: Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
> +               pr_info("Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
>                         p->flags, p->processor_PD, p->memory_PD);
>
>         if ((hmat_revision == 1 && p->flags & ACPI_HMAT_MEMORY_PD_VALID) ||
>             hmat_revision > 1) {
>                 target = find_mem_target(p->memory_PD);
>                 if (!target) {
> -                       pr_debug("HMAT: Memory Domain missing from SRAT\n");
> +                       pr_debug("Memory Domain missing from SRAT\n");
>                         return -EINVAL;
>                 }
>         }
> @@ -449,7 +448,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>                 int p_node = pxm_to_node(p->processor_PD);
>
>                 if (p_node == NUMA_NO_NODE) {
> -                       pr_debug("HMAT: Invalid Processor Domain\n");
> +                       pr_debug("Invalid Processor Domain\n");
>                         return -EINVAL;
>                 }
>                 target->processor_pxm = p->processor_PD;
> @@ -840,7 +839,7 @@ static __init int hmat_init(void)
>         case 2:
>                 break;
>         default:
> -               pr_notice("Ignoring HMAT: Unknown revision:%d\n", hmat_revision);
> +               pr_notice("Ignoring: Unknown revision:%d\n", hmat_revision);
>                 goto out_put;
>         }
>
> @@ -848,7 +847,7 @@ static __init int hmat_init(void)
>                 if (acpi_table_parse_entries(ACPI_SIG_HMAT,
>                                              sizeof(struct acpi_table_hmat), i,
>                                              hmat_parse_subtable, 0) < 0) {
> -                       pr_notice("Ignoring HMAT: Invalid table");
> +                       pr_notice("Ignoring: Invalid table");
>                         goto out_put;
>                 }
>         }
> --

Applied as 6.1 material with edited subject and changelog.

Thanks!
