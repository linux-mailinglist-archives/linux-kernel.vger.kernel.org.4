Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7716EFB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjDZUPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjDZUPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:15:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5FEC3;
        Wed, 26 Apr 2023 13:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8BTuZppGN+SmgpwDutLQIxUttPso/48ZCRkxuCrNDEC+x8JFFw2QEEkVaoFl6BYPbL33Fejva/dRzCzIPN7qU/bjRiY1Z3c66YB0weHcV6HU63vGYuMnA51F2KZlIEFd/H8rD8RkREYU4wQkm7612IJEFH4jqhyKVfmvErUl7ptOcag8x4knq7/4qA7TQPIhrk5/i94d1VnpdSte+rDE0hftdpAoyJw9bmMKJMy3Ls1816JuwZayJWjcoT27AZyPpZcO6prHgXh7a8azhIXcNViGFQ1VU2+nOS+Iqc2lZIM0JVOXXdOSSX9Sz3ILFRRdajfcq1xabTz5+IOOz1OPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBxKneMgwX3TpWqMgQuBSXAu0G0In3g4X1WnxlUg76M=;
 b=ghj3SgWw2rw3TOU5TVsag2+UnoQgRmvlYqWGHHDEyfsocxdYuq/xBF8929janVmyctNzaeUpGIwYtkGAylfzLnq/sqHXb+pyDvjmFfWDR3FiIQSabQpW2gIVUReJPsDhAJkPK8AofPkeZ/0aWio+kN/eQ7rpp2y3LV3NLxWVKXjG5E1TURs79Avg5VvkhqEKkO6wGlk4mEYxxqffvSb6J972DRgOi15Oy4qFiNJRMJYpeSLaDF1KahjsLCDaY7WYLDHLuZv0H+vmp/JUn9T2J+kyb6+y0tsOz8oop8xydsui/nj9YsoRXaRea+ym1inO18VlnO6z1pEkqlbGM0zlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBxKneMgwX3TpWqMgQuBSXAu0G0In3g4X1WnxlUg76M=;
 b=qBM0vuyL+oGXNihrkvxDj2ZlYlCq9RrOAL9ebcFjqMlnVeWiRrfN53JzdMFM37r7IifSRgBPafHzNobb3W772vxNAIzip0WqLt3OtG+qgH5rex2xj7aFW8+6hcF9B0CP+aLKZKDHd3tv8scT3NhHNtv7zB+hvG4o2pj6denoNw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 20:15:32 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 20:15:32 +0000
