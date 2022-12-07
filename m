Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C485645A16
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLGMne convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 07:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLGMn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:43:28 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941C342F75;
        Wed,  7 Dec 2022 04:43:27 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 7E73310000A;
        Wed,  7 Dec 2022 12:43:23 +0000 (UTC)
Message-ID: <f0ccee0d2f85099c146ee682b25d30c832155fa3.camel@hadess.net>
Subject: Re: [PATCH v1 2/2] HID: logitech-hidpp: Add Bluetooth Mouse
 M336/M337/M535 to unhandled_hidpp_devices[]
From:   Bastien Nocera <hadess@hadess.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date:   Wed, 07 Dec 2022 13:43:23 +0100
In-Reply-To: <nycvar.YFH.7.76.2212071117420.6045@cbobk.fhfr.pm>
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher>
         <2283816.ElGaqSPkdT@kreacher>
         <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net>
         <CAJZ5v0ibpzoBLXKiqzciYv1Htks0=4+4_XGLvpH7MCyFoYJiDg@mail.gmail.com>
         <CAO-hwJL7n7HFk4MTKvLcvBPSLDwm9pHqLaZvmuwvSNDVWUF76g@mail.gmail.com>
         <nycvar.YFH.7.76.2212071117420.6045@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-12-07 at 11:19 +0100, Jiri Kosina wrote:
> On Wed, 7 Dec 2022, Benjamin Tissoires wrote:
> 
> > Agree, but OTOH, Rafael, your mouse is not brand new AFAICT, so I
> > am 
> > worried that you won't be the only one complaining we just killed
> > their 
> > mouse. So I think the even wiser solution would be to delay (and so
> > revert in 6.1 or 6.2) the 2 patches that enable hid++ on all
> > logitech 
> > mice (8544c812e43ab7bdf40458411b83987b8cba924d and 
> > 532223c8ac57605a10e46dc0ab23dcf01c9acb43).
> 
> If we were not at -rc8 timeframe, I'd be in favor to coming up with
> proper 
> fix still for 6.1. But as things currently are, let's just revert
> those 
> and reschedule them with proper fix for 6.2+.

Has anyone seen any other reports?

Because, honestly, seeing work that adds support for dozens of devices
getting tossed out at the last minute based on a single report with no
opportunity to fix the problem is really frustrating.
