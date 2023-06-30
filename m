Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9A67438AC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjF3Jtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjF3JtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:49:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EDC10E7;
        Fri, 30 Jun 2023 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688118541; x=1719654541;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rs7PWiDphVKSjZliT8SRMOQpdHEdsR8Qo8PaQCBhvik=;
  b=UQP2p+1ovxBv0HD1McTnBu4dCmGtrafzxgFb3on9Tpg5NQIEF4TmH25R
   TAFrazUD88C4V86A8QNpxP2PSZdKTzAaci6vyLxFKlePHhVxtaabH8MH5
   MWh1xgdyvFhpiwoRP3duAf9yEu9wm4hiOTd2VGiu+5JRSk3OCUhH39S6E
   4oNXG2QTzc2sXuAhMwdD/6QVLTCu+MUa3uYunePIDiXh2CEI/jc23czok
   2YJNl/lqdXF9Y1FvjNFRZWAyeMOE4ZStOK0EXbCR6nohG4wTY/zAu5eQT
   0GATHeIhKc3Bu3CSDw1rN26LFUtab9czofK21NAVDXU53uvMIuCUFdDN9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="364934276"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="364934276"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 02:49:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="747364052"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="747364052"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 30 Jun 2023 02:49:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:48:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 02:48:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 02:48:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2P/rcHdLzfZmSXKVOF9qOpdLYwo9Xtf/HcMmj/sumzHKeWbBox29dfVX5pHRwlR8b5Q1BdugL9kOkkjB1zB3+pkNCNMGZV+ojU+DMawKka3jtlGXmKPg3XGiEHKpfXzox2BBwt/EgQQhwZXH7CEPoitXQWbowmlH5RtZo1ekmNux3ONArWb53p0LI9mjmD7+xn1raMrE7LSpCn/jNTU4r6Hy3JCCI6QpGGiDg25G2RQWEvH2/xqaVeAOCeHjidm3IPeg9JwKiXWxhb+iABlgjFt+xURM4EGFGBSexCWufKdatIOl+o0LwACUaY+hJyV+w/9evUEjW8Z0W9MaKjBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssHh/Z0S1eW1JpSc0r21o4TxfHnkmyL293Bf8scBZT4=;
 b=cTx1f+vzE/tOAgQ88IzAaNo1p1X//zJBAgsikadC9pQ7OV07cvMI2Ucek5KwfwoxXIxlxASOMfLLOEWqSi5NDNxxYxsJVNeAENvPmqV/qnpMyOD/yHbY0Ag+oFeoLiVZHcCgGNNOl2CN25XyHBymoT/jwm9zYQRdbCdiJRYahfqLlOKDk5WORLUBag/1JuRVVDE2+Wh7UtV4fB1m3ntP4JZbwnRXgd6TFBYP3rTBoIRneHLgzRfGvIUCdudnQKExqX1UVrCteXGtJkAcdHwR0xEU6neidlGPYOvUrEcKJlwlsECMrma9hbmmCKmlgs6WSo5gIN7iPRaiOdT63DGd/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by LV3PR11MB8602.namprd11.prod.outlook.com (2603:10b6:408:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 09:48:57 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:48:57 +0000
Message-ID: <f875638a-ea61-04cc-7621-974d4bd2dd34@intel.com>
Date:   Fri, 30 Jun 2023 11:48:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 05/10] acpi/battery: Move handler installing logic to
 driver
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-6-michal.wilczynski@intel.com>
 <CAJZ5v0i1-7p-V0nFHoNWHDXRZ-xvVwTXJKM387PTP1d4k7Wrdg@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0i1-7p-V0nFHoNWHDXRZ-xvVwTXJKM387PTP1d4k7Wrdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::19) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|LV3PR11MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f37d3b-ea1a-4394-8d0d-08db794f3969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZ2eZqWDE7VkyPOD+sGmpZ+r7ok34ktA8WZFkCvuBY6bi7pd7lF1AORScHDluYCRs0zOFh02lczI9EnkWPSzotZqrXbONF98OrcgjKuUf5NG035wtgXMiiSWqo+hph+LXeQ5P/pvNO8Zo568Dp71/L2srp/WHKjqcL0+uocZQrO2MaxC+gip+DiGrWnArkuC96aSoNWg5M4I54Wo0msmQcl3XXx30sTjG4jaVi3xxDeQFc3vjeXS/Hjn14hxyO7zHqGSuZCznwkqZjaThBX4g8fCtyw6NcZ1uc6ct5hzrynx1w2r6opz2EARp91/yMZsxqfiMmbMgLyt9pbc1RmGSyN1+VuRnmpImYr749rJJmyYsbmLcvNDFEJaJjTBqQ+5pbH7fOYXCR0/VOplZoxKlb31Rkwfvk2PwlIbW4J/h4LfH+J2vY1dIPfTZmeQcl6c2eTC+3J0nIpvspncvFrdb9rXmPtqXIKF98xuAPMjj0OxeiMRhhjICR2tf1FuU2m9hympPoG4tcnAxemOnuVTe9x7pwkXMa4QwPfq6Dr555PWvtGPwqALC4Pqd/VbK/g9FmE6ChxP9an5+tkSn9jCrb1gH1QEn16fUO9vlLk9BirzRAOwERVHZGSfnRAMQnaATGtF0QfX3BgpMYyGr0UD+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(26005)(4326008)(66476007)(66556008)(8936002)(6506007)(107886003)(36756003)(2616005)(478600001)(2906002)(6666004)(83380400001)(186003)(6486002)(53546011)(66946007)(31696002)(38100700002)(82960400001)(5660300002)(86362001)(6916009)(8676002)(41300700001)(316002)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDcyV0FmTTZjSDBUR3NBTVljb3VtbnVud1FzMXh5WG9xVzNJeEtidGY1SlVr?=
 =?utf-8?B?QThBSDFBTlZKUTdidUFSSlJ5NERPdWc1ZU45WjFsSUVHeUYvcjExN09EWWdi?=
 =?utf-8?B?Sm93MHQwM0dUT0ZUVm90Tys2b3F3R1M4NTdmVVVTQjI1UVZBZjd5dHI4dEV0?=
 =?utf-8?B?T0xUNWdGazc0Y0tiRndlakpTMmV1Y0JzYkhvelcrL3dIQkxKSGJidXRmNmE1?=
 =?utf-8?B?TlRDM1NHWWFSSE1zWm94ZGVjZ3BPNjE1VmJjcldHU21lcWFQZlFIRGZwWVRD?=
 =?utf-8?B?ZzcxQUUyNmRlaUhSNWhGc0xUdDR6Y1UvWFVjcFh2b2prWHRmcDJRbkFGUXlp?=
 =?utf-8?B?aWJZT3lZYmhRTVRJUGp2cFNWU0VxdmZnVWNzTWVQY3dZTVdhTkdDV1RlQlBB?=
 =?utf-8?B?TWJBdGxPVGJvNlhXS0Q3c01qZFZ1WVVQNnFicGRUVGkyZEppUWRnMmhEbG5I?=
 =?utf-8?B?MUwrckRnb2dmMDkrWk5LcEZNMDI4YXVianh4QllDSGx4bC9KTlB5TlR4eHcz?=
 =?utf-8?B?YjJMVysrNTdLMXVYY0YwUm5maWdLRDA3QzA3d3JrdzhKNUcvZkJoQkduSmtQ?=
 =?utf-8?B?MmRQSXkzL2NUR3dGSTNpZlp6emluK2ZuenUwZEZSUzI2c1JkbHBQSENueEtV?=
 =?utf-8?B?QzI4bXo0Q29pTEpBci91cEZCa2t1UDN2MVo2VWttaWRRcHI1NWM1L2lpU3Bt?=
 =?utf-8?B?WVB3cW0xNHRtTmtPKzNFWHlPeUd5dVVEVjdDN1JWNWhqYWkzUGFndmJIblZ1?=
 =?utf-8?B?OGd3a1JDbzU3YldBQnJmQUJjWXo2TXN1OUlubDQyN0d5OXNibXo3VjNPaE40?=
 =?utf-8?B?TDZXNElGaDN4c0dXWUlQS2pCZXQ1SXZCcm9Uc2pUUytEVWZsT2xyaWFEbTQ5?=
 =?utf-8?B?OXc1TUxGcFVNamFMZEhkdktGNW5GRFhHOG5tNEY2WjMzRFZHNWNRbzdvcGxZ?=
 =?utf-8?B?MWVlZHhCbjF3TDcyaEp4YXBoWFNuc0hJQ1FtL2pudkpqeUYvK0h2SXo1UlZ1?=
 =?utf-8?B?NHVRQkM5MjFqVnZYUk5ZS2o0bkptSysvc2ZSSThRMXg4OUJPbTlnN09Pa0kz?=
 =?utf-8?B?OWMxYkJMemNNZm93YmxlTWd1UHBubHFyMkpuRmFMUUdhaGxITTErMnlFdmxW?=
 =?utf-8?B?Tk9oUjRoRE9pT0d5WFdXc3BpZ2ZadXhYaWdQRW9jUkd1MXNiRmpGanNySDJz?=
 =?utf-8?B?azlBNkRZYUt0dDhOK2xZM3AvVHJtazJCMTZaY3VXVU1DTi9tMlVzNlhQMXdN?=
 =?utf-8?B?S0JqNmFvRGx0UHBxUTJCZ1MvRGZjSGJlVm1KaEp6UWdPSi8rSEVpRldJV0hl?=
 =?utf-8?B?U3JHSm5VVGo5aEJPc0ZITllzMklkV0ZwVUh4Rm03eGJJQ0VlclBJNU1nZ05B?=
 =?utf-8?B?U0tqenVwQTBLb29WenE4bVJYaktUTGx4eHJKTlJaRzkyRnkxT3FUaEVlYWdQ?=
 =?utf-8?B?bjlUN01VZGJtajRYZkRmWmNiaC9neGR4emhxcStaWHg3cHgrTENONmFJYmRt?=
 =?utf-8?B?OFJTb3NIYURVTDNubG42U3VhbURnZWtKVGlSL0dvK0tFZi9NLzZXZjEwdHB5?=
 =?utf-8?B?aTlDUXlqZ2VuMzJnQ3AwN3ZhbU9KTFRva2NUV25iczZuemhFdk1KS2VUamtG?=
 =?utf-8?B?SEd2OVIycVVPbU9pYjUxa0gxbDlwSEc1TnYwRVg4NzBQQ0tVajg3endNYXVt?=
 =?utf-8?B?VzUxdUE0OXNta3RKSXV1Vm9TNVVLb1YrLzVMWjYwN2tRV1RGZWRlVnNvYytU?=
 =?utf-8?B?TnF4TFVTMW56NnFVZksvdisxenRIbHUrRmRRR0FseEc0L1hCd3c0dm9SV3ow?=
 =?utf-8?B?aUNNVktRaG9mQ01vR0x3YjU4ZDFVbXVmeDRaZUQ3TTNRb0tSbGp6dEI1WmJq?=
 =?utf-8?B?dmc1VVFLaDZ5UTdtRks4eWc1VUNKcHhUWTVlNDdHdXpKOHd3dTRSWkh1aE1s?=
 =?utf-8?B?bHRMMmd5ZksvVnlOVktVRWNlTVE1OFZES1VYRW1Hdll1M1V6YWpULysvdTAz?=
 =?utf-8?B?ZE9ZQmNLcDZ4T3RTSC9XT0JlZit2cGlqeXVGcU9MNUdZM0J5RWdlbW5ObnpP?=
 =?utf-8?B?Q0JDYXNiRkNDVkIzRm5UbUFNQ3NxcUY2TksvTk1hSHZaSi9LOFBUN2xBc2dh?=
 =?utf-8?B?OXAwQ05RQ0tvREorUG1vMkxuQ1VkK2VtbVQ1ejZoUmhHcnlZWDZwd0ZpODNO?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f37d3b-ea1a-4394-8d0d-08db794f3969
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:48:57.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzVFF5jO3DuX8yfV4iC/AA6FcUDXGdTAYKMdvVcUL5xhkbhcLJmfYmiWS7VI9iCaKG0d/kGKoyJqtJC4qVmhJ+C4p2bYjBlzrihVo1jM6Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8602
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2023 6:05 PM, Rafael J. Wysocki wrote:
> On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
> <michal.wilczynski@intel.com> wrote:
>> Currently logic for installing notifications from ACPI devices is
>> implemented using notify callback in struct acpi_driver. Preparations
>> are being made to replace acpi_driver with more generic struct
>> platform_driver, which doesn't contain notify callback. Furthermore
>> as of now handlers are being called indirectly through
>> acpi_notify_device(), which decreases performance.
>>
>> Call acpi_dev_install_notify_handler() at the end of .add() callback.
>> Call acpi_dev_remove_notify_handler() at the beginning of .remove()
>> callback. Change arguments passed to the notify function to match with
>> what's required by acpi_install_notify_handler(). Remove .notify
>> callback initialization in acpi_driver.
>>
>> While at it, fix lack of whitespaces in .remove() callback.
>>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> ---
>>  drivers/acpi/battery.c | 30 ++++++++++++++++++++++++------
>>  1 file changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index 9c67ed02d797..6337e7b1f6e1 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -1034,11 +1034,14 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
>>  }
>>
>>  /* Driver Interface */
>> -static void acpi_battery_notify(struct acpi_device *device, u32 event)
>> +static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
>>  {
>> -       struct acpi_battery *battery = acpi_driver_data(device);
>> +       struct acpi_device *device = data;
>> +       struct acpi_battery *battery;
>>         struct power_supply *old;
>>
>> +       battery = acpi_driver_data(device);
>> +
>>         if (!battery)
>>                 return;
>>         old = battery->bat;
>> @@ -1212,13 +1215,23 @@ static int acpi_battery_add(struct acpi_device *device)
>>
>>         device_init_wakeup(&device->dev, 1);
>>
>> -       return result;
>> +       result = acpi_dev_install_notify_handler(device,
>> +                                                ACPI_ALL_NOTIFY,
>> +                                                acpi_battery_notify);
>> +       if (result)
>> +               goto fail_deinit_wakup_and_unregister;
> You could call the label "fail_pm", for example, which would be more
> concise and so slightly easier to follow, without any loss of clarity
> AFAICS.

Sure

>
>> +
>> +       return 0;
>>
>> +fail_deinit_wakup_and_unregister:
>> +       device_init_wakeup(&device->dev, 0);
>> +       unregister_pm_notifier(&battery->pm_nb);
>>  fail:
>>         sysfs_remove_battery(battery);
>>         mutex_destroy(&battery->lock);
>>         mutex_destroy(&battery->sysfs_lock);
>>         kfree(battery);
>> +
>>         return result;
>>  }
>>
>> @@ -1228,10 +1241,17 @@ static void acpi_battery_remove(struct acpi_device *device)
>>
>>         if (!device || !acpi_driver_data(device))
>>                 return;
>> -       device_init_wakeup(&device->dev, 0);
>> +
>>         battery = acpi_driver_data(device);
>> +
>> +       acpi_dev_remove_notify_handler(device,
>> +                                      ACPI_ALL_NOTIFY,
>> +                                      acpi_battery_notify);
>> +
>> +       device_init_wakeup(&device->dev, 0);
>>         unregister_pm_notifier(&battery->pm_nb);
>>         sysfs_remove_battery(battery);
>> +
>>         mutex_destroy(&battery->lock);
>>         mutex_destroy(&battery->sysfs_lock);
>>         kfree(battery);
>> @@ -1264,11 +1284,9 @@ static struct acpi_driver acpi_battery_driver = {
>>         .name = "battery",
>>         .class = ACPI_BATTERY_CLASS,
>>         .ids = battery_device_ids,
>> -       .flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
>>         .ops = {
>>                 .add = acpi_battery_add,
>>                 .remove = acpi_battery_remove,
>> -               .notify = acpi_battery_notify,
>>                 },
>>         .drv.pm = &acpi_battery_pm,
>>  };
>> --
>> 2.41.0
>>

