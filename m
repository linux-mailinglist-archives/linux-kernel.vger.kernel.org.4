Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EA46273DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiKNAbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbiKNAbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:31:09 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67924E02C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668385868; x=1699921868;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9oWrSfpX2WhFznUHJBIRODGa7XS9CCGLZvVqGFg8LeY=;
  b=Gf6HX6SnxmE++hW4PiHAtioW6Bi40fgNWS1PxgxyziwhxFFhKa1tMS5V
   u/cFTzPVTi/WvLJO8Ql5NWZxDFsagIZJyCJAr1n0dxBJJWMEPG2RpQ+hO
   FXYxnOU8CCD27mv3hgeOq4tgnxaO6iEJJlwJ+VepVLZWQiMEgGhFFrtnY
   oZ0tIc6ZxXnvA+ABghm2xKauWN4/255N6yLGYfBzqxkgHlqiZaL80r/HY
   WGZe8qx43Yi+3od39ZsAVFeUuor2AKeF0RrhAOj+0YUyyEQxbE78sez1+
   XMXwSHEzAyOLsj0NKpTIJpXzzqi31vq4VrKwqzZuRmiWReMjVgybipbuD
   g==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="328273382"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 08:31:02 +0800
IronPort-SDR: y8XEENLI3PYfRdO+xPHLEilTq7nmSw8TlPZhLNdZx4wpyX7CF+mCfjHr6pUo5LAULVs+8sVDfx
 fNa54kaotiZHMW+1KIc6+0+3ONr+JvLuyMrbEoxzGcVp0mXYx7kM3TrMFXz2U5rGv4ieZJ9Fx4
 h6gyVD/eyIZlZ+djoHFEWt0LS5UPB8x9VJol9K1yGNmI4MzbMDOYiV3+cELgcG1v4WHpwq9S4B
 jfUs9YGxV5tN1eenvw7Ey+3mPAJJ3N5Res4y/tn8u39siMZY2SjbnKaUFIFV+i8K8Pu9jl4h9/
 Kng=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2022 15:44:16 -0800
IronPort-SDR: 5HmcQCsd89CoSBRIlRkDg1oB6tKpKwuB94xvnBJTn6FBSEj5V8MoWFVbiJtL/awTnKL9A63ZEP
 RyJm+uIK1AXE0tevRWTxzXcdUtjSW2gzEb2oZCufWQh6f+Z92fAfHZ8XAmg7wIocfGVnrGUEEh
 NawmabjkZhAaRP2rD/NFriXckIFrB8grKOCJyaeBPt0dgsYBozQzkDwQ7hmuKpUjZH2L4fDg5m
 92afxOvu+fgvAH+zuyO5fN7UtOEgdG8Uw/elwx+ZMtTnmEkcks9thE9YF01tKKhMyUS6KPkcsk
 TJs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2022 16:31:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N9VbV0G2mz1Rwrq
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:31:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668385861; x=1670977862; bh=9oWrSfpX2WhFznUHJBIRODGa7XS9CCGLZvV
        qGFg8LeY=; b=ODURWQ2HqMc8SoKgM3XIXwlmdDgw0kL/yiVzMlyJlpJPEPkl0Gq
        7My87Rs57Q2DcTZ5+7lN5cOPGl8QprbL4zM2rckGeiEJ24DdcUlnGaGxb9JIysGJ
        IlzNajY8CE85f/90gKfCwC/gL0AB/0KvRDN2h4VdpAUihF2llAOY1LggMzdk9krn
        ngYAzVQBa6WlbV1BKGcnJ8ULy6DE4ARjhffV4Rf0BiRQXGI1vBX1J1WOAWXyFKFD
        BG4xN68wgQfEzUbc6FJYsIh65LcPnsV0K518Ajcq+sScphdvxH0ol2fkYYB3IKxC
        4PolO/CwVlp1HdWzWPDPAJtZJ3Nx9nDo5mw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kqzd5PPG1c2G for <linux-kernel@vger.kernel.org>;
        Sun, 13 Nov 2022 16:31:01 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N9VbS38tCz1RvLy;
        Sun, 13 Nov 2022 16:31:00 -0800 (PST)
Message-ID: <50e1411a-54c4-d9d2-7567-2388219c5bb1@opensource.wdc.com>
Date:   Mon, 14 Nov 2022 09:30:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH 0/5] scsi:scsi_debug:Add error injection for single
 lun
Content-Language: en-US
To:     dgilbert@interlog.com, Wenchao Hao <haowenchao@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221109155950.3536976-1-haowenchao@huawei.com>
 <58472d12-c1e4-59f3-bb37-a98db17ef2ba@interlog.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <58472d12-c1e4-59f3-bb37-a98db17ef2ba@interlog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/22 06:48, Douglas Gilbert wrote:
> On 2022-11-09 10:59, Wenchao Hao wrote:
>> The original error injection mechanism was based on scsi_host which
>> could not inject fault for a single SCSI device.
>>
>> This patchset provides the ability to inject errors for a single
>> SCSI device. Now we supports inject timeout errors, queuecommand
>> errors, and hostbyte, driverbyte, statusbyte, and sense data for
>> specific SCSI Command
>>
>> The first patch add an sysfs interface to add and inquiry single
>> device's error injection info; the second patch defined how to remove
>> an injection which has been added. The following 3 patches use the
>> injection info and generate the related error type.
>>
>> Wenchao Hao (5):
>>    scsi:scsi_debug: Add sysfs interface to manager single devices' error inject
>>    scsi:scsi_debug: Add interface to remove injection which has been added
>>    scsi:scsi_debug: make command timeout if timeout error is injected
>>    scsi:scsi_debug: Return failed value for specific command's queuecommand
>>    scsi:scsi_debug: fail specific scsi command with result and sense data
>>
>>   drivers/scsi/scsi_debug.c | 295 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 295 insertions(+)
> 
> Hi,
> This patchset seems to assume all scsi_debug devices will be disk (-like) SCSI
> devices. That leaves out other device types: tapes, enclosures, WLUNs, etc.
> 
> Have you considered putting these device specific additions under:
>     /sys/class/scsi_device/<hctl>/device/error_inject/
> instead of
>     /sys/block/sdb/device/error_inject/

But these are the same, no ?
At least on my Fedora box, I see:

/sys/block/sdp/device/ being
/sys/devices/pseudo_0/adapter0/host19/target19:0:0/19:0:0:0

and /sys/class/scsi_device/19:0:0:0/device being
/sys/devices/pseudo_0/adapter0/host19/target19:0:0/19:0:0:0

> 
> ?
> 
> Doug Gilbert
> 
> 
> 

-- 
Damien Le Moal
Western Digital Research

