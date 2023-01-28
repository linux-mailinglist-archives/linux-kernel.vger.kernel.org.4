Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6271367F836
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjA1Nnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjA1Nnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:43:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467226D5F0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:43:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45EB0B80A72
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 13:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960A2C433EF;
        Sat, 28 Jan 2023 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674913414;
        bh=wYEb9gM1zWKRC005zxkOEQd6yzlnpH+5L1uFs+GW6Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfFoqtpDMo6Sx8j/HpHFS862eNX4U5FOz6+bebt0hHB17bvSeHpPQZh2Vu1dcwDy8
         JufX6Dc8RlSB0A97xvyXjfHav2VT/h7qq4UqXcBC8CP3fGcGfEpfmfqMKvImn5PgEQ
         g+XzWuXfdqF+26ZX2POw05wsknfJ2zYnodbZAchw=
Date:   Sat, 28 Jan 2023 14:43:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/37] nvmem: patches for 6.3
Message-ID: <Y9UmhI3hRVjLVWFp@kroah.com>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:15:28AM +0000, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> Here are some nvmem patches bit more than usual for 6.3 which includes
> 
> - Adding support for nvmem layouts, thanks to Michael and Miquel for
>   driving this effort.
> - Add support to stm32 STM32MP15x OPTEE based nvmem provider
> - Updated to qfprom bindings to include various Qualcomm SoCs.
> - adding sl28vpd provider layout
> - move imx provider to use new layout apis
> - add ONIE provider layout. 
> - new helper eth_addr_add().
> - few minor enhancements to core and providersdrivers.
> 
> Can you please queue them up for 6.3.

This series does NOT apply to my char-misc-next branch, which is based
on 6.2-rc5.  What did you generate it against?

Can you rebase it and resend?

thanks,

greg k-h
