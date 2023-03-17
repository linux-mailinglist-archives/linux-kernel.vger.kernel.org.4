Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8356BE997
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCQMrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCQMrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:47:16 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F26AF2AE;
        Fri, 17 Mar 2023 05:47:14 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id bp11so2676670ilb.3;
        Fri, 17 Mar 2023 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679057234;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uMPENxtm6B3AsAn3c4xfJq8kPIjS9MSNdQwqeoG6GXk=;
        b=Enor0DrvWQLFMMk1BckAW3zhPQPyM+2hd9Mgj15l08jHxHb8isx1ZlSKkW4WqehgFl
         ByD0bCq8LbMvaeF+gi/BWpxJTsvv1P+JVC/F2zwyL44cEoBi3Vbo+ZLBs4HUlCogom1b
         OXMO4Xq7hypLScLfjGbcEzpoJfwxiGdkpp1X1N2sOqggsM3L9SHXkhsEgiwp5tp86co/
         LgyvfNSSVsHU4gohBSql9Ogto3KrS4BKZZKNe1CpFnPIwALKTBEqyd2r+/U8GMi05v7S
         2zxy21QC3ZdrBkgo8moPfAUPcYSpuINPIKIg5IkQcJ4zQaKsx+rzbT04y+u/t3ejptHE
         29yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679057234;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMPENxtm6B3AsAn3c4xfJq8kPIjS9MSNdQwqeoG6GXk=;
        b=M8aM2H1gIBRtXxrLLxwiI0mLsmAj74w4NjV/FEK13ZWEMTE2jnbJxJmHN1PWgofe+q
         gQ7qrvJ9aSkIWMLDCEW/lFVns4KRflhV3YMVx/a+tl/hcolWHhc9i2apFEPBSdFew9HT
         aDyZTKgOcOb48rx1gNXceDmcYQXQzNdauYIZ1CdDTb0rMgFYlHO4oXpkOOVVA5elsam8
         +s+IeQjIWIFc/jCjmXrVGJuxEvNqW8kzj5BIxrkoynlRWrF91vZpPAKEcKyljVu5bb3U
         kXeVaCRGsJ2fUvwhYNpZWpXBYfAbCazIGDNHVPI8IPfvrlutfJI18pS09ajwuyh0X1mv
         arEw==
X-Gm-Message-State: AO0yUKUOc9vKCzFOLS8ymkPoaPv0OaVRvjYu+DL9JdA+z8iwNvaZReHE
        S7XxuFonBkRHfGIF2uTn6QI=
X-Google-Smtp-Source: AK7set8B4oT+0estBbN7+ctEL+I0r+koof2KJocD38OwW53LVUU3Bra06/AbHcBbtc03N2IRuxwMbg==
X-Received: by 2002:a92:d6d2:0:b0:317:980d:970 with SMTP id z18-20020a92d6d2000000b00317980d0970mr9038697ilp.7.1679057233818;
        Fri, 17 Mar 2023 05:47:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y4-20020a92d804000000b003231396e317sm556704ilm.88.2023.03.17.05.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 05:47:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d5d1880b-2852-a168-b155-26f972a96457@roeck-us.net>
Date:   Fri, 17 Mar 2023 05:47:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Frank Wang <frank.wang@rock-chips.com>
Cc:     gregkh@linuxfoundation.org, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
References: <20230313025843.17162-1-frank.wang@rock-chips.com>
 <20230313025843.17162-2-frank.wang@rock-chips.com>
 <ZBA8Y/dbozOk2df7@kuha.fi.intel.com>
 <f0f0ac72-0a90-da9e-f686-49c21a76866b@rock-chips.com>
 <ZBRN11OwtkvXk1Hd@kuha.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/4] usb: typec: tcpm: fix cc role at port reset
In-Reply-To: <ZBRN11OwtkvXk1Hd@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/23 04:24, Heikki Krogerus wrote:
> On Wed, Mar 15, 2023 at 10:55:20AM +0800, Frank Wang wrote:
>> Hi Heikki,
>>
>> On 2023/3/14 17:20, Heikki Krogerus wrote:
>>> On Mon, Mar 13, 2023 at 10:58:40AM +0800, Frank Wang wrote:
>>>> In the current implementation, the tcpm set CC1/CC2 role to open when
>>>> it do port reset would cause the VBUS removed by the Type-C partner.
>>>>
>>>> The Figure 4-20 in the TCPCI 2.0 specification show that the CC1/CC2
>>>> role should set to 01b (Rp) or 10b (Rd) at Power On or Reset stage
>>>> in DRP initialization and connection detection.
>>>>
>>>> So set CC1/CC2 to Rd to fix it.
>>>>
>>>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>>>> ---
>>>>    drivers/usb/typec/tcpm/tcpm.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>>>> index a0d943d785800..66de02a56f512 100644
>>>> --- a/drivers/usb/typec/tcpm/tcpm.c
>>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>>>> @@ -4851,7 +4851,7 @@ static void run_state_machine(struct tcpm_port *port)
>>>>    		break;
>>>>    	case PORT_RESET:
>>>>    		tcpm_reset_port(port);
>>>> -		tcpm_set_cc(port, TYPEC_CC_OPEN);
>>>> +		tcpm_set_cc(port, TYPEC_CC_RD);
>>>>    		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
>>>>    			       PD_T_ERROR_RECOVERY);
>>>>    		break;
>>> Will this work if the port is for example source only?
>>
>> Yeah, this only set at port reset stage and CC value will be set again
>> (Rd for Sink, Rp_* for Source) when start toggling.
> 
> Okay. Let's wait for comments from Guenter.
> 

Figure 4-20 is specifically for dual role ports. Also, start toggling would not
happen if the low level driver doesn't have a start_toggling callback. I think this
may require some tweaking based on the port type or, rather, tcpm_default_state().
Something like

	tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ? TYPEC_CC_RD : tcpm_rp_cc(port));

Thanks,
Guenter

