Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EB767F1E6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjA0XBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjA0XB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:01:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C30D448F;
        Fri, 27 Jan 2023 15:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2dVS85V6zgrrlR3J1zwtdDQGnP+6KKOnqcZIKTaKgDo=; b=JqWRiFfEg03UEycB0zpY/ofRZ0
        7XcUKso2g8IFZFdOTS08vUSPlPu9GbwwLcg1/RihKX827vcFB9EAIs8SlMEVdrNVxiv0kxPTZAFoV
        L+rLfWhwENATUMRpsmhPtKASQTAhbZtfmUoFY/iuZQEpwlG0Oy5qrt3HH+V5sX5uMx/zXI76iUeCE
        e7ZjdPFvJb7qEevYGzlq16itT8a8FmJSuazYZJBAZM4vf4b54rAVzu+l4XKEQVUePDTlUtnzuPutf
        saV/nqhnH+lotUWZB1T5986zIn/fIlO6e1SGq6Q6LQUkjtW8GNHgyiV55fpRM2Hyf0gJ0JYXncnA4
        emwLUqlg==;
Received: from [2601:1c2:d00:6a60::9526]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLXio-00Gm3t-6c; Fri, 27 Jan 2023 23:01:26 +0000
Message-ID: <9fc96bce-630d-3f2c-eab7-1270251fbb5b@infradead.org>
Date:   Fri, 27 Jan 2023 15:01:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 31/35] Documentation: trace: correct spelling
Content-Language: en-US
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-32-rdunlap@infradead.org>
 <5c1d8862-4ee6-bd17-1a61-ec32689d0578@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5c1d8862-4ee6-bd17-1a61-ec32689d0578@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/23 00:54, Daniel Bristot de Oliveira wrote:
> On 1/27/23 07:40, Randy Dunlap wrote:
>> --- a/Documentation/trace/rv/runtime-verification.rst
>> +++ b/Documentation/trace/rv/runtime-verification.rst
>> @@ -31,7 +31,7 @@ In Linux terms, the runtime verification
>>  *RV monitor* abstraction. A *RV monitor* includes a reference model of the
>>  system, a set of instances of the monitor (per-cpu monitor, per-task monitor,
>>  and so on), and the helper functions that glue the monitor to the system via
>> -trace, as depicted bellow::
>> +trace, as depicted below::
>>  
>>   Linux   +---- RV Monitor ----------------------------------+ Formal
>>    Realm  |                                                  |  Realm
> 
> Do you mind making the rv part an independent patch?
> 
> Spiting it helps in the backport of the fix to stable/distro kernels.

I wouldn't expect this to be packported. stable-kernel-rules.rst says:

 - It cannot contain any "trivial" fixes in it (spelling changes,
   whitespace cleanups, etc).

-- 
~Randy
