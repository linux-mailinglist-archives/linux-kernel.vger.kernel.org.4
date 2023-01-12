Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D421B667F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjALTtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjALTtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:49:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001AE11A19
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:44:57 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CJfwql014771;
        Thu, 12 Jan 2023 19:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : references : from : subject : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xGKYOzY1zjzSPR3GmLBSaXMk6Gd0r79ktWHnTEP4/mk=;
 b=XzVjoQYCIalikTDTOI48gCcF2p0C+Wkg6Qst30TIS33pejKjk18qbEcQ6ixYjupOAbMP
 rgLz5mDNUoE6ZGqWTalfTFWmsGl/yVE39TgCwPWswORoMcMp+mxLoKrfSP0waMJnZVzV
 V5mw1KAXcL6vVJ7ERbwe/qqJV/WzzgORisBvxGXWNFje5YF2C+ClVJMCQqddwtW+li/1
 QDyXkbZr0EYXVvfehGJSD0RIYtdKh7rxFUSAa7h1cWS/pQFaS3Y9+zReAyuufDRzEE9b
 5JBuGzYeORvWD5MDGw23YUE4vHLz1fX7y6tVr79J4Kp2CLfdtT28mMprssqGVZu+yd4m rw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n28ja9vst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 19:44:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CIeEQr016065;
        Thu, 12 Jan 2023 19:44:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4r7q3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 19:44:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1NDhP4bXDhKGhul48hkMFLbeggOmEffBQvr1DV/0OxLcoeD8Je2Cg8C7ELiz9nJUtP1aBzZ1ER2mA7kuPvV2B+0xuTfNiVcnuaRZNcwJXHTFymbGrhCncZ1PHjnL0UfYqa+XWzdQfvmFcgqcPYWTPy4ChLtp52UmEifugn0C9gPibqPJlK2Wxn2tWXhYxn5mzgPMLcLoyu0ageX7y6bTmNb/fizSYw/ZTYOvv1SftoFVdF3gmy/lk2igW86GHvsN06xFiBMSFJoQYJ9BP6ssrjRQUMvwYrCR0/dQVV6OKGLr+V3ukDWYBN7DNnWowxCruXjq+goZK6Qv7xuZmzWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGKYOzY1zjzSPR3GmLBSaXMk6Gd0r79ktWHnTEP4/mk=;
 b=bWbCv8pYJRvbIGe7qqs3Slyl/hM8fq3Px18jtgNa/HktgEuctQOSeeN7Lp3pHUyObH32pbxyWGCb+y3UHyUvT7gD0FgvsFbZ+x5Oxi54/oXXp4hC71OkPlMG1QeFEuq91aQ0B/3dhr7FBxvDuRmbxTp/GqSHX71xXgWln2wYCuk/FwZI1RD76jIf3ON3wOkO0MrG51tJ6zTuPlfgxJDi8ucx6Lue7SZBDIGaYzm+eThQxhXGBXvkb4bmiCKAPDaTIlggxLZJccAW/DUW0PSwH+qaeXRi+7jHgaFP6PC7AIwdrSvybPfLxjlxhRXkeKwKkgucu4X2mmsPa31Ce+NUSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGKYOzY1zjzSPR3GmLBSaXMk6Gd0r79ktWHnTEP4/mk=;
 b=UFaCyhemjL+SKJOPI6vQTgW1jPRbPQrT8JhaEXcFNW1YnO3P86jOw8F13icswJIm+C25qIEfoJGUBf3gOagD1esqX8cFCURMiNXtfU1Gg4259w9lemL0dHrJ9JJRoIVD6401Wjjo9zGfV8aGZWoCpKvGEfikyeNBHi/1rH8uV+Q=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CY5PR10MB6237.namprd10.prod.outlook.com (2603:10b6:930:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 12 Jan
 2023 19:44:11 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::909f:fa34:2dac:11c5]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::909f:fa34:2dac:11c5%7]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 19:44:11 +0000
