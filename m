Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84416D341C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 23:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDAVjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 17:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAVj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 17:39:29 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C171880F;
        Sat,  1 Apr 2023 14:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nq+wVlpePRQY2WWVL6tQTzkVmNZ7Jw4IvnL2MwD+skY=; b=hL1OEayWzlSO6rrTZwbNOwx0/T
        YhLh0NO8HA8DFC3rLBud7OjpuWCdBhNM0fJ6zdowLldJnCqfS0eCPakKPeJYHXjhDvf1c2Bqh88kP
        bnQrlP/8jbVZUdg8T2oOZ8h1vq23zzhpwfyT++peQsXMKbhnvd1x9NAgj4si36UjiENgsmcuSSJmq
        wmZ6B+DTkMyeHAKDzcoFSbnswdjesb2/vFTUQdNjvJJt20mMyIImU2A19Foa5Kq14jxFOkbO35POJ
        u+aix5ypPMQr4jS0YYHA5kfMRx4wrsMfJjcMQvrX+Mz12FN2JNqI0y+n2tsBF4h70Q5y97RZJJjTt
        kRDQ+kaA==;
Received: from p200300ccff2d4a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2d:4a00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1piiwP-0000Aw-8q; Sat, 01 Apr 2023 23:39:17 +0200
Date:   Sat, 1 Apr 2023 23:39:16 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Tom Rix <trix@redhat.com>, nathan@kernel.org,
        ndesaulniers@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] power: supply: twl4030-charger: remove unused cur_reg
 variable
Message-ID: <20230401233916.374ffe1a@aktux>
In-Reply-To: <20230401203026.nzk4aygv7sr7quhe@mercury.elektranox.org>
References: <20230401113432.1873847-1-trix@redhat.com>
        <20230401203026.nzk4aygv7sr7quhe@mercury.elektranox.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Apr 2023 22:30:26 +0200
Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

> Hi,
> 
> On Sat, Apr 01, 2023 at 07:34:32AM -0400, Tom Rix wrote:
> > clang with W=1 reports
> > drivers/power/supply/twl4030_charger.c:242:16: error: variable
> >   'cur_reg' set but not used [-Werror,-Wunused-but-set-variable]
> >         unsigned reg, cur_reg;
> >                       ^
> > This variable is not used so remove it.
> > 
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  drivers/power/supply/twl4030_charger.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
> > index 7adfd69fe649..5fa5b2311330 100644
> > --- a/drivers/power/supply/twl4030_charger.c
> > +++ b/drivers/power/supply/twl4030_charger.c
> > @@ -239,7 +239,7 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
> >  {
> >  	int status;
> >  	int cur;
> > -	unsigned reg, cur_reg;
> > +	unsigned reg;
> >  	u8 bcictl1, oldreg, fullreg;
> >  	bool cgain = false;
> >  	u8 boot_bci;
> > @@ -357,11 +357,9 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
> >  	status = twl4030_bci_read(TWL4030_BCIIREF1, &oldreg);
> >  	if (status < 0)
> >  		return status;
> > -	cur_reg = oldreg;
> >  	status = twl4030_bci_read(TWL4030_BCIIREF2, &oldreg);
> >  	if (status < 0)
> >  		return status;
> > -	cur_reg |= oldreg << 8;
> >  	if (reg != oldreg) {  
> 
> I think the correct fix would be checking for (reg != cur_reg) here.
> 
yes, makes more sense.

Regards,
Andreas
