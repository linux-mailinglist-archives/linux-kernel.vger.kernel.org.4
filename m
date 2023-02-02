Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278DA6878DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjBBJbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjBBJbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:31:48 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427AC59E6F;
        Thu,  2 Feb 2023 01:31:47 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id x7so1390071edr.0;
        Thu, 02 Feb 2023 01:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffpgR5z2JZo6pwKFf6fTkgFN1AbQFcPjb/i8EhiUIp0=;
        b=PnZb8TfMK9LulumZbLHMdE9FvYIZNFF+ziO3KmXlRPbPkYrv52Ffb97jKAoCJn9avG
         Fo0KNzsBIlCii7tOyRTJKk5x61Fn7p4bpXcdQ0qHAkseLFitxfwmyhJPiVdlX5ZZXsWs
         VMJv5Q0lUCuHm9ARq5+2vdw6Zc80EfeXxUi/oKGORZBf8yorBMJY0KYrPGiu4sDIHFRk
         tv6qM0sHVSUIr4jT7UPraXNTI7pHUma2bMLci8eZHbzOjXHhaP27vFtRZlVHwPYbLgUY
         dA4ChUbqLxUwWhwfHAY6dwddBDRtP2pB0fsaPV2yIPHYI07ht6tApk19foHl4GaCpKq0
         2X0g==
X-Gm-Message-State: AO0yUKUqnLQ+2DJMLaQsOFHkFGK5qVxH4r2CnzUosFpoMjO3Y7OlkQlm
        7d34YpYH9HtxPOCUC7pfcrwgujE7OA36qY4Steg=
X-Google-Smtp-Source: AK7set9306TERMaXrdPKee5SdML+Gqydz/luQ9C1YIJFgYD0NZ/nYQnWiZBRLI5KkCDKzPTMZc9hEPaVfQaHClP1dUA=
X-Received: by 2002:a50:cd8e:0:b0:4a2:480b:e164 with SMTP id
 p14-20020a50cd8e000000b004a2480be164mr1594675edi.50.1675330305735; Thu, 02
 Feb 2023 01:31:45 -0800 (PST)
MIME-Version: 1.0
References: <20230202034821.25123-1-tianruidong@linux.alibaba.com>
In-Reply-To: <20230202034821.25123-1-tianruidong@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Feb 2023 10:31:33 +0100
Message-ID: <CAJZ5v0i=2f+NFHbyYNgL8vqkcf8ST=14-uqHqOUmL0JPVhmiBw@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: PCI: Undefined ACPI_ADR_SPACE_PCI_CONFIG when
 CONFIG_PCI is unset
To:     Ruidong Tian <tianruidong@linux.alibaba.com>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        jkchen@linux.alibaba.com, xueshuai@linux.alibaba.com
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

On Thu, Feb 2, 2023 at 4:48 AM Ruidong Tian
<tianruidong@linux.alibaba.com> wrote:
>
> ACPI core subsystem initialization will fail when Kernel disabled PCI but
> ACPI tables still have PCI config address spaces.
>
> Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_address_spaces
> only when ACPI_PCI_CONFIGURED is defined.
>
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>

As an ACPICA change, this should first be submitted (as a pull
request) to the upstream ACPICA project on GitHub.

Having done that, please resubmit the patch with a Link tag pointing
to the corresponding upstream pull request.

Thanks!

> ---
>  drivers/acpi/acpica/evhandler.c | 2 ++
>  include/acpi/acconfig.h         | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
> index be9a05498adc..86057e39df8c 100644
> --- a/drivers/acpi/acpica/evhandler.c
> +++ b/drivers/acpi/acpica/evhandler.c
> @@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
>  u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
>         ACPI_ADR_SPACE_SYSTEM_MEMORY,
>         ACPI_ADR_SPACE_SYSTEM_IO,
> +#ifdef ACPI_PCI_CONFIGURED
>         ACPI_ADR_SPACE_PCI_CONFIG,
> +#endif
>         ACPI_ADR_SPACE_DATA_TABLE
>  };
>
> diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
> index 151e40385673..28456120529f 100644
> --- a/include/acpi/acconfig.h
> +++ b/include/acpi/acconfig.h
> @@ -162,7 +162,11 @@
>  /* Maximum space_ids for Operation Regions */
>
>  #define ACPI_MAX_ADDRESS_SPACE          255
> +#ifdef ACPI_PCI_CONFIGURED
>  #define ACPI_NUM_DEFAULT_SPACES         4
> +#else
> +#define ACPI_NUM_DEFAULT_SPACES         3
> +#endif
>
>  /* Array sizes.  Used for range checking also */
>
> --
> 2.33.1
>
