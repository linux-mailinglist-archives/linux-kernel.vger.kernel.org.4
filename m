Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7914E70556B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjEPRue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjEPRuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:50:32 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F197E3C1F
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:50:22 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GHnSPd015715;
        Tue, 16 May 2023 12:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=cPgZ5k9PHO/LlPNNvKWICO7tPgeRTpiH7ITaMbtHyZk=;
 b=mPJvO7PBZzQXXIXAauIVZ68Kp3ia2OGJ6FyaGQivovoVUKYxnLTYtglokGOVf7LDFnkB
 lewXtW6u/TOF/5swhakUWeOBPoDSdAyhs39I1ztf+UpqQ0AytAwKgeIIrvpz3Aq+TsS0
 0o69FlyLAaqKtfmb5HDJWCiMkz3xXaIRpLSiFGzxLEvK7k9oS+Mor03RITosFkGfr+To
 p1lj5dBtB8FxZuxzJh+CUwK0YjBVfAvmBDBl3dyHlPmHITaGOJpSJi8Aw93SfR9v9Zrt
 fDckjMFEKvHNxNtElAf5M1H2QCO+g6/qPBY0vHt1l5YULufo3ErSMtJlXGNfo1jYGFi7 Pw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qj6ymvt36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 12:50:18 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 16 May
 2023 12:50:17 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 16 May 2023 12:50:17 -0500
Received: from [198.61.64.66] (EDIN4L06LR3.ad.cirrus.com [198.61.64.66])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E2A47B38;
        Tue, 16 May 2023 17:50:16 +0000 (UTC)
Message-ID: <1d174049-0eaf-01d5-2f85-c3cd3f4a40a0@opensource.cirrus.com>
Date:   Tue, 16 May 2023 18:50:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/5] debugfs: Update debugfs_create_str() kerneldoc to
 warn about pointer race
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20230516160753.32317-1-rf@opensource.cirrus.com>
 <20230516160753.32317-4-rf@opensource.cirrus.com>
 <2023051607-trial-worrisome-87df@gregkh>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <2023051607-trial-worrisome-87df@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xwJBQTK1637ZzFiTeotrPhCwx7te6akW
X-Proofpoint-ORIG-GUID: xwJBQTK1637ZzFiTeotrPhCwx7te6akW
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/5/23 17:35, Greg KH wrote:
> On Tue, May 16, 2023 at 05:07:51PM +0100, Richard Fitzgerald wrote:
>> Add a warning to the debugfs_create_str() kerneldoc that the char * pointer
>> value must not change after the function returns, because of a race with
>> debugfs_read_file_str() accessing the pointer.
>>
>> The only safe case is a change from NULL to non-NULL because in that case
>> debugfs_read_file_str() will see either the NULL or the valid pointer.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   fs/debugfs/file.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
>> index 0c039a3d9a42..77794871f26d 100644
>> --- a/fs/debugfs/file.c
>> +++ b/fs/debugfs/file.c
>> @@ -938,11 +938,18 @@ static const struct file_operations fops_str_wo = {
>>    *          directory dentry if set.  If this parameter is %NULL, then the
>>    *          file will be created in the root of the debugfs filesystem.
>>    * @value: a pointer to the variable that the file should read to and write
>> - *         from.
>> + *         from. The char* pointer must not change, except from NULL to
>> + *         non-NULL.
> 
> This feels odd.  Why wouldn't you want to change the string value?  Or
> why would you?

Well, if you _would_ want to change the string value, then the
implementation of debugfs_create_str() is certainly broken and could
only be fixed by involving a shared mutex to protect use of the pointer.

> 
> And why is this one-way transition ok?
> 

This one case happens to be safe because it either sees NULL (which it
handles) or a valid pointer (which is ok). It will not result in using a
stale pointer. This wasn't a deliberate design intent but happens to be
safe, and easily maintainable behavior.

A transition from valid->NULL or old->new isn't safe because the
read function could get the old pointer but racing with that is the
change to the pointer, and so the debugfs code could try to use a
stale pointer.

> Given that this is only used internally, why is it exported?
> 

It isn't only used internally. I found 3 drivers that use it.
But there are no uses internal to debugfs.

I didn't write debugfs_create_str(), I only tried to use it and made
an attempt to fix some problems.

Given the limitations of the basic implementation of
debugfs_create_str() and its file reading function (the lack of
protection against the pointer changing) perhaps drop this chain? Don't
bother fixing it, instead deprecate it for being unsafe?

> thanks,
> 
> greg k-h
