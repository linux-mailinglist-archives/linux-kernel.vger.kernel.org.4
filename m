Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA365E678A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiIVPuF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Sep 2022 11:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiIVPt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:49:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607AC2983C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:49:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1obOSB-0002HK-Vs; Thu, 22 Sep 2022 17:49:32 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1obOSA-002Hsy-F6; Thu, 22 Sep 2022 17:49:29 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1obOS8-000FKE-Dj; Thu, 22 Sep 2022 17:49:28 +0200
Message-ID: <8d586c6da80cb948d38eeb0236423ea4810269bd.camel@pengutronix.de>
Subject: Re: [PATCH v1] reset: npcm: fix iprst2 and iprst4 setting
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, arnd@arndb.de
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 Sep 2022 17:49:28 +0200
In-Reply-To: <20220922153856.23326-1-tmaimon77@gmail.com>
References: <20220922153856.23326-1-tmaimon77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2022-09-22 at 18:38 +0300, Tomer Maimon wrote:
> In NPCM8XX USB reset sequence, iprst2 register was set with iprst4 value
> and iprst4 register wasn´t set.
> 
> This fix sets the correct IP reset values in iprst2 and iprst4 registers
> in NPCM8XX USB reset sequence.
> 
> Fixes: fc5d2a2f4aa5 ("reset: npcm: Add NPCM8XX support")
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Thank you, applied to reset/fixes.

regards
Philipp
