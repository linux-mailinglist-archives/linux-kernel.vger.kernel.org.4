Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D533F741757
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjF1Ri2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjF1RiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:38:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BB22102;
        Wed, 28 Jun 2023 10:38:24 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-54f75f85a17so3391728a12.0;
        Wed, 28 Jun 2023 10:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687973904; x=1690565904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7FWhZzUWQQi1tn9CDiAjHRiSjyYdxBIHiisyfcuALnk=;
        b=MKU6TYNb60d5i/7SVDVRLeUfRY5xkQfoHN3je9GGJ1kLgOONhg1vwK7rV9PQ0Pho6R
         t/UQGvtaeA/2EZEw4H1Q7V9QaacpkK0MsRQY0v1OvzkFiqO5qX5qBM5Bw/R3te6sixRi
         gSdvRGemqrZsHn0U0ABxRljOWfQlUSQAYFwLmiJdbxGpkmXFvIuYNQBEP8fndg637+lC
         zyfvnQfhabeg2XkJfZtIFsIe9f7i16YqTq5SuOIjtIY0W80uNvxSYwQmV9QiCovOAXFQ
         +xI48j4WoS5LRpWQFyKSg4TSxCEuxFPL5K3d7EiYSKmyJRDAlrWwYOYbJz0R0tjPXkGC
         waYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973904; x=1690565904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FWhZzUWQQi1tn9CDiAjHRiSjyYdxBIHiisyfcuALnk=;
        b=dCMPhw1MHaHKMH6A0Z123w6hKJhm/QpZQ/yU+3oheuctVfSrK1mTTWmcsyh6641WJ1
         gv2U2BU+/IennG5r8Q6oz6Yl+5LXcFnS+7tWdoh3bg7wF0y/Lwrfz6AfrfNf92HaF4DO
         6yhqq6NSEoaZIiqEK5ormAnJW3gAXpuXdOVpplqMa4fwD3K6xWHUwVVBJFeD8es/69BX
         klhdYQ2il7buXAH2SqAqS8+wgEyH4EXmKjQiY5P62swKo3yJcXxFZQPc0X4KYR7AERMv
         +V177E48iCvOANLgm4VcPlxz/18QgPDZfMZ7tpVJzQ5qmDuF7jMiAcdy23TLIJ+Yubih
         mtdw==
X-Gm-Message-State: AC+VfDxEkipZjda18pUYHM16ipu1xwik+uADTji79z04AV/qJ3Hy73OE
        t+1pQ8HgvfqxLKrU2OReQM5Hf1punnEojbsli7M=
X-Google-Smtp-Source: ACHHUZ7Ii0hg3v5HpVTrlbUORVopAMTBarNCka+bvhg4JYVWBIFPPqUC7edhH74J7EdiRMFllvEdSJkNNm6CqmOnhls=
X-Received: by 2002:a17:90a:359:b0:262:b22b:8ab5 with SMTP id
 25-20020a17090a035900b00262b22b8ab5mr10233703pjf.17.1687973903727; Wed, 28
 Jun 2023 10:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180805.643662628@linuxfoundation.org>
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Wed, 28 Jun 2023 10:38:12 -0700
Message-ID: <CAJq+SaDkKp7p59WQjHkRNYxaqOkZMy0TMMvXCx1to5vC9zmTUg@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/199] 6.3.10-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
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

> This is the start of the stable review cycle for the 6.3.10 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
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
