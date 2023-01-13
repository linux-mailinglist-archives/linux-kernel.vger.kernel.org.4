Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8126694F4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241175AbjAMLDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbjAMLCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:02:38 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA96E82F5B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:55:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMPwvJpCw8UWKai+yUBPtrtRmtmm3ghbc45vRJeIrjHsOgK2kMuFOX+j1lQP/4KgjmmtpFbu3IKE8VKOnYLy3Un8OrrRZLa0jsZ33pcCpyDcN7D88tqB30a+v+YYeCOIxq7dYWJaOwVNzxFSd99jCBs9Ck0uqOZuSTI7boEKSH3jiZTO8ZDHflXwGoYUVuJA3ZLbqqFHHh7Vm0bDe+DtyN4WJaZ2wg/okArd8JpwVfVrNwYkE//TarYdnfIS7neshKFC+RR7QAUyqKqZyfB/soJxO6o/3QTzI9qpflV4dlzZMAybC+ohcy9lDvvCHkMCc+6r3/WSHHcI/4g5ogU5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nkgeobzWuui53LLIzZEGabaqoHenkpGvSE/b9Bdib0=;
 b=ZyMhEJuIl3XQEIQJMUWkCqOBt8gKun2mI9JFeT6fOJGh4pZ1Cgtbdc3Go0t8+uftc3hSAC4PsH44NV5igiHpZJmGH/cppb29iQyZUO+ykNMq2SxDr8XCp95/LPhXcbHy03TcPr8RsYx5POIgAqJY9KubwMT7Bdl0eDkivYWwWeaCeJMLsWhuTD3vnhoCnJbcHamnme8ve2zL5MaD1HSTUs+SgACx4q3FjpovWhzCJvHwWQ1OMh1eGjJl0auU7NYEm44FWBi5Ibtip9IGN6UZQrxV6eXLJxqlPtD5MSF5jdZD8srmr3cbrAwfP3g0ixBn3JhBugUzvvUBra9UL+xw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nkgeobzWuui53LLIzZEGabaqoHenkpGvSE/b9Bdib0=;
 b=h0fcdF60m5bu0iBKopVSmCv/dRZ29IzsA/4/VnUU/DdLiniG7EJ+eXcvtgVdsu5fuLn+PgrYleVtX2F7XXtoId0MT4N4xyNEm7qvsJUS6UA/cK1dVI83XAZI+2gQMoV47cYuDlnp1UbpJ/ihrsTW9Hf+OhjaiIe97eHYTheML/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 10:54:56 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%5]) with mapi id 15.20.5986.019; Fri, 13 Jan 2023
 10:54:56 +0000
