Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA04E6B20E1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjCIKE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCIKEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:04:24 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409BC65C74
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:04:14 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 07F56589;
        Thu,  9 Mar 2023 11:04:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678356252;
        bh=66ENrWoctqa/DlNjCXXgOhffsRQ+ky57kWuEqZE5+lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myO+297I4TPOi+JY/TNTTg+khd3lhmmZoFeeH5xkMvcdmhmR9zxYBGnIInbQY16/s
         qq63Skef0FGB+YVSGv8E/Pe72y6Bwd+YcBu+tZX4EflqqIKQeGyI+8/c3JBj2YF/Gq
         lmmkPKWcC/mXXDuk/+cpE9W9haBLGZ87eZdnqGYw=
Date:   Thu, 9 Mar 2023 12:04:15 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     David Binderman <dcb314@hotmail.com>
Cc:     "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "rfoss@kernel.org" <rfoss@kernel.org>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: drivers/gpu/drm/bridge/fsl-ldb.c:101: possible loss of
 information.
Message-ID: <20230309100415.GO31765@pendragon.ideasonboard.com>
References: <DB6P189MB0568FCA97758B820EAC036989CB79@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
 <20230308232224.GG31765@pendragon.ideasonboard.com>
 <DB6P189MB056810B266B656706ECF7EAB9CB59@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
 <20230309092647.GM31765@pendragon.ideasonboard.com>
 <DB6P189MB0568832655843F63CCE9B63C9CB59@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB6P189MB0568832655843F63CCE9B63C9CB59@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, Mar 09, 2023 at 09:42:54AM +0000, David Binderman wrote:
> Hello there Laurent,
> 
> > Would you be able to send a patch to fix this ?
> 
> Sadly, no. My success rate with kernel patches is low enough to make
> it not worth trying.

I'm sorry to hear that. If you were willing to try again, I can offer
help with tooling and review to get your patch merged.

> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Sent: 09 March 2023 09:26
> To: David Binderman <dcb314@hotmail.com>
> Cc: andrzej.hajda@intel.com <andrzej.hajda@intel.com>; neil.armstrong@linaro.org <neil.armstrong@linaro.org>; rfoss@kernel.org <rfoss@kernel.org>; jonas@kwiboo.se <jonas@kwiboo.se>; jernej.skrabec@gmail.com <jernej.skrabec@gmail.com>; airlied@gmail.com <airlied@gmail.com>; daniel@ffwll.ch <daniel@ffwll.ch>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject: Re: drivers/gpu/drm/bridge/fsl-ldb.c:101: possible loss of information. 
>  
> Hi David,
> 
> On Thu, Mar 09, 2023 at 07:59:34AM +0000, David Binderman wrote:
> > Hello there Laurent,
> > 
> > > We could, but I don't think it will make any difference in practice as
> > > the maximum pixel clock frequency supported by the SoC is 80MHz (per
> > > LVDS channel). That would result in a 560MHz frequency returned by this
> > > function, well below the 31 bits limit.
> > 
> > Thanks for your explanation. I have a couple of suggestions for possible improvements:
> > 
> > 1. Your explanatory text in a comment nearby. This helps all readers of the code.
> > 
> > 2. Might the frequency go up to 300 MHz anytime soon ? The code will stop working then. 
> > In this case, I would suggest to put in a run time sanity check to make sure no 31 bit overflow. 
> 
> As it's a hardware limit of the SoC, I wouldn't expect so.
> 
> This being said, I think adding a UL suffix to the constants would be
> better than a comment as it will please static checkers and serve as
> documentation to humans. Would you be able to send a patch to fix this ?
> 
> > Just a couple of ideas for the code.
> 
> Thanks for taking the time to share those.

-- 
Regards,

Laurent Pinchart
