Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F5663283
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbjAIVOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjAIVMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:12:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD798293;
        Mon,  9 Jan 2023 13:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=FJgMelawb+AVR/FU9zZ+45ERmeanV6JC6hl8xIQSQmY=; b=UYXeVuG1f9QXJVG/8cLqgT7sPr
        GX7cVQ9ITa6CNmrV3hmu9/VST4acURhn2EuMCfuZfevkrdzObYXDUcBTK4/EdzKAjHdgTK8d1WDj9
        xVW2lfnRyP+cNyaqgj2o6zLy8CrXzXGOk6lcfLZ5ih6K6PVJjGfEOhTKeqDXKz/cBX+JwgPSN5Tt/
        tXij4tu2BO4hoiQOB7cq8icBN0hzhG9aQrOPhETusJM4Ib776rT7go5a3EgN1idhCUSU6tkdIEN/8
        MkkuJBHF8zr7737ANe9E3ykZZsM+Shu8RN95n4piuV64jG5fDwu5Jz6w1OQKYpkvxQQrFq70JDzx3
        6e/IRcvw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEzNm-0046VS-P6; Mon, 09 Jan 2023 21:08:38 +0000
Message-ID: <714cf8b2-b02d-15d4-22a7-5e0dbec3c078@infradead.org>
Date:   Mon, 9 Jan 2023 13:08:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] x86/retbleed: add "stuff" mode admin documentation
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
References: <20230109160808.30740-1-rdunlap@infradead.org>
 <ceec97e2-2acd-6f15-5675-6b2b143b972f@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ceec97e2-2acd-6f15-5675-6b2b143b972f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/23 09:19, Dave Hansen wrote:
> On 1/9/23 08:08, Randy Dunlap wrote:
>> +			stuff        - Enables "stuffing" mode mitigation,
>> +				       which uses return thunking and call depth
>> +				       tracking.  Only in effect if
>> +				       CONFIG_CALL_DEPTH_TRACKING is set and
>> +				       Spectre V2 mitigation mode is
>> +				       "retpoline".
>> +				       IBRS is fully secure mitigation but is
>> +				       more costly (slower) than stuffing.
> 
> The "fully secure" thing makes me cringe a bit.
> 
> I'd suggest saying:
> 
> 	IBRS is a stronger mitigation
> 	but is more costly than stuffing
> 	(slower).

OK, will do (v3).  :)

Thanks.

-- 
~Randy
