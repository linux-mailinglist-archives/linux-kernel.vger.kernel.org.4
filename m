Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425ED602632
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiJRHvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiJRHvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:51:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0120932EC0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D9BEB81D59
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC4EC433C1;
        Tue, 18 Oct 2022 07:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666079487;
        bh=qXmLkh0UgSQwux0+DfA9LGTjAJnTJ7fl/3kbuY3Lpzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=adC40N1khkg9Wm9NCqD2wkYvmZWKBb+HjEByg98moE+fIqBVuNM7J/5D1s6wZY7pc
         EtbGffbts3t/u7eZSBHPSuhOsyEa6/x7XQ/4a759xJ13MI8cNNpm7ENIXV1Ff5DjJp
         lDtzsKg6Tieccfq5nDbroeCM9Goe0Y8R7IE+QKqs=
Date:   Tue, 18 Oct 2022 09:51:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, Sasha Levin <sashal@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [linux-stable-rc:linux-5.19.y 2987/3450]
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts:12:10: fatal error:
 'sc8280xp.dtsi' file not found
Message-ID: <Y05a/L0wGwh7lbjy@kroah.com>
References: <202210181441.Uo9b9Ie7-lkp@intel.com>
 <Y05Swd1ZRAF4SnTV@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y05Swd1ZRAF4SnTV@hovoldconsulting.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:16:17AM +0200, Johan Hovold wrote:
> On Tue, Oct 18, 2022 at 02:50:44PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.19.y
> > head:   28b57a08d7fd284fdeb0c92ce4aeea9bcd023911
> > commit: c4c72ceb23b538b6cbcc9cbf9463b71c3e2ae933 [2987/3450] arm64: dts: qcom: sc8280xp: Add reference device
> > config: arm64-randconfig-r011-20221017
> > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=c4c72ceb23b538b6cbcc9cbf9463b71c3e2ae933
> 
> Sasha, why on earth are you backporting commit ccd3517faf18 ("arm64:
> dts: qcom: sc8280xp: Add reference device")?!

Looks like it was added as a dependancy of another bugfix.  I've dropped
it now, and the bugfix.

thanks,

greg k-h
