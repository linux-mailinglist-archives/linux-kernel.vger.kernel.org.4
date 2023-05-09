Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE916FCC4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjEIRGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjEIRGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:06:16 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1EFDC46;
        Tue,  9 May 2023 10:03:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-52079a12451so4344289a12.3;
        Tue, 09 May 2023 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683651778; x=1686243778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dzB6zXeLLyFlCHebfFpxWpNyEmoL6v/kG0Zxv4l8LgA=;
        b=mutBSZXL9ybuZwzsxpgW8DoesXa5uJk4VDj6zD2pz9V9wTs0Lcn8DXS/EZnEeufX3V
         truznYxiMZPv9kYK3N7iOyAgOWuK1LtrCrSxxK/S8F8vETAuw4p/cPn28WoKfmcZEl8W
         fHa2PtqTTmh6JRVc9nPpUZUCuqlwdp5n9o3VOh9AxjyEk9JZsXJXQdAyR5jy7RKSl33t
         4VMzPtIBQpu0mi5SjFq+oFhHyvU/0IrLPCYx+x9U+G/yGgHi/TEsgcrYiQ/RRBy+GKlL
         7qJfma0rxZbOWyHm8ugpP+DTkh8PCpl8o+fvGBROCEDgjPjt0nNFBl6bZZaOlhul6DHM
         A3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651778; x=1686243778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzB6zXeLLyFlCHebfFpxWpNyEmoL6v/kG0Zxv4l8LgA=;
        b=f0NqOzaNvwl+qd2P0YeZdoqjeBpAdlaHVQPTqC0O549Q0uhHNXPNtJ1X9K/SABSPvc
         VMYsN3iLQ1PmqcUAVgXGyMkLYM7IhjRIX6Yv1lriGkUN2M/KcOHXw9hLoDq8vZ08AMEK
         UoB+BX6mhMJ9Qh81/MZubIwhOQmWAALnkbTUhN/p3wg2n3MCekb7krttwTneLRxINblW
         PgZKakN55qbOnwyJOStunSAX/AI1B5ecgd7P71+8pQ8kOcfQBcrhKgHxscTls+pJ32e3
         6LHpLCNHK6i8IqMai0fVoXDK5S+Hcn7I9l30vR75NJJ3Q6o2VY/cAyizFc8y2xzn4iah
         o3Bg==
X-Gm-Message-State: AC+VfDxXiJtd4zjVG1angBWVlhx09eu7Tcp21WmKQXQ2lW+KaoebiFH7
        BXROUWNNPM28HufhQYibntUnbkk4gfNtRiZBVhc=
X-Google-Smtp-Source: ACHHUZ46/Bn1TTRRMmux+tpvAHmZpthxAfGAEUENhehYrsXm+f+TSVdLGdpFquvt/x2zOEfW9F0ybEuGDFUX5s1S3Gg=
X-Received: by 2002:a17:90b:4b4a:b0:24e:3316:bb99 with SMTP id
 mi10-20020a17090b4b4a00b0024e3316bb99mr14471863pjb.5.1683651777920; Tue, 09
 May 2023 10:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230508094421.513073170@linuxfoundation.org>
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 9 May 2023 10:02:46 -0700
Message-ID: <CAJq+SaBaBEU63Ch1shuvK8k_nifjPN4M0BCc5WB55KKYqJUV7w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/611] 6.1.28-rc1 review
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
> There are 611 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 May 2023 09:42:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.28-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks
