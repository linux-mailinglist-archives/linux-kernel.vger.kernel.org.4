Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2475BB87C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiIQN0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIQN0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:26:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6222981C;
        Sat, 17 Sep 2022 06:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHmtcplpqi/D6Mz2wYXO+M/SQ6/ThSw99ESdvW00E9Nd0KrIsEI7M/tIUwPYSot69fXFyI7mek6s2Ml+AIG2XhqEMg8ZzSw8b1riVOAZb2hRuUo7fAMZis+54etTU1nxYE4ZUEpzGvXwmjMdy1TPS6vZRUqRNzBscae4DlKX4K4QKavMUgN62Ggllvssbs5iUDrEd/IyA3LnsE4py6wAnvSYNZKo0WtG4ubGvIE4I+H5hSUec8PQOJ5cHMpNVTQCAlLSIzEFLA24kV8NIP1EoWzgF6rwIuHQUQw18xlpZ+R570umo0QmjWLDmAAjv1wDHjJELyhjHztqP8CO5+CZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaWbVikndGy8iMzkgyQin9GeoleiXF7R32eVWbWroJI=;
 b=VIKTaiGlNPda0NBPxk8RwsQnuGJLxBUycznSNdSPTUAN5knrjABvTSGjbPg6L4dO1BBJUixI5tDgPtLHsdirSijjGfWc4jR/9/wVWvWsRKKkuKqKHN/xNDqKVTy1smJxDm/OGE4q52Y3d1CGIt6qk3/NwgV5RlbfMCJzlc1tFDbGAxYknu8S9tSVRcnhToXJintNEZD9t2F2EshayXsvnLBWEl2yGprKpIZagTi6HV3VKkxsdla5y9wq2SB2zY0AZbwlvDSsapvqD1qqTHoWGV+gmKjZx95D6udSO8VGRIViwo4w4iBn0zZ9z/e67Ls03YVHY9YLDhdDzoqxs5UD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaWbVikndGy8iMzkgyQin9GeoleiXF7R32eVWbWroJI=;
 b=XGyO3nZ1Lguy3iY1FCVj7kzpP7AEvMPf5a8cfzT2xaRspO9GYShOKMfGjKOfsuUA2oJgSEK53ZtN4mfI3QIkdSdsPI8O/vofw6toF2Q/IzsE46xwyqqyfd4fXvNln9WoLk9Gu419P/b61FjaX/9Godz3C14r1645Sr7R/Ajysaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4861.namprd12.prod.outlook.com (2603:10b6:5:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Sat, 17 Sep
 2022 13:26:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%7]) with mapi id 15.20.5632.017; Sat, 17 Sep 2022
 13:26:11 +0000
Message-ID: <cebae02c-6a9b-e9fa-91dd-509b83543141@amd.com>
Date:   Sat, 17 Sep 2022 08:26:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/4] acpi/x86: s2idle: Add a quirk for ASUS TUF Gaming A17
 FA707RE
