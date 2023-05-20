Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B99A70AAE0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 22:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjETUO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 16:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETUO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 16:14:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83563B4;
        Sat, 20 May 2023 13:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=rAjK21HT0yGQHVwdBbcwL8lnwKlZbXLAtHhGRoIXZT0=; b=iby/FLQg4Sk2HMC7oHCnOftYnx
        AUkAsZi9F5wkd3qX1XKCmuyutW/Cg1HrC/18CJMlGb3+AOXoUIjI2pf3zgC/hTiIFbX2XtIxwY1n7
        UuwNQl4acFdr+RwFOorbxXtrWCbSJj+Cs4eOwCznvdbtwXp2Gs8CYwc8rn0Tr04jheSIjl9vP9gM7
        UNhKIseM4cGWjNq9v3gT06fRkB3ran50UgnyGohN2tUJB3GAkkf3FAL3XJhuRiNrtA3jSnQUC/6Zz
        GTC7JS6gF7Sx8JqLvzWJ+yL+tEVsfEb2u6rhEfnY6PhKHlC4uV7t/4paS2bJnoDZA0/bsDxH+wojJ
        tYW9vqcg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q0Sy8-002ClH-1A;
        Sat, 20 May 2023 20:14:24 +0000
Message-ID: <3aa448c4-6400-6dfe-d5c3-72fa04dbb2d5@infradead.org>
Date:   Sat, 20 May 2023 13:14:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: linux-next: Tree for May 19 (drivers/interconnect/icc-clk.o)
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20230519130753.3a9d3d65@canb.auug.org.au>
 <aa3c7839-82b4-608a-0fd8-62beca5f075e@infradead.org>
 <ae1f454c-6023-0e51-f5cc-4f5d84580c55@infradead.org>
 <CAA8EJpom8JnhquM8R0mXK6CVia=7o45hDbFG6rRLCF=_CmFq1w@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAA8EJpom8JnhquM8R0mXK6CVia=7o45hDbFG6rRLCF=_CmFq1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/23 13:13, Dmitry Baryshkov wrote:
> Hi,
> 
> On Sat, 20 May 2023 at 23:12, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 5/20/23 12:51, Randy Dunlap wrote:
>>>
>>>
>>> On 5/18/23 20:07, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> Changes since 20230518:
>>>>
>>>
>>> ERROR: modpost: missing MODULE_LICENSE() in drivers/interconnect/icc-clk.o
>>
>>
>> I'll send a patch since there are other build errors too.
> 
> The patch was posted yesterday:
> 
> https://lore.kernel.org/linux-arm-msm/20230519230122.3958816-1-dmitry.baryshkov@linaro.org/T/#u
> 

Thanks!

-- 
~Randy
