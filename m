Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019E773A29E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjFVODK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjFVOC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:02:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED211FC1;
        Thu, 22 Jun 2023 07:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cw4mwPHQ0/rRq+2Su8ooWfxFjCF2tgQTctF2VD3+12lh3w2cG5HxnO7AMlK3MC4LctHUVwvufH1vOOMpweWXjFzguLnLpqge7hzLMVPq9IUr3cCU2BAtXtrLxIfX2NmkYDgUgJDTQ8B9Inl9CtNgLk3kh7xhGbM01hIAEw9VzlOUvABUDUpE24GRDnTQIkA4yv8IDuFBsHaYWDPuCtCdtJnUeULIce0ouVLMM29aanMfQ5l4o9zRIHiNu4W62CV+hVMyU8Hp/zGc2juKcTN3XEVxFS8qDScHUpS6hzh1T0Dl6W/NTHYSkSoWAqn1NUegUYBPSB5I1HR4ByzPXFvHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICDj6SSf0MABL+1qT6m7qMjqrQpLU19zDID/i5SAgkA=;
 b=VaxgHqhlarF9rTQ7lArIC5MFmXp+cT3njsfzyuP3vWompeBNz7D0CfrVuCLP3iou34phyRucZWbLborpwt6NUpjEQnELrqgelkl1zi2kJ84AwGPNkJPkHxJPj2ZIbqU5qcYcYp4OYN3RSzL7vjr5e3jglztQ53uZpOFKPsT40UrH7ps75fWgZnQ9Hg8FUEd9uooFEDF219AQ11lgBrDKzje8dbS2kM/cnZHXNXcx59q4J8zoV67uvnoRWQTuxBJE/E7qOzVeiKLl6JusjBlXsMNn92aCAIaJ2w6elUO3jvizQki6em5dEyDvx1FastBggzy9KRSxuG24Z4zbHHOikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICDj6SSf0MABL+1qT6m7qMjqrQpLU19zDID/i5SAgkA=;
 b=1GrxaGU6RCTuAoEaTqahW59+6Xv+WgPpjRt+JmVoJv+SZfNw4dONDIFyEHu0M/NKBtzLq4vn22gyr5Y0lcT274bWKG5bS0Yj2uJIGd3Ei4RO4ttV8RzgTssRTA6bZ0ysIiS7pGp+inbX4J6ab8KHOBBf+ka1fkqefFnlsN4khQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:3b3::7)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 14:02:53 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::c39d:ccaa:b3f3:6b38]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::c39d:ccaa:b3f3:6b38%6]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 14:02:53 +0000
Message-ID: <cb2ca23e-dbde-7e1c-8e3c-3163292fd824@amd.com>
Date:   Thu, 22 Jun 2023 09:02:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 03/27] cxl: Updates for CXL Test to work with RCH
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230622035126.4130151-1-terry.bowman@amd.com>
 <20230622035126.4130151-4-terry.bowman@amd.com>
 <20230622105326.00006302@Huawei.com>
