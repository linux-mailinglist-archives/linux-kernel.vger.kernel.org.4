Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33974652ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 02:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiLUBNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 20:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLUBN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 20:13:26 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AC9A471
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:13:23 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q71so9450890pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I8j9TRWymc2LoH0eKyaoIs9UEkksGnz4z4IEp1BW3rc=;
        b=hjDV0Ac4ho85L/SATVrnhwahrjMc+yi+EKel2PCOPLb84/eYkQkvYkigo2zCbuCBQr
         Qr3V0E1rdjOesLtEzyZ9O9UtmFbS4Z1MAy7zFVaVlsF78dkA7VkiHfhLUpDbxEY8icw3
         fitJKcWFIEyv9KTvAQwacpFOw0IchY3fZxpgYpCEt7+pvTkX34waMaj1TwlU6JO6F9rU
         hGU81NqMke+yzZomf7phHpH11VobXjQOQwYIWLzA95FlnJg/aqz+r4Imr9sD3RJAGrkZ
         pe2qWc4XiEbz7HTG1n5ylkkCrnOu0S5G+9nOwk9ViYzzi39kCfb0LLXErc9rL/MG0Xqh
         3Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8j9TRWymc2LoH0eKyaoIs9UEkksGnz4z4IEp1BW3rc=;
        b=c47bLJ/XXkljdZ87C2ad8I4TI6eklSVd/DpseqMhgD2ozqxu5sYlxLRvvjiUErNDrO
         +++eqt3hZTW5HEggC6h+jO+BdOq4qN+swPeVU6B0iXHE5Lk/0kC5zrtEsTcprOJnqwiJ
         Rm1X/5SRiam46nmVLKGoAhNAvbEio3tsjjESLphuOD8LkfsvFEg5LN2MlTIYKYEpTpTi
         BCwUiVcxCYzW//5wPmIlZukT2tW5X2PRRMg6GAqT8ja+G7ySE4LhY+VbaFHroKnJGv4P
         ETi0vqgQ+XiQejILtQtiVyJncHHytj58EZ/Vp7bM3hLGU0vlt6fCGuOGDwyXOSsLdZ5t
         HhCQ==
X-Gm-Message-State: ANoB5pnPWE8+L0L7bl9kon1kEwr4C712/fMzw573IWTAQXkO0T3TwA5a
        GSWgQcBhh4PYco41LtKb20oLMb3Cmy3nJJm2aP15Ww==
X-Google-Smtp-Source: AA0mqf5Dq4rrq3kxKwTPoA0dfgN01W9r5o0Qnonh1YEBT9OKXCCJjiIlbU87kRlWm2kl8ZHTpnXYHINwH88Hx+j92K4=
X-Received: by 2002:a63:110d:0:b0:46f:6225:c2f9 with SMTP id
 g13-20020a63110d000000b0046f6225c2f9mr87648713pgl.225.1671585203356; Tue, 20
 Dec 2022 17:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20221219182943.395169070@linuxfoundation.org>
In-Reply-To: <20221219182943.395169070@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Tue, 20 Dec 2022 20:13:12 -0500
Message-ID: <CA+pv=HOHmXyiiLPJkcHChGMRnxsCiQV3rY6B0uzRsAe0bwb0Fw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/25] 6.1.1-rc1 review
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

On Mon, Dec 19, 2022 at 2:23 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.1 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Dec 2022 18:29:31 +0000.
> Anything received after that time might be too late.

Hi,
Compiled and tested on my x86_64 test systems, no errors or
regressions to report.

Tested-by: Slade Watkins <srw@sladewatkins.net>

Yours,
-- Slade
