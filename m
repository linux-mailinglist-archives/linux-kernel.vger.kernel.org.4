Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FE6723214
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjFEVQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjFEVQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:16:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7112B10B;
        Mon,  5 Jun 2023 14:16:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-256422ad25dso2412552a91.0;
        Mon, 05 Jun 2023 14:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685999770; x=1688591770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pgABzOJPJ5VIj4UQYjPtZhIHLv/LvJQylDwcub2S5pU=;
        b=NDEefdGqTeKN0VC0nVdBRObxZBclc8lfeYbbNMC5GVI5QfRrLVsk2VstFZXB6x9Qax
         1tfj5Tc7k067Ym30bUuSAL9cTG9J6DGO/XG28pO0o6sU+zE3gfmgfAOFZFAR0HtfTPxe
         WkMARgoT1VI7LgZDdRlHTb9Fw9rL39+GWvpsK/qH6rsNcF7v/QEA48HsPQ8oLeq54aD+
         PTEYEuOWBYxz1dDHA2XQwfwgETw2P/OzhLpHiNgyUZvWE/2bhseAupxSLPZLSHMD2jfb
         Uo/se/6iBxktgiORd8b/+wienQArE0DMPsRF5xP3PoXkU71PL95E0/y684Jg6Df6SBOv
         zqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685999770; x=1688591770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgABzOJPJ5VIj4UQYjPtZhIHLv/LvJQylDwcub2S5pU=;
        b=DoTef/Q838Zw0MnTc1WPW4x8LtgU1HYV9uxGTZ6rpwNitnHI7mYsNiBvirnLfq3/PP
         qh+w8Fdsy9KZdyhiKNYwe64bnibPofC8ALisyPhTDhZz40EzA8x7H+Be8IwqXOWrVGFq
         ux3kAcZ9QNx+6YHAwTgNH790JUomMLX3iBZKWZrFg4aRP0HCdnsG0om9iBqS6q6qefG6
         JYBTIHX6YDhzNFnrmyFje6vMVELVgaKPX9HB0SWQpIJCGHrn3WPOxQ0BAUJdu0mIBi6v
         wUsdtQcNWkBu5cUmbAEFWbFOsiYmymlEJkc8/1t41YsUZthNOdw/LeGRFAIwVQSVioef
         WO0A==
X-Gm-Message-State: AC+VfDyqTmu+3imQYi+LQ11WrVhf6hsnzxHkZjWHQOINvTBtl3XrOcOB
        mgTplSOeJvfUrs1oeiKhwv0riYE5oauXp5k6HYw=
X-Google-Smtp-Source: ACHHUZ4gRcnOB7eeFTHK9+AFV1iotvVJC3lxKfkE/D67ktnXzZGsaN6ap1I2IvSB3gRUYgCA8JtK9+wDW9pXTlLj57k=
X-Received: by 2002:a17:90a:f98f:b0:24b:2fc1:8a9c with SMTP id
 cq15-20020a17090af98f00b0024b2fc18a9cmr3824386pjb.11.1685999770620; Mon, 05
 Jun 2023 14:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230603143543.855276091@linuxfoundation.org>
In-Reply-To: <20230603143543.855276091@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Mon, 5 Jun 2023 14:15:59 -0700
Message-ID: <CAJq+SaC3jGqmM1k2FbpSoe=3uZC5BaO=SPgHW2JuAhxqeLk7ug@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/35] 5.15.115-rc3 review
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

> This is the start of the stable review cycle for the 5.15.115 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 05 Jun 2023 14:35:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.115-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
