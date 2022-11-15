Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F5962A10B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKOSGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKOSGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:06:39 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA94212765
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:06:38 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id i10so29403870ejg.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxphCWzuw1yf1Ze0H/WEX7HxLj5IaZ78xIqJDGMoOT0=;
        b=oO0oPHW+aVrQA//FKJOT5lGh36xtK8VerYktwnj4pGLjfgHgFM+iXB0NZEJoS2TuTd
         J6n15F55DLclGJ5W503JyX8AOYidHxtIBDSWK4BEjDK3bhlByj8T0v/YW/KBMMpqnJp3
         BRc7R4YPOIbpPtKYWH/UsQwzSOn98UF6oBYgi5r4DDsmmAV5kA+P51W3uJ0BVthoKA45
         0T/8+g3V+aZd7E0x3PQZtGQyl02jGPYM1ziODp0wd49anzmTNZ/7rE9fq2J8X3RIE9JY
         s6MNUgXzQVJADgEnzBDFRg3AYYILJJLUYX8LykNpPbTQmMddp4C27a+J1dYgz+gRDOye
         WA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxphCWzuw1yf1Ze0H/WEX7HxLj5IaZ78xIqJDGMoOT0=;
        b=YB6+34zQ7qyNANLmxUvdoLWwR+G2SclsNUwdsv5eY7QSJxtiCAkC99TwbnmItfO/gu
         2xt0Sx4hqqMPmdJDLyu5I1uYzq5ANj3iDK39xMWnbj/qFIdJJQqoTlQ0YPNtG/hOfGeM
         +MmcbPuRSEiweHMohhX6+bc2lgRxZfqKt1VQTgDpcQf20RfvaAVztpROrgW2ieYQPZU7
         HrxPtjDvUydWRuuJrjK3Irg/IWQurfL42SJ7Q+t7KDuWr4udIy+G1N7DgNwTatsC74cQ
         Zk/A6rwxCdZZukmnojpIL8/kkh9FUdLNgmYDPZh6P4gJJb2u6oqDqd3WTWyQWsYEz7jr
         cCqw==
X-Gm-Message-State: ANoB5plnulYUmUM2oCIoFYEZvuIzPat3M5EPz4fxZJ7srwNK9+CWciGM
        ioNWHRFWQRb3wb3TnRLp8ICfBw==
X-Google-Smtp-Source: AA0mqf4IvSk5Q/p6zfVDaS0JcXWLFOPJwyAtgdgfZZ7iBTZxEMr4vBTrneZWdpvDgLB7FrjIR220Ew==
X-Received: by 2002:a17:907:20db:b0:78a:16ad:8250 with SMTP id qq27-20020a17090720db00b0078a16ad8250mr14814054ejb.747.1668535597272;
        Tue, 15 Nov 2022 10:06:37 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id p9-20020a05640243c900b0046447e4e903sm6478342edc.32.2022.11.15.10.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 10:06:36 -0800 (PST)
Date:   Tue, 15 Nov 2022 19:06:35 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, aou@eecs.berkeley.edu,
        jan.kiszka@siemens.com, kbingham@kernel.org,
        linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3] scripts/gdb: add lx_current support for riscv
Message-ID: <20221115180635.crej6pcvokdo3njy@kamzik>
References: <20221115012917.1781185-1-debug@rivosinc.com>
 <20221115084923.1822572-1-debug@rivosinc.com>
 <Y3OkY6myfea00BaK@wendy>
 <CAKC1njRi9C0m3JKpu0ebAFCC25161EST=tFFWiAj1yZBbnak6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKC1njRi9C0m3JKpu0ebAFCC25161EST=tFFWiAj1yZBbnak6A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 09:49:10AM -0800, Deepak Gupta wrote:
...
> On Tue, Nov 15, 2022 at 6:38 AM Conor Dooley <conor.dooley@microchip.com>
> wrote:
> 
> > Hey Deepak,
> >
> > On Tue, Nov 15, 2022 at 12:49:23AM -0800, Deepak Gupta wrote:
...
> > > +         if (scratch_reg.cast(utils.get_ulong_type()) >
> > current_tp.cast(utils.get_ulong_type())):
> >                                                           ^^
> > extra space here?
> 
> 
> I don't see the space in the patch. Can you clarify which space you're
> talking about here?

The same one I pointed out in v2. The one after the greater-than sign.
Is your editor not using a monospaced font?

Thanks,
drew
