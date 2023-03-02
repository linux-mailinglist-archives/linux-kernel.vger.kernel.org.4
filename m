Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B4E6A7999
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCBCmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCBCmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:42:40 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352F63B868;
        Wed,  1 Mar 2023 18:42:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vfnk6LX40Wp12RUtv1MC7LOzLmfnIo41KIb4ZVMb/XaErDh81cYGyRz1sgA6r5mqVXIlBQyiGZKEHnbcLUvXyvHdG/q1eXo3cxWY6dpmS7ejpCpUts8PCfNGyJVMmDpckKRGJNNp7Nkz0/mpknYZYsHtpUe4RRKawnKQveisWVI8H0dQhg/YxyiWvfAlSOi2zF3Jw0zoNPiZ7yzJGeDcB1BpOQRMIIx4IulsFgztIDmJ3XDNJlX7szbVA78dSC57Un26rL+iNI2QGTW1zd3pSmMJp5QsebWNJfEtcK4PjbLlgn5gnuayMPlKA6SvdxZWn98WyBnkLfCPdAENFmHyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBG47TCm5ZtH+LOif34wfSwEt5N6JrMRuVS5LW/7O+c=;
 b=OMFHkSLkN0b8WE+95gMrooSVEW0F0akofdANux49GEEEXFdYtNSlBGQmLYccGCmxowq9sjYTbtVCM5+alN5v4RCe4F5+4eItBFUJCmvcMAGcBGs4pcoVyOc0xQtCMGDqJmEIxtuFV6sQjySjAuYRFRF9DWKegfd2epwzUJxupD/lYNqyRHDuLvo0MsZdEEfzrILw/1JGOIZ8meYKwT6beaMtG4HLfGC5lM44pBAk1rvpDTAO5XxcnynNSGF10G7uFK2r8qjykiBq+eGEl8gu66HTbqMbzivnQJbk18wnPdmvKsaYH3kZMPpNe+RaV3BMM89EreJOdR0zRChSTSc54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBG47TCm5ZtH+LOif34wfSwEt5N6JrMRuVS5LW/7O+c=;
 b=o6iPJHgnM7g+MML4qlE9yLoF0jB2eRP8DqMEYpqFVt1rvKfnLT+AJ7qfJj0PGWWSCEyu/q3CCJJhU8692ofKtFcFNViUTVUDNOq3500OwM6UEgFHpUezyCWCPeNiLEjazYtPojkZUBYU60qXDHsQqnsWR+yqzGsgGO14zPu6HnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 02:42:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%7]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 02:42:34 +0000
Message-ID: <727bdbb5-50cd-aebc-72e4-5849ae2c6f3f@amd.com>
Date:   Wed, 1 Mar 2023 20:42:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] platform/x86/amd: pmc: Add a helper for checking
 minimum SMU version
