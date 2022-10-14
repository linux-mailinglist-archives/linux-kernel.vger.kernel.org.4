Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB645FF2FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJNR3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJNR3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:29:46 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B671A3B7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:29:38 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 128so4894057pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D0te2oWDw1wzOI/Tpg4a39qhOqMmTSOu+4eexqc84Us=;
        b=RcY+BOXpgQlAp/1vCnAGZwqGTc6rvBK9SRQ7QSVPc4oR0PBKaw6ivtzR2xNPi6df/6
         CwMTZeCeKe76jl4J3G6e3xQ5TuGUKMnH5pDVob+EpSW8X1NHyP6OWl6v+3Z9XsllYld3
         u6CVceT2NaPwZz2ef8e0gThyQiiDkafB2F1OPZ/MdF6kUwLUm0cOVE+d2gSf59yJhL+i
         25A1aRtVBFjRQ3AvM8AcJLOHEuJ2LfzWstBnfnpWd7ltkCji6FLIP9q0VDczOGkYUeTR
         HRPIBx7ZxaeKWaLKT5F4qZGGF4AhPwmdnGQE6yqPeHD5jRjkab++WqKkz7FDTEQHhUTe
         4BQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0te2oWDw1wzOI/Tpg4a39qhOqMmTSOu+4eexqc84Us=;
        b=HbF/qjriKIKoSYMkovh69fF9tMigEO+vKuIc4ZcApjxOozOKcPljA+wHKxnlXGqSvb
         4CjEz9JkFIfTn6v8XityEaqYlv8kspCtlO90DU9lWEX/GjeshGyv7JSdbtsz8YNSKmYp
         uyNc1NesSDzyXhSmbImF4EnXlsHLgNmixdV1DH1XA44077ji9YafSKxB8zLl4eFYfT8D
         ZYgopxPpjbB9uqb2r1PiQjykjg+YvkZ8lbTsAaeJ+k7sm9iOOa72XqfN+b6jhsMh9ZVa
         62xuvo4tbxUCbOEOuUfoEIxTd49Go7wC/DXVsJ4SIvN3WFiS+qjzQ6bfFveAyXDuYzxE
         QEqg==
X-Gm-Message-State: ACrzQf0JJkyBh+nHTRiQfGIAjlthN9fKMkp0Nt5Sx732wKqSN97f0GuL
        sYgpOMb991raftZmTQraHxuV6lzXUlB+F0ZQJRNRoKbyi0Pt6EJzv24=
X-Google-Smtp-Source: AMsMyM7jSh3WjaSdEFoy56KJr2Ezfo5c1wOt66wughISVt6a7ISKC4K1HhNLBGR4RtLz7OWZF4UJlGjGKJMG6hSLRnc=
X-Received: by 2002:a05:6a00:8d0:b0:53b:2cbd:fab6 with SMTP id
 s16-20020a056a0008d000b0053b2cbdfab6mr6268943pfu.3.1665768578194; Fri, 14 Oct
 2022 10:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221013175147.337501757@linuxfoundation.org>
In-Reply-To: <20221013175147.337501757@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Fri, 14 Oct 2022 13:29:26 -0400
Message-ID: <CA+pv=HMiD3-nepe6EL=Zsq8jSgHw5b1ot6Czvs960J3KfjDrbw@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/54] 5.10.148-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 1:55 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.148 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Oct 2022 17:51:33 +0000.
> Anything received after that time might be too late.

5.10.148-rc1 compiled and booted on my x86_64 test system. No errors
or regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

Thanks,
-srw
