Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C68647CCA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 05:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiLIDih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 22:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIDif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 22:38:35 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7E52D772
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 19:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670557105; x=1702093105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fgESi8YQzZ0g91NBar7p1m7+FvQiZuq/HMZDT9kkcHk=;
  b=rjnCVXevUrxjL9HiU6RRNcmf0fQbB1DNH1UyEDPPsTVjGlen0hOVYa2L
   gsEw27giBBTMaKONG+8dG81iCzRG2mzvpJf7RtINQj/Qg3cdQj7OgTzJg
   ZlmzOfulRilisDKRHQO8cJ1lBm/pY1fIS5hpjBN4Zgjj45YYJsBSce5I+
   U/F3XC5uk3u5vAhd+WihXHQ7VEnZgv2eSVvRXi7EGsGXC3XLI1/3YzwJg
   umA8ewc4M4rW4kewlZ64HyB8xSGcT9B06M7J+p3RP6BGhapUmbOKHS9Cz
   L4XXJuDrP704+XMVvh1WsiozxzfNWj16VxtsanawDGuF4WzXIc94rSkIH
   g==;
X-IronPort-AV: E=Sophos;i="5.96,230,1665417600"; 
   d="scan'208";a="218510334"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2022 11:31:22 +0800
IronPort-SDR: rvwe1aGXIXBQ4PL4Cj4ffvsbm0idwTZP66Lu9VxgmZaqbzrNTRRt5HY518QmLoXwJi34LI8OLP
 OXJIENH1B2rJfiRwWzGIwRzVSAxTbyVd485Ve631InAvkdffv1JFkkkV+S8CF46yrJ6cwUj/hf
 tagW/bfs+x0PaX6ojvob+clRGHBIrg5xhL9N0MD9yn1/m2Ecjm9IlAy4Noy/nCx3VZraEyxJBw
 HXq6qNJQrtkAmJIuTOKcDtOhupQDQJ3tkGDE/RhS1b3wcFP40BePXUY9fnEcxoo8M7S4fmp91j
 UPk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 18:44:06 -0800
IronPort-SDR: TrAUaM0OUoKu4wMm2KJFEGKYe4+ulHWDn9KfDAEG7zXv9JsE8qosgcu+rtU9ibOgbbzQYX79du
 EtDv1Ju3KScZjpJDJG9S5APH5KGF/IJAGNv70QCSuBY8azmTkAY3xrUhOI5ApFSylPQVWzNBI4
 CZYx+hhNJFqNBPkVQYH2bmtozJrvJJbzzqzm6/p/BkvZP+mAjHo2MVhUavEHh4SPfJ5AbghjSs
 AFcRjXGBXVVHhPM4Vyg+h4amyHtjG5yYstzcDYblb2i9PZAlQerydoJyDqZbaaM6LO2wUQSAwc
 Hg8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 19:31:22 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NSxQ22WWnz1RvTr
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 19:31:22 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670556681; x=1673148682; bh=fgESi8YQzZ0g91NBar7p1m7+FvQiZuq/HMZ
        DT9kkcHk=; b=sacPalBbWsCn2gCH5JXjmi0YENJrLzlVNjITBsUplK5YwiGKIwX
        HT39G7sIR63+nkbUu15RjGEGkS/AA2RvO8GzTcfPiQGUr7X3dYv6CnxUrGSxzn8l
        ySGNEZJtrMjA0GqnCTs4v3NxO9//tPLxy/bSGo0LivaTX+p5iZPUyezR4TNj2tSZ
        EKKAu6GOW063gH7lar7i8/FOA64b3aiQkIBmQIEbaMX/PKSCacN1mnGqoljqeFLn
        0uOTw2LU3IkHTB5eJbKpfQu2yXsVLJD/Ota77o4iV6/y8DjTXCFe4hhQ6wVVFVLi
        tYrcgD7ludLJ2J1xyebzTgMHWwBMY/l196A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ddAAu4xEM4oW for <linux-kernel@vger.kernel.org>;
        Thu,  8 Dec 2022 19:31:21 -0800 (PST)
Received: from [10.225.163.85] (unknown [10.225.163.85])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NSxQ10hzZz1RvLy;
        Thu,  8 Dec 2022 19:31:20 -0800 (PST)
Message-ID: <ad6c7534-14dc-d48a-f5f1-a35c649a42bd@opensource.wdc.com>
Date:   Fri, 9 Dec 2022 12:31:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 25/25] Documentation: sysfs-block-device: document command
 duration limits
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        linux-kernel@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org
References: <20221208105947.2399894-1-niklas.cassel@wdc.com>
 <20221208105947.2399894-26-niklas.cassel@wdc.com>
 <Y5Kp/JhhwF1rjrdu@debian.me>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y5Kp/JhhwF1rjrdu@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/22 12:22, Bagas Sanjaya wrote:
> On Thu, Dec 08, 2022 at 11:59:41AM +0100, Niklas Cassel wrote:
>> +What:		/sys/block/*/device/duration_limits/enable
>> +Date:		Dec, 2022
>> +KernelVersion:	v6.3
>> +Contact:	linux-scsi@vger.kernel.org
>> +Description:
>> +		(RW) For ATA and SCSI devices supporting the command duration
>> +		limits feature, write to the file to turn on or off the
>> +		feature. By default this feature is turned off. If the device
>> +		does not support the command duration limits feature, this
>> +		attribute does not exist (the directory
>> +		"/sys/block/*/device/duration_limits" does not exist).
>> +		Writing "1" to this file enables the use of command duration
>> +		limits for read and write commands in the kernel and turns on
>> +		the feature on the device. Writing "0" disables the feature.
> 
> Sphinx reported inline emphasis warning due to unescaped asterisk above:
> 
> Documentation/ABI/testing/sysfs-block-device:101: WARNING: Inline emphasis start-string without end-string.
> 
> I have applied the fixup:

[...]

>> <snipped>...
>> +		    Possible values are:
>> +
>> +		      - 0x0: The device will complete the command at the
>> +			     earliest possible time (i.e, do nothing based on
>> +			     the time limit not being met).
>> +		      - 0xD: The device will complete the command and an IO
>> +			     failure will be reported to the user with the ETIME
>> +			     error code.
>> +		      - 0xF: Same as 0xD.
>> +
> 
> The lists items above looks poorly indented in htmldocs (due to use of
> proportional fonts). The fix is to align to first character after bullet
> list marker, like:

Thanks for the hints. Will fix that in v2.


-- 
Damien Le Moal
Western Digital Research

