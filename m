Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A266657FA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbjAKJrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjAKJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:47:28 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE138D98;
        Wed, 11 Jan 2023 01:45:34 -0800 (PST)
Received: from [192.168.6.149] ([212.159.46.162]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.99]) with ESMTPSA (Nemesis) id
 1Mrfgi-1oRxIt3Uou-00nlPx; Wed, 11 Jan 2023 10:44:51 +0100
Message-ID: <208196df-d0b2-5cf6-29b3-4570a0946e77@veremit.xyz>
Date:   Wed, 11 Jan 2023 09:44:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: linux-6.1-rt ?
Content-Language: en-GB
To:     Christian Eggers <ceggers@arri.de>, linux-rt-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <12136223.O9o76ZdvQC@n95hx1g2>
From:   Michael Everitt <gentoo@veremit.xyz>
In-Reply-To: <12136223.O9o76ZdvQC@n95hx1g2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GH4nCekC7J8gmdNRQj5CfXCLMrmjp1El7VNYXUlxouSG/WeCjXm
 eWU2/W6P5KabxLKIatlTGVkDucSjauFF1TyJ+2AMMUo3YueDWVBZfNHErCrqn8n6SNRgaUj
 DA1U5f51KADEmYplxrCVYQmYNbG26PTEYeyucN6RVzFmrRClD/Y2Z/MYh5IP2+GrF2G/+TX
 WMxIhfBRU3iwcz53xhhUg==
UI-OutboundReport: notjunk:1;M01:P0:cyKacGI8rXM=;EEyL3U6Pp4nNsi+4mfi38bkps/l
 WWq0VH5nbm/PLg1qI/nXwBVCuKqccWfuoyphCzrZqO3Ym1o7hrBvNjgqs2Kpeh6vU1env2asm
 YJEfMGGqC2NFriJDQR2/ZBJqQ3asbaiVAQZOdF6ObRbGk5sTQqsGQZgX2SBflcroyo667hSN+
 90ObzHKxE+OM0WIBTEzeMxj35+XUncViMH+xJsnR+kRX6nKJIT+b52JqDBrfk73AqgQ+UuGGx
 YS1c/VgHIlNSaZ/6O3RSMQWnaH/xH4dD6/ObDC3ZZ0dOTNjZJK5ixvUQXmTRFiLZvY06bhjrE
 spIm3TA0CliHM92L6fCA3ytNYUk07j6RiTNVrbt8ARLsqboiDdWKobZCe7hXfDyy8LmoMc3Dl
 ON9vTfoBycm63XHq7PMwPSDXqqecd2zVvZ1ff4wCKZUYhDKrPosayIh0jWFddyOHsBCEDy6+h
 pyYXIOZqJMZta4EXqzKntMqG4FOB586FR1/aVpZz6Uz/0gpGT23eM6ndBN+71kyVKykJrFY0b
 DeHDAkqqdKoUiMUW4UJn2y1FHylcGKdA4VVgd/ig7wj8Es7YTLp4FbyGewFNUYUMJGlkrtesJ
 uT8lQDIkZR7mbP6Ujfz96GYTsrKGz3OyomZ5IG9IXPcJTdDHr+SXEhiFOuEu/oeKIqa/0Zb83
 GLfBtj2R2E/HH2n6HHkgvLBxTwtC16nF6VlE7gZXSA==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FROM_SUSPICIOUS_NTLD,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 08:36, Christian Eggers wrote:
> linux-6.1 seems to be the next LTS kernel [1]
> 
> Are there any plans to release a -rt version of linux-6.1?
> 
> regards
> Christian
> 
> [1] https://lore.kernel.org/lkml/Yz%2FZWBeNZvKenEVM@kroah.com/
> 
> 

You probably want this: https://www.spinics.net/lists/linux-rt-users/msg26345.html

You may wish to wait for the maintainer to complete their processes!

Regards,
veremitz/Michael.
