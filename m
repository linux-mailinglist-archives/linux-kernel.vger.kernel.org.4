Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617566FC847
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjEIN4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjEIN4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AB01FC2;
        Tue,  9 May 2023 06:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89C2162C1E;
        Tue,  9 May 2023 13:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09477C433D2;
        Tue,  9 May 2023 13:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683640605;
        bh=iJ/mPW2noo5FchdVMAsquorvcNaKJ/8jol/a+17DyPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DmywGlVa6UAq363sBBZnxsj6gA/l48yeQwhWQ6DL6wyghUFY1C7ZC2fwpuQY8va5i
         jdXVSAW+2gcqA4IrF6KVmtGiwLY74ZynC64Ql+iqwxC2KuulH5HagvTF9tPrZMTY+q
         zXq5icaPAy4hUKeHFLh92+zTZYw2vIV6t8lbaVNk=
Date:   Tue, 9 May 2023 15:56:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rudi Heitbaum <rudi@heitbaum.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
Message-ID: <2023050913-spearhead-angrily-fc58@gregkh>
References: <20230509030705.399628514@linuxfoundation.org>
 <20230509080658.GA152864@d6921c044a31>
 <20230509131032.GA8@9ed91d9f7b3c>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509131032.GA8@9ed91d9f7b3c>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 01:10:32PM +0000, Rudi Heitbaum wrote:
> On Tue, May 09, 2023 at 08:06:58AM +0000, Rudi Heitbaum wrote:
> > On Tue, May 09, 2023 at 05:26:44AM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.3.2 release.
> > > There are 694 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > > Anything received after that time might be too late.
> > 
> > Hi Greg,
> > 
> > 6.3.2-rc2 tested.
> 
> Hi Greg,
> 
> Further testing and have seen ntfs3: NULL pointer dereference with ntfs_lookup errors 
> with 6.3.2-rc2 (I have not seen this error before.) No other errors in the logs.

Can you reproduce this without the extern, gpl-violation module loaded?

thanks,

greg k-h
