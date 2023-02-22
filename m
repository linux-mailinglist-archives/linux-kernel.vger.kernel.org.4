Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0839169EFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBVIN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBVIN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:13:27 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE89C7EE8;
        Wed, 22 Feb 2023 00:13:25 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id ec43so26461734edb.8;
        Wed, 22 Feb 2023 00:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ag/3Atz7wSqimNQuEYxkpDd8W3Ip2Hw0Id13QQyP6Y=;
        b=4MRcp1rZ/hULrX66ZvMbgZT0B6o46Doae/7KIFxUdVxAvuRTj7vCoCpT9N9Ro5r/CR
         hc0enZmObSPh7efW2QZgnOmCDwOonyWchpPOAqO9V3VdSOpzVBXvSIAsnUxMuPFbrGI1
         +DyU/aDkHXD55sAmsoHNFJvvOziCanN7TnUwtI6nCC5wIIgTxwuwh+1CvkLqRLaMbW3R
         3jgHSneBV50woe9IhWcXd5ay1JCYN1GY0s/cH9+WN0Ip+Tah7v5YPhvtcFHdaGw12tCy
         zVAXMr9X1XfHB45hetVQcIZ1EbYS1O0nn7+kGRg4ZHmJ0SD0Gl4SKHKYh2KQ+vXVUZPS
         YOrA==
X-Gm-Message-State: AO0yUKXVt49GpmsCJHxHF0L6B4NSROvYgukjef6+de3VbDaI0cWYFrk2
        bu+LVYgBDdVieyMBthGnOcM=
X-Google-Smtp-Source: AK7set9oplvMl8GCEhp9DiS+4AxXl974OCPXw13AJ1xiZkOaqsCohxZTk5cgMevIshWN/aqlye8fUQ==
X-Received: by 2002:a17:906:5a4c:b0:8b1:811e:cd30 with SMTP id my12-20020a1709065a4c00b008b1811ecd30mr17582554ejc.22.1677053604132;
        Wed, 22 Feb 2023 00:13:24 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id p20-20020a1709060dd400b008be5b97ca49sm5490164eji.150.2023.02.22.00.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 00:13:23 -0800 (PST)
Message-ID: <7b942109-bbad-cbda-ad9c-b10bfb5f6dbf@kernel.org>
Date:   Wed, 22 Feb 2023 09:13:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 2/2] trigger: ledtrig-tty: add additional modes
Content-Language: en-US
To:     Florian Eckert <fe@dev.tdt.de>, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
References: <20230222075539.484878-1-fe@dev.tdt.de>
 <20230222075539.484878-3-fe@dev.tdt.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230222075539.484878-3-fe@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 02. 23, 8:55, Florian Eckert wrote:
> Add additional modes to trigger the selected LED.
> The following modes are supported:
> 
> Tx/Rx:	Flash LED on data transmission (default)
> CTS:	DCE Ready to accept data from the DTE.
> DSR:	DCE is ready to receive and send data.
> CAR:	DCE is receiving a carrier from a remote DTE.
> RNG:	DCE has detected an incoming ring signal.
> 
> The mode can be changed for example with the following command:
> echo "CTS" > /sys/class/leds/<led>/mode
> 
> This would turn on the LED, when the DTE(modem) signals the DCE that it
> is ready to accept data.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>   .../ABI/testing/sysfs-class-led-trigger-tty   |  16 ++
>   drivers/leds/trigger/ledtrig-tty.c            | 145 ++++++++++++++++--
>   2 files changed, 146 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-tty b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> index 2bf6b24e781b..4023585d3acf 100644
> --- a/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> @@ -4,3 +4,19 @@ KernelVersion:	5.10
>   Contact:	linux-leds@vger.kernel.org
>   Description:
>   		Specifies the tty device name of the triggering tty
> +
> +What:		/sys/class/leds/<led>/mode
> +Date:		January 2023
> +KernelVersion:	6.3
> +Description:
> +		Specifies the operating to trigger the LED.
> +		The following operating modes are supported:

Here, you should add a \n. Otherwise it won't start the list properly. 
Check the output e.g. by:
make htmldocs SPHINXDIRS="admin-guide"

then open the built result in a browser:
Documentation/output/admin-guide/abi-testing.html#abi-sys-class-leds-led-mode

> +		* Tx/Rx: Flash LED on data transmission (default)
> +		* CTS:   DCE Ready to accept data from the DTE.
> +		  LED on if line is high.
> +		* DSR:   DCE is ready to receive and send data.
> +		  LED on if line is high.
> +		* CAR:   DCE has detected a carrier from a remote DTE.
> +		  LED on if line is high.
> +		* RNG:   DCE has detected an incoming ring signal.
> +		  LED on if line is high.


-- 
js
suse labs

