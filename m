Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF556786E8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjAWT4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjAWT4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:56:45 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31AB2E0DB;
        Mon, 23 Jan 2023 11:56:44 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id az20so33573392ejc.1;
        Mon, 23 Jan 2023 11:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aG6bB8FbYSgUcAOVToCiYMh7xqxeYAsreqwmnjwBA0Y=;
        b=bZQ7mxQ1dXv9GTtAq097G6yG/hAsqcOzu/oPdF80/FZBgAxz6ubOk8svgGiaR0v0QC
         HdxvKCD5iaFGFR+kF22pxQgUnjbXxxqLrI2tigqdYE9aDTDkLmgJbJhXB7Wl16vNZLeq
         26lwppSyH5XmnXLPNySfklhFLuGiK6KbtdU81PuJjrOPFGqb0J7HooO4IgAm50jbaZ1o
         B/geJWvDYTmdSgL/a6vh4Q8qyzTJMFqktz+7DL1lZ434QlVjik6aJdTGBBbXeGDo6lAn
         KFFbdHeLaqF4bdkMRFqDl6OH0IjcUuODd0p0yY1V1lkeYyNsXXYXvUaZC3dqgEJ7zS3o
         6T3w==
X-Gm-Message-State: AFqh2kpYAvl5Z2LGMm8s3OM+m2HvUDlOKuxGSpwdFa7Fiayyt5nexBpx
        nO2TfV/nXiM4n23IelVyoywVtQ6b7mqzXQPvFMLAEXLi
X-Google-Smtp-Source: AMrXdXsH8dI2YuaT8bEeC4cuEqD4vfb8OuoVtiHh1h6d70WyqgMaw3yamYPwRuG0sn/fJbVyCIy5xRpBQTABqblSUuc=
X-Received: by 2002:a17:906:92c8:b0:877:8b1c:fd7c with SMTP id
 d8-20020a17090692c800b008778b1cfd7cmr2048919ejx.67.1674503803379; Mon, 23 Jan
 2023 11:56:43 -0800 (PST)
MIME-Version: 1.0
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com> <20230123152250.26413-2-jpiotrowski@linux.microsoft.com>
In-Reply-To: <20230123152250.26413-2-jpiotrowski@linux.microsoft.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Jan 2023 20:56:32 +0100
Message-ID: <CAJZ5v0i=NDrHAQYQPfvBGvkvBzNnDhUxxPivQ1VaZ8HBhAyS0A@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] include/acpi: add definition of ASPT table
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 4:23 PM Jeremi Piotrowski
<jpiotrowski@linux.microsoft.com> wrote:
>
> The AMD Secure Processor ACPI Table provides the memory location of the
> register window and register offsets necessary to communicate with AMD's
> PSP (Platform Security Processor). This table is exposed on Hyper-V VMs
> configured with support for AMD's SNP isolation technology.
>
> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>

This modifies the ACPICA code, so it should at least be submitted as a
pull request to the upstream ACPICA project on GitHub.

Thanks!

> ---
>  include/acpi/actbl1.h | 46 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 15c78678c5d3..00d40373df37 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -26,6 +26,7 @@
>   */
>  #define ACPI_SIG_AEST           "AEST" /* Arm Error Source Table */
>  #define ACPI_SIG_ASF            "ASF!" /* Alert Standard Format table */
> +#define ACPI_SIG_ASPT           "ASPT" /* AMD Secure Processor Table */
>  #define ACPI_SIG_BERT           "BERT" /* Boot Error Record Table */
>  #define ACPI_SIG_BGRT           "BGRT" /* Boot Graphics Resource Table */
>  #define ACPI_SIG_BOOT           "BOOT" /* Simple Boot Flag Table */
> @@ -106,6 +107,51 @@ struct acpi_whea_header {
>         u64 mask;               /* Bitmask required for this register instruction */
>  };
>
> +/* https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/acpitabl/ns-acpitabl-aspt_table */
> +#define ASPT_REVISION_ID 0x01
> +struct acpi_table_aspt {
> +       struct acpi_table_header header;
> +       u32 num_entries;
> +};
> +
> +struct acpi_aspt_header {
> +       u16 type;
> +       u16 length;
> +};
> +
> +enum acpi_aspt_type {
> +       ACPI_ASPT_TYPE_GLOBAL_REGS = 0,
> +       ACPI_ASPT_TYPE_SEV_MBOX_REGS = 1,
> +       ACPI_ASPT_TYPE_ACPI_MBOX_REGS = 2,
> +};
> +
> +/* 0: ASPT Global Registers */
> +struct acpi_aspt_global_regs {
> +       struct acpi_aspt_header header;
> +       u32 reserved;
> +       u64 feature_reg_addr;
> +       u64 irq_en_reg_addr;
> +       u64 irq_st_reg_addr;
> +};
> +
> +/* 1: ASPT SEV Mailbox Registers */
> +struct acpi_aspt_sev_mbox_regs {
> +       struct acpi_aspt_header header;
> +       u8 mbox_irq_id;
> +       u8 reserved[3];
> +       u64 cmd_resp_reg_addr;
> +       u64 cmd_buf_lo_reg_addr;
> +       u64 cmd_buf_hi_reg_addr;
> +};
> +
> +/* 2: ASPT ACPI Mailbox Registers */
> +struct acpi_aspt_acpi_mbox_regs {
> +       struct acpi_aspt_header header;
> +       u32 reserved1;
> +       u64 cmd_resp_reg_addr;
> +       u64 reserved2[2];
> +};
> +
>  /*******************************************************************************
>   *
>   * ASF - Alert Standard Format table (Signature "ASF!")
> --
> 2.25.1
>
