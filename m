Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6294C68B69F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 08:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBFHqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 02:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBFHqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 02:46:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9791DCC2C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 23:46:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4809FB80C6A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C730C433D2;
        Mon,  6 Feb 2023 07:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675669588;
        bh=JZbdiYDCE2wLbQi+H6TtHsMc7BqAZZJXIncggkOSHvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBt2+77Jk7sB+CoVefYvn4enikNAZXQVUbv370u+9d0cUHtv9c91nFOkUNFBeSWHc
         5b+1vnWdx8Qe8gqgW838SMMXV2wQkP/JGcsyWhDFHyN9Z4OD4NTOAPyaYizwItEqkj
         DBvdmXSiO4GnQAls3n8Bn1QwqrXihtzs41X07IDg=
Date:   Mon, 6 Feb 2023 08:46:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/37] nvmem: patches for 6.3
Message-ID: <Y+CwUax45KgxPBYE@kroah.com>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
 <Y9UmhI3hRVjLVWFp@kroah.com>
 <93530be7-b957-4481-629f-dc3bdf56972d@linaro.org>
 <Y9exOmknnNHypwsR@kroah.com>
 <75891466-48f7-f86a-d9e5-e4bb4c0e9912@linaro.org>
 <Y+CwGU0bvwIf2S3H@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+CwGU0bvwIf2S3H@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 08:45:29AM +0100, Greg KH wrote:
> On Mon, Jan 30, 2023 at 03:54:58PM +0000, Srinivas Kandagatla wrote:
> > 
> > 
> > On 30/01/2023 11:59, Greg KH wrote:
> > > On Mon, Jan 30, 2023 at 11:27:06AM +0000, Srinivas Kandagatla wrote:
> > > > 
> > > > 
> > > > On 28/01/2023 13:43, Greg KH wrote:
> > > > > On Fri, Jan 27, 2023 at 11:15:28AM +0000, Srinivas Kandagatla wrote:
> > > > > > Hi Greg,
> > > > > > 
> > > > > > Here are some nvmem patches bit more than usual for 6.3 which includes
> > > > > > 
> > > > > > - Adding support for nvmem layouts, thanks to Michael and Miquel for
> > > > > >     driving this effort.
> > > > > > - Add support to stm32 STM32MP15x OPTEE based nvmem provider
> > > > > > - Updated to qfprom bindings to include various Qualcomm SoCs.
> > > > > > - adding sl28vpd provider layout
> > > > > > - move imx provider to use new layout apis
> > > > > > - add ONIE provider layout.
> > > > > > - new helper eth_addr_add().
> > > > > > - few minor enhancements to core and providersdrivers.
> > > > > > 
> > > > > > Can you please queue them up for 6.3.
> > > > > 
> > > > > This series does NOT apply to my char-misc-next branch, which is based
> > > > > on 6.2-rc5.  What did you generate it against?
> > > > > 
> > > > These were on top of nvmem-fixes based on 6.2-rc1.
> > > 
> > > Ah, always say that please.
> > My bad, I assumed that fixes will be applied and then these patches. But I
> > should have mentioned this clearly.
> > 
> > > 
> > > > > Can you rebase it and resend?
> > > > 
> > > > char-misc-next does not have nvmem-fixes yet, which branch should I rebase
> > > > these on?
> > > 
> > > char-misc-next please.  If there are going to be merge conflicts when
> > > the char-misc-linus branch gets merged into that with these changes, > please let me know.
> > 
> > Yes, for sure this is going to conflict. some of the patches in this set are
> > on top of fixes.
> 
> Ok, now that the char-misc-linus branch is merged into my -next branch,
> I've applied these.

Nope, lots of errors:

Commit: b4fee523c0d7 ("nvmem: stm32: fix OPTEE dependency")
	Fixes tag: Fixes: ae46fd89cc0cc ("nvmem: stm32: add OP-TEE support for STM32MP13x")
	Has these problem(s):
		- Target SHA1 does not exist
Commit: b6dc9d9a156a ("of: property: fix #nvmem-cell-cells parsing")
	Fixes tag: Fixes: 6a80b3e6fb41 ("of: property: make #.*-cells optional for simple props")
	Has these problem(s):
		- Target SHA1 does not exist
Commit: 57a71161cecb ("nvmem: core: fix nvmem_layout_get_match_data()")
	Fixes tag: Fixes: f61a093b4a0e ("nvmem: core: introduce NVMEM layouts")
	Has these problem(s):
		- Target SHA1 does not exist
Commit: 8e1cd6f05f71 ("nvmem: core: return -ENOENT if nvmem cell is not found")
	Fixes tag: Fixes: e894d5ad177c ("nvmem: core: add an index parameter to the cell")
	Has these problem(s):
		- Target SHA1 does not exist


Can you please fix this up and resend?

thanks,

greg k-h
