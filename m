Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379B367A95E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 04:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjAYDtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 22:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjAYDtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 22:49:45 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC12126F7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:49:44 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id g68so12600662pgc.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 19:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnB3T9k3P3og6S/sk7qknvEOozu7/Wm64yCeJMFNdvw=;
        b=0UHXmG29Bqv3FzULtv7f93P1JlBTMyLxN90ylh/ngMm0LpalmWaszBLSFMsxWIElMO
         +DYaA/q7TPMra6BJ7sauV/4sBbvrzWsbkUhpmYwZE9ifocopdsfI8SuBK5Ojt/A5/iGG
         Hi9mImTgQw3xkFSeTV+/9/ApAJsWTC6fAXytmX5sQMTcsQhSjqwsH0506IfuhrctG8I+
         9KnY5vL6M06hmsTRlNzlJJkuMeqKaYQeXYiCSraiOHg25NSALSn+b6lGqavwWvKTIkif
         2o34gq86Fj/T/0rKV6tXXnCmofTEAP304J/SXduO8/LdF99sEUW+f2j/ftO1GIV0+aV4
         7fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnB3T9k3P3og6S/sk7qknvEOozu7/Wm64yCeJMFNdvw=;
        b=mgZgusciKpJ9rNlUn7Mpkkv7pT2OkJ9dyQm3fd31XhjUDs3h+2dOgLD6+BHn89qaRv
         0nRoFBpNWOH31/shkzlhhehdgUo6H4gPjbpzXNVWYxKv4dmhYDyV1SFOBRWCPv2Ab6Ux
         frzWgBgDrMpIBf8Aj7Kj2Um1zROWQSc4NziMRQ+DEbFY8fCAvRtYI2/khbujPMUv5oSg
         nyYLMv8Ek7jerhKn6AdpAzUedybMzDt5N6I+I5UBlpltIn4J469mEUTVTh2waPca1eGx
         Kt6GgPnTlQBsHDtW4RC8iMD0/ub1gKFAhLsDmFOzKBWKzeHUIJ/v/LruAXn0R/ep8Cl1
         8zWA==
X-Gm-Message-State: AFqh2kpEnlUpvmTjeJb5zhS3uHR1WFi53IlaDaIn3d3onkS9L29LNV0c
        33HuUELFYP4EjYL87RsPl+YqeTZjs9uM7/+/
X-Google-Smtp-Source: AMrXdXu/n9NVSeTxN9w7G+GhXf/V9RpRcEMdIc9rDjNXTtgozjt8JQ1Uf3SOdxgYXJt2eF/quf6/zg==
X-Received: by 2002:a05:6a00:1887:b0:588:cb81:9274 with SMTP id x7-20020a056a00188700b00588cb819274mr44971593pfh.32.1674618583828;
        Tue, 24 Jan 2023 19:49:43 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id w17-20020a627b11000000b0058dd9c32fcasm2371918pfc.180.2023.01.24.19.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 19:49:43 -0800 (PST)
In-Reply-To: <20230110080419.931185-1-guoren@kernel.org>
References: <20230110080419.931185-1-guoren@kernel.org>
Subject: Re: [PATCH] riscv: pgtable: Fixup comment for KERN_VIRT_SIZE
Message-Id: <167461852792.4353.8179831324242884848.b4-ty@rivosinc.com>
Date:   Tue, 24 Jan 2023 19:48:47 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     guoren@kernel.org, alex@ghiti.fr,
        Palmer Dabbelt <palmer@dabbelt.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 03:04:19 -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> KERN_VIRT_SIZE is 1/4 of the entries of the page global directory,
> not half.
> 
> 

Applied, thanks!

[1/1] riscv: pgtable: Fixup comment for KERN_VIRT_SIZE
      https://git.kernel.org/palmer/c/6be1ff430dab

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
