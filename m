Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B462647B5D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiLIBYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiLIBYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:24:21 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8164286F6E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:24:06 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 65so2634597pfx.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 17:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKTAsr2IrXMz/U2BqEq73Jfn0nVzLtC09ILEdcEpquo=;
        b=2CRNgwmN3i03MopIoAI+Cyp5x7a2vzmm1Ez+9w0eeXm10PfG3FZT2uDND623esVUul
         fJesWMTE6Y3FZD0Cyo82R7j/ZSHW9sZVYb6z1eMF2CdYAurpKPq7ZRfbMzvSG1l2T9XB
         HA7qhLaXo4XqDcrCuyHuHpmVi9ZrFssSbMKxcGKlVjgoY4GrX+d6uIcLc+d020Ze36F6
         9FsREAqpVzJMGRRzGEX8Gk9JKgmhA74kI1ym1TuxhIDbBDko9TgadlL2+U3KbJCvlElj
         kJjgHmXcR45ne7Vr4UWCcrYhsQIPJaesj62ipPuL9OkrUv4BCPhul0irQWDd0XNvYTc2
         uj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKTAsr2IrXMz/U2BqEq73Jfn0nVzLtC09ILEdcEpquo=;
        b=Qb3j+qa3HFG+rr4PiGdN1iAbIz4v9E70F4IiqTjkI0RGB1r6HWdGEa6WX62FCnHGhR
         XEk+dYT2zQEOsxlYzhNOC8vYidYPHVT0ogRQHGCGF6iKSrWo5dNm61oZ158i7XQuW7CA
         JJbuZdxt9MihzJH9RMbNQMk1REoJIpqf/Yior++aCTt5YAVyu+tkbxReq6JsH8KbLCy9
         /fIlZYQCMTMjfCHk06KiMC35OV9AgNKYX6EeS6gUzOn0iZ6ghb0wECed66iGvPhKJ+FH
         NjcP2G5XltXq5Z3zmBYbuzQoc2USTbC4XsMrEd4jhgq+Q2tjsrgoqgiK8f+BhXO8vL66
         pxfA==
X-Gm-Message-State: ANoB5pkLPQRfUHFiroLbC0f3tsGTYlhApKSDL2QLEYEMOzk7J/RbJQHR
        9SH/p1T9ImOue/Zyr4WG0qIOlw==
X-Google-Smtp-Source: AA0mqf7IXsDw5KMVyYSCx2/x3dmfWax5dCPlOeHHAghTvWBGXnL1yaFR8uHDgzS2bfAS8m5LzGS/zg==
X-Received: by 2002:a62:8783:0:b0:577:9d32:b30f with SMTP id i125-20020a628783000000b005779d32b30fmr5183990pfe.15.1670549045965;
        Thu, 08 Dec 2022 17:24:05 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q15-20020aa7842f000000b005672daedc8fsm124950pfn.81.2022.12.08.17.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:24:05 -0800 (PST)
In-Reply-To: <20221114090536.1662624-1-apatel@ventanamicro.com>
References: <20221114090536.1662624-1-apatel@ventanamicro.com>
Subject: Re: [PATCH v6 0/3] Add PMEM support for RISC-V
Message-Id: <167054326322.9839.358393101882236728.b4-ty@rivosinc.com>
Date:   Thu, 08 Dec 2022 15:47:43 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-riscv@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@atishpatra.org>,
        linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 14:35:33 +0530, Anup Patel wrote:
> The Linux NVDIMM PEM drivers require arch support to map and access the
> persistent memory device. This series adds RISC-V PMEM support using
> recently added Svpbmt and Zicbom support.
> 
> First two patches are fixes and remaining two patches add the required
> PMEM support for Linux RISC-V.
> 
> [...]

Applied, thanks!

[1/3] RISC-V: Fix MEMREMAP_WB for systems with Svpbmt
      https://git.kernel.org/palmer/c/b91676fc16cd
[2/3] RISC-V: Implement arch specific PMEM APIs
      https://git.kernel.org/palmer/c/a49ab905a1fc
[3/3] RISC-V: Enable PMEM drivers
      https://git.kernel.org/palmer/c/497bcbe3ce04

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
