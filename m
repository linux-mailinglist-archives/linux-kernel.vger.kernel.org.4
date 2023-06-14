Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F9C72F187
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbjFNBTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241935AbjFNBS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:18:58 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68510123;
        Tue, 13 Jun 2023 18:18:57 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-543d32eed7cso2730564a12.2;
        Tue, 13 Jun 2023 18:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686705537; x=1689297537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8rlEEo9ikUJaK6kPNcD1MGYGJ2duYtePI073tq2+zWU=;
        b=oYEYcNMp5KxkPdf9UjssCKvX91RZnKPWQtliT4xkdMh6wUhLo/HgUtc6IEG9O9gWud
         UE7s6bBVjSDQlT34wkCTUrN+n4tVKq7ty2Lvo7KEklUuhSeFPp9Ielx4042MlB7ltx8m
         wVf3kkXSdv7HWSKG92NqsSa6cEQUbmxEfe1dI3b5QyY0K0ysT6cXzf2Sxi7Cr+/Uvh1n
         yRWpDwsckYZTY0Mnaro9ti9D6vBNc9RUDvgp+yCwURmT6cqhkU95SrugTV9UFJoJCjfL
         v9JwFKNBFcYVqynPfElCM7VG3G6b6bgXSQasb5wv+e5k6qDZ1ogVd6G+umOL1OBJsTSh
         fwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686705537; x=1689297537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rlEEo9ikUJaK6kPNcD1MGYGJ2duYtePI073tq2+zWU=;
        b=SoJABvx8If0Rd14keRDrxBCXLtUHkIpKODzNVTaGtV7KYU+shYVcqHilsfJXLfeaaC
         i1SgCR1RspIhrRPo09IJWuY3xJ4RZ+1U/1g5lituTBz8SWYYvhLwQ5Dm+6mPJNwQTbfk
         G3MWp8DvDHGMU50iQTEhXfd4eMe2Oq68LH4wLiTMJ5o6Zvzyrbi394YOO6pOeqz4/6Nc
         YdawNshr7DSSlJISnJUdO0cZCcUQvKoUzxnz0TSkXo0IM1YT8xz9Za8UfZmig+4b4Cji
         xVAqhtHSS7a+F7DECyPYO7uJvs0//I7SP0aFJInPHos7S5zp2OywNI/kNiB9oIcwJD5C
         JMeg==
X-Gm-Message-State: AC+VfDy2RyUq5imua9GcEQzeXbGryb7jnHMKGiXjHXzmJFAMMKJGjr5e
        9/hlEg7ifQDr4KGRyMN8QuUURs24IWw=
X-Google-Smtp-Source: ACHHUZ6ST5lfSynOfzFpFQetsY4B3xQufhNg6RfgeefKg/BKLEcPb8+yNElTpG47QCrMvPN+Efpjzg==
X-Received: by 2002:a17:902:e74e:b0:1b3:8865:aaae with SMTP id p14-20020a170902e74e00b001b38865aaaemr13011364plf.53.1686705536763;
        Tue, 13 Jun 2023 18:18:56 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902ea5500b001ac8e0ea157sm10804832plg.144.2023.06.13.18.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 18:18:56 -0700 (PDT)
Message-ID: <a2ff6965-e373-5bce-00cd-c8d9deb287c8@gmail.com>
Date:   Wed, 14 Jun 2023 09:18:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 1/1] tty: serial: Add Nuvoton ma35d1 serial driver
 support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, jirislaby@kernel.org, tmaimon77@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230612025355.547871-1-ychuang570808@gmail.com>
 <20230612025355.547871-2-ychuang570808@gmail.com>
 <2023061325-distant-gaffe-8871@gregkh>
 <0e40cbe6-0e88-b300-3507-5fa92eadb46d@gmail.com>
 <2023061312-outsource-triumph-7dd6@gregkh>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <2023061312-outsource-triumph-7dd6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,


On 2023/6/13 下午 10:48, Greg KH wrote:
> On Tue, Jun 13, 2023 at 07:03:11PM +0800, Jacky Huang wrote:
>> Dear Greg,
>>
>>
>> On 2023/6/13 下午 06:29, Greg KH wrote:
>>> On Mon, Jun 12, 2023 at 02:53:55AM +0000, Jacky Huang wrote:
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> This adds UART and console driver for Nuvoton ma35d1 Soc.
>>>> It supports full-duplex communication, FIFO control, and
>>>> hardware flow control.
>>> You don't specify here what your tty device name is going to be, why?
>>>
>>> It's not written anywhere, is that intentional?
>>>
>>> Same for your tty major/minor, what numbers are you using that might
>>> also be in use by a different device in the system?
>>>
>>> thanks,
>>>
>>> greg k-h
>> I will add description about the tty name to the log.
>> In practical testing, we specified in the u-boot parameters
>> to use ttyNVT0 for the console, and it worked fine.
> Where did you pick that name from?  Why can't you use the "default" uart
> name instead?
>
> I thought we had a list of tty names around somewhere, but I can't find
> it right now...
>
> thanks,
>
> greg k-h

Initially, we were using the well-known ttyS, but it is used by the 8250 
driver.
Since the MA35D1 UART is incompatible with the 8250 driver, Andr raised
concerns about using ttyS.

To differentiate this UART from the incompatible 8250, we defined ttyNVT.
This name is specified in the driver's UART name and console name
structure, and other serial drivers follow a similar approach. For example,
we can find names like ttySA, ttySAC, ttySC, ttySIF, ttySTM, ttySUP,
and so on.

If you believe that this UART driver can use ttyS, I am more than willing to
make the modification. After all, some applications and scripts default to
using ttyS, and using ttyNVT can indeed cause some inconvenience in
certain situations.

Best regards,
Jacky Huang


