Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B925D630021
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiKRW3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiKRW3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:29:35 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1553682BF1;
        Fri, 18 Nov 2022 14:29:32 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bj12so16264837ejb.13;
        Fri, 18 Nov 2022 14:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PaZhYkm/pYY/poBYZWLYIWMEFnlY686ZOBazX+0ypxM=;
        b=byyadTcV0DNuihhCjYVYGkgix/u30indBR5wUMD5Lippt6ETu9cMh0sPsDqs3nQEvo
         3OAbrXBhdXg3Bz/1vzxhOLcrqmK6er8RrSYAIgT9VS6hBg3X+yuTIz0nV62uOmK5Oqth
         CNM1UI67tdIstNW1KvloO2TomwIXktoLPrJmp+kkhu61Z7JcCi4EBCf+cg2s7UwBw+U3
         EL/XMwH9Pj37meNMMlqVEP3xKcnfr5CxsUSLoyJbF81AfOpZzV9G7cvpEoc+WJWqRFZV
         0bLHz9qWG2FRvAVvDp4FeTU1OPocAL5YEcn+pc1BrZlX8SwdUvIdRXq5Z8TxzBicscU5
         7reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaZhYkm/pYY/poBYZWLYIWMEFnlY686ZOBazX+0ypxM=;
        b=pB/JfrmFTc5xEemq7aX2dDTHzrpPHaANSj2tJHNGuAvCVOAkkZZ6d80cPV+rjIrRBY
         TDTc7RfOOp5hKhyL+aHQJxOquHpP5wp0dpL1o39WXrUbx865fW2abhoWBIEU2Ytx73zL
         4TWXZZV9FPh3gOB2mJth0jNRYBYkUWUelv/nOvHWPMmT9bz4drIsB9JLSFOvB8QQcvHL
         Y0xDbciy/AKVibef4Hw8WcYJfMr0vX9DuEcMUDKMgV1uPDwYNAzlmgeS9INqz3uzHt0S
         UfDF1edMgVtP9c+g8YAlddKDv8blqTmhfH3h7CBMLuHJAZJ1DEkDWYumt62o6zEr98ca
         gU0g==
X-Gm-Message-State: ANoB5pm/bY/PNoQKXIC/R7BedfDpYZo2RLHGuSS3m0yp3NPpBfwlwAKT
        2E+dv8pQ7POL8qZMJFOoDdM=
X-Google-Smtp-Source: AA0mqf4KymKL6UBE+dbsFmZ9zZr10O561JKezCLM7pD3nEihK54eoj8DgNzX8+b5IC+1PpjSoTr6Ow==
X-Received: by 2002:a17:907:2c57:b0:7ad:9893:fba9 with SMTP id hf23-20020a1709072c5700b007ad9893fba9mr7403057ejc.62.1668810570361;
        Fri, 18 Nov 2022 14:29:30 -0800 (PST)
