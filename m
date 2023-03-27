Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42266CADEF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjC0Svw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 14:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC0Svt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:51:49 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068B51707;
        Mon, 27 Mar 2023 11:51:48 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id x3so40144297edb.10;
        Mon, 27 Mar 2023 11:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679943106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uE+9ZOR2j/FZ936bGtTDw11+RMWw1Oi8CwEW7umiE8Q=;
        b=L6cbJlZz1syCKQFCmFDUvMnF3wXY56zFogRBQAUEoNEspGuRTuv7XMcQZBYRc1M65x
         TNM0AgVlzsqP7MQqOGC6XtgNj3e2myUeLFvIEQR6PQ65Vtjssy3yTZe3inOuETOaaqNz
         hvmYQ+T7L9Ui+xcL5RHxSZfVzADDRuychWH+59F7vzXy1nQBPJyl7C9XJ5B0okqvVbN9
         oxnqQYvJnTwdJxVPnKu7Il8zprI6MrpP1BHo5bO6lZerOsxm6Bz45yr+6DMY/+BmLz6R
         LhdN6u17YRKaFS4zTMQzdmYRnBTUXrZ+9z/LUzC3IWMKzB23ENYZSJgmBgeAqHlOmJrF
         R/Hw==
X-Gm-Message-State: AAQBX9dGFVpcjp0GA/1UpvYNZWtSceTUdcd1F4qq4J9wqtl8E5uhr0Ls
        S2YJ+nj3o3U4G3BYxYsc4XCzogKS9cQseTPKFr4=
X-Google-Smtp-Source: AKy350ZUlloaX3dWICxSiEFOyrs7y49xa/QmDZ4ZJN3MWin7AVjDu+FE3DTv4QLWkr4y7YBmXEpYnGwf/eJGwStee38=
X-Received: by 2002:a50:d54f:0:b0:502:4f7:d287 with SMTP id
 f15-20020a50d54f000000b0050204f7d287mr6288839edj.3.1679943106386; Mon, 27 Mar
 2023 11:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230327132512.84540-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230327132512.84540-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 20:51:35 +0200
Message-ID: <CAJZ5v0gpmGyzpEcbgZ=Y76+rwL47nY4A_Kh0Sd5iQPPH4wgpKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: SPCR: Amend indentation
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

On Mon, Mar 27, 2023 at 3:25 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> 1) Remove unnecessary blank lines.
> 2) Reformat one comment for consistency.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: avoided changind double spaces (Rafael)
>  drivers/acpi/spcr.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 01d29ebdb9c2..cd36a97b0ea2 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -71,7 +71,6 @@ static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
>
>  /**
>   * acpi_parse_spcr() - parse ACPI SPCR table and add preferred console
> - *
>   * @enable_earlycon: set up earlycon for the console specified by the table
>   * @enable_console: setup the console specified by the table.
>   *
> @@ -82,7 +81,6 @@ static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
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

Applied as 6.4 material, thanks!