Content-Language: en-US
To:     Luke Jones <luke@ljones.dev>, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     catalin@antebit.com, Shyam-sundar.S-k@amd.com,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20220909180509.638-1-mario.limonciello@amd.com>
 <20220909180509.638-5-mario.limonciello@amd.com>
 <a5f1976a3b8e905a09ebb08f3baad0996101c5bb.camel@ljones.dev>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <a5f1976a3b8e905a09ebb08f3baad0996101c5bb.camel@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:806:122::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: c864868c-fcf5-47e0-18e4-08da98b02fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tAIRtwOhGetSogsag9i2GMqEdexqwbTP/1WQcnppIqHmEg4ix6fNd0WlkMUfBeDn6zoC0ng/IRU0XX8MyjAb7VvPPdl1vePYek5AKcRd1d16VRlHw2/NPcBKpXRn1jbBnp+F9FgO5e+Rdiqajo1nppICZAhdGL92UKef+meobuJkybnyjCo7faL8yZXTlF/59vxyFqR9hFSYvNUYVcTxWTCJdc3tsUy81YLlTAe3mVnqhI8mAI7UGjDYC6K/ers2jkV7U1Jz+MV5xNQup07/J1BaiPqb6AGGuCLJ8cO5OYK7PapB7ZaOhGLY18EMbstbxq5xCxUCWmoTXxznA7OWUy6TN01LXAunl7rhyMyOoP0Oz8w58IQNrv4VHv0sxUEBoxnB4K7IYsBDjcdBniaLfTUDUmJbFTV9mPsoXFI0anDfOmh4nbJrCnoEFVQuFaaf8hJ6foDYmje/MznPcyf/o1eUpKlCieH97yIbgbFjYpb5Ubcw1ak/cxBDhITvVu6B1lkiRLcFly/j8bk3m6AWhqxxy93gtE9ZfhtqE9lWC+ny6LcTR2/N6Ks5pp7hLUXXKWHIFo167mBGHfWW/4EA8fimKdDXB2j64I/gA6w/uycLCbvrkY1PPaV9RLEbMna7ilMlxUOwSAUyLN0l3yHOr7XAPaaCzXX9EZ7KdXjURm15lSjQPTeJJVtmqqOAjoazzTfM5zgz4mvK9SoKNugfsNuS2obJofvkE4hpj6WeXaJUggHgnUksBbUAQgdD7rTchML5XUuA6NclbcAKu407MoTNKSVIL5n3C4PZF+/Hekl5/AyXMPWlVcWU6tQag4+Ex9/QZNnAN4TCifzTk2iGMbAgi7PfN5T8dH0H9ZMzQ5Zlnm29djDAIhUsQeu6l7Po
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(6506007)(6666004)(478600001)(53546011)(6486002)(41300700001)(966005)(83380400001)(6512007)(26005)(186003)(2616005)(5660300002)(2906002)(44832011)(66476007)(316002)(8676002)(66556008)(45080400002)(8936002)(66946007)(4326008)(38100700002)(31686004)(86362001)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aklPdXRXaklXcEJjQWgrcnJBL3BJSHgvcHNMdU9FenlIOUVtMTQwV3R4MFhh?=
 =?utf-8?B?bVY1OFRtWm1sR0ZvYmZnbFlEcVZWVlJOOGwyTUhhSURaRytxZDUvV2wvWVYy?=
 =?utf-8?B?ZHNqaHdWZnBua0M5V21UczdiQjZKS0RPUnhZK1JuTUZVNlQ3Y3RxdVZxWktT?=
 =?utf-8?B?ZUVlcjg3ZFAzN01RblVjSEZrazNnTFl4TFpDd3ZpSzl1QW1qU3Fwbm9ma0FM?=
 =?utf-8?B?bndpNk91UDhwUml1NDF2cE1vdjJBR0svdkVYODU5a3RrVHhHVCtlZURVNWpG?=
 =?utf-8?B?SDVVRnJ1Zk5MWUtXMnRBbVZ4bUdEVzY5eTkvS3NVU0R0emR3d1RWak5oOWIv?=
 =?utf-8?B?Z3JGc1pRc21TenV6Vm1TN3F4eTdVQzBVOGhCZHdldjBFeWVKa3BNbDQ2UGd3?=
 =?utf-8?B?UE5KTis3ZS96UG9SS2FZcWxTZ2JscXVWVERmTERySEVlMHNLU2hnV1FsZmZE?=
 =?utf-8?B?QzlUelA5OUM1Nlg4QUVzeEJvRnloMFdKR2V4cVN3N2dpL1phbGlHNllKcHo1?=
 =?utf-8?B?UENsbGZMT3FBdWN3NVB4WDFSQmVTVUdGRnh6MTNiQ3doSnJoWEwwRk9EbXFy?=
 =?utf-8?B?WkplaDJFbEFNc2FYenltWW1iRWVKbUZrY1BxRWFuTmVnNEJIMUdZSFlrV0xt?=
 =?utf-8?B?WXQwWTFlK2s4WktFQ255MFJJUWVWem9UcHhHcklCNys5Y2tkVzVUeWJDUEUx?=
 =?utf-8?B?VHRIb0NVWTZFc3p3dVpxMFRwVG9BcThUTVEwUUlVTXNKS2ZqbHFrVEFjV0dZ?=
 =?utf-8?B?NzlaMzVuRGpuT0U5VXdVU01OWmNwUGxCYm1raUtITE9nQnBaNnMwN3NQVlgv?=
 =?utf-8?B?TnY2SXY0ZFNXL1p6UVg1bzcxTnJPOWdHbDB4QmwwV0tyZnJTSnJQdEUrVFpU?=
 =?utf-8?B?ZTI1S3hvZFhsNTEydTBuRXlXU0xtRmhNcUl4bVJOdVFFK0pMdnZnUWRzSXNK?=
 =?utf-8?B?cEluY0JVTHJpQzdhU2NGZFRONUpnY0JkZDdhOXRLWDRGaDlOKy96bUZDalpX?=
 =?utf-8?B?ZWVVRnN5L1Ivay93WkdCK3k4VFRpcmVjeHJIc2YwMmZ3ZFlSMnJDVGppUWtK?=
 =?utf-8?B?QjFBNWROeXlGb3ZSYXcyRzVrU1RSUStLQnJ0bU1WRzArcy9WeGlWNnFUa3gv?=
 =?utf-8?B?TGNGTkFtbGd1VGp0MitMaTFDanVoeWx1ZlB1eGlMZk5GTU9QL0grbE5NTXl2?=
 =?utf-8?B?MWp4cWZ5UVpaSlBtOEdhTVdTY3NBenN4UFhuNEFZa3NJQTVtcG1pckhnZFFX?=
 =?utf-8?B?NzZsU2ZCSFM0ZkF3U1M3Rm05aXZWb25OWjhLWDJ0WVQyazR0b1FmL0ttaTNI?=
 =?utf-8?B?TCttV2ZpZ3NHNEJyblZDaTQ3Y2ZBRTY0QU9CckxmQjZhOGQvT1E1c1F6WjVv?=
 =?utf-8?B?WExoeVgwdnI0TVA0MUlSdXRmb2o5MFlRSWprUXRMYjBudmthdnBQKzMyLzBU?=
 =?utf-8?B?enQ5SGlzc1M4R3ovQXUzWVJ3VUtlWEJzWWVNNGxrV1ZsUDVJam9vMDFzbXRu?=
 =?utf-8?B?MVJzRDNjd2N1Q2p6VWhLSVk3UmVINVJuNCtSazFnUDZMMUxTQTFWMmljLzBY?=
 =?utf-8?B?TUJ3dnJ4dy9UOU8vRVpTZlRsMEp6Rlh5ajF2MDVyQ3NLZGRjYVBEV2FiNldw?=
 =?utf-8?B?SjcrTW9nSjk5bjFMYWU2SDhGTC9PU0ZnS2R5QjdScXBEc1JnUkJsbUJNNEtK?=
 =?utf-8?B?U2VKa2p0NTBiMlFqLzY2dy9SSVdNVkdWVU1wZkF3RCtyTW5TbVR5VW9lSE45?=
 =?utf-8?B?dklMUkdaaVJXRlROTG83bSt0MENOWnNOUnU2SGlRZEJQbUFzY2RPZFdXaHY5?=
 =?utf-8?B?RHk5QXJwaU5XT1Ayek5RUEtEUTlLb1JRYng3dVJLbkdZeWxXNkdTMko5RkU5?=
 =?utf-8?B?cjIzd0huUUNzSzdMU2dQMU9KUEFVNVRSdE53TEJsaFVkb2xYMzFqaXhFQ2x5?=
 =?utf-8?B?RU9UVlRtbm9MKzZralhtZmZDVTNJZ0xSV1dqck1RRFZvTHMrOHVBSm5iQnpr?=
 =?utf-8?B?NEdmUGpUa0cwVExrSzl5dk54bUVuUTRvTTJBMVphQldreGVSOFNycVhrT0pX?=
 =?utf-8?B?eE0rdGp5VUZ0eFRINjRoL212WnhTdDl2N3g4OVB4YmNxUzF6ZmlrUG9hdTF5?=
 =?utf-8?Q?UYJaCkBq2tJlAhZT0Wf5bU2x7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c864868c-fcf5-47e0-18e4-08da98b02fa0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2022 13:26:10.9220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ns7t8A5jWMOsaJDlQnFeXW6tzGwMK86qOT9GCbyAZY6/4VcRxLTpUrIkUfzdB4W92yXaVLGfs+s9xuYq/c18A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4861
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/22 02:35, Luke Jones wrote:
> Hi Mario,
> 
> On Fri, 2022-09-09 at 13:05 -0500, Mario Limonciello wrote:
>> ASUS TUF Gaming A17 FA707RE has problems with ACPI events after
>> s2idle resume.  It's from a missing call to an ASL method in AMD
>> the s2idle calling path. Force the system to use the Microsoft
>> Modern Standby calling path instead.
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216101&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cc89466a0fc1b40d2dfd808da987f390b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637989969450224307%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=hFj1HnKnG9HPiQDc0fDFs07flY9N2KiOpY2g61bIdyE%3D&amp;reserved=0
>> Reported-and-tested-by: catalin@antebit.com
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/x86/s2idle.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>> index a9b0f2b54a1c..6a2c94fdbeae 100644
>> --- a/drivers/acpi/x86/s2idle.c
>> +++ b/drivers/acpi/x86/s2idle.c
>> @@ -17,6 +17,7 @@
>>   
>>   #include <linux/acpi.h>
>>   #include <linux/device.h>
>> +#include <linux/dmi.h>
>>   #include <linux/suspend.h>
>>   
>>   #include "../sleep.h"
>> @@ -400,6 +401,28 @@ static const struct acpi_device_id amd_hid_ids[]
>> = {
>>          {}
>>   };
>>   
>> +static int lps0_prefer_microsoft(const struct dmi_system_id *id)
>> +{
>> +       pr_debug("Preferring Microsoft GUID.\n");
>> +       prefer_microsoft_guid = true;
>> +       return 0;
>> +}
>> +
>> +static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
>> +       {
>> +               /*
>> +                * ASUS TUF Gaming A17 FA707RE
>> +                * https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216101&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cc89466a0fc1b40d2dfd808da987f390b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637989969450224307%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=hFj1HnKnG9HPiQDc0fDFs07flY9N2KiOpY2g61bIdyE%3D&amp;reserved=0
>> +                */
>> +               .callback = lps0_prefer_microsoft,
>> +               .matches = {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER
>> INC."),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming
>> A17"),
>> +               },
>> +       },
>> +       {}
>> +};
>> +
>>   static int lps0_device_attach(struct acpi_device *adev,
>>                                const struct acpi_device_id *not_used)
>>   {
>> @@ -568,6 +591,7 @@ static const struct platform_s2idle_ops
>> acpi_s2idle_ops_lps0 = {
>>   
>>   void acpi_s2idle_setup(void)
>>   {
>> +       dmi_check_system(s2idle_dmi_table);
>>          acpi_scan_add_handler(&lps0_handler);
>>          s2idle_set_ops(&acpi_s2idle_ops_lps0);
>>   }
> 
> I'm confirming that this works for another laptop with the same issue -
> the GA402R series.
> 
> The diff as follows (I'm unsure of how best to submit this as it is
> dependant on your work - I don't need attribution for this):
> 
> 
>   drivers/acpi/x86/s2idle.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index e2b73809ab50..0c8348de5cbc 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -420,6 +420,17 @@ static const struct dmi_system_id
> s2idle_dmi_table[] __initconst = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming
> A17"),
>   		},
>   	},
> +	{
> +		/*
> +		 * ASUS ROG Zephyrus G14 GA402R<variant> series
> +		 * These laptops have a similar issue to the FA707RE
> +		 */
> +		.callback = lps0_prefer_microsoft,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER
> INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus G14
> GA402R"),
> +		},
> +	},
>   	{}
>   };
>   

Hi Luke,

Thanks!

Your model is actually already rolled into v2 and v3 of the series, 
reported by Phillip Zabel.

https://lore.kernel.org/linux-acpi/20220916182609.3039-1-mario.limonciello@amd.com/T/#mc37fd351eb5460a36c9e3da12c408fd3acb9f515

Thanks,
