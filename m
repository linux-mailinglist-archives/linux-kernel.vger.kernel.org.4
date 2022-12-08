Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A66164775C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiLHUgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiLHUgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:36:03 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAA19D2F7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:35:37 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8Jfjdm031522;
        Thu, 8 Dec 2022 20:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+ICE626UngrsZ/Zd8+ubaaIHaY3uaEheVHKAJc+xKRA=;
 b=VGNLxOl4eyco9hW2AIMbTHVGvNtc+awDSOCed5nx2dopIrsgibpdne2qOwwk7BCUmkWS
 5AJ6ZWb7zUHfv+SwaZDRf2FUQFIuDJeY6Nn/Aw0Y26vnERAsDaZrRfEDAwWaqmevq0ar
 08YEM75XxvwVxA057273EYlD6rQ6/GnHLXBut2UXWLEJRHjNUMm7a58nr+xgrz2RnA0f
 V4twECrW7Tet/+f5HBV5+7z8a76MQaFp4PWn+8sAZPZUxAQHbCC0Hmbu42vcxURbM7T5
 TPKLbpVHeQessr1D3tSL3oZQCvK781sgxWeT+3fg9lzrIQijCd3KOy1PI0aFCuJVsE5l jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maudkbvts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 20:35:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B8K2CvI019574;
        Thu, 8 Dec 2022 20:35:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa8jaxf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 20:35:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0TSn8/XYmMTg+g258YWd8wbB60wibog/nqy8lYFEijOM/8FzJMGeCbvmvkMIhNKlIikD+ZakdJ8WzHe+E/UIMOqfxyHN74nKHWcJZbhmDSlNaUV2W/6rw37gMzjZG5TtPe4uQoUr9ZjUuOoTRiKyTXLhAMScdx8cWth5ZC9U4JC0IQsiu5wxThMYgywb5hbtxZ6b7Wi4vPEimN42qGDj3TLbZyFaXw6QvnUC9O4KKNKsw8edJ4srLeDy+WxZXMllvZg1PNTOFbEKqaqXFFVFh/CVs99CaEVrmgBMaSMnCaFfF4I1vCqmtvekujHlB/StAPLP+n6bwDPm5R+2dltEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ICE626UngrsZ/Zd8+ubaaIHaY3uaEheVHKAJc+xKRA=;
 b=BhI+L1oa3pgZcjz9C1xIFgudD0LJtEVluIe7dlOgfaiJ0dPDfK8PHbeBjnIsEkcSswkf2v+KMv1WB89SbcfLcnlX10LEBrSEoDBaijOsjt37Hx3+Vq8WmxjlTb96M44sp8o2MQyO0unftM8G3bM/5Tz5hfyx1GEMgiLhF2nTbXFEfwVJTZgNl+cc7nFP74W5vGQQx7gzmboRWnKYYhDvyY3ETJVzUh67aG6I+SRsNt4iwncR4ugLplWeHHF2vTnyXxQuWUXM6AnnxuHpUF036clFoGmosZdpuT4i+ROKKB8lTTGVyBkHjTEV7NM3YDEj79/GMU88cTbd1Tb6vcl2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ICE626UngrsZ/Zd8+ubaaIHaY3uaEheVHKAJc+xKRA=;
 b=hnOg5l1urBPQ5DmLen8nmN6jN9u/YtRx7tkuAEPPmQ42wZ09eAZkpa/cS7mVIERfbmbAPuVl33UpoWGnSDSPXjlNHxv9NJia0hpuZMzNW0qLWA3uvLT8xUEZJxCZ7NEKwdp75YWs834z66s0lM6aHDQDaj2fBIs4jhh4Zm8EW8s=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH3PR10MB6786.namprd10.prod.outlook.com (2603:10b6:610:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 20:34:58 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%9]) with mapi id 15.20.5880.016; Thu, 8 Dec 2022
 20:34:58 +0000