Received: from ?IPV6:2a02:a466:68ed:1:43a7:1097:bbec:4c24? (2a02-a466-68ed-1-43a7-1097-bbec-4c24.fixed6.kpn.net. [2a02:a466:68ed:1:43a7:1097:bbec:4c24])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709064a8a00b0078d3a075525sm2193777eju.56.2022.11.18.14.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 14:29:29 -0800 (PST)
Message-ID: <641c4fa2-5406-0254-42de-8fd821876ddd@gmail.com>
Date:   Fri, 18 Nov 2022 23:29:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 1/1] usb: ulpi: defer ulpi_register on ulpi_read_id
 timeout
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20221109221749.8210-1-ftoth@exalondelft.nl>
 <20221110000643.xdoav4c4653x3tjd@synopsys.com>
 <e0545783-0a8f-3cb7-2cae-ced85c91e51d@gmail.com>
 <48e7b906-d7e3-46e3-e2bc-71512a1e64aa@gmail.com>
 <20221111013048.p6ahttrpbgzpavid@synopsys.com>
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20221111013048.p6ahttrpbgzpavid@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Op 11-11-2022 om 02:31 schreef Thinh Nguyen:
> On Thu, Nov 10, 2022, Ferry Toth wrote:
>> Hi
>>
>> Op 10-11-2022 om 13:45 schreef Ferry Toth:
>>> (sorry sent html with previous attempt)
>>>
>>> On 10-11-2022 01:06, Thinh Nguyen wrote:
>>>> Hi Ferry,
>>>>
>>>> On Wed, Nov 09, 2022, Ferry Toth wrote:
>>>>> Since commit 0f010171
>>>>> Dual Role support on Intel Merrifield platform broke due to rearranging
>>>>> the call to dwc3_get_extcon().
>>>>>
>>>>> It appears to be caused by ulpi_read_id() on the first test
>>>>> write failing
>>>>> with -ETIMEDOUT. Currently ulpi_read_id() expects to discover
>>>>> the phy via
>>>>> DT when the test write fails and returns 0 in that case even if
>>>>> DT does not
>>>>> provide the phy. Due to the timeout being masked dwc3 probe continues by
>>>>> calling dwc3_core_soft_reset() followed by dwc3_get_extcon()
>>>>> which happens
>>>>> to return -EPROBE_DEFER. On deferred probe ulpi_read_id()
>>>>> finally succeeds.
>>>>>
>>>>> This patch changes ulpi_read_id() to return -ETIMEDOUT when it
>>>>> occurs and
>>>>> catches the error in dwc3_core_init(). It handles the error by calling
>>>>> dwc3_core_soft_reset() after which it requests -EPROBE_DEFER. On
>>>>> deferred
>>>>> probe ulpi_read_id() again succeeds.
>>>>>
>>>>> Signed-off-by: Ferry Toth<ftoth@exalondelft.nl>
>>>>> ---
>>>>>    drivers/usb/common/ulpi.c | 5 +++--
>>>>>    drivers/usb/dwc3/core.c   | 5 ++++-
>>>>>    2 files changed, 7 insertions(+), 3 deletions(-)
>>>>>
>>>> Can you split the dwc3 change and ulpi change to separate patches?
>>>
>>> Thanks for your comments.
>>>
>>> I will send v2
>>>
>>>>> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
>>>>> index d7c8461976ce..d8f22bc2f9d0 100644
>>>>> --- a/drivers/usb/common/ulpi.c
>>>>> +++ b/drivers/usb/common/ulpi.c
>>>>> @@ -206,8 +206,9 @@ static int ulpi_read_id(struct ulpi *ulpi)
>>>>>        /* Test the interface */
>>>>>        ret = ulpi_write(ulpi, ULPI_SCRATCH, 0xaa);
>>>>> -    if (ret < 0)
>>>>> -        goto err;
>>>>> +    if (ret < 0) {
>>>>> +        return ret;
>>>>> +    }
>>>>>        ret = ulpi_read(ulpi, ULPI_SCRATCH);
>>>>>        if (ret < 0)
>>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>>> index 648f1c570021..e293ef70039b 100644
>>>>> --- a/drivers/usb/dwc3/core.c
>>>>> +++ b/drivers/usb/dwc3/core.c
>>>>> @@ -1106,8 +1106,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>>>>        if (!dwc->ulpi_ready) {
>>>>>            ret = dwc3_core_ulpi_init(dwc);
>>>>> -        if (ret)
>>>>> +        if (ret) {
>>>>> +            dwc3_core_soft_reset(dwc);
>>>> We shouldn't need to do soft reset here. The controller shouldn't be at
>>>> a bad/incorrect state at this point to warrant a soft-reset. There will
>>>> be a soft-reset when it goes through the initialization again.
>>>
>>> It doesn't go through the initialization again unless we set
>>> -EPROBE_DEFER. And when we make ulpi_read_id() return -EPROBE_DEFER it
>>> will goto err0 here, so skips dwc3_core_soft_reset.
>>>
>>> Do you mean you prefer something like:
>>>
>>> if (ret) {
>>>
>>>       if (ret == -ETIMEDOUT) ret = -EPROBE_DEFER;
>>>
>>>       else goto err0;
> 
> Why "else"? But I saw you remove that in the new patch.
> 
>>>
>>> }
>>
>> I just tested, and calling dwc3_core_soft_reset() proves to be necessary as
>> we need to goto err0 directly after. Else ret is overwritten and
>> -EPROBE_DEFER lost.
> 
> Looks like there's a strange dependency problem here.
>   * The setup needs a soft-reset before ulpi registration
>   * The ulpi registration needs to go before the phy initialization
>   * The soft-reset should be called after the phy initialization
> 
> I can't explain the actual issue here, and we can't debug further
> because to look into it further would require looking at internal
> signals.
> 
> This soft-reset and -EPROBE_DEFER seems to be a workaround to this
> dependency problem. Instead of using -EPROBE_DEFER, can you do this:
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 2f0a9679686f..5a1aaf3741ec 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1097,6 +1097,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
>                  goto err0;
>   
>          if (!dwc->ulpi_ready) {
> +               /* Add comment */
> +               dwc3_core_soft_reset(dwc);
>                  ret = dwc3_core_ulpi_init(dwc);
>                  if (ret)
>                          goto err0;
> 

This indeed fixes the issue as well. Here is the trace:

# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
  0)               |  /* start_event: (dwc3_probe+0x0/0x1910) */
  0)   7.070 us    |  dwc3_clk_enable.part.0();
  0)   5.480 us    |  extcon_get_extcon_dev();
  0) + 10.230 us   |  dwc3_runtime_idle();
  0)               |  /* end_event: (platform_probe+0x3f/0xa0 <- 
dwc3_probe) */

