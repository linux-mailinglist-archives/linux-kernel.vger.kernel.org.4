Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA37048D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjEPJQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjEPJQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:16:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8D06A4D;
        Tue, 16 May 2023 02:15:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f42c865535so80501955e9.1;
        Tue, 16 May 2023 02:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684228479; x=1686820479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRWUjVainBSLk+Ch+fZFNLT9kQJZkSXu5GrlLii7+xI=;
        b=hNRIsgzrO8MWE4d56GVZ5AJ5PZuIXk5NuKmXxjOEHrctHlrH5rPw5Yvq+XRysw7YDw
         YWiNnlX8y9CZvHQ7IOKjsb55k49PEbNKtYFvzpp8OxGF6nAiPrGIVVATlEfWw+FAdIRL
         AVIEb88SGUvVkyA+1smMQHrZLXgZjHPABJa+huUyFRJhdFvRs6Tw3nMVkYiDHlNZR6xj
         wYJdJOD18qY92Khd26sLnr/aGnjBQTfNLu8W7SU5jQlJqfksSdpVHgNoB5hHDZuyzd7q
         qxNUwRQu8hwql7P61OW/KD1mlDz5izZ2eJllGkpDdirjQBawiyCA+KVpNqsgyWrpSyNN
         KW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228479; x=1686820479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRWUjVainBSLk+Ch+fZFNLT9kQJZkSXu5GrlLii7+xI=;
        b=UZ1CIqkqq7ZMPOlr1G5FqLj3VJW/j6TVS44FhuhlX90HkCRmBdcpxQOB/+rIYHjiht
         iVciPlF+GdmodYrhy4xgeo5mQUmFbQQhdZ+Q47JDc0iQYbi10L92p1786pEadxIeLP0G
         6xfAePbIo2XhOcPBU3VPW2NFvLZ4XHGv7Gd/MnzO0TFyGMph4EblUhKpR+/RXWir4Nj7
         697BK/+5Jd9GgF66JYPlmvXqszDttZSvU2dCefcTbFuAoFbyfSCfQhVKpuNazQMSxJFB
         K1HkKWVmkSRj9epSukOICc/5SAnyBaGXGhtHF0Esh9LvaFD7Ontbz8jmGFO53YN7g4Te
         eSww==
X-Gm-Message-State: AC+VfDzrT3BOgfMxoF444A4cZ8I89S3d4np1OWwbvO/XlwUvb0RLSIg6
        5s8TVr1Txs1+7KoI+PTmcAs=
X-Google-Smtp-Source: ACHHUZ4f1wIwlxc0TmyeaUQQkL1OqyRolgs2zO8TgR6ZeNh2y9jWnu9DSJjEeyx0TmU2vTz0Xm0OjA==
X-Received: by 2002:a05:600c:2292:b0:3f4:fa56:3186 with SMTP id 18-20020a05600c229200b003f4fa563186mr7682785wmf.14.1684228478895;
        Tue, 16 May 2023 02:14:38 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003f07ef4e3e0sm33140975wmo.0.2023.05.16.02.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:14:38 -0700 (PDT)
Date:   Tue, 16 May 2023 10:14:36 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 5.10 000/381] 5.10.180-rc1 review
Message-ID: <ZGNJfAPd8eeVoCJ3@debian>
References: <20230515161736.775969473@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
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

On Mon, May 15, 2023 at 06:24:11PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.180 release.
> There are 381 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 11.3.1 20230511):
mips: 63 configs -> no failure
arm: 104 configs -> no failure
arm64: 3 configs -> 1 failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

arm64 allmodconfig build fails with the error:

/gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_tlb_flush_vmid_ipa':
(.hyp.text+0x1a4c): undefined reference to `__kvm_nvhe_memset'
/gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_tlb_flush_vmid':
(.hyp.text+0x1b20): undefined reference to `__kvm_nvhe_memset'
/gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_flush_cpu_context':
(.hyp.text+0x1b80): undefined reference to `__kvm_nvhe_memset'


Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]

[1]. https://openqa.qa.codethink.co.uk/tests/3530
[2]. https://openqa.qa.codethink.co.uk/tests/3531


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
