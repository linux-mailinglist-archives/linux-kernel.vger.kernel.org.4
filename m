Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947A068C562
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBFSHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjBFSHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:07:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9922223115;
        Mon,  6 Feb 2023 10:07:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3935B60FCA;
        Mon,  6 Feb 2023 18:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30173C433EF;
        Mon,  6 Feb 2023 18:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675706863;
        bh=2MrwvqBJt7ukrXEsIn0AtBjS1SbvuoI2iFvjfzPvabw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=erlZBriKGEMMwf2V+6z5b/DS1cJ8/4s5A5zPaUZc7n6oqyMC8KSslYW2xjFug/2dB
         NevIYzm+2tkaWIPwZjY9KBFoXfWG2xLXUq6SIDTPGjaRZ80gyYSiNTkfE/tC60TsGA
         d71dcR02N7JIQ10GROCpg33BDK2K3Y/38UDGWZpA=
Date:   Mon, 6 Feb 2023 19:06:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.3
Message-ID: <Y+FBqLt45rWccwXT@kroah.com>
References: <20230206141200.9789-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206141200.9789-1-djakov@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 04:12:00PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the 6.3-rc1 merge
> window. In contains new drivers and misc tiny updates. Two of the new
> drivers are in immutable branches (qcom tree pulls SM8550 and QDU1000 DT
> header files). The rest of the details are in the signed tag.
> 
> All patches have been in linux-next for at least one week. Please pull
> into char-misc-next when possible.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> 
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.3-rc1

Pulled and pushed out, thanks.

greg k-h
