Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE906F20FF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346790AbjD1Wl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346501AbjD1Wl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:41:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6735197;
        Fri, 28 Apr 2023 15:41:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SHn0ul012500;
        Fri, 28 Apr 2023 22:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0cuV1hxmgEPGXe7909UP5uC8zy/CFMCkQr/vSk6TYfY=;
 b=vcH5KSFIdVZ1lqnRXatsfM1T/yl9y+9wJMmPWdZm+Tt/tLAwYSF86G2TJhWcwcSfn9y2
 ogBXJZfECt/uWxNLvWxtJIViU9EXm2ojUAs3pngb0EVyxecc7ZCHo+ikBRGyqf2RozqP
 89R7k3nzm+JtQ2PGh1+TV/KeDATnmcjRQM3qivRHJ4KUzusYZCcXO6HX3Qe1Piag0vro
 1aROz1pYy37k/9RP5VvaAJ943PzoQAfI+IY5Xu2tD3wzLSFDsZsnfJ6Q+4ubT4RBK+jC
 j/QclSDh28DnQEUCqfLegjhxGkGxxQSul686ioU8D/q78trr6fcUrU4BbnxLuUGvGSr3 oA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460df7nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 22:41:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33SLrrrQ014242;
        Fri, 28 Apr 2023 22:41:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461bax4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 22:41:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgLxkWq13nKi+G0kfMNcYRmmKKFBnipv5XDcYI/P6gXsfi766LuYihnCSIQb2BXOm2aJcll2+GiRtKwUf9ChmjhOBoFEanj1kUMgGcnk+dWQPs10bxcDticDyB2W7dzGPdWhsY1gXLMWb2yJ3B+ED2Xrj9YWD6ZnJD8yLN/f+Lim03RLzExyueRAejLEbvlQqQ/XnmNc0ccxDo2joE61rlRJeo6MSptoOHscoE2I8NxgBnTku3SVVSZZonOhDxQtlpwVSnLkQctMQmRV/1a/w/w34ndRw/CsTORWvq6MUF/OZI9heG6BbUmIkrFhHnV4UD7QKeUhUwKIEFwDnuo/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cuV1hxmgEPGXe7909UP5uC8zy/CFMCkQr/vSk6TYfY=;
 b=fCNhGDa2afpmG/9gN4zwYw5W2BisQKOpBOvII85E5kbKuBooYMmrOW04DJE/HhB4/WLdcgfbnll1MqxR16YVEWhxrBM1+w/S8QiupUSJ7QAHRCMpoc193yHyI+XwQ5QO7ndzxotzgHbfzqEmlK4E05GBtVSqMZfNqR9IVh1RzXAp/NSkoYxPUW1YvTztbBRi3yEiN6xK893Mw0rJbAElw1unfJC9vhiLHzCdKpYESJzQcpMFpJjZ1dYDpU14pfJbtELGgt6sh+U7OucIW0xzLWZIwG/wtqLAwJKVb6GTmM8hQ2ACyC8OrURCILqN7Tt8pX5iAWwPGnTMTyFMN4gqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cuV1hxmgEPGXe7909UP5uC8zy/CFMCkQr/vSk6TYfY=;
 b=RcwvyBmAvEMEexI9WQS547PQ0jl0qvZClahFxLkl9pYIjQJOpUXOzvB5aHkEZTpeaqPZO3XL/2vze+xg1niwuSMuwKhQ7bkkuglOzn2VIQVAw4Hn0XLXsLnnW+j4aLs+i84ykmFNLZurwl3wsmoKwdYc8JfUndWfiuE9KlEu41E=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by DS7PR10MB4846.namprd10.prod.outlook.com (2603:10b6:5:38c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 22:41:09 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c%5]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 22:41:09 +0000
Message-ID: <f016d747-c01a-c46e-59a7-13d0d6306827@oracle.com>
Date:   Fri, 28 Apr 2023 15:41:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH V4 2/2] blktrace: allow access trace file in lockdown mode
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-block@vger.kernel.org,
        nathanl@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        konrad.wilk@oracle.com, joe.jin@oracle.com
