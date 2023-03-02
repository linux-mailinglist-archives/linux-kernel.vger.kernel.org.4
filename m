Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CDD6A7996
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCBCjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCBCjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:39:46 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1311F43462;
        Wed,  1 Mar 2023 18:39:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YL4jn54zcMP9MVFHUJjz6O5ZNVkr2oYxgSYK71AYNXrCE3XRTc/TMCR/HqIaHlWIPLbUysJgK/tocA2ZJkuOiWn3uoF/FL18HIFTewMtTK3wPGh0SES6dSdlC1NEu/nrvvnoP1g00r4ZG3L1sbEIXCTbqNvIIy34WHpThzfGbhRcZuUdrY4Qz/N9IIJGjVqNkUz18tsJsB963FHllGGVlxKGPlxr4NrXF3DDqaRgvhYqCYhFSlPI0rzUer77kLRvQUjmA2JgY3ZIC6037Q6ogzZIdII+D5MYNCF8lkbNzMjIxjpIUcqcVZsxO3OhVRGFLBm0hCL7GTQSQlOZrLRYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLywOxKHFS1bJh267oxLEhBzfHYFbPqpjSNNhzI9kNo=;
 b=FXyePHhGfctkCSDjNF+NZ+Tj70iFdJux5oh0R7n1R/yDJlHjeWjiMgVFV4oY1a3mFWUuR4wrPkfXKMSLgv/sXHGH71GB9h2W3Qny0dZSrZv7rowLfCwf+ny5uiZ2Pp7dKKwB/XiEONk6MozwWAKITqSEouisFRTeKoJfwPEo3cVtwsFED8jC0emRTXXol4qPWdngiJNJihqPCrcm2Yhr6WHTYg1893WwLqPUt6O2j/SoQ107a/A2Rr9QV08oMXsgDPd+KusTMsUA/gHJdp3HY3zPRYK+PvTx1GLncjqR07ZpZkNoqDoUv+NRUJXKWFUdNSgJ+LkQxuTHjU6TogmYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLywOxKHFS1bJh267oxLEhBzfHYFbPqpjSNNhzI9kNo=;
 b=MqSMsaQ2u6kvl27hH+m/28hUSyl+vJOhFSMCpjSjIBC8lx1EaNKH0pRINyrt68ubhl58bshIt5ylzkiu8xcMW70PpEaPkfv2YkBsZ0zgvIItrQlr/8e52thWC3OfP+RlPnVyO2nj/owj35GuOgE+XHNUL5SuVR4oog8kx709oOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 02:39:24 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::8db1:ed03:e196:be2e]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::8db1:ed03:e196:be2e%6]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 02:39:24 +0000
