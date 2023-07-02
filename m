Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B297452EC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 00:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjGBWUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 18:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGBWUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 18:20:33 -0400
X-Greylist: delayed 1594 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Jul 2023 15:20:32 PDT
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A330100;
        Sun,  2 Jul 2023 15:20:32 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QvNmF4vKxzyRn;
        Mon,  3 Jul 2023 01:20:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1688336429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oMD1TXeK3IXSRa0lCRuCI3EQhj0P8b1KnnEjt/MC0QM=;
        b=DFjiNXqPfScDGbbHjtjidzXf6Z+BMtlODL9HJSN3ac07XEcNrdJ9hHBlVs8BMHc0pBb5I8
        DO8/vXDRdw76K9HFLAj63k/E+xjejZ0WXO5S7ezvtDacplNvdAYc1VWP8a2LDfR1kJAK4Z
        HIFSxHpwiUpdByEV3XCsK7PCPJYxg70=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1688336429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oMD1TXeK3IXSRa0lCRuCI3EQhj0P8b1KnnEjt/MC0QM=;
        b=lFx6nDraEyqXeb7c93L/JtySjBy3qwsILfGwHCmS88OpRd7RhaVl2kMvdTpce8Jyi00LDX
        UmZB9Cn3RZn2agO+7NZNswMNjtHmcXEXTYChyGSrrgeay3S8kKVCiVyaGvxtMdYiRniW4y
        b1MwepdygusFgjNgocqeqcrCOBeCyGE=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1688336429; a=rsa-sha256; cv=none;
        b=GFCc5/eMLM1UfGUytqpKaKfj1e+HCp4zyrGjgpcd2JAQlw/fTdPQ9UvNVhSf7VG+DjYUxr
        LnkywEj9Bme4SWzZQvI0hrwqto5uMpzWRhk2ysZRf6WExwP00TvLqByqPWvYTgK538HWYV
        MvnPhmMdQqgUUPi1HHLHn1TQsRc3iko=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 2FF4E634C93;
        Mon,  3 Jul 2023 01:20:29 +0300 (EEST)
Date:   Sun, 2 Jul 2023 22:20:29 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com
Subject: Re: [PATCH v5 04/11] media: bcm2835-unicam: Add support for
 CCP2/CSI2 camera interface
Message-ID: <ZKH4LXKHX8G1WK7a@valkosipuli.retiisi.eu>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
 <20220208155027.891055-5-jeanmichel.hautbois@ideasonboard.com>
 <YhihbncnSlmvrn/D@valkosipuli.retiisi.eu>
 <20230702152356.GA16995@pendragon.ideasonboard.com>
 <ZKG/bej80eL13Qqp@valkosipuli.retiisi.eu>
 <20230702214505.GB16995@pendragon.ideasonboard.com>
 <20230702214711.GC16995@pendragon.ideasonboard.com>
 <ZKHye/4kARSHqsIJ@valkosipuli.retiisi.eu>
 <20230702220138.GE9285@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702220138.GE9285@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Mon, Jul 03, 2023 at 01:01:38AM +0300, Laurent Pinchart wrote:
> > > > > > > If the hardware doesn't support lane remapping for CCP2, then that should
> > > > > > > be reflected in DT bindings, i.e. data-lanes isn't relevant. There's no
> > > > > > > need to check that here.
> > > > > > 
> > > > > > Should the above check for CSI-2 be dropped as well then ?
> > > > > 
> > > > > Same for CSI-2, too: if there's nothing to configure there (lane remapping)
> > > > > there's no need to validate that part of the DT either.
> > > > 
> > > > OK, I'll drop that.
> > > 
> > > Actually, I'm wondering if it would make sense to tell the parsing
> > > functions whether lane reordering is supported or not. The checks could
> > > then be moved to the framework. What do you think ?
> > 
> > I'm not sure how useful this check would be in the first place: if you have
> > hardware that can reorder the lanes, the framework doesn't know what to
> > check there (if anything) and otherwise there's little point in the
> > entire check.
> 
> Isn't it good to tell users that something is wrong instead of accepting
> the invalid configuration and let them wonder why the device isn't
> working ? Users in this case would be system integrators, not end
> users, but we have lots of debugging information in the kernel aimed for
> them already.

In which of the two cases above the framework could do something useful
there? For devices where you can reorder the lanes or for those where you
can't?

-- 
Sakari Ailus
