Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241AE702297
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbjEODsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjEODsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:48:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC01114;
        Sun, 14 May 2023 20:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3D2660FC4;
        Mon, 15 May 2023 03:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82382C433EF;
        Mon, 15 May 2023 03:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684122488;
        bh=RidPZhJkoUld6CNFvvrP8xj6SI/WUIo1S2NgvKLeUk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joek3vtE+6F3TdtNmJELEU8Gqcc/vzwrzYMPmYOHiDtjTG6WACP9M5AU+UxaMxO7k
         ZYbjMpCBsnQPpMsF0TBE5HJxEZ2WY7mR0cx4WVtCQxjR9wGFhrA4x6/vfSRJ3Zj9m8
         aiQAbuXT+fAKIiC4nQQLEJSBEBixpw68yEvCHAaA=
Date:   Mon, 15 May 2023 05:48:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, andreas@fatal.se,
        jun.li@nxp.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] Add i.MX8MP-EVK USB Gadget Support
Message-ID: <2023051525-spew-uncouple-a098@gregkh>
References: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
 <20230514132122.GZ727834@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514132122.GZ727834@dragon>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 09:21:22PM +0800, Shawn Guo wrote:
> On Thu, May 04, 2023 at 03:46:49PM +0200, Marco Felsch wrote:
> > Hi all,
> > 
> > this adds the usb gadget support to the i.MX8MP-EVK. This Series is
> > based on [1] and therefore it is already a v2. Thanks to Li and Andreas
> > for the very useful feedback.
> > 
> > Patch1-3: Add the mssing support for USB-SS GPIO muxes. This is required
> >           to have proper USB-SS support on the EVK.
> > 
> > Patch4: Adds the devicetree integration.
> 
> Please send the DTS change separately afterwards, as we do not want
> Greg's tool to pick it up into USB tree.

"Greg's tool" is the standard `b4` tool that lots of kernel maintainers
are now using.  So this isn't some magic thing that is unique to me...

thanks,

greg k-h
