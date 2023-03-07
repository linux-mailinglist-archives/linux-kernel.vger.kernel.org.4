Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E256B6ADC71
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjCGKxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCGKxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:53:05 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761E35BBC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:52:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJfxHtL4FP+eL0i7oE/hA1/t7J5yBmKeLH4EB4o3hgLMVQfYVxGNz2Qdh6uhbQdnQgIY6mPDg2sjlVorjhzxP7p5kegcdeyU3tUBqj0O7XXBbpqy26K28r8wp+v5BPguJ7ZbuUPXQU6/PbimKBRaed4p6fzoHNirGHgKLXppSoiB0GzI8VQRZC7k4C9dEs1hidbUuB2BDEY/hOJIFLNrh949j7TuLDTPnrbwBp1U91YiGcrwkdY8SbnYfHrCN/R7WkUa03EKWDrWIavikuUGAvPHt9qcxjMfDNbYkMbysfenhW+uBks3keLZ22147YU9mGFLg1LGH5L+8IyGUCv94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReLoOJudtGsKxI/vPsFdH/VcYWf9Hqf9TlmGx1UMy+o=;
 b=CMwFsaz9HowCGgKLb6tOWKi6umMWmjSPPIQXLcCQe1jefQTrqy6xUTDaLSC7RF/QwBkAhNmNsJP61uOa2nzNZ/phMxAZ71WeSHKFkF/L/E9hcYM+4YQpMU+6xJyNraRJBwxA6/AEJhrCDjc7GyECwEku0srh4/CL7pzo09VTMGatcHxk6xm42rEIiHgYHoOG9SDNDol9UUB1F76TlYHNVSlOYgbnhtNAzqbD391S516ts0mKMH0CAz3/wlBk1DmOhmNS8KKx5kbwRKNs1hlrvtXT5acB2ijFx+H75XXDXe8mX9BGsgwm+/pkaBsnvbcubjPHqVDqAEOEKLkBafjhQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReLoOJudtGsKxI/vPsFdH/VcYWf9Hqf9TlmGx1UMy+o=;
 b=FGHOc0oKNA1uz0Q7/E5HOkAglQAKWRL/8IomTkDWMPCov7R6baSOKp39SVUZhIEA8s4Mto54HIqSmzFx7w5t8QVb8S/LZxe/IG5wMc5Y9PUMfhnNX9novBaRsPu+s11BLdqgZv3K/nE7ENMfcSV30UbbK4uq4lnMbFoDipM2/D8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by SJ0PR03MB6390.namprd03.prod.outlook.com (2603:10b6:a03:396::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 10:52:52 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::96e3:3428:3a5b:5872]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::96e3:3428:3a5b:5872%8]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:52:52 +0000
