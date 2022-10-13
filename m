Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB35C5FDE97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiJMRAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJMRAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:00:06 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FDE42AF9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:00:03 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 3so2487315pfw.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27cGiu0Pf2lf77wdB4SczFGe0dYVOUJndJgYtLGfh2Q=;
        b=ha3YlUkjApYlUAQOIb3BwJut7rOreagRPltDoN3/evAiA60czpVBNaIvKYT6asLhS+
         YUUc8bmXKoMbB57vodTNwdRCDmpGL8ozL8bwakefVz4gL43MTjZ6XphKchXXSvUWGuml
         NFhhDxXGU6fIMVfY+aQHssVqpXT9x7TuO/wZQHhCwTldjClOH7q8hjux4g0H5c+XKwSr
         xQgIKfCVgGy9o17L1EHloeWdEHHLR5+nFBfrUCIWXtthTzFPcPg3Q4T9XU0pbvpJtejH
         v7iEqPiOK0EPCz9ldGu4HfqnNvysop+rvwV8AG0XwMzLV8Te4Fjv2VF8xW4/7UT3L3Zy
         RExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27cGiu0Pf2lf77wdB4SczFGe0dYVOUJndJgYtLGfh2Q=;
        b=fHHz0vyDbOQVXwRVuheFnwYcSJLc6hnwNBXDFg2CifonZUA53LCeAJRiVmXSokP7Km
         EqMLCJIGL55PW1Q4v8sdR/Hr+BFIyO2XH2jEcbkcalGPyuRwbOAVWkgtnjuWHfW0S2gt
         n1wBPyZJfyNJCYYl+yXvM1dZ3LxwLqBfMDHc4RMEmHo3DfbiWif50KZhY+8lYPmUOOYG
         sCBXue79VN08yvq2NowkR7DctkD9ISWcSXcOTJaVl7KiV87gkNK7FdKL750NbnOVLcso
         7YRrk+1IuAScZWuWnlCnooD7SrALa5PNZcpHNh46udW5cUfnynq+O2ow2zm7KXLgcaMU
         8/Iw==
X-Gm-Message-State: ACrzQf2xpfTiKwpVl0f7otYsMLNRONcttI6hkAqFR8PVhS1s5iA0lIlh
        dsjg5AEErVgX7ON9u1paHP6FTNrVl2Gzzmvr
X-Google-Smtp-Source: AMsMyM5fRzBRYjBWiEeY1dgIQaQVm1LW3/HAX/zrzYXR70biomR0fVPdRkcO2/AGu2JcuyV4V1L2aQ==
X-Received: by 2002:a65:4c46:0:b0:460:f598:d038 with SMTP id l6-20020a654c46000000b00460f598d038mr730221pgr.99.1665680401862;
        Thu, 13 Oct 2022 10:00:01 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902cf0300b001785fa792f4sm78055plg.243.2022.10.13.10.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 10:00:00 -0700 (PDT)
In-Reply-To: <20220905111027.2463297-1-heiko@sntech.de>
References: <20220905111027.2463297-1-heiko@sntech.de>
Subject: Re: [PATCH v2 0/5] Some style cleanups for recent extension additions
Message-Id: <166568032205.23595.17535934122459066446.b4-ty@rivosinc.com>
Date:   Thu, 13 Oct 2022 09:58:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-2a85d
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        guoren@kernel.org, Atish Patra <atishp@rivosinc.com>,
        apatel@ventanamicro.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     aou@eecs.berkeley.edu, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2022 13:10:22 +0200, Heiko Stuebner wrote:
> As noted by some people, some parts of the recently added extensions
> (svpbmt, zicbom) + t-head errata could use some styling upgrades.
> 
> So this series provides these.
> 
> changes in v2:
> - add patch also converting cpufeature probe to BIT()
> - update commit message in patch1 (Conor)
> 
> [...]

Applied, thanks!

[1/5] riscv: cleanup svpbmt cpufeature probing
      https://git.kernel.org/palmer/c/e47bddcb2ec5
[2/5] riscv: drop some idefs from CMO initialization
      https://git.kernel.org/palmer/c/f055268e3946
[3/5] riscv: use BIT() macros in t-head errata init
      https://git.kernel.org/palmer/c/499590c084f1
[4/5] riscv: use BIT() marco for cpufeature probing
      https://git.kernel.org/palmer/c/e283187c034c
[5/5] riscv: check for kernel config option in t-head memory types errata
      https://git.kernel.org/palmer/c/14057733109d

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
