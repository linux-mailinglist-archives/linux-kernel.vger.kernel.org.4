Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221D16E60A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjDRMHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDRMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:07:34 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEDAA5EC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:00:56 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:815:8033:3f03:627a] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33IBnCtS027308-33IBnCtT027308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 18 Apr 2023 19:49:13 +0800
Message-ID: <b3a4c253-a9a8-9a6b-b5f1-cf4dd0615b5e@hust.edu.cn>
Date:   Tue, 18 Apr 2023 19:49:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] soc: mdediatek: devapc: use
 devm_platform_ioremap_resource() instead of of_iomap()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        zhengkang huang <zkhuang@hust.edu.cn>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230414092113.64514-1-zkhuang@hust.edu.cn>
 <9bfd1641-3f58-ca6e-1e80-13acea834ea5@collabora.com>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <9bfd1641-3f58-ca6e-1e80-13acea834ea5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/18 18:09, AngeloGioacchino Del Regno wrote:
> Il 14/04/23 11:21, zhengkang huang ha scritto:
>> In mtk_devapc_probe(), if of_iomap succeeds and any following error 
>> occurs,
>> it needs to deallocate the resource.
>>
>> Fix this by repalcing of_iomap with devm_platform_ioremap_resource, 
>> which
>> automatically self-manages the resource. This can avoid modifying error
>> handling code.
>>
>> Signed-off-by: zhengkang huang <zkhuang@hust.edu.cn>
>> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>
> You haven't tested this patch on any MediaTek SoC, have you?

Yes, this issue is found by static analysis and remains untested.

Sorry for the functionablity issue.

Dongliang Mu

>
> This will break devapc.
>
> Regards,
> Angelo
>
