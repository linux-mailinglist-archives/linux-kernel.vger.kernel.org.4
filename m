Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A4C64A8A7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiLLUV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiLLUVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:21:24 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336A12669
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:21:22 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u5so980288pjy.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+2Gol/W/vrCkBFnXmVYWrTmzG1dFrYwfn0LfkKp3QVw=;
        b=dz3c2UhZUInkpt3Imw6LrTTI/SKv2nCAj1lwVwpseUjw8FiPOFPPhk/FLhS4g4+1eV
         b/cZ2MG3Gd3VWU/JiDY8DdvNHTjxLqVoYa7ZJ4U+4wATTOG8N+b4ySv97ZvlUE1/IPKO
         hGOsT8Nmqm8GlhZF2QFtdKoL8Az0Q0Axvm2gpsP51BIJSwYtprj1KyMeyZI/0o8mnltc
         WZU09UAaCqRV45FpMK+MyRCAaMwgakEaILjPY4YA0k0ZP6vRlrIIoma0mRbGL0PVkJho
         6AfkGV6JoHpYRtiuLcgu02w6/yfZ5GApRHm/VudMhbA7B++rYgx2NGKFmYnciUlI5C98
         k0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2Gol/W/vrCkBFnXmVYWrTmzG1dFrYwfn0LfkKp3QVw=;
        b=oCQRa9IgdYTOeJXURwcRqL0vlbnO+90q2XT/2nnoRxCr5iXjPMkLgJSokUL/1quQm+
         tKwamYhSXgnmAiJl8NMG3TySZEcaXxXzcvepq3zoGSD5fn+QzgVv93vaJPUkja2xQiat
         p2MYqJGvS2HQs5G5RJg3Ht1nBKPpM2+ACb+zcV0t32+V4K5P4foo1/TFGacIkPVXG02w
         Nf1RoaS7rdp8X0CugJ0A3GTqr0nc/LFiYLLumwvI/7o0GJUiIYtbF5TtM/nFHIb9w2r1
         iCK0t5ZFG7Wt7myQ6FzBcIcDPaZHOLRYlj2M/JCWa6NI5cwOgNV+PJhrclEk181eJAWJ
         Ezrg==
X-Gm-Message-State: ANoB5pm80/MlalzyiaBON6cGcFK51R8fne8eS4HD/XYPYgw5F6uKCd3+
        jYWTBlsBshCjV3djbMooP9fb67mJpQ+4I0Ya7o7p2Q==
X-Google-Smtp-Source: AA0mqf5EDTFf7Lta+JlVNQNOYeNcWvG89NdL/KjJDks+33xbbjl98uIFJc4VZhz50PLmcRGlQodl9nipFN5akmcP3HI=
X-Received: by 2002:a17:90a:740f:b0:218:fb5c:a762 with SMTP id
 a15-20020a17090a740f00b00218fb5ca762mr31716pjg.241.1670876481712; Mon, 12 Dec
 2022 12:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20221212130909.943483205@linuxfoundation.org>
In-Reply-To: <20221212130909.943483205@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Mon, 12 Dec 2022 15:21:10 -0500
Message-ID: <CA+pv=HOANBfmAqBLi4wyeejs0W1BsZtbhcHqsNmhs2WA3YxGzQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/31] 4.9.336-rc1 review
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

On Mon, Dec 12, 2022 at 8:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.336 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Dec 2022 13:08:57 +0000.
> Anything received after that time might be too late.

4.9.336-rc1 compiled and booted on x86_64 test systems, no errors or
regressions.

Yours,
-- Slade