Content-Language: en-US
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230301150821.9791-1-mario.limonciello@amd.com>
 <846d6f46-07ab-4d4a-5623-417a469c3d0b@redhat.com>
 <MN0PR12MB6101781FC5089EA217CA48A9E2AD9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <e4a8f2ef-d6bf-1b14-ddaf-057fcd5abf11@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e4a8f2ef-d6bf-1b14-ddaf-057fcd5abf11@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a45a07-9973-4ae5-0202-08db1ac7c6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wq48mAJS7dp4THRgdAoKdX0yUN4HdZXBCOyIIcNmHbZUJzU5WqIEHcGXLmBQpD/E0Lmibv7iDu4s2mdrfVt3QDbzUVEnPuj+FDlsVcRVX+JmGThrEr7E3zdP5GmwoxEUNLAESmUDvT2OpMd4bX974UgYVUxNGGyuddFlTHCo1FZ4LkZlTf9te9lj6MpibaIIBPEFuLu7opplfaLS8KssH2b5ELyhcXR77CtqVuzjBAwl3TDrLY6IdYNCP0lqD9SlWP2tYqYa5k/+EDd5omKnFHoFkZuJBxuGBu1+bqf3JJTdbyyUE5z77WNpDUVLF8xaJfUAvUvZyoRNW1wKOUuxYne+QkKAK/Lakj9Va2gLe2zHEuamnUxXeIbnmQ7MHRE9fwjsI730DtPNS9CKrOSYzo3gdgmMq930InbWH8h93algT/MDBVbjriWMhRm/AIQO0Uqdx67cN2NYKbiWmUyEIpnTcnEcG3jb3N4q705a+aUQP/IFoudEjD7sR3GHTZ66aL2K51ES0/37ilJkhMtQkeKl79uf5FP/fskGnIps6lcnSUdMiOywUM+Z6hOB60GCAON5eSQ05hpuyF0QqlJmfwKHQOJx/CrDt7IFd/Fbx/xPLBxK5dqOTkG0UkEt9Aupuxu2JI9K3pIc1nbIGXtd+8kqy8/DG7xgfxCEKw+fT5xKHqdGGc5ZgJkyMbr7OB4eNgNoejrK4QBXJpmS+T35gUpNW3QQ3lj8IdnSWz8thhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199018)(8936002)(31686004)(4326008)(41300700001)(8676002)(44832011)(5660300002)(38100700002)(66556008)(66946007)(2616005)(54906003)(36756003)(110136005)(6666004)(31696002)(2906002)(6486002)(66476007)(83380400001)(478600001)(6506007)(6512007)(53546011)(316002)(86362001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1FMMVZKeHV6ZHVXRSsranRKcTNpZ3pvRnJzOG84Vi9uMExRZXp1WUczYzE4?=
 =?utf-8?B?T1dtQzhrRjl3N2M1ZGtVS3FjSG9jcnZQVnVGbFZqVWk1c0xES256Y3V4Ujlk?=
 =?utf-8?B?UXhXSWpIMlVNcHJ6VGgrckRqQ0l1UDNzWDRxRlhkSWljRVNLK1JOaHVZOWFv?=
 =?utf-8?B?QUM4bkM3cDBodWRRM1ZITHgzbHg5YTJ2K1FNRFVYL0JxRE54Z2NMYVNrdlR1?=
 =?utf-8?B?Snpac0ZYTGt0R2JBUlpJWHVQUDlUU3hMUDdySmFzUUg2V0gxQUdBT2dzSEh5?=
 =?utf-8?B?VlVnZC9xUklXL2Q2cHBkaitrQVpTZ1hFUkpYanU2bDA5T2k4bGYwQTJzYmVN?=
 =?utf-8?B?TlF4Vzk3cFdmaldZOW9WYU5pL1JjRWUzQzZuV2dkQ2hVNmg4TzJ1ZVR0SURn?=
 =?utf-8?B?QjFJeHMzdDh5d1BsMyswNWRkVjQ1QWpTM1Qvb3RaWWlNeTJuNUpsUGlSSnNK?=
 =?utf-8?B?Y1VpUS9EOTFkalNScDlaMHc5Qm9VRkpML1FnejF3SlBXWHY5UktYcDRHRDFl?=
 =?utf-8?B?bk81NnIxYkw1Nkl4dm1adk84VHRtUm9BdHVoZGhrQUd0blV5N01VQzRiellz?=
 =?utf-8?B?RzJLRmRVVkw3eTB6eVl3QkhOVC90dmRrck95QzVYRXNXWHZINCtjVXU4aXB0?=
 =?utf-8?B?L1BrZ0FaWVVDcm9OcExDRXFReU12S0UvZXRuaEkwM2J2YmhVcmNEMEZjVUJm?=
 =?utf-8?B?cXMyWXIvYW0rZHhVNTVtcGcvdEE5NmZWcGF2ZmpyZkFaTVM3czFzcXZpc0cr?=
 =?utf-8?B?LysySWN3S0JhR05tdS9mc2ExK0ZubVV3U2xWNllpYUJxQmEvcnY2SHVTUVh0?=
 =?utf-8?B?dGRpUlVUNHpvZ2hTTEhpY0NJNndJVWpQenpNVERoNFAvSXdnUG56UTJGWmZu?=
 =?utf-8?B?bElzejBscklUREZrYUFyL0pHUVdpaGx1eG95Z3psZjBscDZabnJ2TUF5OTRU?=
 =?utf-8?B?Nk13MXRpbW43K1kzSlNqR1dka3ozL1FDOXdnbzZwK2MrVVFlUlZKaTkrazYy?=
 =?utf-8?B?cUhwK1hqR21ZZk9pODFVYWEwcGhFUERwaWQyOGhRZ1RmV3pJVGdBcjNlWWZ6?=
 =?utf-8?B?REliOVFlek1DUUV1aWFKSFJYVjZpTUttdzNsZVNsMitPSVhLZ1VyRWVXZlZs?=
 =?utf-8?B?M1VmbGF4VG5YSTNxMHhtd0JXMC95azZLZlB6b3BwUFkrZ3ZtWXp4MVBjdlRQ?=
 =?utf-8?B?RXZjY2FpbnQzNy9QQVVLaERzS2czbnMyczlEUzdjNjJuSU9URE04Z0Vib1VS?=
 =?utf-8?B?dlhIVElYUjNqTUUrUnV0enVNSDRmYkFHdjhDbDUwMG5oUlFzUk4zcWhWQllD?=
 =?utf-8?B?NG1VOTBhL0t3R2pRb0ZpTkRsSFZlc0NIMndrREZVSThvdlE0emE2UXlBYkkv?=
 =?utf-8?B?UGZ4aGFQT1N6M1AxUmZ5dVVQd2RKQmJERlpOQlorMTUzdzdFU2N5TC9HV1pE?=
 =?utf-8?B?N1lsT1lMVFZGMkZvK0VHejNOMDFiSVZxTklweDdRWWdOcHdNcERhd3JrUXNv?=
 =?utf-8?B?ZXZXMDVrSWVXelZHN00wRGlPV09zUVlTKytUMXRBcEVUV2NiZ21YSE1WYVY2?=
 =?utf-8?B?R25McXRubG9ZNWljRFdjWHNxS0ZKREVRSnBXY0pTU1pteFVIcTh2R0hFS0Jj?=
 =?utf-8?B?L3ZkczRWVkFvaXNmNytRUnJEL0RzWW01Qk5ESlovOUZaNEdZdjU5eUhtSjRN?=
 =?utf-8?B?aEM3Q2lJcVJCSktFRkRDT2JkSlN2NmFxVUE2VTdyYTcvVEJFcG91WVJmOS9r?=
 =?utf-8?B?c1pma3JpYkFzd240Y3FQWHJVOGlyODVIVEV3WW1MbmsyTHEwRlhwZ1prS3Ev?=
 =?utf-8?B?TW9GWkRwUjVPVU4rQUFtRWtrdWl0RlVDeEd5OUJ6NldGNzVFV1l2ZVVzMzgw?=
 =?utf-8?B?OWxoMGtEL1pEbDBuYmMzeVI2QUtpaVdqUlBhcnh0eUFmSjZQRnJoSEdlYURy?=
 =?utf-8?B?MlRENndCdExjdWw0Q2o2Qlo0Q2NwZkhXeVdRQk9saW1YN3pnNUNiTGE2cUNZ?=
 =?utf-8?B?Um5yS05jL1VWbzk5SVA1ZG1xOGxZdDh1cUxwMCtxeWFGY0c5SDZ3eGFpQUxo?=
 =?utf-8?B?OTJHL2R2Rk45OHBIZDZ5MGRMV1ZvWkE5V3ZyZlRIcnNIV2MyUWJhekMvTHJw?=
 =?utf-8?B?Njh6VXFGWDJ1WkNsd0ZkaDhWZk0wMmNlK1YwNlRHRUZ5UzZNUHFTRTJlM3dq?=
 =?utf-8?Q?gj4pZOGC5r3aFg0s3wkTWBPjZbX97YO8y7qzeE5qQFQI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a45a07-9973-4ae5-0202-08db1ac7c6a3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 02:42:33.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPSPEcykSvTJBWWDWnssWrNWk5P6yFRYTit7G7g6IrOf/V1m9ylkodMW3nzsUSVhQ+PEyjWDrgJhCj3ukfs41A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 20:39, Shyam Sundar S K wrote:
> Hi Mario,
> 
> On 3/1/2023 9:01 PM, Limonciello, Mario wrote:
>> [Public]
>>
>>
>>
>>> -----Original Message-----
>>> From: Hans de Goede <hdegoede@redhat.com>
>>> Sent: Wednesday, March 1, 2023 09:28
>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; S-k, Shyam-sundar
>>> <Shyam-sundar.S-k@amd.com>
>>> Cc: Mark Gross <markgross@kernel.org>; platform-driver-
>>> x86@vger.kernel.org; linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH 1/2] platform/x86/amd: pmc: Add a helper for checking
>>> minimum SMU version
>>>
>>> Hi,
>>>
>>> On 3/1/23 16:08, Mario Limonciello wrote:
>>>> In a few locations there is some boilerplate code for checking
>>>> minimum SMU version.  Switch this to a helper for this check.
>>>>
>>>> No intended functional changes.
>>>>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>   drivers/platform/x86/amd/pmc.c | 49 +++++++++++++++++-----------------
>>>>   1 file changed, 24 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/amd/pmc.c
>>> b/drivers/platform/x86/amd/pmc.c
>>>> index 2edaae04a691..c42fa47381c3 100644
>>>> --- a/drivers/platform/x86/amd/pmc.c
>>>> +++ b/drivers/platform/x86/amd/pmc.c
>>>> @@ -418,6 +418,22 @@ static int amd_pmc_get_smu_version(struct
>>> amd_pmc_dev *dev)
>>>>   	return 0;
>>>>   }
>>>>
>>>> +static bool amd_pmc_verify_min_version(struct amd_pmc_dev *pdev,
>>> int major, int minor)
>>>> +{
>>>> +	if (!pdev->major) {
>>>> +		int rc = amd_pmc_get_smu_version(pdev);
>>>> +
>>>> +		if (rc) {
>>>> +			dev_warn(pdev->dev, "failed to read SMU version:
>>> %d\n", rc);
>>>> +			return false;
>>>> +		}
>>>> +	}
>>>> +	if (pdev->major > major)
>>>> +		return true;
>>>> +
>>>> +	return pdev->major == major && pdev->minor >= minor;
>>>> +}
>>>> +
>>>>   static ssize_t smu_fw_version_show(struct device *d, struct
>>> device_attribute *attr,
>>>>   				   char *buf)
>>>>   {
>>>> @@ -526,14 +542,7 @@ static int amd_pmc_idlemask_show(struct seq_file
>>> *s, void *unused)
>>>>   	struct amd_pmc_dev *dev = s->private;
>>>>   	int rc;
>>>>
>>>> -	/* we haven't yet read SMU version */
>>>> -	if (!dev->major) {
>>>> -		rc = amd_pmc_get_smu_version(dev);
>>>> -		if (rc)
>>>> -			return rc;
>>>> -	}
>>>> -
>>>> -	if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
>>>
>>> The 2 major checks here originally were not in sync, so for major == 55
>>> *and* major == 56 it would only succeed if minor >= 37.
>>>
>>> Where as after this patch for major == 56 it will now always succeed.
>>>
>>> This feels like a bug in the original code, but might have been
>>> intentional ? Please verify this.
>>
>> @S-k, Shyam-sundar as the original author of that, can you please confirm?
> 
> I cannot completely recall :-) It was something like if the major
> version is greater than 56, there is no need to check the other part of
> the "OR".
> 
> which is kind of similar to what you are now doing in
> amd_pmc_verify_min_version().

OK yeah, then I'll split this correction of the logic off to that in a 
separate patch to make this one "really no intended functional changes".

> 
> Like we discussed off-list, we should have this boilerplate in place, so
> that the future checks would not be duplicated.

Something else I noticed that we probably need to consider is that there
is no examination for the "program" version which may be important.

We don't have any version checks for YC, but if we did for example YC A0 
and YC B0 use program "0" or program "4" respectively so version checks 
could fall over.

I'll add something like this in for v2 of the patch as well.

> 
> Thanks,
> Shyam
> 
>>
>>>
>>> After verifying please post a v2 updating the commit message to
>>> point out this functional change.
>>>
>>
>> Sure, thanks.
>>
>>>> +	if (amd_pmc_verify_min_version(dev, 55, 37)) {
>>>>   		rc = amd_pmc_idlemask_read(dev, NULL, s);
>>>>   		if (rc)
>>>>   			return rc;
>>>> @@ -686,15 +695,8 @@ static int amd_pmc_get_os_hint(struct
>>> amd_pmc_dev *dev)
>>>>   static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
>>>>   {
>>>>   	struct device *d;
>>>> -	int rc;
>>>>
>>>> -	if (!pdev->major) {
>>>> -		rc = amd_pmc_get_smu_version(pdev);
>>>> -		if (rc)
>>>> -			return rc;
>>>> -	}
>>>> -
>>>> -	if (pdev->major > 64 || (pdev->major == 64 && pdev->minor > 65))
>>>> +	if (amd_pmc_verify_min_version(pdev, 64, 66))
>>>>   		return 0;
>>>>
>>>>   	d = bus_find_device_by_name(&serio_bus, NULL, "serio0");
>>>> @@ -718,14 +720,10 @@ static int amd_pmc_verify_czn_rtc(struct
>>> amd_pmc_dev *pdev, u32 *arg)
>>>>   	struct rtc_time tm;
>>>>   	int rc;
>>>>
>>>> -	/* we haven't yet read SMU version */
>>>> -	if (!pdev->major) {
>>>> -		rc = amd_pmc_get_smu_version(pdev);
>>>> -		if (rc)
>>>> -			return rc;
>>>> -	}
>>>> +	if (disable_workarounds)
>>>> +		return 0;
>>>>
>>>> -	if (pdev->major < 64 || (pdev->major == 64 && pdev->minor < 53))
>>>> +	if (!amd_pmc_verify_min_version(pdev, 64, 53))
>>>>   		return 0;
>>>>
>>>>   	rtc_device = rtc_class_open("rtc0");
>>>> @@ -772,13 +770,14 @@ static void amd_pmc_s2idle_prepare(void)
>>>>   	/* Reset and Start SMU logging - to monitor the s0i3 stats */
>>>>   	amd_pmc_setup_smu_logging(pdev);
>>>>
>>>> -	/* Activate CZN specific platform bug workarounds */
>>>> -	if (pdev->cpu_id == AMD_CPU_ID_CZN && !disable_workarounds) {
>>>> +	switch (pdev->cpu_id) {
>>>> +	case AMD_CPU_ID_CZN:
>>>>   		rc = amd_pmc_verify_czn_rtc(pdev, &arg);
>>>>   		if (rc) {
>>>>   			dev_err(pdev->dev, "failed to set RTC: %d\n", rc);
>>>>   			return;
>>>>   		}
>>>> +		break;
>>>>   	}
>>>>
>>>>   	msg = amd_pmc_get_os_hint(pdev);
>>>
>>>
>>> Patch 2/2 looks good to me.
>>>
>>> Should I queue v2 (once posted) up as a fix for 6.3-rc#  ?
>>
>> Yes please.  If it makes it easier I can re-order the series so that
>> we add a check in 1/2 and switch to the helper as 2/2.
>>
>> This might make it easier to take the LTS kernel too for stable,
>> but I don't feel strongly.
>>
>>>
>>> Regards,
>>>
>>> Hans

