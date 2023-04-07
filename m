Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1141B6DA9BB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbjDGIJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDGIJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:09:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000949768
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:08:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9333b408ee7so19108666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 01:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680854938; x=1683446938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=chM+aOuRzB7CkSudk4w7H6Qb4P5pnNlrP1RR+AKS8Os=;
        b=iSQScGwbd8Xo1rkfffuHE5wo++SEQieFziBhIbwNp03vvlG0Olj4tlPrJh9QRpdcyv
         R0zR8h995hiTbwbKr3yNfnmRpCsAMrl8rsp1+Al+eXw8PEXyXNJXgjrAbiMe3HhPYcFn
         65rXJpmRe2fpaMxnFiLxZtlvS8pAtdUfNR7I+vDUTVVsbEicYh+TfOtjswa5JdRr0Abx
         t3rMgKScRi1cMiOHgW+Ebc9ITazb0CDIkfJr3M/6b0iEfGLyu4OzrNUg2F1arsaUndlm
         P9+61A2R2z7NBTuNZD8qYUMW82ZEzrpaDk3lEaRL5iSR9Xj5Tg3qwi/7mCW+GQ+YiF1J
         Zvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680854938; x=1683446938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chM+aOuRzB7CkSudk4w7H6Qb4P5pnNlrP1RR+AKS8Os=;
        b=a0W29q2QobZ8hYPRAXVxLbI4J12XDiWcj0YGXd5dwu93UeY+br3zuOOUpJntUQLkje
         kzjeKj9yn+fG1KqkhKJdtqYY0LVsh/gLTRjn27UAIXz1W3kqYnERxIdDVgboOV1YiP1U
         v8G8/IPZSOUdRCCVAu55X/wH3Jg3HaEHGNeKt65VL16DWvFnL6tTQ/dw33L0bsJei8ID
         +tQqoEolh7lGIQdkxqizx0sxssTsa/Io6VO2hoqRPVoZPPrQZGFVHavgHzcb7foCzzxf
         WvH5dGFvnwVpYkA5elS0SQZsWye6wR++lNklriDgEqIrU2fLbIBhVdB4/+KhCPyhG5U0
         IQrg==
X-Gm-Message-State: AAQBX9cKdUrFQGMcsAkqAReeZRDEuBHWpBG3wLJKX2S6IUeKNIgMbyHO
        QOu9qf1krrCrG3/ckBg9fVya67F/05M=
X-Google-Smtp-Source: AKy350aQmBXc9Vys7GOF9dMrPtvkrmkMVcOzaImMuNqqJY/Z3PK9o8zsFsOVLVfTIcwIohylZs4Ocg==
X-Received: by 2002:a17:906:73c5:b0:92f:39d9:1e50 with SMTP id n5-20020a17090673c500b0092f39d91e50mr1346683ejl.3.1680854938270;
        Fri, 07 Apr 2023 01:08:58 -0700 (PDT)
Received: from [192.168.0.103] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906488900b0093de5b42856sm1787294ejq.119.2023.04.07.01.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 01:08:55 -0700 (PDT)
Message-ID: <7ce977bb-a5b9-080c-4c27-58c12899759e@gmail.com>
Date:   Fri, 7 Apr 2023 10:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/5] staging: rtl8192e: Remove unused local variable
 irq_line
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1680729715.git.philipp.g.hortmann@gmail.com>
 <6ec702e12cb30501fc81693a71a96b238bf09ea0.1680729716.git.philipp.g.hortmann@gmail.com>
 <ZC8mR9OjVlEdDMV-@kroah.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZC8mR9OjVlEdDMV-@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 22:06, Greg Kroah-Hartman wrote:
> On Wed, Apr 05, 2023 at 11:48:20PM +0200, Philipp Hortmann wrote:
>> Remove unused local variable irq_line.
>>
>> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
>> ---
>>   drivers/staging/rtl8192e/rtl8192e/rtl_pci.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
>> index 0bc3e013001e..1c3ccd2aabc3 100644
>> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
>> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
>> @@ -33,11 +33,9 @@ bool rtl92e_check_adapter(struct pci_dev *pdev, struct net_device *dev)
>>   	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
>>   	u16 device_id;
>>   	u8  revision_id;
>> -	u16 irq_line;
>>   
>>   	device_id = pdev->device;
>>   	revision_id = pdev->revision;
>> -	pci_read_config_word(pdev, 0x3C, &irq_line);
> 
> As was pointed out, that might not be "unused".
> 
> When doing a PCI write, the only way to know it has completed is to
> issue a read.  Are you sure this isn't a read that is flushing out a
> pending write?  Look at who calls this function and verify that this
> read really is safe to remove and then document that really really well
> in the changelog text when doing so.
> 
> Be careful about removing seemingly-unused PCI read/writes, they often
> times are actually needed.
> 
> thanks,
> 
> greg k-h

Hi,

The first function that is called of the driver is: _rtl92e_pci_probe().
66 Lines later the function rtl92e_check_adapter() is called. The line
pci_read_config_word() is the 10th line of this function.

No other pci function before in function rtl92e_check_adapter().

The following functions are used in the probe function before the
rtl92e_check_adapter():

pci_enable_device()		Does not require a pci read.
pci_set_master()		Does not require a pci read.
dma_set_mask()			Does not require a pci read.
alloc_rtllib()			Does not require a pci read.
pci_set_drvdata()		Does not require a pci read.
SET_NETDEV_DEV()		Does not require a pci read.
rtllib_priv()			Does not require a pci read.
pci_resource_start()		Does not require a pci read.
pci_resource_len()		Does not require a pci read.
pci_resource_flags()		Does not require a pci read.
request_mem_region()		Does not require a pci read.
ioremap()			Does not require a pci read.
pci_resource_len()		Does not require a pci read.
pci_read_config_byte()		Which is deleted in this
				patch series. So Gregs hint is
  				applicable for this patch as well.

I am going to issue a v2.

Thanks for your support.

Bye Philipp

