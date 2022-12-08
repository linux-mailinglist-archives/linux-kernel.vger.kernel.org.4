Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F66F647B5E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiLIBYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLIBY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:24:26 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8AAAC6EB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:24:08 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so3378510pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 17:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sh3DpSD9hmFO/dex/jVh6bGRV5N5LUyE3oOlwg3aL5M=;
        b=Vm9r2YID3VAMHXS/hHE3pBlUDKFPjeQGp0ma3v7DGNWTWfecsle7RiBJnsoyyTCaI1
         /S3/0e2AncyK7bMpvzKZu0DEHJSdULB3B42HD874t2XMinAOYPT18MjNp8rNaf+9TFbV
         0YmIJGCceR20pHAQ1rlszLJcFj9L6JCENtuGuaH6P26Ibs4D7K9eIGHtjR4ZFObewKVy
         6J1YUxR1HtyRcqPfBr+ff12TaMecaZSrPUvZcRD9hvWw2IID+2Fn+q9VTykkxJI/kajh
         AEI4SMa4FOSQi/6Zy13i5ItmjT8oJgZlCzvqWtnbQPchDsyrILtcMLBHJVv2/l6gC2mM
         WatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sh3DpSD9hmFO/dex/jVh6bGRV5N5LUyE3oOlwg3aL5M=;
        b=slYlz/o986SkmUBdG/FzEiXajZdCDa/46AWp2RTBLHk66ewMsNxjglzUZsMVosYnyl
         hQ1HWk4X0cf3qfx3DIBMeav4GtwVAjLjwFfGXPxtoONpg8lXKbkk/UygrVCGjOCD3oQv
         zohNliMo9UKzkrkIm/+FxPQ2rnJdyJPNa5HJWadyhdIiQbeXgnwnweHjU8UR3bbmyquA
         z+Yjeh2jeye8Au+luPsPkS7eO3JQyjSzOUklZjAcsef6gC+bQwN3MKb446U3CrB6jJFj
         274I4W+z0wqXsvf0/vhULDJ35KknjznSN097RzWsfxcRUQpQ2NEt59+E2zMy/H9U1ll4
         NKIw==
X-Gm-Message-State: ANoB5plXPyhy/0VXGf5LrZp1jcxuvPTdUNDt4xU2DF+xT52YTKtuHj3Y
        gxAfsKBemqJI60rnVm9CgDHFdg==
X-Google-Smtp-Source: AA0mqf6NyW7czNvsIhY95K1Jdc/lOdQ5a/byVZNbMGPNGmzYiRe+hryvEd5tjIxIxLKK82dEP+06bg==
X-Received: by 2002:a05:6a20:d044:b0:a9:167:1788 with SMTP id hv4-20020a056a20d04400b000a901671788mr4645650pzb.19.1670549048337;
        Thu, 08 Dec 2022 17:24:08 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id r36-20020a17090a43a700b00218fba260e2sm194151pjg.43.2022.12.08.17.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:24:07 -0800 (PST)
In-Reply-To: <20221118104300.85016-1-conor@kernel.org>
References: <20221118104300.85016-1-conor@kernel.org>
Subject: Re: [PATCH v2 0/3] RISC-V interrupt controller select cleanup
Message-Id: <167054390671.12029.6021322479982022289.b4-ty@rivosinc.com>
Date:   Thu, 08 Dec 2022 15:58:26 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 10:42:58 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Hey Marc, Anup, Palmer,
> 
> Submitted a patch yesterday defaulting the SiFive PLIC driver to
> enabled [0], and in the ensuing conversation Marc suggested just doing a
> select at the arch level and dropping the user selectability completely.
> 
> [...]

Applied, thanks!

[1/3] irqchip/sifive-plic: remove user selectability of SIFIVE_PLIC
      https://git.kernel.org/palmer/c/fdb1742aff43
[2/3] irqchip/riscv-intc: remove user selectability of RISCV_INTC
      https://git.kernel.org/palmer/c/d8fb13070c3c
[3/3] RISC-V: stop selecting SIFIVE_PLIC at the SoC level
      https://git.kernel.org/palmer/c/bf3d7b1d8499

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
