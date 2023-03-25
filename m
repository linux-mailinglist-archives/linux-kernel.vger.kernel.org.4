Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A5E6C8D03
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 11:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjCYJ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 05:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjCYJ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 05:59:55 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CCEDBC5;
        Sat, 25 Mar 2023 02:59:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D1D42FCE3B;
        Sat, 25 Mar 2023 02:59:53 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o8nROS5231e1; Sat, 25 Mar 2023 02:59:53 -0700 (PDT)
Message-ID: <a0a10c7bf7fdf388b7d09ca3ba59e416d4924877.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1679738393; bh=3Fg+LMktGNv0YxDPBo5MDgiv93LD8o8DA2oXs8mAEOI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UNt18uh7UbXW3VYZUaog5fmlbhXAwYfJ2rvrELOOeo09b8xntVL4EH4fKRxlEVw6A
         HQkTON6k5kBiKLO6Q61QOkQIEKu5VKHRNlR3c9t5Ed8vl1v1YH0/pJUU2WvhFO4RpG
         vnEArbASOJC31VR6d+SRIQAppYmTV2oyC6DPg2CWR+O39MTBjXFb6K1Hg5JkhuG88i
         JzA+38BKA943hr1sfDX+qpX2R4yJrpk4lQZ4cD8//Di87T04nNND09wrPvZMeYVzex
         gJcC1qNzp/2A9pSpi8bGwzQlaVORna9EKpXQ5ip2GDLrCeR1WYESK0aF9VbW5vE2i2
         xNQDvrchg9e7g==
Subject: Re: [PATCH v2 2/2] media: imx: imx8mq-mipi-csi2: remove unneeded
 state variable and function
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        gregkh@linuxfoundation.org, shawnguo@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Date:   Sat, 25 Mar 2023 10:59:47 +0100
In-Reply-To: <25ed971e90324ad596353ba6aade2e14c40c7183.camel@puri.sm>
References: <20230307150047.1486186-1-martin.kepplinger@puri.sm>
         <20230307150047.1486186-3-martin.kepplinger@puri.sm>
         <20230312133706.GJ2545@pendragon.ideasonboard.com>
         <25ed971e90324ad596353ba6aade2e14c40c7183.camel@puri.sm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 12.03.2023 um 15:04 +0100 schrieb Martin Kepplinger:
> Am Sonntag, dem 12.03.2023 um 15:37 +0200 schrieb Laurent Pinchart:
> > Hi Martin,
> > 
> > Thank you for the patch.
> > 
> > On Tue, Mar 07, 2023 at 04:00:47PM +0100, Martin Kepplinger wrote:
> > > Clean up the driver a bit by inlining the
> > > imx8mq_mipi_csi_system_enable()
> > > function to the callsites and removing the hs_settle variable
> > > from
> > > the
> > > driver state.
> > > 
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Could I volunteer you to also drop the struct csi_state state field
> > ?
> > :-)
> 
> sure :) it can become at least a bit more tricky than this patch.
> I'll
> take the time after this is merged.
> 
> thanks for the fast reviewing

Laurent, are these 2 patches queued up somewhere? I'm used to waiting
until they are part of a tree that is part of linux-next before sending
something new. Does that make sense?

thanks,
                      martin


