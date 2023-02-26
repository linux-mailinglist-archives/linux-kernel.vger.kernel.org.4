Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AD26A2F26
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 11:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBZKvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 05:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBZKvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 05:51:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB91110260;
        Sun, 26 Feb 2023 02:51:42 -0800 (PST)
Date:   Sun, 26 Feb 2023 11:51:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677408700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdCgwPEZkdUaTdJD68lLnYRV7pxl7xMKq1uKteKL5Vs=;
        b=yeiHgmAGD3cKEuxhF8jTpXD05mPtzuEpgImdwC3h08oJGn8u8QLmWkod6P02xWH/iFE6Bl
        hVz3cRxyp7RpKCTNOU/K2XLuDJZ9LqKafsn6wdcAFheonTfxV8nKAwtOcZpgLAmng8unEV
        kjHTFZgy56fbEJ156hEHMgm9J6jGg2ZPbRWrlpQnNDev+eLpY+Y5Y0yb5i229twglf1cJ9
        nvFOV5uu08tQWkGxTs7b9Js0ZWoweYvsSvAY3bZZavvuFNDcBvLuQHiAARqMll/2C1uxNJ
        5mOAKXZY6UoQyWPr8bgCcctMkpqPnc1llZV/6KEazxRoIA5QenMhYgUI0ejyxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677408700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdCgwPEZkdUaTdJD68lLnYRV7pxl7xMKq1uKteKL5Vs=;
        b=lcLjTCBMD+jQnZV9Vs3BL40xy/kj5mp/WUDovgQuqHRvQR3CkuL8NeaKva70o50tgUOsO6
        2UbfJj5tvk+mLZCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Michael Everitt <gentoo@veremit.xyz>,
        Christian Eggers <ceggers@arri.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux-6.1-rt ?
Message-ID: <Y/s5ukYRqAzEj1AE@linutronix.de>
References: <12136223.O9o76ZdvQC@n95hx1g2>
 <208196df-d0b2-5cf6-29b3-4570a0946e77@veremit.xyz>
 <Y7/cYsEXHpCEGwwa@linutronix.de>
 <Y/nRRHo1XtRenC6u@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y/nRRHo1XtRenC6u@duo.ucw.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-25 10:13:40 [+0100], Pavel Machek wrote:
> Hi!
Hi,

> Apparently 6.1 left the Schr=C3=B6dinger state, and it is confirmed as LT=
S.

correct.

> If there are any news regarding 6.1-rt, world wants to know :-), but
> maybe that is better discussed on realtime meeting?

There was a v6.1-RT since then (last week). The handover needs to be
discussed on the realtime meeting, this is correct.

> Best regards,
> 								Pavel

Sebastian
