Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFC769F131
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjBVJVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjBVJVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:21:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C4727D48;
        Wed, 22 Feb 2023 01:21:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7193B8122A;
        Wed, 22 Feb 2023 09:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F7EC433EF;
        Wed, 22 Feb 2023 09:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677057695;
        bh=DRkaQ2QMTyMKbMBa3g3UbF86U6cHs28JPVEbBudftnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sthjhPV/ygHRM90sn5uoL40X+PmEwYLN4KRsfvMZc1pMNEazN7rm3DP/AGzmJN7Y3
         C3fkZ+GGvaNnAteYtCQEv5Fj8jXdIntNaZNcaZ+wL+Ls7XRcOXevFObW4ugzDLziFN
         UqwDJn8tzCEuefzPfGG4FJNSizb4tihIkw2svo5w=
Date:   Wed, 22 Feb 2023 10:21:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, daniel.lezcano@linaro.org,
        chunfeng.yun@mediatek.com, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        sean.wang@mediatek.com, zhiyong.tao@mediatek.com,
        khilman@baylibre.com
Subject: Re: [PATCH v9 9/9] arm64: dts: mediatek: Initial mt8365-evk support
Message-ID: <Y/XenZUmT7Nh2qGP@kroah.com>
References: <20230125143503.1015424-1-bero@baylibre.com>
 <20230125143503.1015424-10-bero@baylibre.com>
 <8c348b39-67f3-9210-1929-8b2f093be24c@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c348b39-67f3-9210-1929-8b2f093be24c@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 09:17:39AM +0100, Alexandre Mergnat wrote:
> Hi Matthias,
> 
> This is a gentle ping to know if you can take this patch please.
> Sorry for the double mail, I screwed up the first send.

It's the middle of the merge window, we can't take _ANYTHING_ now.
Please wait until after 6.3-rc1 is out.

thanks,

greg k-h
