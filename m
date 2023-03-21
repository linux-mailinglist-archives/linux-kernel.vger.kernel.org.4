Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91386C2F67
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCUKsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCUKsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:48:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600554214
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:48:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d17so4720011wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679395689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fr4s/NbgFwlXaB/kT+wdNGLIVroo3XSqt3IGTfKlrw=;
        b=XpxtA4gxBxKDJ+qVj87Lm+nPdo9mRsPb9+gYYIOIqGAHVmtPw9Xws+tHNBVkr1HrMe
         KNw1h8gFTV68arDcGIVtYPpY9Z8mio8vMDw+jTo6BWD3wyTCCPWjF+EHtmKdMG/+c41f
         kz2Thg/wBZGzM3WGDsRfNjQdKFKwBawispP30fYPXblSeCtauxrT0p3XZqawGxwx2YHa
         2m9uWuLQ1+E0u0vnC0tG4bRnwKj6dfb7Qy7W8K+I0f2oy/QprtKkMEbWji4nzWsqPSF6
         6ibDObDfCxIdrlKzN/vM2WiNFTYdPp+GOLbZG9Ktk7WNe+nM8Cq8B2np38QurauyySPd
         GqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679395689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fr4s/NbgFwlXaB/kT+wdNGLIVroo3XSqt3IGTfKlrw=;
        b=3h35Ldu5Z9Ml8o4L/w/XaCyVKz9OFD5evAfxdANkM0p2SxjMGFy2m6YOw6lAuH7KmU
         Sw0igE6BzQaymdP1wnwvZ0PhMtva3E+x435rqamlgx+zn2KteuRYdyFbEtsol0ZLqvTj
         SFpj3jlS36/swjkf4ujUQ3cnsV1+1u6PJ3N5AdxWfwnEKlHJmSZsjXInR9ki/SvqyVOS
         Kv5Vtj/1CTZQabMFPG91ZCUXU4EUeNT5ZTLQ1h5WT2oWUyOzWaVcSrARUT46Z8rei5BF
         WkvTce5ikavssKsxPNpz3PB8OXBSmX2rPhEUBF5z3RQW4AQiyQx1LChzcXDWpFW0SDfr
         e9uA==
X-Gm-Message-State: AO0yUKXZzC9+slpbByjVD9tvn0J+EGHBhW9dboLVSyC57JufWUH1JGcw
        dCY9OClcaiKuhGUVJgmnIhrcmw==
X-Google-Smtp-Source: AK7set+Dx2bqwbuauE+ZNG0b4IJ0siP/A/tIE+bC6HdEArLrXCBXSI/i2Tk8rfNS7MbnYwY37Ql4ug==
X-Received: by 2002:adf:edc9:0:b0:2d1:5698:3f6e with SMTP id v9-20020adfedc9000000b002d156983f6emr1913160wro.58.1679395688892;
        Tue, 21 Mar 2023 03:48:08 -0700 (PDT)
Received: from [192.168.1.70] (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id a4-20020adffb84000000b002d322b9a7f5sm11010756wrr.88.2023.03.21.03.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 03:48:08 -0700 (PDT)
Message-ID: <5845f51e-5d87-c98e-77a1-0f9b6365e6c1@baylibre.com>
Date:   Tue, 21 Mar 2023 11:48:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: Add TI TPS6594 PMIC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     lee@kernel.org, krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        eric.auger@redhat.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, davem@davemloft.net,
        christian.koenig@amd.com, contact@emersion.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
References: <20230315110736.35506-1-jpanis@baylibre.com>
 <20230315110736.35506-2-jpanis@baylibre.com>
 <20230320155354.GB1733616-robh@kernel.org>
 <04914464-2bc2-9d86-e9e2-8a716b929f28@baylibre.com>
 <2dcfd9dc-6c43-20b7-e27b-8ec2883be237@linaro.org>
 <887d5e71-334c-b206-08e6-2cc822df9eda@baylibre.com>
 <2aeb47d6-0577-f8e4-6070-331af15b1f83@linaro.org>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <2aeb47d6-0577-f8e4-6070-331af15b1f83@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/23 11:32, Krzysztof Kozlowski wrote:
> On 21/03/2023 10:03, Julien Panis wrote:
>>
>> On 3/21/23 08:36, Krzysztof Kozlowski wrote:
>>> On 20/03/2023 17:35, Julien Panis wrote:
>>>> On 3/20/23 16:53, Rob Herring wrote:
>>>>> On Wed, Mar 15, 2023 at 12:07:33PM +0100, Julien Panis wrote:
>>>>>> TPS6594 is a Power Management IC which provides regulators and others
>>>>>> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
>>>>>> PFSM (Pre-configurable Finite State Machine) managing the state of the
>>>>>> device.
>>>>>> TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.
>>>>> As mentioned, the binding needs to be complete. It's missing GPIO at
>>>>> least. RTC and watchdog may or may not need binding changes.
>>>> Thank you for your feedback.
>>>>
>>>> About GPIO, do you speak about 'gpio-controller'
>>>> and/or '#gpio-cells' properties ?
>>> Yes.
>>>
>>>> For RTC (and for watchdog, once the driver will be
>>>> implemented), our driver do not require any node
>>>> to work. What could make an explicit instantiation
>>>> necessary in DT ?
>>> Properties from RTC schema, e.g. start-year, wakeup etc.
>> TPS6594 RTC driver is being reviewed (this is another patch
>> series, not merged yet). These properties are not used by our
>> driver, that's why we did not have to add some RTC node in
>> the DT (until now, using such properties in our driver was not
>> requested by RTC sub-system maintainers).
> Bindings should be complete, regardless whether you now need this in
> driver or not. Does your comment mean that you will never need these,
> because hardware does not support them, and never going to add?
> Otherwise I don't get why you refer to driver when we talk about bindings...

OK, I understand now (I misinterpreted "RTC and watchdog may or may not
need binding changes").

> Best regards,
> Krzysztof
>

