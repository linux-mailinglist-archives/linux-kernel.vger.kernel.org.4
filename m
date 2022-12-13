Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8112364B45A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbiLMLlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiLMLls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:41:48 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FD21C418;
        Tue, 13 Dec 2022 03:41:47 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id ud5so35820553ejc.4;
        Tue, 13 Dec 2022 03:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjC4cfU0JkRcyEtSEIvQxO1hPKLcqBFwHz5kpZLRS3Y=;
        b=ks1KubPtS3WMoAFYo8j7Y613QhmCvEvYnHgEavXcqUfCF1X2jjkHkq/ITLyKz/9wZU
         1b/ii7Xvn5EPUA95TloPTph5j4fqIXEKvh5r49rSjin6fLxO6lBJ9gyeZulmanePsWMp
         PMReJM9BoH/DwpP4Yh7rQ7iE4jE6XI4ZvCS3BRNGyGFboaQsB1AlcaJoE6gTtMuGYqos
         4BPU5GDynK5smLtGpgPFwzyvpsSZBtfnD7iGdB2ym0NaH+I1epBOaX3IxX6wP9SWffXp
         61Trc6XWLtVcXmAomyNrx6JfaxGKYe9JzjqYsx28V/ayIkE2igbdEK3bozg4Q944trXw
         EM7w==
X-Gm-Message-State: ANoB5placciUp/3bnSNyHXwou91j5wv2UkzHjOIkxx1q4or/dztsg0ix
        V6OmSbAMdNBmegAIUg8EgLw=
X-Google-Smtp-Source: AA0mqf4YWEGxh1Gi4wqqqk2wCAVW0Pr9GWBAv36Gw7EQuhFCLKE0l31W4FeCU7MB0xHw7I+bbg6LTA==
X-Received: by 2002:a17:906:37c4:b0:7c1:e7b:6460 with SMTP id o4-20020a17090637c400b007c10e7b6460mr17568184ejc.41.1670931705869;
        Tue, 13 Dec 2022 03:41:45 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906292200b007c09d37eac7sm4396564ejd.216.2022.12.13.03.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 03:41:45 -0800 (PST)
Message-ID: <824effa5-8b9a-c28a-82bb-9b0ab24623e1@kernel.org>
Date:   Tue, 13 Dec 2022 12:41:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <Y3gwySzRvhCwdSgW@google.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [git pull] Input updates for v6.1-rc5
In-Reply-To: <Y3gwySzRvhCwdSgW@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 11. 22, 2:26, Dmitry Torokhov wrote:
> to receive updates for the input subsystem. You will get:
> 
> - a fix for 8042 to stop leaking platform device on unload
> - a fix for Goodix touchscreens on devices like Nanote UMPC-01 where we
>    need to reset controller to load config from firmware
> - a workaround for Acer Switch to avoid interrupt storm from home and
>    power buttons
> - a workaround for more ASUS ZenBook models to detect keyboard cnotroller
> - a fix for iforce driver to properly handle communication errors
> - touchpad on HP Laptop 15-da3001TU switched to RMI mode
> 
> Changelog:
> ---------
> 
> Aman Dhoot (1):
>        Input: synaptics - switch touchpad on HP Laptop 15-da3001TU to RMI mode

This appears to break keyboard on HP's 15-da1xxx which appears to have 
the same ID: SYN3286. This happens on 6.0.12.

synaptics excerpt from dmesg:
psmouse serio1: synaptics: Trying to set up SMBus access
psmouse serio1: synaptics: SMbus companion is not ready yet
...
psmouse serio1: synaptics: queried max coordinates: x [..5648], y [..4826]
psmouse serio1: synaptics: queried min coordinates: x [1292..], y [1026..]
psmouse serio1: synaptics: Trying to set up SMBus access
rmi4_smbus 6-002c: registering SMbus-connected sensor
rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, 
product: TM3320-003, fw id: 2659795
input: Synaptics TM3320-003 as 
/devices/pci0000:00/0000:00:1f.4/i2c-6/6-002c/rmi4-00/input/input21




This was reported downstream as a regression between 6.0.10 and 6.0.12:
https://bugzilla.suse.com/show_bug.cgi?id=1206358

Full dmesgs available there too.


6.0.10 has this instead of the above:
psmouse serio1: synaptics: queried max coordinates: x [..5648], y [..4826]
psmouse serio1: synaptics: queried min coordinates: x [1292..], y [1026..]
psmouse serio1: synaptics: Your touchpad (PNP: SYN3286 PNP0f13) says it 
can support a different bus. If i2c-hid and hid-rmi are not used, you 
might want to try setting psmouse.synaptics_intertouch to 1 and report 
this to linux-input@vger.kernel.org.
psmouse serio1: synaptics: Touchpad model: 1, fw: 8.16, id: 0x1e2b1, 
caps: 0xf00323/0x840300/0x2e800/0x400000, board id: 3320, fw id: 2659795



thanks,
-- 
js
suse labs

