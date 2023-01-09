Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430F8662370
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjAIKr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjAIKrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:47:45 -0500
X-Greylist: delayed 3005 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 02:47:43 PST
Received: from 8.mo576.mail-out.ovh.net (8.mo576.mail-out.ovh.net [46.105.56.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C01A22A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:47:43 -0800 (PST)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.108.1.93])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id 5749720837
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:52:34 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-78j8k (unknown [10.110.208.94])
        by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 201CB1FF6C;
        Mon,  9 Jan 2023 09:52:34 +0000 (UTC)
Received: from RCM-web6.webmail.mail.ovh.net ([151.80.29.20])
        by ghost-submission-6684bf9d7b-78j8k with ESMTPSA
        id pKYPBuLju2OyXwAA1nTmNw
        (envelope-from <rafal@milecki.pl>); Mon, 09 Jan 2023 09:52:34 +0000
MIME-Version: 1.0
Date:   Mon, 09 Jan 2023 10:52:33 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmem: u-boot-env: align endianness of crc32 values
In-Reply-To: <d0df69da-e881-46aa-da51-eb3b610dee57@linaro.org>
References: <20221012155133.287-1-musashino.open@gmail.com>
 <57f10c5d-2a71-7f8d-e2ab-6e868d8ba79b@linaro.org>
 <e8932e3eaf1bd9a690e2f41aad8faf3a@milecki.pl>
 <d0df69da-e881-46aa-da51-eb3b610dee57@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0857740baa7bd7fd2c3f5ff5a5cb911b@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16420687192283196379
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeigddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnheptdeihffftdefveffvdduvddttddvieekteefgeettedugedvgeelgfefleetgfegnecuffhomhgrihhnpehgihhtrdhnohifnecukfhppeduvdejrddtrddtrddupdduleegrddukeejrdejgedrvdeffedpudehuddrkedtrddvledrvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-09 10:48, Srinivas Kandagatla wrote:
> On 06/01/2023 19:15, Rafał Miłecki wrote:
>> On 2022-11-11 18:41, Srinivas Kandagatla wrote:
>>> On 12/10/2022 16:51, INAGAKI Hiroshi wrote:
>>>> This patch fixes crc32 error on Big-Endianness system by conversion 
>>>> of
>>>> calculated crc32 value.
>>>> 
>>>> Little-Endianness system:
>>>> 
>>>>    obtained crc32: Little
>>>> calculated crc32: Little
>>>> 
>>>> Big-Endianness system:
>>>> 
>>>>    obtained crc32: Little
>>>> calculated crc32: Big
>>>> 
>>>> log (APRESIA ApresiaLightGS120GT-SS, RTL8382M, Big-Endianness):
>>>> 
>>>> [    8.570000] u_boot_env 
>>>> 18001200.spi:flash@0:partitions:partition@c0000: Invalid calculated 
>>>> CRC32: 0x88cd6f09 (expected: 0x096fcd88)
>>>> [    8.580000] u_boot_env: probe of 
>>>> 18001200.spi:flash@0:partitions:partition@c0000 failed with error 
>>>> -22
>>>> 
>>>> Fixes: f955dc1445069 ("nvmem: add driver handling U-Boot environment 
>>>> variables")
>>>> 
>>>> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
>>>> ---
>>> 
>>> Applied thanks,
>> 
>> has this patch been lost somewhere in the process?
>> 
>> I'm quite sure I saw it in linux-next.git and probably in nvmem.git. 
>> Now
>> it seems to be gone.
> Yes, I had to revert this one as next reported sparse warnings [1]
> with this patch which were not addressed.

I missed that, thank you.

INAGAKI: could you take a look at this, please?
