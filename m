Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87BF7286B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjFHR5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbjFHR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7000C30E1;
        Thu,  8 Jun 2023 10:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A9A76500E;
        Thu,  8 Jun 2023 17:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9478C433D2;
        Thu,  8 Jun 2023 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686247025;
        bh=FpLokzzvgb8Su1TVOxrVGWWZ4a4F1CNAPWwV5MPS5J8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SG7zVSHd37Cz6pGm5ywhW4tw0tNbaARPlUU962UwZGHDdQ5KaYDk6JfllvULHPKam
         tZ7rwh1uRazx3jVET3lv7jzi8zrJMlMwHGQSz4uNmM1qpaueaVW1eRTtJQ9jl1Kkum
         SkyX+RTGxFqIsSjA2I6W+kVkXnaO10urilaM8YFo=
Date:   Thu, 8 Jun 2023 19:57:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/225] 6.1.33-rc1 review
Message-ID: <2023060848-vice-dismay-a6f2@gregkh>
References: <20230607200913.334991024@linuxfoundation.org>
 <cf6f959e-2885-1e7b-826d-61bff351ff14@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf6f959e-2885-1e7b-826d-61bff351ff14@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 08:08:50AM -0700, Guenter Roeck wrote:
> On 6/7/23 13:13, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.33 release.
> > There are 225 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Failed builds:
> 	loongarch:defconfig
> 	loongarch:allnoconfig
> 	loongarch:tinyconfig
> 	loongarch:allmodconfig
> 
> arch/loongarch/kernel/traps.c: In function 'trap_init':
> arch/loongarch/kernel/traps.c:815:21: error: 'EXCCODE_BCE' undeclared
> 
> EXCCODE_BCE is indeed undeclared in v6.1.y.
> 
> Commit 'LoongArch: Relay BCE exceptions to userland as SIGSEGV with si_code=SEGV_BNDERR'
> is not marked Fixes: or stable: and should arguably not have been backported.
> 
> The same problem affects 6.3.

Thanks, I'll go drop this from both trees and push out -rc2 releases.

greg k-h
