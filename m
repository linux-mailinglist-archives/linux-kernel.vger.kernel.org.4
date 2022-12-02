Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A67640DD7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiLBSvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiLBSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:51:49 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52639E344D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:51:48 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id jn7so5399874plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 10:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NkylfJHLCaUWC39XJgY9uFoItTR1wh957VtzWUPeic=;
        b=M/k18vAPdtcWltp9pDSiYbad8lgtQr1R0YKRX2jnH3cxPxm6ocwcuKfwdg5XVcELJv
         JlLfNvS/nvrOspX8TJQRaRngl/Wwm/s3Nwx5ejOXOPah+lsH7W4OsTAN7bfGo4uGJy8V
         7yZBDfOkyYp5+nl4M3Ag2mqSi0qPm3n9AfDQfvquiX9DkVIJijd8gExWROMYbOdRW+b9
         BmHchqiTvRyQ/9AqSPcijGDWJgKXhi0/dpw53/HTqQwObaijYy49kgHQ9FyRgpX+hCK0
         X13GyrUK0IVNmd/UUK+3P4N42QM9ouB6HNo2nkKwmcd5JvhV1C+Xp67C9qiFLv+XIoyr
         MWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NkylfJHLCaUWC39XJgY9uFoItTR1wh957VtzWUPeic=;
        b=m2v9QuPBR8gDxWj+I65Nkx7TM6Ja5Ftzfo67IlqhNtNfOEp8hXYNY/dkJFU8/vZH0G
         nZl2pLYqt3bs936re4cTMbcBT7jZQBt5o0U46n0CTotF08lmibf5AL+IFiA8xvmbuBzD
         OC5u7QcPeEU7CiKJhqF1DUQBDlOE2/ZN2Y4UTB9uhT/VsNNQBNfJJ3EmH8EjIURLGPc+
         Fwlta7Mg4pJ3dfFNwViQsaN+SckUrlJODBjHsp46COp66q7NYjNaZIylEJ4+VzoWWUEA
         mrrNKgA1z+PGnRv6n+SBW8gFccOmwzA0PZn3+nA/t4fN3/ZgO42O5cLf+ff9eh/GHR7T
         8jiw==
X-Gm-Message-State: ANoB5pkSkRAmdVUlVXekwJD4jeO8CpIHABuBluSic8n88w8uD9Gs/4AR
        PsSzOy2SehDieWVxxkFWIsr76g==
X-Google-Smtp-Source: AA0mqf6JP8q5rl1k1s+siCcxvzud6ws7QpC/qtRAoo3H6tpms2/dGJP2mzE2MwC1SLB59/zBx+IvDw==
X-Received: by 2002:a17:902:7793:b0:189:24b3:c86 with SMTP id o19-20020a170902779300b0018924b30c86mr54056810pll.84.1670007107784;
        Fri, 02 Dec 2022 10:51:47 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b00186b1bfbe79sm5937381plh.66.2022.12.02.10.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:51:47 -0800 (PST)
In-Reply-To: <20221118011714.70877-9-hal.feng@starfivetech.com>
References: <20221118011714.70877-1-hal.feng@starfivetech.com> <20221118011714.70877-9-hal.feng@starfivetech.com>
Subject: Re: [PATCH v2 8/8] RISC-V: defconfig: Enable CONFIG_SERIAL_8250_DW
Message-Id: <167000658679.29055.15185601584520551755.b4-ty@rivosinc.com>
Date:   Fri, 02 Dec 2022 10:43:06 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Marc Zyngier <maz@kernel.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Hal Feng <hal.feng@starfivetech.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 09:17:14 +0800, Hal Feng wrote:
> Add CONFIG_SERIAL_8250_DW=y, which is a necessary option for
> StarFive JH7110 and JH7100 SoCs to boot with serial ports.
> 
> 

Applied, thanks!

[8/8] RISC-V: defconfig: Enable CONFIG_SERIAL_8250_DW
      https://git.kernel.org/palmer/c/6925ba3d9b8c

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
