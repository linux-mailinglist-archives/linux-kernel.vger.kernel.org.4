Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084116312C4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 08:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiKTHBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 02:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTHBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 02:01:11 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE082A1A37;
        Sat, 19 Nov 2022 23:01:08 -0800 (PST)
Received: (Authenticated sender: alex@alexyzhang.dev)
        by mail.gandi.net (Postfix) with ESMTPSA id 33A6AFF80F;
        Sun, 20 Nov 2022 07:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alexyzhang.dev;
        s=gm1; t=1668927665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xl+tWVY+Atk085UDczWmuRowQVekdiN/GKtVTpKhRRk=;
        b=OC3gz2K3mtM2/AcEJ3WDTleiivbIGZs+X09/m3e2HwX0QBc6tL3Urb1m1lj+o9Lga+Sk0o
        O0YLjM8lID+7nwAxtQ6whUkVZJzJTTohpN+2NqUbqCYEBpnqiaeEwgfqPYP/b1L4HIvRGe
        41FsrXCaudCpA/SjXKHRXyk3uvGGdQgZ8uwOdSYr7v1V0M2sDHOJilCVobGvFSflJhC7kC
        L6uWtC0+TGvCxR+L0JiHiGUzY2RQgFOCnjlNgIt1uUGz8bKRs78ZNAJl/nsJ2VTWDPJNyA
        lu47qlrwxm0kwz/awmz1A1KSLiN8Ja66RAL0w+2Ou3RbjxrKqoiSIfBIgZiTqQ==
Message-ID: <d08049f2-443b-f769-cfde-629cdfb96fc0@alexyzhang.dev>
Date:   Sat, 19 Nov 2022 23:01:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/1] HID: uclogic: Add HID_QUIRK_HIDINPUT_FORCE quirk
To:     Jiri Kosina <jikos@kernel.org>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        benjamin.tissoires@redhat.com, openglfreak@googlemail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221110174056.393697-1-jose.exposito89@gmail.com>
 <e1daf0a9-b699-affd-0d14-e46981733096@alexyzhang.dev>
 <nycvar.YFH.7.76.2211141509340.6045@cbobk.fhfr.pm>
Content-Language: en-US
From:   Alexander Zhang <alex@alexyzhang.dev>
In-Reply-To: <nycvar.YFH.7.76.2211141509340.6045@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/22 6:10 AM, Jiri Kosina wrote:
> On Thu, 10 Nov 2022, Alexander Zhang wrote:
> 
>> Hi José,
>>
>> On 11/10/22 9:40 AM, José Expósito wrote:
>>> Hi everyone,
>>>
>>> About 3 months ago, Torge Matthies sent a patch fixing an issue with
>>> his XP-Pen Star G640 [1].
>>>
>>> His patch changes the IS_INPUT_APPLICATION() macro to accept
>>> HID_DG_DIGITIZER. However, it looks like it is not being merged because
>>> of the possible side effects that changing that macro could generate.
>>>
>>> This patch aims to fix the same issue but using a more conservative
>>> approach hoping that the bug can be fixed.
>>>
>>> Torge, Alexander, could you test it and confirm that it fixes your
>>> issues, please?
>>
>> I tested the patch on commit 4bbf3422df78 and it fixes the issue.
> 
> I will add
> 
> 	Tested-by: Alexander Zhang <alex@alexyzhang.dev>
> 
> to the commit; please speak up if you disagree.

I'm not sure if you're still waiting for a response from me but I'm fine 
with that.

Thanks,
Alexander Zhang