** multiple defers while waiting for extcon

  0)               |  /* start_event: (dwc3_probe+0x0/0x1910) */
  0)   7.320 us    |  dwc3_clk_enable.part.0();
  0)   6.830 us    |  extcon_get_extcon_dev();
  0)               |  dwc3_core_init() {
  0) + 29.200 us   |    dwc3_core_soft_reset.part.0();
  0)               |    dwc3_ulpi_init() {
  0)               |      ulpi_register_interface() {
  0)               |        dwc3_ulpi_write() {
  0)   3.380 us    |          dwc3_ulpi_busyloop();

  ** without this patch this one times out after 10000us

  0)   7.710 us    |        }
  0)               |        dwc3_ulpi_read() {
  0)   3.060 us    |          dwc3_ulpi_busyloop();
  0)   7.210 us    |        }
  0)               |        dwc3_ulpi_read() {
  0)   2.830 us    |          dwc3_ulpi_busyloop();
  0)   6.690 us    |        }
  0)               |        dwc3_ulpi_read() {
  0)   2.880 us    |          dwc3_ulpi_busyloop();
  0)   6.670 us    |        }
  0)               |        dwc3_ulpi_read() {
  0)   2.940 us    |          dwc3_ulpi_busyloop();
  0)   6.690 us    |        }
  0)               |        dwc3_ulpi_read() {
  0)   2.870 us    |          dwc3_ulpi_busyloop();
  0)   6.620 us    |        }
  0) + 18.150 us   |        ulpi_uevent();
  0)   5.990 us    |        ulpi_match();
  0)               |        ulpi_probe() {
  0)               |          tusb1210_probe() {
  0)               |            ulpi_read() {
  0)               |              dwc3_ulpi_read() {
  0)   4.440 us    |                dwc3_ulpi_busyloop();
  0)   9.600 us    |              }
  0) + 15.770 us   |            }
  0)               |            ulpi_write() {
  0)               |              dwc3_ulpi_write() {
  0)   3.270 us    |                dwc3_ulpi_busyloop();
  0)   6.820 us    |              }
  0) + 11.020 us   |            }
  0) ! 407.540 us  |          }
  0) ! 416.980 us  |        }
  0)   9.800 us    |        ulpi_uevent();
  0) * 18604.00 us |      }
  0) * 18611.20 us |    }
  0) + 30.570 us   |    dwc3_core_soft_reset.part.0();
  0)               |    tusb1210_power_on() {
  1)               |  extcon_set_state_sync() {
  1)   5.330 us    |    extcon_set_state.part.0();
  1) + 90.550 us   |    extcon_sync.part.0();
  1) ! 113.670 us  |  }
  1) + 19.450 us   |  ulpi_uevent();
  0) + 13.640 us   |  ulpi_uevent();
  1) + 13.980 us   |  ulpi_uevent();
  0) + 15.960 us   |  ulpi_uevent();
  0)               |      ulpi_write() {
  0)               |        dwc3_ulpi_write() {
  0) * 10239.47 us |          dwc3_ulpi_busyloop();
  0) * 10250.57 us |        }
  0) * 10265.09 us |      }
  0) * 69518.95 us |    }
  0)   5.740 us    |    dwc3_event_buffers_setup();
  0) * 88241.02 us |  } /* dwc3_core_init */
  0) ! 104.900 us  |  dwc3_debugfs_init();
  0)               |  dwc3_drd_init() {
  0)   4.720 us    |    extcon_register_notifier();
  0)               |    extcon_get_state() {
  0)   2.640 us    |      extcon_get_state.part.0();
  0)   6.460 us    |    }
  0) + 14.460 us   |    dwc3_set_mode();
  0) + 43.300 us   |  }
  0)               |  /* end_event: (platform_probe+0x3f/0xa0 <- 
dwc3_probe) */

Maybe this is the preferred way to go if the dwc3_core_soft_reset() 
doesn't hurt other users?

>>
>>>>> +            ret = -EPROBE_DEFER;
>>>> We shouldn't automatically set every error status to correspond to
>>>> -EPROBE_DEFER. Check only the approapriate error codes (-ETIMEDOUT +
>>>> any other?).
>>> Other could be -ENOMEM. I think no need to do any new handling for that.
> 
> There's also -EINVAL and some others too. Regardless, if it's -ENOMEM,
> then it should not return -EPROBE_DEFER.
> 
>>>>>                goto err0;
>>>>> +        }
>>>>>            dwc->ulpi_ready = true;
>>>>>        }
>>>>>
> 
> Thanks,
> Thinh

