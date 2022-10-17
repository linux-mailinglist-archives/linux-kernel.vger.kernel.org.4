Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1B6600482
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 02:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJQAUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 20:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJQAUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 20:20:36 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EDA13D1D;
        Sun, 16 Oct 2022 17:20:35 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id p24-20020a9d6958000000b00661c528849eso4952264oto.9;
        Sun, 16 Oct 2022 17:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9kvM+3fJBdQWLpyLziSUQTeFnCrd9UUj5XCixO7Xv7s=;
        b=LahTpg9McgDs5JgGUv6uM1FVm+iHYG2rMm+XoOo/EjDguWm4Y2DbRLdtrV4e0/+LQv
         DaqD+3fk9msZ95byEkERKCbxwSRYiD/+phrr+et/scXyXdD2KUnSBKSAd/nHzw0yg3VM
         niYib1vsAh+iSH/5eHHEszQmHuusUuhIL6OnOotY0pq+DIvJLTpJp4eSnNfUGNbrOMWj
         YeuyK6Yk63fXboAvwgSDpwWgb10FZrspMAtiD3IuVdl9EdUXR5NNymoj0CjPi+TFygD4
         KQTZo4PNE27ZbTFPIQFELcvBRQuoFIP5vsaMEGxROvJ/pKnvx08uSeJLGXZaHcek/9Mk
         wouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kvM+3fJBdQWLpyLziSUQTeFnCrd9UUj5XCixO7Xv7s=;
        b=12t+zI4SCZPSHjUZaA9bifjxmyF1ePfbRk++f+LgZyJ14ImNaThQNwqGeHzqjuf8z7
         Jabud5lMEo6+yzt+Di1bXKvBx88xrLsPe83yImGikGan4+zHS1UHPAFA7LfxdCoA8kW5
         ntQ8i364vxya6b9LAps55OEY/ezGttn6nQX9Z9oGBwaQFnXnkDhR0XiGVYcOD8qTE7yr
         +7V9CUzyy5fnocPCUzYKZ5TEb9GTE+xWjCZ8cp7X5ETm1XPqyDurHf8wQNkgRZW7KheO
         mxTzMBJ60A2NQzx3vhQBJ7zLtQPZ06lMRJVRMqvuoJtejy/HKbpdNIKvACEbx5IdxbQ8
         qnJQ==
X-Gm-Message-State: ACrzQf27uwYO61D8ZLelShcWlkmz4VGjm1siIXNhcPE71ZeOC5LBeNqC
        TFNo1jeVbKG3HXBvO5fj6K8=
X-Google-Smtp-Source: AMsMyM49bfbewVsg57/0mjRK5pHKRVhj1LRLI5kkSirPLIlfxbFFs+MweNQxxmib3f1EfxuF2GX1Sg==
X-Received: by 2002:a05:6830:1343:b0:661:9598:6786 with SMTP id r3-20020a056830134300b0066195986786mr3804864otq.354.1665966034556;
        Sun, 16 Oct 2022 17:20:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m67-20020aca3f46000000b00350743ac8eesm3761627oia.41.2022.10.16.17.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 17:20:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <686b46bc-5986-abe5-8717-4c57d58d6581@roeck-us.net>
Date:   Sun, 16 Oct 2022 17:20:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] ARM: dts: armada-xp: add interrupts for watchdog
Content-Language: en-US
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
References: <20220211003257.2037332-1-chris.packham@alliedtelesis.co.nz>
 <20220211003257.2037332-2-chris.packham@alliedtelesis.co.nz>
 <87o839jw4p.fsf@BL-laptop>
 <0308a842-efcb-d4a0-f17c-2b0bf12c9dfb@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <0308a842-efcb-d4a0-f17c-2b0bf12c9dfb@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/22 15:39, Chris Packham wrote:
> Hi Gregory,
> 
> On 15/02/22 04:39, Gregory CLEMENT wrote:
>> Hello Chris,
>>
>>> The first interrupt is for the regular watchdog timeout. Normally the
>>> RSTOUT line will trigger a reset before this interrupt fires but on
>>> systems with a non-standard reset it may still trigger.
>>>
>>> The second interrupt is for a timer1 which is used as a pre-timeout for
>>> the watchdog.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>>
>> To keep bisectability this patch should be merged after the driver
>> patch.
>>
>> Thanks,
>>
>> Gregory
> 
> The driver changes were merged a while back. Looks like your intention
> was for this to go in via the watchdog tree but that never happened.
> Could you take it through your tree now? Probably won't be until 6.2 now
> but that's fine.
> 

We don't take any actual devicetree changes. Those need to be pushed through
architecture/platform trees. Anything else would create never ending conflicts
(and I strongly suspect that various maintainers would complain).

Guenter

