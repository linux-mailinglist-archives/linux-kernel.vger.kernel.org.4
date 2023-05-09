Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6105F6FCC51
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjEIRHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbjEIRGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:06:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910737689;
        Tue,  9 May 2023 10:04:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-643990c5373so6015211b3a.1;
        Tue, 09 May 2023 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683651822; x=1686243822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aQVqoDuYiadvLKIDWNHU9bvAIHfwA741Xo32NGJHuhA=;
        b=HronIf/B3jRa3EQ7+UrJchlxryWkOmAVtFa6NQDDU5aO/EXIC9Db5Dz6Vk16j1lN2e
         u/2yi/lV5GvIezLePpSS/io+oo9FCSE/jfwuUhtXVV0WyKq+9acSXtak+9CvqTxgXMCy
         jDlXm7vlSUE4lx2pYpuxJW9tFYrTPI4oe5v+vzGCkQsi9zktitU3U0RUzWHUwWDxou9C
         8wVDX0E6n797bqCdVasPPmpDKqw92YliMEbY7ojO8cwigOYTbKhgnGD+kI698Riw3CXF
         6ob1fX+polBN5tsDqmTNejdmTXw5XveWH6S29cRJxexmpcd31E/cxM/sZGD5kDV8ICd8
         rulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651822; x=1686243822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQVqoDuYiadvLKIDWNHU9bvAIHfwA741Xo32NGJHuhA=;
        b=Ghj5PzWkoVYmAS6CcVp0k3ZKANxY16Qn1+Bze5Rmvnw/efZxAMxAnkwLc0WlAyzxEi
         02blJ7Mfp+cL4S5FbBiRZLccw6d+vTLRjKqi2QJAVBgS/4DzkRX6TH6z9IfigMA2p/FK
         C0CyyHvrjW8fn394VTCeA7myX2VZattroARDwCu8pnAisY6mgLcU2rFgDzAaWLGHwxqN
         TFl9kkYf/zu1lultEtDZz7dqwDPzoz1WBmLIw33bWsViIf0SgtN6Rc9U+896hR2F+dS+
         ssB5H+jVMP2FZmjdgtb/n+SShgHzH0oC0w8uY9RUWNjduTcGJEF0Ni3V+bCNew7nZFad
         s1Dw==
X-Gm-Message-State: AC+VfDxCC0617uNSq7NHVoT/WDWNwkJrQqmiV7SDYFaZVNA9lvxjsZY6
        /e1nnaPhG61TMcuMoff5i2LYK3msNVVDPH1iBsY=
X-Google-Smtp-Source: ACHHUZ7dxAWTjtm7E9vWztOYHrkAC3+lQLKpXAWrh894XjXoT0DY0kVTIYcd5lbLibLbGAfpZrnSjgo/rGj+eKJN4Bo=
X-Received: by 2002:a05:6a20:6a04:b0:ff:6979:ebc0 with SMTP id
 p4-20020a056a206a0400b000ff6979ebc0mr15733360pzk.50.1683651822281; Tue, 09
 May 2023 10:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030611.521807993@linuxfoundation.org>
In-Reply-To: <20230509030611.521807993@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 9 May 2023 10:03:31 -0700
Message-ID: <CAJq+SaC9ctdNzvupkZJTFpTy-Gx2Sgkn5r=r9+R2SHmR1MziEw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
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

> This is the start of the stable review cycle for the 5.15.111 release.
> There are 370 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.111-rc2.gz
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
