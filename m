Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F90373EFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjF0AbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF0AbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:31:08 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDEA1702;
        Mon, 26 Jun 2023 17:31:07 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b708b97418so3575833a34.3;
        Mon, 26 Jun 2023 17:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687825866; x=1690417866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=O/2c9YwwQFhf0X0LD7Wd4iGQMCYKRK/hqVyQ7BZ1+ok=;
        b=q8mhZZdYPrHx1I3QLvplF2h9BxzqYZesS+LMX5o3xCNa2BrRmKGuk0gzEUXntLV366
         D24KIkzO67C2Wb+RbX7NYZQbzbEjoKTEWGD0nJ+8UFVIjBP7YZgTO6PvjHnd3ejedoHP
         bKVL3syv5a9hXjbDpCcSnhqBlB44YgNm/+8RO65bAbaYpZpRXe8g9ezxRZqDvkW4I98d
         FrnuSfeiVGtmb7Tx1o6ACRV73r4qa5h5CMHXkgp5+OIVXQbmsjofJzquTTxHICf6YWFZ
         eAMboNZNdMx6oVqDMt4Ing9al5z9YVwzMu3iEk8Lu0rLyO1gQ9CiCeiGwwlYge2r/VYd
         VCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687825866; x=1690417866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/2c9YwwQFhf0X0LD7Wd4iGQMCYKRK/hqVyQ7BZ1+ok=;
        b=CdmiZ1wtTmzoAm036k1/Y7kfRedwg3Mf9T5QQCiaQDJZCiG3Mt5qIaPqpAwv2xsIcx
         nE9y3DwiXLbzLK9edH2erPNnuTVl/Fk0MaaQbM5Mr2UlDyeoPAFVD1cW2tY6786VIYTY
         HEFkMQ+vgvv6tT8jFeKOgwJwSmQAxe5e7hrtCBFAplyRg1Y9kNi8QOF2dxfnDQq7Dd1A
         /mJmnHDJj/vmA1xQrqu/ozvO/EToTBKn/pUqxGGowhbcLzwvwD/9aoGkSA0ul4HDj0jA
         upsRPoLb1OLWfGpyrbNV2nbeZDW0ZigIw67QqyUiZz9pJ0pdN+wbRkgPU7ZfqtXkkkgY
         w4WA==
X-Gm-Message-State: AC+VfDzBEisI71WqyJOFMSomtZmHWc58U2cR0zW824gQZfLabRkJs704
        jRcLZKAMQ8VpDN6u11vQB5y3PXjmUmE=
X-Google-Smtp-Source: ACHHUZ55w/s5bZkFY+aekRuMQHhZ6sW4heSKvm03Smaj5yPZV18Y21i2LabwstcZX3q+GaColKLSGw==
X-Received: by 2002:a9d:4801:0:b0:6b7:38c0:7420 with SMTP id c1-20020a9d4801000000b006b738c07420mr8014064otf.9.1687825866336;
        Mon, 26 Jun 2023 17:31:06 -0700 (PDT)
Received: from [192.168.1.128] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id t6-20020a9d7486000000b006b735499817sm2722862otk.25.2023.06.26.17.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 17:31:05 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <02659cdf-753b-442d-f110-1f92619d55c7@lwfinger.net>
Date:   Mon, 26 Jun 2023 19:31:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: After kernel 6.3.7 or 6.3.8 b43 driver fails
Content-Language: en-US
To:     Sardonimous <sardonimous@hotmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Cc:     =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>
References: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
 <b9428e48-f0f9-46f6-892c-4c8834c930c4@app.fastmail.com>
 <RO2P215MB193850DDADD38492BEC8CC2FA720A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <a3bc5eb5-9639-8016-36ab-105abc8c0ca3@gmail.com>
 <69b98eb4-2c4e-fe75-90b4-4b08505a595a@lwfinger.net>
 <RO2P215MB193879B2D99DD0BAF59EFA92A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <e0a08449-554a-4a28-ac50-7051866eb95e@app.fastmail.com>
 <da80b806-de3f-c7ea-0352-cd23e0f6dd65@lwfinger.net>
 <RO2P215MB1938BD13105900F3525E0FE7A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <67faf4f4-f36c-3ff7-03b8-cd259e4a5548@lwfinger.net>
 <RO2P215MB1938BA68BBB683EC696F4BFAA726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <6afa0ebc-1d3f-8cba-79dc-8ddfe13c296a@lwfinger.net>
 <RO2P215MB193898F3008E0F390CCEBC87A726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <RO2P215MB193898F3008E0F390CCEBC87A726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 16:33, Sardonimous wrote:
> 
> On 6/26/23 10:21 AM, Larry Finger wrote:
>> On 6/26/23 07:44, Sardonimous wrote:
>>> If I were to send you some test patches, could you create a kernel with them 
>>> applied?
>>>
>>> Doubtful.
>>
>> Sardonimous,
>>
>> OK, that essentially eliminates  getting DMA to work. The cost of a 
>> MacBookPro7 is too much for me to acquire one to debug that issue.
>>
>> On my PowerBook G4, I also got the failure to connect, thus I should be able 
>> to fix that problem, but getting a new kernel with the fix onto your machine 
>> will not be easy.
> 
> It might be possible to follow the arch instructions for patching the kernel
> 
> https://wiki.archlinux.org/title/Kernel/Arch_build_system
> 
> It takes about a day to rebuild the kernel following this procedure.
> 
>> Is it possible to ssh into your machine, or to use TeamViewer? Those questions 
>> do not need an answer now, but think about them.
> 
> This is complicated by being in a CGNAT environment.  I usually do this via 
> tailscale.  Will have to think about it.
> 
>> Larry
> 
> Should pio=1 qos=0 cause the problems that it does?  It if is no longer a 
> supported configuration, perhaps it should fail more gracefully.

Setting qos=0 will generate a harmless warning, but the network still works. 
Using pio=1 should still be supported.

I am bisecting the source. It will take a while as I still have 13 kernels to 
build and my PowerBook G4 takes about 6 hours per build - it is a lot slower 
than your computer. At this point, I know that kernel v6.1.0 works, and that 
v6.2.0-rc4 fails.

If you can find a 6.1 kernel, it should work for you. Once I know the fix, we 
can explore having you patch and rebuild your 6.3.X kernel.

Larry



