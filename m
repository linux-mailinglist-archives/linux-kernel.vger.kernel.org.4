Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257DB746114
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGCRCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjGCRBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:01:52 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A73E69
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:01:44 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id GMvbqaLPIL1SxGMvcqewci; Mon, 03 Jul 2023 19:01:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1688403696;
        bh=vHaTg43ZN4pIqH0XjXUyIHPFQb3nQdBrMYDjetNLFHM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UYuVx8uN3j2zQ1Mj6NoQNPv2Vn3M3UmX2kUAmwh91xHCBmSln+5lvS0Xkskkuw8kg
         KKootEW+nAqL5ZxwXoLZAai/2L1plig0O9M/qQZjdmRNUNziTh5t8qZF7frgly9HlH
         9fCQV1+wNvF0JqWAWyiz/WfMQf1SIQemHnDTejaK+LiFDKuia2kw7GtOpgZNd7eyQq
         nXc84LC9poLQwvAbwB5yDUbS5nzK2cMqsvfaFSjTvyUUBSSxwu0G7kgRG9SCjiAyA7
         ZKZMKkd/WHajeNDRsc09Xl6oUxOLrmUdvQc8k2ayx82AubPdhuOPZgyF5ZbKaUmrBq
         XNGv8ZIj0ny/Q==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 03 Jul 2023 19:01:36 +0200
X-ME-IP: 86.243.2.178
Message-ID: <f97e8c26-1379-dabc-21af-ebf4b06b31e7@wanadoo.fr>
Date:   Mon, 3 Jul 2023 19:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] powerpc: powermac: Use of_get_cpu_hwid() to read CPU node
 'reg'
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230319145931.65499-1-robh@kernel.org>
 <168836201902.50010.13066091729121047041.b4-ty@ellerman.id.au>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <168836201902.50010.13066091729121047041.b4-ty@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/07/2023 à 07:26, Michael Ellerman a écrit :
> On Sun, 19 Mar 2023 09:59:31 -0500, Rob Herring wrote:
>> Replace open coded reading of CPU nodes' "reg" properties with
>> of_get_cpu_hwid() dedicated for this purpose.
>>
>>
> 
> Applied to powerpc/next.
> 
> [1/1] powerpc: powermac: Use of_get_cpu_hwid() to read CPU node 'reg'
>        https://git.kernel.org/powerpc/c/bc1cf75027585f8d87f94e464ee5909acf885a8c
> 
> cheers
> 

Hi,

I guess, that it does not really matter, but shouldn't the 
of_node_put() be *after* the "reset_io = *rst;" statements to be 
absolutely safe?


(This change is in my backlog and I have apparently never proposed it)

CJ
