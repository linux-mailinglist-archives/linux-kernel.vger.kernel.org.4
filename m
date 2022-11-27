Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640406399A0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 09:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiK0IKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 03:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiK0IKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 03:10:40 -0500
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB45E0D6;
        Sun, 27 Nov 2022 00:10:38 -0800 (PST)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id 0021330B294A;
        Sun, 27 Nov 2022 09:10:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        cmp.felk.cvut.cz; h=cc:cc:content-transfer-encoding:content-type
        :content-type:date:from:from:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to; s=felkmail; bh=GGyL/
        C4H6vtTsrrNEWsfehnYpF8amxqPutxzbZGcttQ=; b=aNK6bSUHyYC0fKV//4P50
        8iC488EVv3oOeIeB/P0hp6Q5BUVjiJsG2KoBRdqMesQHs0CH/3MTt2pT2HjEOAmq
        FrW3KqCVYpMOY38rNMMXcnllpqD1OdyhlRxcvYW4eSa50vmVrXZHz33TVBwQeCd5
        ff5Q/n3aAsArvNHEVVZFGm++feNVcvm5Ih3tdwSoBP09q6pgecUccr670dHPl+vk
        9ArL1E1kQD0cS3MMciFila9785HvItTcyhfVP3YWXmZ8RHiTlqOMO7rx9Jm3mzS6
        s4ztCn1+7MsS5KrwuTmR4ZNjl8ppRNRnEtswbd8XV/eDq4Z2rb0ueOBytj5UpuPD
        Q==
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id 72DED30AE001;
        Sun, 27 Nov 2022 09:10:05 +0100 (CET)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 2AR8A5lQ000718;
        Sun, 27 Nov 2022 09:10:05 +0100
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 2AR8A5nY000717;
        Sun, 27 Nov 2022 09:10:05 +0100
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     "Marc Kleine-Budde" <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ctucanfd: Drop obsolete dependency on COMPILE_TEST
Date:   Sun, 27 Nov 2022 09:09:57 +0100
User-Agent: KMail/1.9.10
Cc:     Jean Delvare <jdelvare@suse.de>, linux-can@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        =?utf-8?q?Mat=C4=9Bj_Vasilevski?= <matej.vasilevski@gmail.com>
References: <20221124141604.4265225f@endymion.delvare> <202211241556.38957.pisa@cmp.felk.cvut.cz> <20221125155758.ji5djevvycduuykt@pengutronix.de>
In-Reply-To: <20221125155758.ji5djevvycduuykt@pengutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202211270909.57804.pisa@cmp.felk.cvut.cz>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 of November 2022 16:57:58 Marc Kleine-Budde wrote:
> On 24.11.2022 15:56:38, Pavel Pisa wrote:
> > Thanks for the care. I cannot judge change on my personal opinion.
> > But if that is general direction even for other drivers
> > then I confirm the change.
>
> Should I convert this into a formal Acked-by: :)

I you prefer formal one and agree with the change then yes.

Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

