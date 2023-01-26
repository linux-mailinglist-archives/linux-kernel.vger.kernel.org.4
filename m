Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77DA67D36A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjAZRmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjAZRme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:42:34 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Jan 2023 09:42:33 PST
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F7D6D5F7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:42:33 -0800 (PST)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230126174128e36964c33bf68108e4
        for <linux-kernel@vger.kernel.org>;
        Thu, 26 Jan 2023 18:41:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KO6hf+CPKb+kyZe/tzFWxI+3m1X7vAFdAbD49859oG4=;
 b=GCJi+ZvDjB/eP4upbG8f1swqFfcq6z7+bddmwQYirJEg6Mp1S2a7VNZr7ILeN28J7Kipb1
 09Vq/EM4z3AKrGhKRpayDMz336f2hrKkldbVeWi9qS/Jn7jbMB9M0Z5yaJKF734BC4yGg/YT
 PiyYJ7w1DJ4lwylzyd8lKf4n0XPFM=;
Message-ID: <2ad9f8a7528818b9509f62278b42e5bc6d210054.camel@siemens.com>
Subject: Re: [ANNOUNCE] 5.10.162-rt79
From:   Florian Bezdeka <florian.bezdeka@siemens.com>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>
Date:   Thu, 26 Jan 2023 18:41:27 +0100
In-Reply-To: <Y9KOvZH61omPpn/3@uudg.org>
References: <Y9KOvZH61omPpn/3@uudg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, especially to stable-rt maintainers,

On Thu, 2023-01-26 at 11:31 -0300, Luis Claudio R. Goncalves wrote:
> I'm pleased to announce the 5.10.162-rt79 stable release.
>=20
> This release contains a single change, a fix to the aarch64 build failure
> I introduced while fixing merge conflicts in 5.10.162-rt78.

The CIP (see [1] for technical infos about CIP) kernel maintainers
(especially Pavel) noticed this build failure while trying to prepare
the next 5.10 based rt-cip release.

Looking at the kernel CI logs [2] this build failure was detected by
kernel-ci as well but it seems the build result did not make it back to
the maintainers. Is that correct?

From the CIP projects perspective we would like to improve the
situation.

From my perspective the following could be done:

  - Instead of (or in addition to) building and testing released -rt
    branches enable testing of -rt release candidates
  - Make sure the build results get back to the maintainers

I'm not sure if every -rt branch has a -rc branch. I'm not familiar
with the -rt release process yet.

What do you think? Does that make sense?

The discussion did not start yet, but it might be possible that I'm
able to do such kernel-ci improvements under the CIP umbrella.

Best regards,
Florian

[1] https://wiki.linuxfoundation.org/civilinfrastructureplatform/start
[2] https://linux.kernelci.org/build/rt-stable/branch/v5.10-rt/kernel/v5.10=
.162-rt78/

>=20
> You can get this release via the git tree at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>=20
>   branch: v5.10-rt
>   Head SHA1: 10ea07eb47e2f5a82c5dabba993635c73c11592f
>=20
