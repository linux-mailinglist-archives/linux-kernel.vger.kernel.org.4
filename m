Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E3C6FD870
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbjEJHn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbjEJHn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6911726A2;
        Wed, 10 May 2023 00:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6E8763B27;
        Wed, 10 May 2023 07:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2B9C433D2;
        Wed, 10 May 2023 07:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683704625;
        bh=HGDgcnUYhuIGRYcbgZbIP2n2DCbFNR8IlInvEEoKZEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y6dwyEZ3E0GoHYZI6eOkx9WSho49HLVb7DsbJwS8aPgpccoXxJPY9vjcl6uEi3dEf
         2ixPd+iQ+TqAVvEbiWObhcwZ5M3py+gs2kvl9aKalr7KnNtfKsrMpbC0MQttNXPypu
         HHCBEKySikrHu5DtgFeu+y6cIW3ZsXVd8u9xduqo=
Date:   Wed, 10 May 2023 09:43:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
Message-ID: <2023051035-monitor-sandy-2a5b@gregkh>
References: <20230509030611.521807993@linuxfoundation.org>
 <863a112f-f4a4-d580-9687-f6214d555939@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <863a112f-f4a4-d580-9687-f6214d555939@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 09:12:33AM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 08/05/23 21:26, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.111 release.
> > There are 370 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.111-rc2.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> New warnings are introduced for Arm, PowerPC, RISC-V:
> 
>   /builds/linux/kernel/sched/debug.c: In function 'print_cfs_group_stats':
>   /builds/linux/kernel/sched/debug.c:465:41: warning: unused variable 'stats' [-Wunused-variable]
>                   struct sched_statistics *stats =  __schedstats_from_se(se);
>                                            ^~~~~

Odd, and this isn't on other kernels too?

thanks,

greg k-h
