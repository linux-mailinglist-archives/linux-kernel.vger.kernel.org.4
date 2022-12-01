Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3837863EB0F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiLAI1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiLAI05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:26:57 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3FD6E554;
        Thu,  1 Dec 2022 00:26:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2E422CE18B7;
        Thu,  1 Dec 2022 08:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF528C433D6;
        Thu,  1 Dec 2022 08:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669883210;
        bh=QUQeSgrutik/8pe2d8be3o1H58jPmKkhXZFIw6Ik2kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Md+MZxrRPwCp1G5I8QzwH7U/PWE7L7jEqIo7f09qti2RUpHabMgbt3ocqcgWdSC9r
         PDbFiKn1MwdtHXuT9vXi9GuqnPwlzcsgwP4rZQH/qG3BArvSR8VCHY56QkmV+X4GRn
         Ra/jmj3ssv2QCewohK+aH6cDJE4AyBO5eonWeO74=
Date:   Thu, 1 Dec 2022 09:03:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Artur Bujdoso <artur.bujdoso@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
Subject: Re: [RFC PATCH v1 0/2] add xhci-exynos to support Samsung Exynos SOCs
Message-ID: <Y4hftXoUdAQ3SK4s@kroah.com>
References: <CGME20221201021940epcas2p2073f25dad069314022471eaa16d26592@epcas2p2.samsung.com>
 <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:13:29AM +0900, Daehwan Jung wrote:
> This patchset is to support xHCI Controller on Samsung Exynos SOCs.
> 
> Daehwan Jung (2):
>   dt-bindings: usb: samsung,exynos-xhci: support Samsung Exynos xHCI
>     Controller
>   usb: host: add xhci-exynos to support Exynos SOCs

Why is this a "RFC" and not a real submission?  What needs to be done to
it to get it into mergable shape?

And thank you for posting this, I've wanted to see this merged for a
very long time given the millions of devices already using it.

thanks,

greg k-h
