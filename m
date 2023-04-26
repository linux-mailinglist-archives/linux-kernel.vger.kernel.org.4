Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D046EFA44
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbjDZSpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjDZSpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:45:23 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC286AF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:45:04 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-517bb01bac9so5388554a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682534703; x=1685126703;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8X9QIdG4Ip5y9y13sVSAOZfIX4bMSFLSP6fvMFKbKI=;
        b=pudR6w2sMYaPRbOA7YCNd1nXsK3n1NGjv1R7Q9HFR2gTFGztwnNIB5tTbbTV5SdJ3q
         Lrm9H0UtTXrx20/sfZM9daDQutjpUALtt2UBHlXi09a7x5xweFuc6YjmpDwnAcy79qhT
         oS9vAYCHEzf7XWsXJXMMuaVDO0NaE/Wxjs56ryvH5Oxt8Xla7Lg3U/ngtGmQj38Uvp1k
         8ctb/S35RfnY+L9kHpDrkI9C8UV2KQVcary3H1xQfWY5wSrJMZ+02s5cRAv52Ef9BKXF
         q/gz+oIP5uOPRMD5iNhwygrma7IyAM4k0uNnzj72xYnpgvAxxJ/7e3eB4F3gW+Xlie3D
         Rlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682534703; x=1685126703;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8X9QIdG4Ip5y9y13sVSAOZfIX4bMSFLSP6fvMFKbKI=;
        b=MKs3jioUJCT3dISbuSRfMU73FNQMA4N2hFq2BfrxhhNL1WWbJba2Bhxa2Wu0F6CEf5
         6+fg1tMGUc7hS1+vYq0IpCmJI9koHQxXppZEq1gl8zaNnMW9PUwBI5/CT6wf+aJ4Lgn0
         bSgsIM1oN+ESUbB6YWBhNTwjvLkLH3woSzTw8e4RxHlmDuUAu7+HnEWubFHdj8czasZI
         N7AdKuuW6N0J20mBD3Hb03hSes6tgtUVmkhgyPL/ewESsq00r2bY43hK+CqmTjehkd5u
         Qxqu/fIFf/wAmi2oufR90H2g2jv+0Bsu+aQzssAqBACP+zdrSAYOSU0wrgqaDxJWVzUU
         Ujxg==
X-Gm-Message-State: AAQBX9cN6yXOonDYHB30Se8+Vt5E1vteqIopaZTozZ/j5yfHCWArfIYv
        Euqs6VnpfKkk5wShysqJEL7Amw==
X-Google-Smtp-Source: AKy350Zxbo8zr4FSe2VzWFsKoxcfkfCx7R5z9jnLJN8dWKNQN0YLmoodj0Tq/TNnwolsDiM3siDcVw==
X-Received: by 2002:a05:6a20:2443:b0:f0:3e57:f42a with SMTP id t3-20020a056a20244300b000f03e57f42amr29047614pzc.44.1682534703116;
        Wed, 26 Apr 2023 11:45:03 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b6-20020a63d806000000b005143d3fa0e0sm10115035pgh.2.2023.04.26.11.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:45:02 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:45:02 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Apr 2023 11:44:12 PDT (-0700)
Subject:     Re: [PATCH V4 09/23] drivers/acpi: RISC-V: Add RHCT related code
In-Reply-To: <20230404182037.863533-10-sunilvl@ventanamicro.com>
CC:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, qianweili@huawei.com, wangzhou1@hisilicon.com,
        herbert@gondor.apana.org.au, Marc Zyngier <maz@kernel.org>,
        luzmaximilian@gmail.com, hdegoede@redhat.com, markgross@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        rafael@kernel.org, davem@davemloft.net, sunilvl@ventanamicro.com,
        rafael.j.wysocki@intel.com, ajones@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunilvl@ventanamicro.com
