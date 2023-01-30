Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9719A680CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbjA3MAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbjA3MAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:00:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822BC2718
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:59:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB1EB60302
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA57C433EF;
        Mon, 30 Jan 2023 11:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675079997;
        bh=Oy8Eu2C1DFOq8TaPsdO7OkKsM5/+1tWL2jL6WM/wwgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zdNcKsPq+wrrCsU48MkMQHentVnRwIVSwtjH+52cs8jVsqg4+QvkJcXrd1VCNA1T8
         V0efTkYtt4w7btQRCc69SIC7iyMmYeSISFZS79PS6Zxrb3lbmPK4ydEHezvLQms0bM
         IOH3AmYfpuV0+iFpyw7NBGyWjNeoMeWKgp6vQcec=
Date:   Mon, 30 Jan 2023 12:59:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/37] nvmem: patches for 6.3
Message-ID: <Y9exOmknnNHypwsR@kroah.com>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
 <Y9UmhI3hRVjLVWFp@kroah.com>
 <93530be7-b957-4481-629f-dc3bdf56972d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93530be7-b957-4481-629f-dc3bdf56972d@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:27:06AM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 28/01/2023 13:43, Greg KH wrote:
> > On Fri, Jan 27, 2023 at 11:15:28AM +0000, Srinivas Kandagatla wrote:
> > > Hi Greg,
> > > 
> > > Here are some nvmem patches bit more than usual for 6.3 which includes
> > > 
> > > - Adding support for nvmem layouts, thanks to Michael and Miquel for
> > >    driving this effort.
> > > - Add support to stm32 STM32MP15x OPTEE based nvmem provider
> > > - Updated to qfprom bindings to include various Qualcomm SoCs.
> > > - adding sl28vpd provider layout
> > > - move imx provider to use new layout apis
> > > - add ONIE provider layout.
> > > - new helper eth_addr_add().
> > > - few minor enhancements to core and providersdrivers.
> > > 
> > > Can you please queue them up for 6.3.
> > 
> > This series does NOT apply to my char-misc-next branch, which is based
> > on 6.2-rc5.  What did you generate it against?
> > 
> These were on top of nvmem-fixes based on 6.2-rc1.

Ah, always say that please.

> > Can you rebase it and resend?
> 
> char-misc-next does not have nvmem-fixes yet, which branch should I rebase
> these on?

char-misc-next please.  If there are going to be merge conflicts when
the char-misc-linus branch gets merged into that with these changes,
please let me know.

thanks,

greg k-h
