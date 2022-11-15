Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C6E629BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiKOONV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiKOONR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:13:17 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139735F75;
        Tue, 15 Nov 2022 06:13:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYJw0k/ZnsFayfWfgATJXEuf0TcDfehn1+ifl1vj1/F0T2siwHLzmfHh1n+us+OUEq3bc+jFEqnz9dyQyXmudRVezLbXFzGH7tBjuF8Si7ZLABmAEXC4vFFX+RoocflG+pejDLNP+lOrX01GOsJeP4EMkiHOREqUNVdto4JlPxvYIOK7Wcqzy7dz8jIr/pF5UnesitaiakWPIdIIRnmDXS57DdOWC3pywgcfOfeeXE0OOfzgSUwletCaFOkEDfzykvSGzuGRjKHHJ6vp8wCrI/9iNmF1oDVnHzGjX4/fNHjwG2ZkcbLoFdi1XJ7mtd6NfHIo+e6xB0lwKzdQe2RKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTn1q4WYqwhsJJMOfSqZfHQq2UoMySdQs0udGVV/hu0=;
 b=RRwBxBFkEyLWhVajKIzBKebni0g3xBZnBrJIG/F7XhDapFHNyyWs+DtzdfN7PTeEwflbJ/aaiOJQcTDIkkC2o1Lbgc2uysGmeqqjezssD9ZSFSgdy62DhM5LNVWS86VPqKTxQQaVRJxFnEmCcDmueaR9pnnvKavutHV8PfqVraxUz1U1AL+KG/t18TKXxRbHZqkTw+Ps0mUvOUPvObSPiypeFm303BHgdYCO9J1iSJ9FxoabhfD4XXQYsaAl1NZ478xXVL5FnFkfh4y5g9r3BBMPP+ctxZWTVNYiJnYQU9ZPyQhoAU8N2afrCvO2T66DICQHLjmbfGSWbhqgbcXR/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTn1q4WYqwhsJJMOfSqZfHQq2UoMySdQs0udGVV/hu0=;
 b=rbry8WrnTfcm8xOdqaTDklh8/hrFtYyKtfkdCaG4Tbi29SDX8E2sWmLbNU6oyGsZObtIqHthOJ5RMBpa6Ex2YYxFeKlkFJmCXaD2N+Vzd9M5J3YKan1sweMhOz/OAvexjs8VAjQV7KzGdkuOdlJvECk6fdPXEDCqnI37fK49Ct0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 14:13:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 14:13:13 +0000