Message-ID: <mhng-c1242642-931b-4585-8c65-02a0ec5e6a84@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Apr 2023 11:20:23 PDT (-0700), sunilvl@ventanamicro.com wrote:
> RHCT is a new table defined for RISC-V to communicate the
> features of the CPU to the OS. Create a new architecture folder
> in drivers/acpi and add RHCT parsing code.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/acpi.h |  9 ++++
>  drivers/acpi/Makefile         |  2 +
>  drivers/acpi/riscv/Makefile   |  2 +
>  drivers/acpi/riscv/rhct.c     | 83 +++++++++++++++++++++++++++++++++++
>  4 files changed, 96 insertions(+)
>  create mode 100644 drivers/acpi/riscv/Makefile
>  create mode 100644 drivers/acpi/riscv/rhct.c
>
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index 1606dce8992e..2b3e78d5a13b 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -61,6 +61,15 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>
>  struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
>  u32 get_acpi_id_for_cpu(int cpu);
> +int acpi_get_riscv_isa(struct acpi_table_header *table,
> +		       unsigned int cpu, const char **isa);
> +#else
> +static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
> +				     unsigned int cpu, const char **isa)
> +{
> +	return -EINVAL;
> +}
> +
>  #endif /* CONFIG_ACPI */
>
>  #endif /*_ASM_ACPI_H*/
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index feb36c0b9446..3fc5a0d54f6e 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -131,3 +131,5 @@ obj-y				+= dptf/
>  obj-$(CONFIG_ARM64)		+= arm64/
>
>  obj-$(CONFIG_ACPI_VIOT)		+= viot.o
> +
> +obj-$(CONFIG_RISCV)		+= riscv/
> diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
> new file mode 100644
> index 000000000000..8b3b126e0b94
> --- /dev/null
> +++ b/drivers/acpi/riscv/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-y 	+= rhct.o
> diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
> new file mode 100644
> index 000000000000..ea78d906a0fe
> --- /dev/null
> +++ b/drivers/acpi/riscv/rhct.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022-2023, Ventana Micro Systems Inc
> + *	Author: Sunil V L <sunilvl@ventanamicro.com>
> + *
> + */
> +
> +#define pr_fmt(fmt)	"ACPI: RHCT: " fmt
> +
> +#include <linux/acpi.h>
> +
> +static struct acpi_table_header *acpi_get_rhct(void)
> +{
> +	static struct acpi_table_header *rhct;
> +	acpi_status status;
> +
> +	/*
> +	 * RHCT will be used at runtime on every CPU, so we
> +	 * don't need to call acpi_put_table() to release the table mapping.
> +	 */
> +	if (!rhct) {
> +		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> +		if (ACPI_FAILURE(status)) {
> +			pr_warn_once("No RHCT table found\n");
> +			return NULL;
> +		}
> +	}
> +
> +	return rhct;
> +}
> +
> +/*
> + * During early boot, the caller should call acpi_get_table() and pass its pointer to
> + * these functions(and free up later). At run time, since this table can be used
> + * multiple times, NULL may be passed in order to use the cached table.
> + */
> +int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const char **isa)
> +{
> +	struct acpi_rhct_node_header *node, *ref_node, *end;
> +	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
> +	u32 size_hartinfo = sizeof(struct acpi_rhct_hart_info);
> +	struct acpi_rhct_hart_info *hart_info;
> +	struct acpi_rhct_isa_string *isa_node;
> +	struct acpi_table_rhct *rhct;
> +	u32 *hart_info_node_offset;
> +	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +
> +	BUG_ON(acpi_disabled);
> +
> +	if (!table) {
> +		rhct = (struct acpi_table_rhct *)acpi_get_rhct();
> +		if (!rhct)
> +			return -ENOENT;
> +	} else {
> +		rhct = (struct acpi_table_rhct *)table;
> +	}
> +
> +	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
> +
> +	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
> +	     node < end;
> +	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
> +		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
> +			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node, size_hdr);
> +			hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info, size_hartinfo);
> +			if (acpi_cpu_id != hart_info->uid)
> +				continue;
> +
> +			for (int i = 0; i < hart_info->num_offsets; i++) {
> +				ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
> +							rhct, hart_info_node_offset[i]);
> +				if (ref_node->type == ACPI_RHCT_NODE_TYPE_ISA_STRING) {
> +					isa_node = ACPI_ADD_PTR(struct acpi_rhct_isa_string,
> +								ref_node, size_hdr);
> +					*isa = isa_node->isa;
> +					return 0;
> +				}
> +			}
> +		}
> +	}
> +
> +	return -1;
> +}

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
