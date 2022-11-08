Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CDA620AFD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiKHIOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiKHIOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:14:30 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 00:14:28 PST
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA2A20191;
        Tue,  8 Nov 2022 00:14:28 -0800 (PST)
Received: from mailhub.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
        by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id E97F140388;
        Tue,  8 Nov 2022 08:55:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=univ-grenoble-alpes.fr; s=2020; t=1667894104;
        bh=CifegeMCjXZQIpdO+ZEFHnXLYSNMGD8TGBz3ntYzCk4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M9e07P2kLBWj/+Uoas4G4ukBBAhMtEvltORoInAIUwOv/kYb7r0m/QK/mgGEbnt9L
         vUk2yzDN6koFWiywXVim5q1+KXnXaI3SwsDnhphFBnLeHR3He9RZWBOpFuxllR6d6F
         KPYoTM7IMOIxe/6rohzAsGdKDyQzNoV6sYgpu5YSrDvDvjuXf75fqVwKT8hqVhPWTQ
         tHPHVDxrg4ZSrN3aymcowwu/pEADWq6afZD9djULZh5ugSKz06fWnlBOtgfpprQxXJ
         hKZe36ejGrwuATY9jWVquT9oFF/rVlaga5W/sHWnyaAVAKpYh34DPBmLxAwUgMmIQ+
         pRng8whQopcDg==
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
        by mailhub.u-ga.fr (Postfix) with ESMTP id E663D10005A;
        Tue,  8 Nov 2022 08:55:04 +0100 (CET)
Received: from [192.168.1.50] (amontpellier-653-1-4-7.w92-145.abo.wanadoo.fr [92.145.106.7])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: palixn@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 70BDD40050;
        Tue,  8 Nov 2022 08:55:04 +0100 (CET)
Message-ID: <2fcd7fdb-7984-a2b7-7995-d164754c5eb2@univ-grenoble-alpes.fr>
Date:   Tue, 8 Nov 2022 08:55:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [cocci] [PATCH] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Content-Language: fr
To:     Julia Lawall <julia.lawall@inria.fr>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        nicolas palix <nicolas.palix@imag.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel@pengutronix.de
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
 <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de>
 <20221107200815.u7hcwejileeabnct@pengutronix.de>
 <257596884.6156222.1667886713273.JavaMail.zimbra@inria.fr>
From:   Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
In-Reply-To: <257596884.6156222.1667886713273.JavaMail.zimbra@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 08/11/2022 06:51, Julia Lawall wrote:
> 
>> After uninstalling python2 this ends in:
>>
>> 	Cannot find Python library
>> 	coccicheck failed
>> 	make: *** [Makefile:2076: coccicheck] Error 255
>>
>> Didn't try to debug that any further. Is that worth a bug report against
>> coccinelle (which is shipped by my distribution)?
>>
>> I tried to adapt the org and report modes from other patches in the same
>> directory. So a critical glimpse by someone more knowledgable than me is
>> recommended. However I don't know how to react to "I doubt ... is
>> appropriate", I'd need a more constructive feedback to act on.
> 
> I'm not a python expert, so I'm not sure what to do about this python2 vs python3 problem.  Is there some strategy for printing that works in both of them?

It sounds like a missing dependency in the package system of the 
distribution. Coccinelle has been build with Python support, but
some libraries are missing.

Which distribution is it ?
Can you install some packages that provide the two missing shared 
librairies ?

> 
> julia

-- 
Nicolas Palix
+33 4 574 21538

