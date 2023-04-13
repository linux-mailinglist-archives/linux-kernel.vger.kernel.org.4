Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46246E0A75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDMJqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjDMJpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:45:55 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B26DA9EE2;
        Thu, 13 Apr 2023 02:45:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BFD6C80F0;
        Thu, 13 Apr 2023 09:45:45 +0000 (UTC)
Date:   Thu, 13 Apr 2023 12:45:44 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz,
        phone-devel@vger.kernel.org, maemo-leste@lists.dyne.org
Subject: Re: Motorola Droid 4 -- Stopping charger when battery is full
Message-ID: <20230413094544.GD36234@atomide.com>
References: <ZAcvuP8kmWveLoE/@duo.ucw.cz>
 <ef4409b2-abd8-0eac-f66e-6858c3358cc1@gmail.com>
 <20230309071443.GF7501@atomide.com>
 <ZDfNRogC4ruBE4Xy@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDfNRogC4ruBE4Xy@duo.ucw.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [230413 09:37]:
> 
> > * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [230307 14:10]:
> > > Also, some guys have concerns about charging (and keeping it charged) @4.35,
> > > because of the possibly reduced battery life.
> > 
> > Yes for devices connected to a charger for long periods the battery will
> > bloat up within some weeks or months. This happens easily when using a
> > lapdock for example.
> > 
> > A simple and safe solution here might be that we allow charging up to
> > 4.35V only once when the charger is connected. Then we let the voltage
> > decrease to 4.2V (or whatever known good maintenance voltage) if the
> > charger stays connected.
> 
> Optimum solution would be user specifying "I want battery full
> tommorow at 8am" and doing the right thing.

I think you can already do that via sysfs with cron or at :)

> > For folks wanting to force the charge voltage higher we have the sysfs
> > interface.
> 
> Yep, we just need to make sure it is usable for this.

It should be but I have not tried for years. You need to first configure
the allowed voltage for battery via sysfs, then set the charge voltage
for the charger.

Regards,

Tony
