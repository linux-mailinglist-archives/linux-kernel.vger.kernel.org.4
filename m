Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6876219B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiKHQmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiKHQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:42:00 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFE85654F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:41:59 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id g127so18033225ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 08:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JD3PRe74QR2mJ+orp5KCKp7oflDuwpBWOjw8obsvdQc=;
        b=ezAdGSbLm5hnxH9a3UKs0v0CGNhaTm5NwZtDjS9EEqbMnkp1Y2iUV48IxyEfmZ+0Kx
         unxFChxpGKrMIO/AKuVpdPRMAOH4GAvvbcqOl2jUOyIhcD0e+2cXmwK836XVVX2abv2I
         DDn3JnLzfMjf0qZJui350cU5ptyGDxUq2cA1/rnwTac3XS4TbsbX9r7S3lYSoSRJcblK
         divx9A5gGxFXwdlV3pQj0M3zehum+TE28Ws14aurCYj2DL903dBJ6dujNz4nMLYfgKgQ
         8U1AKAlyaWjm/nI2lZlnL6DYCTFMALUWDcKVrQthayTqYPSYWiRh+8HOUpCN4JMHDJGb
         fWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JD3PRe74QR2mJ+orp5KCKp7oflDuwpBWOjw8obsvdQc=;
        b=r7w5FJWlkhxQKbu3JLLfCsKaNjkIAkz7wO4W7Vl/G/uo0iaJZs/AQdrANHkuBQ+cZo
         h0fyurYQLJ8YPR3t2me9wiNPCrnTDo6hlXPIZMNysDMSJY3BoyQERnUQeUry0ASY7NL/
         ccsK+359HdsSyRkiABU99Fk7dBEMHhCgtBY4y2YC10BxgjjiuXUcQprgqGqnfSCwIpf6
         0RuUmiDPerwJKgX1PaSMFCYo3ohnzL3fEDO768t0wQjrgkxFDpPBW4i8I3TtLkrn9G26
         pWUEh+ibMxmviKY9+QZVVMyGlAxHgdNSIVWhtkjusI0NJ+e7s4nGRjoylbrQhsLEctoS
         KfDg==
X-Gm-Message-State: ACrzQf1RhKSF4ZxWwqoSe0jMme8v6XQF8Qs/+AlrvZHBM547nMk+FQJu
        gH1UPGHtlGkTZNZCJ+ZXNeHqfi1vwBd1qlcAEVCTkA==
X-Google-Smtp-Source: AMsMyM7b5keHpnrPp6sbB8q5Ph5lxpcIatBUP8MgjCIRGloZ+3MsJQch3obqOYW8dlqcALhXh82dmnZYmZrU003kRTI=
X-Received: by 2002:a05:6902:722:b0:6ca:260e:cc5 with SMTP id
 l2-20020a056902072200b006ca260e0cc5mr57709150ybt.336.1667925718127; Tue, 08
 Nov 2022 08:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20221108133340.718216105@linuxfoundation.org>
In-Reply-To: <20221108133340.718216105@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Nov 2022 22:11:46 +0530
Message-ID: <CA+G9fYtSBS77MiW99t7HGyBPnnpxyu-6L3HUPsA+pXd_fkZRVg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/118] 5.10.154-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 at 19:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.154 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Nov 2022 13:33:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.154-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As other reported LKFT also noticed arm64 build failures.

Error: /builds/linux/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:1296.24-25
syntax error
FATAL ERROR: Unable to parse input tree
make[3]: *** [scripts/Makefile.lib:326:
arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb] Error 1
Error: /builds/linux/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi:1296.24-25
syntax error
FATAL ERROR: Unable to parse input tree

URL:
https://builds.tuxbuild.com/2HGddiHMonVVZRsckAWkubW4tdh/

- Naresh
