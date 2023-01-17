Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDD766E86E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjAQV3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjAQV2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:28:54 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6822323867;
        Tue, 17 Jan 2023 11:50:13 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1442977d77dso33145771fac.6;
        Tue, 17 Jan 2023 11:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVRN9WuFQqZQy8t/vvVMvysnKtLMLWxVtmq6SFpr+OY=;
        b=cZxYL6S40bpSxV9RAsHlUK2VXV/O6y3pGRHZCC8OWQlBIAPjjkHazVofbKX972JcG8
         YsHr6ZAdJ1OTN8bjfkkOrhdSHSNHZ2pePc9FOT7nMdi9rvmkLKZ/3IXSfuilbSyXt+yA
         dlfgFPkN55mE46xoHFJ4blqDgzy8ruq59RqwlWTX1ZEnrA5t0BNwrmx8HBSfDeAzrj4P
         sTDll9cNLVfvWQbdjXXC4Jkom2LVtzgL7NKhMTdAvKXf8sgkj5Wodq992Ggsa18YkXFf
         ANGBFTIi/tl1Ag/oBUf6kr8sxtfD6h/wVXOKRjiz0uJI1KFvJBTTThT/yvg/uors32wU
         aGKg==
X-Gm-Message-State: AFqh2kqKnSePnxyLLBI6NzKDIXUdTpK1Mf+AyiHZJboNMwBBcU5L5iMd
        kx7qRjAVGbKXTr9nMDLPgEfEL/VX/g==
X-Google-Smtp-Source: AMrXdXtDWEQCAQKd90hHWf7/fvv4ZNpfThfphggEnd/a33sVVKdBxufs/RmFdfHxKmucc9XtTeDTNg==
X-Received: by 2002:a05:6870:4985:b0:152:d0dc:2bba with SMTP id ho5-20020a056870498500b00152d0dc2bbamr2462922oab.15.1673985012635;
        Tue, 17 Jan 2023 11:50:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bc31-20020a056820169f00b0049f8b4b2095sm15479404oob.44.2023.01.17.11.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 11:50:12 -0800 (PST)
Received: (nullmailer pid 3526963 invoked by uid 1000);
        Tue, 17 Jan 2023 19:50:11 -0000
Date:   Tue, 17 Jan 2023 13:50:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     samuel@sholland.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        atishp@rivosinc.com, will@kernel.org, robh+dt@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        apatel@ventanamicro.com, ajones@ventanamicro.com,
        opensbi@lists.infradead.org, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v5] dt-bindings: riscv: add SBI PMU event mappings
Message-ID: <167398500960.3526866.18235571341667319487.robh@kernel.org>
References: <20230113205435.122712-1-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113205435.122712-1-conor@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jan 2023 20:54:35 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The SBI PMU extension requires a firmware to be aware of the event to
> counter/mhpmevent mappings supported by the hardware. OpenSBI may use
> DeviceTree to describe the PMU mappings. This binding is currently
> described in markdown in OpenSBI (since v1.0 in Dec 2021) & used by QEMU
> since v7.2.0.
> 
> Import the binding for use while validating dtb dumps from QEMU and
> upcoming hardware (eg JH7110 SoC) that will make use of the event
> mapping.
> 
> Link: https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_support.md
> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc # Performance Monitoring Unit Extension
> Co-developed-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v5:
> - Remove the word hook from top level description & reword some of the
>   statements that sound clumsy when removed from the context of OpenSBI.
> 
> Changes in v4:
> - A bunch of minor description/comment changes suggested by Drew
> 
> Changes in v3:
> - align descriptions to SBI spec (and fix a misinterpretation of mine)
> - switch to a nested items description, since the descriptions are for
>   the elements of each entry, not the entries themselves
> 
> Changes in v2:
> - use the schema mechanism for dependancies between properties
> - +CC perf maintainers...
> - move the matrix element descriptions into regular item descriptions
>   rather than doing so freeform in the property description
> - drop some description text that no longer applies since changes were
>   made to the SBI spec
> - drop mention of the "generic platform" which is OpenSBI specific
> - drop the min/max items from the matrices, they don't appear to be
>   needed?
> 
> OpenSBI is BSD-2-Clause licensed, hence the license here.
> ---
>  .../devicetree/bindings/perf/riscv,pmu.yaml   | 161 ++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> 

Applied, thanks!
