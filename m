Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C57D65590A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 08:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiLXHzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 02:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXHzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 02:55:20 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4303418687;
        Fri, 23 Dec 2022 23:55:20 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p8zNE-0003Re-2D; Sat, 24 Dec 2022 08:55:16 +0100
Message-ID: <69ccf9f3-ce2e-600d-00b3-51ccc4a73011@leemhuis.info>
Date:   Sat, 24 Dec 2022 08:55:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [6.2][regression] after commit
 cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae stopping working wifi mt7921e
Content-Language: en-US, de-DE
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     lorenzo@kernel.org, sujuan.chen@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre+XJS_s5FgVteYA@mail.gmail.com>
 <678adc67-9e46-3eef-f274-c951b121570f@nbd.name>
 <CABXGCsMUbs+bf=tWnx98r4v_JzVmYdVyOos9EhcGJ6jnEwathA@mail.gmail.com>
 <a30d8580-936a-79e4-c1c7-70f3d3b8da35@nbd.name>
 <CABXGCsNJKy2SQffeU+uaua5SM_77YiGKdPLRdzSF3F+ShpF+5w@mail.gmail.com>
 <3cb53fbd-0bee-22f9-bba2-6ac4a87db521@nbd.name>
 <CABXGCsOarWTb9+ofcd14bLGuWEQOTqRQQ0bXP57mhVjnpjcEQQ@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CABXGCsOarWTb9+ofcd14bLGuWEQOTqRQQ0bXP57mhVjnpjcEQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1671868520;e5af03e8;
X-HE-SMSGID: 1p8zNE-0003Re-2D
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.12.22 07:47, Mikhail Gavrilov wrote:
> On Wed, Dec 21, 2022 at 10:17 PM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> Sorry, I worked on a tree that had other pending fixes applied.
>> Please try this:
>>
>>
>> --- a/drivers/net/wireless/mediatek/mt76/dma.c
>> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
>> @@ -205,6 +205,52 @@ mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
>>         mt76_dma_sync_idx(dev, q);
>>   }
> [cutted]
>>   EXPORT_SYMBOL_GPL(mt76_rx_token_consume);
>>
> 
> I confirms after applying this patch the issue was gone (wifi works as
> before commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae).
> 
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> 

TWIMC, there are two more reports that at least to my eyes look like
they are about the problem discussed here:

https://bugzilla.kernel.org/show_bug.cgi?id=216829
https://bugzilla.kernel.org/show_bug.cgi?id=216839

I pointed both reporters to this thread.

Ciao, thorsten
