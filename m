Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65346050B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiJSTsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJSTsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:48:45 -0400
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EAF519E02C;
        Wed, 19 Oct 2022 12:48:44 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id DF543409F8; Wed, 19 Oct 2022 20:04:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org DF543409F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1666202689;
        bh=1HHZXkFh9povR5NiCygpNN0T8ybamjOo7OaZdu9z6eg=;
        h=Date:From:To:Cc:Subject:From;
        b=V35Jx1A5OzczOQh3xg8D0oBU4I0JA0RrH3EXKtvXrFyt7WCHJwjWFYlGrNiSRXEYW
         RozswnXqa2c/snv3qmkSovC5/EjxRYX4HTcENag+MdYAbBqXh/oxMOlrN7D8Gm1o9A
         PL65UidRsYP6LlnIDMoKt8b2/mexpsy+lE0xapow=
Date:   Wed, 19 Oct 2022 20:04:49 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [GIT PULL REQUEST] watchdog - v5.1 release cycle.
Message-ID: <20221019180449.GA12018@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull following watchdog changes for the v5.19 release cycle.

This series contains:
* Add tracing events for the most usual watchdog events

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit 099d387ebbcd70c6adc906ab5b66ef639c09dede:

  watchdog: twl4030_wdt: add missing mod_devicetable.h include (2022-10-07 11:03:25 +0200)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.1-rc2

for you to fetch changes up to e25b091bed4946078c0998e4be77bc56824a9adf:

  watchdog: Add tracing events for the most usual watchdog events (2022-10-12 09:47:02 +0200)

----------------------------------------------------------------
linux-watchdog 6.1-rc2 tag

----------------------------------------------------------------
Uwe Kleine-König (1):
      watchdog: Add tracing events for the most usual watchdog events

 MAINTAINERS                      |  1 +
 drivers/watchdog/watchdog_core.c |  4 +++
 drivers/watchdog/watchdog_dev.c  | 12 ++++++--
 include/trace/events/watchdog.h  | 66 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/watchdog.h
----------------------------------------------------------------

Kind regards,
Wim.

