Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD04601355
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJQQX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJQQX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:23:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EAC6D86F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:23:56 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HBvAxP005110
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:23:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=f+4Bmw8+nzFR3puY9PHIp19psNGyMKX+P1ApjHuvhMw=;
 b=PLuOFX4BvuHVJpwFY5sDw6SIvg7rAiHUcQ/IiN4p6CA8YoU4gAUYBLn2npWLUO9aV5mD
 UEFw9B3oVcAEvZXyeGiEWRSqbQP1CZX/u3doQWalzVj1fPd053iIGRzDhR3bInGilVHI
 ZDqVJj7d3bfALQRU6M/SU/o6PoL9vGiVUcbqkDzE3ZuABNb4O3AYAY/zWS6S3vPxs+il
 cojO9N+HPEMCjZptNnkalH7psL39NRYCOzQ+fo+zcyah3TvlHxDv3V2kDT2+P5Vy4L9E
 IlCIerrZSyLBe3c6AS2RzZHklCL2lQs0wYONKXqOzhsVMz0ywZfiSj9qp4w0idT7x1iH uQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k96mctd31-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:23:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6q58lXXJ7QLnI4m46ciWfGhKk7KW2EiAKbVkccZlWsJqkY7UMLE2fJoat6g7lX3S0tWOK3REXgP9YFvUq1Er30cmctIpfGOk/lKIspOReK1NnzSmy878IVEBxiHRbNGPT8wA+nlJToS8JSJc7gEAJP20kArYzfbMtD3xwYrKRpALm6QmW3U3c8d94p9qaQw+jLTuJP1icS/c46BHHoEejcuXLKnuLGAcSRVa4GQqwPjB87r3SqIIhSDSL5XhjUdoIJT6xMdt0wFRKJOVfLyBy5CkvFo139xlHVw/zKYbah47C1X8opVJM5omIwNXkDQGxVJBqEnHobztCOPEPrWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+4Bmw8+nzFR3puY9PHIp19psNGyMKX+P1ApjHuvhMw=;
 b=Vl5j4afNML/QoCbVT59zCN1aPw7fQLliM4B7s6VA9Wo1PAZDjKxHafhi00AnJiIKXRzL3M1tvtPEBqEPUGpdg3IyQkpiNp8Yvkev5IYTHW77DoEHhMkNv6NGfX0SsVCIFwCT2KnUBMZuxHc5TfqY0fN2xHtqFQIJYYNJ2TEDv6VctykKEQaEhgYbc2RPv5bHbnw5iCx+T3QNwotR1/0SC0Oew6KFjBnFDDEGw2xEJ1qq2qGeOZ1+7gr4GvPEG2reOBH5wJgBvM1e1gD39IPWanMIP5t/GkN3d5VkoE3PMUrEjblavNNejZertKIsxnx/CJ/doV9lwsmJ7ywoFoL1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB4557.namprd15.prod.outlook.com (2603:10b6:510:87::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 16:23:52 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 16:23:52 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Song Liu <song@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [RFC v2 0/4] vmalloc_exec for modules and BPF programs
Thread-Topic: [RFC v2 0/4] vmalloc_exec for modules and BPF programs
Thread-Index: AQHY2qb9UHFHCXXpukKxiSq7OlxGX64SPiOAgACWPoA=
Date:   Mon, 17 Oct 2022 16:23:52 +0000
Message-ID: <E8A7DEAE-C1C6-4821-A3A3-FD4996414AFD@fb.com>
References: <20221007234315.2877365-1-song@kernel.org>
 <20221017072607.GA30977@lst.de>
In-Reply-To: <20221017072607.GA30977@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB4557:EE_
x-ms-office365-filtering-correlation-id: 0edb50a9-30d9-42cd-b077-08dab05bfaf1
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K10cytw8jTB/jUJk2s3NrsuUunXqExCaNRz7LYNbo389+cMNuifvRl+YAc+qRgwW1g5AcK5Y6tULNuJyUeKs7SIi04AxeIJ3S/lrAFPf7oOTTxDQKev/F8JXsgkutxu3xBKXHsKXfF8uEtfGND26FUSiY3gehTnDrSEPUZzN3V9fgCX5HuPeB1KEVVKQ/wN5R7l9DZ969g2rqjfg/Cq1XlqdBzPKVn/hPxclIaHNg2Ax+pWb4I5CD8GyeZaz4f1uFkesET57TWIAMyhNc1FMXeq287zKv36o34/WXOYzTxyfLdc8aBFjzqLjZbzlbtG7ZNMhjVWj9ExZUEQHLuuOX1Ybi7+eMnZ6tJEBiLjXC+zpyj/EPue6nO0J2jQsbZdznEB+IhDinHkPYMuf8+7ckR2Z7iDt7T5Cs+FRFGLAW6t9O3nWrHOFVhtJFIdlI9V8DVWlJsyON9FSvNvl6dD+jg2TwoBqGU1TedICpuobHYkHE/KXNdSw6CfWUqaI5uht4rYlX1P8/hsKC3SQOo4s1yjbWMWHFmiICWjzbGHbVdgoFf3wI6pjXkwRB7e2X0QmHTOmAHks/vH47vT5zxDThk6F1nCQSptkNRnzi8Tjg0+nZ3wDZGSPEavOQ8hPjwyC2KIvCeOkgTXg6kaRhH/EOFyaiSbNtJ3jGGkt2Zf7i0r81O365BN/qGMZGSD6NQdN49jLQ+pKGies1DJMOyXvu1GKjI98AwFp5B+Y2Dg1Ge/1jDaUdTNnUR6fEA7j6N3x4i4gMHi2CMrTTHPCczy2Sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(2906002)(36756003)(64756008)(4326008)(66446008)(8676002)(7416002)(66556008)(316002)(76116006)(66946007)(66476007)(91956017)(478600001)(41300700001)(54906003)(6916009)(6486002)(33656002)(5660300002)(71200400001)(8936002)(86362001)(6506007)(53546011)(186003)(9686003)(6512007)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XZfmO3YBqZ2+2fFUo1zU59a3J4Ni0iW+y4qOlcTlT2WanJl9AEoaCWx4ZVql?=
 =?us-ascii?Q?16hTZ84JbPAVgBmNx+rWy4t4mS/Oz9EK+lrT02eFwfcTmnGtT8C1wndXWU29?=
 =?us-ascii?Q?PH701mGoMky4eFjn+7N1YdXtoRbnmMFtutq8hDG9E74sbaqrzHWMEBHCFLbs?=
 =?us-ascii?Q?/ii2P7kf7+UIruFLZs5JhgSaHOarkTqZQfOWOE1irqLfbDBVxTtsKECsMrft?=
 =?us-ascii?Q?1REBQAe2YoxfLD1shhHlTgvcrCv21cjZWGQ/LkRg3kbWSlzKVy4Heiwi7mve?=
 =?us-ascii?Q?nAvT8pb6tGgcLR2C0ZVot0OyL2rKq1QftxjSq7ciT0NntWGMuW1pkfH9aSX3?=
 =?us-ascii?Q?xpdlD4AbVx/voUUILdvQS8DN0spj5+9X+cBqe0w2B+zYXaFkdO8zzY3FxDXV?=
 =?us-ascii?Q?it6Z45frvycRd/34ffMh+2zqZeJSswSFIXw353AdT+Rwa8zzYcl/j4E4bAdN?=
 =?us-ascii?Q?utEdXWgVtZA4gY2yMhj3iKYbxTQbxgoYby6Kh8EOUaHGSB7hu5/oRbU4ronL?=
 =?us-ascii?Q?OrTfA815UT9jlhyV131PtnldQNVnQTSyRZvA1mfCHiqD1pQSXJZpoKXJkRLc?=
 =?us-ascii?Q?P3h7GjjrPSERHUPYEf3LjiMJTV7DmM0UujEhlr6Gh6R6yaPBhSgfBBzsqnFu?=
 =?us-ascii?Q?CzAuZZkXadKcg+9yCqpUhvSt+SbAby24TweU/6/skmzspmnenETMr/+aL1t4?=
 =?us-ascii?Q?5dLBaTTsehRapoE90qD5o+UDfJVaJgsxZNtDpbu7DHXdv/8H4JAGvwhxMMSB?=
 =?us-ascii?Q?iU1Spl92Df6o1+ITPlAgXrMfrC6hQ7r8reE3Ainem06GeRqLlTmJ7dFLEgpc?=
 =?us-ascii?Q?EiuTJiqqRGaRuNHU61p82SopmufFO7xO8fIIOknwhekAQZcVGLXGkXX4HFzx?=
 =?us-ascii?Q?imfLg5oMBRaK4HD84kG+vekBahrTq7kz4ppktg6SZ08uXNAt1itSxtKKHvMm?=
 =?us-ascii?Q?p6eGMHCcbl2YX0yCKU44JM4doPlr80zl9Dt9ehzfaA+gcZiKSjG++3YyYtAM?=
 =?us-ascii?Q?A6nTdvUgAbXPVH5IyjfmsM49j+R9m3vq7q7IgNBIS4yVZUuWXqLGXKc5dtGj?=
 =?us-ascii?Q?9UVf/VNC7i9ONTHWt8Io/UhnkUFBmVfiZm0EwpNT/XbpZSEJWnzuBUowhxuU?=
 =?us-ascii?Q?V2bn5gpAf+tV9jCZoIjkNuhlFoOw89GO27z7HQ6P5C+UBr9xVWMSnSrNNbUO?=
 =?us-ascii?Q?B0h6nxUSHez956m4SjfhTi7TIg8l/FzfPLePWc+DEpfW+l+WWjkCJpnV2w6q?=
 =?us-ascii?Q?H0qWH+nBJnuYYt+ExAajrHQOp7FBIdPWoP6zXKYZa2Jg1eiy+Hf3g15bTEN3?=
 =?us-ascii?Q?WIOwdHYrPz8o1/MXL8zQBo41Y6HvbjM9NqMk0NS3KYjBbWode4gSsZhP1vbj?=
 =?us-ascii?Q?K3nfxe4LL7IruNgLU2zxPN4qI+1/vyZ+TX1EMC4WoNSQon5v+2cCb5jthn1f?=
 =?us-ascii?Q?h6iyWq/1Nh7+M11psxzVMQ5+Z7CdI3Z68CZOfVb+H24envHMrPnBrJMJwH+u?=
 =?us-ascii?Q?mJ2OYBamr8p6z/GD4JCS3FSiyr0PHDG9j3W2PBAdWcUcmnboiQpmKeeIMIKn?=
 =?us-ascii?Q?WMlHdYvAEqvt2lr6WK3ToPZlxRqLWIK2FHoktFq15EouDAgudJHEDAm1pHKR?=
 =?us-ascii?Q?IH2C+S3J5w7jQW3Vi0v5Rloda02O7s31zhww6XKw78Nz?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7EA86F4E8C70DF4ABC9F1BE1BA590A7B@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edb50a9-30d9-42cd-b077-08dab05bfaf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 16:23:52.4846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9O1eDnoXXKGXu+SasGluIPDQqOKaHBR7F0kzJ3txcf8Wb0rNZR6CNSRQWR+ofcgp10Q+9aHuAgwNcOmWrlVygw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4557
X-Proofpoint-ORIG-GUID: q4D9H2Bu0M_49poMJQYMYpEpO5BmBMEG
X-Proofpoint-GUID: q4D9H2Bu0M_49poMJQYMYpEpO5BmBMEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chritoph, 

> On Oct 17, 2022, at 12:26 AM, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Fri, Oct 07, 2022 at 04:43:11PM -0700, Song Liu wrote:
>> Changes RFC v1 => RFC v2:
>> 1. Major rewrite of the logic of vmalloc_exec and vfree_exec. They now
>>   work fine with BPF programs (patch 1, 2, 4). But module side (patch 3)
>>   still need some work.
> 
> Can you please move the changelog under the description of WTF the
> series actually does like the normal kernel process?  Explaining the
> changes from a previous version before you even describe what the series
> does is completely incoherent.

Will fix in the next version. 

> 
>> This set is a prototype that allows dynamic kernel text (modules, bpf
>> programs, various trampolines, etc.) to share huge pages. The idea is
>> similar to Peter's suggestion in [1]. Please refer to each patch for
>> more detais.
> 
> Well, nothing explains what the method is to avoid having memory
> that is mapped writable and executable at the same time, which really
> could use some explanation here (and in the main patch as well).

Thanks for the feedback. I will add this. 

Does the code look good to you? I personally think patch 1, 2, 4 could
ship with a little more work. 

Thanks,
Song

