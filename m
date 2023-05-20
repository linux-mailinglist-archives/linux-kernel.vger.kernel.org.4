Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F40670AAD9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 22:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjETUMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 16:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjETUMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 16:12:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EABB4;
        Sat, 20 May 2023 13:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=tBbOqqWF6/KyxrR0pHpm78hZTtmuTTuk8Q+kr9ikl1s=; b=HjnxVLiLpTeQq49hqPQ01suoUf
        U9CsUHkT8hkqIVo9ymFYUk5MtvIu9ifoWazWiuzeAx2CAqrH4QCzycOyweJjGJjqrhkkVZw4vEFki
        E0BP5QkOEI0wVrmWGrAJdJR0UJwER3tAN6zmgAXJDVZsVEG2tY4LZJy7hNeC58i/0bJMNTO5noL4b
        pZdiLV0EFP67A1fE8YsswtfJ+tb5xUyXgC1O2zcmSAqQ9uobAGLLWSnog7bOmdrzEVMELHdYTz2x/
        15mufLc7wrEC5E6VXmH2koiFaEXZBLIGylRR5x/B9eITE8+cRRzU3Qj//SFh3ApK4hrTgDV1d+Dpz
        jlrpO25g==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q0SwM-002Cac-1o;
        Sat, 20 May 2023 20:12:34 +0000
Message-ID: <ae1f454c-6023-0e51-f5cc-4f5d84580c55@infradead.org>
Date:   Sat, 20 May 2023 13:12:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: linux-next: Tree for May 19 (drivers/interconnect/icc-clk.o)
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20230519130753.3a9d3d65@canb.auug.org.au>
 <aa3c7839-82b4-608a-0fd8-62beca5f075e@infradead.org>
In-Reply-To: <aa3c7839-82b4-608a-0fd8-62beca5f075e@infradead.org>
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



On 5/20/23 12:51, Randy Dunlap wrote:
> 
> 
> On 5/18/23 20:07, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20230518:
>>
> 
> ERROR: modpost: missing MODULE_LICENSE() in drivers/interconnect/icc-clk.o


I'll send a patch since there are other build errors too.

-- 
~Randy
