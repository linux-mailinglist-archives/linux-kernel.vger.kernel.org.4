Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C181715CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjE3LPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjE3LPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:15:43 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A5A93
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:15:42 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 4f256f9d-fedb-11ed-b3cf-005056bd6ce9;
        Tue, 30 May 2023 14:15:40 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 30 May 2023 14:15:39 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v4 0/9] serial: sc16is7xx: fix GPIO regression and rs485
 improvements
Message-ID: <ZHXa23WFb9vNG-T2@surfacebook>
References: <20230529140711.896830-1-hugo@hugovil.com>
 <ZHUnwNNcU_EnS4bo@surfacebook>
 <20230529220708.66f7825fed9ee36b181128cf@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529220708.66f7825fed9ee36b181128cf@hugovil.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 29, 2023 at 10:07:08PM -0400, Hugo Villeneuve kirjoitti:
> On Tue, 30 May 2023 01:31:28 +0300
> andy.shevchenko@gmail.com wrote:
> > Mon, May 29, 2023 at 10:07:02AM -0400, Hugo Villeneuve kirjoitti:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > Hello,
> > > this patch series mainly fixes a GPIO regression and improve RS485 flags and
> > > properties detection from DT.
> > > 
> > > It now also includes various small fixes and improvements that were previously
> > > sent as separate patches, but that made testing everything difficult.
> > > 
> > > Patch 1 fixes an issue when debugging IOcontrol register. After testing the GPIO
> > > regression patches (patches 6 and 7, tests done by Lech Perczak), it appers that
> > > this patch is also necessary for having the correct IOcontrol register values.
> > > 
> > > Patch 2 introduces a delay after a reset operation to respect datasheet
> > > timing recommandations.
> > 
> > These two patches are w/o Fixes tag, they should be moved in the series further
> > as I explained before.
> 
> Your explanation was not clear.

Sorry if it feels like this. The documentation should have more clarity
on the matter.

> Anyway, I moved them in position 7 and 8.

Thank you, but take also what Greg KH replied to you into consideration.
He is the maintainer and seems other patches needs some additional work
in the scope of Fixes / backport (see stable kernel patches flow in the
kernel documentation, which I also mentioned earlier).

-- 
With Best Regards,
Andy Shevchenko


