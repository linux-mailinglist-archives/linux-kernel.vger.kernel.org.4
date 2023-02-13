Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629EF694F96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjBMSnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjBMSnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:43:51 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84AF1C58F;
        Mon, 13 Feb 2023 10:43:50 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id qb15so32135726ejc.1;
        Mon, 13 Feb 2023 10:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phypxvDgNwKNv7NnFv4/pvdOv9qJLQHt4mqzGVZcdKI=;
        b=s026fVsGTurghmPgM3Cg3/r5mpfD33XR5/BGTSbZIyCXKPaHAr/TnzIt9fPmUTyFSB
         igvWFLw0/oeeYcprSQuWskKUzz5k30FiNVAoARHaae5qXYQ5Zyu9SI+dhXJDmtgYYDmy
         EZOwT9ajTfK/6aAsqxT2xoLe6g7S38+yvchrr3qGTmxOZAS70G7yyoqi37bc8Bqc3zBi
         B8ZOi8zKpwxRcGB6bGEay9xYsCG1eWh+dVif/zwW4BTJDRLNRDggFyymrKWGdthRHyPD
         QsOR+B2ZUDIyhfidTG/Dtg6Bzop/p2hWAsnr6sliKvvs5IE/yzRt25hmgwvjGj4Z8cn/
         luNA==
X-Gm-Message-State: AO0yUKVtZ5084sgoB/rTYr9P6kfFWd1K+ElGJ0oWnF1gXDhXti4IBfXk
        jwY7cLIFAIVa3xHQSxt4ZdukByjGrlXZsSVonllzkgXA
X-Google-Smtp-Source: AK7set8G4v6X+CkDIWnl8K1TORQBiW3aIDk5lHcKXCWTKM3NePgnu8luSpLzlaX6B2gPuMP6mSAMNIVKhPmnPxrZXqc=
X-Received: by 2002:a17:906:e28b:b0:8ad:731:592d with SMTP id
 gg11-20020a170906e28b00b008ad0731592dmr5057361ejb.5.1676313829323; Mon, 13
 Feb 2023 10:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20230213092429.1167812-1-jpiotrowski@linux.microsoft.com> <20230213092429.1167812-2-jpiotrowski@linux.microsoft.com>
In-Reply-To: <20230213092429.1167812-2-jpiotrowski@linux.microsoft.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 19:43:38 +0100
Message-ID: <CAJZ5v0hcyWs49ttGA2sjyWe5f++jvCORLeTX1eiP5O2qOAOGgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] include/acpi: add definition of ASPT table
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
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

On Mon, Feb 13, 2023 at 10:25 AM Jeremi Piotrowski
<jpiotrowski@linux.microsoft.com> wrote:
>
> The AMD Secure Processor ACPI Table provides the memory location of the
> register window and register offsets necessary to communicate with AMD's
> PSP (Platform Security Processor). This table is exposed on Hyper-V VMs
> configured with support for AMD's SNP isolation technology.
>
> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>

Please add a Link tag pointing to the corresponding upstream ACPICA
pull request (or upstream ACPICA commit if already pulled) to this
patch and analogously for patch [2/8].

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