Message-ID: <12462e10-ae39-b198-b159-9c621eb5119d@oracle.com>
Date:   Thu, 12 Jan 2023 14:44:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        xen-devel@lists.xenproject.org
References: <20230112152132.4399-1-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH] x86/paravirt: merge activate_mm and dup_mmap callbacks
In-Reply-To: <20230112152132.4399-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::33) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|CY5PR10MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 186789fb-8462-4973-fb0c-08daf4d560d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdM5lWrnOzt4XMfOjxg8+A9a8qBy4jWrSUpbLPpPFJQnFfYs0sBgAN5m8aq6B1pQpEEj8SQVQ6+eWpyVY310h0YKSI91MWQQFWlVQ6kHyMADiPU+kr2+ekZMkIzcESCdEiG7L7JU6HnkLNXCycsJbrPaXGi7OmCKBPAVZEDUDSOxM1tWnrkhcc6qs6Vb65RiNGR0hffl0neCmMbqWRjhRBQHY0wP3kDax6OQ21dkNot63yV4hhkiqmb/9VswGT1Sj1YquPrmEBvEGJS5x9X/Pk+J+C1bocxCcFhoLHayCT8TtTlx/69m/McFV/N0dju2tv80boc3Ruphw8Qb1Hj3nxXLjZnjFM1vl35cTVBtYEaqBZxSsgekOBwk6fCJn1i+zcMBaO1ZZqDLfvau/u3GiuqNovfhup9QSjLgbaxJlWdRd5JnKC1Nf+uINDOZNGi8BN4knrTR4COBWRLXLADr8WB1Y9HW27cqmTHL/zeSFUyqsCVM4qqgqrGvTG+7dvm3g/BizsOxvjt8iZxZiZRKcGxXPKtJSBDEUIjNo5bA0/JXYGuwtMZQMm26bsOB/UhCeyU6FUZSayi9zu4wOz25xFMrtoelBg++GW+Q/9qGl2c/kfeLZjbZzWnab3c4HIGnmN2pfXYGgYQia/hGMAber8DFFSrnOFjZfCMd+uvcb0isA3IVTgH0EmiZOrdTlVDPC2YrJUvSp1AceZIsXamyBpyMfT5SiuMN/+NPz9lbeec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199015)(86362001)(36756003)(31686004)(83380400001)(4326008)(7416002)(66946007)(66476007)(66556008)(8936002)(8676002)(44832011)(5660300002)(4744005)(31696002)(38100700002)(2906002)(478600001)(6486002)(316002)(54906003)(6506007)(41300700001)(26005)(2616005)(53546011)(6512007)(186003)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm9FbTFnS1psU2R4YlVpbjlYektrOGRxT3VoeGdpSGl4bWlHanNmcmxpOUR3?=
 =?utf-8?B?Uk16ZUhJZlVaaENkRmtNayt2cFdZQUxyZS9CMnJkc2tGOUlQczdjZ3Q1UlJ4?=
 =?utf-8?B?OFhad1Y3WHFDN2J1bjY3SWlnMHBIM1hTTksvREJtcDJGOU5EeC9zejNWZ243?=
 =?utf-8?B?emxyODdNMjdyWVB6eWFUeTM5MjJzZjNrRFYzVDAwbVhHMzZjcVJPZkNPREg3?=
 =?utf-8?B?ekw1QWVwZk5EeitWS1FuWng2VUNTNnNUNnNvZlJUSGRpWDlqNWlFWjArbm9M?=
 =?utf-8?B?ZmcxbUVTaVNBTWtackJmcEdUdXZ3aW4rblg2ZmVjQ0x3cStsTkd1V09BVGNi?=
 =?utf-8?B?ZWNwREYvMVlEd1JGNkpFV3N3Rm4yV1V4YVFCb1l3VTNTTWx6eGRFMzAyUytB?=
 =?utf-8?B?UWVzZVh5ODdld2pHTXRLNTlYd0cxQ3JQSENjZHAxUFlqZ09iRGJCb0hKZ2VO?=
 =?utf-8?B?cVZBNzZHUnpBK21VRUpHVVZoV1FQNjNBb0N5dnRUblZpT2wrVWtqWFoxZk0w?=
 =?utf-8?B?QmdMT3hPQit5OFNwbFk3S1FDYlpyaTFIejEvUHR2SU12dlFybzdUOVZCRkYx?=
 =?utf-8?B?VDhTcEdISkFMWkF1Q2d1cnV4QVM4R3VISHlOYjJXcFZCSDJVaEpzbUU0Smxm?=
 =?utf-8?B?Vkppa0ZPZENuZncwcVp4NWo2Y094ZTZuTVhiSHhOV0NqQjBBVTF5RUpvTzRw?=
 =?utf-8?B?QTdkYlpPTE5UcmYyUGI1SXFEOURxaFVzRGJnbFJ2SWFiT0VGeFYyTTh5STVG?=
 =?utf-8?B?cVU5Tm5MT1p2TndBdEJCaWp6YnprZUJUdGx4WWJUcHdncDNtU09NY0RvREFm?=
 =?utf-8?B?RXVkeDBiQllIMmNTNlgvUDVZR1BHTlQzeHpzTFZHbmExK1VmdzBzWjczTXlp?=
 =?utf-8?B?TERvSFhXL1F6cXJBZmZTYzVxaXRxVk1TU2xaOHZxRGRqZkVTUVcyaUp5ejJT?=
 =?utf-8?B?emNJLzZwdzZsMEY5S2FpYVl6ZnI0VXluanJMZWVhNUFtMTlvcW1pdU1SVlJn?=
 =?utf-8?B?UXR4T0tmckMyNXdtQkZ2T0lYZ1VoSjNHME5wRllFU2F6N0lJZVIzcDBxSDls?=
 =?utf-8?B?WFRtYXNCejN2UkM0MWh2Tk9UbUcxUTkzUW1abWJvRE80V3paajBwdEdUUGoz?=
 =?utf-8?B?VHVuakx4Y2p2T0RENXh4N0pSMGZjNnNrWWM0NkhaMUVITXgrQXpSKzRYQUpO?=
 =?utf-8?B?TVZZMVVOSnJyZUtKWVdHNklXZTRKdDdPOWpNN3pJeWRJY0Jka3M2Y1daV1Ry?=
 =?utf-8?B?UDVyN2RPS1JWaFZ1Yi9XSlE5a01mUTlRNkpuU3k1VjFLKzNKZllTU3ZhTU8w?=
 =?utf-8?B?d2Y2MUN4ZWtQUElrMjdIanZUNE1BQWJGem9XVE0wb2IwV0sySkVtZ3U4Q2I4?=
 =?utf-8?B?S3dTMjVacnhvZnJRUER4VGN3UG1yQmdMQWllSG5VbDA2SGl4UFlsaEZGMi9T?=
 =?utf-8?B?V3JsOGRZa2VpOEk4QkVMRk9FREdEZzZQbzA5aTlWc2lmdzZ6M2plclNEUnE2?=
 =?utf-8?B?YkR6SkpPU3VHTUVqbllUd1JDWlVHS2hhSlpyQ1UxTWMrdW1VekQ0SFZvZmZz?=
 =?utf-8?B?R01UWlhETXFwNkhxd3pZNHBvOEtmTXA1Y3BZVGFOYUM2Y0NmQ0JCQ1ZnbHVW?=
 =?utf-8?B?NFRzbXVPQmZKZ1lFNDVEdU1pdDJnTVlVN0JEUEVFcm92RmtFODg1bEp3UGVU?=
 =?utf-8?B?bjVaYURJZGRSZHpyOWd6UkJpTU1jcEdqRExyRjk5OGFBTkppaUVaL1djYVZp?=
 =?utf-8?B?V1ZsME1GdlZkWis2eGh2a2grZ2JiZnhJWmN1bzcxZnB3Q0hNTW90aC9ReXBt?=
 =?utf-8?B?Y2NkRURtbXVGeTQ2WE54ZTkrdnJST3dRTHcrWktnZnBzaXYySHNKeFlzbFRh?=
 =?utf-8?B?MWwwUS9wZTdEMzF1TVB6dlZ3a1BVVDNEM1hId1dqckQxSVI2eDVjd2NmSytB?=
 =?utf-8?B?UkhWUzFWU1JybVRKMDBrK0orU3VyQTl0ZS9mcmk5a0dkTHZqRkNTMnh5SkJy?=
 =?utf-8?B?ZFNKNWEvTlpldTk1bXZPdVptaHpXM28rUVMzbUQwbjdGNWV5a3M2dmNueFhY?=
 =?utf-8?B?VktNSEdTZEZDck9iRVNTSVozWkFHbVp1TWdLQXNabEgyOWVkUklUQWpGaGJk?=
 =?utf-8?B?MEw1VzM1SDlaQWJGQUprcVhrZ1J1WEJmUWV3RXRmcXo0aUdjbE1qbWhuL1Jh?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MW5mRExLaXZkUWJ4NjZaQ3BQTmk1RDZJMGhpN2hTM24wam5KcStZeXlIV1Qv?=
 =?utf-8?B?ZGY1cjlXL05UMlkzWGV6ejV3QW5ncUt5RmFTcGtVSndvU3UxQ0RKVkxObGhB?=
 =?utf-8?B?QWpPU2drdXk4T1ZmanhIdjhFSlRpdFRLNXk0NHJwSGJCbmV4aTltbTl0Z1JU?=
 =?utf-8?B?Qjk2VmhKbW51TDZtVzhZV2ovdDE4dThVVEdjWHJpaDdwUTlraXEydnJhWi9I?=
 =?utf-8?B?TVMvaUcveVNGbWE1NWdHZjJpcjVvbStOWUNlc29RaDgvZmE2aUQrdDZhWitn?=
 =?utf-8?B?enNjSXJUdVNvdG9FbkRLUndRc2lHejFDZXRveVZqMlAyQWdvQWlmcm1DV0xn?=
 =?utf-8?B?YU9iS0R6WitPYlhsajF6ZVNPWEt2ZThEblJaTzNVYXEzTTlySUZmNTlCeFlp?=
 =?utf-8?B?ZXozZlM4dWN0S2hTNXBOSFZPZkhZYUR2d3MxSHF4YzlaR3lDNVhyZTY0REh4?=
 =?utf-8?B?UDdLRURzWEhkb1VXMGJiMWlJNDNrZ0dLcDlWcjVXd1JuKy9JQUY3MEx2RTNX?=
 =?utf-8?B?NDg4SUVza3J4NVJqTjJSTkFvR3JSQjZsb3NVRkJRdTZlU2xXTUFnMHlQTi9K?=
 =?utf-8?B?b1lBSUxac0dwZ2NIYUxkNGg4TlNKVU4yMWRNYWIreVB6Q0VRYUdEUGJMd3Ji?=
 =?utf-8?B?b0phU1BULzNhYWRrRzZ5T2g2T1FpczdlUDJsOEEvTnBuRGxRU0tDeUpDVkxK?=
 =?utf-8?B?b1JHRHVxVHBoTi94Zit5U3dtbnBTeTlWbncrSXdLUjA2S0cyelJrNU1OUG1i?=
 =?utf-8?B?NHd6WU8yVVpud1JEQ2RWOWprdUFhVEk4ZSt3cjBHWk10WGNkaFgyNUVaLzVU?=
 =?utf-8?B?L2VFcGh0NlhPN0dRYUdud0FuaFNBKzhMclcxSjR1UDVmY3hzamh3VlI5TElM?=
 =?utf-8?B?c3MwT0t0VWd3QjZJbmNzNGdub09aamg2SVFiZGFHM1VhV3ljdnpvVjBwNzlS?=
 =?utf-8?B?SndkRndablZTR2JsRWdKUno0NHpSZ0hTN0c3S2d5YkIzTXljeUtHWHpFOGUr?=
 =?utf-8?B?VE9ZZjhETjhoZEVRdVk5RU1ZYWhzR1FFN2FNNTU0QVg0TmwzbGIzTjdaM0RX?=
 =?utf-8?B?MytXSnBrb1p3cVJ3ZFJ0STdkcXNYdmNzZmR0Umwxc1g0dW1rdzJMMy94Lzc5?=
 =?utf-8?B?a3A2NjJBSWN3dXlIVUZQQnNtYkI1aHNFck4xc2ppQkkyUC91RjJHR29hVFEw?=
 =?utf-8?B?MWJ5M2NXT09kUHB6dTFIUEp5d1VlMTBISE5nNFNvK3lPcU9GalBVczVxbndo?=
 =?utf-8?B?M1llTE52NmVRajN1REtaeDBaaEs3R3pPTnZ6ODlxVkIxajZ5Um5BUkJMVVVX?=
 =?utf-8?B?V1dPam1LaThJNTV0N2JaNEdiRzhHK2dMaHNVZDFYLzZoOGozSmc4K0lyL3Rw?=
 =?utf-8?B?OVJFMGNSbEdNU1hVQVhQdHBINVpLbTVyZjFIdGxOcUs4VkYrWFdSdnk2YTdz?=
 =?utf-8?B?ZmxJUUNScWZJclZJR2VpTTJKeVMybGRaMVZHS3dNdVU1TC9UbTJyVVg2MGZT?=
 =?utf-8?B?ckR1S1ZOb3lmZlpaRFpLd3dENlZkMGxOU2gxUTlmTFFkazhGcG4wQ25Ld3NM?=
 =?utf-8?Q?IXomv0c3CZbZ/pJHNOEIPrJtI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186789fb-8462-4973-fb0c-08daf4d560d3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 19:44:11.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7u3H/736JcLjowuGrsXn1pd1Y+0fTfXZJlH7d7kRdDjgbNTLPdnxl8xrV5bF0KTT92bKAl2nQ5VEOT6LeyTR0AXrKD8jYSOE4OU4DK2AWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120141
X-Proofpoint-ORIG-GUID: VD9Nbg3F-a_L5jYivbIFN7Xhc7-rzmbt
X-Proofpoint-GUID: VD9Nbg3F-a_L5jYivbIFN7Xhc7-rzmbt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/12/23 10:21 AM, Juergen Gross wrote:
> The two paravirt callbacks .mmu.activate_mm and .mmu.dup_mmap are
> sharing the same implementations in all cases: for Xen PV guests they
> are pinning the PGD of the new mm_struct, and for all other cases
> they are a NOP.
>
> So merge them to a common callback .mmu.enter_mmap (in contrast to the
> corresponding already existing .mmu.exit_mmap).
>
> As the first parameter of the old callbacks isn't used, drop it from
> the replacement one.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

