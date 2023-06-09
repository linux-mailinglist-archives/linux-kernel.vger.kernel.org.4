Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3115729302
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbjFII0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240604AbjFIIYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:24:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D08D3C3E;
        Fri,  9 Jun 2023 01:23:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30adc51b65cso1439197f8f.0;
        Fri, 09 Jun 2023 01:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686299012; x=1688891012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hESlPtiMkKprbYVZWF5WJWN2aGL5r7t0ApI5+mmRyB0=;
        b=BQyDsaqkDyBWYVZF/AVcBKzt2B1IFlTWk9a2CX+OmiEwmU7p4VG3sfQ/1wLolnbXmj
         CMBy9TA6yNyhQoL5ZP9U+b/Vk38QvvEnJZIUWuRs2l2qr5Wf8g5R1XEANbVzOGJffFcX
         7nNar+XWU+5xgPih6aVJIhvjvqbl8v/XJt6kZciF2F15JedwKSkmg7Ee2MmbQ+vobj6M
         DUdtxK/JBNoMXBfKBYveCiho7nQHzmep3uPpiGOScv4SRyxhBZwqcE8U1Qjf/cuNoPCQ
         V2fLHiclsWPc0dDcN3N6CqwRfFZiGOxAq/IthD/cR0VP67I4LgiVrV3njkl56AmrelNC
         bBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686299012; x=1688891012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hESlPtiMkKprbYVZWF5WJWN2aGL5r7t0ApI5+mmRyB0=;
        b=QkDpp0n7Gb6J3sH3Y7zAYYTGcX04/EMP0oeibyx8jr4ON37AiN/RNd69oKXv+KYxa9
         BsfcM5iAr97hKuZBtUnY/B1GtuumY48M2VZslF6Oj0R/lBjViTY6saPZU+DSgOciv3gI
         yEQW2RCDPYLyiOpMFXkG33kgTkbQt+ifglxek8FTh3rwC3j/lvMcPVKZKX2unrhQyozK
         91FUtIGYDksAbDs9AGFqAHENrQp+vdZraKC/g/rSqevneM4ZHkdGEVbbgF4ZDBGy94S/
         xDJqXSBnoaWV2eJs9BctW0123hv9u9pyc5G+eMwwgmoLNbEOwcf2g1jBVVdxUS51iyM2
         1IvQ==
X-Gm-Message-State: AC+VfDxsO+ifKlls1pUj53ikl3nnCdGruWFP7HBlIyzRK2HuNeJ3AmzM
        7OnBIqjz3ajX7qpcO+5JCl8=
X-Google-Smtp-Source: ACHHUZ4CRzvbhWxHia89K6HWPpQFgfp0h45TKT5cng/bUltErsyatSXCh71jmSFAwQhCw0mLEr2rPA==
X-Received: by 2002:a05:6000:4cf:b0:30e:56d9:d7ad with SMTP id h15-20020a05600004cf00b0030e56d9d7admr476807wri.71.1686299012331;
        Fri, 09 Jun 2023 01:23:32 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000008700b0030fa166d8a1sm1126605wrx.34.2023.06.09.01.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:23:32 -0700 (PDT)
Date:   Fri, 9 Jun 2023 09:23:30 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 5.10 000/120] 5.10.183-rc1 review
Message-ID: <ZILhgiQl0Twzknr5@debian>
References: <20230607200900.915613242@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
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

On Wed, Jun 07, 2023 at 10:15:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.183 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 11.3.1 20230511):
mips: 63 configs -> no failure
arm: 104 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]

[1]. https://openqa.qa.codethink.co.uk/tests/3821
[2]. https://openqa.qa.codethink.co.uk/tests/3822


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
