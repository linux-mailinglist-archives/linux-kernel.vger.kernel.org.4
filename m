Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5709B72EA39
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjFMRuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFMRuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:50:46 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3286A6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:50:44 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-53fbb3a013dso4194726a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686678644; x=1689270644;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30g+5RTvWxZ/POtOT0u4s+KENg3XA8TnYdOsSrtCeKI=;
        b=FWXr+Cm5r81iCSl5BxYMSlF9tfk9VoeaRpbTFzR4doi2ef/uTL2wFwBdBf35pjrBSv
         pR2P5xk2mw8AEec72rXNNmZXFfkW27QY5nbS7VZg42XHDd/jyhwTfriPnBBmFCY6iv6l
         4bgW224/lTE9SA1KXzHwsCCTO0pxguv2daZXvWM+ZZqaSGzv1LkbopNtkgf2+eh7ZBJS
         /VCH3l6sHN4eg0bDgEjO0+AwjdJ06hojdzO1+1nUzNhouW9+gcEz/UiJ4dMi2hGPCa8L
         liQqxM8R6TQ5RkgwxlgFNuZACWPS7eYB/aubDu1FBQQywKkrZCVKYhqoGkyldT3hRcsj
         oWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686678644; x=1689270644;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30g+5RTvWxZ/POtOT0u4s+KENg3XA8TnYdOsSrtCeKI=;
        b=JXuZf9snk5zc/c0sSJwMQQkXKvpQXIjIUGZhiN0yvyTtdyW0BdQNz/Bu5ml+2yTF2Q
         ZITH4R4dNr7KSIq/mgLkGmQyV/xOwHppBzGV+F10rzM4aYttL/76SjHuFiA33k88zFqe
         sGGxYL+BNp62BfIk0AQ2b2kIukKogU2rc9soYpZ+oLoCGyOzYi4oO+byIloSarO5iR23
         K/zAW+ejI25Zs5qC8r7aElH0ijcV/7ZM267XtZ1Otg2wyQGy6ZlEqiO56aSqenekeDYe
         bm0bFYJuc0auvIfqw5F6NIkGL0FbqB/xitMSUSH7+xrNiMNl9wh13OceDeioRz6ryuaR
         VKGg==
X-Gm-Message-State: AC+VfDzO/l6sy57QyTMSC9kh4pBEA42xdiYhqWbsZx7NKcTmAO+bc9sF
        mDe625IJ3PTMP+0T2m65ELNehQ==
X-Google-Smtp-Source: ACHHUZ4vZSFn1tmwHCtCy2ep7HRRqOCwT29eUWxVgrK1nI/ZHPdnBYjjzh6e4pLsprVDqT1KWhC9Kg==
X-Received: by 2002:a17:90a:8044:b0:25b:f88f:5348 with SMTP id e4-20020a17090a804400b0025bf88f5348mr4786217pjw.17.1686678644253;
        Tue, 13 Jun 2023 10:50:44 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a031c00b0025c02ef91f6sm2670106pje.22.2023.06.13.10.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 10:50:43 -0700 (PDT)
In-Reply-To: <tencent_E6911C8D71F5624E432A1AFDF86804C3B509@qq.com>
References: <tencent_E6911C8D71F5624E432A1AFDF86804C3B509@qq.com>
Subject: Re: [PATCH v3 0/2] riscv: allow case-insensitive ISA string
 parsing
Message-Id: <168609537703.11035.4463826338484666822.b4-ty@rivosinc.com>
Date:   Tue, 06 Jun 2023 16:49:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yangyu Chen <cyy@cyyself.name>
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 02 May 2023 00:10:19 +0800, Yangyu Chen wrote:
> This patchset allows case-insensitive ISA string parsing, which is
> needed in the ACPI environment. As the RISC-V Hart Capabilities Table
> (RHCT) description in UEFI Forum ECR[1] shows the format of the ISA
> string is defined in the RISC-V unprivileged specification[2]. However,
> the RISC-V unprivileged specification defines the ISA naming strings are
> case-insensitive while the current ISA string parser in the kernel only
> accepts lowercase letters. In this case, the kernel should allow
> case-insensitive ISA string parsing. Moreover, this reason has been
> discussed in Conor's patch[3]. And I have also checked the current ISA
> string parsing in the recent ACPI support patch[4] will also call
> `riscv_fill_hwcap` function as DT we use now.
> 
> [...]

Applied, thanks!

[1/2] riscv: allow case-insensitive ISA string parsing
      https://git.kernel.org/palmer/c/255b34d799dd
[2/2] dt-bindings: riscv: drop invalid comment about riscv,isa lower-case reasoning
      https://git.kernel.org/palmer/c/9e320d7ca46a

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

