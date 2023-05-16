Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC277046BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjEPHnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjEPHm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:42:59 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FB219BF;
        Tue, 16 May 2023 00:42:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 92FBAEBA11;
        Tue, 16 May 2023 00:42:26 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id haCKqCl3j_pU; Tue, 16 May 2023 00:42:25 -0700 (PDT)
Message-ID: <a4b3cf3be9f105adcbcad688f8745556eec4d9df.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1684222945; bh=hNjjN4aUowMpetU4hQNKDhkB3mHZChV8fgTpId6EMEY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HLQZwyvPnFKZdXq8EXsL6LEhNYigiSbK0uxDs9KFCOoMnaTt3Bfeei6CqN6932AU6
         AtsBcbs8iHv3k4E1X6v1gJL8E0AzgdH//vhiecDEvDxbqIb0OXAadMItXcI2sEe7+G
         BZs7vxGxcv2AwcU8rtuJHbgGQ2g7Jlb5eHKaG1MRIvhOExHOLAvgEUZBZP/E2t1jOW
         3C0AggK6YgJUvq3BDU0VCg1YK2VJAILXKLD6CUK7dNJRwe4ih6vvh3RZOJWLkKY9/5
         UfOcrEpRI/c4Lp4RSGu4Tg9PSCfV2pLR2L55g1a9AO/alTA1Im7W/SnxmzL1/DRH9F
         FMVovSo86KHbQ==
Subject: Re: [PATCH v2] media: imx: Unstage the imx8mq-mipi-csi2 driver
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        slongerbeam@gmail.com, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, rmfrfs@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 16 May 2023 09:42:18 +0200
In-Reply-To: <20230425094346.GA17841@pendragon.ideasonboard.com>
References: <20230425090804.2664466-1-martin.kepplinger@puri.sm>
         <20230425094346.GA17841@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 25.04.2023 um 12:43 +0300 schrieb Laurent Pinchart:
> Hi Martin,
> 
> Thank you for the patch.
> 
> On Tue, Apr 25, 2023 at 11:08:04AM +0200, Martin Kepplinger wrote:
> > The imx8mq-mipi-csi2 MIPI CSI-2 receiver driver is used and
> > maintained.
> > There is no reason to keep it in staging. The accompanying CSI
> > bridge
> > driver that uses it is in drivers/media/platform/nxp as well.
> > 
> > One TODO is to get rid of csi_state's "state" and "lock" variables.
> > Especially make sure suspend/resume is working without them. That
> > can
> > very well be worked on from the new location.
> > 
> > Also add a MAINTAINERS section for the imx8mq-mipi-csi2 mipi
> > receiver
> > driver.
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks for reviewing Laurent,

Are there any second thoughts to this? If not: It still applies to
todays' next kernel. Who would be able to queue this up?

(This enables Debian and other distributions to use cameras on imx8mq.)

thanks,

                       martin

