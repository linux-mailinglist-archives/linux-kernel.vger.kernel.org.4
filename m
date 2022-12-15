Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFBC64DD1C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiLOOs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLOOst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:48:49 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2802F641;
        Thu, 15 Dec 2022 06:48:46 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id c0c6e7946502b002; Thu, 15 Dec 2022 15:48:45 +0100
Received: from kreacher.localnet (unknown [213.134.188.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4D8B71DE5297;
        Thu, 15 Dec 2022 15:48:44 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] HID: Revert catchall handling of Bluetooth device in hid-logitech-hidpp
Date:   Thu, 15 Dec 2022 15:48:43 +0100
Message-ID: <2659428.mvXUDI8C0e@kreacher>
In-Reply-To: <4787931.31r3eYUQgx@kreacher>
References: <20221207142433.1158329-1-benjamin.tissoires@redhat.com> <nycvar.YFH.7.76.2212071757220.6045@cbobk.fhfr.pm> <4787931.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.188.201
X-CLIENT-HOSTNAME: 213.134.188.201
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepvddufedrudefgedrudekkedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeekrddvtddupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepsggvnhhjrghmihhnrdhtihhsshhoihhrvghssehrvgguhhgrthdrtghomhdprhgtphhtthhopehjihhkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrghinhhssehrihhsvghuphdrnhgvthdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvghtpdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhgvvghmhhhu
 ihhsrdhinhhfohdprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 12, 2022 6:03:07 PM CET Rafael J. Wysocki wrote:
> On Wednesday, December 7, 2022 5:57:47 PM CET Jiri Kosina wrote:
> > On Wed, 7 Dec 2022, Benjamin Tissoires wrote:
> > 
> > > We are basically too late in the 6.1 cycle to be able to do anything
> > > else. Let's revert these 2 patches as we are in a situation where we
> > > would break too many users.
> > > 
> > > We will reintroduce them during the next cycle with proper fixes in the
> > > driver.
> > 
> > Rafael,
> > 
> > it would be nice to get
> > 
> > 	Reported-by:
> > 	Tested-by:
> > 
> > for these reverts if possible.
> 
> I had been offline for the previous 3 days, sorry.
> 
> I'll test 6.1 and let you know.

Sorry for the delay.

I have tested final 6.1 on the affected machine and I can confirm that it works well.

Thanks!



