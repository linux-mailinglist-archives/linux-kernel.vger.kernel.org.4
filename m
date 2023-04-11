Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1B66DD491
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjDKHp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjDKHpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EF21BD1;
        Tue, 11 Apr 2023 00:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0A2061D0C;
        Tue, 11 Apr 2023 07:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81C0C433D2;
        Tue, 11 Apr 2023 07:45:09 +0000 (UTC)
Message-ID: <5649adcd-3afe-e413-2eac-a92c78427dc9@xs4all.nl>
Date:   Tue, 11 Apr 2023 09:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] media: vivid: Add webcam parameter for (un)limited
 bandwidth
Content-Language: en-US
To:     Max Staudt <mstaudt@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
References: <20230410063356.3894767-1-mstaudt@chromium.org>
 <20230410102350.382f7d02@sal.lan>
 <6aafad18-13a2-ef45-48a1-1f094554af31@chromium.org>
 <6ee01cf1-5a8b-081f-e218-8c7da39343bc@xs4all.nl>
 <c6d5be4c-42c9-b8fa-fbd7-108c5da694bc@chromium.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <c6d5be4c-42c9-b8fa-fbd7-108c5da694bc@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 09:31, Max Staudt wrote:
> On 4/11/23 16:26, Hans Verkuil wrote:
>> I think we either use this bandwidth option and calculate the max fps based on
>> that (basically the bandwidth divided by (image_size + some blanking factor)),
>> or we keep it simple and instead of going down two steps in fps we allow up to
>> 60 fps up to 720p, then 30 fps for 1080p and 15 fps for 4k.
>>
>> The fps values currently used are a bit outdated w.r.t. modern webcams, so
>> upgrading it wouldn't hurt. And this is a lot simpler than doing bandwidth
>> calculations.
> 
> Do I understand you correctly, are you suggesting to simply update the FPS limits to a new fixed schema, and not have an option at all?

Correct.

The ideal solution is indeed proper bandwidth calculations, since this would
be a proper emulation of actual webcam hardware. If you have time and are
interested in doing the work, then that would be great, of course.

But if you just want to increase the fps limits to be more in line with
modern webcams, then that's much quicker and should be fine.

It might also be interesting to perhaps allow for 120 fps for the low
resolutions (below 720p).

Regards,

	Hans

> 
> I'm happy to prepare an alternative patch for that, too.
> 
> 
> 
> Max
> 

