Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0E76EE8BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbjDYT71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjDYT7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:59:25 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AA97EFA;
        Tue, 25 Apr 2023 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L86vp4MEciQORrOWppaUSzqRnFQPmYv8ta/VZMl77TM=; b=zx+UuNU6lahZPACsb2q1UTojlV
        yW9Ahnj+WukU4bTx/YnJG4l4Rf3QF4DhZ8z4a4FOPi1dJ3LSCPGsXfGZIthZSsKoO+JPfZyWrzmaT
        ZTrCN3QNidi6WxhuXrHADUoaROzRP54i0shcl4fzNBs2p6EroJaVE+7lRdHE3jIwsbF8SyGPIjCAc
        BhEhNPRc3wFoF9JaTd5l2CTwRmCG8pRJaL2KxDzvO6mq7q/+ZQtycDoLSwCXHeMt/N7FQVjwGqO56
        CMruS9CKTjFTxmycKjMABObKny6vE4hgX7W4heLSn7BZ3uluNJ8SBfy22uGb1sMXfQAzx13+RD6pg
        LDqngO2g==;
Received: from p200300ccff17ff001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff17:ff00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1prOoL-0005dy-Jq; Tue, 25 Apr 2023 21:58:49 +0200
Date:   Tue, 25 Apr 2023 21:58:48 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED REGRESSION] OMAP1 GPIO breakage
Message-ID: <20230425215848.247a936a@aktux>
In-Reply-To: <20230425193637.GH444508@darkstar.musicnaut.iki.fi>
References: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
        <20230425201117.457f224c@aktux>
        <20230425183857.GG444508@darkstar.musicnaut.iki.fi>
        <20230425212040.5a4d5b09@aktux>
        <20230425193637.GH444508@darkstar.musicnaut.iki.fi>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 22:36:37 +0300
Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> On Tue, Apr 25, 2023 at 09:20:40PM +0200, Andreas Kemnade wrote:
> > Aaro Koskinen <aaro.koskinen@iki.fi> wrote:  
> > > Which commit introduced that regression? Also, the changelog mentions
> > > it happens only with "unusual" probe order. Now, all the ordinary cases
> > > for OMAP1 are broken.
> > >   
> > did not bisect that to an exact commit.
> > Unusual probe order: on the device where I tested it,
> > I did not see a completely successful probe.  
> 
> If you cannot point out a working past commit, there was no regression. If
> you fix something that hasn't worked before or has been long time broken,
> it must not cause breakage to other current users.
> 
Well, I did not take the time for a bisect. As we need a less aggressive
fix, it seems to be worth doing it. 

> > > And it's not just that tps65010 thing. E.g. 770 fails to boot as well
> > > and it doesn't use it; and reverting 92bf78b33b0b fixes that one as
> > > well. AFAIK it's because all the gpio_request()s in OMAP1 board files
> > > stopped now working.
> > >   
> > so we break every non-devicetree user of omap-gpio?   
> 
> It seems so.
> 
or maybe an if (not_using_devicetree())

Regards,
Andreas