Content-Language: en-US
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20230622105326.00006302@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0985.namprd03.prod.outlook.com
 (2603:10b6:408:109::30) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:3b3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2748f8-f295-4351-f7ce-08db73295f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nORtekZKiEV/RYWAb8bcEPKWa9O4VmcBj1kFV9UNlqJBw6vJP3ULKBSANWnWlmzfLzAXgqyexj07DlF/Y+SU7OdS+YTqOhgXhd3pTSrMp35VKrP2+vAykwugooy/ECJ/RNaeIVTlQUXza39kCY8HGKG7GcOewjjEo7cXwNhkccAYzDephWb5feIbb1VJDjdsobfLXdyAu6JMbGMYfGAosNRxaLGUz0frR7cnIvZXp8XSgJoAXnCqRPd2fwYbo/BsmDXLVIidXzkDNhO/vdmlz0PEjVI5KriZ03421U7GzTina/0bM++k041GQQ0o38ZUfEYS9GWPPelU4J55heZdG9FLZPEOCmlypgd/MyGk37U9NgFK2hb8yD3XUVBjJ6/uLt5WSApJwhS1apqlRav0OYmehtNhnsUKYAGBBg82+ynUSMVef/FeSXyZ6bVlxVkTczPqCexjIscGhDT7myR/mtWBUfzVzHRwl+oudYtdcxOlIM1U+rGSuUCujr+qc1wYOw26J4yRl2cAi9rIhpiwK5EOk9s3XeN04rvbSfIF6k2DXrdNYq9RCYQjUpwsXVT1Rf3QUCJ9ssCBTLwg9L6gmL+HMKILSFJuLo5Wz73Bwp0+WVmjFUddZNWA6i5fMYOIifcQboV3Ov0R+w473a5WFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(2906002)(6486002)(38100700002)(2616005)(83380400001)(6512007)(53546011)(186003)(31696002)(86362001)(41300700001)(478600001)(316002)(4326008)(36756003)(66476007)(66946007)(66556008)(6916009)(5660300002)(31686004)(6506007)(8676002)(8936002)(15650500001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3pFb2xhekY0YkZUS3NJSDRvNmtkOWpCNkxnWFRYQ2VtZzB5VnlBeGxGaTh1?=
 =?utf-8?B?UExyTG8wZzExRGdZaWJIcUxzQWRuK2h0OU0waVdkYkpQS21PZ01rZ0Jrb2c2?=
 =?utf-8?B?YTNYQXp2Yk9NbXFQWkN3ZW81WG1sQlVoaHM3ZHpiK2NHNmZRYzNtc0tFejJr?=
 =?utf-8?B?TVBXNTJFcVExckxzN2p1MGdiTTU3S0dWTUV2TkhNd2d3ell1ZHowd3dPUnZt?=
 =?utf-8?B?NDBRWnVBa0k0OFdTRCtwNGlpdi9MdnA0ZlBvTzQ3Y2Nub3hiRUJHSUY1Tzlq?=
 =?utf-8?B?MGRIUjI2cWdxSy9uWkxQT0MwdWhzSk5nTzBMLzFIcUNwOGFOYnhNdEJYTWdQ?=
 =?utf-8?B?VXA0WG1qMkNEZVpCQzhzQWZVbnhTYzYyYWNoTHlkVmk1Sml2N0FwdHc4M29v?=
 =?utf-8?B?cStJNko4dmNLOXV2SGREZEdyMkFYVzZ1MnB6blozd3o1WFFtTHc2TXE5L0k1?=
 =?utf-8?B?clFZdXRnVFJ3SjJwL1p0b2l6Q1F3M0h3UDdQUmF1Ym01MzJlTGZMREJJa2tN?=
 =?utf-8?B?SktKSUVlc2oyOTJrMjNsR2xlSGJMbUdOMllWdGxUeVVpNHpDYjJId2hPZkIw?=
 =?utf-8?B?aENLK01DOFd6ZlROVzA1cStkc3lDUXJrbW1za0dIeVIrRzhKM1dBUkdUZnhw?=
 =?utf-8?B?UTZOWG80bWJQTDBkNDcyV2RjZmZYZm5mZFlVSVhObWF0aXVRRG1nZFVzZytL?=
 =?utf-8?B?WTZTbllkc2dFejR1NjBMNXRXVTR4VitDOVlSMmsvbElzQ0t3OGVtU3YrZGho?=
 =?utf-8?B?dnVEMStyeDdxdUUxWkhLNldOM01OUndRbWNyc2F5WFBZblE0d2dFTG9RbUJv?=
 =?utf-8?B?aE5NSHIvUkVQZm5Vd2U0QlY3ZC9CSEwwSGxyWGhGK2t1S0lmS0x4QTlzUzZY?=
 =?utf-8?B?UmE0UEo4anl2K2FrbWRhRkthbjFoV05yZG01YldsVWNMU05UcUVYZ2FDVi94?=
 =?utf-8?B?bm8veGVZV3psZ0QzSEFyWithWGtYbWZJNnF3ZGppcm1SM05VTlphaVR1cndR?=
 =?utf-8?B?SnZKaGtMVlNCTGF5UVlzRWFPTy96SXhycjhKZXBXcUc1MnEzbC8zdFg3Mkho?=
 =?utf-8?B?ejhNVXNKcVZVWHVFQVluT1JERUdJOFQ2OStZOXVUZnphWFZZV0E5aUc2c0tp?=
 =?utf-8?B?QnNtdlo4bUVVTlZpNC9RbExySTFGRUJWYmp3ZzMvdTVDUVRVMDVmYmRFNzg3?=
 =?utf-8?B?YnZCRjdDN0VLN2Vkd1ZWOTJNVTh6ajVJWGx6czV3emhFMG1YYytDbWFHSHli?=
 =?utf-8?B?bE5OUTZPbUh0UEdXQ1hkeEtkamRwb3NFcU0zcFBUdjJ0T3JMUk9MS0RKTTBZ?=
 =?utf-8?B?RHN0SHc2aDFCL1ZOQnBQUFEza001TGFBRU44cUpvd1REY1VlUDI1S1Jka1lt?=
 =?utf-8?B?V0dIMFk2aUpIalFVN1ZUSXc0YnZHL0pVQWtaY1NQS3pZcUdiSlhvUUVSR244?=
 =?utf-8?B?UldFK0huZkFtelpvY25DdmFnL0Iwd3dhSG1CeVlLTnlQS3dXUURQYkd3d1d2?=
 =?utf-8?B?U1kwVGM5VnVGdmM2OUpyaFlFdGl5UFNxaGx4czR3Y3hkbE1lVWFCZFU0MFBn?=
 =?utf-8?B?WTh1bUx1TGNSVEI0WnN5UnNXUnVKQjE4Szk3dkdGbnprTzRVeG1KWEd3Y3Qw?=
 =?utf-8?B?YjRJdkE1Tjc0bU1XV29TTWtOVVR1c3BDTUY4MytYa2tpZm1mT2dvTlU2RmNH?=
 =?utf-8?B?SWJDU1RZYWNxcW1CZjE3R2xLYVQwR3FpYU9RQUxkS1ZTcWJVZGxqanhFdkRu?=
 =?utf-8?B?MDArOXV5aUd3ckVwSk5hdWh1U3NHUUhsODR0cHJoK2sxVHVrb1Q4SjkxMktj?=
 =?utf-8?B?K3VpN3ZFQ0ZKY28xbnVIK0lVZ1J3RkdsLyt3S2lGM3ZGTDdjVU1ua0J4eThh?=
 =?utf-8?B?ZER0MndxQzNmWmw0UUx1dTdRRDlTMFR1alczVG9veFR1TnFIaktvR2d1aDMz?=
 =?utf-8?B?ekNwSmJEMFEyQUUzODJmK052VmFpbDNlSHZ3Zk9oeFkwUENWeEx1ajBOVmNh?=
 =?utf-8?B?Wkd3VkRoZmF6Szhoa0d4Y2RwZjQ2OURKclJuNTZ2bWp2QzN2QUZGWUxnVi8z?=
 =?utf-8?B?M2puMHVhMHQ1cGxYQTc0KzNETmZrRFJkclpzV2UwK09BWWdNMTBMWS9pZGVW?=
 =?utf-8?B?YmhZRURDNWlKMU14TlZMeTg2dGFzc3lraWpjMkgxR3A0ZlBvUDNPT2x0S0dV?=
 =?utf-8?Q?yvxzrFoMf1ggxDY6RHicEQTV4lL799g/MjH5jIKHsTUp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2748f8-f295-4351-f7ce-08db73295f29
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 14:02:53.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiGl4ThIyHvciZ5+uVjqW+QILc3eMfC4Fu3KgJ3pOqqg5tJL15naG9mpHXm/6lubILwnAn8pKdNEv/lwq60lvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 6/22/23 04:53, Jonathan Cameron wrote:
> On Wed, 21 Jun 2023 22:51:02 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> From: Dan Williams <dan.j.williams@intel.com>
>>
>> CXL test needs to be updated to work with latest RCH changes.
>> Add CXL test support for devm_cxl_add_rch_dport and
>> cxl_rcd_component_reg_phys functions.
>>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> This chain is getting confusing.
> 
> Why a SoB from Robert on this one?
> As Terry sent the series I'd expect Terry to be last unless there
> was some codevelopment involved in which case that should be indicated
> in the tags.
> 

This was a mistake on my part. I'll remove Robert. Thanks for pointing out.

Regards,
Terry

> For weird corner cases it's worth adding some comments on why a SoB chain
> is non obvious.
> 
> I'm far from an expert on cxl-test so I'll leave reviewing this in
> depth to others.  FWIW looks fine to me.
> 
> Jonathan
> 
