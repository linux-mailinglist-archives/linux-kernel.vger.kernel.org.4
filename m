Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCFB6A1CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBXNHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBXNHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:07:16 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EDF5E854
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:07:15 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id az36so1780279wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vRmr+qDGaynX3Fi6rufm9jo6Cki4j4VKaIrpKJ6hwe4=;
        b=RIzQ/rCEKDayTetLjXaZd+oSz1DZTFs/EICH39jXUnNfYZuNXnhAVn70h8MAx/r7En
         9s9Ztit2RAsX5OutmWbcjJkoU9mBD5kv04WMC7vhxIx2bstjHAjj1xeOVYwNJaVShM3z
         MSXKpi6MONd3MJNXHM3ZRafE10CLJIX6gKoSHplkfWt/wYKfHUkuSARSfw7LabxHBMej
         7+Hj+7Xcz24oxDBt9lUDiNIcYvmbGKsvwOQ6uDv4vzRQi9cfze/4mtNDEknnN7oKrxjS
         5fsa6SOiCOHWvHCnDcmSg4Fx9Qf3bP4BqNcw8pBity7kNEjBwK6FWjDX5KLT8rrlrAUs
         iiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRmr+qDGaynX3Fi6rufm9jo6Cki4j4VKaIrpKJ6hwe4=;
        b=UWRjlsNWpb6+1e93upjNhc2ocSJZv+M666GdE/sv2nZ8wyWePCCSV8X5ZwTg7vSnQ+
         GS7IPUmUCqxbzvL7RsbydRwEZzeRppQIDKHyTwR+FoUiJRWiE04j6+9KsPpWr4lAZ3G/
         y9hUvO51IXUfSdE49ZoU+4z9rnv+ZGUxRVsMHj3D/MJJBiqcVnAVOng2nvVt4yn8y7TU
         0CZOXZEBkWDrba8nzccOZemm5KTYnUtH0JVCGH3Xyprdenind8HHNmH/XDsR8+7iHPBX
         +k6vQDuTdaUJYWRPIyEc7I4jwt15ojYKrz0yqDRrK77WcasA8Y/yhaGPA7rQse+pldF4
         0nCw==
X-Gm-Message-State: AO0yUKXW3mobUotB0PeHAhoGnVtca/Eoa/Yp91vZZuY65+tEoHInqMER
        Nnew3bIF3MdU0LsOcWWsK3mGiQ==
X-Google-Smtp-Source: AK7set/jjFnC7ufdlcEvxsuUZyY5vrhEqrMGd5YSK2I2jwDD6VLGYlvjWgiKEajdk68eJyHa5z6g7w==
X-Received: by 2002:a05:600c:80f:b0:3db:fc3:6de4 with SMTP id k15-20020a05600c080f00b003db0fc36de4mr11161205wmp.35.1677244033586;
        Fri, 24 Feb 2023 05:07:13 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id b4-20020a5d4d84000000b002c71703876bsm3195029wru.14.2023.02.24.05.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 05:07:13 -0800 (PST)
Date:   Fri, 24 Feb 2023 14:07:12 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V2 18/21] RISC-V: Add ACPI initialization in setup_arch()
Message-ID: <20230224130712.c42ob66ux5xhffbm@orel>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-19-sunilvl@ventanamicro.com>
 <20230220200743.rev3djzbaa2jcmg6@orel>
 <Y/ivRjQbIna7M4R2@sunil-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/ivRjQbIna7M4R2@sunil-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 06:06:22PM +0530, Sunil V L wrote:
> On Mon, Feb 20, 2023 at 09:07:43PM +0100, Andrew Jones wrote:
> > On Thu, Feb 16, 2023 at 11:50:40PM +0530, Sunil V L wrote:
...
> > > +	fadt = (struct acpi_table_fadt *)table;
> > > +
> > > +	if (!(fadt->flags & ACPI_FADT_HW_REDUCED)) {
> > 
> > Do we also need to check for ACPI version 5.0+ when checking for HW
> > reduced?
> > 
> We need to add version check of FADT once spec is released. Will
> update it at that time.
> 

I was thinking we need the version check already just for the flag.
The spec has a footnote that says

"The description of HW_REDUCED_ACPI provided here applies to ACPI
 specifications 5.0 and later"

It doesn't really matter in practice since no RISC-V machines can
boot with ACPI less than a version that support the new RISC-V
tables... But I'd rather we either document that fact, or just do
the check.

Thanks,
drew
