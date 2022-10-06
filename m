Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECE55F62F3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiJFInS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJFInP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:43:15 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F104E92F7D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665045794; x=1696581794;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FcJkuxesVv/tbGFvODo0PePW/pFVpB+iYt9q3UH3uY4=;
  b=GqqqAiLRRU3qoRu59cMDXtPwR91DSbW01fQ9/wPdRQik9h5geYqA9XT+
   vqK9j3cWZToqEfBKyREe4naXXofiiFUVcvJDX+g7Hye7+Lb4jV3q0TOTk
   giUEkxC+UTIQDQ5JNMxkVhY0QPsGtEgBJY8v53nC+aOX8Ux4ELWre/NNW
   1KfsqzZgaKOQSUe2cr5v1ZLuK1Ji53JKJnobC5/KSu3hu6PFa5A03tSb5
   9HUgpBplDYYQ+WKxfzzczCO1bfyngawQ00f5nXRvImMUcijBaKOjvPsBh
   NvG6yo5cIqBTDSzZV06FKTCtCymq+fjUMOGdAzO1aWNop71/zp+cP4n6L
   g==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661788800"; 
   d="scan'208";a="218298451"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2022 16:43:14 +0800
IronPort-SDR: Uc3wOKxICMggDQX6Fu2G9N9ra2wgNVOfpbfwLI/tGPIsIjPzt0D2Pdskffxoshu6QZo6SfVl7c
 MKtyFOjFaVDuRM7VhWeNCLGGcNpOxxtFaWdihHJl2K0YEVsV4ox6PO8ixmBMY2kW+JItZv05Vd
 xzWcHv03X74SHfVEEOw5meEFVKy/bHcE2099jZu6Y+M/EV/vfYt8FM+5rr5hyB3pEk/CRej14z
 QE924Y1sOiSLz4P80wAjcByr8yZ+ZRwRdFLK1dgq7at34ubWjQoJU2LQOG5xOtViFk4h+w5thz
 Qhyp8gNlvkHb5d6JSox9wEUh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2022 00:57:25 -0700
IronPort-SDR: HGdNgwNyUjbopAlqK1CHaejMoGvzs7Z4u5EcnnxCmrkkYe+PfGbC2w7/JAa5vDKTwv86yy+SWh
 y166LwDSORBJnXBWCjhpty+xGFe81PpUVdNrzCYYlW7nmfQdnwOPJf11nzNne3jgsJ/qSMj7NO
 l1hWns0wwMP+62Z53iDEy9PO9rwD2sdTbvY7GDg/PnQS/YiwFMb1AHDS+mP4BqfwWgrWEgLwcb
 KWPC8FfKnxjsK/CtZEZZWZJeB1B3NrGmfp8zvq722FSueqgv9hXfa4G1NnWwFdV1zJBHNQAFl7
 sXM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2022 01:43:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MjlMQ0QDXz1RwqL
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:43:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665045793; x=1667637794; bh=FcJkuxesVv/tbGFvODo0PePW/pFVpB+iYt9
        q3UH3uY4=; b=kK06tU19qQYS1x95KNebaAMqA4jVkFqIu4ed/S+Wdkl1BXHGD9k
        9WCGeHaqTS/CjLQwVpLmwoCUaDDKF2DbP+Kku65XRdARPIKnFBKvZ62Jh4GW8sN0
        sQkAfOaW9J1+6Gvqy1VIg4TT2Ed5T+qt12xkUpZjz9bAEYpBNhZrsAkkDgfW983V
        gqrYXmErqHXJlbzjzoHCTm8Wyujb2BWstU5OAnvSfSSGxy/15qcy5vxiAKkF7NEs
        o91sakrcjGxq2nd9CGZuNRcb5W4WY6xCgGsjYzadrtJymiVBE6ZHOU2VVnF99q/g
        EGz6vm6gpb8VcF8Y4Z2UZDHPHvzK5sPfM1w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UvuIGTAr5Unz for <linux-kernel@vger.kernel.org>;
        Thu,  6 Oct 2022 01:43:13 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MjlMP05wrz1RvTp;
        Thu,  6 Oct 2022 01:43:12 -0700 (PDT)
Message-ID: <80583d1d-4434-bd33-5fc7-7e72037e1ed4@opensource.wdc.com>
Date:   Thu, 6 Oct 2022 17:43:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ata: pata_mpc52xx: Replace NO_IRQ by 0
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <a8c87c6d8dd6d9e57c515036a333ff89fc56bcbf.1665033366.git.christophe.leroy@csgroup.eu>
 <3a89c963-df7c-8fac-7213-d37c1b04f864@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3a89c963-df7c-8fac-7213-d37c1b04f864@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 17:37, Sergey Shtylyov wrote:
> Hello!
> 
>    Perhaps s/by/with/ in the subject?

I can fix that when applying.

> 
> On 10/6/22 8:17 AM, Christophe Leroy wrote:
> 
>> NO_IRQ is used to check the return of irq_of_parse_and_map().
>>
>> On some architecture NO_IRQ is 0, on other architectures it is -1.
>>
>> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
>>
>> So use 0 instead of using NO_IRQ.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [...]
> 
> MBR, Sergey

-- 
Damien Le Moal
Western Digital Research

