Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511BD69D907
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 03:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjBUCyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 21:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjBUCyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 21:54:47 -0500
X-Greylist: delayed 17352 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 18:54:17 PST
Received: from 19.mo582.mail-out.ovh.net (19.mo582.mail-out.ovh.net [188.165.56.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4854234DC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 18:54:17 -0800 (PST)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.146.168])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 68BA222F90
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 22:05:03 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-kgbzl (unknown [10.110.171.164])
        by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id A846A1FDED;
        Mon, 20 Feb 2023 22:05:01 +0000 (UTC)
Received: from RCM-web1.webmail.mail.ovh.net ([176.31.238.120])
        by ghost-submission-6684bf9d7b-kgbzl with ESMTPSA
        id +fnGJo3u82PxBzoAs5WIMg
        (envelope-from <rafal@milecki.pl>); Mon, 20 Feb 2023 22:05:01 +0000
MIME-Version: 1.0
Date:   Mon, 20 Feb 2023 23:05:01 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] nvmem: add generic driver for devices with MMIO
 access
In-Reply-To: <2f9aa86e-40e1-91f6-06b2-c79d62f7a136@infradead.org>
References: <20230220174930.7440-1-zajec5@gmail.com>
 <20230220174930.7440-3-zajec5@gmail.com>
 <2f9aa86e-40e1-91f6-06b2-c79d62f7a136@infradead.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <c4fd4ca4e550bd7de909269e8eedd5f6@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17189958306374331355
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudejhedgudehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepjedvlefguedthfefleehgeeftdeludeluedvgfeffeevhfevtdehteejteefheegnecukfhppeduvdejrddtrddtrddupdduleegrddukeejrdejgedrvdeffedpudejiedrfedurddvfeekrdduvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekvddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-20 20:55, Randy Dunlap wrote:
> On 2/20/23 09:49, Rafał Miłecki wrote:
>> +static int mmio_nvmem_write(void *context, unsigned int offset, void 
>> *val, size_t bytes)
>> +{
>> +	struct mmio_nvmem *priv = context;
>> +
>> +	switch (priv->io_width) {
>> +	case 1:
>> +	case 2:
>> +	case 4:
>> +		return -EOPNOTSUPP;
> 
> I'm just curious: (since read supports those cases)
> 
> what size writes are typically used here?
> And what value for priv->io_width?

Sorry, I really don't have any statistics on this or any real overview
of hardware that supports MMIO writes. It's probably a minority of
devices that allows it.
