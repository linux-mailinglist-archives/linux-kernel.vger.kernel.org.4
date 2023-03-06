Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A056ABA47
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCFJpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCFJpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:45:43 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E44021A2F;
        Mon,  6 Mar 2023 01:45:37 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id j11so16348164edq.4;
        Mon, 06 Mar 2023 01:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxVJaz0YNFmuR9r2BtY5InSB5e1/5Bxah7sj7UUN4Dw=;
        b=J+P0YdhlKQSWHvDTsDChikps5zpRnJjPB1otQsfWzWfPysg3G8h2pURergZYKHE9AB
         TGuM+K8icW4C4trtUMBzctonvOm5oUgBCTS79yq5hb/ojY7OXQCjMY1u0A+kSfFof0tU
         u7mjGD3lwkhqIS0Qnh6TqfxT/oWYg3yj9w6X0fxq9baj01CTfP7gcM2WAqg2BorrhSr+
         K41HF2NBAIB3SpTauFZqyY2VwJOgaxJcM5RdCGlx2CYwDBKX472kf1owwPKB8kbCDHgr
         tkxx5P4gcvtWcb0sN8ebPPH4xRQdilE1Qj5r4C2dWaVOizoA4+k66AQK+WT1jJfU5wJr
         DPBg==
X-Gm-Message-State: AO0yUKUL3kLLJFHG6pQh477/UgJVUub2kC8+hgwn5bVHwDcC5tuqC/5f
        FjG/KV5oARZMBogweR81i4Q=
X-Google-Smtp-Source: AK7set+AN4v6xNWeX/GyeOfCsm+ktQr6Jc/7o279/ujye9bsAt1E4BbEXOnfHEM49SzRxTCWSLr8UQ==
X-Received: by 2002:a17:907:a0b:b0:8b2:7567:9c30 with SMTP id bb11-20020a1709070a0b00b008b275679c30mr14642559ejc.59.1678095935547;
        Mon, 06 Mar 2023 01:45:35 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id y64-20020a50bb46000000b004bc2d1c0fadsm4880057ede.32.2023.03.06.01.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 01:45:35 -0800 (PST)
Message-ID: <97e6f0ad-bc77-db86-5a8e-2f5e0a817662@kernel.org>
Date:   Mon, 6 Mar 2023 10:45:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 0/3] leds: ledtrig-tty: add tty_led_mode xtension
Content-Language: en-US
To:     Florian Eckert <fe@dev.tdt.de>, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
References: <20230306094113.273988-1-fe@dev.tdt.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230306094113.273988-1-fe@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 03. 23, 10:41, Florian Eckert wrote:
> Hello,
> 
> here commes v8 of this series to add additional tty_led_modes.

I think u r 2 fast. Uwe had some more comments on v7.

Don't be afraid to wait some days after the last comments ;). As it is, 
it makes the review harder...

> v8:
> Changes compared to the v7 patchset with
> 20230222083335.847655-1-fe@dev.tdt.de are.
> 
> * Update 'Documentation/ABI/testing/sysfs-class-led-trigger-tty'
>    with the suggested changes.
> * Use a meaningfull name for the Rx/Tx enum.
> * Do not use C++ comments style
> 
> Add a new patch 'ledtrig-tty-fix-brightness-set' to fix an issue with
> LEDs that are connected via GPIOs to the SOC with the device driver
> 'leds-gpio'. In my view, the wrong function is being used here. LEDs
> that do not need and do not have a delayed call do not work with the
> current implementation. Therefore, the 'led_set_brightness_nosleep'
> function must be used.
> 
> 
> v7:
> Changes compared to the v5 patchset with
> 20230222075539.484878-1-fe@dev.tdt.de are.
> 
> Addressed review comments by Jiri Slaby are:
> 
> Thanks for the hint with the command 'make htmldocs SPHINXDIRS="admin-guide"'.
> Unfortunately, I did not know that. I have now verified it also in the
> browser. In my opinion, the list is now also displayed correctly in
> the documentation.
> 
> 
> v6:
> Changes compared to the v5 patchset with
> 20230221081901.15557-1-fe@dev.tdt.de are.
> 
> Addressed review comments by kernel test robot are:
> 
> * fix Documentation/ABI/testing/sysfs-class-led-trigger-tty:9:
>    WARNING: Unexpected indentation.
> * fix Documentation/ABI/testing/sysfs-class-led-trigger-tty:9:
>    WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Thanks to Jiri Slaby, who gave me the crucial hint of what I need to fix,
> to possibly make the 'Kernel test robot' happy.
> 
> 
> v5:
> Changes compared to the v4 patchset with
> 20230220152038.3877596-1-fe@dev.tdt.de are.
> 
> Sorry for the inconvenience, but I sent the wrong patch for
> ledtrig-tty.c in v4. The v5 patchset now includes all the changes I
> specified in the v4 patchset.
> 
> 
> v4:
> Changes compared to the v3 patchset with
> 20230220093739.320478-1-fe@dev.tdt.de are.
> 
> Addressed review comments by Jiri Slaby are:
> 
> ledtrig-tty.c:
> - Do not use __TTY_LED_MAX pattern us instead __TTY_LED_LAST = TTY_LED_RNG
> - Move declartion and assignment into one singel line
> - Use __TTY_LED_LAST pattern, to simplify tty_mode_show and
>    tty_mode_store handling
> 
> 
> v3:
> Changes compared to the v2 patchset with
> 20230217094403.1574468-1-fe@dev.tdt.de are.
> 
> Addressed review comments by Greg K-H are:
> 
> tty.h:
> - Fix first comment line and remark -%ENOTTY for the new function
>    'tty_get_mget' to make a proper kernel doc.
> - Add the return value -%ENOTTY again, I thought it was no longer needed.
> 
> 
> v2:
> Changes compared to the initial patchset with
> 20230213140638.620206-1-fe@dev.tdt.de are.
> 
> Addressed review comments by Jiri Slaby are:
> 
> tty.h:
> - Fix compilation error because of wrong rebaseing
> - Remove empty lines
> - Use new 'tty_get_mget' in 'tty_tiocmget'
> 
> ledtrig-tty.c:
> - Update commit description
> - Use enum for tty_led_mod in struct ledtrig_tty_date
> - Rename sysfs file from 'mode' to 'tty_led_mode'
> - Change tty_led_mode show function to use loop instead of switch/case
> - Change tty_led_mode store function to use loop instead of switch/case
> - Check return value of function tty_get_mget
> 
> Florian Eckert (3):
>    tty: new helper function tty_get_mget
>    trigger: ledtrig-tty: add additional modes
>    ledtrig-tty: call correct brightness set function
> 
>   .../ABI/testing/sysfs-class-led-trigger-tty   |  18 +++
>   drivers/leds/trigger/ledtrig-tty.c            | 145 ++++++++++++++++--
>   drivers/tty/tty_io.c                          |  28 +++-
>   include/linux/tty.h                           |   1 +
>   4 files changed, 171 insertions(+), 21 deletions(-)
> 

-- 
js
suse labs

