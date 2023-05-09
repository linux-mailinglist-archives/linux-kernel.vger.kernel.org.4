Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4461F6FBF16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjEIGO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjEIGO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:14:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0567B9EE1;
        Mon,  8 May 2023 23:14:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8857F6315C;
        Tue,  9 May 2023 06:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F73C433D2;
        Tue,  9 May 2023 06:14:52 +0000 (UTC)
Message-ID: <bd58506f-1eb1-d0f4-4145-95dbbd821807@xs4all.nl>
Date:   Tue, 9 May 2023 08:14:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] media: vivid: Extend FPS rates offered by simulated
 webcam
Content-Language: en-US
To:     Max Staudt <mstaudt@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
References: <20230414072419.1397808-1-mstaudt@chromium.org>
 <0ed5d350-85f6-967f-5ff9-270e50bb0f3a@chromium.org>
 <e0dd9182-0638-b616-d09b-a2b031513c19@xs4all.nl>
 <310b789c-ae2e-7306-267e-8bf508211b60@chromium.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <310b789c-ae2e-7306-267e-8bf508211b60@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 07:09, Max Staudt wrote:
> On 4/21/23 16:17, Hans Verkuil wrote:
>> On 21/04/2023 09:07, Max Staudt wrote:
>>> Is this patch close to what you had in mind when you suggested updating the simulated webcam parameters in vivid?
>>
>> Yes, that makes sense.
> 
> Hi Hans,
> 
> Quick ping on this patch.
> 
> Are you still interested in upstreaming an updated FPS table?

Yes. I've been very busy, so it will take some time before I pick it up, but it
should go in for the 6.5 kernel.

Regards,

	Hans

> 
> 
> 
> Thanks,
> 
> Max
> 

