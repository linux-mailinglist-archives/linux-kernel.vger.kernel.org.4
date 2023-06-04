Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FFF7215A0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 10:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjFDIhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 04:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFDIhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 04:37:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104F9DA;
        Sun,  4 Jun 2023 01:37:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-307d58b3efbso3219730f8f.0;
        Sun, 04 Jun 2023 01:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685867851; x=1688459851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/RW4TbjF3qcw7YmxPDw6GL8ZaIlrSZn8h5/QVYrrPp8=;
        b=EbrdZUBU0Mji0L16MSXokIObTH9SYRfFZ9gA94biGdVBS0x4jvyCuw88nbgVmLXeA/
         dBIZXIkJM4USV1s1QzfjXqPlQ/mkCcSFfHkMxq+V4UbBCW0jCU86+n2p7b7lwz/SHUbB
         6oBwcfFk8E7dJ74MnTPLfF8tL0+RwRLT2hwbIogBWWwm/iQeXR4mqAdOEqG2qEjzJ4gK
         mp74hHZR1+daJ1JAGQX947XUR6kYqFMaA6Kmp6GKKYgdiTNglrCsD/P3W9m/uQ0kXYBo
         Bb7sXpIjaqG3xkkf/ZXKvxX7PwFOj+mznLXJ5s44FskVQxyhUz6ViuYAfzoqxKjsZRTZ
         UK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685867851; x=1688459851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RW4TbjF3qcw7YmxPDw6GL8ZaIlrSZn8h5/QVYrrPp8=;
        b=B/x1gx2qNUmN+0HqqGPV3cAjwxQ3vBwPpsurJ8ADckyqDoZXSIFSmCDuc1fbtnwGPl
         yDFsKem7xVpi7+QLZwDHrWAMdaxPk6K8Nc5NTTRHv0NrDjoW8DSzpydZ9FHUSIu9YnzC
         n/jclClIRJ39d/HSxf3zNTpj3ro74XdCVxqgxuqmOgS455R/d8LYDsK4Y7pjZjHOZW1q
         4z48qyLni9elup3kMEATakLZVoMIJHpxp6rznCx0Q656NjRok9L/7k9vj0pMGrOW4yxr
         aNqDtbkrWeHKAqz80b47niHOt3ta1MFhjD63EuDOVeANYFaoZbSXSj56mp76oKUTVs4l
         XvjQ==
X-Gm-Message-State: AC+VfDzDya47MGKHkG0y6qszGi0Mz1LJ0nAX+6KycIDhCGCKRdvgIFoj
        je6Y5C24mMbhXt3k3VVi7L5auwuPYvI=
X-Google-Smtp-Source: ACHHUZ6L4JF0jW2JC0FX5JeRF+CeIhBoPYgf9/5C1p+83UpPGn6iPCqD+sXs46KxF7D+/zjqgYrtuw==
X-Received: by 2002:a5d:58e3:0:b0:309:31ac:6663 with SMTP id f3-20020a5d58e3000000b0030931ac6663mr2692479wrd.16.1685867851220;
        Sun, 04 Jun 2023 01:37:31 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d6186000000b002ffbf2213d4sm6466544wru.75.2023.06.04.01.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 01:37:30 -0700 (PDT)
Date:   Sun, 4 Jun 2023 09:37:29 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 5.15 00/35] 5.15.115-rc3 review
Message-ID: <ZHxNSQkgrZsyV6OT@debian>
References: <20230603143543.855276091@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603143543.855276091@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sat, Jun 03, 2023 at 04:37:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 12.2.1 20230511):
mips: 62 configs -> no failure
arm: 99 configs -> no failure
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

[1]. https://openqa.qa.codethink.co.uk/tests/3687
[2]. https://openqa.qa.codethink.co.uk/tests/3688

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
