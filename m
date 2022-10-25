Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0776360CA3B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiJYKlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiJYKln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:41:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051BF48C83;
        Tue, 25 Oct 2022 03:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F53E618A2;
        Tue, 25 Oct 2022 10:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C550C433D6;
        Tue, 25 Oct 2022 10:41:38 +0000 (UTC)
Message-ID: <293e27b5-b7b0-c637-fd3a-2f6dfa507c81@xs4all.nl>
Date:   Tue, 25 Oct 2022 12:41:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1] media: cedrus: Propagate error code from
 cedrus_h265_skip_bits()
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220914150105.209484-1-dmitry.osipenko@collabora.com>
 <d75c0597-2323-27f2-a7e2-b319667bdcf6@xs4all.nl>
 <12078224.O9o76ZdvQC@jernej-laptop>
 <3a26e105-9c50-8cdd-b4be-ba97b3306261@collabora.com>
 <1103d833-6c29-6ccb-05dd-a2883eaa2281@xs4all.nl>
 <fcf78a88-ab27-3a6a-db06-66504fc18e10@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <fcf78a88-ab27-3a6a-db06-66504fc18e10@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 12:36, Dmitry Osipenko wrote:
> On 10/25/22 13:23, Hans Verkuil wrote:
>> On 10/25/22 11:34, Dmitry Osipenko wrote:
>>> On 10/25/22 07:59, Jernej Škrabec wrote:
>>>> Dne ponedeljek, 24. oktober 2022 ob 13:38:36 CEST je Hans Verkuil napisal(a):
>>>>> Hi Dmitry,
>>>>>
>>>>> This patch has a conflict with this patch from Jernej:
>>>>>
>>>>> https://patchwork.linuxtv.org/project/linux-media/patch/20221017194413.11983
>>>>> 01-1-jernej.skrabec@gmail.com/
>>>>>
>>>>> I decided to take Jernej's patch first. Can you make a v2 that sits on top
>>>>> of that patch?
>>>> I believe you already merged first version of the patch for 6.1. No need for 
>>>> this version though, first version already solves main issue.
>>>
>>> That was a followup to the first version.
>>>
>>
>> I have no idea what you are both talking about :-)
>>
>> "I believe you already merged first version of the patch for 6.1" Which patch
>> are you referring to?
> 
> This is about [1] that was already merged. This patch implements the
> error propagation that Jernej asked [2] when he reviewed [1].
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=91db7a3fc7fe670cf1770a398a43bb4a1f776bf1
> 
> [2] https://lore.kernel.org/lkml/1733932.VLH7GnMWUR@kista/
> 
> I'll prepare the v2 if this change is still desired by Jernej.
> 

Ah, OK. That was not obvious to me :-)

I'll mark this v1 patch as 'Changes Requested' in patchwork.

Thank you for the explanation!

Regards,

	Hans
