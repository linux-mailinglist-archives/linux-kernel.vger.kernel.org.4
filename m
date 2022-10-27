Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605BA61061E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiJ0XHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiJ0XH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:07:27 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2857F8FD55
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:07:27 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f140so3273861pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3Cg4hSAtiIjg4fn0TICaEm2CR+A3G1G6cZSFVGjRNw=;
        b=Av8g1yEyrqRtyNEXn86lA8dQA/VPx5chCpzAaJr8YHh5QrQmllXTNXOUXPEOHaLTfh
         wah/v1AynDgRuQETrGf+yixPVV98WHKq97+NxSSOno8kO3DQ3jhB4U2rusKJLC4eHY1q
         wvTdtdNBgSP3+lqbOhcYy2xMoK6+NjU02/JEB32NB6KAp+5XW8ZorvJH6xFksCrpjFha
         PfR5PKVMXdkD1G2H0+2DVzam1yHTpIYi9xyvFNrvsp6EVyibEf/ArLZyc15zp3dkx/yc
         2a9nAPFMspoi8DdfPyLHMnROPkG2cRexh19jNGrSi055Js0iQvWZVKZ3RIJqFKROLbFn
         QSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3Cg4hSAtiIjg4fn0TICaEm2CR+A3G1G6cZSFVGjRNw=;
        b=QAEoKiQDPMf7HRZecjUMWEsX35fgdj18hOxm3fH+qjhIsZ5Prf+ozKM9CbogBl3yw5
         OXCWoynu1S/YE1kmqeHKLh2Lh358KynYWjbetzGZ+WUTJOGU8NFi0UszVqnlakJbAaLD
         krMyDA+gVt6mN7bDEuzVfoJ8IPd0/eO9LLpSC0jFICDbfpKhWRJ0/qpwygyOnSCBFWsS
         ykmcDJIXLafMmMCKci1fo8Lkg9c+n3E+36wKseUWlcHRli3zwBZp9hQ0ECEfkmonpt40
         peAjEy4aePIHdftHJrG9W76uGOY0tBfBIboCpeIUKKfxg88X714bglI5a69aSR7dCFEb
         wUTw==
X-Gm-Message-State: ACrzQf30Y3S2j9PkdHVFt7AtNqJk3LPVqvQiC9NSeqqqWAyLpdMhW7oD
        TUncDeT4IEv3fmiNRTaZJJ5R4Q==
X-Google-Smtp-Source: AMsMyM7kN3GSvCxNiwfw+NyImUjG5pItb0YNfkTmIf3lG0wAIQ4nx3SiQhJ3M8nvIi0JCl+uWSHK+g==
X-Received: by 2002:a63:8241:0:b0:46e:ffaf:cc4a with SMTP id w62-20020a638241000000b0046effafcc4amr20467261pgd.546.1666912046644;
        Thu, 27 Oct 2022 16:07:26 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001867fdec154sm1688526plf.224.2022.10.27.16.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 16:07:26 -0700 (PDT)
In-Reply-To: <20221006173520.1785507-1-conor@kernel.org>
References: <20221006173520.1785507-1-conor@kernel.org>
Subject: Re: [PATCH 0/2] (attempt to) Fix RISC-V toolchain extension support detection
Message-Id: <166691074050.22328.4455408116267853696.b4-ty@rivosinc.com>
Date:   Thu, 27 Oct 2022 15:45:40 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-36ce3
Cc:     Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        llvm@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Conor Dooley <conor@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022 18:35:19 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Hey,
> This came up due to a report from Kevin @ kernel-ci, who had been
> running a mixed configuration of GNU binutils and clang. Their compiler
> was relatively recent & supports Zicbom but binutils @ 2.35.2 did not.
> 
> [...]

Applied, thanks!

[1/2] riscv: fix detection of toolchain Zicbom support
      https://git.kernel.org/palmer/c/b8c86872d1dc
[2/2] riscv: fix detection of toolchain Zihintpause support
      https://git.kernel.org/palmer/c/aae538cd03bc

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
