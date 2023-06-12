Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC6772BE68
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbjFLKK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbjFLKJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:09:13 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569F26E9A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:50:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35C9nvMe089737;
        Mon, 12 Jun 2023 04:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686563397;
        bh=irMo5CUtJTWL9zZyCijfKJZBCwDzOInCIwvRPYkuzxY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=jnrZz7LrHfAeiaYqDFDizmCb3kENFt66HRprWf2FTkTqnoZhbkpxsFGb9ZQ5kRV7U
         CjBOXre1KLzLPUwvjn/+629McyptPq7ydyeUudNWtVkh5wgV0jvCf8alZZh7bAKa2l
         BQ66drcRkxbWcHRGf9culreGdAJPwd13IjNo+2OA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35C9nvqZ020265
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Jun 2023 04:49:57 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Jun 2023 04:49:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Jun 2023 04:49:57 -0500
Received: from [10.24.69.79] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35C9nsU7030260;
        Mon, 12 Jun 2023 04:49:55 -0500
Message-ID: <e3e409c5-56b5-570d-e962-a7c0a1c05fa3@ti.com>
Date:   Mon, 12 Jun 2023 15:19:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: defconfig: Enable HSR by default
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230612094340.13865-1-r-gunasekaran@ti.com>
 <ab8dfd0f-fa49-6493-d79d-c35f632373f3@linaro.org>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <ab8dfd0f-fa49-6493-d79d-c35f632373f3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/23 3:14 PM, Krzysztof Kozlowski wrote:
> On 12/06/2023 11:43, Ravi Gunasekaran wrote:
>> Enable HSR feature in kernel build.
> 
> Why? Commit msg should answer to this question.

I apologize for incomplete description. I will send out a v2.

HSR protocol is implemented by the network stack at /net/hsr/*
In order to create HSR interface, HSR module needs to be loaded.


> 
> Best regards,
> Krzysztof
> 

-- 
Regards,
Ravi