Message-ID: <04383d21-b71e-93dd-5f4c-b39f5bc21937@amd.com>
Date:   Wed, 26 Apr 2023 15:15:26 -0500
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
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <ZEmBULXp24oMxaUH@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::20) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddeef76-82f2-4b59-eeb7-08db4692fc2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTewn3cXUzgVcAxx3siIe0Tfh+xg+qjmS/jauokd42t+pY7kOhZWPbgJGVxg4UZzo41LmVn6oPEayeShBhEscERb/lCjVpt3zb09Dep2vTa0Kr/RFmIPWVFXPXpKAkq81PRaoEuvW3+s4P1U/9Wu2kv1xUerQaqCYVdozMmcp21MK518pAxq3YacwrSRSKBC7hLzr9y2kyBqDu5Cec9CMyqctjpOvf9R6odm9gt0QRF3n3430S0NFhVQMpJLwWjPMSeZz/1ZEqsEPC8BcH/CPEBNU6e9MDAIsSL2CrO/Um1rB7JlNFgmjgy/YBPs9I9ZI/JLMSB3l2A28FoQXPPJyD2JZvh3zQPnrkZZC3T0h3jIYejhF4k8QirLJGX4uDI71ySdC7wWSJx53QZoGFEJmkm9X+M+3Rg49ittZigU79cyLXIRIM62oT8qXoJtdR/ZYXEnLKMUy4DZYPBYFhKDwnnq+YMV/w/IdxoTDxrDOUnu1jobD1VcHppzDCwjs1k3UigpxE52/43wuPpBgjgUS2umCUFM/vuSorN9EyUjHP4hHgBpLTyU0+a9lbtPf9yyfkiCzhIA2hyAcG0l97B84lK4AHuDiFXiNmVDtiMJFZG+8bmq6rsGofQZoaLU/lcvsyMK4BTpaRGgnlZvE9SFjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(5660300002)(8936002)(38100700002)(8676002)(86362001)(316002)(66946007)(66556008)(6916009)(31696002)(66476007)(4326008)(44832011)(7416002)(7406005)(41300700001)(2906002)(15650500001)(186003)(6506007)(6512007)(6486002)(36756003)(6666004)(83380400001)(53546011)(2616005)(31686004)(478600001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFIzTmp0ejZURE5vYlNERmNsS0dvUmRTNXFXNjBJY2ZQOC9BWDNuUE5vY1NG?=
 =?utf-8?B?ZHJFVlA4RW90MmlpdE8xdlViR2FabUxsSTF1aVdGSjRTVTRKQld2N3hRQVVE?=
 =?utf-8?B?T3VkNFVvWVJCbVJTK3ViV1NNSHF6azRkcEZIQU5pQVJGVlZ2SVEwVVR4SWZQ?=
 =?utf-8?B?b2NZZkpoeEhpRzhsMk40K2ZHcXJmaUJHZ2RGWnFvempNZjRGUS9GWDg5NjJk?=
 =?utf-8?B?RHQvL0FmOW40UjArRnlZZnBsU0xVcHQ4NThsMXpJcyt2M2J4VVpBWFM2RzVW?=
 =?utf-8?B?eDVJbk0vRjFSbk1kYjBRd1NYOEpBaFJlOHNZdFd3b09uMDJLenAzZDRqN2o3?=
 =?utf-8?B?WnRiNm5tVGxMOHBtVU85KzNrZ0h2UEJVcUtxUFhKZnZEL015M0h5VFNCc3JC?=
 =?utf-8?B?Z0JrOXcwUldJdThyR1Y0TXAxWWhiTkZ6RjhlanMxQjNrcXlKWUt5Z0IyTmtM?=
 =?utf-8?B?S2hDMEZjSzMrdGFQRk5qRFV6dS8wbytBdWlDMVFtVG5zazNjSXNETjlzOWpi?=
 =?utf-8?B?MFlNUTlwdjJvTFpTVm0rcFVVMjBCSzRnQmtZTWRxM2hnczlOS1Y2VktVOUpx?=
 =?utf-8?B?OWtqUXRGZlZ1M1k5N0JmOGg0OWVtOHJVVm0zQk10UHNhM2taVk5NQzIwSHlZ?=
 =?utf-8?B?NFJrVzVCeFJjNjRuUEdWbXdHTytYRHFDbmN6S1REUGF4R21ndnZJRUdWZS9t?=
 =?utf-8?B?SlowNzVyejE1RUVSYTlFVitMRlhhUmFzVDVrTzkwa0s5WldPOElSbDhaQU81?=
 =?utf-8?B?eEN6alk0UldMKzg3YjIvZ0hacHcyOFJ4Z2pITDFldEoyU1Y0azRpcWlLdmhH?=
 =?utf-8?B?OW9hSFZ5U1BzQnhWMXFLVlFGTmYxOUVMd1F4QW1hQ21oZjlac0dGZVFxZXRt?=
 =?utf-8?B?VERxY0JFUU9zM1lWdEUvV1F6Njd0eFhMYTREaE02WkFjek5FOVoxbXVxNnl2?=
 =?utf-8?B?eFE1YmlJN0lUemNaR1h5K3UvYVlwdnJlWFJLRWsyeHF0TkUxcVhPRFVwK0g2?=
 =?utf-8?B?TG1jWVFJZzY3a3RPUXpoeENiK2xJZVM5a0owRWdpUFp4VncxRXdlWTB6Ui9B?=
 =?utf-8?B?SHB3cDgzQ2EyQmlYd2ZVZjBoanNGVitheVJCQXRtYTVzS092TkNNUGU2NGY0?=
 =?utf-8?B?M3hMZGZxbWk5cWdiWEhCUjJBNThWWmJ4SHRyeWFYRHRiaUdySFprMVZBSlNK?=
 =?utf-8?B?ZHhBOEZTakoraGQ2Vk9LSEErOC9MWEhoQlVYbWtRMGl0cEpBTnlmSUpSYTJL?=
 =?utf-8?B?aDVTc2xHVVA1NUtVblowTGg0bVJlWThEaldlbXVnYU80K1hZRDJUblRvQTE4?=
 =?utf-8?B?MlRmWDJhZ1dJbHUybkRjakxnREYwelhIT2dSdVJNT0RXMHFnTkVBS2kvK3pU?=
 =?utf-8?B?dzBzeUdiKzNqRm1ES2dkOENaY1ZaaE1LcThyUjg2YVRnMGZ6RHoxQjBLeVJs?=
 =?utf-8?B?M0t3NUxtVmMvSVZCZDdiTGdXbXZBY0lnS0F1WnVYbFZkdzM5Sy9BTjdHV01t?=
 =?utf-8?B?RFd4Zi9KTXQrSlJJZWlaSHJEcWt2SXBMejE1NmNoSTUrbkExS0lCeTFnVjBD?=
 =?utf-8?B?UDJQeENHY3lDUkczMVdTMFIwbkw0ZDJBd29xY3Y1TmgwdkFjTHRmWDFxcXFH?=
 =?utf-8?B?SzlZaW95YVB5cVg4QmdCaEtuQTBJenYxcVNiYmNnM3V0SlV2eVJlenp0Z1hq?=
 =?utf-8?B?VXdOaUd4eHNYQnF2ZFhkR0xXeUVFVDhUVW80a1YycnBzeUdYYVdTcUgrc1Ex?=
 =?utf-8?B?THB2OTRXenE3aUtiUFZDSlpsUmljQ2g4ZG9FclpxR3o3VzhaM2JqN0lIMkdi?=
 =?utf-8?B?NnVDdXREZ2Nib1dZMXB5VWpVZStxOVdaMjRyWmo1NVJZaGRrNWdyWWFZdVVW?=
 =?utf-8?B?MmJjZWpMK0ZYMFpRTDZFK2dQZzZaTkVuNFRaOEM5ZDZzOVVIZm5XUWhtclQx?=
 =?utf-8?B?S1JPbHpVRFFtbWt1WlVib0NrYU1XZklUZ2ZlS0YxNUZOSndKN01od09YNTRN?=
 =?utf-8?B?NVd3bmhMa3hzZytQaXhVYzRaaUJ4ZkpOSzZsWi9rM0t5ZGNZVzFrV2hySlFG?=
 =?utf-8?B?ekFZWlRzSWh2RTBPblhiRjJ3NWZHSndnZkhTRWF4c1R4SFo0TGhjd0ZQRENN?=
 =?utf-8?B?c3FFdmFrbDVRRkxIY1BRT2w5elkxREtDWTNzN1RhdEVMMjlCVVM5NGx5T0NT?=
 =?utf-8?Q?I0i3syCnQpgddyFbVC3BKzM/K3nRpmK+BLyhGfRrEtL5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddeef76-82f2-4b59-eeb7-08db4692fc2a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 20:15:31.6652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbWbG7KyLVcEPDsNk+R4kNzeAnngJsw4E6TiwN/QaSO4Gd9OI+xa2vFiy2nPzdJnMZ9SuapP8kV1MoyBVYM4pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276
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

On 4/26/23 2:53 PM, Sean Christopherson wrote:
> On Wed, Apr 26, 2023, Carlos Bilbao wrote:
>> On 4/26/23 10:51 AM, Sean Christopherson wrote:
>>> This document is named confidential-computing.rst, not tdx-and-snp.rst.  Not
>>> explicitly mentioning SEV doesn't magically warp reality to make descriptions like
>>> this one from security/secrets/coco.rst disappear:
>>>
>>>   Introduction                                                                    
>>>   ============                                                                    
>>>                                                                                 
>>>   Confidential Computing (coco) hardware such as AMD SEV (Secure Encrypted        
>>>   Virtualization) allows guest owners to inject secrets into the VMs              
>>>   memory without the host/hypervisor being able to read them.
>>>
>>> My complaint about this document being too Intel/AMD centric isn't that it doesn't
>>> mention other implementations, it's that the doc describes CoCo purely from the
>>> narrow viewpoint of Intel TDX and AMD SNP, and to be blunt, reads like a press
>>> release and not an objective overview of CoCo.
>>
>> Be specific about the parts of the document that you feel are too
>> AMD/Intel centric, and we will correct them.
> 
> The whole thing?  There aren't specific parts that are too SNP/TDX centric, the
> entire tone and approach of the document is wrong.  As I responded to Dave, I
> would feel differently if the document were named tdx-and-snp-threat-model.rst,
> but this patch proposes a generic confidential-computing.rst and presents the
> SNP+TDX confidential VM use case as if it's the *only* confidential computing use
> case.

What part of us describing the current Linux kernel threat model or
defining basic concepts of confidential computing is SNP/TDX centric?

IMHO, simply stating that "the whole thing" is wrong and that you don't
like the "tone", is not making a good enough case for us to change
anything, including the name of the document.

Thanks,
Carlos
