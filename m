Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E8A6558E2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 08:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiLXHUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 02:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiLXHUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 02:20:51 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2216404
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 23:20:50 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p8yps-0000x0-Oo; Sat, 24 Dec 2022 08:20:48 +0100
Message-ID: <f1770b7c-d287-a255-0298-2523ce3a9565@leemhuis.info>
Date:   Sat, 24 Dec 2022 08:20:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [6.2][regression] after commit
 ffcb754584603adf7039d7972564fbf6febdc542 all sound devices disappeared (due
 BUG at mm/page_alloc.c:3592!) #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     alsa-devel@alsa-project.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com>
 <5dff36ee-bfe5-4596-b01d-0eaca1b552bd@leemhuis.info>
In-Reply-To: <5dff36ee-bfe5-4596-b01d-0eaca1b552bd@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1671866450;edf446c9;
X-HE-SMSGID: 1p8yps-0000x0-Oo
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.12.22 13:17, Thorsten Leemhuis wrote:
> [Note: this mail contains only information for Linux kernel regression
> tracking. Mails like these contain '#forregzbot' in the subject to make
> then easy to spot and filter out. The author also tried to remove most
> or all individuals from the list of recipients to spare them the hassle.]
> 
> On 15.12.22 15:17, Mikhail Gavrilov wrote:
>> Hi,
>> The kernel 6.2 preparation cycle has begun and yesterday after the
>> kernel was updated on my Fedora Rawhide all audio devices disappeared.
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced ffcb754584603adf
> #regzbot title dma-mapping: audio devices disappeared
> #regzbot monitor:
> https://lore.kernel.org/all/20221220082009.569785-1-hch@lst.de/
> #regzbot fix: dma-mapping: reject GFP_COMP for noncohernt allocaions

The typo in the subject of the fix was fixed, hence this is needed:

#regzbot fix: 3622b86f49f8