Message-ID: <e4a8f2ef-d6bf-1b14-ddaf-057fcd5abf11@amd.com>
Date:   Thu, 2 Mar 2023 08:09:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/2] platform/x86/amd: pmc: Add a helper for checking
 minimum SMU version
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230301150821.9791-1-mario.limonciello@amd.com>
 <846d6f46-07ab-4d4a-5623-417a469c3d0b@redhat.com>
 <MN0PR12MB6101781FC5089EA217CA48A9E2AD9@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <MN0PR12MB6101781FC5089EA217CA48A9E2AD9@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::7) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: d10e10d9-f2c9-4ed5-ad84-08db1ac7557a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXa67/UpuMsp//kehtPzTfdVRn4XhvxjLqls/nKgxPP6OvV3ArkH7BOVtb/jQxt2pZGOqbIfZIwOQ77BID3nEO0eUG5N5kCczt8OROpfz9j+10cYpXGh2/PmZF1+SVDWBX+OZMfQNXwiraTrhBYzl/6VfMDGuUxQyQN5Dt84bMpO6q0GL3hLq0Ds4PGcdZADLxUfX5P2Ll4NtjyDww0X3VowavcbHx/A5aPU74tkC/GL2g7U1tYvbumdDDWmvvN1OebDERvc/4/EmK7Q3EgoOwEoXlvZGBmLg2IZ2uy7nNWjI3GkKy6zqJlVEXmixeZCDpN5pcBnhIZyeCBN4jxkmeXguWnjFKUQOucUYyI4licBsqOhCidvzGUYNRgFhMfxA5KhrVAlCnFy3OY/qGrfg5bh1LD2700mKO7xNYoQaC3Umd7olcD3Wk2nUJXKjR2VRggXEDU2uxxtJwRELJczkD+gbiFYJr4ielo6wC5QWChjkgfeDj6NoRm8+mCJqqCIxYIYxtRKL+D2GTs70C35I4jSzZOc0E/Uwd/wXXxLtMfCcfX/OsztmX+wEXelxtKQWmSNaYiM+f1ksMdsm6YqcF3qxvin/zuZRsrimnB/WTPvXH/lyxldtTichmEU9cRrq2ezmi/9ytJWY9P511Jlxn5spXijmQYaoO8WPdKfCRm5Qu65+Z9VvBKC0EExzqIrAqqDt5f23tUPKP5KM15c6OTxsAAGN6nL7sAzuacHJL8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199018)(83380400001)(31686004)(6666004)(36756003)(38100700002)(8936002)(5660300002)(478600001)(31696002)(86362001)(2616005)(26005)(186003)(6512007)(6486002)(53546011)(6506007)(8676002)(66946007)(66476007)(66556008)(2906002)(316002)(4326008)(54906003)(41300700001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHJvYUpGQ2lJbmx1cEVzNCtMTTBmUTQ4UHB5UFZSaUwrN1JOem5jajRCK2Fs?=
 =?utf-8?B?VVlhVjE3MjdBRFV1UXZDS0pIblFsN2pzVkNkOFB0N3hBRU5EcTJZOWRYYTJY?=
 =?utf-8?B?bk92QkorcytwMndVaURrSWMzQzgxQzRFaU5nQmNmdWNFRUZzSUltUEhydlds?=
 =?utf-8?B?OGJzTTkwdXhZUlBNdDZyZ1hkNm80L3k1ZnIzMjZsRHdxT2ZNRGlVMXpkYnJQ?=
 =?utf-8?B?OFhzRTFBSTQ2Y04yUTZIVVd4S3p4TGoySVhBdXowVlJ3OU1qdlNCRlVlK0lU?=
 =?utf-8?B?LzJ1c3hxV3pSTzNCSjVLYktvc3U3TnRZdVNlSm5uUi9NSS8rQXpaWThnM1Vy?=
 =?utf-8?B?U0xSd1VjNDZiQkhjaHdZVVpYV3UxaGhZL2xRaEhwblVKWElPYmlEN3ZrNjFX?=
 =?utf-8?B?NTM0ZjV1WTVobzIxR2dMYlQ4ZnRDMjRLMFRETUZxYk8zVEMzUFh3OWRVQnhu?=
 =?utf-8?B?TjZERjZHazJlcUV6ei80VzdrdVlPTFZDSjA4elUxSWJnOGtpUHF3enI4UDUv?=
 =?utf-8?B?RWxlRGx4YSsyWEF2SXFaRk5zalBjaER0c1EyNVZiQThHVEZnMXV3QllWbTdJ?=
 =?utf-8?B?eHUrdXYrcDhDNmlpUTBlZ3R0UjZvN1JHNEFIeUZJMkViZXhKMmZvU2JFQmVi?=
 =?utf-8?B?d2lHRlk1TXdDcGY1K3k2WkJtMTlaMURSSVEvcDE3KzdLNDNpTjlIaFZRU3R0?=
 =?utf-8?B?QWFMQ2N4bGVrQkVLSmt4dTB2SzNuZGVnNGVib2phWEt2NEhBS0ZkK3VyN2NS?=
 =?utf-8?B?NXg4TERnK3Rsc0xhNnNCbnJFNG1RTHZnWEhoQjhUTTVKRGc5WUtFNGZmVGdo?=
 =?utf-8?B?bHM4Z1Z3ZSswRHNsRjZKRnc4eWUwUUVIMHVEU3RJeFowMnBxK0J0WmRWdlVL?=
 =?utf-8?B?MGlUUGNMWDdlZWtOZlBWejMrd1lFcTFIdk1GNnFHMmFUWUc5cFY2RlJMcktu?=
 =?utf-8?B?TWFtQXp5endKY0xaUkFjdFgxeUloMFNSZmJIdFJid0I4a05RNmJuNHlkd2pQ?=
 =?utf-8?B?ZndQQWNVSnFGb0g0cmVoRXQyRDVFRTh0WDQxTElYRmtZQ1F1bUdXeUhCeFY3?=
 =?utf-8?B?TzJGaUcrL1puVUdLdzNRZll2TFRtOEkybE5oNm9WQUhJM1Bhanc5UUkxckRv?=
 =?utf-8?B?VmdGYWhqMklkZWIvWnJPWVluRUtwNlMvWnRoQ0twcG1EMlJXVFZ5VHBSWGJL?=
 =?utf-8?B?NnpqR1M1aGV5RUZHRWFBRUUwa0lONG94cmZtUzIwNnRDd2JlaXlCTjMrTlFR?=
 =?utf-8?B?bTFiWjBsMzU1QTNlQ1h0ZmhoTEhqY0x0SjNVeGgzQXV1T0tFVnhVcDJIQVJC?=
 =?utf-8?B?L1F1M1VjeHlHZUJ5ZWpXU2xkUHBmN2JXUjVaV3BqdHQ2c2Jxd3IrZGp3MmpW?=
 =?utf-8?B?SHhQVW1NRVkrZlVNdkQ5VFJPM2JCK0NjajllSlk4ZkJocnRmT050amgxMkV0?=
 =?utf-8?B?NlB1ZWJqaGtOSlovaHFFNXU5SEVXaUFadkFkemdUaGNQTlk5Z3Q1NHdDdHU4?=
 =?utf-8?B?dTlrODdhNE41L0Q2RXgyNloxWVBLZnllUGpWWGIvT3dlWXk0T2p5VHRKNHpL?=
 =?utf-8?B?Y1lNNFRVQVp6L2JkWGcrVnhpTlBlbENCaFBva1V2dS94NVA3SUxnZmd0aHhH?=
 =?utf-8?B?dnNuYXYydWhqZ1RtUGJWYzNWa0pjc1pIUGtRdGhna0N4YW9IditmaWtETTZm?=
 =?utf-8?B?cEJMOXZ1ZjY2K2k5L0RBT3VhVENBK0h5MDlrT3ZibVZXYjBrNUVpMEVsRGIv?=
 =?utf-8?B?WDQ5ZXRiSGMxdStnTEpQTlYwQzBBMjhiY3Y3ekxyMUtVRmh0QU5BbDFVelRp?=
 =?utf-8?B?UlFNRldPZkUyTTduQmVjUnRqeW5FdWxhMU8vTDE5SUFzaVVwTG9Pb0EyQzJL?=
 =?utf-8?B?Z2ZRSzFRZ0k1eFZHeG5aNGJXb0RwQ2xpUGJJTG1adkthdzNSeUJBcjFUd1d2?=
 =?utf-8?B?QU9GWFA4TGdhakxCKzZYNWkzWUl1OTJ3SXRaSkQ4czQ2Wm8wdlVyYXN5UVgz?=
 =?utf-8?B?cnhpUEJjZllYMUc0bzdicjNXNkpHdkZybTBoZU5aZDdMY1RxL1JJc2JyaGJZ?=
 =?utf-8?B?dWUzTy9mUDNBdjNEak10dTFoN0VPRDBrblJmdGw3SW9udjJTRTVBZVhva2cr?=
 =?utf-8?Q?8q0UQHuqOmYJm0xIpKed/8S0V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10e10d9-f2c9-4ed5-ad84-08db1ac7557a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 02:39:24.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bk8j2ApRzmYih3ejO1w9HaOP2hebUHw65/6qVLNZ6ZgVp6sDqP3vh/7S0zIfnjPk7F/ZZrLtUZUp2PuC3wEYtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On 3/1/2023 9:01 PM, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Wednesday, March 1, 2023 09:28
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; S-k, Shyam-sundar
>> <Shyam-sundar.S-k@amd.com>
>> Cc: Mark Gross <markgross@kernel.org>; platform-driver-
>> x86@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/2] platform/x86/amd: pmc: Add a helper for checking
>> minimum SMU version
>>
>> Hi,
>>
>> On 3/1/23 16:08, Mario Limonciello wrote:
>>> In a few locations there is some boilerplate code for checking
>>> minimum SMU version.  Switch this to a helper for this check.
>>>
>>> No intended functional changes.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>  drivers/platform/x86/amd/pmc.c | 49 +++++++++++++++++-----------------
>>>  1 file changed, 24 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/amd/pmc.c
>> b/drivers/platform/x86/amd/pmc.c
>>> index 2edaae04a691..c42fa47381c3 100644
>>> --- a/drivers/platform/x86/amd/pmc.c
>>> +++ b/drivers/platform/x86/amd/pmc.c
>>> @@ -418,6 +418,22 @@ static int amd_pmc_get_smu_version(struct
>> amd_pmc_dev *dev)
>>>  	return 0;
>>>  }
>>>
>>> +static bool amd_pmc_verify_min_version(struct amd_pmc_dev *pdev,
>> int major, int minor)
>>> +{
>>> +	if (!pdev->major) {
>>> +		int rc = amd_pmc_get_smu_version(pdev);
>>> +
>>> +		if (rc) {
>>> +			dev_warn(pdev->dev, "failed to read SMU version:
>> %d\n", rc);
>>> +			return false;
>>> +		}
>>> +	}
>>> +	if (pdev->major > major)
>>> +		return true;
>>> +
>>> +	return pdev->major == major && pdev->minor >= minor;
>>> +}
>>> +
>>>  static ssize_t smu_fw_version_show(struct device *d, struct
>> device_attribute *attr,
>>>  				   char *buf)
>>>  {
>>> @@ -526,14 +542,7 @@ static int amd_pmc_idlemask_show(struct seq_file
>> *s, void *unused)
>>>  	struct amd_pmc_dev *dev = s->private;
>>>  	int rc;
>>>
>>> -	/* we haven't yet read SMU version */
>>> -	if (!dev->major) {
>>> -		rc = amd_pmc_get_smu_version(dev);
>>> -		if (rc)
>>> -			return rc;
>>> -	}
>>> -
>>> -	if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
>>
>> The 2 major checks here originally were not in sync, so for major == 55
>> *and* major == 56 it would only succeed if minor >= 37.
>>
>> Where as after this patch for major == 56 it will now always succeed.
>>
>> This feels like a bug in the original code, but might have been
>> intentional ? Please verify this.
> 
> @S-k, Shyam-sundar as the original author of that, can you please confirm?

I cannot completely recall :-) It was something like if the major
version is greater than 56, there is no need to check the other part of
the "OR".

which is kind of similar to what you are now doing in
amd_pmc_verify_min_version().

Like we discussed off-list, we should have this boilerplate in place, so
that the future checks would not be duplicated.

Thanks,
Shyam

> 
>>
>> After verifying please post a v2 updating the commit message to
>> point out this functional change.
>>
> 
> Sure, thanks.
> 
>>> +	if (amd_pmc_verify_min_version(dev, 55, 37)) {
>>>  		rc = amd_pmc_idlemask_read(dev, NULL, s);
>>>  		if (rc)
>>>  			return rc;
>>> @@ -686,15 +695,8 @@ static int amd_pmc_get_os_hint(struct
>> amd_pmc_dev *dev)
>>>  static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
>>>  {
>>>  	struct device *d;
>>> -	int rc;
>>>
>>> -	if (!pdev->major) {
>>> -		rc = amd_pmc_get_smu_version(pdev);
>>> -		if (rc)
>>> -			return rc;
>>> -	}
>>> -
>>> -	if (pdev->major > 64 || (pdev->major == 64 && pdev->minor > 65))
>>> +	if (amd_pmc_verify_min_version(pdev, 64, 66))
>>>  		return 0;
>>>
>>>  	d = bus_find_device_by_name(&serio_bus, NULL, "serio0");
>>> @@ -718,14 +720,10 @@ static int amd_pmc_verify_czn_rtc(struct
>> amd_pmc_dev *pdev, u32 *arg)
>>>  	struct rtc_time tm;
>>>  	int rc;
>>>
>>> -	/* we haven't yet read SMU version */
>>> -	if (!pdev->major) {
>>> -		rc = amd_pmc_get_smu_version(pdev);
>>> -		if (rc)
>>> -			return rc;
>>> -	}
>>> +	if (disable_workarounds)
>>> +		return 0;
>>>
>>> -	if (pdev->major < 64 || (pdev->major == 64 && pdev->minor < 53))
>>> +	if (!amd_pmc_verify_min_version(pdev, 64, 53))
>>>  		return 0;
>>>
>>>  	rtc_device = rtc_class_open("rtc0");
>>> @@ -772,13 +770,14 @@ static void amd_pmc_s2idle_prepare(void)
>>>  	/* Reset and Start SMU logging - to monitor the s0i3 stats */
>>>  	amd_pmc_setup_smu_logging(pdev);
>>>
>>> -	/* Activate CZN specific platform bug workarounds */
>>> -	if (pdev->cpu_id == AMD_CPU_ID_CZN && !disable_workarounds) {
>>> +	switch (pdev->cpu_id) {
>>> +	case AMD_CPU_ID_CZN:
>>>  		rc = amd_pmc_verify_czn_rtc(pdev, &arg);
>>>  		if (rc) {
>>>  			dev_err(pdev->dev, "failed to set RTC: %d\n", rc);
>>>  			return;
>>>  		}
>>> +		break;
>>>  	}
>>>
>>>  	msg = amd_pmc_get_os_hint(pdev);
>>
>>
>> Patch 2/2 looks good to me.
>>
>> Should I queue v2 (once posted) up as a fix for 6.3-rc#  ?
> 
> Yes please.  If it makes it easier I can re-order the series so that
> we add a check in 1/2 and switch to the helper as 2/2.
> 
> This might make it easier to take the LTS kernel too for stable,
> but I don't feel strongly.
> 
>>
>> Regards,
>>
>> Hans
