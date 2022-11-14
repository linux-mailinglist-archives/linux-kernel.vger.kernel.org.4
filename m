Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094BC6283E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiKNPam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbiKNPaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:30:39 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB0D14D17;
        Mon, 14 Nov 2022 07:30:38 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id k2so7585028qkk.7;
        Mon, 14 Nov 2022 07:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h99OlI5BbKbsPyp3lQEwfF/aB86+nXeBTZxW/Q0PKWg=;
        b=SsO8ug6Rvjx5h0LpBBfnCwqbFrPpL5+BGjGPrrpVv8pKxXoZvkTTh9JiUgzLgA6GtW
         3hpaPVg0H7OcHIrsbpyAR1lM+7lluZArfdJBWBkzVttcPd8G7yXuvY3czVRmNrzWmhrU
         G+BhLWF+HJ23t1ETWZNQ8iNwtuKjnVekiJhpNax9R2OohWgoY9gMjF6t863iEvQE+W8M
         NxnDOgKqujuYr97Z9t8UYILrEHv5+EGnlcbdk9IvCNy+kEXZXgq9HU6vpT5coGHtgoba
         drASF487i7ALSZdcihiLTQjs/STyZ7CAhqU0x0Z0h5oj34imH2BB4btEpJxSVd7TTLp2
         jv8Q==
X-Gm-Message-State: ANoB5plsba5C0bGx2qL99GvsOiufXyTm/8sGLvrLjk1IR3DPu2gkZw30
        w4UK8AHoGUEVKJ/mU+ajkYVXqcHG6agEMnyG5Mc=
X-Google-Smtp-Source: AA0mqf7/MXQ7rX7nNJyNfnme/xAECA9tjCnRtwu5640fhPYM+RESqqf6mBtZy+ln2slbv0ACukYwvkSrHET711EC5XU=
X-Received: by 2002:a37:638f:0:b0:6ec:fa04:d97c with SMTP id
 x137-20020a37638f000000b006ecfa04d97cmr11105446qkb.764.1668439837750; Mon, 14
 Nov 2022 07:30:37 -0800 (PST)
MIME-Version: 1.0
References: <3701ca18.12f.1847065cd7e.Coremail.wangkailong@jari.cn>
In-Reply-To: <3701ca18.12f.1847065cd7e.Coremail.wangkailong@jari.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Nov 2022 16:30:20 +0100
Message-ID: <CAJZ5v0i7oQK4t8ua6sSbbRGEZfStzosT8+JfcAYL5WJEgNVceA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix array_size.cocci warning
To:     wangkailong@jari.cn
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 10:55 AM <wangkailong@jari.cn> wrote:
>
> Fix following coccicheck warning:
>
> drivers/acpi/acpica/tbfadt.c:107:27-28: WARNING: Use ARRAY_SIZE
> drivers/acpi/acpica/tbfadt.c:137:30-31: WARNING: Use ARRAY_SIZE
>
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>

Please submit ACPICA changes to the upstream project on GitHub.

If they are not applicable there, they are also not applicable to the
Linux kernel.

> ---
>  drivers/acpi/acpica/tbfadt.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
> index 31d7ea84a360..637fcd74f30e 100644
> --- a/drivers/acpi/acpica/tbfadt.c
> +++ b/drivers/acpi/acpica/tbfadt.c
> @@ -103,9 +103,7 @@ static struct acpi_fadt_info fadt_info_table[] = {
>          ACPI_FADT_SEPARATE_LENGTH | ACPI_FADT_GPE_REGISTER}
>  };
>
> -#define ACPI_FADT_INFO_ENTRIES \
> -                       (sizeof (fadt_info_table) / sizeof (struct acpi_fadt_info))
> -
> +#define ACPI_FADT_INFO_ENTRIES (ARRAY_SIZE(fadt_info_table))
>  /* Table used to split Event Blocks into separate status/enable registers */
>
>  typedef struct acpi_fadt_pm_info {
> @@ -133,9 +131,7 @@ static struct acpi_fadt_pm_info fadt_pm_info_table[] = {
>          1}
>  };
>
> -#define ACPI_FADT_PM_INFO_ENTRIES \
> -                       (sizeof (fadt_pm_info_table) / sizeof (struct acpi_fadt_pm_info))
> -
> +#define ACPI_FADT_PM_INFO_ENTRIES (ARRAY_SIZE(fadt_pm_info_table))
>  /*******************************************************************************
>   *
>   * FUNCTION:    acpi_tb_init_generic_address
> --
> 2.25.1
