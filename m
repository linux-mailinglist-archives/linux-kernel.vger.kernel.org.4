Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5190C652AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 02:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiLUBTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 20:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiLUBTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 20:19:01 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6C462C5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:19:00 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n3so9667800pfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bAITO3y/ju2E/+p9GTxr9wsk3UMDCPB8LrqMLu/DxU4=;
        b=aaR0yhDR1arVKz9UQcdkfu1yGghKA2d2lXbz/Cn/BqodlUjjfi3OCW26wJtpzDeGk3
         bCaPIfQfvFQl2mTdqe8hv9EV8QenxNPJ4/R6cYOX+ukofz46aSIxI+zoiAKqJTkKy+Zt
         RuX+ycRwOEPUOKg4nHusyucYQIdjA07axDoFxzJF01glILrSPMhaHlpI1pFaHRfgZQfg
         xh2geX9EOJ2ad93Sdq9+NLZo3afz9NB4MbOiguMi/vInckRPFZadMGZhhGivuxWDI6Oe
         otblobrKwemL8pruCySEOPyagZrZDEMzLY8Yyeo5lkHiuD4JkLNIk0Xujb7K0eDSQp3p
         77YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAITO3y/ju2E/+p9GTxr9wsk3UMDCPB8LrqMLu/DxU4=;
        b=5gQ7V2dDcJcwU5k5iZkuusSI3T3edFIJVkckOdIy+w97V1bgyR8ITXvtFbayvUnVUR
         3niXOimwqdpcMqz3XCzZztmm13ffoGf0t6Z6eNmHPzZTtJe/PHg8p6Maose3sOAviOzk
         JMutBnPTxoFhJkMHDvhl3qLvKaY1q+8Utjx7quz1K5EEryZVedOIzvZBmd7uYMMohLyD
         0EQcYU236CIRk7AAXEJ2LEtAdEu2Qw+rZger13Gl9AUuope/f1dQpCZ8fGzG7kT+L5rO
         apPzKoKEJ9XW3/DZrirYSpO3520qZf67auW9fcxAi3nAnXbQkiWWJ20locUpenDGyKtO
         Nirg==
X-Gm-Message-State: AFqh2koxT6GQ7yD3qdJsxa0C64Shx8hFib0s347aJeb14JbnrhBaj7Vk
        l+Os+jCbYTWpZvun7PGFXHNXyi/hwtQqeSRlnFxiNg==
X-Google-Smtp-Source: AMrXdXuQj6iDU7ydKDNX2WXWS08ZB8AjLM2GmHfB3McWYiawQPSS9mrhaOw5Fb4C64BzytTsKhuh4PfhqlYK1PRCf60=
X-Received: by 2002:aa7:8887:0:b0:57f:fc4d:f773 with SMTP id
 z7-20020aa78887000000b0057ffc4df773mr21306pfe.3.1671585540202; Tue, 20 Dec
 2022 17:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20221219182940.739981110@linuxfoundation.org>
In-Reply-To: <20221219182940.739981110@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Tue, 20 Dec 2022 20:18:49 -0500
Message-ID: <CA+pv=HPtWrkHhjNu77bxHzZ1xBJ_1vhocbiQYuaNHnyF9ZQm2Q@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/17] 5.15.85-rc1 review
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

On Mon, Dec 19, 2022 at 2:27 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.85 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Dec 2022 18:29:31 +0000.
> Anything received after that time might be too late.

Hi,
Compiled and tested on my x86_64 test systems, no errors or
regressions to report.

Tested-by: Slade Watkins <srw@sladewatkins.net>

-- Slade
