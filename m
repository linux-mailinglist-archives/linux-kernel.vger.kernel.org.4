Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D303D6EFD23
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbjDZW2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjDZW2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:28:01 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B78D269F;
        Wed, 26 Apr 2023 15:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMVL1esMM4X/IQSsXASSUjZKjyOvroF9KMsgQfUsdn11oC1nak6vDYF1Y4l5F065NxYcJ6VZUXM2OR6c1MHxmMxZWc08fSMX1kX0mi2FtQt8131tC1PtadrKwrYEqy2Hb4j74Losr2DaWsXz6/CAwUMlp1vJTV4BIc46dJvj1Z2l8bITxuvgn7fUH6+RA3CoSuuqUdOCpr6rnKbozyrArtp0pvb9fdgU9q+bgYe0cX7OZCSWt3KoRfGPAJtxcCNuLG/lcT3GSDH/WhzZ7dmyhIJ2AaXaXmSCSS+gL8d5bj+49ILKrM013qGQ/xkCw/97bjo3PqeYVbssDZqrjRFh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwsrljwOOVl1pOSMfTqO8KGwpiRWqyMHBo8fWc01l8U=;
 b=mGH6TZSkuSQPHqcb9FelufwQmkqvi342toF6Pe6Af8CU3uaOrvCjV7AYf2ZAIbs1TsuhauH/ECVQRgM1Sw6FAw2TmgfD03mft5pkdSYl6/SqOtsTGpTo4Jw+4ADW0qbMkBSHpWaiULiklgl7M1Ya9UEKr8Yn5EenT61CCZU6SHRqEIdQxo+FsJaqkV+4zMpdfBKOu4s3aLBv4aBqt1RbM2bcYuWXpi5Gg4K1lfIWa6621T/rbq+0Q/9S9E+914u2II4pcqMAw83qgtrfiHKUFSYEcucMqGtgeNkgQKxRj3Ni6QGJ+RSlTwqFhX+tJtIwKXcAOp5F0FYd16EYfvqggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwsrljwOOVl1pOSMfTqO8KGwpiRWqyMHBo8fWc01l8U=;
 b=MJnPwaidyDroafRBG+I992NNyK4sH+pKTgo39vHuGlS0zLLvOwKEd+hN/NYgdcBn9ntheVMw42gxrOkIRLhJDWcbyooTUrd0yjVDVSgqIPdaMze6KAHatR63h0mhfHp8di7YBgvUSryLgOIk1EUi0+by1cg6w6QwUINZLiJde/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 22:27:56 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 22:27:55 +0000
