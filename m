Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3317293AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbjFIIux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbjFIIub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:50:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D3895;
        Fri,  9 Jun 2023 01:50:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30c4775d05bso1039504f8f.2;
        Fri, 09 Jun 2023 01:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686300628; x=1688892628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QlhS76abjw2unQxYRogEYbRc9c+4vaUtoOax7Eo2mpE=;
        b=HR37tdNjO6ngZIOBuyeFvQy2tBqrULVrePY3fvThMC7JwDm37IkcfhapHMoCtDTLgV
         lqerEAxML/bRSOfdiKXc3+WImhNAecjxZOgX8WM3OpYRxiebfChwkSlq9fvM7gVHzTPR
         PyNQXwAvhXkZyUQDQSFDrcBZefBpMmjdKXKi/4KVetoyS9agAQtS0yL5PRlr0JHEbSi1
         9mw+M3mPOlKY/tRcfS0jh47bGjUquy9qidY5g8qiJfi+G3bQKhP/4yoUOuDAmkJKiU58
         vgHe/KVqJHA8YgdkveAQq0yEqJ+ly0RDcrGftWmUY1A/wsddrcsuFUxDEsH2Zd0L33jo
         vZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686300628; x=1688892628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlhS76abjw2unQxYRogEYbRc9c+4vaUtoOax7Eo2mpE=;
        b=bFLYU85HHCyiYDyv8ALowj/fqkm8sXHWjNFU5VNcmoh6aYXYKqg1dERiKHef6Gdqie
         RCx64g4GH/izWRfGnXPaZKOwVoxZ4F/a5JhVCUwGdSRzfwEXsURLsVULjAkx0Kc29bVf
         O78nmCf34hijnZsRGLaZH+9vLgrIeokdDM2adIAWrcYSljD0ftq7b2EEnVhiio0j3rIX
         CiPywKxDqQA3nZ2GSJAP2HXcIAT/eMUphHLI4RYgD+iU4rJ+XkAEHwL2J5JPvZRIsUtE
         ln0DYvkGSRlZl26k01LLlM+2148iOn3MaHztuPx3hLHQ0uh9Egq0U1VoTFluIEvX+Q+N
         IjwQ==
X-Gm-Message-State: AC+VfDyddIb2l2b2ZSi5qAlLOsbi00DNulZZ3/ci98/0Ywl6iQcED2nV
        iqNW8uHM5+5WTBQQqQmiRLM=
X-Google-Smtp-Source: ACHHUZ5FL2uwDQQk+Qwd1oRh5/2afHTPCb6VVpooihXZdU7XJeSEFfMWqX1FLahYOnplauNKXdw8kA==
X-Received: by 2002:a5d:5052:0:b0:30e:4c8d:c6c with SMTP id h18-20020a5d5052000000b0030e4c8d0c6cmr295484wrt.55.1686300627965;
        Fri, 09 Jun 2023 01:50:27 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id m6-20020adfdc46000000b0030e5bd253aasm3852053wrj.39.2023.06.09.01.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:50:27 -0700 (PDT)
Date:   Fri, 9 Jun 2023 09:50:26 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/224] 6.1.33-rc2 review
Message-ID: <ZILn0m8jsz8+jnMF@debian>
References: <20230608175726.909746266@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608175726.909746266@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Jun 08, 2023 at 08:00:45PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 224 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 12.2.1 20230511):
mips: 52 configs -> no failure
arm: 100 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
csky allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]
mips: Booted on ci20 board. No regression. [3]

[1]. https://openqa.qa.codethink.co.uk/tests/3828
[2]. https://openqa.qa.codethink.co.uk/tests/3812
[3]. https://openqa.qa.codethink.co.uk/tests/3827

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
