Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBFA61F9BF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiKGQaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiKGQ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:29:36 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFA4233B5;
        Mon,  7 Nov 2022 08:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667838451; bh=Mg3Id1/fkypwOfC8wSYIW3Daq138C5v1hZ6ElXptx3w=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Ad6bDeeRL6UDBnT2widUFcAT8BUumtDjzMOfhEfKqCGnyRWfm4VStTPzWW3SMObHg
         Ur2sqDex2qZLMoGADvy0GyJxqhiWzio1YrPuHqTzHgTcjTqv5384orlZLPhvSgiZPa
         HFMoRX3xrdx0HEyA71+gsplF6ix/57i2ayDi4R6U=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon,  7 Nov 2022 17:27:26 +0100 (CET)
X-EA-Auth: iW97wWXq7wu86/I281m0xgHIxJjEWPKb6RpDVe9GmtL39NqzPnDHdijSL/LFBCfxpHq/8ZVf676fiuiEBW1lz9iA0X4yNR8N
Date:   Mon, 7 Nov 2022 21:57:21 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: meter: use min() for comparison and
 assignment
Message-ID: <Y2kx6d9T9/1pzKk/@qemulion>
References: <Y2iFGA3A1w+XMlYU@qemulion>
 <Y2kDTxE38epBN368@kadam>
 <41a43f3865f3c86c6c2d1fbf3d82c42b685c7041.camel@perches.com>
 <Y2kme/FDg/4K2VW5@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2kme/FDg/4K2VW5@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 06:38:35PM +0300, Dan Carpenter wrote:
> On Mon, Nov 07, 2022 at 07:22:24AM -0800, Joe Perches wrote:
> > > In terms of run time, this patch is fine but in terms of reading the
> > > code using min() makes it less readable.
> >
> > It's not a runtime question, either should compile to the same object
> > code.  It's definitely a readabiity and standardization issue.
> >
> > In this case, IMO it'd be better to use the much more common
> >
> > 	if (ret < 0)
> > 		return ret;
> >
> > 	return 0;
>
> I also prefer this format.
>
> But at the same time, I can't advise Deepak to go around changing
> existing code where the author like ternaries.

Thank you Joe, Dan. Just to conclude, I will leave the line untouched as it is
no big advantage and the current format is more readable.

./drv

>
> regards,
> dan carpenter
>


