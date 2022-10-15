Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD98C5FF842
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 05:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJODan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 23:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiJODag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 23:30:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5820636DE4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 20:30:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 3so6553081pfw.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 20:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ER8adTwAOMdLu2nq11yXwvX5UbvtwH5jkW2p7zfk5Rg=;
        b=Ys6Os6lFMtFxXLfPMhUKVze/ZWQwXxeCGxwKPSU5Sqk3m1S3nS4/VnVqu5qUW90dqy
         zBzXvd3bfdCKr9IxDSK8Yz7wwAja858gaPkxuXoRTWqlSDB3biWXMSMQeeGwHLTYgJj5
         UxdC2UE0ot970e7cV4mfIZb6WqAqqOvm3uwSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER8adTwAOMdLu2nq11yXwvX5UbvtwH5jkW2p7zfk5Rg=;
        b=3YQ8QuEKtLO+Ln0Up91BWj/3PIzcCAJl64cJkmxqWRDU9NxSinQV+3N4K43E4fN1XN
         UqeR9uivj3Pb4N0d/iWVkWaLP6IH0oe9/7QzmUKRWUCiD7cJ103I0HtWIflyrZJz8iCx
         fqdaCB8xfTg2tRtI3PstvpLI0uWnnF9o7H65EoMNBf+4jPHK8uIz0Vn86VJCybp7jRJ1
         pbKFiHrsI1Muy9AQaJJiQSWTpCuO/dU47bXlktm/ZNnFu85rk6MGIi1Cf1wRbsPzcPPJ
         f2VAfqg5PpydcIDLC7oOWs404aJ/f3Dwp1k6jtSdzcRTQ7vyi6PsIL3SJk554YiS3bor
         ccoQ==
X-Gm-Message-State: ACrzQf2tYfPPAHCq+6v5kOwrUpXakngbERYJg+gRLn2txfq4SGVx9yMw
        bJsB8srZihQ3ymBMEnzYTB58fA==
X-Google-Smtp-Source: AMsMyM61fO7n/3/pxtyjZ17fc6DpQrxi2g8Fs8LAopSZ1XYE6Yo3eZGcXJTx+pMqlLTLfEuuQTAvMA==
X-Received: by 2002:a65:6b81:0:b0:461:4049:7df7 with SMTP id d1-20020a656b81000000b0046140497df7mr945115pgw.593.1665804631835;
        Fri, 14 Oct 2022 20:30:31 -0700 (PDT)
Received: from 90cf639d7f59 ([220.253.112.46])
        by smtp.gmail.com with ESMTPSA id m3-20020a62a203000000b0053e38ac0ff4sm2427921pff.115.2022.10.14.20.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 20:30:30 -0700 (PDT)
Date:   Sat, 15 Oct 2022 03:30:23 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net
Subject: Re: [PATCH 5.10 00/54] 5.10.148-rc1 review
Message-ID: <20221015033023.GA1744407@90cf639d7f59>
References: <20221013175147.337501757@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013175147.337501757@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 07:51:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.148 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Oct 2022 17:51:33 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.10.148-rc1 tested.

Run tested on:
- Intel Skylake x86_64 (nuc6 i5-6260U)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
