Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159796C1B30
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjCTQUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjCTQTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:19:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A04855B5;
        Mon, 20 Mar 2023 09:11:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KFwtgO013811;
        Mon, 20 Mar 2023 16:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ADagl5Lp95eKJ8xEa3TH7Q5auxtAZk0nsJ+KON1xnoQ=;
 b=sCvKOfkdR3FEwqFeQ4DKMJC/7oOlGn18FHLW+jgqFWX3sWu+rRsPtY1+nSwBtsVT2BVl
 ikjIzvEItQ6+rB/ypZc4d7Lp7bTP/42nztyUYMO5bgxARnBS518bfHH/LCq7ZBDheYuj
 ufeGkMLNmpjqEo8fqkkPkXXxRRErT0cNOaGyaRp45vNBfXp9IMgkn4q0bfCigyZ01aIS
 EEnSQ1vJKsF3qZ86bUtqBzB1tswDjXYLRfe9fabCXbEXNPJUuC7tVB8w0dwdUo9RF89c
 YsKmauS55bmcbXy/xmTexTIwjShHc7Du8b0kvYxJl4bwuuyGYDvYI/3PHfRAkTWOjF1e yA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd4wt3uvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 16:11:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32KFBkBs036953;
        Mon, 20 Mar 2023 16:11:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3peg5nha2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 16:11:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiZJ3WMWu1wRhCGgnFZ+acQX7VdcrW42UCzG7DRIGbgDo4y5bpNnq8dcMg4wRuXZZmk2SwlBaDNEGtWwo5Hh7cPWVCdTXcUtnRwPxqRUg0iv2QcT0djWbREZrGsn9AgQgaO4HxQgFTWgZdXQnY7TWVDZKjl93GQJU5TyS/MOmm6BfzzHAcTQTaMaQNeZULxUKoGEzs8pcgXKfUhHn7w5OtTn7w3MMjjhMx772iXqVhD+8PFgcDo9HG1qt8rajH7T9fYl7grf3YnldgRUnHTYs2WMl1ntmg+LwACQGKW6xT0cSYB1xhGdap8vZpXQSXSgIt+O2cSElsW1EpO/gaH5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADagl5Lp95eKJ8xEa3TH7Q5auxtAZk0nsJ+KON1xnoQ=;
 b=DTqcXm2IX2juoxQ/B43aPL4+RZFhPBSSeAiv6NHgRPJVOqzInuPQUUTD7kEl21jJ+/h3tpqdCjPMTybepITL7szwqZPHxMM15lL9nhrVQnNQwDTmfFG4IMlPmmRnQHRzUDcKWHfQMkGPHlOvG4OAeFKxkjpuBJNl0oTy+x79aIKwmBPneW2FKCi9WzURLulDVpirntqLAoowYkya0ZnBPu5IerhiRkIdqzYXHwD8nwYhwWx97Kw8tmH5z7vhu3OvpCtn6uIOogeOScTOnlKsMl9mJ7AbwLuSWsy6ZWH0cPQveFLFXSjX7gpCMJW1UuZalDqn9nZrAdgyXfs9GG6lqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADagl5Lp95eKJ8xEa3TH7Q5auxtAZk0nsJ+KON1xnoQ=;
 b=dG+HegvHz0ik8+9jH9W7ApkWgw82OUIr8cGarB6PM1s8vLWGml0jifFn8VcCyChKaTAobplE6TnlsjjCc556H7THTjahy66Yf+IlQXndow7y4By31sP/J0OHtHM6CzxsinQZPKr5fz+l+63LCa/+DbSR3XCa8bYBhMn30dCcfec=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB4268.namprd10.prod.outlook.com (2603:10b6:5:220::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 16:11:05 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:11:08 +0000
Message-ID: <bce4f9d8-e4b9-39e6-4534-34b7dc7d43ac@oracle.com>
Date:   Mon, 20 Mar 2023 11:11:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RESEND] scsi: qedi: Fix use after free bug in qedi_remove
 due to race condition
