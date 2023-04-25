Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA66EDECA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjDYJKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjDYJKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:10:48 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36E010CE;
        Tue, 25 Apr 2023 02:10:47 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:b4e1:4fd9:48ca:cb80] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33P9AEMM009718-33P9AEMN009718
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 25 Apr 2023 17:10:14 +0800
Message-ID: <559cf3a3-f740-89d3-9e63-d0016d767a8a@hust.edu.cn>
Date:   Tue, 25 Apr 2023 17:10:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND] usb: dwc3: remove dead code in dwc3_otg_get_irq
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, lihuya <lihuya@hust.edu.cn>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hust-os-kernel-patches@googlegroups.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424105930.49944-1-lihuya@hust.edu.cn>
 <887b6226-ea4f-e75c-bfde-0785ccf30c77@omp.ru>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <887b6226-ea4f-e75c-bfde-0785ccf30c77@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/25 16:57, Sergey Shtylyov wrote:
> Hello!
>
> On 4/24/23 1:59 PM, lihuya wrote:
>
>> platform_get_irq() only return non-zero irq number on success, or
>> negative error number on failure.
>>
>> There is no need to check the return value of platform_get_irq()
>> to determine the return value of dwc3_otg_get_irq(), removing
>> them to solve this problem.
>     I was going to submit such patch myself at some point... which
> has never happened. :-/
>
>> Signed-off-by: lihuya <lihuya@hust.edu.cn>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Hi Sergey,

Please take a look at the following thread [1]. Yuhang sent a v2 patch 
since he did not use his real name in the Signed-off-by.

Greg already had some comments on this patch.

[1] https://lore.kernel.org/lkml/20230425015532.13622-1-lihuya@hust.edu.cn/

>
> [...]
>
> MBR, Sergey
>
