Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C689E67A921
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 04:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjAYDPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 22:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYDPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 22:15:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E154E50D;
        Tue, 24 Jan 2023 19:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=8kDAcW/Rs9qr0pwqRKQEOb3vJvwotqrY0b3nUMKSn3U=; b=UXZ9ARxK+x5wZdMhO8AEo9xQga
        UktQ8CeJ0xMHPtedzasVlY1CuAwBoA0VHSAMhxGWXLnvFkjqARLAcB02hjqtwQA6zg4YY9yFe6N2/
        +5Pcajd0HEGXPb2AtEgGYPwzdR39lkNWZ9ysjTKxuQTykeW4odgYrFwZ6LZ4rADzCx4hR+ebA6Xua
        vpgL3i8qQp/t/XtPDw43mB66QrUzFe8N+LaHhhePqf52TGATbnONvG9C1rqfEovK3JLCJfSwjOYPp
        H5Tw1uwhTeQnjN/9EH+S/Hba+5v97cfkzRKB+FG62dp3GPOlpbs4pHsSjF+yLa/jrlnbWMud0zhqX
        Vpu3cREg==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKWFl-005uqz-TU; Wed, 25 Jan 2023 03:15:13 +0000
Message-ID: <1061c239-285b-c1df-5d7f-c5542683b8f0@infradead.org>
Date:   Tue, 24 Jan 2023 19:15:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] cxl: Kconfig: fix a spelling mistake
Content-Language: en-US
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
References: <20230124233431.21599-1-rdunlap@infradead.org>
 <Y9CUA8VFHobacc5x@aschofie-mobl2>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y9CUA8VFHobacc5x@aschofie-mobl2>
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

Hi,

On 1/24/23 18:29, Alison Schofield wrote:
> On Tue, Jan 24, 2023 at 03:34:31PM -0800, Randy Dunlap wrote:
>> Correct a spelling mistake (reported by codespell).
> 
> Hi Randy,
> 
> Maybe you were just interested in Kconfig's, but while you're
> in here, would you mind correcting a few more:

Yes, I am trying to focus on user-facing text,
but I am happy to make additional corrections in v2.

> drivers/cxl/
> ./acpi.c:22: Specfication ==> Specification
> ./core/port.c:1140: swich ==> switch
> ./core/region.c:402: suport ==> support
> 
> Thanks,
> Alison
> 
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Alison Schofield <alison.schofield@intel.com>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Ben Widawsky <bwidawsk@kernel.org>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: linux-cxl@vger.kernel.org
>> ---
>>  drivers/cxl/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff -- a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -116,7 +116,7 @@ config CXL_REGION_INVALIDATION_TEST
>>  	depends on CXL_REGION
>>  	help
>>  	  CXL Region management and security operations potentially invalidate
>> -	  the content of CPU caches without notifiying those caches to
>> +	  the content of CPU caches without notifying those caches to
>>  	  invalidate the affected cachelines. The CXL Region driver attempts
>>  	  to invalidate caches when those events occur.  If that invalidation
>>  	  fails the region will fail to enable.  Reasons for cache

-- 
~Randy
