Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE68968081C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbjA3JC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbjA3JCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:02:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D32718;
        Mon, 30 Jan 2023 01:02:52 -0800 (PST)
Date:   Mon, 30 Jan 2023 10:02:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675069369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6fIFcywVaxJrMhVVv8btTwEym2El5BtVTKT/UKLhpU0=;
        b=BISmPm+DMZuR+8kXO3uyYDHZqeXB8sGpXJ2NlezzBDKiHydN4kOzqtn34It9avBNbehM3C
        /gWN0LdwoRb0h9NgeM5CMlYNlOZXpLiDS+6JdcJUgKoNUrmCzWLoFkX/scXd5N36g2+lvk
        1nysNAZ6bPgoM1f9YUNNpXWCy0ZDeoicbqhbnqpmGnKYlIlTTk/EBDDnH9Gd8LtLZnun2q
        RrvAz2BRK7VorrhUsATZyA6d1ftN4uGPBVpIJzaLRp1ZLXucBDR/CgH27EXbMQxSy4Gw83
        xaqjhfIGH3m2OvL94WWb3hl67oqFSnCk6GEi/Li68NZ1hdzr9BJd9iNqnXfUJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675069369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6fIFcywVaxJrMhVVv8btTwEym2El5BtVTKT/UKLhpU0=;
        b=2NOyfTV5NunsOSBHrLICuz0jmkHrzR/OKkZnoLgO0zq9r4dQj2dyqzAaOfroNtJOn2Wh5b
        ooNaCchfHOWLq8CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [rt-devel:linux-6.2.y-rt-rebase] [printk]  5342b8e20b:
 hwsim.ap_ft_eap_cui.fail
Message-ID: <Y9eHtTgQ0Pmz2gql@linutronix.de>
References: <202301242146.213fe56e-oliver.sang@intel.com>
 <Y8/mviV4zZbxgy1x@linutronix.de>
 <Y9R+VfUgvU1U6DEj@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y9R+VfUgvU1U6DEj@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-28 09:45:57 [+0800], Oliver Sang wrote:
> hi Sebastian,
Hi Oliver,

> we rebuilt the kernel for both this commit and its parent, and make sure =
the
> config are same for both (as attached, actually also same to the config w=
e used
> in last tests for oiginal report), then rerun the tests more times, but t=
he
> issue seems still persistent
>=20
> d144a18b3d136079 5342b8e20b15e5fb37e49de2435
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :20         100%          20:20    hwsim.ap_ft_eap_cui.fail
>            :20         100%          20:20    hwsim.ap_ft_many.fail
>            :20         100%          20:20    hwsim.ap_ft_pmf_bip_cmac_12=
8.fail
>=20
> attached one dmesg for this commit and another for parent FYI.

|  wlan0: send auth to 02:00:00:00:03:00 (try 1/3)
| +wlan0: send auth to 02:00:00:00:03:00 (try 2/3)
| +wlan0: send auth to 02:00:00:00:03:00 (try 3/3)
|  wlan0: authenticated
|  wlan0: associate with 02:00:00:00:03:00 (try 1/3)
| -wlan0: RX ReassocResp from 02:00:00:00:03:00 (capab=3D0x411 status=3D0 a=
id=3D1)
=E2=80=A6
| -wlan0: associated
=E2=80=A6
| +wlan0: RX ReassocResp from 02:00:00:00:03:00 (capab=3D0x411 status=3D55 =
aid=3D1)
| +wlan0: 02:00:00:00:03:00 denied association (code=3D55)

It is hard to comprehend that the printk change broke wifi/ hwsim. Let
me add John to see what he thinks.

> BTW, we noticed PREEMPT_RT is mentioned in commit message, but we didn't =
enable
> it in our config, not sure if this is relevant?

These printk changes are kind of staged for upstream inclusion. "kind
of" because John is reworking them. So either I broke something while
rebasing them or the timing changed and this pops up. The 6.1 series had
mostly the same printk code. This should work independent of PREEMPT_RT.

Sebastian
