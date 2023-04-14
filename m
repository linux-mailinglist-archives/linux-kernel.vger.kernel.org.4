Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DD46E23AC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjDNMyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDNMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:54:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE5E977F;
        Fri, 14 Apr 2023 05:54:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f2so9696133pjs.3;
        Fri, 14 Apr 2023 05:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681476850; x=1684068850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F1QwZkwEn6xrzyo5DQTCYy/azTv/nyRhxJzIWb9QpKo=;
        b=ZlQHDJaxfFOBDNnlsQ5DFBkAhD/kgVmgKr8JQtBLs11Yyil3+q84lTINMny83+k4Fc
         92P9ctaA3ohsMwY+l5IH5Oq97mKvlB25/1KdawxX40WTSPLvkju8u7wDOxYy2YwZNCSS
         +YXa2KLFmukli2dtKCatUzk1Osk0wvnuD79psCpnrLXaZDE6xyuAxLMpA8cdh7q6hRfi
         MU8LKOiM5u3/QiQ37taeEfimP76+JnpfLR1MxbAdI8l7iq/zf7Z36tXU1JENRB2JQnel
         GbIK+r3frbmAbU7nC+ioZpwi4WXfZPe4pvMU7UG/GfnxHlUbO6PSGyR0id9V5ss3eiim
         VqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681476850; x=1684068850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1QwZkwEn6xrzyo5DQTCYy/azTv/nyRhxJzIWb9QpKo=;
        b=SN5ZJQzEVCHbSWkZnVMJfxAe6gDwXchyfkCuw6FyREELif1w42iBWF0ZfBmh5UJYUN
         XXyXd+jHKn676i1/5R6r3Uu0uTpb3TBiV/1rFLNu9P5R2ntGi5yYDr0uiBfF02/GKCub
         3sQvWq/zhcOwgIpb0ZmtXL+jPvEYc4MDZIHDdbavBEC8YD6hWLEQ3rgUUJ4RimTbYmde
         AeWubdAVycEEKQTQp98Y1Hv12O+/XAwB74dJsV++pr1KN9vPTcPh1g3FTt3pyXh+2W5x
         iQCX4bXBu39qi2OP9clwqOeYYj2uyG4Fej/KzK+T1/W+KrMZvyXXbFtBOD7/9U78XVsa
         vbdg==
X-Gm-Message-State: AAQBX9dR2X0dGA5l7zGmyuC86H46HqBxGdQ84FYafJh9dG5Qmb9A1dLV
        VeZldi1q057gUrGHGmk16+I=
X-Google-Smtp-Source: AKy350bVdsNcSykv+SI7jRhrzajw1AY99JX8jbvhF3NwG40IfJgwp3GQ/Rn1ZF4VmBuQ0CesUO/oeg==
X-Received: by 2002:a05:6a20:b2a4:b0:ec:60a:d04d with SMTP id ei36-20020a056a20b2a400b000ec060ad04dmr5217378pzb.33.1681476850006;
        Fri, 14 Apr 2023 05:54:10 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id e24-20020aa78c58000000b005895f9657ebsm3005541pfd.70.2023.04.14.05.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 05:54:09 -0700 (PDT)
Message-ID: <fd092a59-dc44-2c26-5c72-c9b442cf2bc8@gmail.com>
Date:   Fri, 14 Apr 2023 05:54:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] serial: 8250: Add missing wakeup event reporting
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc:     linux-kernel@vger.kernel.org, opendmb@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Wander Lairson Costa <wander@redhat.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20230413213957.1985949-1-f.fainelli@gmail.com>
 <ZDj-htAWWxJ5gqPr@kroah.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ZDj-htAWWxJ5gqPr@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2023 12:19 AM, Greg Kroah-Hartman wrote:
> On Thu, Apr 13, 2023 at 02:39:54PM -0700, Florian Fainelli wrote:
>> An 8250 UART configured as a wake-up source would not have reported
>> itself through sysfs as being the source of wake-up, correct that.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   drivers/tty/serial/8250/8250_port.c | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> What commit does this fix?  Is it needed to go to stable kernel(s)?

That would be b3b708fa2780cd2b5d8266a8f0c3a1cab364d4d2 ("wake up from a 
serial port").

I do not know of standard Linux distribution user-space relying on the 
wake-up counts from sysfs, though I certainly do care.

The patch I submitted should backport fine all the way down to 4.14 
where irqd_is_wakeup_set is available. Do you want me to submit a v2 
with that Fixes tag?
-- 
Florian
