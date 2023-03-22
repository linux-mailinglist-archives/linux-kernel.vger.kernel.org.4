Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9066C541F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjCVSvW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Mar 2023 14:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjCVSvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:51:14 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4904D66D15;
        Wed, 22 Mar 2023 11:51:11 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id r11so76969456edd.5;
        Wed, 22 Mar 2023 11:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679511069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYKTAnSN7pbus8iof2Mz7rGDiYWbcSTkY7UHD5fskOc=;
        b=J7Heyw3rpxLPfKLnDR3ESnEvOEvWhf24Yy/1dsCrIkNbQIaNABovxgqw915hR3crEL
         Pe77jYhfUQbOrY7ahPfwt82N67naHZ16IGJfbTIWbgFBSg9XCsQVqJchnQ6Nup/N2PTc
         Jd6IN075+rLNB6Mowjrvi97DsMtiNnNX+rjl90fYLfyzDM68RWtvdCvEJhoPEVyP3oSL
         3s8oj8hWYCMySkeKmyy2Dlfe5jrLSDsmoDCaBZTFHOhu0naA+KqMTL92tKvhYbxn7YpO
         oLduEowZs/HI8LZgR0aatnfkZkz2x1JtUDJZ/Of3p0asYPge7kHchzKw7FXosyH9Jinz
         YlQQ==
X-Gm-Message-State: AO0yUKXSHu5iJwgVoqvSZJfPXtJMsFyLQwW2HvOzLZneFAZhElO+dxTM
        9gzuoA3fid2jyAqZ/gyhUscKAxJvBkoHFKVViJI=
X-Google-Smtp-Source: AK7set+9k2U6FEIVVkuQ7Lw+N/Q498NWJrjsFs1IJF0Gg7Ix5G7cy5vtrIU/fJU4L7kxpk9Mk5ZdyjlRkOZ6txwX/Fg=
X-Received: by 2002:a50:9995:0:b0:4fa:3c0b:74b with SMTP id
 m21-20020a509995000000b004fa3c0b074bmr4088147edb.3.1679511069277; Wed, 22 Mar
 2023 11:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230322102258.27390-1-andriy.shevchenko@linux.intel.com> <20230322102258.27390-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230322102258.27390-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Mar 2023 19:50:55 +0100
Message-ID: <CAJZ5v0imGNb8pETxdJmjJ9cSJQedeb=w2dcG6huDB=SpL-ufqA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ACPI: SPCR: Amend indentation
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 11:26 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> 1) Remove unnecessary blank lines.
> 2) Remove double spaces for consistency.

I don't quite agree with this.

Double spaces after a period are recognized as end-of-sentence markers
by some editors (notably vi), so if they have been used intentionally,
I see no reason to replace them.

> 3) Reformat one comment for consistency.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/spcr.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 01d29ebdb9c2..3d242c746d10 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -71,18 +71,16 @@ static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
>
>  /**
>   * acpi_parse_spcr() - parse ACPI SPCR table and add preferred console
> - *
>   * @enable_earlycon: set up earlycon for the console specified by the table
>   * @enable_console: setup the console specified by the table.
>   *
>   * For the architectures with support for ACPI, CONFIG_ACPI_SPCR_TABLE may be
> - * defined to parse ACPI SPCR table.  As a result of the parsing preferred
> + * defined to parse ACPI SPCR table. As a result of the parsing preferred
>   * console is registered and if @enable_earlycon is true, earlycon is set up.
>   * If @enable_console is true the system console is also configured.
>   *
>   * When CONFIG_ACPI_SPCR_TABLE is defined, this function should be called
>   * from arch initialization code as soon as the DT/ACPI decision is made.
> - *
>   */
>  int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>  {
> @@ -97,9 +95,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>         if (acpi_disabled)
>                 return -ENODEV;
>
> -       status = acpi_get_table(ACPI_SIG_SPCR, 0,
> -                               (struct acpi_table_header **)&table);
> -
> +       status = acpi_get_table(ACPI_SIG_SPCR, 0, (struct acpi_table_header **)&table);
>         if (ACPI_FAILURE(status))
>                 return -ENOENT;
>
> @@ -184,10 +180,10 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>          *
>          * If the user specifies "traditional" earlycon, the qdf2400_e44
>          * console name matches the EARLYCON_DECLARE() statement, and
> -        * SPCR is not used.  Parameter "earlycon" is false.
> +        * SPCR is not used. Parameter "earlycon" is false.
>          *
>          * If the user specifies "SPCR" earlycon, then we need to update
> -        * the console name so that it also says "qdf2400_e44".  Parameter
> +        * the console name so that it also says "qdf2400_e44". Parameter
>          * "earlycon" is true.
>          *
>          * For consistency, if we change the console name, then we do it
> @@ -202,7 +198,8 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>         if (xgene_8250_erratum_present(table)) {
>                 iotype = "mmio32";
>
> -               /* for xgene v1 and v2 we don't know the clock rate of the
> +               /*
> +                * For xgene v1 and v2 we don't know the clock rate of the
>                  * UART so don't attempt to change to the baud rate state
>                  * in the table because driver cannot calculate the dividers
>                  */
> --
> 2.40.0.1.gaa8946217a0b
>
