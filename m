Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02DC6A0741
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjBWLW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjBWLWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:22:52 -0500
Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E2654A09;
        Thu, 23 Feb 2023 03:22:38 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1515193|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0199928-0.000496274-0.979511;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.RUpWDcJ_1677151355;
Received: from 192.168.220.144(mailfrom:michael@allwinnertech.com fp:SMTPD_---.RUpWDcJ_1677151355)
          by smtp.aliyun-inc.com;
          Thu, 23 Feb 2023 19:22:36 +0800
Message-ID: <6d7c8e3f-225e-400f-f8a4-bf14c538ad8a@allwinnertech.com>
Date:   Thu, 23 Feb 2023 19:22:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Content-Language: en-US
To:     Oliver Neukum <oneukum@suse.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, richard.gong@amd.com,
        mario.limonciello@amd.com
References: <20230222013944.31095-1-michael@allwinnertech.com>
 <ef80c145-e33f-4aa8-c9e8-c77f34b1bb0e@suse.com>
From:   Michael Wu <michael@allwinnertech.com>
In-Reply-To: <ef80c145-e33f-4aa8-c9e8-c77f34b1bb0e@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Oliver,

On 2/22/2023 5:34 PM, Oliver Neukum wrote:
> On 22.02.23 02:39, Michael Wu wrote:
>> This patch fixes a problem that USB mouse can't wake up the device that
>> enters standby.
> 
> Hi,
> 
> I am afraid I need to ask you to be a bit more precise here.
> Are you referring to USB mice being unable to wake up a system,
> even if you so request via sysfs, or that they won't by default?
> 
>      Regards
>          Oliver

Yes. I can't use any USB mouse which supports Remote Wakeup to wake up 
the system by default.
If I enable the wakeup node in /sys/bus/usb/devices which is disabled by 
default, the mouse can wakeup the system successfully.
Clearly, the only thing I can do is to register the wakeup source for 
USB Mouse devices.

-- 
Regards,
Michael Wu
