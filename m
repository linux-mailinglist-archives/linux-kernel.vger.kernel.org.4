Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F205F62B651
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiKPJUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiKPJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:20:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3980626127;
        Wed, 16 Nov 2022 01:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668590441; x=1700126441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PBvpl/LIIC4KatBxSf7OTdZHj1uA/ufQHvck22uMENM=;
  b=pp+TfWhU2y+NWgdhKx3W2JYDDrJjYKZ3o5XKcybHLDZGQ89pHSrveuYn
   wDqcKvAsofQI4Ha+X667Jj8DWXJY6OaaBDX78mU5KeRb1X69XWKgr9nz5
   myboTlvLj6jiIOSlBMpFOEsY4wfLwFkiiZIbD//MyDfSaK0wQGsK4gIjH
   guIsAdPKjorSQG6lcLRb+aqPMTrd+FUErV5xlg5P2oG+ojrhRxZgFA/wC
   qd5pxC2d6RPKNdHWw8c8TedpVXTOx05dkkZnMQtz4jyePCRP5kRupYeBJ
   SogEwuvzYsUYXXgrT8HBtr8z8YREgqzzfczu89Ru00+k0qkS+v1UICsTg
   A==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="123666759"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2022 02:20:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 16 Nov 2022 02:20:40 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 16 Nov 2022 02:20:37 -0700
Date:   Wed, 16 Nov 2022 09:20:20 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Conor Dooley <conor@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/9] dt-bindings: Add RISC-V incoming MSI controller
 bindings
Message-ID: <Y3SrVMYjkWEx4wYw@wendy>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-5-apatel@ventanamicro.com>
 <Y3EDuaW0zQSSfiQ/@spud>
 <CAK9=C2WDQCnVnxKR6SFspdwope2KffyASLJDF_Ygo_417ekJ5w@mail.gmail.com>
 <Y3QT5Vy3RnIXobHz@spud>
 <3037b4f9-268d-df03-380c-393a5d01f3ba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3037b4f9-268d-df03-380c-393a5d01f3ba@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:00:27AM +0100, Krzysztof Kozlowski wrote:
> On 15/11/2022 23:34, Conor Dooley wrote:
> > On Mon, Nov 14, 2022 at 05:59:00PM +0530, Anup Patel wrote:
> >> On Sun, Nov 13, 2022 at 8:18 PM Conor Dooley <conor@kernel.org> wrote:
> > 
> >>> Also, the file name says "riscv,imsic", the description says "IMSIC" but
> >>> you've used "imsics" in the compatible. Is this a typo, or a plural?
> >>
> >> Yes, the file name should be consistent. I will update the file name.
> > 
> > Is there a reason why the compatible is plural when all of the other
> > mentions etc do not have an "s"? It really did look like a typo to me.
> > 
> > It's the "incoming MSI controller", so I am unsure as to where the "s"
> > actually even comes from. Why not just use "riscv,imsic"?
> 
> Yep, should be rather consistent with all others, and IMSIC stands for
> Integrated Circuit?

Incoming Message Signalled Interrupts Controller, no?
