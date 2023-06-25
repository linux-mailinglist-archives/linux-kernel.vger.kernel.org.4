Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CB473D523
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjFYXFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYXFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:05:35 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78991A3;
        Sun, 25 Jun 2023 16:05:32 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b7206f106cso2091231a34.1;
        Sun, 25 Jun 2023 16:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687734332; x=1690326332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/NcnRc4T0o1t4O2y9WdosBv1HmRGzHO7rljVZKS/vtw=;
        b=DWGXcKWA8mJpSlfe7rytQ9jD3o/OLn7RkOiLBBnByUY/5r0y1CALU8GTLHhcaYzOQ3
         Xyv4rTbzJ+XJvEtj8j64lz4TYmA4WDcy96TiTbeuGQh/dNK97JqSwxXwFCdczK/ZVZsF
         +HHDKoQlwyQ94ARC5PmVtE+fsoIvYmoaWFZ/8deSnhfXwvpw1pzMPJd3Xt2z+CfKdzMR
         oxB3ACWLbow0x9KvCe0u85nob7cjMGrQk2YvWTSsp8yHJxKJ1XLi8/hdwGQ2zX0nZP82
         4aB1FQaeCL04m+rc8XAyvZz+oyt+14fjZFcojKIGQ/vCOFp66xegHdHcGCeHCl+Iopvs
         C8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687734332; x=1690326332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NcnRc4T0o1t4O2y9WdosBv1HmRGzHO7rljVZKS/vtw=;
        b=ViiT4wmcGHeCGd2FGZoXF8xdgXOt4sdxvXTlno2YGWb/ZXEoLJOoubo6hIybqfN3TZ
         WVixLMoOLlyTEPEEHlalpJ/Ktwnr8mRCP2Og0/Sw5makgoSNu+sJkO53feQOzBN9o43U
         wrdZi09a58Ho1MKK+sZv8yWXUKIDIgYC0dGav7shWTD5EsN1yxjf67HE4EWFKNrtw8eF
         yfyd5iWap1sbWWqI2DGlWKYXu/ZOZ+WK88SMSUS8V3vHuaoIvwSUQ0jltc6JyeFSTeKg
         PEZifuoS8WwQC2x1+0RLhzpxA0HZ5avJ7JtmGfaS6Qx68wtYeDVgOYez8c+GxHz2w4BD
         gyIQ==
X-Gm-Message-State: AC+VfDw1RAbxDQZzrSYSzsyvaW0QmL+zZlJ68oL4w6pDDmUA/VB5FRCl
        EOmFkyeo+PW4U1RP9iKIX9s=
X-Google-Smtp-Source: ACHHUZ6F/t+CjYz3dH4q0+WC+LUKE4SgfRB50r+VZeqbojjjx8nQ40wfPh+s9QWadsUpAdtgglV8oQ==
X-Received: by 2002:a05:6830:e13:b0:6b7:30d6:f4ed with SMTP id do19-20020a0568300e1300b006b730d6f4edmr3595867otb.5.1687734332029;
        Sun, 25 Jun 2023 16:05:32 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id di7-20020a0568303a0700b006b4281cf424sm2036723otb.4.2023.06.25.16.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 16:05:31 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <67faf4f4-f36c-3ff7-03b8-cd259e4a5548@lwfinger.net>
Date:   Sun, 25 Jun 2023 18:05:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: After kernel 6.3.7 or 6.3.8 b43 driver fails
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
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <RO2P215MB1938BD13105900F3525E0FE7A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/23 16:11, Sardonimous wrote:
> On 6/25/23 13:17, Larry Finger wrote:
> 
>> On 6/25/23 13:12, Arnd Bergmann wrote:
>>> On Sun, Jun 25, 2023, at 18:58, Sardonimous wrote:
>>>> I have been unable to get DMA to work in the past.  So I have been
>>>> configuring it with PIO=1 (/etc/modprobe,d/b43.conf):
>>>>
>>>>       options b43 pio=1 qos=0
>>>>
>>>
>>> I think the qos=0 parameter is what causes the WARN_ON(), as that
>>> causes the use of only one queue, while the warning happens when
>>> tx function iterates over all the queues and warns that they don't
>>> exist.
>>
>> I agree and suggest running with no options. If we need debug, we can turn it 
>> on later.
>>
>> Larry
> 
> Sure. Of course, this is what I started out with years ago (2017?) when I was 
> trying to get this to work.
> 
> Now:
> Linux version 6.3.9-arch1-1 (linux@archlinux) (gcc (GCC) 13.1.1 20230429, GNU ld 
> (GNU Binutils) 2.40.0) #1 SMP PREEMPT_DYNAMIC Wed, 21 Jun 2023 20:46:20 +0000
> 
> This is the sort of loop I get (dmesg | grep b43):
> 
> [   31.979539] b43-pci-bridge 0000:02:00.0: Sonics Silicon Backplane found on 
> PCI device 0000:02:00.0
> [   35.239389] b43-phy0: Broadcom 4322 WLAN found (core revision 16)
> [   35.275018] b43-phy0: Found PHY: Analog 8, Type 4 (N), Revision 4
> [   35.275046] b43-phy0: Found Radio: Manuf 0x17F, ID 0x2056, Revision 3, Version 0
> [   66.890631] b43-phy0: Loading firmware version 784.2 (2012-08-15 21:35:19)
> [   67.437162] b43-phy0 ERROR: DMA RX reset timed out
> [   67.498976] b43 ssb0:0: Timeout waiting for bitmask 01800000 on register 0F90 
> to clear
> [   67.707177] b43-phy0: Loading firmware version 784.2 (2012-08-15 21:35:19)
> [  391.127300] b43-phy0 ERROR: DMA RX reset timed out
> [  391.360514] b43-phy0 ERROR: DMA TX reset timed out
> [  391.382127] b43 ssb0:0: Timeout waiting for bitmask 01800000 on register 0F90 
> to clear
> [  391.590659] b43-phy0: Loading firmware version 784.2 (2012-08-15 21:35:19)
> [  709.123840] b43-phy0 ERROR: DMA RX reset timed out
> [  709.357235] b43-phy0 ERROR: DMA TX reset timed out
> [  709.378623] b43 ssb0:0: Timeout waiting for bitmask 01800000 on register 0F90 
> to clear
> [  709.573851] b43-phy0: Loading firmware version 784.2 (2012-08-15 21:35:19)

Sardonimous,

Did it ever work with DMA. or was PIO the only way to get it to work?

If you add in only the pio=1 option without qos, will it work?

If I were to send you some test patches, could you create a kernel with them 
applied?

Larry

