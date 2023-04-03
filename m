Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550EC6D4461
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjDCM1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjDCM1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:27:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79350113EA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 05:27:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so19387796wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680524863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxqO2IX/lOxdyOopfgbP40oTI1EeUwuWoB1FSfdYqqY=;
        b=LwR9i9ZCwIynxLtQb6FQaFGe+/+1Np1vHT66lBjNQ4A3obHiN3EfpVZ3oil192Ng0M
         W8WqxBNP6kb/4Xui4QYKaEaVAyHV1egHkOsb/HhY42jGt7TV7D+EwlO4VxH/7p5e7ugF
         wOghWg/YTPx5nrZSzCp92+ljn7EVVqgg/NmqGiiMR4FSevXoKTemvsnj6yhYB5Fpptpu
         7Q5eB/4hSeMoeyyv09YaJQEFZcXq+9wwRlfjvLtoC9vVHsIWseaV+X6pdrduPTUvy/RW
         BD75a13P16aa4bOlSNPTbEUYL/86i1Uw2mJ8JZQcTJgg469ub9r4Y/Zmtax/yxjh6azL
         ZQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680524863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxqO2IX/lOxdyOopfgbP40oTI1EeUwuWoB1FSfdYqqY=;
        b=4mg9VWi5V5fDBuFqWM1+vnJrfQJFp7up73lJVwOB2J500F1J6R9w/KyER6alb6677P
         61wWWTRJagF2YtkfbKkZ4900BjBkAi6pFBw09fdwIxFpR20obMrqNlZuLA1WaWTwsZgG
         bj986vyLGcxDG5BkzfU/FYMYisFRrKjaIzWGnJTo9hDBVUe27Fcl9vmOgbvrya5aDcl0
         rP+0xFHq6891h9KSTpUEeLmjlh3Ko6f+NuOrJIvDc3ci3yBI5Ub/hdBzfldTvDHq1IjA
         xaA/C5SdAuAifLzCNolzvp+jgX/EaA1/l262vAp7798v4yrcwY+W1chePdwfbwmSHr7m
         HOlw==
X-Gm-Message-State: AO0yUKXuKtYnHdkBlkChh9LYtFBNoarb/vVCiL8kYwdpq0v/FcNiftjq
        nXRNJmyTaOBIWn1ik/7qh4v7WA==
X-Google-Smtp-Source: AK7set//ZEBXvjQpHtj+FZ1Pzr5549u8qSf3J/8O/2XhOoJ4yBLZqx6rSXkc5Ji7/GLfD4blCbGeiA==
X-Received: by 2002:a1c:f619:0:b0:3ed:514d:e07f with SMTP id w25-20020a1cf619000000b003ed514de07fmr27877312wmc.3.1680524863019;
        Mon, 03 Apr 2023 05:27:43 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id l32-20020a05600c1d2000b003f0321c22basm17875591wms.12.2023.04.03.05.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 05:27:42 -0700 (PDT)
Date:   Mon, 3 Apr 2023 14:27:41 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] RISC-V: KVM: Add ONE_REG interface for AIA CSRs
Message-ID: <qrx4xyreynfc3yg67cwknwxof3omuknmz55bzyjzrgs3d3iffk@a4qt4pewh5pk>
References: <20230403093310.2271142-1-apatel@ventanamicro.com>
 <20230403093310.2271142-7-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403093310.2271142-7-apatel@ventanamicro.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 03:03:08PM +0530, Anup Patel wrote:
> We implement ONE_REG interface for AIA CSRs as a separate subtype
> under the CSR ONE_REG interface.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 8 ++++++++
>  arch/riscv/kvm/vcpu.c             | 8 ++++++++
>  2 files changed, 16 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
