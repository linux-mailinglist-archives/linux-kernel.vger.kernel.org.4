Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11676A719F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCAQ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjCAQ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:57:51 -0500
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A514148E25;
        Wed,  1 Mar 2023 08:57:47 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 37679C800A8;
        Wed,  1 Mar 2023 17:57:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id mI9Wl69HATO3; Wed,  1 Mar 2023 17:57:45 +0100 (CET)
Received: from [192.168.178.52] (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 9A7C9C800A7;
        Wed,  1 Mar 2023 17:57:44 +0100 (CET)
Message-ID: <192c2eab-3b57-8a09-dfd7-5720b2b419b8@tuxedocomputers.com>
Date:   Wed, 1 Mar 2023 17:57:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/2] Fix "Input: i8042 - add TUXEDO devices to i8042
 quirk tables for partial fix"
To:     dmitry.torokhov@gmail.com, swboyd@chromium.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        mkorpershoek@baylibre.com, chenhuacai@kernel.org,
        wsa+renesas@sang-engineering.com, tiwai@suse.de,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230227185907.569154-1-wse@tuxedocomputers.com>
Content-Language: en-US
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20230227185907.569154-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 27.02.23 um 19:59 schrieb Werner Sembach:
> This is a continuation of
> https://lore.kernel.org/linux-input/20220708161005.1251929-3-wse@tuxedocomputers.com/
>
> That fix did fix the keyboard not responding at all sometimes after resume,
> but at the price of it being laggy for some time after boot. Additionally
> setting atkbd.reset removes that lag.
>
> This patch comes in 2 parts: The first one adds a quirk to atkbd to set
> atkbd.reset and the second one then applies that and the i8042 quirks to
> the affected devices.
>
>
Somehow, for my testing last week these patches seemed work, but now i still see 
occasional laggy keyboard after boot. So sadly the atkbd_reset quirk didn't fix 
the issue after all.
