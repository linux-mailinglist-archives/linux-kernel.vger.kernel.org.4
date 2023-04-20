Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01F96E8D61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjDTI50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjDTI4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:56:42 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604DA59C8;
        Thu, 20 Apr 2023 01:54:38 -0700 (PDT)
X-UUID: 3bc7c0257ccf46a69a1e28c32f8c59b3-20230420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:bca1b735-45ee-4a54-8e61-ae6b0acbe2dc,IP:-32
        768,URL:-32768,TC:-32768,Content:-32768,EDM:-32768,RT:-32768,SF:-32768,FIL
        E:-32768,BULK:-32768,RULE:Release_Ham,ACTION:release,TS:0
X-CID-INFO: VERSION:1.1.22,REQID:bca1b735-45ee-4a54-8e61-ae6b0acbe2dc,IP:-3276
        8,URL:-32768,TC:-32768,Content:-32768,EDM:-32768,RT:-32768,SF:-32768,FILE:
        -32768,BULK:-32768,RULE:Release_Ham,ACTION:release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:nil,BulkID:nil,BulkQuantity:0,Recheck:
        0,SF:nil,TC:nil,Content:nil,EDM:nil,IP:nil,URL:nil,File:nil,Bulk:nil,QS:ni
        l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 3bc7c0257ccf46a69a1e28c32f8c59b3-20230420
X-User: gehao@kylinos.cn
Received: from [172.20.12.78] [(116.128.244.169)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 150126191; Thu, 20 Apr 2023 16:54:06 +0800
Message-ID: <7b162010-4fa3-4572-c834-7264eb937e4a@kylinos.cn>
Date:   Thu, 20 Apr 2023 16:53:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH] mediatek/clk-mt8173-apmixedsys: convert to
 devm_platform_ioremap_resource
To:     Stephen Boyd <sboyd@kernel.org>, matthias.bgg@gmail.com,
        mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230413090128.60119-1-gehao@kylinos.cn>
 <f09425fde83f4b21ee301ef8810c4c29.sboyd@kernel.org>
In-Reply-To: <f09425fde83f4b21ee301ef8810c4c29.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 02:40, Stephen Boyd wrote:
> Quoting Hao Ge (2023-04-13 02:01:28)
>> diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
>> index a56c5845d07a..fe386bf8225d 100644
>> --- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
>> +++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
>> @@ -90,7 +90,7 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
>>          struct clk_hw *hw;
>>          int r;
>>   
>> -       base = of_iomap(node, 0);
>> +       base = devm_platform_ioremap_resource(pdev, 0);
>>          if (!base)
> 
> This needs to be updated.
> 
>>                  return PTR_ERR(base);
> 
> And PTR_ERR(NULL) is 0, which is wrong.
Thank you for pointing out this point and Sorry for the late reply.
I will update the v2 for it.

Best regards.
Hao
