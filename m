Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313BD71F100
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjFARlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjFARlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60A519D;
        Thu,  1 Jun 2023 10:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C8A615F6;
        Thu,  1 Jun 2023 17:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3FAC433EF;
        Thu,  1 Jun 2023 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685641276;
        bh=CRB7AMcp8uSqjPgC16U5Gj7d6x7dEv+JFT/7ZjpPCXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IEhDo82S8U8HTCuNuscTnYHQ8mIRPYGtk5eQ6Q9Yukyl3SSlZYhaMZE659XNE4UpD
         LTQ9JVuH3QpkfblUGNxHDGHR7ulTmtFskpPQRB+DFtWgZKqTmsOSiQzRLFyYBndSWj
         jEXHPmH6aB1dtqIZMOmemzZiUGoIe6x7+vszTkVY=
Date:   Thu, 1 Jun 2023 18:41:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 00/42] 6.1.32-rc1 review
Message-ID: <2023060155-angles-baggy-78e5@gregkh>
References: <20230601131939.051934720@linuxfoundation.org>
 <CA+G9fYuHjNhe-5TboAbrOeZrL3xL-CYYSaEnL=8onebLUqDt8g@mail.gmail.com>
 <2023060101-coconut-smugness-4c7a@gregkh>
 <e7f9cbd1-f19d-2f08-8876-45163910ad93@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f9cbd1-f19d-2f08-8876-45163910ad93@roeck-us.net>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 07:39:54AM -0700, Guenter Roeck wrote:
> On 6/1/23 07:26, Greg Kroah-Hartman wrote:
> > On Thu, Jun 01, 2023 at 07:41:08PM +0530, Naresh Kamboju wrote:
> > > On Thu, 1 Jun 2023 at 18:57, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > This is the start of the stable review cycle for the 6.1.32 release.
> > > > There are 42 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > >          https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.32-rc1.gz
> > > > or in the git tree and branch at:
> > > >          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > > and the diffstat can be found below.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > 
> > > Following build errors noticed on 6.1 and 5.15.
> > > 
> > > drivers/dma/at_xdmac.c: In function 'atmel_xdmac_resume':
> > > drivers/dma/at_xdmac.c:2049:9: error: implicit declaration of function
> > > 'pm_runtime_get_noresume' [-Werror=implicit-function-declaration]
> > >   2049 |         pm_runtime_get_noresume(atxdmac->dev);
> > >        |         ^~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/dma/at_xdmac.c:2049:40: error: 'struct at_xdmac' has no member
> > > named 'dev'
> > >   2049 |         pm_runtime_get_noresume(atxdmac->dev);
> > >        |                                        ^~
> > > cc1: some warnings being treated as errors
> > > 
> > > reported link:
> > > https://lore.kernel.org/stable/CA+G9fYswtPyrYJbwcGFhc5o7mkRmWZEWCCeSjmR64M+N-odQhQ@mail.gmail.com/
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > Ah, the .h file was added by 650b0e990cbd ("dmaengine: at_xdmac: add
> > runtime pm support"), which isn't needed here.  I'll go add it by hand
> 
> Really ? Some of the dma patches seem to fix runtime pm support, and
> "dmaengine: at_xdmac: disable/enable clock directly on suspend/resume"
> is even tagged with
> 
> Fixes: 650b0e990cbd ("dmaengine: at_xdmac: add runtime pm support")
> 
> Why do we need to fix code which isn't present in 6.1.y ?

We don't, I've dropped all of the patches for this driver from 5.15.y
and 6.1.y as something went wrong here.

thanks,

greg k-h