Message-ID: <c15e968f-c23f-b41f-1fa3-10ad16f6fb35@oracle.com>
Date:   Thu, 8 Dec 2022 14:34:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v14 7/7] x86/crash: add x86 crash hotplug support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-8-eric.devolder@oracle.com> <Y5BozkPot12L5d9w@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y5BozkPot12L5d9w@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:806:21::20) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH3PR10MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 70858403-3c15-4345-e22c-08dad95bab34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4p6ZLUinDQxTvJzZ+Y+cTY0jDLzjH7DUY072aP174IbLbVorFJPcw/E5oN30Dyd5xIjU5aMu+osaVkUfBMBaYNF4M6NBX7h4hWVARNT8JJVJXVINWhjS+1mq70Ckzh0dkK6WFZqR1clCbrQ99qhGfGzsJ8BudTfFQfCAf1EpvBDZq7XlwnL2wQB61yuNwE3L/ekvRnO8CeUd1I8PtBnxcrWD5/FRmpnMIRnSscl9QZl0SpVBI77NVNXidQ5JOdwuk94TeJnehq4h5Ko2rIIf0YS6MUqYfxr59G5k+AQojgLmxJUzU/L4BGWDm3AB7fCwq09tu40D8Ade7QhUNHzNtkElbucfe9kj6wUuJ1gcxg0666P235OwBoOuxdyzjhiPlBc79Y5EksW1U6IqZFpDkCC22U+K9770IX8Vl/SWaitkrrPKJ52weNSDtvJEBSKvL1mUIyAd6nPdcG1tPwqXnWVXs47YgUnmoM7hbrvlWJolLH7dk19kCt7VVy6VZF/y5q35pc313mOYfkXq4EPIRQ8I4pQ0FIOEH9r7QVNwpt0furIby+evIZxlRTTb50RlValTKtw6uUorodAjMbZ4ND1gxU/qn8fFekuD0335R1B99pwdZm2EtVsX4hc/ni1VbjpxLJVcCPX96MMACHvylBZEEnPCF1WNqWHKwGJJSYw/N91OhjOPKrU8EgZgGzmWdSuGUqGqSHQI78qTudrCzF1ruJN+InzG0ZHMy2G4Gd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199015)(38100700002)(83380400001)(7416002)(8936002)(66946007)(41300700001)(2906002)(31696002)(66476007)(4326008)(8676002)(66556008)(478600001)(5660300002)(186003)(107886003)(6512007)(6666004)(6506007)(53546011)(2616005)(86362001)(316002)(6486002)(6916009)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDZ1SlQ3cndKY0RZT0grZDNZSVJ1VGRhbHJJcTFtNWFNVEMwMEhDbGVET2pJ?=
 =?utf-8?B?R0thMFpRK1JFK0tBV0dSUy9OMzhmdjFrc0xpb2x2eEljbUxHQmxOYjFUOU5P?=
 =?utf-8?B?R2MzYnB3NWxPajF2Zk85NlhkQ3BOYVpwZmFkOFVLdnJPTG11OE4yTWlGMWRu?=
 =?utf-8?B?TEMvWXYvdEE0NkxRNlJHMXVRQ0hpSG9SWUNoQlA5SWlnemNIY3lYUmlTOVhD?=
 =?utf-8?B?N3ltM08wOG8vbWZxY2FHTjViNzNxay9GV3JZTThuaXFWRmlwaG9hMWo1T1lM?=
 =?utf-8?B?UnVMcGE3L1dVckxrcXFxR2gxbXBiMlMyeDdScVNSQTZRSjM1ZUtlZXhBRkp3?=
 =?utf-8?B?V0JxaklmNlJobDlLZ0dIeGh1b0ZaSEFHdHljall2NGFEOWVoYS9WOTZwTlU2?=
 =?utf-8?B?RjA5R3dJQ3lWYURJbGlkZEs3NFZCbU5mN0NUM2RxM2RYM0o2N0NXajMwQVll?=
 =?utf-8?B?NG1ETXNrVGVOVkRKQVBYKzZFOWpPUWhDVEo4Qmt6L2s3d1Rid1ZyU0hmWm9X?=
 =?utf-8?B?TGE2Ym1iQnRrU0RuUHY5QW5mOU5jN25VK1RzOFhHMWo0ZnQyZWNydXJFOGQ2?=
 =?utf-8?B?SGpTNXRQdDVXa1dGVTU2SHFFQ20vMTE3SGFoYXJYQWFWMkVhRmg2VUZRdVNZ?=
 =?utf-8?B?Q1RQMmRwYmFMcGI3RFJjSlgvbHZDNXRjck5BYm1LNzNrRWRtTXVuNzRzZ29T?=
 =?utf-8?B?TUdKRHcyQitsK1VFbGJrZ294dEZnUVBkdENUWFRiQ3VzWmNBaE9raHdrUTVv?=
 =?utf-8?B?eWl1R1dGTk1GY2g5a2RxcXZ6NWh5WFhhcXVaT25OTFBYQWQrRllkQitMajNv?=
 =?utf-8?B?a0s0aWowVnMxNVU1MXBHRUhXV0JPNUpZYlE0czlJTGhWcHliNzk5ZU1ZVUZu?=
 =?utf-8?B?TUxvdjVvTkNuRGVHTU41OFZjaUhhd3JwUmt4YlB5WkRYUnJvSFZNRHdIaU1w?=
 =?utf-8?B?QUNGdEtad2JDMzZoOEhPZDM2T3Q5T3dVWDNLdGI2dVRCVml4dlljV1hXekFy?=
 =?utf-8?B?V0VBNkwxZ0VJdHdlZEpsYnAzRkZhNG5rTG1uaVUwNE1wKzF3ZHQ4bkkwbmlt?=
 =?utf-8?B?OW9TVUlWaGhpaGtTRmRWbTVEK0tKZVNpd3RMUTZweE94cVZvMm1uSDMySjRl?=
 =?utf-8?B?UVltSGJESnZFcWFuNWk4NXVmUWdDNHMwNWs0M0ZMUloyb2lYd2xuYjk5ajls?=
 =?utf-8?B?TjFDODBjbUEwa0VKUVRYNTdKc2k5QnNzVFpXQkpCS1dwTDBwMm1URmxnMitr?=
 =?utf-8?B?WVFpMlhhMDgxNUJuVjZTd0VJTWF6d2szdUxEMDVpV2NOZWVwcGU1aWFhTVk1?=
 =?utf-8?B?cHR0MVBZU3hyQWtGaU53SHBvQ0hnd1ZTZ2hiZlpVcngyczBocHVxSDVrQ2gv?=
 =?utf-8?B?em9TUWlIdW55T1FsTjJrVENnblBLYXV4UzB2L0RiYlloN0o4bnFtbGhzRnh1?=
 =?utf-8?B?S2hIbGhVZ0U4Qm1Qa0VUQ2FVZUU2OW9rby96QUpnT1h4eTZqd3NaME14YUFM?=
 =?utf-8?B?d3ZjRW40OHlMQ3dTaWdjMmV5VHR3ZzdoK2pTNE9WUGhMZzVTTXBUUkNRZDhj?=
 =?utf-8?B?QWozWGVoYXFmdVJNSGh4bjU1c0QxVTdGWkc0OVdMUEJnVEUwMG5JYlFubTFG?=
 =?utf-8?B?a1dKazVIZGJxdkhEd2hiRXFsTDgzTmtqR0NIdHFLSzQ4SWhFTWJjSEk5TDk4?=
 =?utf-8?B?R2VBT0pqZVkyVVkrV2ZlRnlCcDlGVTNxRVVLUmxyTldvQlp4SldCRldGMVk4?=
 =?utf-8?B?UUpXbkVIYnE2dXZUY3Q1WjkzcnduZDdUVzdPd004VGgxMS9ZSWJQTDNVSTFB?=
 =?utf-8?B?U3QrMDNCejZDL0I0dXYxMmRZOGp5ZVJDcW1NNTZ0UTAwNm9mQVF4SnE4NzNK?=
 =?utf-8?B?aEdHbXRVV0dUa3k0MExFNG9KZytaRENLRkdVVi9pQlFqcVkzTFo2WjBLNUE2?=
 =?utf-8?B?ZmlscW03WlNveHVZc24xbHcybkhzRmFJSWZKVjQwbmFYaTVpWlpTRHBQWHdr?=
 =?utf-8?B?aDJTSG85ak16UUhwUWRaNHhYZHQ4M1lwNHc1YWZBOURXUjgyemFXblhmQkhh?=
 =?utf-8?B?SVRsekxoWmQwUlpXQlBmSUlCVVFXL3AxUml2ZXZObmFQRVAxVXluakRVVVBC?=
 =?utf-8?B?UVRkVVY4eDlIanM2YnpVWTB1b1BDRnpWaWowZG5ibW1XcjF6WktHSG5mSHlz?=
 =?utf-8?Q?a7DOfZL5dz25ICTy9v36IOY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70858403-3c15-4345-e22c-08dad95bab34
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 20:34:57.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VR9yuq2MmoQ6JL4Tsy9vivXqWyMNiUhKiyeUiowTlZDpjGSu6fxc/LuOOX7xPhLWLcAZqZ+DFE1QmEWja0asXYKINv6HaWjQX4Jfg6pM/cI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_11,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080171
X-Proofpoint-GUID: wDqn6ndjmfsTmnj6rj7I_A_sI-3u9hkt
X-Proofpoint-ORIG-GUID: wDqn6ndjmfsTmnj6rj7I_A_sI-3u9hkt
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/22 04:19, Borislav Petkov wrote:
> On Wed, Nov 16, 2022 at 04:46:43PM -0500, Eric DeVolder wrote:
>> When CPU or memory is hot un/plugged, the crash elfcorehdr, which
>> describes the CPUs and memory in the system, must also be updated.
>>
>> A new elfcorehdr is generated from the available CPUs and memory
>> into a buffer, and then installed over the top of the existing
>> elfcorehdr. The segment containing the elfcorehdr is identified
>> at run time in crash_core:handle_hotplug_event(), which works for
>> both the kexec_load() and kexec_file_load() syscalls.
>>
>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>> the need to update purgatory due to the change in elfcorehdr was
>> eliminated.  As a result, no changes to purgatory or boot_params
>> (as the elfcorehdr= kernel command line parameter pointer
>> remains unchanged and correct) are needed, just elfcorehdr.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr segment must be sufficiently large enough to accommodate
>> changes, see the CRASH_MAX_MEMORY_RANGES description.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/Kconfig             |   9 +++
>>   arch/x86/include/asm/kexec.h |  15 +++++
>>   arch/x86/kernel/crash.c      | 106 ++++++++++++++++++++++++++++++++++-
>>   3 files changed, 127 insertions(+), 3 deletions(-)
> 
> Some quick cleanups ontop, there's potential for more:
> 
> ---
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index ffee99046942..486509030d3a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2091,13 +2091,16 @@ config CRASH_DUMP
>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>   
>   config CRASH_HOTPLUG
> -	bool "kernel updates of crash elfcorehdr"
> +	bool "Update the crash elfcorehdr on system configuration changes"
>   	default n
>   	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
>   	help
> -	  Enable the kernel to directly update the crash elfcorehdr (which
> -	  contains the list of CPUs and memory regions to be dumped upon
> -	  a crash) in response to hot plug/unplug of CPUs or memory.
> +	  Enable direct updates to the crash elfcorehdr (which contains
> +	  the list of CPUs and memory regions to be dumped upon a crash)
> +	  in response to hot plug/unplug of CPUs or memory. This is a much
> +	  more advanced approach than userspace attempting that.
> +
> +	  If unsure, say Y.
Done!

