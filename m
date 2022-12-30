Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BD2659B09
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiL3Rpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiL3Rpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:45:47 -0500
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E49E78;
        Fri, 30 Dec 2022 09:45:45 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id p66so11455726iof.1;
        Fri, 30 Dec 2022 09:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTP1DtWjB+7nv7oA/EEYqYhJy7cQJi0Y6iPnNBwX9Ic=;
        b=G4tHhRoU8nLzdlsUqUdWGOKDRrRTHK9d6/rhIou7AB1tdu1q7xucGL7jqboByrvlWF
         7wEjsSAPXG1Ev5zv14ygVQTBMCI1KoiLajIU//hiPY6AxfPnJfryZwlPgJMs1KHIPRtq
         2ENocB1pRxjou+lXD0oosEKqs2BCbWKDYA1HWVlzMITGx4dmkajbNOgsNoRDmpLfpJI2
         YapzU6sfQ2iuGHfh67hu5DIDJyabS3iW1SZS7LzOL6AKIGno6nl+3rKf6urv8t3b397G
         X9+hl4nvP4ldyPbCRcNh0kRBE1PJYKMIlw7rx11R1B6UpikiO7Pr3BQBrm61nS9Yx8M+
         GEKQ==
X-Gm-Message-State: AFqh2kpy8HiWW+cfuiGDPUpMnsBaZF/BL8MHj6RC2ugNEdHaE1KY141O
        qwNIR/8ShvAd2fKF9xbuX7hVLEsrre+Y1hdI2mQ=
X-Google-Smtp-Source: AMrXdXv7+vNpXgfaps2GjiqW0Qs8iqSZRHzzk0jsVoislu1IZqz79DzHDTWjiLiavaOv58M02rMdfTjiGRIoBBxWM6Y=
X-Received: by 2002:a5e:cb44:0:b0:6df:b793:35ac with SMTP id
 h4-20020a5ecb44000000b006dfb79335acmr2331705iok.33.1672422344590; Fri, 30 Dec
 2022 09:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20221208232536.591347-1-stuart.w.hayes@gmail.com>
In-Reply-To: <20221208232536.591347-1-stuart.w.hayes@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 18:45:32 +0100
Message-ID: <CAJZ5v0jq_z3H5Uw7vM1998pgtUyHE0M19aOg+mf1O=UgApf7cg@mail.gmail.com>
Subject: Re: [PATCH] acpi: add support for the NBFT
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, John Meneghini <jmeneghi@redhat.com>,
        Charles Rose <charles_rose@dell.com>,
        Doug Farley <Douglas_Farley@dell.com>,
        Lenny Szubowicz <lszubowi@redhat.com>
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

On Fri, Dec 9, 2022 at 12:25 AM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>
> Add support for the NVMe Boot Firmware Table (NBFT) to facilitate
> booting from NVM Express namespaces which are accessed via
> NVMe over Fabrics (NVMe-oF).
>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Tentatively applied as 6.3 material, but it was unclear what the S-o-b
tags below mean, so I've dropped them.

If you are not the original author of the patch, you should add a From
line pointing to the original author to it and the corresponding S-o-b
tag along with your S-o-b.

If you have developed the patch in collaboration with someone, there
should be a Co-developed-by tag pointing to the other author along
with the corresponding S-o-b tag.

S-o-b alone is meaningful only if you are sending a patch from someone
else, for example as a code maintainer.

> Signed-off-by: Doug Farley <Douglas_Farley@dell.com>
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> ---
>  drivers/acpi/tables.c | 3 ++-
>  include/acpi/actbl1.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 47ec11d4c68e..f390c5883b56 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -545,7 +545,8 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
>         ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>         ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>         ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> -       ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI };
> +       ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
> +       ACPI_SIG_NBFT };
>
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 15c78678c5d3..6ec43410288a 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -49,6 +49,8 @@
>  #define ACPI_SIG_S3PT           "S3PT" /* S3 Performance (sub)Table */
>  #define ACPI_SIG_PCCS           "PCC"  /* PCC Shared Memory Region */
>
> +#define ACPI_SIG_NBFT          "NBFT"  /* NVMe Boot Firmware Table */
> +
>  /* Reserved table signatures */
>
>  #define ACPI_SIG_MATR           "MATR" /* Memory Address Translation Table */
> --
> 2.31.1
>
