Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072A8696224
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBNLOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjBNLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:14:40 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1567126CEA;
        Tue, 14 Feb 2023 03:14:09 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9423e69038=fe@dev.tdt.de>)
        id 1pRtFm-0005ZV-6S; Tue, 14 Feb 2023 12:13:42 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1pRtFl-00083W-Lc; Tue, 14 Feb 2023 12:13:41 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 3F142240049;
        Tue, 14 Feb 2023 12:13:41 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id D8203240040;
        Tue, 14 Feb 2023 12:13:40 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id A08482B4BF;
        Tue, 14 Feb 2023 12:13:40 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Feb 2023 12:13:40 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: Re: [PATCH 2/2] leds: trigger: ledtrig-tty: add additional modes
In-Reply-To: <b5dd2505-b087-b521-739b-ad4e97f3cbc5@kernel.org>
References: <20230213140638.620206-1-fe@dev.tdt.de>
 <20230213140638.620206-3-fe@dev.tdt.de>
 <b5dd2505-b087-b521-739b-ad4e97f3cbc5@kernel.org>
Message-ID: <f4f9b09939819709822cea2b328422b8@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate: clean
X-purgate-ID: 151534::1676373222-A8B146AC-785ABD1E/0/0
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiri,

> 
>> +};
>> +
>> +static const char * const mode[] = {
> 

> This is not a wise name.

What do you suggest? For me, the 'mode' here was the most accurate.
It describes how the trigger should behave.

How about
* action
* switch
* tty_trigger


> 
>> +	[TTY_LED_CNT] = "TD/RD", // Trasmit Data / Receive Data
>> +	[TTY_LED_CTS] = "CTS", // CTS Clear To Send
>> +	[TTY_LED_DSR] = "DSR", // DSR Data Set Ready
>> +	[TTY_LED_CAR] = "CAR", // CAR Data Carrier Detect (DCD)
>> +	[TTY_LED_RNG] = "RNG", // RNG Ring Indicator (RI)
>>   };
>>     static void ledtrig_tty_restart(struct ledtrig_tty_data 
>> *trigger_data)
>> @@ -21,6 +38,74 @@ static void ledtrig_tty_restart(struct 
>> ledtrig_tty_data *trigger_data)
>>   	schedule_delayed_work(&trigger_data->dwork, 0);
>>   }

Best regards
-- Florian
