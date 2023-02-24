Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416116A206C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBXRVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBXRVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:21:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792AF158BF;
        Fri, 24 Feb 2023 09:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hVqtr9A69/Si/EFagr+5HgP7SHagZOhLbSWzYrGADwQ=; b=LItUNW0Trf6fcGd6hJBbRaRstL
        stwDEmjolZnMfJzKOvSKW4DYjOQF4M9ihtyDTW+NSO9muiwINc+qKp872YxbNmSXZOtBbp1jPzWcB
        0QKG0gY2bl8FGPKU3bXzncEox6oIacRQXz4OstV3ASwysT0lZYHGHauRQWVNETlwEvZKVwQEVJTrj
        fzp41hf3DDTpzvH0y2TMv7beyY2/99ZbK9lvVM5jc5aOZXZRfXoBvL1fk1d/rqM0aIy8ZoRYIt01f
        7vIP7ZAsmkxsZ1+eqBnNo2w98KzuUK/F5XODOSBdoC36nrd4g4F21l6kJsjuhg/aT6loCGblVeZE6
        9WFxINYQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVblM-003IPG-2u; Fri, 24 Feb 2023 17:21:40 +0000
Date:   Fri, 24 Feb 2023 09:21:40 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 09/27] irqchip: remove MODULE_LICENSE in non-modules
Message-ID: <Y/jyJFXqlj9DlX9z@bombadil.infradead.org>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-10-nick.alcock@oracle.com>
 <86y1onw02k.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86y1onw02k.wl-maz@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 03:32:51PM +0000, Marc Zyngier wrote:
> On Fri, 24 Feb 2023 15:07:53 +0000,
> Nick Alcock <nick.alcock@oracle.com> wrote:
> > 
> > Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> > Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> > are used to identify modules. As a consequence, uses of the macro
> > in non-modules will cause modprobe to misidentify their containing
> > object file as a module when it is not (false positives), and modprobe
> > might succeed rather than failing with a suitable error message.
> > 
> > So remove it in the files in this commit, none of which can be built as
> > modules.
> > 
> > Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> > Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: linux-modules@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  drivers/irqchip/irq-renesas-rzg2l.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
> > index 25fd8ee66565..4bbfa2b0a4df 100644
> > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > @@ -390,4 +390,3 @@ IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
> >  IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
> >  MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
> >  MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
> > -MODULE_LICENSE("GPL");
> 
> I'm probably missing some context here, but I find it odd to drop
> something that is a important piece of information because of what
> looks like a tooling regression.
> 
> It also means that once a random driver gets enabled as a module, it
> won't load because it is now missing a MODULE_LICENSE() annotation.
> 
> It feels like MODULE_LICENSE should instead degrade to an empty
> statement when MODULE isn't defined. Why isn't this approach the
> correct one?
> 
> I expect the cover letter would have some pretty good information on
> this, but lore.kernel.org doesn't seem to have it at the time I write
> this ("Message-ID <20230224150811.80316-1-nick.alcock@oracle.com> not
> found").

The right thing is to not even have this and have the module license
inferred from the SPDX tag. But for now we want to remove the tag from
things we know for sure are not modules.

  Luis
