Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8F75BAC31
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiIPLUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiIPLUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:20:04 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B920E4F6B2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 04:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663327204; x=1694863204;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=oBajLzQTfHIXxw7U7X8vG9cr0RADr1yQ8Vq8fgiwIVU=;
  b=p6rzG348st5r+57I2QB4HJG2mH2350yKqlBhTkN0cNvTlKMq3ZXMyzbk
   xtw1SgBAi1UkhFfA3oQhW4GOLN83WNpGlPoQJnOXk7198qPR/n2SV4+af
   l9+4WONpwF3zdug2JXLj7VsJcNWEeSgBj/+PLd35nKGbL3GeoYtPMxKpc
   U=;
X-IronPort-AV: E=Sophos;i="5.93,320,1654560000"; 
   d="scan'208";a="130817700"
Subject: Re: + libfs-fix-error-format-in-simple_attr_write.patch added to
 mm-nonmm-unstable branch
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-90419278.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 11:19:36 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-90419278.us-west-2.amazon.com (Postfix) with ESMTPS id 3D7BC45852;
        Fri, 16 Sep 2022 11:19:35 +0000 (UTC)
Received: from EX19D013UWA004.ant.amazon.com (10.13.138.207) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Fri, 16 Sep 2022 11:19:34 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX19D013UWA004.ant.amazon.com (10.13.138.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Fri, 16 Sep 2022 11:19:32 +0000
Received: from [192.168.101.215] (10.85.143.172) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Fri, 16 Sep 2022 11:19:29 +0000
Message-ID: <ce553e2b-0a13-08ee-283c-bc749e41ca61@amazon.com>
Date:   Fri, 16 Sep 2022 14:19:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     <yangyicong@hisilicon.com>, <viro@zeniv.linux.org.uk>,
        <jonnyc@amazon.com>, <hhhawa@amazon.com>,
        <andriy.shevchenko@intel.com>, <akpm@linux-foundation.org>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20220915213426.3BC15C433D6@smtp.kernel.org>
 <YyQTmZG/tNWd/ErO@localhost.localdomain>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <YyQTmZG/tNWd/ErO@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/2022 9:11 AM, Alexey Dobriyan wrote:
> On Thu, Sep 15, 2022 at 02:34:25PM -0700, Andrew Morton wrote:
>> libfs-fix-error-format-in-simple_attr_write.patch
>
>> From: Eliav Farber <farbere@amazon.com>
>> Subject: libfs: fix error format in simple_attr_write()
>> Date: Thu, 15 Sep 2022 09:15:44 +0000
>>
>> In commit 488dac0c9237 ("libfs: fix error cast of negative value in
>> simple_attr_write()"), simple_attr_write() was changed to use 
>> kstrtoull()
>> instead of simple_strtoll() to convert a string got from a user.  A user
>> trying to set a negative value will get an error.
>>
>> This is wrong since it breaks all the places that use
>> DEFINE_DEBUGFS_ATTRIBUTE() with format of a signed integer.
>>
>> For the record there are 43 current users of signed integer which are
>> likely to be effected by this:
>>
>> $ git grep -n -A1 -w DEFINE_DEBUGFS_ATTRIBUTE | grep ');' |
>> sed 's,.*\(".*%.*"\).*,\1,' | sort | uniq -c
>>   1 "%08llx\n"
>>   5 "0x%016llx\n"
>>   5 "0x%02llx\n"
>>   5 "0x%04llx\n"
>>  13 "0x%08llx\n"
>>   1 "0x%4.4llx\n"
>>   3 "0x%.4llx\n"
>>   4 "0x%llx\n"
>>   1 "%1lld\n"
>>  40 "%lld\n"
>>   2 "%lli\n"
>> 129 "%llu\n"
>>   1 "%#llx\n"
>>   2 "%llx\n"
>>
>> u64 is not an issue for negative numbers.
>> The %lld and %llu in any case are for 64-bit value, representing it as
>> unsigned simplifies the generic code, but it doesn't mean we can't keep
>> their signed value if we know that.
>>
>> This change uses sscanf() to fix the problem since it does the 
>> conversion
>> based on the supplied format string.
>
>> --- a/fs/libfs.c~libfs-fix-error-format-in-simple_attr_write
>> +++ a/fs/libfs.c
>> @@ -1017,9 +1017,12 @@ ssize_t simple_attr_write(struct file *f
>>               goto out;
>>
>>       attr->set_buf[size] = '\0';
>> -     ret = kstrtoull(attr->set_buf, 0, &val);
>> -     if (ret)
>> +     ret = sscanf(attr->set_buf, attr->fmt, &val);
>> +     if (ret != 1) {
>> +             ret = -EINVAL;
>>               goto out;
>> +     }
>> +
>>       ret = attr->set(attr->data, val);
>>       if (ret == 0)
>>               ret = len; /* on success, claim we got the whole input */
>
> No scanf please. Just revert original patch if something broke.
>
> scanf may be tolerable if it is just one format conversion but it is
> disaster as an interface.


If I revert original patch I get this checkpatch warning:
"WARNING: simple_strtoll is obsolete, use kstrtoll instead".

Should I still revert the original patch as is, or send a new patch that
fixes the issue by using kstrtoll()?

--
Thanks, Eliav

