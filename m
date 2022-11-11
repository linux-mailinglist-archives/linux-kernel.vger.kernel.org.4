Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6029625269
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiKKEYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKEYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:24:48 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B909E64CE;
        Thu, 10 Nov 2022 20:24:46 -0800 (PST)
Received: (Authenticated sender: alex@alexyzhang.dev)
        by mail.gandi.net (Postfix) with ESMTPSA id 3FF2320003;
        Fri, 11 Nov 2022 04:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alexyzhang.dev;
        s=gm1; t=1668140682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mr3strPn3RRXcW5p//6ykHmcpg7jCcKUL+ZH8POSj8U=;
        b=UVqetWTblbVMH4CkFJ+7iUqxXllx6PxzXR8jodw/1Yic9lGw3rZKNXQ2Tcsexgtuie2qC1
        N1YmpPrA4eIUb9VywtnXrneM7uoLYHCNDvRm4lWtj8futZ2bnSJqtWui/e66ETaS3YBcX2
        QPEsr5cSR0LvKsHZdV7E1N2O462KgtDvVHaRVCIb9sjYB+VsU2CJEWRSYT1OBBmEZ1xycf
        H2UVgFOMsJLp+yC9qxJB+EBy65f8bGGz45YZ8PgH+qijGfC12fycPkVF1hPIIYSuCvfcJ/
        jm2xNAHliu/hnAVAkgOgWsliq/uPXvUdFk/qUllY0Z6hmV8ASN73BvthIV6kHw==
Message-ID: <e1daf0a9-b699-affd-0d14-e46981733096@alexyzhang.dev>
Date:   Thu, 10 Nov 2022 20:24:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, openglfreak@googlemail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221110174056.393697-1-jose.exposito89@gmail.com>
Content-Language: en-US
From:   Alexander Zhang <alex@alexyzhang.dev>
Subject: Re: [PATCH 0/1] HID: uclogic: Add HID_QUIRK_HIDINPUT_FORCE quirk
In-Reply-To: <20221110174056.393697-1-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi José,

On 11/10/22 9:40 AM, José Expósito wrote:
> Hi everyone,
> 
> About 3 months ago, Torge Matthies sent a patch fixing an issue with
> his XP-Pen Star G640 [1].
> 
> His patch changes the IS_INPUT_APPLICATION() macro to accept
> HID_DG_DIGITIZER. However, it looks like it is not being merged because
> of the possible side effects that changing that macro could generate.
> 
> This patch aims to fix the same issue but using a more conservative
> approach hoping that the bug can be fixed.
> 
> Torge, Alexander, could you test it and confirm that it fixes your
> issues, please?

I tested the patch on commit 4bbf3422df78 and it fixes the issue.

Thank you,
Alexander Zhang

> Thanks a lot in advance,
> José Expósito
> 
> [1] https://lore.kernel.org/linux-input/20220804151832.30373-1-openglfreak@googlemail.com/
> 
> José Expósito (1):
>    HID: uclogic: Add HID_QUIRK_HIDINPUT_FORCE quirk
> 
>   drivers/hid/hid-uclogic-core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
