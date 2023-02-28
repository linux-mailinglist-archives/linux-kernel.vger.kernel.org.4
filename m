Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC0A6A5779
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjB1LHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjB1LHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:07:08 -0500
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448EE2A9B3;
        Tue, 28 Feb 2023 03:07:06 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 8EA5EC800A8;
        Tue, 28 Feb 2023 12:07:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id e8gRqcMKz9K0; Tue, 28 Feb 2023 12:07:04 +0100 (CET)
Received: from [192.168.176.165] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 0ABDFC800A7;
        Tue, 28 Feb 2023 12:07:04 +0100 (CET)
Message-ID: <02ec2b60-2651-fb50-ca8c-d64c2df84caa@tuxedocomputers.com>
Date:   Tue, 28 Feb 2023 12:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/2] Fix "Input: i8042 - add TUXEDO devices to i8042
 quirk tables for partial fix"
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, dmitry.torokhov@gmail.com,
        swboyd@chromium.org, gregkh@linuxfoundation.org,
        mkorpershoek@baylibre.com, chenhuacai@kernel.org,
        wsa+renesas@sang-engineering.com, tiwai@suse.de,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230227185907.569154-1-wse@tuxedocomputers.com>
 <a2216cc2-b719-12e1-264c-374fc467db14@redhat.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <a2216cc2-b719-12e1-264c-374fc467db14@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 28.02.23 um 09:41 schrieb Hans de Goede:
> Hi Werner,
>
> On 2/27/23 19:59, Werner Sembach wrote:
>> This is a continuation of
>> https://lore.kernel.org/linux-input/20220708161005.1251929-3-wse@tuxedocomputers.com/
>>
>> That fix did fix the keyboard not responding at all sometimes after resume,
>> but at the price of it being laggy for some time after boot. Additionally
>> setting atkbd.reset removes that lag.
>>
>> This patch comes in 2 parts: The first one adds a quirk to atkbd to set
>> atkbd.reset and the second one then applies that and the i8042 quirks to
>> the affected devices.
> Can you please rework this series so that the quirk based setting of
> the "atkbd.reset" equivalent on the kernel commandline becomes another
> SERIO_QUIRK_* flag and avoid the duplication of the DMI ids?

I'm not sure how to cleanly do this, since atkbd is an own module?

Kind Regards,

Werner

>
> Regards,
>
> Hans
>
>
>
