Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DD05BCC44
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiISM4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiISM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:56:05 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F6A6340;
        Mon, 19 Sep 2022 05:56:04 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 63EA59BA;
        Mon, 19 Sep 2022 14:56:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663592163;
        bh=9Mr46YmjsLRLVKJjiWth2KE6xqw9og/WajL2NO3Thzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6P0cs8/Wc3eM6BOHjJ92Dhs2KBhqeCDREldv0Ey5zThraVeQXt+ujxhsDBJxVwZd
         Ast/CRgcxmpg/A3JVsTgScgHp6wOx2EQ5KVwJyrxwndlbqDP4AUQ1sG8TsNvqK4HXe
         zltmcmR6NjoGIT0pHEMytrLt4b7l6MPrhmXN0Nj4=
Date:   Mon, 19 Sep 2022 15:55:50 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, mchehab@kernel.org,
        akinobu.mita@gmail.com, jacopo+renesas@jmondi.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] media: mt9m111: fix device power usage
Message-ID: <Yyhm1o44NHWe018B@pendragon.ideasonboard.com>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
 <20220916135713.143890-2-m.felsch@pengutronix.de>
 <YyhkdtFzXn36AytN@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyhkdtFzXn36AytN@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 12:45:42PM +0000, Sakari Ailus wrote:
> Hi Marco,
> 
> On Fri, Sep 16, 2022 at 03:57:12PM +0200, Marco Felsch wrote:
> > @@ -758,10 +751,14 @@ static int mt9m111_g_register(struct v4l2_subdev *sd,
> >  	if (reg->reg > 0x2ff)
> >  		return -EINVAL;
> >  
> > +	mt9m111_s_power(sd, 1);
> 
> It would be nice to have this driver converted to runtime PM. Up to you.

I second that :-)

-- 
Regards,

Laurent Pinchart
