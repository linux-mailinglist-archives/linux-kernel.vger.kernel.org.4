Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB6063F97F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiLAVAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLAVAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:00:49 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028FCB2B5D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:00:48 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1Jdc6s024834;
        Thu, 1 Dec 2022 13:00:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=PaJR2pjwTh+/Grz7Qudw9cfT/0WeoGmrj4Q7kgeQ5Ew=;
 b=JL4cG2449p8G2s4t0IgJ+GaO/cHIV58zu0DqQY8UE9n/76y6SA/KcJlhDtgx5qy3eZG8
 VB+QvpYtjTOFpIZJd9VrzXeAbcCEQXUki7mc3pdc9WXGjUl95GSMYHE4ddySIF8EXnnZ
 Eb+4nMGHXxSRvXriS/YPaGermQI6gnCpbH5n07xmbq074Sw38LHh6oZbCHcsZELnfyTh
 MvImvqtHVEQ3F0yehBJWXj+0c6ejRN6lVe4xGVBv6/pQ6HdZK16OcAyP8EUdOT6wBbFz
 u1u59gWq/ZgI6KR3Lrc6fy1e6+hpcp51uMvqG5AcU8yri2z34lKmmKL8bDTXi71sfeGB /w== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m67nvxwmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 13:00:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gt75cli/e4SrC49wJbOiZFcahTHU/09pixpjLyVLRCPOv3nLMKEQXoN468xAJue0EpzF8HZO6/V2GMHX005AOlEJkcz4XpZ1q7DA53N6uMllIpTmeKY/WQZ3hseEa34fHVc743OD0Y5BF1uQwFfE17MzYklHsbZwZrlsc11kG80e7PGgwqyPyObvmvt+n9OuX03VeqFqvpOs6PH01q0Gdp72fMhkz39f5FttZJ0JS3p0okC6JngZvPFzg5Rdyl79+lWvOiTORMT0m1yXFNSQPjTtlmqhAkAD2baPBMmZTCJYh9uGl/u6TkrwX0+qqDGJYb9cUygnbhCC5S3YzdYq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaJR2pjwTh+/Grz7Qudw9cfT/0WeoGmrj4Q7kgeQ5Ew=;
 b=n+juzqzFdbKOsgtleGKChv4RuC7JxmMhQrIuXIW5iVU8QCvOIuxczG6FOBMmoZ2Qfp/q0B8LgAWMQqjStTQBH2paQLKYemyU74ySs24KBne7XfD5UTqZaGszZl7xgt6p3Dq1UogZHQPiir+vXsqK1jLzLoH6lv2y+MsHDzVbCPahI93u1EKCyBcZAaGkVKF9k/slqBCgW5ahKJVyIxrHZcRl6Ts5APDLk2U/yPp2zGkmDk/BD1oU8YC3sz18IP3S7u7m5qRpbLfYPDYz4heW/sVWk+q62O2BsewBD5bJGwA5RvXJ3yYainq698wIhIesLBH99vAR6a2rsXYnOlG2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by SA1PR15MB4982.namprd15.prod.outlook.com (2603:10b6:806:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Thu, 1 Dec
 2022 21:00:06 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::563a:dd91:dd5:6a8f]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::563a:dd91:dd5:6a8f%7]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 21:00:06 +0000
Message-ID: <78b7a67f-8c5b-6b2e-7fb5-01c47d75c104@meta.com>
Date:   Thu, 1 Dec 2022 16:00:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [RFC PATCH] panic: Add new taint flag for fault injection
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20221201234121.8925fdf83115747ac4ac116a@kernel.org>
 <166991263326.311919.16890937584677289681.stgit@devnote3>
 <202212010838.B0B109DA@keescook> <20221201114848.13a87aca@gandalf.local.home>
 <202212010852.6D4B542@keescook> <20221201141426.08411b29@gandalf.local.home>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20221201141426.08411b29@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::12) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|SA1PR15MB4982:EE_
