Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048E170D518
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbjEWHeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjEWHdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:33:42 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE58210E6;
        Tue, 23 May 2023 00:32:43 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 74BAE7FE0;
        Tue, 23 May 2023 15:31:21 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 23 May
 2023 15:31:21 +0800
Received: from [192.168.155.209] (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 23 May
 2023 15:31:18 +0800
Message-ID: <33a663b7-a353-69b9-7fed-b7758cadb12b@starfivetech.com>
Date:   Tue, 23 May 2023 15:31:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] crypto: starfive - Depend on AMBA_PL08X instead of
 selecting it
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230522105257.562cb1ec@canb.auug.org.au>
 <ZGr6aB9uJVnyfJQ9@gondor.apana.org.au>
 <20230523103637.20175fbc@canb.auug.org.au>
 <ZGwmAp5RPqAjVMCg@gondor.apana.org.au>
 <20230523-pelvis-unwritten-bedc9c75d899@wendy>
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
In-Reply-To: <20230523-pelvis-unwritten-bedc9c75d899@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/5/2023 2:56 pm, Conor Dooley wrote:
> On Tue, May 23, 2023 at 10:33:38AM +0800, Herbert Xu wrote:
>> On Tue, May 23, 2023 at 10:36:37AM +1000, Stephen Rothwell wrote:
>> > 
>> > That did not fix it :-(
>> 
>> OK, this patch should fix it:
>> 
>> ---8<---
>> A platform option like AMBA should never be selected by a driver.
>> Use a dependency instead.
> 
> Randy submitted a patch to change the driver to not conflict with
> the arch symbols:
> https://lore.kernel.org/all/20230523000606.9405-1-rdunlap@infradead.org/
> 
> The corresponding change here makes sense to me,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> @StarFive folks, you will need to go and submit a patch for
> arch/riscv/Kconfig.socs that selects ARM_AMBA for your platform.
> 

Sure, I'll submit a patch for this.

Thanks
Jia Jie

