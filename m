Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A8B6A1DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjBXOpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjBXOpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:45:06 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166113BD9C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:45:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id nw10-20020a17090b254a00b00233d7314c1cso3059434pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=coTtLh17Jcp/i0fKluv9ugDwM4AesfTvM9iAIYJCq2A=;
        b=f3JP3IfXZFoWmGVI+4aC5ZR6KytWd3/IEHl8NQy66xo+fh0HIm6MxedamJlxa8lmAl
         fPZCJigIQoFapyXsf34PLbN35QvacCathImrfrvcSwCQu3H/mXdgGvsKKvIDS7GxJcSI
         K4hISq8h9SDFlloVloSQcmKNkcY3+ahaPqbJwxZNGSgsfIqmdjIGe9ovGg8Py222kmjl
         zyvSr5nhPsrS30yHyQgAGQ2XxxjJy8kB1k2F4U86BXsVCd3c4kUCL0G4lrFkSklq3c25
         OyvtfK3ObB4PhLcCUuu+YrSO5foxebwWaxQ3UrcvkXuH8tl7RDskoyYWD/uNdmXFNdWG
         fp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coTtLh17Jcp/i0fKluv9ugDwM4AesfTvM9iAIYJCq2A=;
        b=pVZobXBT2wf8p7HOEFHELAzINdo8qfMdOi9ddd/qrhuDzZ9CQsXy+NopuBuD+FaxnH
         ij796ttuZwf6EgUC9nl9c9edZTUgC5UznaNOUCpDljrYQnir+wwbKv1GelORomlR/Hkz
         D9y4fXwOooRE+7Kds78lOTVIjHTCzMp+ocC5v2mtqcVxLd5nJ87d1XGLPoe9tE3HGKvD
         XsKWtvHWO03QXYwROfEUFKFd50fP35g4xIvNBvYyc7e27sNIkcDRhRQXDvnaBcTD+Gbb
         MR/iry5rj3rYcC9N+dLyNT2CNN5xx/9oxKCHcfBoBfDgEtT4SJnCH9MbzhzGxJ0SkIdO
         hucw==
X-Gm-Message-State: AO0yUKVhClXS2NhuzP3mP0fqpn/mYNkjeltE+D+1EwuPruQE4chri3hB
        cgTL4bNBbjea9XTpksTJQJoWYw==
X-Google-Smtp-Source: AK7set/Iyjj7TrMe766Iwdl0u/OZcVJHX4ug1aHv9t/gLxoHo1hy6D3fQY4QTXwCFZqVNjl7iJMV7g==
X-Received: by 2002:a17:90b:38c7:b0:234:a88e:d67e with SMTP id nn7-20020a17090b38c700b00234a88ed67emr17691751pjb.34.1677249904318;
        Fri, 24 Feb 2023 06:45:04 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902b60c00b0019472226769sm9103967pls.251.2023.02.24.06.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 06:45:04 -0800 (PST)
Date:   Fri, 24 Feb 2023 20:14:54 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Andrew Jones <ajones@ventanamicro.com>
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
Message-ID: <Y/jNZg5k1UZ26i1X@sunil-laptop>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-19-sunilvl@ventanamicro.com>
 <20230220200743.rev3djzbaa2jcmg6@orel>
 <Y/ivRjQbIna7M4R2@sunil-laptop>
 <20230224130712.c42ob66ux5xhffbm@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224130712.c42ob66ux5xhffbm@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 02:07:12PM +0100, Andrew Jones wrote:
> On Fri, Feb 24, 2023 at 06:06:22PM +0530, Sunil V L wrote:
> > On Mon, Feb 20, 2023 at 09:07:43PM +0100, Andrew Jones wrote:
> > > On Thu, Feb 16, 2023 at 11:50:40PM +0530, Sunil V L wrote:
> ...
> > > > +	fadt = (struct acpi_table_fadt *)table;
> > > > +
> > > > +	if (!(fadt->flags & ACPI_FADT_HW_REDUCED)) {
> > > 
> > > Do we also need to check for ACPI version 5.0+ when checking for HW
> > > reduced?
> > > 
> > We need to add version check of FADT once spec is released. Will
> > update it at that time.
> > 
> 
> I was thinking we need the version check already just for the flag.
> The spec has a footnote that says
> 
> "The description of HW_REDUCED_ACPI provided here applies to ACPI
>  specifications 5.0 and later"
> 
> It doesn't really matter in practice since no RISC-V machines can
> boot with ACPI less than a version that support the new RISC-V
> tables... But I'd rather we either document that fact, or just do
> the check.
> 
Okay Let me add the current FADT version of 6.5 which for sure
supports HW_REDUCED flag. When the spec gets released, we can update with
actual revision we need for RISC-V.

Thanks,
Sunil
