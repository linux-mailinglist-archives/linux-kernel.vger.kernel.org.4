Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3095B6251
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiILUkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiILUkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:40:46 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDDB19285;
        Mon, 12 Sep 2022 13:40:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bj14so17322551wrb.12;
        Mon, 12 Sep 2022 13:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=wEszEHUyzXdDAbDnhA3UlL1WJ5ZcMn3gra5lLB+dYuQ=;
        b=fU/j7QgrNqVGu58i0I7YtynmaDz/NzALnT1aKQSQIK7SwUhinPEKa4Lpb4/aS3DgS7
         0SSVvVbeZUC1O61pXSvy9jedmiptdWfmjKTghs3ptmHUaUiWRSZ8p/z1gYN/FYciYjG+
         tisxYvbzUZkEuBSNpQCg8+JBtKiEdtrDo6ZkOr1xeRE9qzLmDxSSnXbWGxmo88RQu7Bw
         wMwAjwKGNqx8Gm1/g4GmP5yxBsG4TfDW/pZUlqLBF++jLE/zv/eUcKZzCRN9f0THUWHy
         EQ9Tf44z1VNZ1QLSjPZDB2J2Xau5jvKzAras1OfKT4IqY7nEqQ+GnHqkMBVVZMsplD7e
         ecug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wEszEHUyzXdDAbDnhA3UlL1WJ5ZcMn3gra5lLB+dYuQ=;
        b=tx/VHS91eLhCm2U1vDRKvGDlgVvrsDMKXfmVQ0vIPhtThNTVr4pzs0t3otZ/gm4Qma
         B7gx2/OeZ639gF8Q3BTYVKe5EKFQY4IJuWwm91xsT5Bu5cw66he4owGfNvn1LSCYcdD9
         46tNiwE7KRv3+GTUdmGGMaxzB8BI8Zlpz9/Ng4zaMVBsQ4mZc9NN52AYgRrGPc5Cysz2
         dZ//GxJ2SVjpcxRLIyTL4pWIfyyOBRcQQ0BPEOXxw3bIRjagw5clO85wJtT1hohW6/gb
         DibmsfrkTwGR2/LZ2pFVKsBD2YdsKCSuIYrsuJnVOlbhO/zQWaNHuK1nAmF5TpJmBuwD
         dq5Q==
X-Gm-Message-State: ACgBeo2GuPstnvnri7s7l8VZrkxMpDuWIszYceihjo1ErFNkP6PJclVy
        SADxWzm8cBiMZBPjfF8TaTY=
X-Google-Smtp-Source: AA6agR7FDGVfY9HSA740Ecx6pHJzWPZToFBP2PHNU/S1y6z3QzLqHDkIlU+4tgeIYyCRZWZBCioSAg==
X-Received: by 2002:adf:ec03:0:b0:228:76bd:76fc with SMTP id x3-20020adfec03000000b0022876bd76fcmr16244105wrn.533.1663015243110;
        Mon, 12 Sep 2022 13:40:43 -0700 (PDT)
Received: from [192.168.42.87] ([212.2.175.203])
        by smtp.gmail.com with ESMTPSA id ch16-20020a5d5d10000000b0022abd7d57b1sm270753wrb.115.2022.09.12.13.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 13:40:42 -0700 (PDT)
Message-ID: <e8279305-6bad-4029-4436-b48a4a8d43e9@gmail.com>
Date:   Mon, 12 Sep 2022 23:40:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@oss.nxp.com>
Cc:     Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>
References: <CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com>
 <59b6dd0a-7cbb-5dbd-8da0-57baeba3327e@gmail.com>
 <CAJ+vNU2FVQRwCa3DnOwkFjaZg-ntFLZmetwDbSggDXDdwOOGTg@mail.gmail.com>
 <2ab24cc4-4aa2-d364-9b29-55f5d6b23626@denx.de>
 <CAJ+vNU0voeMW06Je6nyrV1Ud3sT8Us+RACcQtsKUwKVaXF+dQw@mail.gmail.com>
 <ce0ffc43-bae7-a55b-ebea-985abc765c33@denx.de>
 <DU0PR04MB9417D8123D40FBC980E9C05388439@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <a03ce7a3-dfa5-6016-afbf-33193a5e2376@denx.de>
 <8736ba4e-1c61-995a-f090-ef322d84e5f6@gmail.com>
 <0c924574-d2b4-2a23-0cc2-63f32d521854@oss.nxp.com>
 <CAJ+vNU1NW9cDDB4sa+uLK3G1Z782pPe=E=GtYLTswR2Xa1YnoQ@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
In-Reply-To: <CAJ+vNU1NW9cDDB4sa+uLK3G1Z782pPe=E=GtYLTswR2Xa1YnoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 20:15, Tim Harvey wrote:
> On Mon, Sep 12, 2022 at 12:40 AM Peng Fan <peng.fan@oss.nxp.com> wrote:

//snip

>>
>> After a thought, maybe an easier way is to add a optional property
>> xxx,32k-always-on to the pmic node/driver.
>>

Yes, that would be easy. Yet, creating a driver specific DT-property 
feels a tad wrong. I don't think the BD718xx is in any way special so it 
should not need such a vendor specific property. It might be better to 
find more generic solution.

> Is there simply a way to add the clk to the snvs_rtc and the wdog dt
> nodes so they have a use count and don't get disabled?

To me that does sound like the right thing to do. If we have a consumer 
which requires the clock, then describing this dependency in DT sounds 
like a correct approach - assuming this keeps the clock enabled without 
a race between instantiating the PMIC and finding the clock consumers.

Finally, if adding the consumers does not help, and if there will be no 
consensus regarding the generic property - then I think it's better to 
have a vendor specific property (as Peng suggested) than it is having 
the boards broken. Eg, if all else fails and if there is a buy-in for 
the vendor specific propety from Rob and Stephen - then I can also live 
with it (even if it sure significantly decreases my happiness level :p)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
