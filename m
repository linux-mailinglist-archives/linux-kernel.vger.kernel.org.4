Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D974D704D61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjEPMGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjEPMGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:06:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C5F4494
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:06:12 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-39415d3526bso2825468b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1684238772; x=1686830772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Ih0ErHlIQ5YrjtNFsDq5EWsjo/4Co+mHOiUsuoIXj8=;
        b=QXRI5Ago1CcQP4kFd3qGyQw6YZ17B5FTy4HUQmbdA3nbAzzV281OfK/oZwb8Unedfk
         ERqrJgyciRBRptaLaVGuEv464Xp+K96hSAGqZMUyMOisTIrq3HNEsQ9kuCdnqe2PPUN3
         Rv9zvmHaqqyeQ2FRqwmh/DZDmh4EcYCFflQCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684238772; x=1686830772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ih0ErHlIQ5YrjtNFsDq5EWsjo/4Co+mHOiUsuoIXj8=;
        b=AhymGYBl31IYwM+aAy6ZW9C1TzgtQeWi8KeYZdFwV+EcKpCA2SWCmAGeKpGqg1PIsC
         9Qzy3eXIKKocXwIvg2pXt0jprxo2fYE8VjoT0DrABa283u5GPTzqgLVThL0XwjX2AcMn
         K5nYrHMFounvm6VS/pfToaiFPV2aMJ9ZobG/459CVTuFiXUv0MqRHGt7mJ1J1FLk6oME
         DZ3dT5SA6JnLws6V2GMZOXyLnD1xmuunXAR1ddrNU0mWTVJAKVh7A6L+sDiWOvgYozZj
         G7pXZ1eNsfHzIOS5kxPgIR2wM51rGnk6oXKqSPpwDHpLA1YhD9AekINjElLDvXKtMw9b
         MmgA==
X-Gm-Message-State: AC+VfDxec7FS4yAuEgZ/9vZFwfhQXHGpkAlCsP1vwQRRvCPTbWD9oMkk
        OOZ8sk/y91B3wPDUWIpeP3Nttw==
X-Google-Smtp-Source: ACHHUZ5pyXTWc3+GB9fGPQkMkajRrD4ybxHoBRoZcZw43/fbR6Vi5t6hm4Cp7MHSlXVnTYJ+pb3XqA==
X-Received: by 2002:a05:6808:6197:b0:394:48c:8495 with SMTP id dn23-20020a056808619700b00394048c8495mr12076658oib.5.1684238771877;
        Tue, 16 May 2023 05:06:11 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id fu24-20020a0568082a7800b0038eeba6fce1sm8130991oib.55.2023.05.16.05.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:06:11 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 16 May 2023 07:06:09 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 000/242] 6.2.16-rc1 review
Message-ID: <ZGNxsdOoy9bwZWIV@fedora64.linuxtx.org>
References: <20230515161721.802179972@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 06:25:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.16 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
