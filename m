Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E5C729406
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbjFIJA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241189AbjFII7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:59:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F87173A;
        Fri,  9 Jun 2023 01:59:46 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f732d37d7bso10659515e9.0;
        Fri, 09 Jun 2023 01:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686301184; x=1688893184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dk7boxF/9/KN8GwWEET84WLw8dgEVug8WBc4y7YXzoE=;
        b=pdcrcA9ymjmWCw4gJJoG99qknB3gxUsHnyct2z7MHeGGbClJ4HuEAWuEg1nxRSSkLi
         UMne/SfFUfqr+mtvdB0ZQsioOz6Q17grcfDRBtSTgzAWkthlCDbgFGFcRCf3IndlmTn1
         4wRTIqgbIcN6LUSuZscWQ28ZiZxL54o2XVe5CHyaD/WyjC6O/0stkbw49C8aYKxGuGqq
         HyqzI2+Sa6b4EfDy7TYPwnLfi+/tMR+HrZK5e1WRely0Jk+tbL1e9HBwn8H6CZ3hVniP
         kjATyftvyZXtoVZKaFFsb+b2aZQoBORaOFcTAwH7Y9Q25y9uf1Iw7KHVpw38cgmAI7UE
         7B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686301184; x=1688893184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dk7boxF/9/KN8GwWEET84WLw8dgEVug8WBc4y7YXzoE=;
        b=DHG+/1uNZx8H2vmWr74xpjF8TCMF2xKucXagCStLK18XNU9wancDuW5ZPcMgn/+30c
         W0RDoxWYGQs4esxfnEZk0UfB4SYWmvczX1WCKzECQC4NpMaWLPKpDFiNISG+bgMjnAx8
         uMZ+fHMBFZegw7RQO1LyhyS0yqa7Yiktq5T6X8zvBDWlDOce+c0hnlqBgIipQWdh74Rf
         xpXeZk2eVMO4WW5kV8iSYZhDyq9jF+F8IxRHVgajOWI3tlTUgeGgJDHhPbsYCfkmiEiK
         HaeLs7Xhw4Wsbv/ZBukLMKvlq+mKybjWqrpuj4LZpccqXSU609unzaEfbFEZfBe6f/Bs
         1s0g==
X-Gm-Message-State: AC+VfDypNiBIpKc1FhfA0i+wby373lkO03OfEvzz0p+FW5dTn+U4azAv
        GnxA+ayQKomS2S/s5rDw8aQ=
X-Google-Smtp-Source: ACHHUZ7DijPleZHqtZpsYl1X78/S7FIkEn5S34I55CA9LriEVpVhX0bCOcbv5Dl08GHXgFR0URLDiA==
X-Received: by 2002:a7b:cb98:0:b0:3f7:948f:5f17 with SMTP id m24-20020a7bcb98000000b003f7948f5f17mr420174wmi.7.1686301184473;
        Fri, 09 Jun 2023 01:59:44 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bc5c6000000b003f7f87ba116sm2003715wmk.19.2023.06.09.01.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:59:44 -0700 (PDT)
Date:   Fri, 9 Jun 2023 09:59:42 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/285] 6.3.7-rc2 review
Message-ID: <ZILp/l2B2AJ+/1Yi@debian>
References: <20230608175722.489602717@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608175722.489602717@linuxfoundation.org>
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

On Thu, Jun 08, 2023 at 08:00:53PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.7 release.
> There are 285 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 12.2.1 20230511):
mips: 52 configs -> no failure
arm: 71 configs -> no failure
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

[1]. https://openqa.qa.codethink.co.uk/tests/3814
[2]. https://openqa.qa.codethink.co.uk/tests/3815
[3]. https://openqa.qa.codethink.co.uk/tests/3829

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
