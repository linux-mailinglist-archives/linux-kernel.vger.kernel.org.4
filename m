Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBCB69674F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjBNOtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjBNOs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:48:58 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F36E72A0;
        Tue, 14 Feb 2023 06:48:57 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id jg8so40721396ejc.6;
        Tue, 14 Feb 2023 06:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dO9zQQMF7TMrx+/BjRM6rVVVA5NoHbBHzsXtZkm9yy4=;
        b=OSGlNb+h0+nVYhvdM0Vu1lMHlReRtnSZwGibjvpDQJYa6mNn0slByHllx1RwhyeQFU
         iGXPuBgFwbA7qj+GUHhTyNkedbrntfJRPrXpWn+aBJownzqHJfc6YKYtWtKfsQD7d5tm
         ITZkTWUegoNpd91p8tQEWnajAc8YIE3jxf3OMm9g8nixjISYON44s8UIs3gR+OtXuTnX
         gs5h70zGe6GrHE8UW/XQ2tJKBE5UXcRSj0axMtlQHxK6k+y5lpxoIvt7k64xiIR7J+8f
         A/GQGJ1Xt+ySRQNFHGlpZiz9ILIWTnqfxNX6bBRewYrO7i31UYvc7qhHPwBYp/QoIpXq
         FIhQ==
X-Gm-Message-State: AO0yUKVaqx1Y520UVcHpoc1yqLNXUGYJW12pc1PxD9NSGB536gICmycz
        QYwXqcF7Dec7MgTJhguU+yGBgBCGfe2A3rF26xE=
X-Google-Smtp-Source: AK7set92OL3G8YnrRMKsCXin+A4QvxdoGU7T0cUEjR5WoCpPkZ1BCDK1WZNm/rg+4Uf/k3SHFHNQFN205jo6C8vMSnw=
X-Received: by 2002:a17:907:10cf:b0:888:6294:a1fd with SMTP id
 rv15-20020a17090710cf00b008886294a1fdmr1430066ejb.2.1676386135992; Tue, 14
 Feb 2023 06:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20230213213537.6121-1-mario.limonciello@amd.com> <20230213213537.6121-2-mario.limonciello@amd.com>
In-Reply-To: <20230213213537.6121-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Feb 2023 15:48:44 +0100
Message-ID: <CAJZ5v0j0GYyrF33=7ginfhYMrNyD=EDUK0RuHHYkKJ2VZAQnsQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: x86: Add more systems to quirk list for forcing StorageD3Enable
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, dbilios@stdio.gr,
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

On Mon, Feb 13, 2023 at 10:35 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 018d6711c26e4 ("ACPI: x86: Add a quirk for Dell Inspiron 14 2-in-1
> for StorageD3Enable") introduced a quirk to allow a system with ambiguous
> use of _ADR 0 to force StorageD3Enable.
>
> It is reported that Vostro 5626 suffers same symptoms. Add this other
> system to the list as well.
>
> Suggested-by: dbilios@stdio.gr
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217003
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Can you please combine these two patches into one?

Or at least make the subjects differ?

> ---
>  drivers/acpi/x86/utils.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 3409ce6513afa..b1d24718f73d7 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -214,6 +214,7 @@ static const struct dmi_system_id force_storage_d3_dmi[] = {
>                  * but .NVME is needed to get StorageD3Enable node
>                  * https://bugzilla.kernel.org/show_bug.cgi?id=216440
>                  * https://bugzilla.kernel.org/show_bug.cgi?id=216773
> +                * https://bugzilla.kernel.org/show_bug.cgi?id=217003
>                  */
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> @@ -232,6 +233,12 @@ static const struct dmi_system_id force_storage_d3_dmi[] = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 16 5625"),
>                 }
>         },
> +       {
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 5625"),
> +               }
> +       },
>         {}
>  };
>
> --
> 2.34.1
>
