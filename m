Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981A06AD13C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCFWMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCFWMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:12:05 -0500
X-Greylist: delayed 16699 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 14:12:03 PST
Received: from 11.mo583.mail-out.ovh.net (11.mo583.mail-out.ovh.net [46.105.47.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B676E3A86A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:12:03 -0800 (PST)
Received: from director1.ghost.mail-out.ovh.net (unknown [10.108.1.240])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 3C200253DC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:06:36 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-mkdzr (unknown [10.110.208.100])
        by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id DD95C1FE62;
        Mon,  6 Mar 2023 14:06:35 +0000 (UTC)
Received: from RCM-web1.webmail.mail.ovh.net ([176.31.238.120])
        by ghost-submission-6684bf9d7b-mkdzr with ESMTPSA
        id d61TLmvzBWTgkQoAZ9SXKg
        (envelope-from <rafal@milecki.pl>); Mon, 06 Mar 2023 14:06:35 +0000
MIME-Version: 1.0
Date:   Mon, 06 Mar 2023 15:06:35 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Michael Walle <michael@walle.cc>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/8] nvmem: Let layout drivers be modules
In-Reply-To: <d46241e139b7a1e96705402a42f9bf31@walle.cc>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
 <ee7923a8b5fa8358e6805d20df7d8049@walle.cc> <20230306143528.7407fda5@xps-13>
 <73a04afaf658292c05ef27117c60b21d@milecki.pl>
 <d46241e139b7a1e96705402a42f9bf31@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <75856a2c7099bad906e6b0c5475a3b7e@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17540394650260122608
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -85
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtkedgfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepudeivdethfeuffegtedukeeutedvtdffleeuuefhleffffekledugeelgffgleeunecuffhomhgrihhnpehrvggsrghsvgdrmhhhnecukfhppeduvdejrddtrddtrddupdduleegrddukeejrdejgedrvdeffedpudejiedrfedurddvfeekrdduvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekfedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-06 15:03, Michael Walle wrote:
> Am 2023-03-06 14:57, schrieb Rafał Miłecki:
>> On 2023-03-06 14:35, Miquel Raynal wrote:
>>> Hi Michael,
>>> 
>>> michael@walle.cc wrote on Mon, 06 Mar 2023 14:01:34 +0100:
>>> 
>>>> > Miquel Raynal (8):
>>>> >   of: Fix modalias string generation
>>>> >   of: Change of_device_get_modalias() main argument
>>>> >   of: Create an of_device_request_module() receiving an OF node
>>>> >   nvmem: core: Fix error path ordering
>>>> >   nvmem: core: Handle the absence of expected layouts
>>>> >   nvmem: core: Request layout modules loading
>>>> >   nvmem: layouts: sl28vpd: Convert layout driver into a module
>>>> >   nvmem: layouts: onie-tlv: Convert layout driver into a module
>>>> 
>>>> With the fixes series [1] applied:
>>> 
>>> Thanks for the series! Looks good to me. I believe both series can 
>>> live
>>> in separate tress, any reason why we would like to avoid this? I am 
>>> keen
>>> to apply [1] into the mtd tree rather soon.
>> 
>> Given past events with nvmem patches I'm against that.
>> 
>> Let's wait for Srinivas to collect pending patches, let them spend a
>> moment in linux-next maybe, ask Srinivas to send them to Greg early if
>> he can. That way maybe you can merge Greg's branch (assuming he 
>> doesn't
>> rebase).
> 
> Mh? None of these fixes have anything to do with nvmem (except maybe 
> patch
> 4/4). The bugs were just discovered while I was testing this series. 
> But
> OTOH they are kind of a prerequisite for this series. So what are you
> suggesting here?

I'm sorry, I didn't realize you are commenting on linked mtd series.
I thought you want to take nvmem patches series over mtd tree ;) My
bad.
