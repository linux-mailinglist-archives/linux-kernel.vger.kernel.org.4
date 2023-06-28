Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B95D741755
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjF1RiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjF1Rhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:37:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8342116;
        Wed, 28 Jun 2023 10:37:40 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso4821768a12.1;
        Wed, 28 Jun 2023 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687973860; x=1690565860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1yBs5D4wuN/Qn3dTB04DQldh1q8a2hbv1sJCNrinerQ=;
        b=HWp/WrUb9iVyx1eK+ZvTzvrWC+7UTUHapR4hQT7zeei3AcUJVeobpacj+UcELGoHIV
         iwqWGobm09SdUbNSxdLhA+BwcZgioTuxUvKzRK8jbhBks1fVebyHZTlAezIhJtSE3Yjl
         vi161Svqtqi+l0WhJ29TqvqGdM9xpFcEsRYnEgc1g1XO+B7NHJws9Q7DAuHeVw+hBrT7
         3xFAhzgLpXIxmJrD3pbfGXUS28FWSdXfomwDE3cCU1MS6fLdK5zN0/LT9wKGbUDHQ9cI
         mfoYni20HXEAD1wvfcN3xd7QdIWctN3md/tiUNnIvohpOZ2bW9ATI4LSr7bCgfOW3gE7
         aoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973860; x=1690565860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yBs5D4wuN/Qn3dTB04DQldh1q8a2hbv1sJCNrinerQ=;
        b=bdm0hwvkxSA5ftH9tFxQ6IKcf7xwd6R81Ku4pSIvt5OPyECL/rnNHAMRMWz829jIWA
         c81eej2hL+ai+x6sSNx0vin6PVSdRqcihhGZYiOoE3ZaTEwz7uPaeQKSiZ01YApCOCfz
         HYzQ8IuCAzCufz+ShQBrGhWzHlIummbdIwo9i72h62nmnlTDh3kB9QB23sTf3cQhw1Hq
         BGpHhZHmUGM/0CSX84P+S1ba0C4nB7r9wPV/Yjb74wBsbOnkeSDmIWnCEGFZ3JUJqzjo
         eW7U/Ty+ZUuZigJhZ9BNC/ayw2HMrTGD+4I8Ov9eEkfUl/vNeUFOxw+ZYbvY21bTPPnS
         PJcw==
X-Gm-Message-State: AC+VfDwvqBMce1/YBXoMWo2IZOZEWfh6P0bEE5BORy/UFSOg/ibLmyBi
        3BeBoSXYjDDdnVAt+ylKTuhHkNsESQ7kCddfMkk=
X-Google-Smtp-Source: ACHHUZ4PYVYUjZfEER0mnrZe93juN7xF+PBfEMEb/F1Ax7S/khFtg1eYQxso9QE6WkFA9CfWoXK8t6ANuA3XfJyXa48=
X-Received: by 2002:a17:90b:4d83:b0:263:4164:dfba with SMTP id
 oj3-20020a17090b4d8300b002634164dfbamr2118362pjb.6.1687973859868; Wed, 28 Jun
 2023 10:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180744.453069285@linuxfoundation.org>
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Wed, 28 Jun 2023 10:37:28 -0700
Message-ID: <CAJq+SaDykUQdMHsCvevXoHA18xGgqU=xhj6BBR64T8_H5M+0pg@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/81] 5.10.186-rc1 review
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

> This is the start of the stable review cycle for the 5.10.186 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.186-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
