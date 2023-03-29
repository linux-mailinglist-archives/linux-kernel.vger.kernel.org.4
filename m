Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CE66CD08C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjC2DNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjC2DNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:13:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2ED3AB4;
        Tue, 28 Mar 2023 20:13:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a16so12782833pjs.4;
        Tue, 28 Mar 2023 20:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680059595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpYwrBUei0Yntg7xFJOvTxfcN3SxHd8qVrHJBACjzb0=;
        b=ngQGLIGxJ/+cQJqhNgkIdH0oCIopO/k2BvAgnR1YoxZo0+r2cDwjzwhzAgJ5bAhZcc
         Gah6HI6eNok0z/c5KuGkgJzfHNXIjPCSuMR1gWXaaS7z7mYemW+bqXPjCeKV9+p3eiDN
         nT1bPUZrgkBvFrteeb9hACT/d6bCac646emwLTO/SF+vjTzX8OCxdK7yZw+NiS7AdqaR
         R87hxXb+KcnDn8LD4QH3RZjSRMcCpap7P2i4b/gL8aEkCDhu2C0jj7LQbF0G4V180Lkt
         jO1OztpwCBACr3NUyVqma7WuISjprC8S++SgGaHSlaj/PqlFxjHcXMr947qwr6dqvKsH
         WMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680059595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpYwrBUei0Yntg7xFJOvTxfcN3SxHd8qVrHJBACjzb0=;
        b=bGOQa6e96L5abXgTsFV0hPplM3V/FV163nTE73yCX13b7+JqY42dh/ULQMp1BwuBgp
         ttp/O8l6BvA2TGOdymGoDT8X9Danff4Rqe+1ADy2kpezdwMjtICgkFHRMIW7VDqeefY4
         xP0/NKwNI74HFNtxZA5RdZuW4jF10a1SzX/LYXoeOjLjqwc17CoBEYWVT183gWWJruV4
         lN6lYqZT87PRXrQi9XINvvD++TfwR0E0kAlFaSlfJcPvbS7dsXUgrcF9XVt9LGVFkJue
         IuxqeCGiVijBXqJrtNng1Px3EPTGrpYKxNZoJTG71BKKG7w9g8Lh8Bb41e+afktFX1ri
         0f4g==
X-Gm-Message-State: AAQBX9eSEi4V6qzHARFktlpj0ZxEhi7JKY/02WuSGAuAtFZYOUmG/uyd
        D1Js8r74vj4mcFmCJzK4w6M=
X-Google-Smtp-Source: AKy350b8F97veUYDd0LZIttnzIEOfuEPPq9b7fGWXm+kHGtxMVy8U/oAu5Wtr7QxcQVE4e9fx2QC5w==
X-Received: by 2002:a17:902:f2d3:b0:199:1160:956c with SMTP id h19-20020a170902f2d300b001991160956cmr534268plc.31.1680059594885;
        Tue, 28 Mar 2023 20:13:14 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jl1-20020a170903134100b0019cc3d0e1basm21765949plb.112.2023.03.28.20.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 20:13:14 -0700 (PDT)
Message-ID: <ad908782-8291-4240-d88e-61dff5a05ef7@gmail.com>
Date:   Wed, 29 Mar 2023 11:13:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 08/12] arm64: dts: nuvoton: Add initial ma35d1 device
 tree
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-9-ychuang570808@gmail.com>
 <ab4e0bc8834b7e618e9a88ea6a1c30cc.sboyd@kernel.org>
 <b7977069-4f82-76a1-10c1-b6400862c2c4@gmail.com>
 <c37e1f3a40c404acd81c2c9d5b28b340.sboyd@kernel.org>
 <129cf4b6-b3b5-2a12-5911-37e70a624812@gmail.com>
 <e5221cd020bc60513df6a1c1859e1acc.sboyd@kernel.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <e5221cd020bc60513df6a1c1859e1acc.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Stephen,


On 2023/3/29 上午 10:46, Stephen Boyd wrote:
> Quoting Jacky Huang (2023-03-28 19:39:36)
>> On 2023/3/29 上午 10:19, Stephen Boyd wrote:
>>> What do you use the syscon for then? The clock driver must want to use
>>> the syscon for something, implying that they are the same device.
>> The register lock mechanism is applied to protect many critical
>> registers from false written.
>> The register lock control register is one register in system controller.
>> Some registers of the clock controller are lock protected. Not only
>> clock controller, but other
>> IP such as RTC, PWM, ADC, etc, also have lock protected registers. All
>> these IP requires
>> syscon to access the lock/unlock control register in the system controller.
>> That's why we add a <&sys> to the clock controller.
>>
>> Should we implement a ma35d1-sysctl driver to protect register_lock()
>> and register_unlock()
>> and export to those drivers?  If yes, we can remove the <&sys> from
>> clock controller.
>>
> You can implement the lock and unlock in the hwspinlock framework. See
> drivers/hwspinlock.

I may not explain clearly enough. The lock/unlock register of system 
controller is more like
a kind of write protection for specific registers, rather than 
preventing hetero-core CPU access.
In many different IP of ma35d1 contain write protected registers.
In fact, ma35d1 has a "hardware semaphore" IP, and we have implemented 
the driver in drivers/hwspinlock.
Even the control register of "hardware semaphore" is also write protected.

So, should we implement a system controller driver to provide 
register_unlock() function?
Is it OK to have such a driver in drivers/mfd?
Or, just use syscon in device tree for those devices that have write 
protect registers.


Best regards,
Jacky Huang


