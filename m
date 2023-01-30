Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9FD681596
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjA3PwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjA3PwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:52:18 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFF9172F;
        Mon, 30 Jan 2023 07:52:14 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id m2so32559927ejb.8;
        Mon, 30 Jan 2023 07:52:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBwjnk18irD2gYHr6RSTL8oiNSvKOVuusoOh34SmgAc=;
        b=AML9uhFgfI79wmX3x8KTAa12hHOwjoEdaX6VimHtsLVtAwAZATN0X7WlxFdtnOKB1H
         ldcahFJT/pH4nGIg1OyJA9Ju6vhuxSaqPVf/zNsxF1Miu3s3gozIEYDOtxR3t5D15GAN
         fsrGCkmCFvudhK+UeRGiXOAWxWDIcaPHqsNaGrhsEL5jGFQAYFMjjKCpM3JizF+S+jSp
         lCw2bIol0AWruSxRFE0uz1kOK9bv6elF20GSHwLgctckSrZDZp7fF2KmueMi/kKHa8LM
         GB4aLs0TKgYYivvMtgOffJFdyH55Jy49c6aco07atp/GETAOMVcpXhkNes+ydRAvqTDu
         FdSQ==
X-Gm-Message-State: AFqh2krfP8lVWGOV+VNzPxqaE/9luNiqXAypwwbS0bmngJ7RDk4wi3e9
        5TeS5lQMIOf02LT42Nza3UqvCiSqS3qYs2QmwRTmuR6a
X-Google-Smtp-Source: AMrXdXu6GDWZV9lCohQER6b63rBHweFDQKwZc7orpDimzIW5qgv0HClbhF+U2d3rjBCDP6Kc6K74BeEWyW1QM/Y9yJA=
X-Received: by 2002:a17:906:70d2:b0:844:44e0:1c4e with SMTP id
 g18-20020a17090670d200b0084444e01c4emr8712988ejk.291.1675093933118; Mon, 30
 Jan 2023 07:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20230127064005.1558-1-rdunlap@infradead.org> <20230127064005.1558-10-rdunlap@infradead.org>
In-Reply-To: <20230127064005.1558-10-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Jan 2023 16:52:01 +0100
Message-ID: <CAJZ5v0h9_P7wke=KC2=nsLFmQmjh_0Fxao6WeKKnbOSdU_v-NQ@mail.gmail.com>
Subject: Re: [PATCH 09/35] Documentation: firmware-guide/acpi: correct spelling
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
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

On Fri, Jan 27, 2023 at 7:40 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Correct spelling problems for Documentation/firmware-guide/ as reported
> by codespell.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/firmware-guide/acpi/acpi-lid.rst  |    2 +-
>  Documentation/firmware-guide/acpi/namespace.rst |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff -- a/Documentation/firmware-guide/acpi/acpi-lid.rst b/Documentation/firmware-guide/acpi/acpi-lid.rst
> --- a/Documentation/firmware-guide/acpi/acpi-lid.rst
> +++ b/Documentation/firmware-guide/acpi/acpi-lid.rst
> @@ -34,7 +34,7 @@ state upon the last _LID evaluation. The
>  _LID control method is evaluated during the runtime, the problem is its
>  initial returning value. When the AML tables implement this control method
>  with cached value, the initial returning value is likely not reliable.
> -There are platforms always retun "closed" as initial lid state.
> +There are platforms always return "closed" as initial lid state.
>
>  Restrictions of the lid state change notifications
>  ==================================================
> diff -- a/Documentation/firmware-guide/acpi/namespace.rst b/Documentation/firmware-guide/acpi/namespace.rst
> --- a/Documentation/firmware-guide/acpi/namespace.rst
> +++ b/Documentation/firmware-guide/acpi/namespace.rst
> @@ -31,7 +31,7 @@ Description Table).  The XSDT always poi
>  Description Table) using its first entry, the data within the FADT
>  includes various fixed-length entries that describe fixed ACPI features
>  of the hardware.  The FADT contains a pointer to the DSDT
> -(Differentiated System Descripition Table).  The XSDT also contains
> +(Differentiated System Description Table).  The XSDT also contains
>  entries pointing to possibly multiple SSDTs (Secondary System
>  Description Table).

Applied as 6.3 material, thanks!
