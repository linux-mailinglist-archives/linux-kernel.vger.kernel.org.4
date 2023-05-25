Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C399710290
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjEYB4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYB4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:56:17 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715AF9B;
        Wed, 24 May 2023 18:56:13 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E423280C7;
        Thu, 25 May 2023 09:56:04 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 25 May
 2023 09:56:05 +0800
Received: from [192.168.155.165] (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 25 May
 2023 09:56:03 +0800
Message-ID: <29d515ec-83aa-c13e-b491-bc2ab7454012@starfivetech.com>
Date:   Thu, 25 May 2023 09:56:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] crypto: starfive - Add RSA algo support
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
References: <20230516075752.659287-1-jiajie.ho@starfivetech.com>
 <20230516075752.659287-3-jiajie.ho@starfivetech.com>
 <ZG3biep8vAWQ5ZgA@gondor.apana.org.au>
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
In-Reply-To: <ZG3biep8vAWQ5ZgA@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS063.cuchost.com (172.16.6.23) To EXMBX168.cuchost.com
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

On 24/5/2023 5:40 pm, Herbert Xu wrote:
> On Tue, May 16, 2023 at 03:57:52PM +0800, Jia Jie Ho wrote:
>>
>> +static struct akcipher_alg starfive_rsa = {
>> +	.encrypt = starfive_rsa_enc,
>> +	.decrypt = starfive_rsa_dec,
>> +	.sign = starfive_rsa_dec,
>> +	.verify = starfive_rsa_enc,
>> +	.set_pub_key = starfive_rsa_set_pub_key,
>> +	.set_priv_key = starfive_rsa_set_priv_key,
>> +	.max_size = starfive_rsa_max_size,
>> +	.init = starfive_rsa_init_tfm,
>> +	.exit = starfive_rsa_exit_tfm,
>> +	.base = {
>> +		.cra_name = "rsa",
>> +		.cra_driver_name = "starfive-rsa",
>> +		.cra_flags = CRYPTO_ALG_TYPE_AKCIPHER |
>> +			     CRYPTO_ALG_ASYNC |
> 
> Why did you set the ASYNC flag? Your implementation appears to
> be completely synchronous.
> 

I mixed this up with other modules, will remove this in next version.

Thanks,
Jia Jie

