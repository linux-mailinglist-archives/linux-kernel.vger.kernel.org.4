Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DED714D39
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjE2Pid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjE2Pib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:38:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275129C;
        Mon, 29 May 2023 08:38:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF11061794;
        Mon, 29 May 2023 15:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C934C433EF;
        Mon, 29 May 2023 15:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685374709;
        bh=OH/vh5ucJsvWdnT5PvqiPVI/rDkbKH6ANrnU5OP0+Q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdldZdPR6Ez7zOchY3JlqxbOOzzF90yZMzXS/YAvbWdzX18sd1tRWSZY+XIOU4IlC
         l1E0qlZ9VqJxtwlRt6R4AZMTjUTMUk6+NNOzLA+J+I1RRhuZr9J+vE2QkVhuplVQVI
         qZy02Bug+4fvhtVEsGi273o0DIRfLYdAQV2vvik8=
Date:   Mon, 29 May 2023 16:38:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 4.19 000/132] 4.19.284-rc1 review
Message-ID: <2023052914-lustrous-sandpaper-d025@gregkh>
References: <20230528190833.565872088@linuxfoundation.org>
 <e98d3b88-980b-4487-baf8-4685cfe62209@roeck-us.net>
 <468bc707-0814-4d83-9087-74768d98203a@roeck-us.net>
 <CA+G9fYspKgo+qF5Onq_HDz1-w6NscULrFUSw=YKp+1e=4NkBBQ@mail.gmail.com>
 <bb173e8e-c275-e153-83cd-019861b30e09@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb173e8e-c275-e153-83cd-019861b30e09@roeck-us.net>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 08:20:23AM -0700, Guenter Roeck wrote:
> On 5/29/23 07:28, Naresh Kamboju wrote:
> > On Mon, 29 May 2023 at 19:19, Guenter Roeck <linux@roeck-us.net> wrote:
> > > 
> > > On Mon, May 29, 2023 at 06:48:10AM -0700, Guenter Roeck wrote:
> > > > On Sun, May 28, 2023 at 08:08:59PM +0100, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.19.284 release.
> > > > > There are 132 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> > > > > Anything received after that time might be too late.
> > > > > 
> > > > 
> > > > Building s390:defconfig ... failed
> > > > Building s390:allnoconfig ... failed
> > > > Building s390:tinyconfig ... failed
> > 
> > We do noticed these set of build failures,
> > 
> > Seems like the following commit might have caused this
> > build break
> > 
> >   drivers: provide devm_platform_ioremap_resource()
> >    [ Upstream commit 7945f929f1a77a1c8887a97ca07f87626858ff42 ]
> > 
> > 
> 
> Yes. devm_ioremap_resource() is only defined with CONFIG_HAS_IOMEM,
> That dependency was added to platform.c with commit 837ccda3480d
> ("drivers: depend on HAS_IOMEM for devm_platform_ioremap_resource()")
> which wasn't backported.

Thanks, I've queued that up now, and will push out a -rc2.

greg k-h
