Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0BA6C547B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjCVTCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjCVTCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:02:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C57B5D8AE;
        Wed, 22 Mar 2023 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679511661; x=1711047661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5JExtYzYhg/1NXW9btXi1XuTbxhrdxUWt+Ls0Ti/QCg=;
  b=hlMu4DHNVenYkjyUVSH+4fEvN4Ikhy9sVK6bCbimlyTkOvW5uMYmOvm9
   V/sPVqolOG+OeWB6NH9GlJ9ztCY7IAxc2bRp8gVY6vezqeegfJD8k8h+p
   7USJXplYFYcmPFZlEU1PHwlX5AzEnEtIVRSVr0dSY23VdSOEwEe0WaiNS
   5i0y5Meu1AS/KgyIAGF23kDT5kScdOhp4smNRQoIUYpekfxt4q8KXiDjI
   xc0lacstzVAhna5/Ma0oHSwD33bS+NmlDxbi3YW7RjmcECpZtBV7idV0d
   j3LrkCw6IaOTqNqkTwAqEMGVkhVFeKSjBC43Wi6Nfnd5G+sggtGpBhPWi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="340847440"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="340847440"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 12:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="714510064"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="714510064"
Received: from rfbarbee-mobl.amr.corp.intel.com (HELO [10.251.1.54]) ([10.251.1.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 12:00:22 -0700
Message-ID: <86fc67ba-9a6f-950a-cf30-5e80ba8efeb6@linux.intel.com>
Date:   Wed, 22 Mar 2023 12:00:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2] ACPI: sysfs: Enable ACPI sysfs support for CCEL
 records
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230320212019.2479101-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0ggn6q5WJsK7jP7EbxnRq6xxwzj2PwOMxhV6L6Rb5iSJw@mail.gmail.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAJZ5v0ggn6q5WJsK7jP7EbxnRq6xxwzj2PwOMxhV6L6Rb5iSJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 3/22/23 11:31 AM, Rafael J. Wysocki wrote:
> On Mon, Mar 20, 2023 at 10:21 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> The Confidential Computing Event Log (CCEL) table provides the address
>> and length of the CCEL records area in UEFI reserved memory.
> 
> The rest of this paragraph can be omitted.
> 
>> To access
>> these records, userspace can use /dev/mem to retrieve them. But
>> '/dev/mem' is not enabled on many systems for security reasons.
>>
>> So to allow user space access these event log records without the
>> /dev/mem interface, add support to access it via sysfs interface. The
>> ACPI driver has provided read only access to BERT records area via
>> '/sys/firmware/acpi/tables/data/BERT' in sysfs. So follow the same way,
>> and add support for /sys/firmware/acpi/tables/data/CCEL to enable
>> read-only access to the CCEL recorids area.
>>
>> More details about the CCEL table can be found in ACPI specification
>> r6.5, sec titled "CC Event Log ACPI Table".
> 
> Please provide a proper section number here and a Link: tag pointing
> to the relevant section of the spec (which is
> https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#cc-event-log-acpi-table
> I think).
> 
>> Original-patch-by: Haibo Xu <haibo1.xu@intel.com>
> 
> If the original patch has been signed-off by that developer, you can
> use a Co-developed-by: along with the original S-o-b tag here.
> 
>> [Original patch is for TDEL table, modified it for CCEL support]
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>

How about the following version?

ACPI: sysfs: Enable ACPI sysfs support for CCEL records

The Confidential Computing Event Log (CCEL) table provides the address
and length of the CCEL records area in UEFI reserved memory.

To allow user space access to these records, expose a sysfs interface
similar to the BERT table.

More details about the CCEL table can be found in the ACPI specification
r6.5 [1], sec 5.2.34.

Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#cc-event-log-acpi-table # [1]
Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>



>> Changes since v1:
>>  * Removed unnecessary parenthesis as per Rafael's suggestion..
>>
>>  drivers/acpi/sysfs.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
>> index 7f4ff56c9d42..687524b50085 100644
>> --- a/drivers/acpi/sysfs.c
>> +++ b/drivers/acpi/sysfs.c
>> @@ -458,11 +458,28 @@ static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
>>         return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
>>  }
>>
>> +static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
>> +{
>> +       struct acpi_table_ccel *ccel = th;
>> +
>> +       if (ccel->header.length < sizeof(struct acpi_table_ccel) ||
>> +           !ccel->log_area_start_address || !ccel->log_area_minimum_length) {
>> +               kfree(data_attr);
>> +               return -EINVAL;
>> +       }
>> +       data_attr->addr = ccel->log_area_start_address;
>> +       data_attr->attr.size = ccel->log_area_minimum_length;
>> +       data_attr->attr.attr.name = "CCEL";
>> +
>> +       return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
>> +}
>> +
>>  static struct acpi_data_obj {
>>         char *name;
>>         int (*fn)(void *, struct acpi_data_attr *);
>>  } acpi_data_objs[] = {
>>         { ACPI_SIG_BERT, acpi_bert_data_init },
>> +       { ACPI_SIG_CCEL, acpi_ccel_data_init },
>>  };
>>
>>  #define NUM_ACPI_DATA_OBJS ARRAY_SIZE(acpi_data_objs)
>> --
>> 2.34.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
