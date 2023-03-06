Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B296AB616
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 06:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCFFk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 00:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCFFkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 00:40:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6311A64E;
        Sun,  5 Mar 2023 21:40:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A4ABB80C6E;
        Mon,  6 Mar 2023 05:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264E4C433D2;
        Mon,  6 Mar 2023 05:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678081249;
        bh=ozxEJ4XFCHc0BADBdwIy4ELSX5qpfo2qbo1MrODvuy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bHN+kMHiv4Jyy7FXsPSetvL8Vkg+/m76gScZIzvwjPNjP0ox220En3ejMyHiO+hFc
         6kjMM2s7Cp9EK7OjylRuauBE0GQH6mJS59b7ZL0ffSqHwky0cchlvSfZq8MDm6OiGt
         vGigdCflbB3O+hNGcHtpvPfI0rPp1qzxz47eFH98=
Date:   Mon, 6 Mar 2023 06:40:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
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
Message-ID: <ZAV83gLh+qNqrHrg@kroah.com>
References: <20230125143503.1015424-1-bero@baylibre.com>
 <20230125143503.1015424-10-bero@baylibre.com>
 <8c348b39-67f3-9210-1929-8b2f093be24c@baylibre.com>
 <Y/XenZUmT7Nh2qGP@kroah.com>
 <CAP2ifjPvsvPyF56=YXrc9Ti6ZSLOxEXbMCOP-Qa4ZSempfod=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP2ifjPvsvPyF56=YXrc9Ti6ZSLOxEXbMCOP-Qa4ZSempfod=g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 06:02:03AM +0100, Bernhard Rosenkränzer wrote:
> Hi,
> 
> On Wed, Feb 22, 2023 at 10:21 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Feb 22, 2023 at 09:17:39AM +0100, Alexandre Mergnat wrote:
> > > Hi Matthias,
> > >
> > > This is a gentle ping to know if you can take this patch please.
> > > Sorry for the double mail, I screwed up the first send.
> >
> > It's the middle of the merge window, we can't take _ANYTHING_ now.
> > Please wait until after 6.3-rc1 is out.
> 
> Now that 6.3-rc1 is out, can we try to get this patch merged? All the
> i350 driver patches are waiting for this to land.

$ mdfrm -c ~/mail/todo/
1459 messages in /home/gregkh/mail/todo/

Please relax, it's only been out for a few hours, and our review queues
are large.  To help out, please help review patches from others to
reduce our load.

thanks,

greg k-h
