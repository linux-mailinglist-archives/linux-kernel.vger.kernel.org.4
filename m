Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A335F1779
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiJAApY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiJAApU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:45:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825BA87FA6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664585118; x=1696121118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0k8Omvocy/Lmn1JNbD0D6pTNgD8xKFYnwKObyBLyY3Q=;
  b=o98rLmQAwlx9dhU2p6p0+KgSs47Jp4GHOLLhF2xWrqDyA16v1mwPXhSZ
   0gUEQGYVIlgE/oGgRjgFqk0vXQ9o5Cg+tMb9lh6kn6KuWNCk2l4jmUC1S
   Yg1qRkmC1r6VhToO+xFh/8jt788Ococ9H25fr74DYYOQ1amA2954gV4/9
   wmG4w8DdhYTL0qSSPTQ8js1VwI7FLayHPcwFs5Pthwjwjf8jysM9YZOLO
   RiDu/z/XN2/GZe8GBMRXBDrvgCOmPUGkc8Z4T0SpovIcT7SBY0Cln8ELF
   XQgXWcl0WN0kIHqB4+HQRU+tTtzrxmK9PIJnVG0Q/zWEawBh61p/kH717
   g==;
X-IronPort-AV: E=Sophos;i="5.93,359,1654531200"; 
   d="scan'208";a="316995695"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2022 08:45:17 +0800
IronPort-SDR: 6iSrc8SpDJumpXSu/7VeYyjrIhoEHoHqKY7ttDwmFS5taw5qly4zFksGXWxBaOVHvrb3cFoorP
 ZLn6I5FfIDtjUap+IMQcsCmCCxhE/YDQbDv6hMwPcPK0rrNMU9RSTvfWt+p9YMb97roNIVQHMD
 Vye77FjOp7zduN9BcdQ7TvlxlyPwwTgEpXt1VSOsOEIAchG7K40N5feD35Jk0m6Zrgf7ll+0cU
 e/nZIcWdXaYgSUgJ+w56dcjWc9jCABIdHlHyVq1w2ksA8bpxoBSARhKi6+AWt9KWcS/xF/EBCi
 U88hxWS43bSH3ghbPUsjfef8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2022 16:59:36 -0700
IronPort-SDR: eTU4lXc/+Dn8S8KmbPNvqp38rnQgSL5jzYHLzVIKK+48Il7oeIRmXK1rPBfu/h9NNNiyvjvH1o
 cRWFck3tiyzBazbuSzsTIsgD+nyQR15dFx12TwjtbbN5mvH+22ztXvztZfVfNtFGv/A4mMIy43
 /JYEjqlouuJpNutiycpvii/J1VZxjN/4R2mDtX+hdfQMKw4Tz0DK/gPmX3rpM6UqeILROCRgoY
 IQ9LIG+fzKr4WuyEXHSWpYaeSEcr2mnPq6PYgSzQNF/2/EXl5ESI8tmRaUO4PD4bS+EbPswF7O
 JUU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2022 17:45:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MfT0D0F0Cz1Rwrq
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 17:45:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664585115; x=1667177116; bh=0k8Omvocy/Lmn1JNbD0D6pTNgD8xKFYnwKO
        byBLyY3Q=; b=TBmgxUD6GnERjJmdq/0e0i+8yyLf3pp02kEDYv4DrQaFwp/O95E
        D+qy3e2Uo87AHw1O34ZcgRE4Zlvrggr1hP2DdqpE6ihqkKd+3wMtDyqp5HPHXef2
        PG8ulQHC7ut9HCxTvuSaNTqWuRb+F7nMkdNuLqGCpwzB47XZpTqwILKVVARsbsmw
        pdXs48ruVM7tKnCAIMze46IRWrk/AhxTr0fSnA6fbmzB5Ioof7WfHOETwFrUUIap
        iX73D1EoSLUH2PCw7/fX+uCpz3CEaeP9wnUBDUfsb0k7G8LM2/Jz76KhfBBTDFlW
        uDGkZbNTsPzlXsWya34a2a72rMhzYcB+fUQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AbbgX1E13d1b for <linux-kernel@vger.kernel.org>;
        Fri, 30 Sep 2022 17:45:15 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MfT076V2Xz1RvLy;
        Fri, 30 Sep 2022 17:45:11 -0700 (PDT)
Message-ID: <bb2b3784-422f-fc82-e5be-e4d24412e21f@opensource.wdc.com>
Date:   Sat, 1 Oct 2022 09:45:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        Keith Busch <kbusch@kernel.org>
Cc:     jaegeuk@kernel.org, agk@redhat.com, gost.dev@samsung.com,
        snitzer@kernel.org, linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
 <20220923173618.6899-1-p.raghav@samsung.com>
 <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
 <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
 <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/22 04:38, Bart Van Assche wrote:
> On 9/30/22 08:13, Jens Axboe wrote:
>> On 9/29/22 12:31 AM, Pankaj Raghav wrote:
>>>> Hi Jens,
>>>>    Please consider this patch series for the 6.1 release.
>>>>
>>>
>>> Hi Jens, Christoph, and Keith,
>>>   All the patches have a Reviewed-by tag at this point. Can we queue this up
>>> for 6.1?
>>
>> It's getting pretty late for 6.1 and I'd really like to have both Christoph
>> and Martin sign off on these changes.
> 
> Hi Jens,
> 
> Agreed that it's getting late for 6.1.
> 
> Since this has not been mentioned in the cover letter, I want to add 
> that in the near future we will need these patches for Android devices. 
> JEDEC is working on supporting zoned storage for UFS devices, the 
> storage devices used in all modern Android phones. Although it would be 
> possible to make the offset between zone starts a power of two by 
> inserting gap zones between data zones, UFS vendors asked not to do this 
> and hence need support for zone sizes that are not a power of two. An 
> advantage of not having to deal with gap zones is better filesystem 
> performance since filesystem extents cannot span gap zones. Having to 
> split filesystem extents because of gap zones reduces filesystem 
> performance.

As mentioned many times, my opinion is that a good implementation should
*not* have any extent span zone boundaries. So personally, I do not
consider such argument as a valid justification for the non-power-of-2
zone size support.

> 
> Thanks,
> 
> Bart.
> 
> 

-- 
Damien Le Moal
Western Digital Research

