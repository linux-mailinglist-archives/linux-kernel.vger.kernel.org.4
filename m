Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0896C9F49
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjC0JZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjC0JZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:25:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272703C34
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:25:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x17so10467928lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679909100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T02EEsB+JsxIsGvfHU8GNmWoAeNpI9q8KBBhU8dmU7w=;
        b=dhknn5eprEgoiGJpfoeIbZPZ3N9+U4ul2o9E+zM5DD6Yjs7/S1nIcK8qvZCnH47uQR
         m/OSrjh4aldu7RVRY6OZmwbT5QMyVKgiRlzYGbQLBCaDs66dnKQUzcvjGBPfGmGQ/t4N
         ry2rl62CaDB47euJa00hy/lhHYau+qZRsujISxMvrFqJ/rj5j3PaFBtFJ6jPB1rMVvSU
         GG+zS+0Q2/Hd/SrPSky2TLVxKRZ2nbh1Hakuu4dMLEdvkXGNEN7gSYliYNxS+ihWM3PD
         QIbljOlh/hQ1g7ZWAnwfupYvDJJFaAxiBine6LivbqxW5HkLk9Y2BK6Kv0x3DetU0JRO
         WCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679909100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T02EEsB+JsxIsGvfHU8GNmWoAeNpI9q8KBBhU8dmU7w=;
        b=VE6furuKgwpKSs9nvuKBICrvYgpC2NwiGRLCeyxrjaCdKJa8aYWWHKjH/OeyIkEaJE
         IP37KIhbkkhYjxuSMrA8dT9L0JXKkHHSICMuz6L1mn24T7eghej2ySJPJ83yUIziXdOY
         7IpzYl/mxT4/zOAgL6S+QD5w5mcSl6cIl3MZf2oQlu8zyHWJReGHOxYEtqm1IUPAMaux
         l4igtoxAmDmIJo7LmwyKMTi+2vnBC2NWzWlWXidlD9Ae+F0eAgQ/OAE5MmANfAzatfL0
         h43cmZFHf4XQENrFPzpQ7IvbIzz9XWgD0dXxfYHRIujsttafqxk8LcGqICP7XvfcJsnO
         iutQ==
X-Gm-Message-State: AAQBX9eJfsuDJ30PmV91/QQgUqQmYmxVwoFQlaiYUES5FLjepvjj6Dy/
        yKuDAVZ06cbdI6wdpL7OpQBx+w==
X-Google-Smtp-Source: AKy350bop+wpdj9i3wKW2k/44nNJUMknqVjf+xVWhqU9jOd5p4BncKHQf8G+uV2pyGqFwmtzhyC9pA==
X-Received: by 2002:ac2:530d:0:b0:4e9:a9e6:2752 with SMTP id c13-20020ac2530d000000b004e9a9e62752mr3396168lfh.22.1679909100406;
        Mon, 27 Mar 2023 02:25:00 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id f9-20020ac25089000000b004e9d2af99c0sm3372837lfm.71.2023.03.27.02.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 02:25:00 -0700 (PDT)
Message-ID: <506a7e48-2576-0fa6-d5e9-0157539bcebf@linaro.org>
Date:   Mon, 27 Mar 2023 11:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/5] usb: dwc3: qcom: Allow runtime PM
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230325165217.31069-1-manivannan.sadhasivam@linaro.org>
 <cc7392c1-0ea1-29b3-fab6-19c843413724@linaro.org>
 <20230327091733.GA14584@thinkpad>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230327091733.GA14584@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.03.2023 11:17, Manivannan Sadhasivam wrote:
> On Mon, Mar 27, 2023 at 11:01:35AM +0200, Konrad Dybcio wrote:
>>
>>
>> On 25.03.2023 17:52, Manivannan Sadhasivam wrote:
>>> Hi,
>>>
>>> This series allows the dwc3-qcom driver to do runtime PM itself without
>>> userspace intervention. Still, userspace is required to enable runtime PM
>>> for dwc3 glue and xhci drivers as we cannot enable runtime PM for them.
>>> But this series avoids one more additional step.
>> What sort of 'userspace intervention' are we talking about?
>> echo mem > /sys/power/state?
>>
> 
> I forgot to add that bit:
> 
> echo auto > /sys/devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.1.auto/power/control
> echo auto > /sys/devices/platform/soc@0/a8f8800.usb/a800000.usb/power/control
> 
> You need to set "auto" for the runtime control for both xhci and dwc drivers.
> 
> Then if you don't connect a usb device, all 3 drivers (dwc3-qcom, dwc3, and
> xhci) will become runtime suspended after a delay of 5s (default delay).
> 
> This can be confirmed by:
> 
> cat /sys/devices/platform/soc@0/a8f8800.usb/power/runtime_status
> 
> After connecting a usb device, they will all become "active".
Thanks! And if I'm following correctly, we can't enable runtime PM
for the DWC3 glue and XHCI drivers, as that would cause havoc on
other, non-qc platforms. Is that correct?

Konrad
> 
> Thanks,
> Mani
> 
>> Konrad
>>>
>>> While enabling runtime PM, I noticed that the xhci driver suspends before
>>> catching the xhci interrupts during resume. This ended up deferring the
>>> device enumeration for some time. So I included a patch adding autosuspend
>>> delay of 200ms to the xhci driver. With this delay, usb enumeration happens
>>> properly.
>>>
>>> This series has been tested on SC8280XP-CRD and RB5 devices.
>>>
>>> Thanks,
>>> Mani
>>>
>>> Manivannan Sadhasivam (5):
>>>   arm64: dts: qcom: sc8280xp: Add missing dwc3 quirks
>>>   xhci: host: Use 200ms autosuspend delay for runtime suspend
>>>   usb: dwc3: qcom: Fix null ptr access during runtime_suspend()
>>>   usb: dwc3: qcom: Clear pending interrupt before enabling wake
>>>     interrupt
>>>   usb: dwc3: qcom: Allow runtime PM
>>>
>>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 14 ++++++++++++++
>>>  drivers/usb/dwc3/dwc3-qcom.c           | 13 +++++++++----
>>>  drivers/usb/host/xhci-plat.c           |  2 ++
>>>  3 files changed, 25 insertions(+), 4 deletions(-)
>>>
> 
