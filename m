Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D746F6EE6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjEDP1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEDP1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:27:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1138544A6;
        Thu,  4 May 2023 08:27:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64115e652eeso13330323b3a.0;
        Thu, 04 May 2023 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683214054; x=1685806054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=n+9BCWWFJ9kX9z9vwPs5suJnsnm6pBL5Gs+H048I/qU=;
        b=TWp9QsQs580Bhd2vSJBiMSPWDVihPNFnTH4NxuHDJxUSmvrbHBQZELCgUyci3K0gvk
         skiXxJLJAGKasYUQURiKZPBvwPWgZXbORA5VCiDrN6KJiGCrHn/8WfJLfDSK88yHkrl9
         9cRLTEhEFRIwLgxupRQmD3hJc44ZJ6jUDMX7g4RWFV/v+ch9vugjVewDTul20Z4eMqCw
         E0ccPu+OjOp36CrznMHDRZoUdp1neZFgjewocnTAHxBswadvt306m2W0XlrLpaUbYloS
         QmEsZIf2w8m2Ff/CF0tWcJXETg3PS+7twhXqTPBT5nzrPOAszJUh3D7Ka4Bu2BRs7lfu
         luUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683214054; x=1685806054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+9BCWWFJ9kX9z9vwPs5suJnsnm6pBL5Gs+H048I/qU=;
        b=ZBGJG8gnApkgJCrFzoE/1vWxqa3nATYw/Qbpddl44qRqSCRzO5a2Qv6d2Owp/8H5jg
         pSVjxmFtX0lnxItcq5fu1Bd2U5uXjc7xbPcr1l4WkcKbvV8Qm3dnhaiZ4nfe6K81saAS
         Fa/A82SAyD+2kKi32wl88gfbv9dM5FhR++tRYu+Sro05dZUHoI+qMSVknmY0tLiFVWrt
         L2ngKU9tWFBIpzArNQJik8c0tWPVKDeSLrTTS0l0c3uJnJAqfJei9Rb6cpFqiMp31O+Y
         jJJ1emvNt4+a/n1CYE5I/S09t2F4es1iunXXFqJrpeY5FyA4PbWYST7aNYOFTrHFUw5P
         uhyw==
X-Gm-Message-State: AC+VfDykmTwFf6GL2592+I+nEgAPwk/ISiys2Mh5y8/pynmI5ZnYFaZv
        RWo8BkqrTqMiWg8U2B5K7OI=
X-Google-Smtp-Source: ACHHUZ77he6sPOfU3xZK5Zxt1mecQtL1ZIiBcnD7jZbW98h9cu9zDF/Ty5yPW8w/6Pq0Z+YGF4WaDA==
X-Received: by 2002:a05:6a00:4206:b0:63b:6373:786b with SMTP id cd6-20020a056a00420600b0063b6373786bmr2606305pfb.2.1683214054329;
        Thu, 04 May 2023 08:27:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k4-20020aa78204000000b0063b7f3250e9sm2355903pfi.7.2023.05.04.08.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:27:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <670c3604-7287-ed7d-8e37-b0458ff28ca8@roeck-us.net>
Date:   Thu, 4 May 2023 08:27:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/4] usb: typec: tcpci: clear the fault status bit
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     andreas@fatal.se, jun.li@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
 <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-3-3889b1b2050c@pengutronix.de>
 <6a894ff0-3232-4ef0-5e26-95471cc33ed9@roeck-us.net>
 <20230504142708.l4xo4sbl7wzsrbql@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230504142708.l4xo4sbl7wzsrbql@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 07:27, Marco Felsch wrote:
> On 23-05-04, Guenter Roeck wrote:
>> On 5/4/23 06:46, Marco Felsch wrote:
>>> According the "USB Type-C Port Controller Interface Specification v2.0"
>>> the TCPC sets the fault status register bit-7
>>> (AllRegistersResetToDefault) once the registers have been reseted to
>>
>> cleared ? set ?
> 
> Sry. I don't get this.
> 

instead of "reseted" which isn't really a word.

>>> their default values.
>>>
>>> This triggers an alert(-irq) on PTN5110 devices albeit we do mask the
>>> fault-irq. Fix this gernally by writing a one to the correspondig
>>
>> generically ?
> 
> Sure, thanks.
> 
>> corresponding
> 
> Of course!
> 
>>> bit-7.
>>>
>>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>>> ---
>>>    drivers/usb/typec/tcpm/tcpci.c | 5 +++++
>>>    include/linux/usb/tcpci.h      | 1 +
>>>    2 files changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
>>> index 8da23240afbe..15632d023e4c 100644
>>> --- a/drivers/usb/typec/tcpm/tcpci.c
>>> +++ b/drivers/usb/typec/tcpm/tcpci.c
>>> @@ -602,6 +602,11 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>>>    	if (time_after(jiffies, timeout))
>>>    		return -ETIMEDOUT;
>>> +	regmap_read(tcpci->regmap, TCPC_FAULT_STATUS, &reg);
>>
>> Needs error check.
> 
> I will add this.
> 
>> Also, I am not sure if this is the correct place for this code. The alert
>> status is cleared after vendor initialization. Should the same be done
>> here ?
> 
> According the spec the bit must be cleared before the TCPC_ALERT is
> cleared. Of course the vendor-init can (re-)trigger the bit, therefore
> we should move behind the vendor init and right before the TCPC_ALERT
> clear.
> 
>> Also, why not just write the bit unconditionally, similar
>> to TCPC_ALERT ?
> 
> Thought about this too.. I will change it in the v3.
> 
> Thanks for the feedback,
>    Marco
> 
>>
>> Thanks,
>> Guenter
>>
>>> +	if (reg & TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT)
>>> +		tcpci_write16(tcpci, TCPC_FAULT_STATUS,
>>> +			      TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT);
>>> +
>>>    	/* Handle vendor init */
>>>    	if (tcpci->data->init) {
>>>    		ret = tcpci->data->init(tcpci, tcpci->data);
>>> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
>>> index 85e95a3251d3..83376473ac76 100644
>>> --- a/include/linux/usb/tcpci.h
>>> +++ b/include/linux/usb/tcpci.h
>>> @@ -103,6 +103,7 @@
>>>    #define TCPC_POWER_STATUS_SINKING_VBUS	BIT(0)
>>>    #define TCPC_FAULT_STATUS		0x1f
>>> +#define TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT BIT(7)
>>>    #define TCPC_ALERT_EXTENDED		0x21
>>>
>>
>>

