Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898B674D972
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjGJPDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjGJPCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:02:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A00127;
        Mon, 10 Jul 2023 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=sXd8fOLlAD3XJ6DIwb78DhwDpyb7fuPEHcC/aPSb/gc=;
        t=1689001368; x=1690210968; b=XVwhYssLpdLBnXqXjbzYGELl3TEydzxLWmGXcfhUI1LguJf
        7sPifFt3Yu1/rukcIrRLrBrWKF8HPqfv0VbrM7kD0+v9sTQFqngVUFadMxcPTaBmtJYYrBQNWsQKv
        L9mIM7TaZJg79cuB0AsP4VzAdPP3+6vGnCaq2TIwshyyTapcDMykx1LlJz/lEvGn6u09erivMXTYk
        aDLENC0xngbKgV3+LxQmmQSGMj0X+Ftah2BStUMsEklmGfXADX3W5zFZH/D4Gv2LdKyRPpgD0sSfZ
        6zITbhRg1EB2Da4eIT1bLLB297hr+Ylno1pyoqXw9EAq061sbIxuXfBEFSMv9h8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qIsPR-00EgUu-0L;
        Mon, 10 Jul 2023 17:02:41 +0200
Message-ID: <047c7bdc8057175f2bb78981a5f1a1aa6b493153.camel@sipsolutions.net>
Subject: Re: [regression] iwlwifi driver broken on Intel 3165 network card
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Aloka Dixit <quic_alokad@quicinc.com>,
        John Crispin <john@phrozen.org>
Cc:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 10 Jul 2023 17:02:40 +0200
In-Reply-To: <6f8715af-95c2-8333-2b32-206a143ebb52@leemhuis.info>
References: <6f8715af-95c2-8333-2b32-206a143ebb52@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-10 at 10:32 +0200, Linux regression tracking (Thorsten
Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
>=20
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developers don't keep an eye on it, I decided to forward it by mai=
l.
>=20
> Aloka Dixit, apparently it's cause by a change of yours: bd54f3c2907
> ("wifi: mac80211: generate EMA beacons in AP mode") [v6.4-rc1]
>=20

That bisect result seems unlikely to be correct. Those changes are in
"how to get beacons" (in AP mode) which isn't even used in client mode
here.

johannes