X-MS-Office365-Filtering-Correlation-Id: 967ff910-c223-4db7-1082-08dad3df0644
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: snK+HYnFBWyYAJ6kSl9xtKJmZeE0FAL2/fSzU9Lu5W0V06M7coCNJzB3IM0W5S/YVOMktHqOrEjpBugUCTuDOc3t61uaeRwIO0ZPns/bzbqqtIWOLPAvl3sLWMDpKKsrVzoiwjyyh3A7cKakYS6tbQNcl0HH39BCvM9dnSSGcrECViULR4LZifJaZHl6ZMwAtQdY2APsmp36J2TI7VeufO2l8vQ3w1nWSne1NMUDAA5UMxYsTQCpoADJ5DgJ6V/X2fY1g3tsG0bEi081B2JzQjvgMSOKlzTU44ED9Cx6xAyfzvndZSyOm1RLoRwbc+FuYj21frFvTCMeLcUNia2PIiuvOyuE4Ivh+0hpwnZRxog6Ze2zDyc1Z332trC7jG7S60vSY0UXmNssuI5hXpuxpif0QTB4bDV6BNr0K+XyQloSNdCUFH3HeLRmPrWFGxtz6FbbkSbKckJNUVVv2+inCjLArxZuq5+gza/4dJG+Xi+qnVMBVgHDlKS+5+kLi7db7q5pt6YN1DKFgA36YhcJARuL20974NH8uxbiirpUCYTQ0XcHUmTC0x/NMF0r+WE0/srIcVgdK6i6UP/CucwR4t9ZkmMW6+++QJVQETyR8E3YRxk4bNfmMXZB7IZZeD7KtH5fKoBwuQNSGuWBiJY34gunizl6IyORCtfZTbCH8o/cpfvn37+1UcSndFUHnlBV+lh2n3d0x9m9mPeFapjFAO3pusId+HLXWMicCqM6eOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199015)(4744005)(66556008)(6666004)(7416002)(110136005)(38100700002)(54906003)(86362001)(2616005)(6512007)(186003)(316002)(8676002)(31696002)(8936002)(36756003)(66476007)(4326008)(41300700001)(5660300002)(66946007)(6506007)(478600001)(6486002)(31686004)(53546011)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXVTM0wrSFo2WElzMnVCQ2JTdU5rekR3dE84Y1BlMDVXd2NDZThhKzlMTlFX?=
 =?utf-8?B?eGhSL0VyNzJCVEQzdTVVVi90cFlXUWhwU0NFYWJCRmswbjRuZjBHb1RQL2ts?=
 =?utf-8?B?R3BOSWZtQmRvallVM0Zhd3hGOXlVcnRLczM5c1BBNzBoQ2p2NUNzMnI3eXZJ?=
 =?utf-8?B?ZmljSWgwVitUZFpIQWYwOEJPeTFQR2FwcnVGS0xBV0s1ZGpGbStCUDNxblhh?=
 =?utf-8?B?L0labVozbFR6bVN4YktERUkzbUxMbzdrVmFQc2xyeENyeG8wWmhNSzBSOURD?=
 =?utf-8?B?a2FDcFY1WklKV0JEOEYzcmRjcE1WY2d3ZVRuN1ZuSXQ3ZkpReDVrTmg0ajUy?=
 =?utf-8?B?dkhFZnVPR0l4emhrTkY5dTRiSUljS0pSN0Q3dTJMV1Q3d28zUkphZUdzcTB2?=
 =?utf-8?B?djV4WFJRWjZWM2k5YlpqTExtWkhWYStoVW94QlBGc3FTZUNCdmhmMEZtUzda?=
 =?utf-8?B?eTV2M09rWnM4ajdLa1pDRHVuKzhtcUwxRng5VHdVL01wYXJTQ21MYnVpOHRy?=
 =?utf-8?B?ZlZGbUpBeFRZM0R3dys4QzRHa0I4czZhdUxOWmVxdlVIRGp4L09IeGF3MjZy?=
 =?utf-8?B?NGpqZCtjZ1FkckhoUXdtakZrak5IbGRKcTB0amdoYUN3VUpURmdhZGJwWXZr?=
 =?utf-8?B?eC94cFc4ZHAranRlTEJzMmQxL0NwRWsybmtIT2JUbXMzQTNRTU5OdFBidlFR?=
 =?utf-8?B?TE1KdWtrRU1DSE5UbEFYUjE3N2Z0Sy80a2dyd1F3czhKdTA3Mm5SblQ3VGtU?=
 =?utf-8?B?SW9TT1VMcHFjbjVadDVhWmRocHRka2trQ0tkTUpvRTdFelNlSy8wRExJSmJ0?=
 =?utf-8?B?eTFheDRIWks0T3JKcVErWGV2YktyNXVITmZ4TmlTVlZFUVJSZ0wxV0ZZKzBD?=
 =?utf-8?B?SFZnZzhxRU1seVNWSXUxajc0V3BCMENNdGdJU09MZ0twSEpVeXdHNU9DMFNZ?=
 =?utf-8?B?K0JPVXR5a0JzeEhINlBWakloQlVBZ1QzNVl2Q2Rkb1JsdW54NEF0RUloNFQ0?=
 =?utf-8?B?OWpPWW5KRVl5QXdMbUtIRGl4YXgrNWppanBYTVZjMmtNL0E2SUg0WVdXaVB5?=
 =?utf-8?B?a2RjVlRGMEhCWURWWFVoeWd3TmxKRG01Q2xmY1p4K1A4d3o3UTZVQlBZbVc5?=
 =?utf-8?B?ZCtFK1BnVytLWlV5V1dwamdNclp5dElBaTdzWW55b01DenBMUHRzRElWUE9N?=
 =?utf-8?B?VnVVWks1UFI2dktSWW11Mk9lYWNBazVjckxLRUNaTTRFdkRkRkRkRDl2ZVkx?=
 =?utf-8?B?amYxMjU4c3ZObDZiYkNJYUF3UHlWNGRQMFlsOFRBZWIzV29KNVcxcURqalBp?=
 =?utf-8?B?QzFZOXRoNnZZTVZvNHFrWW00MjVCdmdOSDdhVG5lUWlzMGFlYXNwV2tHTXV5?=
 =?utf-8?B?L0EybDlJYTB2N3daVnIrRVBWVUwvTFVJeXcvd3RwV1EvWFhoSzhLb3dUb2RS?=
 =?utf-8?B?bERIa3NsUUU2Wk5tQ2RWbit3S1dWemREaGNiY0tZZldteHpjR1IzOW51RzZB?=
 =?utf-8?B?dUI5cVBHLy8rQUI3MHo2bzdwTW5GTHU5NDZ1QlE1cE5FWkQ1Zk9RSjNHY1hB?=
 =?utf-8?B?QTJPWGtnTEorNkk1QjkxN1V4RmxndGpRb2FDTWRUWURiT3hzMzVIVmFET0pk?=
 =?utf-8?B?cHJ1YjVNR25ucmdlT0k0N29uZ1JlZVFXOXBJUFl0OGJwKyt3WU5sUlRHRW13?=
 =?utf-8?B?WTlvenpJVjRidVFXa0YwT0xvRDZnSHBXeEM5TDVrbnlJTWZGNGZwVEhYR2FV?=
 =?utf-8?B?T2NRMlduQ3l1K0gyOXVNSnUzZHoydlhIT1BOZ3pERnRKajJiMkZoeHdzTkpH?=
 =?utf-8?B?MnZMcjdJYVllOW5VL3phcWR3S0F1a1NETzNLSm9WVzRGZjYzMWE1N0tNTmJS?=
 =?utf-8?B?YmpXbjdZUVgzblQzYmprb04xckEzTys3d3pGME1VSjhiaFdiUUlqZDFGbHF5?=
 =?utf-8?B?WEtDd1FiN25CdU9QZTU1eWo4eEhBMm95OHBvbThld1liRU4vQjlkSzlFUVFk?=
 =?utf-8?B?dTdWcEdDNitxcGZmak1IOCsrRllMbzlOZXJRd1YvN0NWVUZ5S3F6MWxXbzR6?=
 =?utf-8?B?L0k2eHhUNDMvZytDcEhPRDltNTNXWm5oVkZtVEt2SFRScnBHWFNvVGQxM1VJ?=
 =?utf-8?B?MjFUbWxVVVJBaFRuVnR4UUxmSmJTU3hiZ1ZwNE9keGZEUElUeUtGTWdSNFFN?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967ff910-c223-4db7-1082-08dad3df0644
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 21:00:06.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uu4d9QBvp4Khn8TQTsUiHeGewj8o6rXd9DHwgWEI6/0FHd0EyzI24g34fYsFq3qh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4982
X-Proofpoint-ORIG-GUID: eQl_qB0vX9pVbdIaEw91cLIilhaC7Suy
X-Proofpoint-GUID: eQl_qB0vX9pVbdIaEw91cLIilhaC7Suy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_14,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/22 2:14 PM, Steven Rostedt wrote:
> On Thu, 1 Dec 2022 08:53:02 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
>>> Have you not been reading this thread?  
>>
>> I skimmed it -- trying to catch up from turkey week. If this was already
>> covered, then please ignore me. It just wasn't obvious from the commit
>> log why it was included.
> 
> That's a better request :-)
> 
> That is, please add why this is needed for BPF (and also include a Link:
> tag to this thread).

Sorry, I'm completely failing to parse.  Is this directed at Kees or
Benjamin?  I'm also not sure what the this is in "why this is needed for
BPF"?

-chris
