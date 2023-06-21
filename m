Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF92673784E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjFUAhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFUAhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:37:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBD0E65;
        Tue, 20 Jun 2023 17:37:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b543f7e53aso33727225ad.1;
        Tue, 20 Jun 2023 17:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687307871; x=1689899871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8k3mdQd8K4USROd4w8UPhJY2YwWLEAlecS6pG0RGVs=;
        b=kwf/gC6mLX5KQYsz7kvzn1TS/gHOjeUK1EZeQnJwTSb0i+VN5zrBqU5b1JXi3rmQKK
         e0rE72YyERLEhi8tNFKfMJxZDGdjtqIwXAB/29iGverXyu0HuGWXwMj1ogWZWIAvQD/M
         w/Zn61gbn/H6E5B9kERWixe1H69dzdRPcXWKEm3PvW0o3zGHnRQndwlsCtlqdXpsHRKJ
         L9LSIWF3ZeUqfPteTkhjVBp/NZY5nSeaxPNI69UUY8zZtrdXDzcJumO7lT7TU387vPTL
         SyThrx/BVWC/ZIp9QRG6ST4Sg4ya95Xreej/e0pplxB6UgOBgqPJwFhejiUVQB6VUNxq
         2MDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687307871; x=1689899871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8k3mdQd8K4USROd4w8UPhJY2YwWLEAlecS6pG0RGVs=;
        b=BYNS2Eyb0ZSawj+ZhSJYQzvjITEgGIAGSBtEuMcUxfkJCze0IpRiWFuMIs2reCtR1Y
         LK211gvN1a7eiCmsqv13VJ8xEOP3fX80K8XaVRBuyJemAPyNHv5zV7pAVdtRpIjbC2Os
         90uFD5Ek44Uvicl54qjapiziCKweqJzWji+CNYdZdBksYdNjfrba/8RLcVAADYTbTpmx
         9rpabe4HggkeYHuBVSpRAtm8o9m+B6oSDycr7SaVeoV/WC5q4sbQ1xcqRVe5GtUrnrRE
         1rAAZI3TuDXRBojNAKRVP5hXRSvzHMEc3etID63/ozUzwfC+dEBOu1PlYVC0jdZc3RGA
         qM4Q==
X-Gm-Message-State: AC+VfDy7/GRwfvvwru9VFcKICzcVvEIZugJpjN3dfgWUzeRhNxrbYddC
        B61xFvlWrJ9tt1KHE7yPOLE=
X-Google-Smtp-Source: ACHHUZ6u2x6A3/oe3ZEQbeVpQa39a7cqvoctDIYRjmqTifSWDRePMgmrRczhdpUwDjLMPFDfrRimoA==
X-Received: by 2002:a17:902:a3cc:b0:1b3:ee49:8334 with SMTP id q12-20020a170902a3cc00b001b3ee498334mr10720833plb.52.1687307871466;
        Tue, 20 Jun 2023 17:37:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jd10-20020a170903260a00b001b562175158sm2135786plb.244.2023.06.20.17.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 17:37:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Jun 2023 17:37:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 4.19 00/49] 4.19.287-rc1 review
Message-ID: <4d153532-0664-47f3-95a0-115c94e983f5@roeck-us.net>
References: <20230619102129.856988902@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 12:29:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.287 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 431 pass: 431 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