Message-ID: <893accb9-e961-a922-8fa7-81a558dee138@amd.com>
Date:   Wed, 26 Apr 2023 17:27:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat
 model
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com>
 <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
 <9fa5ce43-584d-878d-227a-fb458254c00a@amd.com> <ZElIjw7Ca6N2mYHe@google.com>
 <9021d861-cde6-a51a-7d8c-b3f67eaa01d8@amd.com> <ZEmBULXp24oMxaUH@google.com>
 <04383d21-b71e-93dd-5f4c-b39f5bc21937@amd.com> <ZEmYR0fWl05lGW0d@google.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <ZEmYR0fWl05lGW0d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:806:6e::34) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 8621bbe5-8e17-4f90-6a66-08db46a57b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8Gb2sXJIjxKG7yNeAQ0hzWLyEqJsPupyManyuz/ZcOU9FGt5ylB6ylzg6wXRNVSXxYeJ0YNovlbLs8TNVAwZIO6qf0Qzj5F0wQcMFy1dVLJjCIwDK2Jh91NUvXyZAw6YjEYh6phsb7wSZ+Tb97hBNgPEMUlGlpEAqdvQm11Y/oaxZQ5R22ewOQe4saJ3X1OTLh2ANQIugsM0q8ioUoX1zLo0caBfA1KgI4NI3447G+Z1T3CoZAm6mVmi33yimhU9lpkPeqp+KUuTLiReKNxE+eCbAMohu29PKgvCmRa3fAr8galG8/bAAtbiB8h2C4iqsgCrDH3KczUNCHN2aQ2UxoFLlCqF/o4L7nLRI/iETumm8xNyXzf4NVlzrUhrjaQ4ZjpBzoqUMdAIWGa5vXUlT4mtUSbBpvlZLka3b2eg7PfrBmler14/I5/hNvOJPApNkNSL/N3Ms4cNV384NEnBakQzRnM7Xa/jIozNAH84m5tUpOnx4IM2v9q0uguFNb0pBfgPiZNyBs9yHcaVHX9kF5qBkZ7Qj7srkYv+QQaefhZYdXetd6WhN7v2wIiDCbapp3X4bPpSgfvC2Exw05fnD5Coko9hyC1PcJ9NoNCsaJWyJYob7yv8S7eZYQuJkOPGnIWumXI/HoIS/uL+171Zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199021)(2906002)(15650500001)(66946007)(66556008)(66476007)(7406005)(316002)(4326008)(7416002)(6916009)(44832011)(8936002)(8676002)(41300700001)(36756003)(86362001)(31696002)(6512007)(186003)(53546011)(478600001)(5660300002)(38100700002)(6666004)(6486002)(31686004)(83380400001)(2616005)(6506007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnRpa1dxRE8vQ0tMbVdpcXRTbDBmclM4WW5zdGdUNWIyN3dtcVA0L1B6WXVX?=
 =?utf-8?B?eDdFNU85dmRxbGZkTGdOSVJSbnYrc2FVNlJUeW1jN1B2ZEdZcWRHRGtWSzIw?=
 =?utf-8?B?VW1yeGJQZklKYW5KR0diVnMyRk4zUWlPcVFuN1BIV2FmMWJDWmZVamZlWUZv?=
 =?utf-8?B?WkVraTJBQVNLMW4wZVl6TWtzeGtjRVlRNGZvZUtIREFDNFJKY0hxRFdLb3l2?=
 =?utf-8?B?YkFvalFmQUdBUXJnQXpKQjlsY0p3R29WMUxUZ2prby9LNmFnWEhtK2pKbGJC?=
 =?utf-8?B?bFRoczNveGxXTUxBYi94d2hLSzVLZE1xV2FBT1JYNlVxSTRTZG5GK1NRTzZ1?=
 =?utf-8?B?UFVrQjR2b05OMEtqYjhVNGYyRC8rb0k2aVJSeXd2VDFnVnF2bU5aditCcG4z?=
 =?utf-8?B?UGpMM3RCZ2xkMThHMUlrZnphdE5qZnIvRmQzRGppSXM3amRJWVZvcUlhYWth?=
 =?utf-8?B?aTExbjlZR2ljd2hrUW5kamk4dnFvaVl5NVVOUnRRZXJiWHhyS1VqQ2UwNWJa?=
 =?utf-8?B?c2JBS0EwYk1TS0J1NlFUSmthbWhidFg4QlhmMS9GeGluOGxhbTN1SmFVMklJ?=
 =?utf-8?B?N0pXZ3ZHc3hEaGM3ZnVCR0NlZTA3TnhEMHBCVDR0UU83T0VNemNUSnJFckw2?=
 =?utf-8?B?SHExb3hsWkpoN2JRelNZd2xSK05uS0svMG1pRjRQdzhzdy82OVo1b2kwR2hZ?=
 =?utf-8?B?c0lzYWNtSEFJekEzb2IrWWV5NWJobVZmbHg4TktPKy85cmowVHRmb0Q2QlJz?=
 =?utf-8?B?T1VFdUpJZWJrMEU1d3lSYW9lclQvaC9HSndNemVQTWZxcUo0cDlYQ2Z5SERr?=
 =?utf-8?B?MGRDMFA5UkoxWHloRWZGbWF4cGVUS2ZSNVZBZU1DNENNZnNEdFBUSHFaVHJ0?=
 =?utf-8?B?ekFadllrR1VuYjROV2N2NWxMZjFLWjNGN1U2eTE0bkRML2NvUEMvS0NEZTV2?=
 =?utf-8?B?NVYvWFRzN3VEY01ZQzUwNVZHYnpLS1VhWkNPTEEzM1FuN3ZuRXJLMG43a1A0?=
 =?utf-8?B?TWErcTFrZjBhVjNqRkpCV3gyR2w3T1M1ekhxWXZ6UWphcC9JckJyT1BqcjFG?=
 =?utf-8?B?UDJCYTJFZ0YwREI0aHBRTHBqdk1IUUFlM0l0ZDZRdkdqeUJ0MlVUaE5SUXp0?=
 =?utf-8?B?UG9rbVUwN2VOZWtndmFtOHBzemc2UFN6NnhMOGoyR1ZBQW54VDJ5TGlmWTFi?=
 =?utf-8?B?YlVsdWZuU0h2bEZhRUlzQ1E5TWNEM1p3ak1sV0Jmek1jQ21teGtmSXV0ZHAx?=
 =?utf-8?B?b3hGTHBvZFh1TzhUWHNjU2VGb3IrckxQUUI3aDcrbmw5T1V6blhqbkFFR2lh?=
 =?utf-8?B?M2twRmpZS2lrdnBsTEV2SU11aXR6SlhsWm1iaW9jMU5qUjZJb2ZkZzk0aFIz?=
 =?utf-8?B?NE9xZDg1eXBHRDZseE82SFl2MVJaQWRUbzR5MnBOcHlHZ0dNaTMya01POEd4?=
 =?utf-8?B?WmVtSDJCek9QVnZSVnErV2lzR3VObnFsU2lQMnVjYlpmTGZQU2trK2Nic09H?=
 =?utf-8?B?d1E5cUFTK3FmV2VnamtNTkJDdHdDSDZsT01qcXZNaWhOaWN3MCt3WVEzdkRh?=
 =?utf-8?B?N0hHT1g2TXJSQzkxdFhRalRVb2xOK0lIMEZ3SUlNK1NPbHhkV2xSWmp1dCs4?=
 =?utf-8?B?ZHFRak9HYXk2bFg5eWZ0ZlU5Y0E5Mk1RNkQ5c1lhY1RuSWMyQ0dlUEc3ZXNj?=
 =?utf-8?B?d0VWTGllTGRpYjdQNm1kVXRkSmRITUkvY040aTBxUU9jdHYrNGxQcUhHRzUr?=
 =?utf-8?B?UmhWbXNUOUJzdU92YnZNRzc4ZkZwU2NkTjM1N3RkaWRFUU04VlVPTnJqcVJH?=
 =?utf-8?B?dEgxcGs5bHFnWFFaNG55RlpnMUpHRkxsZVpWUFNJUTE2ZUpIVVlJKzdzT3RL?=
 =?utf-8?B?NkF2SitNaFRvc09CWHl3bEp6ajZqSFk1bWVmSnFtM1JYTzRLM0ZndGIxSFZ5?=
 =?utf-8?B?SXd2N0QzeG9nOEh6RDM0anp5cm5Hd3pHRzVvWjBjaXVGV0dCenJ2aDVVa0Yy?=
 =?utf-8?B?dXc0V0Z4REFYQWtEYkJkaUZnVXBvQXM2eEQ3MG9TS3I2OU1xbEF4UHEycTF4?=
 =?utf-8?B?cVYyR1FXdkJVa3oyelk1TWZRZ2d3WlpJeG9SanhrcEg1TFZ4bDFmQ3g3cXhR?=
 =?utf-8?B?N210Mk9VY3JvNjlibGdSVWVmd1pJZlVkRHN2dWNrazNoTWw4K0hUWk9nK01i?=
 =?utf-8?Q?YlM/cjh2LWTPb/An8HUcQMF2Qk785FZeCDCqssZBoXCK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8621bbe5-8e17-4f90-6a66-08db46a57b2d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 22:27:55.7031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dn4D8TLl66XPq1vC9mOQRmiDilKkW41aBALOhXeIVWvfCVqgm2mufL6A4ZXYKPexORVAgikXeJAaHlTjgCxKYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 4:33 PM, Sean Christopherson wrote:
> On Wed, Apr 26, 2023, Carlos Bilbao wrote:
>> On 4/26/23 2:53 PM, Sean Christopherson wrote:
>>> On Wed, Apr 26, 2023, Carlos Bilbao wrote:
>>>> On 4/26/23 10:51 AM, Sean Christopherson wrote:
>>>>> This document is named confidential-computing.rst, not tdx-and-snp.rst.  Not
>>>>> explicitly mentioning SEV doesn't magically warp reality to make descriptions like
>>>>> this one from security/secrets/coco.rst disappear:
>>>>>
>>>>>   Introduction                                                                    
>>>>>   ============                                                                    
>>>>>                                                                                 
>>>>>   Confidential Computing (coco) hardware such as AMD SEV (Secure Encrypted        
>>>>>   Virtualization) allows guest owners to inject secrets into the VMs              
>>>>>   memory without the host/hypervisor being able to read them.
>>>>>
>>>>> My complaint about this document being too Intel/AMD centric isn't that it doesn't
>>>>> mention other implementations, it's that the doc describes CoCo purely from the
>>>>> narrow viewpoint of Intel TDX and AMD SNP, and to be blunt, reads like a press
>>>>> release and not an objective overview of CoCo.
>>>>
>>>> Be specific about the parts of the document that you feel are too
>>>> AMD/Intel centric, and we will correct them.
>>>
>>> The whole thing?  There aren't specific parts that are too SNP/TDX centric, the
>>> entire tone and approach of the document is wrong.  As I responded to Dave, I
>>> would feel differently if the document were named tdx-and-snp-threat-model.rst,
>>> but this patch proposes a generic confidential-computing.rst and presents the
>>> SNP+TDX confidential VM use case as if it's the *only* confidential computing use
>>> case.
>>
>> What part of us describing the current Linux kernel threat model or
>> defining basic concepts of confidential computing is SNP/TDX centric?
>>
>> IMHO, simply stating that "the whole thing" is wrong and that you don't
>> like the "tone", is not making a good enough case for us to change
>> anything, including the name of the document.
> 
> I honestly don't know how to respond since you are either unable or unwilling to
> see the problems with naming a document "confidential computing" and then talking
> only about one very, very specific flavor of confidential computing as if that is
> the only flavor of confidential computing.
> 
> So if you want to push this doc as is, please add my
> 
> Nacked-by: Sean Christopherson <seanjc@google.com>
> 

Well, the intent was and still is to work with the community to collect
feedback and finish a version were all flavors are represented --see
Motivation section of the draft. But if you are unable or unwilling to
collaborate with us, just please make sure to read whatever is the final
version. I will assume it has your Nacked-By otherwise. 

To the rest, please do point out to specific parts you consider to be
AMD/Intel agnostic. We will do our best effort to fix it.

Thanks,
Carlos
