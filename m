Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029556AD040
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCFV2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCFV2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:28:30 -0500
X-Greylist: delayed 27250 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 13:28:23 PST
Received: from 11.mo581.mail-out.ovh.net (11.mo581.mail-out.ovh.net [87.98.173.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BCE34F46
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:28:22 -0800 (PST)
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.1.239])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 2C33323ECE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:54:11 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-smxjb (unknown [10.110.103.53])
        by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id ADA691FE09;
        Mon,  6 Mar 2023 13:54:10 +0000 (UTC)
Received: from RCM-web1.webmail.mail.ovh.net ([176.31.238.120])
        by ghost-submission-6684bf9d7b-smxjb with ESMTPSA
        id S5nvKILwBWTX2QAA7mgTHA
        (envelope-from <rafal@milecki.pl>); Mon, 06 Mar 2023 13:54:10 +0000
MIME-Version: 1.0
Date:   Mon, 06 Mar 2023 14:54:10 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/8] nvmem: Let layout drivers be modules
In-Reply-To: <20230301152239.531194-1-miquel.raynal@bootlin.com>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <88b8ed4babd8c2d00ff4a4d8876378ba@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17330695793049316336
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtkedgvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtjehjtddtredvnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeeivddvleejhedvjeeugffhudetfedugfefueduvdeuveetvdfhtdeugffhteeiteenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduvdejrddtrddtrddupdduleegrddukeejrdejgedrvdeffedpudejiedrfedurddvfeekrdduvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-01 16:22, Miquel Raynal wrote:
> The base series on which these changes apply is still contained in [1],
> I would prefer to keep it as it was and apply this series on top of it.
> 
> (...)
> 
> [1] https://github.com/miquelraynal/linux/tree/nvmem-next/layouts

My experience with kernel development over all subsystems I touched is
that patches should be improved until being clean & acceptable. I never
sent a series with more recent patches fixing issues in earlier patches
of the same seriee.

So my preference would be to get a new, clean & complete set of patches.
