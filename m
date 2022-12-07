Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB24645A39
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiLGMyl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 07:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLGMyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:54:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AC455CB6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 04:54:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1p2tw9-0006WR-PT; Wed, 07 Dec 2022 13:54:09 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1p2tw7-002vM8-2e; Wed, 07 Dec 2022 13:54:07 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1p2tw6-0006dw-Tb; Wed, 07 Dec 2022 13:54:06 +0100
Message-ID: <f3cd89a9d00918f222e3fe24c5512c7fb6bf1c0d.camel@pengutronix.de>
Subject: Re: [PATCH v11 1/6] media: platform: chips-media: Move Coda to
 separate folder
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     kernel@collabora.com, bob.beckett@collabora.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        nas.chung@chipsnmedia.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 07 Dec 2022 13:54:06 +0100
In-Reply-To: <20221207121350.66217-2-sebastian.fricke@collabora.com>
References: <20221207121350.66217-1-sebastian.fricke@collabora.com>
         <20221207121350.66217-2-sebastian.fricke@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Mi, 2022-12-07 at 13:13 +0100, Sebastian Fricke wrote:
> Prepare the folder structure for a second Chips&Media driver.
> Move the Coda driver to a sub-directory.
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>  MAINTAINERS                                    |  2 +-
>  drivers/media/platform/chips-media/Kconfig     | 17 +----------------
>  drivers/media/platform/chips-media/Makefile    |  5 +----
>  .../media/platform/chips-media/coda/Kconfig    | 18 ++++++++++++++++++
>  .../media/platform/chips-media/coda/Makefile   |  6 ++++++
>  .../platform/chips-media/{ => coda}/coda-bit.c |  0
>  .../chips-media/{ => coda}/coda-common.c       |  0
>  .../platform/chips-media/{ => coda}/coda-gdi.c |  0
>  .../chips-media/{ => coda}/coda-h264.c         |  0
>  .../chips-media/{ => coda}/coda-jpeg.c         |  0
>  .../chips-media/{ => coda}/coda-mpeg2.c        |  0
>  .../chips-media/{ => coda}/coda-mpeg4.c        |  0
>  .../platform/chips-media/{ => coda}/coda.h     |  0
>  .../chips-media/{ => coda}/coda_regs.h         |  0
>  .../platform/chips-media/{ => coda}/imx-vdoa.c |  0
>  .../platform/chips-media/{ => coda}/imx-vdoa.h |  0
>  .../platform/chips-media/{ => coda}/trace.h    |  0

TRACE_INCLUDE_PATH in trace.h needs to be updated. For reference, see
commit 64441979bda6 ("media: platform: rename coda/ to chips-media/").

regards
Philipp
