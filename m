Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA67F6FCC56
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjEIRHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjEIRHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:07:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371C9DD93;
        Tue,  9 May 2023 10:04:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aaf21bb427so44243445ad.1;
        Tue, 09 May 2023 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683651874; x=1686243874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cqwYJC2a32+Z6h234kt8dpAjjln4imJVcBQC4D4MUi8=;
        b=jaY2ZrpWSQ2CfwkRMbKibXqOX/GLsR53W6H6XyjXjqvx3qsNBjGX6/PABq9XQAuDfz
         GKRoCrP73N/US1bT0/K8BaGTY+q/5ZuIRCn6FyS28za/gpHn03b+d4O/HByy07po17KV
         n4YYjgDnG+BW1D91s1bz9do/4fcfZB4LOY4sgkdT79r5+s9qb7EavfGuigho+b48HSjV
         XFhqvoueCNXhzppgDLWYUDeKoYeRBBWcwiEsCaRXyYZSF6jYJ2utDV5/7Y5aioRVCUSH
         CYlkV4+DrJ2Gg45DIti0YTMGf79wj/NebLWeJ9cTzzMG5AWr2eYC8fFLgznTsFn6mfp+
         rxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651874; x=1686243874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqwYJC2a32+Z6h234kt8dpAjjln4imJVcBQC4D4MUi8=;
        b=Bykvm8wNFchhpT3eph4/BMTEPJxIBZa75kaOUipc050fF2QdvL+M+/VdD29+vP0bbE
         kyLxj89/+fCO1hlrjC23ZYvJn6ybUOGwyItgqaEHtDfnxaIMVdByUaOLIT5isITsuq/q
         GZO1xPcBjHqEi0oLNx8ipFfuN49UAYoPbfdayB2xdwCD33UJJUoOb3d6nAyDBFzeZySj
         zX5UBJQKcSLQa8VrN/65/SihJbh7k/7ESfZ4iXc1RxzbaTHong1S3pz3s+9JOFOlXl83
         sk/SryGqpb7ZRstor4XLhAGTwVp3vZa/66pnPd+6I0IbegYGP1gYJqQJC53gKpyN+ob0
         P5+w==
X-Gm-Message-State: AC+VfDyP2exsjg46zloTGOuBzw9QKBH4LhWE4UBDY3kdcBYYqO2rICaq
        afY6vGUA1fxyopRG6AMLxWe2JsoALWkIvdEWLDg=
X-Google-Smtp-Source: ACHHUZ67/FhEiGui4khV15HtrKuQbRNbJ3wk4wnpBI377nKp9v2/95FfYMrHMF6HJ9iMcA61OBTtybgJyICWz4PsBFI=
X-Received: by 2002:a17:903:247:b0:1ab:16cd:51a3 with SMTP id
 j7-20020a170903024700b001ab16cd51a3mr19228370plh.10.1683651874673; Tue, 09
 May 2023 10:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030653.039732630@linuxfoundation.org>
In-Reply-To: <20230509030653.039732630@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 9 May 2023 10:04:23 -0700
Message-ID: <CAJq+SaCr5qarZJPRdFkWFXppoAPx4KFEwOKiVm8rSkZ53vseNQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/610] 6.1.28-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 6.1.28 release.
> There are 610 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.28-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