To:     Zheng Wang <zyytlz.wz@163.com>, njavali@marvell.com
Cc:     mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
References: <20230318081303.792969-1-zyytlz.wz@163.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230318081303.792969-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:8:57::26) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|DM6PR10MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: 644fe4fc-7e57-4848-59ea-08db295db6ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIhXrR0Te7Oun3BfRImPzUwyvit240Q5Q50LFUDnOMljtekpVP/gVUCcEUdWMb5dEDJ9A4CKYKDt5pj+HtvGPOW1gM9uSgFgGM7XPNsFDK5RtDL+X28pS8S+f9VTYC3EQ8gA1MvmaFvlV9cMuRb2R/KCKcNy/KOIDfb9n0LnLFRHrm6+lMkByNVFRprI/K3NimI41o0WQBZOf3qQNOUDrUU0GSniNmDHw/ZXtBGhOEdZgEXhOpx706/u3jk/vWbONmbGc3JSjfp34Oi8o4rmBJDWeVKzswgHZwU5rE8RcyUDqHCdW4IrGHZMysI5NJgaYuymYAHve3xNw9PTbt5ta2aIzunMFM0MXN8vk4BF2g/RrbWNp4rh/XEbGGgvnLBFFjuvl80bLQppvlcq7qtMtzvTOO3To8VWEaj0mfWkOSj9DLMsjcNiZvmjKZrsweACBRXyHBjvCePkCRfM7u5MBfSrKm3WMn6YZI27zI5EmM7HWKkA3U8upHAhmU6uWpc1KxS0A17OFGJiM9h7iFeNgLoKizSRjv2WF7n1yuDnrFF9eiIgVEqeUDjslsOBmVhFJMMqbJsfkZDsHlpbIZ/4VFK2zfVeS+gUQBqcgqttq+dmqVuLDIiEA10RT6wz3ElcXZSxEFJFF/oWnOlji8YDjzY8XvsmROHtVlViT8WPzx5d/nD3MiDkqHFPyEoAA5UTjGY0lquLZXX+6aQdPrDGrVe07eCAlypt8qMGy9Pm48Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199018)(2616005)(186003)(6486002)(4326008)(83380400001)(478600001)(316002)(66556008)(66476007)(66946007)(8676002)(31686004)(53546011)(26005)(6506007)(6512007)(41300700001)(5660300002)(8936002)(7416002)(38100700002)(2906002)(31696002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzY1eGRraFlzL2JUaUdQMjZGQlJvbFgrRlNnTkNaQzEremhkamNmcFNjanJN?=
 =?utf-8?B?SnpsYTFoRENYbEN5ZlJlMW50dEo2TW1pSnpxS3ZWNlJUQTlJbEFIQ09lWG5N?=
 =?utf-8?B?UCs1bW9xRDZsdmNmTUYrOHMvdlZtK0hGQ2gzeG5oVUJ4WUdDbXdVZnd4MGxZ?=
 =?utf-8?B?YlBMSjhpWVRhR3EwUlBJT1o3RXBtQitOZVhOM3UwUENSaVluMTk3bVlVbGVu?=
 =?utf-8?B?RTlyajlOTml4VlFyRkluNU8rWlRZNGl4UTVSWnh1SnlaS0lob21mMU8rZ3Ns?=
 =?utf-8?B?ekROVDgvak9BdHhFeHZNNjFEYUhCZFptVFUyT0ZOcnJqMGdETEJuaStNdjlJ?=
 =?utf-8?B?UmNBWWlmVWY1VHhGNXFLZXRON2ppVEl5bUJjN0dlNWwvU0YzR3llYWNwU0V2?=
 =?utf-8?B?TDRVTGFpaFk3ZVlHVjJmTWpOS3BFR0F1K1EwaFlvMnlwbTBibGVlcHViZ0Qv?=
 =?utf-8?B?V1lDNnM4SWExZGFHc0MvdjhTL240TU5Mc0NBbVkxbzd4SEN0WmxWQk85cnFY?=
 =?utf-8?B?djJlSlJlNEFwUHhXNU51THBodFh0ZHE5VlYwRWFldklFM1lPSC9kdW0xNERN?=
 =?utf-8?B?Q0UwZXVka0YwWFlHYzFIeGRLZjQxNDdUMEtRTEV3YjNLYUlkTGZkcXRxYnpS?=
 =?utf-8?B?eHB2U2JlTEJKenJWODZBRDRMRWhXajdPR1ZvN0NWQW1WM0xBOHgzb1JDQUhG?=
 =?utf-8?B?QlJmNmxMRTRUakd6NHNCWkUzUXVub1lhQmw2RlAwME13aTFQVkNDK1ovNHg5?=
 =?utf-8?B?YjhMRDFLc1VJL0UxKzFYc1hkbld0WG5RU051bFBBNXR4bDJpOXlvUURwTEFU?=
 =?utf-8?B?WW13Y3hoSTNQWVFRN3htRnZpakVsNG10NDg0YlUxY2gvV0pvOTA4UWFTcHp2?=
 =?utf-8?B?VTZtbWpSWmtBUzQzS2ZoQ2Z2N1NkKytMMXFjVTdRRzd3MjliZkRjUXZYdG9t?=
 =?utf-8?B?TDkzVFhDeExzRlB3dFVGSnN3c1Q4SUpKMklWTHpLSWdNREFCV2Mxd2pFL1d0?=
 =?utf-8?B?Y3hBYmhlUnRpQ1p4UDRsc2FkNjVWR0d1aEQ1QmkvcVA3T3l0aWVtTGZXeGZJ?=
 =?utf-8?B?d3krQVozM1hkS3VmQ1FqUDdXazJCQ0NxZ2JWejRkSlphblZnOU9jQUREdFgx?=
 =?utf-8?B?TlJ0aFVWUVRJVFRObDVMQVlSN2FSTmw3dFFDYTVtR3BSWXBzckpDWGpQaHpn?=
 =?utf-8?B?OEZzclZvd0ZrN2tTczc2UjNJQUYvYnkxOUZHYU1MenFSUjRmMS9sb1RxbWRO?=
 =?utf-8?B?Vi9RL2dSa3Qyaks5YlZqWnVIVk1aOUJiVnF1WVdINUYvbEw4UzJnYlE5MUF3?=
 =?utf-8?B?NEFxakwrMzlwTk1EZmFhQ1FpQmpMUWhSaGVKQ2pvT2Ewd1hreG5qd0IwbjJi?=
 =?utf-8?B?NGRwaEF4V0lQNnFpNEc0blZLTW5VV1JlSnNoMzlyL1dWVTNNMW9YL2NZVjhm?=
 =?utf-8?B?d3poZHNRVXZYRDY1T2RZdG91OEpjdmJYczRubzQ2dXpBeFpGZmdIcXBmSE1S?=
 =?utf-8?B?RGZjV1JqMDZpd3NwWFJnYnlEODR5bGFidk9ZejVtTnp0bWdzMlpNYjcveElP?=
 =?utf-8?B?RVZaejNWMlNHUlZYNm5BVS93Sm5VN25kT0RQOFBBQ1hnQlpRRG1zSHBiclhm?=
 =?utf-8?B?MnN0amNYbkJLSVdpSDVWUnJrQ1p5MjRLdGdLYlpxRERYVjViQkZGb3lNUzM0?=
 =?utf-8?B?WWt2bStPTENHRjNLUG9LTDVTMnExcVhTb2xkQ0t6WlFxN3JUTW5zbE1RdkN5?=
 =?utf-8?B?MnpMb3pob2pTUnlVTlRSR291Zlg5VGVqWkRlS2svNnJIK0ptT3IwZVRUQzQ2?=
 =?utf-8?B?VStjV2VTaHIxVk9MdTZCVlJ3OTZHU2I5dTFkMitLcEJ0MVBTRDRTWU4wUzlz?=
 =?utf-8?B?cFlLSTZqVmxqaEVrU3k1MENUK0V2Yzc2cGlQVURudTF6dkxMRE1ab3ppclN0?=
 =?utf-8?B?UlVMczV5cFphWk0yNmpYMUREdCt5S1NCTnVCRWk3OEk2cGd5aDM1WE1wMlFj?=
 =?utf-8?B?U2p2SXdMZmw0SlFoTEs1MlNYR0tRZjRIemx2Uk9qUElSMzlrcVczYnVVRUlh?=
 =?utf-8?B?NFdOdDNvblY0bWlmL3VhaUVKdmw3V1JydzRhdUhXQ1FUYVNlVkI5amxUT0tG?=
 =?utf-8?B?UG5WZC9oMmdQeDUrdGxiN2o0MXFxSUxVTVhYbXYvOXp5ME9RNlZtTWtxM3cr?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +gNa9GNJcwPOTvFKFjNndcPC6FiRhZRFrNQsNgzcSFHsrSQ7Nh6AYKXuKdiSr3vVxniJ+Y1UTtfc/Xha6f6Lacvz6qt02QjdP26PwQZhkWCFEFVFlPgzjvxInPSIIu2n9LQwT4VqIwmf0rerMP3/N05HU/Id295+RYxPJeDQ5KZeZpxQiCnL/exL07BICPWFhou2DhfPKh1fr1C8ix4Opt8ewnXshAOGgyy30NeAqLEODG04f7523pEblF4+NbTf98WGAOHyQtmG5lkI5HKSYjkuPxxB/G5UFktyxSuXMUvkBeewZGRXY0iOVC3mWYwxYtNi3J6oYVPhXvfWbjJy0IrdhhLeSa6UIIC10cBFZyCKv0rZNt9UeJO8eWrUTi49Nxkcmkfih44z7eEmDrOXI7Ux+2HVmctLr30zf46HYCN0YXVAjihWuVK2KMh7S30rHbIPe1V3kkrExKxR5M4kPMSg+lPuB5dLB6KuOJg4MnpIBL+yZO6JkGFVrUcpNzPf4cZu8F0hT6PEeqJsKUektk5ousq8/FIAokBXYUysjrHPnxuN1ytN5IA0PdTEt8t5UaLInH7zn9Mz0hrXsjS4ne/YpQVNBzhf7g4QKpOzerY4Lzf7EK9hPNqc+pP9VkfC8Ocl4SNh8kxGKMZuCFPXO9c2RE5lWxfk3KW3pGctxKALCyQKJFVHXUyJ8cCofuVm6scMVTw8bm6zD2ZQmTnlD2kIdyR0+RhHadurZZyApnktefCduZcSFfmBu1wGXodaKQZ/cfqEzWtEgsRa7SH/VvgI0xp7XCwsZwhqzbfc3xK1LywoCIbE6AneM2Fyf2gAmLA6tdTVyA0APGz60KdWYzaZTi4h89QSr5ux6F0VeqJvmSCGfRkQip2whSzaYtXZ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644fe4fc-7e57-4848-59ea-08db295db6ef
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:11:08.2925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwcbVDMpDaG3LQ3qtc9x+ZBzHKejQuDKrgjiz32MjCOvy5x2ICKiBBpjK5Q2PZwylBFEnYIqNedlHfkwTFF5gSx7OhEkoVNV4fFcagt1e1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_13,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=927 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200137
X-Proofpoint-GUID: _a1HElq_BejjgODNOjphd9SVs2n7bswI
X-Proofpoint-ORIG-GUID: _a1HElq_BejjgODNOjphd9SVs2n7bswI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/23 3:13 AM, Zheng Wang wrote:
> In qedi_probe, it calls __qedi_probe, which bound &qedi->recovery_work
> with qedi_recovery_handler and bound &qedi->board_disable_work
> with qedi_board_disable_work.
> 
> When it calls qedi_schedule_recovery_handler, it will finally
> call schedule_delayed_work to start the work.
> 
> When we call qedi_remove to remove the driver, there
> may be a sequence as follows:
> 
> Fix it by finishing the work before cleanup in qedi_remove.
> 
> CPU0                  CPU1
> 
>                      |qedi_recovery_handler
> qedi_remove          |
>   __qedi_remove      |
> iscsi_host_free      |
> scsi_host_put        |
> //free shost         |
>                      |iscsi_host_for_each_session
>                      |//use qedi->shost
> 
> Fixes: 4b1068f5d74b ("scsi: qedi: Add MFW error recovery process")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/scsi/qedi/qedi_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
> index f2ee49756df8..25223f6f5344 100644
> --- a/drivers/scsi/qedi/qedi_main.c
> +++ b/drivers/scsi/qedi/qedi_main.c
> @@ -2414,6 +2414,10 @@ static void __qedi_remove(struct pci_dev *pdev, int mode)
>  	int rval;
>  	u16 retry = 10;
>  
> +	/*cancel work*/

This comment is not needed. The name of the functions you are calling have
"cancel" and "work" in them so we know. If you want to add a comment explain
why the cancel calls are needed here.


> +	cancel_delayed_work_sync(&qedi->recovery_work);
> +	cancel_delayed_work_sync(&qedi->board_disable_work);


How do you know after you have called cancel_delayed_work_sync that
schedule_recovery_handler or schedule_hw_err_handler can't be called?
I don't know the qed driver well, but it looks like you could have
operations still running, so after you cancel here one of those ops
could lead to them scheduling the work again.


> +
>  	if (mode == QEDI_MODE_NORMAL)
>  		iscsi_host_remove(qedi->shost, false);
>  	else if (mode == QEDI_MODE_SHUTDOWN)