References: <20230420215331.88326-1-junxiao.bi@oracle.com>
 <20230420215331.88326-2-junxiao.bi@oracle.com>
 <05b3eebd-7a3f-13d5-1fe9-8f4ab3080521@oracle.com>
 <30ab7555-8f36-cfb7-9101-0ebb92af3c2f@kernel.dk>
 <6300a33a-9d3d-42a2-d332-81e02d52d310@oracle.com>
 <CAHC9VhT2uCc5ePi+ung+rLaDiLCCCF=fjq8G+D3FJf0i4E8_hQ@mail.gmail.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
In-Reply-To: <CAHC9VhT2uCc5ePi+ung+rLaDiLCCCF=fjq8G+D3FJf0i4E8_hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|DS7PR10MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f699ee-0949-4704-37ec-08db4839a904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQd90ZCgIT6p9zs9nTNE50VJAV3Tsv2MmVEyHWMDKQG8LcX132MLfeD51ko4ozxi3kVezABilrYMbhBaB7LvLPYka4mLiuXP3cZgQkYuOPNZNB0g0ONS2fcFf+eBSNX5pcAJP7wLLDIT22zDqHEsdbPUDZfpkZTl+yng4XD4PppEBqXHwZ0RTM9D6MfrVaYpwDjoVThRVaiXuMEf38y2tBRq/XjIPgf5SVOvPW/pMwbbmtDZuNyk46xPFBtcgDoGUyhfMngImKT3+mLAdHVg3jW7k2EIU7IP/9xc5RSP5RZoPFkTVYriUwjHq1IcvaRApBLrqwfwsgFTyWwbCZRDRL15RK6JkE0HxKwM0TfOl/BI+/rRSgYZ9uQStMAM+XJMekuw5+zpvzA2ULlBG8oeBQfNCR6RDaypYtbOzrofImp8F/JAMu6uYYGGQYY9yFNtlPonrDgFQIePH7lfTxock7WQtFe45BaUvONdxupTX2b9zQ5FH2McKZSz/mLI/2a10HVfY7LaN6fv2xDzMB7aai4ZM347bexK6N3ueR6f4HrUwVlMS95gByFTmI4afNVttnFt5YhgPSk4gikUNNc/2MWVlOqYeDcROO1Cto/ORa+f52iC5QxSlD78vNPL4AuYXBqQSDUr7u4L9ChTeikxZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(66946007)(4326008)(66556008)(66476007)(478600001)(8676002)(8936002)(316002)(5660300002)(41300700001)(38100700002)(2616005)(186003)(83380400001)(6486002)(6916009)(6506007)(107886003)(26005)(6512007)(44832011)(53546011)(86362001)(31696002)(36756003)(2906002)(4744005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZpYkcwRzJhTytWNlZhbjBmbkNubHlXL0dvalZOMUFmYWtpenJVUVJSZ20w?=
 =?utf-8?B?OVIwQ0FXUGRkWEtWc3dDMFJNU0pHT0N5K1pzWW5EQ1lCc2t2QmNnSG9rZk54?=
 =?utf-8?B?KzdGL1pxeFdwQWlTWFpBMEFEcGF4NGlialREVm14U1UxTjFlZGtJZ2ltT0Iw?=
 =?utf-8?B?ak45UU85WUFTOEc3M1pyRjFGZGp0bGFGa3Via3E3ODAxU2ppUE1pVXFaaXpH?=
 =?utf-8?B?aXh1bGRBcTBQVFNnQm5HaXFXSUJxd0NmSnJPV2xsT3VaelMrdmQwQ0RzVzNB?=
 =?utf-8?B?bmZoU2JlcFdRUmMwZS9qdi8vU2FtVEhXeForc3lVT3E2bXZ3alFKZmc5K1Rw?=
 =?utf-8?B?SWY0Q1NIWEI3dFk0UXNIR0FYVnRYSUx0MmpjeWJveHdNeVduTjBoN1lEdkY4?=
 =?utf-8?B?UExTNmg0ZU82Y1BIL01rdk5iVjNvekhycVJSdi9lWGpYQ24vMVlSU0tWT3RF?=
 =?utf-8?B?S1pIcWQ1SlRXOVkwaGZsdldHMEtzem50SkpHK0Rwa0tybkFzYmZpcEVNU1ov?=
 =?utf-8?B?TEdQWkQ1bGFjTC94UGptVzBsMlVtYzBXN09hU0NCbUdnOVo3aHJDb01JWldE?=
 =?utf-8?B?TTJKbXhmYXdLUUdkWUQ1TG5BSjNsK1pvTDVJaUFmSWNrMUwxalhTZHhieUho?=
 =?utf-8?B?eEtoYStpTlFGQ21Cekx0Z29wL2xINU1FNmJORERNVFVDWitGQjNvYmNVRlM0?=
 =?utf-8?B?MXhrOXpOMU9jSnEya3dmZlBBTWRVR1dUaktJSVFLWk0vUjY2VWVRdVFPSTJv?=
 =?utf-8?B?MS82ckd1Ti9JWndvVmxrZDgyWjVKaURRbXRUUFRJd1g1WjR3YW9UOEE2bS9r?=
 =?utf-8?B?dmVSMVFxY21YM1VyRkhzTXBPU29EK2h6UVU3bTVRMmI0YmVjLzRvUkdlbU9a?=
 =?utf-8?B?akI2TDcvazZXSjZoZEphQzdlb08yWFMweFpBMW1oV3EzU0pvK0pRbVdYY1Vt?=
 =?utf-8?B?YUxBWTFXYXR1dVg5cTVCTFRSTnRrN29adTFWc0hxVis5ZnEzVEJlODF6RmJv?=
 =?utf-8?B?ajJvL3RpQWwzSm9EMXFDNHdhQXNkLzFrRERWZXVPbzEwOERlcXlRbWFZMm1z?=
 =?utf-8?B?MkwwQ0tVT016ME5WZVNob1hIam9kVmgraHNaTGlldDdCUkV6eEsvcU41MjlC?=
 =?utf-8?B?VVd4eUFHbjZhek1Xa21TVzgyN0FrNUFRWWd5Z09PV2h0K0swOHMrbGlpZXdE?=
 =?utf-8?B?YzZ6blN3OUFtais0NXBoRkV6bmQ2ajBIR1RLcjJzYTA0UDJCbEdwYUVLYXk2?=
 =?utf-8?B?cnJ2QzFUUWxWcFNzbEU2NVNnaTBrL2l4NnlkYkE2eWFKaGpHNVQ0K1VzQjZa?=
 =?utf-8?B?b0c2SitxNjU4V0VNVldmaTF1U0ZmYjk4ZFYrK1RDRHU4ejlSdVdnRTJsVlJa?=
 =?utf-8?B?VHo5YU92RElySS9yd1BYMS8zbUN2eWk5MWlVSytrMWFNSHVRQnVPK1BzL0hq?=
 =?utf-8?B?TVFiMzl4UmRWYlNVUW1UNTlhdjFFRC9WZEd3NjFUMkgveTJjS0Z5cDA2UnRw?=
 =?utf-8?B?OEE0ajRVdTM1OUFnTjI1aWQ3SExndmcvYnE3Ni8vRktXcGdTMkxKa1ZuTmxl?=
 =?utf-8?B?bG9ueVhnU2hzMkZZQ1ZlUndlS1p4QkpqVUc5Yzgya0hxRWFRL2dYbkVJcUUv?=
 =?utf-8?B?KzlaOEttSDA3NzJianIySlFocG9UUDg5SHlBcUw2eFNmM3dXZSs4YXlHUHQr?=
 =?utf-8?B?Z1MvM0pOSGQwSUZrVEhYVUV1MFA1Qk8xT3NiTkx1MnVFaENaTlEvMy9TWTU3?=
 =?utf-8?B?QlNDNXQrNm5RQ1FNU1YzZlRxL29PSkh4VkU2RWpvU2c5ZHJteGZWNGZOMXds?=
 =?utf-8?B?RUlNUDBkQmdrZHBVMkNIOVZpN0I0UkRkSGE2Q3hSeTVNdWp2a2VSaFMrWGFH?=
 =?utf-8?B?a0RVejIrRXg4L0xYY0NBZnM1V0ZqYU41RU5zRXhMaExDM1pJYlJ6RExjaEhG?=
 =?utf-8?B?a2tLcHhvbGg1aWhjbHpaZ1EzemEwekdqT2RnQ0RkYWM3L3p1SEJsT202VXdq?=
 =?utf-8?B?YVpob1EyRlczZXI4dFdVQXk2VXlHYmVJelBIMFNKdUIyVEx6bFlScnliaFhK?=
 =?utf-8?B?bllpZFFCS1ZSTzIvN0dIdm14WW00c1NlUEorRUdzRmJOZmE4ZStDenFKZ3o1?=
 =?utf-8?Q?pwbqoMaKk8dwkzfliczzpB08d?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kdfUguOuTPGnYzv+W9dnRQA+gSPYMMGDQHz0ZL4p2QfFhSLr4a/MGDewo4Htt8XiHcddNR5C8pXGSTC96aElv+mo0jahmxJswWJMHSQmZe1xXEZfHj0t9RExhRWC1Hn+MWgMBQdcOd8PffrW8R0Whu0Th1uZlPXoiOblIEMOS6Juq5xg71VhFfFdOs2QF9s04XXS/qEh5QtkG82Dqp/ZjonKnqa0fjdw3ZyiRYLbdpb+dKIPls+yn/8NruHUrIwNDsduGJIo6AxA56iNdfw1+xQis7aQFJmyNMRtvA4yEAQ4o8ttysPHm4xDRFj9z1v/sJHYa2kxymuKsxSyl/DkTvpbREEqaXk+VwciAArtUBdIUl+RUce5/O0XJmf8BwbeY//QmpQE2w00Ea1/ecJOHX/E5CFBhMaAtt3p9uqbRw5c/bjhKj3NofD/W/z6q/gE/hHWbyBDdfhqwd9pzL6UY5Odu14z2Rw2whIhwXFNePlBnSAlpgGHXSaJzbEO5Wsl6TwW6YK690vzSDNwpN9nRAcDG5u6lDaL18wy25oK//Zs2S93vAwDpx2UzA6Ps374j632dtobhbCJN0jIYGkSbeU8j9w3cE/HCGrlSYo169YzEFIDVD9MKXDFLiRdrV03ODz22FvgtH9TdoHvdTqO9r89Gck0AX+c4D921mR4a5E2/Vm6gvFpc5hVUCW7iQN8pstePm7k93RARtLrKqSf2c6Gr6pljN0alSCsEgQ0EggbIVS4HMB/WNXMRsNYTIzhm+TKy1Kv4gF8ESrl+ICtPf4JqMTaVy3OIdGolXXwtEcTD2JeSwVHmJWqXBrMDDi4m1u96JIoHHl/4jUODpxxgyCd0mRINfY/LofMJCGy9Qgr2C4RYY1r6k8vRxhdroN8l8IGbqddUZpX2lnaqZoeeuOB7BKC9NDqYnRuk0TVyDo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f699ee-0949-4704-37ec-08db4839a904
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 22:41:09.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nN8p4i/zt8ZEuiEicmDCrOGE6dqXqF16R8qfpRaeoqViGTfiRZvmRHOlm3Qwx7t+s2jplqVQYqOvcti9nrP+CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304280189
X-Proofpoint-GUID: YSc6miyb2W1yc91IC_w0oHu0LePSUeUe
X-Proofpoint-ORIG-GUID: YSc6miyb2W1yc91IC_w0oHu0LePSUeUe
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/23 2:26 PM, Paul Moore wrote:

> On Wed, Apr 26, 2023 at 12:33 PM Junxiao Bi <junxiao.bi@oracle.com> wrote:
>> Paul,  do you have any other concerns regarding blktrace? As Jens
>> mentioned, blktrace just exported IO metadata to Userspace, those were
>> not security sensitive information.
> I think this version of the patchset is much better, thanks for your
> patience.  I don't have any further concerns, and since the lockdown
> LSM doesn't have a dedicated maintainer I think you should be all set
> from my perspective.
Thanks a lot for the review.
>
> Since there are no changes under security/, I'm assuming this will go
> in via the tracing tree?

Should I notify some specific maintainer or mail list for merging?

Thanks,

Junxiao.

>