Message-ID: <90782037-109b-b197-ca17-b7d199931f7d@amd.com>
Date:   Fri, 13 Jan 2023 16:28:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 19/19] ASoC: amd: ps: increase runtime suspend delay
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        arungopal.kondaveeti@amd.com
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-20-Vijendar.Mukunda@amd.com>
 <c7f018e3-c8be-6819-0ece-244bfb943c62@linux.intel.com>
 <0aaf3fa5-bcf1-ec06-8f78-c61e8809398e@amd.com>
 <5a34e6f7-eaf1-8128-81e4-81f65541d9a8@linux.intel.com>
 <1a14e117-4216-b98d-f972-c9a02cf79d1e@amd.com>
 <eb12ed5d-a9f9-cb8d-28f5-ac84c75cf441@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <eb12ed5d-a9f9-cb8d-28f5-ac84c75cf441@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::25) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a460d6-9a4e-4215-a7bf-08daf5549b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvHltx2RauZOkkFIthAKKyBMZ0uRpM9ULdHQ8bvJrR59lX+Xcuf8QlHuLS1lXy4Xc+uELqBxbfV9EHj9IxbD3jCsTZL3IwZRZ54OzEFodO/WGGWrFHnU0hOgouBnSK/PDrwe+W6URCDjH2KH8qmOY8A0Yq4ZsBvChr2SXh9oR9klZtjO0TxB98DsIPmLyedoi1gzSY5+t4NLF64YHPB1gzj0Zp2Sls0Sn+Wh1JY/hUFMO30VSy66YGgaYEOmHMGj0pdf4JNXCIrcG8wUjLY7MUlfNJ4hEJhNmNTYvKSuxVOIBOGjTP3RPhvaEcSRxP/blvtQLZX/RxPr42PYxvRcKqXDYfhctt5mAcNaeCnJuHxee1emJWICwmrrRxHNxPsXEvfy8if6F646SCZmQZ3Y7+F345uSZ/ns5S6bh1lfX1VsHejpJtTTz47dW8N8e48wwsZpKuboWdMIaMuLZOW+5Y9dF2yxnlPU1N06uVbyF2CfaT2LxRmtYluLlFp5KEqFFdHQeuwEAWuVosdeRt1dl4ULwtAhgbC/BSkUXey9I7o8keorByhjbF4/StrmYexUIE2+di3PPP33dhNFdWpNg+VzetBjanJBPaN1qgD8qKm001G0lj19SX5GhQ74RfZyjMtVVJGWY985D84HGkdJuLuTL07H3GPpqftj9lzONHR+KzHQI4L31VkkF+tU9aqE5RdOnfgAjLtVMRPhd3IgbYbN0Ic8FnGA+I2iL27HAo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(53546011)(6666004)(26005)(186003)(66476007)(54906003)(66556008)(8676002)(6506007)(6486002)(6512007)(478600001)(66946007)(66899015)(4326008)(83380400001)(41300700001)(5660300002)(8936002)(15650500001)(2906002)(36756003)(2616005)(38100700002)(31686004)(31696002)(316002)(110136005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEVZUFlyTEFaWWV0ZkNUNWlYNEtGWGtrOE9TdDIyUEV5VEJzQ3VRMW54aFhH?=
 =?utf-8?B?d1ZuQ3FPRXVJV0F1andYSFNjNFNHbHV1NGtHbTI5UTZCbW1FcFdyQjQvUUw5?=
 =?utf-8?B?d0wzRDZGTmw5TVh6Q25GZ29ZVmc4S2RRZTRjZk5sT3UyRWxMSkt3dHk1NVh1?=
 =?utf-8?B?UGdOc01yaURhSTNlKzFNa2FpZGlKb3dZNUlRRDRHSVY4UE9KQXoySTlCVUZp?=
 =?utf-8?B?ajM2N3FzNDYveTduaFg0WThtS29ZbCtmL2YwS3Y0aUNjalVCSlZKZFNOZG9N?=
 =?utf-8?B?eWdxSEhjMEpNQnNJWEZraWNCUDU4K3QvM0tianZVaTc4bkQwdVJ1ekFlZWw5?=
 =?utf-8?B?UGNZL1lsSVl0R1FMVWhOYnZIM0V5dSthME5lUXVIQzEzZ0F2R3crYjY1Mkp6?=
 =?utf-8?B?bzA4RC9TM2hJRXVYc1lGQ3FFWXpXeFh3U1NlL2k3VUh5QzA1Kzlnc1dOYnZj?=
 =?utf-8?B?a3dXYWtSdzQraStpUVc1Uk4zMGhoUnZuTEVDa2hCOHUzdUFBcW4vOC95ZXpD?=
 =?utf-8?B?RVptZm82U29NY1EreVVxSmc3OEpaazBxaWtQcWR2eTN0VzZhZm1saTFSMVZG?=
 =?utf-8?B?Tzc3cVEwUzIzZzdpaTRBa0lwK0RiQW1yaFBOQnNJemdHRUNtY2FoQWlZdVhj?=
 =?utf-8?B?ZFhNRnFnS05nSm4vOWVsYW5ZNm5xRjNlQSthMXlSczllS2RjY2Z1cXdnYTFM?=
 =?utf-8?B?TmRGR3dubDVHb0F2MEVKNC9ZWlg3M2RRMzF1ZTczY1dScFNySy9ncGxKdUVh?=
 =?utf-8?B?NWh5VXJSUGJLWEtTcVYxOWQvVjVwTGJ2UFJ4UWNjcXZLY0NkdkFtL2ZFY1M3?=
 =?utf-8?B?S2pPN1BiTVU1dDJwWnQ4WlBuTlhlak9qUjV0V3g3dWlxOHAyaHJjWmtnK2dr?=
 =?utf-8?B?aGpXOU5PNk9oYWM5VS9UU0VlRnY5M09tT0JQMFp2R3dPSUQ0aElUTWp6Sktp?=
 =?utf-8?B?dEtSZ0xla0QzZ3RRaDIwMlEzSVYvWTlwa3ZzUlFJSWdBeTBVYnV6MENnRnVz?=
 =?utf-8?B?YWJ4c1BCRzBTYldQUjZaSGFmdmhFRHM0K0Z2MUo5RTRzMzR0aURsL0dTaFNz?=
 =?utf-8?B?QWxnUmJna2FzVTM0UjIrcC9lRUFUekQ2VDBxM3o1UktKKzRoQVpDRmZLZkRu?=
 =?utf-8?B?aFpmcjRJT0NlWCtCQXJDUFR4TDd3N2UvNUtCQUMrc1haZ1p2b0MwYjFaNDVJ?=
 =?utf-8?B?NzdhNkxDemlqWjlOdGJVd09ZVGlMTGhHMnJzSFJPSUNRMW5wWkpDdTY1MzBR?=
 =?utf-8?B?WWZIeTRuQVJkUEFrcWFGeStsd1NoRkRNWG1xaTBLaHE0VmRvZHFYSURCOExQ?=
 =?utf-8?B?eXRKejNKTWJqZFNJcElqUXVxRWdYdnVSYkxNTEFNbDdudzZYbEROUEZxZWwx?=
 =?utf-8?B?cS9MUFRHKzU1ZTZTREN2bWkxUTJlU3laUjJ2SjBXWXNqN2t6bGJKM0NKM2tu?=
 =?utf-8?B?Yy9jckR4TU44cncreVpPZ2R3TE1BdWRRaGYxdkRUU291MjNDd1hZMTJvVDRn?=
 =?utf-8?B?YThFU1YyRmp4U3ZyNjZYcmsycFJucTkvcmRxUXdzd3pwQmU3N1Y3c1Ezd3Fz?=
 =?utf-8?B?cUl6RmxIUFkrNXkwUm1jUEN6M0pyN0NuOHhnSVFXYlY4d1RjbHZtSEFuLy9J?=
 =?utf-8?B?dG12Y21ISjFVZE0vNkJoRTNZZkVlcUFOSWxJSFRNQkVMK3phZS9xdTZoSzVl?=
 =?utf-8?B?bmcrUDRYa2Y2R1pBNTJGODNWOGMwWUtCbE82VG9EYUI2RjMrM1JSZ0NKOW1G?=
 =?utf-8?B?Z2JZZ1EyTXlvSnNHY2Q4YnFZSXZoWFNhNXdZMVh2Vlg4RlVtS0djRTE1YzEr?=
 =?utf-8?B?NWNaSGF6NzhVMGEvNU1HRE5tR0NEbzZMRVRhZDZ3a0JKZ3k3QXBlcmtxMEQ1?=
 =?utf-8?B?bDJsNEgrWkpnTzRkWDNuemt1d0JZNlJNakZzUVIwdFE0bFg4NDI2T0I0NjBW?=
 =?utf-8?B?YTZZb2dxM0p3UEZ0RE44UEdWMFV1czROSXptSFlrS2NYL1ljR0FsZ3cvRUFW?=
 =?utf-8?B?b0EzcWI0YWtsd1VDL0JCc2pOR0xiSUlVMXJ6N0I2V1dwSithL1V2cUNMZmlI?=
 =?utf-8?B?ZmdSdVlXWWh4M3NGemxySFlZV0FScER2MDJLQ21ZTXpWNXRMNi8rUlVUN2p2?=
 =?utf-8?Q?/Qmb7pdwq70pqDHDqt9FoLIEX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a460d6-9a4e-4215-a7bf-08daf5549b30
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 10:54:55.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGsFQAAGKSZrn9sMSfiYp0kKkw7aieN3FetL7ZGUxW48O/76KECf9f36W5558gkQeQ4nBYuwv0qt0qmjhiWX/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/23 21:35, Pierre-Louis Bossart wrote:
>
> On 1/12/23 09:29, Limonciello, Mario wrote:
>> On 1/12/2023 08:54, Pierre-Louis Bossart wrote:
>>>
>>> On 1/12/23 05:02, Mukunda,Vijendar wrote:
>>>> On 11/01/23 21:32, Pierre-Louis Bossart wrote:
>>>>> On 1/11/23 03:02, Vijendar Mukunda wrote:
>>>>>> To avoid ACP entering into D3 state during slave enumeration and
>>>>>> initialization on two soundwire controller instances for multiple
>>>>>> codecs,
>>>>>> increase the runtime suspend delay to 3 seconds.
>>>>> You have a parent PCI device and a set of child devices for each
>>>>> manager. The parent PCI device cannot suspend before all its children
>>>>> are also suspended, so shouldn't the delay be modified at the
>>>>> manager level?
>>>>>
>>>>> Not getting what this delay is and how this would deal with a lengthy
>>>>> enumeration/initialization process.
>>>> Yes agreed. Until Child devices are suspended, parent device will
>>>> be in D0 state. We will rephrase the commit message.
>>>>
>>>> Machine driver node will be created by ACP PCI driver.
>>>> We have added delay in machine driver to make sure
>>>> two manager instances completes codec enumeration and
>>>> peripheral initialization before registering the sound card.
>>>> Without adding delay in machine driver will result early card
>>>> registration before codec initialization is completed. Manager
>>>> will enter in to bad state due to codec read/write failures.
>>>> We are intended to keep the ACP in D0 state, till sound card
>>>> is created and jack controls are initialized. To handle, at manager
>>>> level increased runtime suspend delay.
>>> This doesn't look too good. You should not assume any timing
>>> dependencies in the machine driver probe. I made that mistake in earlier
>>> versions and we had to revisit all this to make sure drivers could be
>>> bound/unbound at any time.
>> Rather than a timing dependency, could you perhaps prohibit runtime PM
>> and have a codec make a callback to indicate it's fully initialized and
>> then allow runtime PM again?
> We already have enumeration and initialization 'struct completion' that
> are used by codec drivers to know if the hardware is usable. We also
> have pm_runtime_get_sync() is the bus layer to make sure the codec is
> resumed before being accessed.
Instead of walking through codec list and checking completion status
for every codec over the link, can we have some solution where once
all codecs gets enumerated and initialized, a variable in bus instance
will be updated to know all peripherals initialized. So that we can
check this variable in machine driver.

>
> The explanations above confuse card registration and manager
> probe/initialization. These are two different things. Maybe there's
> indeed a missing part in the SoundWire PM assumptions, but I am not
> getting what the issue is.
We will rephrase the commit message.
At manager level we want to increase the delay to 3s.


