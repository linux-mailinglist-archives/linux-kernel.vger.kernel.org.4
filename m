Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B448074940C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjGFDIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFDI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:08:29 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247CF1BF7;
        Wed,  5 Jul 2023 20:08:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so209948a12.1;
        Wed, 05 Jul 2023 20:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688612908; x=1691204908;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkswXhgVYLum5NAuYw9zYKn7kb93ZCamEnpThtSqHNc=;
        b=S3is4OStCcuBp9VXOE2UDwGY1EdZNPtDBNIShgNjO2ImugFGUKpwVRwPpSRa0+C6ee
         lvANFsMxW1CNYqXS0/WWuK7Y5+aiH4ZURb5ItUIinZOMeL4QgqyRlPCF9GuoIHmiIscu
         XPKcSvn6XDiu98lirHCA1rWuWmpdA07TLqsXU9tTYjunKKR6ArzdVNy+zjB584hwsTt3
         GUfD99svNOngxdn/SYf+WHgvY5io9RbYmwKo5RXDnZN3M+DHCx1+Y8mDPXQhVzqLBqmM
         5Fat7gJD0npAwHt3alPSauqFApN6RqU86demE4lm2grNV1dI8amc9YXEBSMlxM1koPSN
         PZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688612908; x=1691204908;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkswXhgVYLum5NAuYw9zYKn7kb93ZCamEnpThtSqHNc=;
        b=XKUdROJChHPnIxPHTUaM9ncCAdxqq6UHOTalGEWr7cUD5rzIkh9duLg7qio04fMLdV
         rPG3NX3UGO7KrTbtJ1gsHr8csoHDKjl/jNbMZ6ta2JRytzeDd00NPzXfUJHVJE8aYhMV
         B6GEMKdFzZFOiN7h/QydwL3h1/ZwW6+MuLviQz2x1UiiHwWKEwl1fbROtOJxaa/7ppr+
         NURfWzJibkBYKvwN0I2bSTButCTm8z1zaZBlKtGPVKsgcFeGfL7M+1GkQGT3mVSe0eLu
         MKPUy02vQy9wI/xpFcWNgTMryAxdrLHQdzgxLK2AY3xTVcwqzXMO/Gwy25BuUWwPypp8
         TY8g==
X-Gm-Message-State: ABy/qLaaSTBDDOERFBGU8rzs9Tmal8Rc8ZqtvSq89BUb4Dv3D5OUxOkb
        f9y1Um/8QDNZGZNECs6rOAxsHUn6HPLMwho7
X-Google-Smtp-Source: APBJJlGylu/y1J6UmD5L0LCkDB3980SfnVTwY5UUOgqM0SRWc727bzWb5tomce3Ltd6cmX+TmhrHew==
X-Received: by 2002:a05:6a20:13d9:b0:12d:d379:6e6c with SMTP id ho25-20020a056a2013d900b0012dd3796e6cmr681861pzc.11.1688612908443;
        Wed, 05 Jul 2023 20:08:28 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id x23-20020aa793b7000000b00673e652985esm220170pff.44.2023.07.05.20.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 20:08:27 -0700 (PDT)
Message-ID: <50f4c10d-260c-cb98-e7d2-124f5519fa68@gmail.com>
Date:   Thu, 6 Jul 2023 10:08:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: 3 more broken Zaurii - SL-5600, A300, C700
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Dave Jones <davej@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ross Maynard <bids.7405@bigpond.com>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>
References: <7ea9abd8-c35d-d329-f0d4-c8bd220cf691@gmail.com>
In-Reply-To: <7ea9abd8-c35d-d329-f0d4-c8bd220cf691@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 09:09, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> The following patch broke support of 3 more Zaurus models: SL-5600, A300 and C700
>>
>> [16adf5d07987d93675945f3cecf0e33706566005] usbnet: Remove over-broad module alias from zaurus
>>
>> dmesg and lsusb output attached.
> 
> Because the description above was vague, I asked the clarification.
> The reporter replied:
> 
>> The problem is that networking to SL-5600 / A300 / C700 devices does not 
>> work. I cannot ping the devices.
>>
>> The error is occurring in zaurus.c. dmesg is missing the following line:
>>
>> zaurus 2-2:1.0 usb0: register 'zaurus' at usb-0000:00:1d.0-2, 
>> pseudo-MDLM (BLAN) device, 2a:01:39:93:bc:1a
>>
>> A patch was created in 2022 to fix the same problem with the SL-6000:
>>
>> USB: zaurus: support another broken Zaurus - 
>> [6605cc67ca18b9d583eb96e18a20f5f4e726103c]
>>
>> Could you please create another patch for the 3 devices: SL-5600 / A300 
>> / C700?
> 
> See Bugzilla for the full thread and attached dmesg and lsusb.
> 
> Dave: The reporter asked to write the quirk for affected devices.
> Would you like to create it?
> 

Thorsten: Email to the culprit author (Dave) bounced. What can
I do in this case? Should I start adding get_maintainer.pl output?

-- 
An old man doll... just what I always wanted! - Clara

