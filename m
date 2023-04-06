Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66C26D9FF2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbjDFSf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240239AbjDFSfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:35:52 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F679EEA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:35:50 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id kUSTpODywxZmMkUSUpEAxX; Thu, 06 Apr 2023 20:35:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1680806148;
        bh=UZh5/Mo43daJTwcFuQEwoE2zsf6dokq7Oj4UPELT3is=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hkPA3xO+BHGLZ6etPEH/S1JPDsOIS02G9QUIuSSJcdqYm4+pOpc/pyD4KZIjZcPyj
         4du/rkxggd9KUqW/gWqm09dVgVPSGj/G7iT0Z9YDU+rfkGULbOcevZA0eS793pyNm5
         nBKkFsYu78JEToy/kcAq4CLH28CnQHkwKJQNfE09Q064sVcP0QKpuE4UGBzQorgLMg
         ghlq6LOfQvN1dJo2ZybQOJaxS6or4aY+2v5cYoVAmlQ0C4a2/YjjDG7QM4Nn+Wn+OU
         o+9dT/ckL6stPOPhYE4ZgAgrMJzJR+sESSAiDmQvw8BYfk5Q1MbdcOcFFtQ6RLz5aN
         MSjeRNUkNmrpg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 Apr 2023 20:35:48 +0200
X-ME-IP: 86.243.2.178
Message-ID: <9628fe5d-62c0-b761-967b-357287e99a3e@wanadoo.fr>
Date:   Thu, 6 Apr 2023 20:35:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: RE: [EXTERNAL] Re: [PATCH v10] ASoC: tas2781: Add tas2781 driver
To:     "Ding, Shenghao" <shenghao-ding@ti.com>,
        Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
Cc:     "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        Shenghao Ding <13916275206@139.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
References: <20230329100107.8181-1-13916275206@139.com>
 <8d0d0478-1e45-ea52-f1b7-910b747d6282@linux.intel.com>
 <7a0cfa60e2a244168edd49c3d2f6a2bd@ti.com>
 <458d7c2f-bcee-9ec3-e955-9661a06a3349@wanadoo.fr>
 <bbae9e35f2bf4cbcbc78f852041e4b2e@ti.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <bbae9e35f2bf4cbcbc78f852041e4b2e@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 05/04/2023 à 13:21, Ding, Shenghao a écrit :
> Hi Both
> I wrote a test code to verify the be32_to_cpu & be32_to_cpup,
> static int __init lkm_init(void)
> {
> 	char test_buf[]={0x12, 0x34, 0xab, 0xbc, 0x56, 0x78, 0xef};
> 	unsigned int *k, p, q;
> 	int i;
> 
> 	printk("Hello, Shanghai!\n");
> 
> 	for (i = 0; i < 4; i ++) {
> 		k = (unsigned int *)&test_buf[i];
> 		p = be32_to_cpup((__be32 *)k);
> 		q = be32_to_cpu(test_buf[i]);
> 		printk("%d: *k = 0x%08x p = 0x%08x q = 0x%08x %ld\n",
> 			i, *k, p, q, sizeof(unsigned int));
> 	}
> 	return 0;
> }
> The output is:
> [ 9109.722548] Hello, Shanghai!
> [ 9109.726287] 0: *k = 0xbcab3412 p = 0x1234abbc q = 0x12000000 4
> [ 9109.727665] 1: *k = 0x56bcab34 p = 0x34abbc56 q = 0x34000000 4
> [ 9109.728553] 2: *k = 0x7856bcab p = 0xabbc5678 q = 0xabffffff 4
> [ 9109.729308] 3: *k = 0xef7856bc p = 0xbc5678ef q = 0xbcffffff 4
> Apparently, be32_to_cpup's output is what I expected.
> Looking forward to your comments. Thanks.

Hi,

thanks for the clarification and code sample.
You are right.

I had in mind that something like: be32_to_cpu((__be32 *)data);
would make it. (thanks to the cast)

But because of the need of "&" and "[offset]", it would just make the 
code unnecessarily complex.

I think that your approach is better.

CJ
