Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9993D696384
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjBNMbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBNMbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:31:41 -0500
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC587C144;
        Tue, 14 Feb 2023 04:31:37 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id B554EC800A7;
        Tue, 14 Feb 2023 13:31:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id aweOVSJQj-J0; Tue, 14 Feb 2023 13:31:35 +0100 (CET)
Received: from [192.168.178.52] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id F18DEC800A4;
        Tue, 14 Feb 2023 13:31:34 +0100 (CET)
Message-ID: <2d983050-f844-6c5e-8ae9-9f87ac68dfdd@tuxedocomputers.com>
Date:   Tue, 14 Feb 2023 13:31:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NH5xAx
To:     andy.shevchenko@gmail.com
Cc:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230210164636.628462-1-wse@tuxedocomputers.com>
 <Y+qyEVxMh4VRIsy3@surfacebook>
Content-Language: en-US
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <Y+qyEVxMh4VRIsy3@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.02.23 um 22:56 schrieb andy.shevchenko@gmail.com:
> Fri, Feb 10, 2023 at 05:46:36PM +0100, Werner Sembach kirjoitti:
>> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
>> changed the policy such that I2C touchpads may be able to wake up the
>> system by default if the system is configured as such.
>>
>> However on Clevo NH5xAx/TUXEDO XA15 Gen10 there is a mistake in the ACPI
>> tables that the TP_ATTN# signal connected to GPIO 10 is configured as
>> ActiveLow and level triggered but connected to a pull up. As soon as the
>> system suspends the touchpad loses power and then the system wakes up.
>>
>> To avoid this problem, introduce a quirk for this model that will prevent
>> the wakeup capability for being set for GPIO 10.
> Please, update the commit message and send v2.
>
> We would like to have this fix nevertheless, because users will suffer w/o it.
>
OK I'm on it.