Message-ID: <cb3886e5-7005-ffd4-28a2-8258a1473ea4@amd.com>
Date:   Tue, 15 Nov 2022 08:13:07 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC v2 1/3] PM: Add a sysfs files to represent sleep duration
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221110064723.8882-1-mario.limonciello@amd.com>
 <20221110064723.8882-2-mario.limonciello@amd.com> <871qq6tnqx.ffs@tglx>
 <MN0PR12MB6101BB92574BEF0A0AE2AB11E2059@MN0PR12MB6101.namprd12.prod.outlook.com>
 <f1bff724-252c-e403-f02b-2fff49b2283f@redhat.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <f1bff724-252c-e403-f02b-2fff49b2283f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0005.namprd18.prod.outlook.com
 (2603:10b6:610:4f::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d7c33a-529d-4f53-a219-08dac713879e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ugcjrwv/L8k4/AqOYx1ALIcXYi1ja3q8SXAUWy+KQa2JCFsT1K/timhkkUtNEIVqv5N66rxaAerd98gUAiyk4Gmpz2GOVHndWVG7pgiXg4Rb6riYFfibzLN3DnWtAYwIueflEa2V/LichCXstI1K2piPTpwbggCjY8cuTeUSQTeRRjLFKYvXxPvJRAB0sMucRDaOD9AMlfK/tLaWHliGUdd7i8VNSauJp8wNB6y2iQzyH32j0rDWQWdUNWiXURZZvywMZZpneal5bt0K+n57YYxPBUt2BtOHObSrJejsuDwcrQn/4go24YbZZpD3S8B91PUn9Ti+afz3K0zVk2Ayn0HmaAFH8zpa5h7yJ/6UUIC6+WyEpoZHMZ6CxfI2zNDcCnj2UaGLh18NIDIwzD2a6GFIGSCOnO0/vypntj3TA4EuXZrTR/3dVy3UQwg38RZBt7bXjmDAvsZadMWzXqdQ2LpJ+1fOrsPEvIo/dAgN+9WYM+4SX6KJdqK5ofJCV54Hj/9wz1hKwzqAE7gouaCD7k3Zy4wi1/7hZNJVog0ZpxP0n1gRTK5BtTKFcU2EmypkiZ++BfAeNEMTB/R1ucUoR65sh80q9DIxYSpJ011QMqIOAv9sVUD3ZlHHBaRXBas9idFZcksdDUkwyE+Sq595duZEfcM4TVfHKUe4tZMjDTTp1ukwlSkbxr7l4arG6sgNRY0shmfct/QMWdbJttYfDbpbwYmuFvfNQQQSgnipTptaPFh8zgwBCTwy3Z/4gr3HoJ0dNg4n+WD524/zKRi7J2N/yykuOtMVK1kYctYVQGGSAML58QRIw4osdYZWAug1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(66556008)(66476007)(8676002)(66946007)(4326008)(83380400001)(36756003)(7416002)(8936002)(41300700001)(5660300002)(921005)(53546011)(2616005)(6486002)(26005)(186003)(6666004)(6512007)(86362001)(54906003)(478600001)(110136005)(31696002)(316002)(6506007)(38100700002)(66899015)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlRmOGx4Y2RHc0EyQmFkVDg4QmtNN1pTZ1lhS1ZJajZETUQxeHQ2Nk04cWhu?=
 =?utf-8?B?Z2VYeE5WbnpBR2k2cFNNR2xCak1TSzFOejVYdlhCSFgwR0szU3FGMGx6NWZu?=
 =?utf-8?B?Um9JUlpoRTdpODljYkJuTW1lY0I4YjJsc08ydXdSL1lOTEprYzZWZ2pGTTFX?=
 =?utf-8?B?MXdhbHltU255dU9rSmZoYjR2YTRkVkZFUHpxOE13cjR0dEFiVnZnUDZnTmJp?=
 =?utf-8?B?bDdoT0NHeGl6UitOR1dXc2xrcW02U1pEV0ZRQ2ZEY2hhOWd0VDBKMjJaVHB6?=
 =?utf-8?B?L25TUHRMTzEzUzE4TWVyVVFRUGxVUGthMTMzamRuaFpvSTc1YkdlSmJkMkMx?=
 =?utf-8?B?R2FRZFcvR3k0WGVpOVJuQmgvaVA5dThRYTIrSC9VcGo0NnNueWV2ZzVKUUdu?=
 =?utf-8?B?RFVoSTlESnRGRk5zUlFkNXdXUHA4OHNmc1FDRkhubnpyTjNVWm9FeUNDeC84?=
 =?utf-8?B?MXZPWTBYY1BwMmM4NndwUTlrTWEvTGFwYlZneVlmL3BHem9PUGF6UHNhdm4r?=
 =?utf-8?B?cFVMRllNNUJ4UU90R1JRWXRDMzN6TUhqSGx3NEJqUmk3eDNjODNUTTR0WTBx?=
 =?utf-8?B?bHdocjU2UlliVnlvV0ErNlhMZFNJWVF0d3BCMTkvUXVsTUp0YjNLM1pDSTFG?=
 =?utf-8?B?Y3kxaEJRNndCVm8rRCtRK3VRc1plRERKbVRiaXRWUHBwM3A5d0ZFT1JNVTh0?=
 =?utf-8?B?bE9BdURCTjl4V0hYdGNuUlNZSzhvbllCR0l6NVBySzFLQ2xsczRub0xEQWoz?=
 =?utf-8?B?QWpaaDJXbk5oQ2FPTmRtak0xZHk5cHd5SG9CKzNkcTZyQnJQS1duT0Zmb2tu?=
 =?utf-8?B?UTR5eUN1SThUUmxnNVkxeWVPZzJmazM1V2NaZmJWUkRFaENMVE9Ud0tveG5s?=
 =?utf-8?B?a3ViWUdYb0s4cUJka0tJL2tieERhcXBtM3FGcHdiUkF3Y0UyTWVJNUFLczRv?=
 =?utf-8?B?NzgzRGNQQWZCTGJmM1o1OVc5emoyNWY2NHJNNG1DTWQzZEIvYi9vdEtBTU5G?=
 =?utf-8?B?V2lJbERia2I5Wkx5dnVIWVRTM1crQ0RSeXo2MEdYMDBXOGExZDh2b2NBV1ZR?=
 =?utf-8?B?NzU1YjljSU5MLzR5SkRKUW54c250cm1uN2Q2SVNFRDUyWkgwb3ZNakRJVlIr?=
 =?utf-8?B?V1VRK0Y3WFhIMmhZWlFRcy96MGxuejNwUHZNK0xSZEk3NDhQYzR3MmszNGpy?=
 =?utf-8?B?QTRQN1F2VmFaNkJhbkZlSFZsY0l2MDVmNFhqWFVSVmJXSUthSkdPbTltYVJM?=
 =?utf-8?B?b0JlOElzY0FVaEFUN1BzamZlUXZtNW1YaXNnNVBYcXJNL1lLdndidVpCYU5a?=
 =?utf-8?B?a1BCN3hNOTZ3YVdsOTJqdGwwZXd6SU9mTFNFN2d0dEdiS05tcEN0MXgveDY0?=
 =?utf-8?B?YWNvVk8yME5HQWtqdzExVFJEZk1xVmVFOGRkYUhmRHdkMWtBTWhNc2NjekNj?=
 =?utf-8?B?TmJFd2pnbDhHQ2FiTDNLS3JreWp4U1pSK0xDOTBxeUtCSDhKQ21VWnYrWnNE?=
 =?utf-8?B?UmkrRU03dmpiNFNJN3hPR3krMktwQlRGSVIxQ1N1S21rN0R4bnpDMUJsWXQz?=
 =?utf-8?B?OWM3YTU0N1ovYzUzRk9VNER1cUtuOGltNm1LSFFqYkhGdEU5KzZ5Z09QQStm?=
 =?utf-8?B?akJtYS8rWGx3SUpsMmVwbXFOMFljcTQrRXFXU2szZ1VCSERtU0xwTGpDa0Nr?=
 =?utf-8?B?dGJsSXM4dWMyeGVxbmNtR0lpOXRjQy9QazBEcnFBMVdtUTZpS2FKUXRSUDBI?=
 =?utf-8?B?Wi9IVTVwUGdKaGtleS9yTFJhSldvYW1uZHBCRnJia0tyNGZod1NYNnZWZVpE?=
 =?utf-8?B?T1VBUnFKN0wzdHdpNEd2N3pNNG9YVUxuRk1nbHhBcDN5Wkw3UGl2QzdoZXc0?=
 =?utf-8?B?MXFvRFRyck14aVVlMzhsWlpzRlBNNkM2ZnozSkk2ZjB1VG5obk8rREVIQTNJ?=
 =?utf-8?B?SEV5Qit3ZndURisyeTBma0ladGh2eDE3SWUveFVPcDFGUEkzYzhSUnB4NEdR?=
 =?utf-8?B?UENTVW1WNjFkNEJsNWlKVGdiTW9mNkw1TEtYZTZ6RnR4Q2xMa3VxYTB0UGpk?=
 =?utf-8?B?Nmh3Q3JSejYwS0RHdjBzTVF5RWZhM0dabEFreGRHVHpVeXoxcTc0ZzFKTjJw?=
 =?utf-8?Q?NOs6XW6S5n5SUw7GxIM/OjSPg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d7c33a-529d-4f53-a219-08dac713879e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 14:13:13.4670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZkSMP6UyYP+FHompV3j8vaShH1y7nCE6KpqZzs0piWa1MpiIYZqKf+HO9UaA3mMTG40SgKQGAOFPVYeixuZ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/2022 04:32, Hans de Goede wrote:
> Hi Mario,
> 
> On 11/14/22 20:12, Limonciello, Mario wrote:
>> [Public]
>>
>> Thanks! Appreciate the comments.
>> At least conceptually is there agreement to this idea for the two sysfs files
>> and userspace can use them to do this comparison?
> 
> First of all let me say that I think that having some generic mechanism
> which allows userspace to check if deep enough sleep-state were reached
> is a good idea.  And thank you for working on this!
> 

Sure!

> I wonder though if it would not be better to have some mechanism
> where a list of sleep states + time spend in each time is printed ?
> 
> E.g. I know that on Intel Bay Trail and Cherry Trail devices (just an
> example I'm familiar with) there are S0i0 - S0i3 and we really want
> to reach S0i3 during suspend.
> 
> Sometimes on S0i1 or S0i2 is reached due to some part of the hw
> not getting suspended properly.
> 
> So then we have reached "a hardware sleep state over s2idle"
> but no the one we want.

At least the way it's built right now it's tracking the s0ix counter for 
Intel and the s0i3 counter for AMD.

BTW - when I did all the cleanups suggested in RFC v2 I notice I was 
taking the raw number for Intel, and I have that fixed for the next version.

I don't know if other counters exist for Intel for various hardware states.
On the current AMD silicon this is the interesting metric.

> 
> OTOH I can image that if we start adding support for functionality
> like standby-connect under Linux that then we may not always
> reach the deepest hw sleep-state.

Can you elaborate what you mean by standby connect?  WoWLAN?
At least on the current AMD platforms WoWLAN can happen while the 
silicon is in the deepest hardware sleep state.

> 
> So I'm a bit worried that having just a single number for
> last_hw_state_residency is not enough.
> 
> I think that it might be better to have a mechanism to set
> a set of names for hw-states (once) and then set the residency
> per state (*) after resume and have the sysfs file print
> the entire list. >
> This list could then also always include the total suspend time,
> also avoiding the need for a second sysfs file and we could also
> use the same format for non s2idle suspend having it print
> only the total suspend time when no hw-state names are set.

So is your thought is to have a single sysfs file something like 
/sys/power/suspend_stats/s2idle_stats that would show this?

state \t % \t duration (us)
s0i3  \t 99.5% \t 1000

For AMD that would be a single line and I don't think it's worth the 
extra code.  I would like to know if it actually makes sense for Intel 
though.

We also need to think about what will be actionable with this 
information by consumers of it because I'm certain it will be leading to 
bug reports.

Let's think about a hypothetical bug report:
"Intel System only spent 20% of time in deepest hardware state".
They attach to the bug report s2idle_stats that looks like this:

state \t % \t duration (us)
s0i2  \t 80.0% \t 1000000
s0i3  \t 20.0% \t 100000

Is that any more actionable than
/sys/power/last_hw_state_residency showing 100000
and
/sys/power/suspend_total showing 500000

I think in either case the next action is more debugging will be needed, 
such as turning on dynamic debug or some module parameters.

"Practically" I expect software like systemd or powerd to be reading 
these sysfs files.

> 
> Regards,
> 
> Hans
> 
> 
> *) Using an array, so up to MAX_HW_RESIDENCY_STATES
> 
> 
>>
>> A few nested replies below, but I'll clean it up for
>> RFC v3 or submit as PATCH v1 if there is conceptual alignment before then.
>>
>>> On Thu, Nov 10 2022 at 00:47, Mario Limonciello wrote:
>>>
>>> 'Add a sysfs files'?
>>>
>>> Can you please decide whether that's 'a file' or 'multiple files'?
>>
>> Yup thanks; bad find and replace in the commit message when I added
>> the second file.
>>
>>>
>>>> Both AMD and Intel SoCs have a concept of reporting whether the
>>> hardware
>>>> reached a hardware sleep state over s2idle as well as how much
>>>> time was spent in such a state.
>>>
>>> Nice, but ...
>>>
>>>> This information is valuable to both chip designers and system designers
>>>> as it helps to identify when there are problems with power consumption
>>>> over an s2idle cycle.
>>>>
>>>> To make the information discoverable, create a new sysfs file and a symbol
>>>> that drivers from supported manufacturers can use to advertise this
>>>> information. This file will only be exported when the system supports low
>>>> power idle in the ACPI table.
>>>>
>>>> In order to effectively use this information you will ideally want to
>>>> compare against the total duration of sleep, so export a second sysfs file
>>>> that will show total time. This file will be exported on all systems and
>>>> used both for s2idle and s3.
>>>
>>> The above is incomprehensible word salad. Can you come up with some
>>> coherent explanation of what you are trying to achieve please?
>>>
>>>> +void pm_set_hw_state_residency(u64 duration)
>>>> +{
>>>> +	suspend_stats.last_hw_state_residency = duration;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pm_set_hw_state_residency);
>>>> +
>>>> +void pm_account_suspend_type(const struct timespec64 *t)
>>>> +{
>>>> +	suspend_stats.last_suspend_total += (s64)t->tv_sec *
>>> USEC_PER_SEC +
>>>> +						 t->tv_nsec /
>>> NSEC_PER_USEC;
>>>
>>> Conversion functions for timespecs to scalar nanoseconds exist for a
>>> reason. Why does this need special treatment and open code it?
>>
>> Will fixup to use conversion functions.
>>
>>>
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pm_account_suspend_type);
>>>
>>> So none of these functions has any kind of documentation. kernel-doc
>>> exists for a reason especially for exported functions.
>>>
>>> That said, what's the justification to export any of these functions at
>>> all? AFAICT pm_account_suspend_type() is only used by builtin code...
>>
>> I think you're right; they shouldn't export; will fix.
>>
>>>
>>>> +static umode_t suspend_attr_is_visible(struct kobject *kobj, struct
>>> attribute *attr, int idx)
>>>> +{
>>>> +	if (attr != &last_hw_state_residency.attr)
>>>> +		return 0444;
>>>> +#ifdef CONFIG_ACPI
>>>> +	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
>>>> +		return 0444;
>>>> +#endif
>>>> +	return 0;
>>>> +}
>>>> +
>>>>   static const struct attribute_group suspend_attr_group = {
>>>>   	.name = "suspend_stats",
>>>>   	.attrs = suspend_attrs,
>>>> +	.is_visible = suspend_attr_is_visible,
>>>
>>> How is this change related to the changelog above? We are not hiding
>>> subtle changes to the existing code in some conglomorate patch. See
>>> Documentation/process/...
>>
>> It was from feedback from RFC v1 from David Box that this file should only
>> be visible when s2idle is supported on the hardware.  Will adjust commit
>> message to make it clearer.
>>
>>>
>>>> --- a/kernel/time/timekeeping.c
>>>> +++ b/kernel/time/timekeeping.c
>>>> @@ -24,6 +24,7 @@
>>>>   #include <linux/compiler.h>
>>>>   #include <linux/audit.h>
>>>>   #include <linux/random.h>
>>>> +#include <linux/suspend.h>
>>>>
>>>>   #include "tick-internal.h"
>>>>   #include "ntp_internal.h"
>>>> @@ -1698,6 +1699,7 @@ static void
>>> __timekeeping_inject_sleeptime(struct timekeeper *tk,
>>>>   	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic,
>>> *delta));
>>>>   	tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
>>>>   	tk_debug_account_sleep_time(delta);
>>>> +	pm_account_suspend_type(delta);
>>>
>>> That function name is really self explaining - NOT !
>>>
>>>       pm_account_suspend_type(delta);
>>>
>>> So this will account a suspend type depending on the time spent in
>>> suspend, right?
>>>
>>> It's totally obvious that the suspend type (whatever it is) depends on
>>> the time delta argument... especially when the function at hand has
>>> absolutely nothing to do with a type:
>>>
>>
>> I fat fingered this.  In my mind I thought I wrote pm_account_suspend_time()
>> Will fix.
>>
>>>> +void pm_account_suspend_type(const struct timespec64 *t)
>>>> +{
>>>> +	suspend_stats.last_suspend_total += (s64)t->tv_sec *
>>> USEC_PER_SEC +
>>>> +						 t->tv_nsec /
>>> NSEC_PER_USEC;
>>>> +}
>>>
>>> Sigh....
>>>
>>> Thanks,
>>>
>>>          tglx
>>
> 

