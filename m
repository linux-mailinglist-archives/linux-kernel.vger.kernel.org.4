Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7CF6BCBAE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCPJ5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjCPJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB9EB3E38;
        Thu, 16 Mar 2023 02:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B97761FAC;
        Thu, 16 Mar 2023 09:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D27C433D2;
        Thu, 16 Mar 2023 09:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678960612;
        bh=lsZikO2VvRyvYJlmsOMc+/eeBve2a5BVdyRGQXVN/po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=noCSjuAGGYwgPkmD8dbVY1s4kLhp0XIoPa5J6i7PFHAVI7p2IfYFljzd+dKoaAGF8
         XPNUuos/oH/D0c+N/iZjSON12U/4ARa83qXfBZ4aCEOFjcuhmQAwZsvDdwlwLePE1a
         /VtmiYPglo+CDwbdS8WXFxpwd9VnZ9C+U3l5y+Ws=
Date:   Thu, 16 Mar 2023 10:56:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 6.3-rc
Message-ID: <ZBLnxsPa5ZUy/36q@kroah.com>
References: <20230316091655.865358-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316091655.865358-1-djakov@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 11:16:55AM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains fixes for the current cycle. These are fixing
> a race condition and other reported issues. The details are in the signed
> tag. All patches has been in linux-next during the last few days (but in
> practice even for more than a week - i dropped one patch and some hashes
> changed). Please pull into char-misc-linus when possible.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
> 
>   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.3-rc3

Pulled and pushed out, thanks.

greg k-h
