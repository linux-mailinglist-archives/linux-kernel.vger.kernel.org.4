Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16512745A5A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGCKfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjGCKfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:35:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADF6C2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:35:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3143b70d6easo242539f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 03:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688380517; x=1690972517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J40dAHLBYs+6jNCvPXKQ8FET9CwOYOul2uRlAFchtyg=;
        b=iGOVDqd76rhLjh7X2a6Q5e0e8jd+GHtjYscGqSI8MLzWyvjZoePaP2A1WEYG8adQ5K
         QxIfBaITzYX1tF6MwCgpTUIDhadocJCWdYhlCEXGPG43pk/9zUFbB8CFNVQ2jh5n/xX2
         Sg+bS/ZJQloKuMnl+xskng+XdAUec+zzWjKiFM2XhFPjmckmvQ2Hjd1h1L7nL4pmEBOt
         aSznGCfKbFUqwn/8I3i0A+NhF0AObLwA5eARKLjWPXiDcIFVEqjy1FKQtPnk07rsRRzz
         J4Eh17PnGcZEd74pJnKyMQKJvZt9FpaJ4ptfL4h2nGmB92o5lF85d6WtULTcZWfUL0AV
         riuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688380517; x=1690972517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J40dAHLBYs+6jNCvPXKQ8FET9CwOYOul2uRlAFchtyg=;
        b=IcX2C/R+UafWWpZbyxED1F9TQxinrezJ0S0Nm5VjhlJR/CtWMUK5/mqrZeUi1UY/Tq
         keHX3kjEfiMfJzGugfn8yM+SYHbYNFbAM3svyg8OaGS66KIfTGoYSkiqpVl93W6kmKqD
         G/KKLbC1X8r5RWN5+qts4CQFTGyrH2Jx/+rl5oDpYwPgRAGGc2eRWnLwbPeFvDAyMdgg
         FxaE/GmD969B8H4kX7tJ6/3yg5ri8jERdIVoTuo1SEDo7e+cAapsGOk5GEFpQRc05Mmd
         5KPN82X3TKU/HbGCxdV4vrGjgi+1n0Tcuwu9//ouQtQ1J/XT/g43yqUtYwVmSHLFSaXe
         XJiw==
X-Gm-Message-State: ABy/qLZ71qG7T3Mq3Um2A8FqWao/31nyLnP1vayS4pcQbPJBM9dYtY74
        LQqC9cxAIGwm2ss8i032lFfEzOZ1LFE86xPAIkA=
X-Google-Smtp-Source: APBJJlGeBmzt5GDmk1m6+um4Vg0XHzEHow2LQZ3z3s3wvCCqvafdIhSFB1GZm3Ai6rWjn4XoMZmD7A==
X-Received: by 2002:a5d:554d:0:b0:314:824:3777 with SMTP id g13-20020a5d554d000000b0031408243777mr7601315wrw.48.1688380516742;
        Mon, 03 Jul 2023 03:35:16 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id u18-20020adfeb52000000b003113943bb66sm25177829wrn.110.2023.07.03.03.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 03:35:16 -0700 (PDT)
Date:   Mon, 3 Jul 2023 12:35:15 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Amma Lee <lixiaoyun@binary-semi.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, xiezx@binary-semi.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: optimize ELF relocation function in riscv
Message-ID: <20230703-8fe42edab5ff83cea01db4f9@orel>
References: <1688355132-62933-1-git-send-email-lixiaoyun@binary-semi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688355132-62933-1-git-send-email-lixiaoyun@binary-semi.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 11:32:12AM +0800, Amma Lee wrote:
> The patch can optimize the running times of insmod command by modify ELF
> relocation function.
> In the 5.10 and latest kernel, when install the riscv ELF drivers which
> contains multiple symbol table items to be relocated, kernel takes a lot
> of time to execute the relocation. For example, we install a 3+MB driver
> need 180+s.
> We focus on the riscv architecture handle R_RISCV_HI20 and R_RISCV_LO20
> type items relocation function in the arch\riscv\kernel\module.c and
> find that there are two-loops in the function. If we modify the begin
> number in the second for-loops iteration, we could save significant time
> for installation. We install the same 3+MB driver could just need 2s.
> 
> Signed-off-by: Amma Lee <lixiaoyun@binary-semi.com>
> ---
>  arch/riscv/kernel/module.c | 67 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 64 insertions(+), 3 deletions(-)
>

I guess this is a v3 of [1]? But there's no change log here to know
what's different.

[1] 1683881513-18730-1-git-send-email-lixiaoyun@binary-semi.com

Thanks,
drew
