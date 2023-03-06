Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CF16AC880
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCFQpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjCFQoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:44:14 -0500
X-Greylist: delayed 7525 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 08:43:49 PST
Received: from 14.mo550.mail-out.ovh.net (14.mo550.mail-out.ovh.net [178.32.97.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256753BD92
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:43:49 -0800 (PST)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.143.183])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id 9F7F8230AB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:23:51 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-dqffs (unknown [10.110.103.233])
        by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id E3EF11FD28;
        Mon,  6 Mar 2023 14:23:50 +0000 (UTC)
Received: from RCM-web1.webmail.mail.ovh.net ([176.31.238.120])
        by ghost-submission-6684bf9d7b-dqffs with ESMTPSA
        id GltaNXb3BWSE4wAALXMDEQ
        (envelope-from <rafal@milecki.pl>); Mon, 06 Mar 2023 14:23:50 +0000
MIME-Version: 1.0
Date:   Mon, 06 Mar 2023 15:23:50 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/8] nvmem: Let layout drivers be modules
In-Reply-To: <20230306151829.57c689b4@xps-13>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
 <ee7923a8b5fa8358e6805d20df7d8049@walle.cc> <20230306143528.7407fda5@xps-13>
 <73a04afaf658292c05ef27117c60b21d@milecki.pl>
 <20230306151829.57c689b4@xps-13>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0b94d38a25f5d8ea70f228213ba14fa4@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17831721252273499120
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -85
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtkedgfeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepjedvlefguedthfefleehgeeftdeludeluedvgfeffeevhfevtdehteejteefheegnecukfhppeduvdejrddtrddtrddupdduleegrddukeejrdejgedrvdeffedpudejiedrfedurddvfeekrdduvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheehtddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-06 15:18, Miquel Raynal wrote:
> Hi Rafał,
> 
> rafal@milecki.pl wrote on Mon, 06 Mar 2023 14:57:03 +0100:
> 
>> On 2023-03-06 14:35, Miquel Raynal wrote:
>> > Hi Michael,
>> >
>> > michael@walle.cc wrote on Mon, 06 Mar 2023 14:01:34 +0100:
>> >
>> >> > Miquel Raynal (8):
>> >> >   of: Fix modalias string generation
>> >> >   of: Change of_device_get_modalias() main argument
>> >> >   of: Create an of_device_request_module() receiving an OF node
>> >> >   nvmem: core: Fix error path ordering
>> >> >   nvmem: core: Handle the absence of expected layouts
>> >> >   nvmem: core: Request layout modules loading
>> >> >   nvmem: layouts: sl28vpd: Convert layout driver into a module
>> >> >   nvmem: layouts: onie-tlv: Convert layout driver into a module
>> >> >> With the fixes series [1] applied:
>> >
>> > Thanks for the series! Looks good to me. I believe both series can live
>> > in separate tress, any reason why we would like to avoid this? I am > keen
>> > to apply [1] into the mtd tree rather soon.
>> 
>> Given past events with nvmem patches I'm against that.
>> 
>> Let's wait for Srinivas to collect pending patches, let them spend a
>> moment in linux-next maybe, ask Srinivas to send them to Greg early if
>> he can. That way maybe you can merge Greg's branch (assuming he 
>> doesn't
>> rebase).
> 
> Just to be on the same page, we're talking about the mtd core fixups to
> handle correctly probe deferrals in the nvmem side.
> 
> Applying mtd patches then nvmem patches is totally fine in this order.
> Applying nvmem patches and then mtd patches creates a range of commits
> where some otp devices might have troubles probing if:
> - a layout driver is used
> - the driver is compiled as a module
> - the driver is also not installed in an initramfs
> 
> I was actually asking out loud whether we should care about this
> commit range given the unlikelihood that someone would have troubles
> with this while bisecting a linux-next kernel.
> 
> So getting an immutable tag from Greg would not help. The opposite
> might make sense though, and involves that I apply [1] to mtd/next
> rather soon anyway, I guess?

The problem IIUC is nvmem.git / for-next containing broken code after
adding nvmem stuff. That is unless Srinivas takes your patches in some
way. Hopefully not by waiting for 6.4-rc1.
