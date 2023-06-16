Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C549F73270A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbjFPGGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjFPGGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:06:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA9E2D63;
        Thu, 15 Jun 2023 23:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8397618D9;
        Fri, 16 Jun 2023 06:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CB7C433C0;
        Fri, 16 Jun 2023 06:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686895563;
        bh=oFafS+joAVEfG2Kq+i4g/5wzFR7uMWWQuQRO7azLGmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZHiUi+FVQwaLPloXN4kUYjIihOnMM4OFQV4manBBaVGAsrDvI42mDL89HASx0wxN
         hTa27+eKuKu+2VfDj5cr99NsHcxQ/ucP1ZGST2LoW1MDshtwk4gc5gnb13ANI5SY3d
         CFSQr5xviiZEJslzAz8eSa2dnuLCLHmov5LEQ4qU=
Date:   Fri, 16 Jun 2023 08:06:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Frank Wang <frank.wang@rock-chips.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        heikki.krogerus@linux.intel.com, sebastian.reichel@collabora.com,
        heiko@sntech.de, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        huangtao@rock-chips.com, william.wu@rock-chips.com,
        jianwei.zheng@rock-chips.com, yubing.zhang@rock-chips.com,
        wmc@rock-chips.com
Subject: Re: usb: typec: tcpm: fix cc role at port reset
Message-ID: <2023061643-uplifting-sequester-0152@gregkh>
References: <20230616022001.25819-1-frank.wang@rock-chips.com>
 <3c3fbecd-caf9-c432-0890-93cceade98c1@roeck-us.net>
 <f4bc4e7e-b9d4-432b-2157-f5b30c160a3a@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4bc4e7e-b9d4-432b-2157-f5b30c160a3a@rock-chips.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:03:14AM +0800, Frank Wang wrote:
> Hi Guenter,
> 
> On 2023/6/16 10:27, Guenter Roeck wrote:
> > On 6/15/23 19:20, Frank Wang wrote:
> > > In the current implementation, the tcpm set CC1/CC2 role to open when
> > > it do port reset would cause the VBUS removed by the Type-C partner.
> > > 
> > > This sets CC1/CC2 according to the default state of port to fix it.
> > > 
> > > Comments are suggested by Guenter Roeck.
> > > 
> > 
> > I have no idea (recollection) of what I suggested here :-(
> 
> Aha, this is also an old patch I have sent before, you suggested that the cc
> role should require some tweaking based on the port type or default state,
> do you remember it now?

Please version the patch, and provide the change information as
documented.

thanks,

greg k-h
