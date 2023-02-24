Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EE06A20E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBXRz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBXRzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:55:25 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070051815F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:55:25 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id i3so282572plg.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OYejHnHCd/0NM5wxYlzbguJDabqND0i6mKg9xEzuA74=;
        b=i1dq4emqpx6xG6yMZsrPDX+J8bAjHV7sjol1HOnvBtQMlkFX34sMdYER2riwEoApxM
         K72VY6qoBWVvT7f6HF+cNZcME9+teYLqYhrl7MsdrrDb/hydzsQZF0uJ7oUYbzMKzojJ
         rXRYnWaLiJ5jZ2Lbut3Q/VrgYUxbUGSfsPUcmPiBTKas4N9dien6dxW+QZbrZjldM/OL
         gVUIVDSgG3getHw/VmeXh1ILTHzRvBuae8KBzEpLRVvHJym2X5CsOs18czGuC9iUTcyG
         i1awIYiMc2PFIHTMKlG3BhN3pm/r5okxhwjNRmyM8B69YFEATDXeERn/M8TLylHfHYn7
         M1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYejHnHCd/0NM5wxYlzbguJDabqND0i6mKg9xEzuA74=;
        b=rMYYg6zZIJuAmi8kDBrGRJ630jgcfHCred17qOMO8O6yCoUfZqmM5W8SBCTwUFXBbi
         QdJopXMSu1Ti5vjS+SiM5yz0sMtyPugcZnp/9up2OBxrOBUO/MwYd15YW4XJw7eVvZ0/
         mrWN7LKj6/b/MPwJ6C2fTAk+6vyfGBhjUycYua6pPomGpvgLozarz2PhePXDczM7XRD9
         er1ySz4vl732dxczrRC0Nu/4MUFD/KbJDnAAwuMW0J/wn+YXuclam0hDr4rk152f2QQR
         nPKSzPvB3uNHNR42SCtDrWTMdN8LWzfoagIaqQ+UeNRk9HJkvXw+lgYBWSRopeN9rCnN
         jP6g==
X-Gm-Message-State: AO0yUKUqzMJW0JG/kQizejYBRGF81JDh+AsxAMc1Iv87oxYJiqs24r4R
        o2YQgJYWjuPI582PQJ++pDAcrGnCEDoO4UwnJDWdQw==
X-Google-Smtp-Source: AK7set99bb6Ur8cDdsqPYjrECSI1xBnSAc48RH2LFjf40927rAhzf6Wba3b2MUqRmkdto4EWC/CMiv5lwnJcPJ8di7s=
X-Received: by 2002:a17:90b:374a:b0:237:3d0c:8d58 with SMTP id
 ne10-20020a17090b374a00b002373d0c8d58mr1960736pjb.5.1677261324524; Fri, 24
 Feb 2023 09:55:24 -0800 (PST)
MIME-Version: 1.0
References: <20230223141545.280864003@linuxfoundation.org>
In-Reply-To: <20230223141545.280864003@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Fri, 24 Feb 2023 12:55:12 -0500
Message-ID: <CA+pv=HN5MeWYBVts6GNs6eA2nBYXn3k--m=1imMDvjox4UMnWQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/47] 6.1.14-rc2 review
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

On Thu, Feb 23, 2023 at 9:16 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.14 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 Feb 2023 14:15:30 +0000.
> Anything received after that time might be too late.

6.1.14-rc2 compiled and booted on my x86_64 test system. No errors or
regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

Thanks,
-- Slade