Message-ID: <77a82fb5-873f-f57c-a6fc-9cd879273d57@synaptics.com>
Date:   Tue, 7 Mar 2023 18:52:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
Content-Language: en-GB
To:     iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, will@kernel.org
Subject: [RPC]: iommu/dma: custom iommu_setup_dma_ops for secure iommu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::7) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|SJ0PR03MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 95bb9df9-9b9b-4f04-ce2c-08db1efa1922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/8IGTvqcse7k2y3WwXZc+iVTSEAoPrBm8BD6kUVsKqxJgZE8XhXgdXg3zOxiiII4J8GbVUqEnqGiLHi2Hoax03wHVYy1tnTsPmjG/RVtq/78VYuGxtozn56GiCwleAh2rM2jn4htzXMku6agNLBxAkkhi3+OQwwWmforYE61DDKQp+HkmjN35roMmDyvH1Whp3Wk1GN95RkN1dj3ympHQeDmfnlFf+2/rjhbThOKseFyOKwuya3ZCph5X60R98HfF9reIVMJkBftP066YfhgoBa6W6jwW83CiWmjcMl3Tjejt2poNDE6n0KZ+Ikt5dY6P3o4AEFgvcXKeMeQ7VSkQ1hR1Uzt5T+zTZg2lftQFFws4RgvLneLKjlscpW1HsrFrTFO9qvWaFs4fVG/cXVr5X3oV6fxLRc+foMTpRHmWtlFf2xt7yMLq/Ng4t5vlwsnj5M5ezl571UwQPzxR2RJcnDZZxITuSsgEFeoPPdFYfRcxwUbYs2q2DbsLzObZZoKVBUac66gvBdrc0uMP6JnHZsgDCfLzK9bUsLSH7sRofNpOadJQv/EdXTNgRDq/rBsuvcQUbbS2Ebe6/e6WMFNrDxbDrQvzLMMU2QvMazlNNLygta6kT+wn5hnVYu1SHR987Jl7la1/cr9t0V1hqL1dpdt0F08C4ykE2yv4NysWkchV3THGK/faPXEqqUzPatLaDHoUSBDWagMRdIbsPkd/DZhbmgFXwC7P34UFklJ739wH73b3AQQks+GZ8tzH9V/QNICw0eY7J8LFxKBGU+cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199018)(36756003)(316002)(6486002)(31696002)(86362001)(31686004)(2906002)(186003)(52116002)(5660300002)(26005)(66946007)(66556008)(8936002)(66476007)(8676002)(41300700001)(4326008)(478600001)(6506007)(6512007)(6666004)(2616005)(6916009)(4744005)(38350700002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZGY1RJWFRXM09scWpFMFg2Njc0Qi8vU2RCSGRzL3hybTVHbzZIMXJMdFZt?=
 =?utf-8?B?THhVZXUzNUx4U3VkQ2pQbTlCaGhVWmE5b2YxdE1oS1JrN1JDMlYyRytwU2dE?=
 =?utf-8?B?cjhselZhNHVQN29PaDhBWU9KYnJSb2I5OS92S0xSNzVvUU1YUGJzVmhLd0RV?=
 =?utf-8?B?WmdqVzRDN1R5ZUdDQ3pSMTNIb0hwRnFDOFoyajNuNU9ReC8vTE85a29oc25N?=
 =?utf-8?B?ZWwzVXhqWXZ0M3d5U1ZPd1B3S0ZvM3pRNzVMRXpFQWt0VU8zOGd1bU1xNHp3?=
 =?utf-8?B?ZzM2RDFubjBtQ2Z0SklHYitlU3ArSllGdVgwVFZyeTRNOTJzcTlZUC9LdEZN?=
 =?utf-8?B?VDB0VEQ1MFV0SU1Hc2xHVUdUenRFNlhRd0c3SURvc0krTWg2NXB5MGRZS0s0?=
 =?utf-8?B?Skd6VTdKR2Q2ck4wSEtnT3JpVWJmV281aWx0SjNYSkpjSlJsNzVYemM5NHdY?=
 =?utf-8?B?VXJPKzluTk93THNIWi9HNFQwbUtCZHNQcnJTL0pXTTQ4NTBnQ2VUZ1owQ1I4?=
 =?utf-8?B?b0VhYmMxZzd4U2RQUmc0WHFhWTQ2Y0dpS01jSkVQQUlUTE56SFYrRnNYRHE0?=
 =?utf-8?B?VXVJNDJwL1VqMmRabjVmc2paZVZWU2M0OVVrT3VXM0J6ZTJKWHgxakxtTVFX?=
 =?utf-8?B?bTZFakdpUmFMRlQwWDU5RWxRSDNnM0FRQ1hINzBDamVnRVF4aE1CVzE0OHJH?=
 =?utf-8?B?VmJ2YjF0YmFkYk02bWlpOXhSMWladmlwMmNqaGtNc0IxYllpdmQ0VkpqTHow?=
 =?utf-8?B?bFlPOXI5eEgxekViZ2t6Rk1QekdzK1Y5SFFYZ1dEWXNEd2x5c1NFRDlTcGtr?=
 =?utf-8?B?QWlkNDhSbi9ERTk3WlhuQVRWQ3NuRWFUeXhiWGE2bEJ2KzQ2UEZFSkdSTjhZ?=
 =?utf-8?B?NER6Ui9ES0NaaEowZ3NqQ09IbXRlQ2h2b1dRb2xxajhBN1JSZ204eWNaYjRB?=
 =?utf-8?B?Qmpkb1IzdFhTbXlHNXEzaXowdVh6TUJWSDJZQlFiMUl5RGhCQ1Y4eFYzNU4w?=
 =?utf-8?B?UmlLdTd4R09qdUFGVUVENFliaDlHbGRJT0RuSzlBWkw5S2FPMTJnYTVZMVF4?=
 =?utf-8?B?OHZxdzRZNlZjODJwaTNBamp2N1Zzekc3OGVwTEJmb0Y5Z3doNFRqbFFsbGxX?=
 =?utf-8?B?OEE2SGRpK3Y1OHE3cW02WFB4aXByN3NkZG93UFhIS0VaT0drU3FOamVKWDF0?=
 =?utf-8?B?WEs0enBGVXM2akZxdmFSYWVTSjdrWWtQTDIwdmM0RUpJWm44MFNqTzdyT3lV?=
 =?utf-8?B?RjZPTEtpb2V3KzVVQlpEdlZzVGJMbXNaNURFYi9GdjZqQVZXbkw4dUxNbXVp?=
 =?utf-8?B?RlQ3RTM2MFJrMS9xL0pBdXhvYUZDaGU5SURLeG8rZzJxVk9tOTB4SjVBaVJl?=
 =?utf-8?B?T0F3cXlRQmlac2hhem8rcE5LZlYzeGpiN1huRFdDTmhzSjNyNW1TMVRqUUds?=
 =?utf-8?B?aUZacUd3VkErd2tXT2taS2JESzBWTzFvWnpIZnI5VFZxOEErYlc2M3JyNFkx?=
 =?utf-8?B?YllZSzJpZjVpRXB0UmNUM1h2VjJ3Tmx1RTZ5S0YwNFRCZDVpNXFQalQ5T2pp?=
 =?utf-8?B?L3h0OWczeTBaa1ZYQU5KMWtwUEdnWm0zWjRzV3d6RkcvUmdxWW93Qjh4a1Nv?=
 =?utf-8?B?eE1VbCtJWEZrZFdzMCtMNXYzTzFoTnB4R3JqNU9nd1BjUjUyS2FiTElaTzhn?=
 =?utf-8?B?a1dvMTBiQW1PLzhwYUErMjZJMG94OTN3MG5tbFJWWkduWlJxS0xkckdHM2tu?=
 =?utf-8?B?Rjk4Z3N5WlBvUkE4c3BxNmUxYmlVZktqdjYyQUpISHllQy9OemVlZXEvZW9v?=
 =?utf-8?B?OUtDSnM4M1RwWkFHQlVRRDQ4N2hwV28wNHhSK2I3MXdZQTB3VkVqSU5EOGRS?=
 =?utf-8?B?SzB1ekJ3cG0zU1NMMlNtS2RYckxzS2ZRVGFMam1IeWo1NU10dGxieEpDTG9Z?=
 =?utf-8?B?dUNWZmhJRFBhMW9DaWI3TktGeHE0UVBwYmY1YlFteE9LcUpBdGlJY0tOdzky?=
 =?utf-8?B?Skx5VFd1V2U2dVF1eEozZVNGM3lhMW9WWFJTM0d0cU5VM2xaVDZ5Y3plaUV6?=
 =?utf-8?B?akxiYjZGZTFzWkdLV1NtVldUK1BsSlVmN3Q3ZlZxT2U4Nm5YUTJ4dmJVWUt1?=
 =?utf-8?Q?8SV5UQREBDz1k8ckQQ0OB1ne4?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bb9df9-9b9b-4f04-ce2c-08db1efa1922
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:52:52.0893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n20h/6tTCQ82+4tIiqN5X5KtKMOTIJiAW+ODwE6JsYdhPTVO3wImtGGunAqpHA+ff8vl1E/7u5+5vrTM7Q3xIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6390
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All

If I want to implement a secure IOMMU. Is there any way other than hook 
the iommu_setup_dma_ops() I still want to use the of(device tree) helper?

The secure IOMMU is a little different from the existing secure 
attribute page table. The physical address and iova address not 
available for the Linux environment(REE), even they are available, they 
can't be configured to the secure device directly. So we don't need the 
Linux kernel to allocate the iova address for us, means I need to 
replace the current iommu_dma_map_sg() implementation.

Even sometimes it didn't do the iommu work, just allocate a secure 
reference page id for a continuous memory. I think the iommu framework 
is the most proper framework to implement this feature, it just fit the 
steps of importing a buffer for the secure world.

Please give me some advice on this idea.

-- 
Hsia-Jun(Randy) Li