>   
>   config KEXEC_JUMP
>   	bool "kexec jump"
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index d2238bcf8106..d26f208e582e 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -413,25 +413,32 @@ int crash_load_segments(struct kimage *image)
>   	image->elf_headers_sz	= kbuf.bufsz;
>   	kbuf.memsz		= kbuf.bufsz;
>   
> -#ifdef CONFIG_CRASH_HOTPLUG
> -	/* Ensure elfcorehdr segment large enough for hotplug changes */
> -	unsigned long pnum = 2; /* VMCOREINFO and kernel_map */
> -
> -	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> -		pnum += CONFIG_NR_CPUS_DEFAULT;
> -	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> -		pnum += CRASH_MAX_MEMORY_RANGES;
> -	if (pnum < (unsigned long)PN_XNUM) {
> -		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
> -		kbuf.memsz += sizeof(Elf64_Ehdr);
> -		image->elfcorehdr_index = image->nr_segments;
> -		image->elfcorehdr_index_valid = true;
> -		/* Mark as usable to crash kernel, else crash kernel fails on boot */
> -		image->elf_headers_sz = kbuf.memsz;
> -	} else {
> -		pr_err("number of Phdrs %lu exceeds max\n", pnum);
> +	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
> +		/*
> +		 * Ensure the elfcorehdr segment large enough for hotplug changes.
> +		 * Start with VMCOREINFO and kernel_map:
> +		 */
> +		unsigned long pnum = 2;
> +
> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> +			pnum += CONFIG_NR_CPUS_DEFAULT;
> +
> +		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +			pnum += CRASH_MAX_MEMORY_RANGES;
> +
> +		if (pnum < (unsigned long)PN_XNUM) {
> +			kbuf.memsz = pnum * sizeof(Elf64_Phdr);
> +			kbuf.memsz += sizeof(Elf64_Ehdr);
> +
> +			image->elfcorehdr_index = image->nr_segments;
> +			image->elfcorehdr_index_valid = true;
> +
> +			/* Mark as usable to crash kernel, else crash kernel fails on boot */
> +			image->elf_headers_sz = kbuf.memsz;
> +		} else {
> +			pr_err("number of Phdrs %lu exceeds max\n", pnum);
> +			}
Done, converted this block to an IS_ENABLED(CONFIG_CRASH_HOTPLUG).

>   	}
> -#endif
>   
>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> @@ -463,10 +470,9 @@ int crash_load_segments(struct kimage *image)
>    */
>   void arch_crash_handle_hotplug_event(struct kimage *image)
>   {
> +	void *elfbuf, *old_elfcorehdr;
>   	unsigned long mem, memsz;
> -	unsigned long elfsz = 0;
> -	void *elfbuf = NULL;
> -	void *ptr;
> +	unsigned long elfsz;
Done, note that I leave elfbuf initialized to NULL as its use in prepare_elf_headers() does not 
necessarily write it, so it could otherwise have been used uninitialized.

>   
>   	/*
>   	 * Create the new elfcorehdr reflecting the changes to CPU and/or
> @@ -489,26 +495,24 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
>   		goto out;
>   	}
>   
> -	/*
> -	 * Copy new elfcorehdr over the old elfcorehdr at destination.
> -	 */
> -	ptr = arch_map_crash_pages(mem, memsz);
> -	if (ptr) {
> -		/*
> -		 * Temporarily invalidate the crash image while the
> -		 * elfcorehdr is updated.
> -		 */
> -		xchg(&kexec_crash_image, NULL);
> -		memcpy_flushcache(ptr, elfbuf, elfsz);
> -		xchg(&kexec_crash_image, image);
> -		arch_unmap_crash_pages(ptr);
> -		pr_debug("updated elfcorehdr\n");
> -	} else {
> +	/* Copy new elfcorehdr over the old elfcorehdr at destination. */
> +	old_elfcorehdr = arch_map_crash_pages(mem, memsz);
> +	if (!old_elfcorehdr) {
>   		pr_err("updating elfcorehdr failed\n");
> +		goto out;
>   	}
Done, changed to old_elfcorehdr and error/early-out.

>   
> +	/*
> +	 * Temporarily invalidate the crash image while the elfcorehdr
> +	 * is updated.
> +	 * */
> +	xchg(&kexec_crash_image, NULL);
> +	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
> +	xchg(&kexec_crash_image, image);
> +	arch_unmap_crash_pages(old_elfcorehdr);
> +	pr_debug("updated elfcorehdr\n");
> +
>   out:
> -	if (elfbuf)
> -		vfree(elfbuf);
> +	vfree(elfbuf);
>   }
>   #endif
> 
Done.

Thanks!
eric
