Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBE7718585
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjEaPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjEaPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:03:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF8F121
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:03:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d41763796so4133929b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685545422; x=1688137422;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALTOtXPl7WneZEczbI4aASRfMlEXlldwEBTkzZZ2WKs=;
        b=O/6IXWweMuAY+XSU/vwd/R2Qf3/keOkkfHe6yktMlbJAYIrjwYAwCScR8URQtfLVBF
         Q3cEeWrM+a/bFZb9Vyyy/lciMxEGaLoWbK2qmjwYXfJS0JxZIiEF7VXNnwvDublCb45M
         8iQTZn/ys+aM8FkCtO+1ZufzUuO728sHlS0sXgVbHLXO42x+z5k6/tLHHb+O1LIG59TB
         6TdpQK4NtEWQCjtmXOD+f6TeZReZKT7dhXcl5SZz0lIImqdaMClJH3NJ4qwHhdKpcGaN
         7j7DtpmMJLQimaleoxWLMMnhHQsEen3FDRth823BxdUAQswqvsx2+08xLETJ+Jea1sSR
         jeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545422; x=1688137422;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALTOtXPl7WneZEczbI4aASRfMlEXlldwEBTkzZZ2WKs=;
        b=cNQX76yLpPRPcgrZkJKJzGUm08xJfaM+sYYpQ7MnEBOLi7iGN3+6zbMpYUY/nfY12Z
         VodfP0u/PhkXgkrx5BHW94F0pPyhkPvHithHc4W7uJKbbExX8GTg70H8OJJJE5KBTNeP
         YrhONKK08WJkjNnGW0R0T0FZ3dIFFdhpJxlyXDld8zICPdUEsXYz0wPTO02gjQ7pQu4y
         xqwXAu+CH3Jaljwgt8bx7equl9ygCWyUaC0F2AiMYQNqWRgZUnQC6S+TaYzeyazKPjZh
         ZpGD6YiaaLHEBL0gnRI9kxIAPLN7znKIhjUHpbt2sMVifWhnw9MXbwQhoYXKC4pdymg4
         FVHw==
X-Gm-Message-State: AC+VfDwGdBTg6d5SNVw4ORjdS/9Q/dXH3bTqdiH+tOeoXlmbF1MqQJYv
        V5naAjmgY6eM/FzJguUyc7pLEg==
X-Google-Smtp-Source: ACHHUZ7dVAFU6Mu2bNkSmU2wj27QKF/ql1+HpKaSeoc1pbUUdsoZeBMyRumOex8m7gIkk1G1oKWYJw==
X-Received: by 2002:a05:6a00:15d4:b0:64d:1215:a0f5 with SMTP id o20-20020a056a0015d400b0064d1215a0f5mr5381179pfu.34.1685545422406;
        Wed, 31 May 2023 08:03:42 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id u7-20020aa78487000000b0064358d032a4sm3530851pfn.145.2023.05.31.08.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:03:41 -0700 (PDT)
In-Reply-To: <20230526-astride-detonator-9ae120051159@wendy>
References: <20230526-astride-detonator-9ae120051159@wendy>
Subject: Re: [PATCH v1] RISC-V: mark hibernation as nonportable
Message-Id: <168554541142.21606.8005252517231405209.b4-ty@rivosinc.com>
Date:   Wed, 31 May 2023 08:03:31 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Conor Dooley <conor@kernel.org>, atishp@atishpatra.org,
        anup@brainfault.org, alex@ghiti.fr, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Shuai <suagrfillet@gmail.com>,
        JeeHeng Sia <jeeheng.sia@starfivetech.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 26 May 2023 11:59:08 +0100, Conor Dooley wrote:
> Hibernation support depends on firmware marking its reserved/PMP
> protected regions as not accessible from Linux.
> The latest versions of the de-facto SBI implementation (OpenSBI) do
> not do this, having dropped the no-map property to enable 1 GiB huge
> page mappings by the kernel.
> This was exposed by commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages
> for the linear mapping"), which made the first 2 MiB of DRAM (where SBI
> typically resides) accessible by the kernel.
> Attempting to hibernate with either OpenSBI, or other implementations
> following its lead, will lead to a kernel panic ([1], [2]) as the
> hibernation process will attempt to save/restore any mapped regions,
> including the PMP protected regions in use by the SBI implementation.
> 
> [...]

Applied, thanks!

[1/1] RISC-V: mark hibernation as nonportable
      https://git.kernel.org/palmer/c/ed309ce52218

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

