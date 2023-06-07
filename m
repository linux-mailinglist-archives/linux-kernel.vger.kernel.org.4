Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BAD725312
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjFGE4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjFGE4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:56:08 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4522810F2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 21:56:05 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-19f8af9aa34so7097182fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 21:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686113764; x=1688705764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ee1qHw85e1eBuIdTgig6finUlPCk2EHIHBldhRjpTW8=;
        b=DiiCfwERoWx0zOUM6VadmUsxBffRWRnopnDGBblkb0ISRVgQEQf1pjTtTWHLCp4iXK
         392f7jwCBXbbhXbsQCNqlRjb5DsCw7T6EMUo1cnqIkpgxWKeZfqy58+VUANGkE2lZ6/n
         9TSdiCbv2gFVERoyfxjUq+5ZhULgFzZ9R42eIpISI+Xl/5pEbFzm2ctnfAFFGddWF+rE
         a4AgthExR8lzUQetmql+RP4RJxiwD5dllYQqsl8HDwJmFxmjaPckUlSSHKOFTSeQ9WrQ
         S4BS28CTZwwQA+det0+xGA0OkJe04KCxDIakCuSdih7STEs+c5atOkky8WiBWa7cRvSH
         kInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686113764; x=1688705764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ee1qHw85e1eBuIdTgig6finUlPCk2EHIHBldhRjpTW8=;
        b=ULiLFbtDpRVY0YhTceoar8Y8rUQ3vrUQ+frrW+ZpIc/WO+cN4NQgC5JS6Jhpzfy1nx
         bqBpuE/smsm/NAwcehQl1RYo3y224n+kCbCBayaZOMqE+fbKGIYy9igu+VNJFLESMZNx
         MD43FCb5M4OG3UwmA4uycDH6d9DdCvAjtRzCqv7+b+Yqz0Y8Mu3I4TrCvQRSoEegFLFr
         8a1fJ/xtqNlfl3eJpgfN+PDTNd47EwWEHsn3y1h7tQjcni9NfZcZ3uXxInr6fU87tDRg
         JX8icewSc782N2Ka1KB/uQqokAEwOnhf+4u0tUIx4gqTsEiioUUTV7zKw/FwHuwA+aZh
         2UDg==
X-Gm-Message-State: AC+VfDyRnxi0HByXdqj/3K4837SuJsOy4SiNkEpBNKWFuZO/PXmxGP9s
        bYxP8P9nCf4S9IDsUUw7I4y0Cg==
X-Google-Smtp-Source: ACHHUZ4Z/iohestmpyscDyMKSE2JiJGGdU65tjAlQFbm9eJHYAacPAnDBkWRMxzeQTL6/kERoYlX3w==
X-Received: by 2002:a05:6870:c82b:b0:19f:1947:551 with SMTP id ee43-20020a056870c82b00b0019f19470551mr3995485oab.6.1686113763954;
        Tue, 06 Jun 2023 21:56:03 -0700 (PDT)
Received: from sunil-laptop ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id ed43-20020a056870b7ab00b001726cfeea97sm5564537oab.29.2023.06.06.21.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 21:56:03 -0700 (PDT)
Date:   Wed, 7 Jun 2023 10:25:56 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 -next 1/2] RISC-V: ACPI : Fix for usage of pointers in
 different address space
Message-ID: <ZIAN3OHhPbvgj0uV@sunil-laptop>
References: <20230605143512.707533-1-sunilvl@ventanamicro.com>
 <20230605143512.707533-2-sunilvl@ventanamicro.com>
 <20230606-conduit-cupped-1791a640713b@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606-conduit-cupped-1791a640713b@spud>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Tue, Jun 06, 2023 at 04:35:29PM +0100, Conor Dooley wrote:
> Hey Sunil,
> 
> On Mon, Jun 05, 2023 at 08:05:11PM +0530, Sunil V L wrote:
> > The arch specific __acpi_map_table can be wrapper around either
> > early_memremap or early_ioremap. But early_memremap
> > routine works with normal pointers whereas __acpi_map_table expects
> > pointers in iomem address space. This causes kernel test bot to fail
> > while using the sparse tool. Fix the issue by using early_ioremap and
> > similar fix done for __acpi_unmap_table.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202305201427.I7QhPjNW-lkp@intel.com/
> 
> Is this
> Fixes: a91a9ffbd3a5 ("RISC-V: Add support to build the ACPI core")
> ?
Yes, I missed it. Will add.

Thanks!
Sunil
