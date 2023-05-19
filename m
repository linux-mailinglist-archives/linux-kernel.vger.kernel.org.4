Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56B0709ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjESPBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjESPB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:01:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22AEC7;
        Fri, 19 May 2023 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2jTWFuDurAqpzGQEpvpUbzRLzj71zTuSnsPEw86T0dg=; b=Txzbih6tIIhzpwJ7L7uIU45yY5
        OWYVCIoZHG3+TqKOMTcv/YhOErojdq9GxUi60L9sDnj6lZ2P61vKlifRT54INB5lzKNYlZYvaM6Wi
        vbwg9FXEBVsxZCtJ/j86nxm5CWgkoYdBkUjZDCsPGC9uvd/ADo+pnlZ7tJWZdbhpg90P1UiH4Xf0V
        xqYhuk+oU/unDeRRCpDVI/OQwgji22fmplqBaRqOulmQMLdSO1/y6XoNc8iqQXRJyPNHsAGA/PyXx
        ijaSG60jfT0UcCoLJyfmmeyXQq+XyhfKxBfpk78CkvzLfQKjMPrZzuwH+T+vp4qdbqa++Y2TZzc3q
        tE9DW1VA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q01bi-00GY2d-2U;
        Fri, 19 May 2023 15:01:26 +0000
Message-ID: <69c787f6-7496-f6dd-2324-6a6079e15754@infradead.org>
Date:   Fri, 19 May 2023 08:01:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] media: frontend.h.rst.exceptions: add more dvb define
 exceptions
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Athanasios Oikonomou <athoik@gmail.com>,
        linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20230518234735.20289-1-rdunlap@infradead.org>
 <20230519090308.0e53eccd@sal.lan>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230519090308.0e53eccd@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/23 01:03, Mauro Carvalho Chehab wrote:
> Hi Randy,
> 
> Em Thu, 18 May 2023 16:47:35 -0700
> Randy Dunlap <rdunlap@infradead.org> escreveu:
> 
>> Building documentation reports multiple warnings for undefined DVB
>> frontend labels:
>>
>> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-11-45'
>> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-4-15'
>> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-14-45'
>> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-7-15'
>> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-11-45'
>> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-4-15'
>> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-14-45'
>> Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-7-15'
> 
> Thanks for the patch. FYI, I already merged yesterday a fix identical
> to your patch:
> 
> 	https://git.linuxtv.org/media_stage.git/commit/?id=8bc27fa5d7763d376a992a1638475987ed4807e7
> 
> Regards,
> Mauro


Hi Mauro,

Did you post that patch to the linux-media mailing list?
I searched that list for such a patch before I made the patch.

Thanks.

> 
>>
>> so add those symbols to the ignore list to prevent the build warnings.
>>
>> Fixes: 1825788e2a96 ("media: dvb: add missing DVB-S2X FEC parameter values")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/linux-media/202305162245.wtaLIXf3-lkp@intel.com/
>> Cc: Athanasios Oikonomou <athoik@gmail.com>
>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>> Cc: linux-media@vger.kernel.org
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> ---
>>  Documentation/userspace-api/media/frontend.h.rst.exceptions |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff -- a/Documentation/userspace-api/media/frontend.h.rst.exceptions b/Documentation/userspace-api/media/frontend.h.rst.exceptions
>> --- a/Documentation/userspace-api/media/frontend.h.rst.exceptions
>> +++ b/Documentation/userspace-api/media/frontend.h.rst.exceptions
>> @@ -142,6 +142,10 @@ ignore symbol FEC_26_45
>>  ignore symbol FEC_28_45
>>  ignore symbol FEC_32_45
>>  ignore symbol FEC_77_90
>> +ignore symbol FEC_11_45
>> +ignore symbol FEC_4_15
>> +ignore symbol FEC_14_45
>> +ignore symbol FEC_7_15
>>  
>>  ignore symbol TRANSMISSION_MODE_AUTO
>>  ignore symbol TRANSMISSION_MODE_1K

-- 
~Randy
