Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006E9652AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 02:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiLUBPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 20:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLUBPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 20:15:39 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD024DFDC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:15:38 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so593267pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ecA2KXfjiKAstKqFn0Kl2sfLSWuL9dSPL6PdGndRJc=;
        b=HLhMHTdtTaY+RzmPvx3EykrQea2pY8Rqo0th90WsLsGFLpc0t1uVM8lpLvzai3MiaM
         A5Z3lIQWq/k++BdsWInnJlXL6IkvDxqoVBR9yuwpCksa+EDOFoySF6sOpeXyZJhMqXIL
         7/GWSeWENTy3TDSqvvCHd/IHuKS8PGsEcYj5aP7xlPv9rGTjvwnUZr3i+MNiBxMcgo1C
         /xoThY/k/NeSRI3W3yTpNnMkXOg4wLOAB0q1u+GLeArOyG3rsB4qLn47/Wqcnje+yr/e
         liku4EaRFuEA4Zuj/SwnXZRSsi/Jp+mgDirEOUDMgtZdZQNuqjGMx7R8n0eX9zFsoJiC
         byaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ecA2KXfjiKAstKqFn0Kl2sfLSWuL9dSPL6PdGndRJc=;
        b=hHZqr2ON2qK0VD4X0OIvDNG9gwFZMbpgZvLxyPNDirRuAEK4vTWwvCRW9U5JNoH276
         Z2KT0tBRhBSv8XPSo/yiIjPEDqJOTirTuEN+up+SAOl13zRIAcHnrQEUQGsd3cwXSfZ7
         pw3kfdFS8KvJ0czPwU04VUtAJ3wxgw/ShNSxlnV9/4rfS2L0s2ZmtHPvSNZWDgCSb1Pt
         IPoZYBFyM+G8WscMS8VvL/v5pIJeOVKRQohCcSnvaZ43FfFMk3OVpIoFB9aVHP1lgKFE
         6QCieNUVaawp1PNVsLbwBY5qfP3BxZ6SEqUm7/B3MasGWPE1WcpBmNjG3sZBJUj2igHW
         pACw==
X-Gm-Message-State: AFqh2kptPcgt01tsoYOFFUx0off6q2thAJUJvd+vN5WR3i28nE/noX0/
        Oga2Hg8dd7aVEcvogEYN2N/LE5Kzo4agfAlmL98QOA==
X-Google-Smtp-Source: AMrXdXsOZC8o3lMenbRvAifZAxKpZqUVvFbfth8W2cnPbqoe6AHhagMGsxRpAaMf3Lvn469gMvUswW7LwzTYnvEZLLY=
X-Received: by 2002:a17:90a:af91:b0:219:536b:41ef with SMTP id
 w17-20020a17090aaf9100b00219536b41efmr15187pjq.71.1671585338288; Tue, 20 Dec
 2022 17:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20221219182940.701087296@linuxfoundation.org> <CA+pv=HMdmd5E=yH-1_dbF316EQ=KkriAPgLg8e+7m6wbinchaQ@mail.gmail.com>
In-Reply-To: <CA+pv=HMdmd5E=yH-1_dbF316EQ=KkriAPgLg8e+7m6wbinchaQ@mail.gmail.com>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Tue, 20 Dec 2022 20:15:27 -0500
Message-ID: <CA+pv=HMJ1K5Hhho7FgsGEf=7i2ZROT6y8X9Q6m1LXSyxj9h4Qw@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/18] 5.10.161-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, rwarsow@gmx.de
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

On Mon, Dec 19, 2022 at 5:36 PM Slade Watkins <srw@sladewatkins.net> wrote:
>
> On Mon, Dec 19, 2022 at 2:28 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.10.161 release.
> > There are 18 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 21 Dec 2022 18:29:31 +0000.
> > Anything received after that time might be too late.
>

Hi,
I noticed that the original message was missing my Tested-by...

> Compiled and tested on my x86_64 test systems, no errors or
> regressions to report.

Same applies.

Tested-by: Slade Watkins <srw@sladewatkins.net>

Sorry,
-- Slade
(via his corrected script)
