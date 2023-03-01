Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968956A7368
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCAS0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCAS0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:26:20 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1474348E09;
        Wed,  1 Mar 2023 10:26:19 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id eg37so57466575edb.12;
        Wed, 01 Mar 2023 10:26:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677695177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTcW5bVcScAMnNN3gSgz/zKQl+YyNYPA26DBVP6pHao=;
        b=NPRGSCEBEEv4QUrhwCftyZ7zDg3oy5ZGLeez0P3MB4zc5828ZjI4ZgvkYVP3F/YxIO
         UcJEwu6M5McmgZcdEOH3QDX+nd53vkDZ72/01flGm75SOa2QKUpq84CRpsap++lnV+jv
         hlrkkDAbARPs3WRQ7VOqqdM/cVJ133KkmlGs4RGRwSSR2f11GYMyYfAMcbkP2rr1SQUx
         NyMPVjlYcuOpMIJDu7kr9i7cBxMH+AREQP52Soer4DUd0YGzBxk/UIFXbtnzRaMPvyql
         M2ZSHd1OHulI2M0neYf9gKHjX8iJrJAlCXHoM9/+15h5QE0T6K2fwqOrV86O0z2PT897
         USKA==
X-Gm-Message-State: AO0yUKWSuMg5OxCTgGNlzoleOHOZBkIWe+7h2NxNveH9SZqrZTLbyT32
        ZVrwFRV+zKCHfv6OEcUE2s9BJ9dXy+h4hvUpzzU=
X-Google-Smtp-Source: AK7set/jqSgBFNlOmGDZrVLgyHFa9PcGuta3832R9dQaL2fjCFqTGxdXtS8sYPkVwsdo4FgcljnMkabF8JSJ0p/Ch7A=
X-Received: by 2002:a50:cc93:0:b0:4ad:7482:cd3b with SMTP id
 q19-20020a50cc93000000b004ad7482cd3bmr4350660edi.6.1677695177481; Wed, 01 Mar
 2023 10:26:17 -0800 (PST)
MIME-Version: 1.0
References: <20230228221128.2560-1-mario.limonciello@amd.com>
In-Reply-To: <20230228221128.2560-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Mar 2023 19:26:06 +0100
Message-ID: <CAJZ5v0hkOv6RWHtCc9v+uAU2wMUV+h5xYv8NE2zMGC1yH9hZtA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: x86: Add Cezanne to the list for forcing StorageD3Enable
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        David Alvarez Lombardi <dqalombardi@proton.me>,
        dbilios@stdio.gr, Elvis Angelaccio <elvis.angelaccio@kde.org>,
        victor.bonnelle@proton.me, hurricanepootis@protonmail.com,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 11:11 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 018d6711c26e4 ("ACPI: x86: Add a quirk for Dell Inspiron 14 2-in-1
> for StorageD3Enable") introduced a quirk to allow a system with ambiguous
> use of _ADR 0 to force StorageD3Enable.
>
> It was reported that several more Dell systems suffered the same symptoms.
> As the list is continuing to grow but these are all Cezanne systems,
> instead add Cezanne to the CPU list to apply the StorageD3Enable property
> and remove the whole list.
>
> It was also reported that an HP system only has StorageD3Enable on the ACPI
> device for the first NVME disk, not the second.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217003
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216773
> Reported-by: David Alvarez Lombardi <dqalombardi@proton.me>
> Reported-by: dbilios@stdio.gr
> Reported-and-tested-by: Elvis Angelaccio <elvis.angelaccio@kde.org>
> Tested-by: victor.bonnelle@proton.me
> Tested-by: hurricanepootis@protonmail.com
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Switch to using CPU rather than an ever growing list
>
>  drivers/acpi/x86/utils.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index d7d3f1669d4c..788b29ed9fb3 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -200,39 +200,28 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
>   * a hardcoded allowlist for D3 support, which was used for these platforms.
>   *
>   * This allows quirking on Linux in a similar fashion.
> + *
> + * Cezanne systems shouldn't *normally* need this as the BIOS includes
> + * StorageD3Enable.  But for two reasons we have added it.
> + * 1) The BIOS on a number of Dell systems have ambiguity
> + *    between the same value used for _ADR on ACPI nodes GPP1.DEV0 and GPP1.NVME.
> + *    GPP1.NVME is needed to get StorageD3Enable node set properly.
> + *    https://bugzilla.kernel.org/show_bug.cgi?id=216440
> + *    https://bugzilla.kernel.org/show_bug.cgi?id=216773
> + *    https://bugzilla.kernel.org/show_bug.cgi?id=217003
> + * 2) On at least one HP system StorageD3Enable is missing on the second NVME
> +      disk in the system.
>   */
>  static const struct x86_cpu_id storage_d3_cpu_ids[] = {
>         X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),  /* Renoir */
>         X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL), /* Lucienne */
> -       {}
> -};
> -
> -static const struct dmi_system_id force_storage_d3_dmi[] = {
> -       {
> -               /*
> -                * _ADR is ambiguous between GPP1.DEV0 and GPP1.NVME
> -                * but .NVME is needed to get StorageD3Enable node
> -                * https://bugzilla.kernel.org/show_bug.cgi?id=216440
> -                */
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -                       DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 14 7425 2-in-1"),
> -               }
> -       },
> -       {
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -                       DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 16 5625"),
> -               }
> -       },
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),  /* Cezanne */
>         {}
>  };
>
>  bool force_storage_d3(void)
>  {
> -       const struct dmi_system_id *dmi_id = dmi_first_match(force_storage_d3_dmi);
> -
> -       return dmi_id || x86_match_cpu(storage_d3_cpu_ids);
> +       return x86_match_cpu(storage_d3_cpu_ids);
>  }
>
>  /*
> --

Applied as 6.3-rc material, thanks!
