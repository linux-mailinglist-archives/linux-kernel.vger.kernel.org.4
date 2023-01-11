Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADFD66558C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjAKH5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbjAKH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:56:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7045FB1;
        Tue, 10 Jan 2023 23:56:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDE30B81AC7;
        Wed, 11 Jan 2023 07:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C57C433F0;
        Wed, 11 Jan 2023 07:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673423783;
        bh=2u7nhABhalr1syMdvDWnyzBAsvh3jha2i2GvzP5W6AI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lErlo3e4xmSv9OKudecdXAEB8QKLE+sW6hoWXlzF6rL5I42SakD9/9/DLREwZSV8g
         9J8b0+XtLK4QNsC5PYtAKQNK5Zd3CuF78U2GAiFLXVKRRdlMyYhyOU7UNkeF2NLsG4
         ctr8l/MvyaNfZtEkkcTaGLxQF8v2uYhCULiWvtQQrYRBjjuu0SQovDRAvnLvuzYlsu
         4rcAJLmBPzhTq1WN8Agx5RhFG3l+tCgOiWXqxwc9N/F6xD2Qm1nNK+7qwkKWXosd4g
         6nqWZYMOSA+8NRS7VZlgkNB5m1bt17pXtv24kJ1v8fkqXpI18fJCVHYIfE0Zj7HDLM
         JNn7Mm/+oqSbg==
Message-ID: <e83108ff-3f9b-8087-f7da-3b95bf89f0d3@kernel.org>
Date:   Wed, 11 Jan 2023 08:56:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
To:     yuji2.ishikawa@toshiba.co.jp, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230110014143.18684-1-yuji2.ishikawa@toshiba.co.jp>
 <20230110014143.18684-2-yuji2.ishikawa@toshiba.co.jp>
 <b0245b64-a3eb-a242-8824-9effe0c63f0e@kernel.org>
 <TYAPR01MB6201932EC0EAB58C4228CD4292FC9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <TYAPR01MB6201932EC0EAB58C4228CD4292FC9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 03:19, yuji2.ishikawa@toshiba.co.jp wrote:
> Hello Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Wednesday, January 11, 2023 4:31 AM
>> To: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
>> <yuji2.ishikawa@toshiba.co.jp>; Hans Verkuil <hverkuil@xs4all.nl>; Laurent
>> Pinchart <laurent.pinchart@ideasonboard.com>; Mauro Carvalho Chehab
>> <mchehab@kernel.org>; iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ)
>> <nobuhiro1.iwamatsu@toshiba.co.jp>
>> Cc: linux-media@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Subject: Re: [PATCH v4 1/6] dt-bindings: media: platform: visconti: Add Toshiba
>> Visconti Video Input Interface bindings
>>
>> On 10/01/2023 02:41, Yuji Ishikawa wrote:
>>> Adds the Device Tree binding documentation that allows to describe the
>>> Video Input Interface found in Toshiba Visconti SoCs.
>>>
>>> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
>>> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people and lists
>> to CC.  It might happen, that command when run on an older kernel, gives you
>> outdated entries.  Therefore please be sure you base your patches on recent
>> Linux kernel.
>>
>> You missed few of them, so clearly this was not sent correctly.
>>
>>
>> Subject: drop second/last, redundant "bindings". The "dt-bindings"
>> prefix is already stating that these are bindings.
> 
> Thanks for reporting. The recipient was generated with an older kernel.
> I'll update the list and send the v5 patch.

The patchset should be rebased and tested on new kernel. But this still
does not explain missing CC to Rob - he is there since ages...

Best regards,
Krzysztof

