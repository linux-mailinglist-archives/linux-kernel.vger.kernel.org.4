Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFABA66CE71
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjAPSLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjAPSLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:11:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F542B63B;
        Mon, 16 Jan 2023 09:55:41 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30GGnXEO003584;
        Mon, 16 Jan 2023 17:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DixW04/oegFhi01CfjSMV6OVQ8u8n2Zk3KjOpUCIfz8=;
 b=F0xb1NB6oi5rbWriXmag4PY1XzBPY63FTIUg59tCC0KtvOKoMrDoUBQkXYjwYdWRN1v4
 L970xZpiCd1OBnjClu4+exrFqK20a0KwurwsAEP/+pSizG8UhVziD3a/UpPgPkP2Yv1b
 vn8/cSxOZEivCVHxfiW+L2muYfxCdz8lzQV5bKVfpo565mvFs0gU/6AHWF4uvkhfmXq6
 ORn+sl2xso8SXRJyKsIPDrjBIk4SYjVLnnjOJiVu5CwdwvhTkNd6Pp3ExOQvG9YlIRNK
 O8Z0i/8frN73aNs3xqg258nBPqYb9bBaOcnUJGE0vB+TVHauPm3IEKChg3jPwK/D2MrQ oA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxt36af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 17:55:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GGS2jW004972;
        Mon, 16 Jan 2023 17:55:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyxpr4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 17:55:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCRpQx5cWXZ0bCU89LQ1HT4dw/EDuRM4DhCF7LlGwlGkicbpqTuiK4kKItSFzy5obQzvMYAtYvKXyA8TDHe3fJoR2KPaoEpuNBXPJa266tFLFXUH4NXzbJp19a1IMtaG2PwHmnpoMkjNNDvDBRzfOVYA5ERdyGcEyuJ2J66u8Onzg7PYEi3gsRuxqHBxq4Vqm5qGihbE1YaUHcxP6wJYcrM3R/ZlRmjnB8IAqG/G1toruvW7Zxtya0XuE+3QVXFfNg8s9hoH4HnWee4D98/ixVRpk1I5SD3dlMIogaMSU1KDKeY/T4uAbld+AqBdQWXR5D4U3qRhYlCShObM27YWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DixW04/oegFhi01CfjSMV6OVQ8u8n2Zk3KjOpUCIfz8=;
 b=FVM+xMgYwGJ9z1UogPiME8Oa9hys/r3eV1Fs9B1oGdHt0B2fejxNKUcfkoj4SJUBrXyus5y+PlyIG+juzUmOlwm1O1XbvkX4pNvGi50y6WeUwnzGc2rnq0ABjNQ30iFleYAZmGMkeUSS3StxgDsfkO2f5ajZqLcdprEwLkXg2VVw7OfZw1b4DfNU/IFfl6ESayEJE2ofBPRGiHKkwQVUlPX+tq+JaMcovapgj0Rq6fALt3H2f7E21mYAIDHYO3QqzfJW9Z5kfV7vVONmXciik+vStirCkeqIyCUP/Sa/s/szQ/ugl8hVwegVi1XibpMPR1DMwkvWjTvc48YMqOTE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DixW04/oegFhi01CfjSMV6OVQ8u8n2Zk3KjOpUCIfz8=;
 b=lj/LYmP5C9c4B6Xxk7tXm7YluNyFdLnrik5pn63K4+kLfd36Llxak1N23B8AZ3y7zqaWpg9QcOR/mObgTt/oEvNSbWMRhoyLURKU1knGkOhN0Hnxs1Ne9WpH9tHUpi8v8xYUTWhhm7nzhxeaI5ZY+f9raOMT09yNJmCe+BdYHwg=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11; Mon, 16 Jan 2023 17:55:26 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6002.011; Mon, 16 Jan 2023
 17:55:26 +0000
Message-ID: <57bd58f9-7df6-62e6-9d16-83102e942f88@oracle.com>
Date:   Mon, 16 Jan 2023 11:55:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230116132415.793bb720@canb.auug.org.au>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230116132415.793bb720@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::25) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CO1PR10MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f87175f-922b-46b7-0285-08daf7ead887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WjMf8hQygOXi2a1c1Jtg1aUUT/1kMCv+dlfedTAmVWl9IaULcbz+A6q6bwmTHnsFKk8hZQ3RApx5+ukhAdOgE2QVAH2T/xPyepzmroKiVIn/3z1+qYEv4W+9rLt+WKYMjK9D/oZ/T0IlgSR2po/SDSlnL+DnpdCfO2UoZwc+gwddPS4fGtogGRaiYh/BQry01A6W7B7GoJyuio7bkKOkfkG67+00DBsT56nY1rxANHjarihPR3OnwSiT1LqdEkmzfsB63mZ4ehluOVI4bNn6n2b12omiqZptC83cqid5pr8ZOcYYS2ZapVr8EoUMXcDQJCDrwP+J76cpz0VAIom1gAmb5WrDIinXvwPlLg3C9zuGYKN9AisoOzSxuJWJ7n3rbiQXeH1zWVQ8YFeawbg3MaSZFWbnHXn64yGxIdBq3lddrWky72bxFx924ajeexF2CfqaIaGlVWKVBhZyo11Y2hc/zaelQUGb3lSM29fKTjfX+iur4py5V7CSg4A5rRVROzrktAPKQQTOvA1c6FW43GX5DQWkz7tf/qCDhJZDRUS8WlsVf3ppxEhSkxNRRURk1Jjn8cc6FKB183jJlxKnyR2SlBlMb9G/4/yzXDl72aW4YV/N+6+QoTPUCO1D5862oik5KHeB5owvuA+FcGo02iiyhnEXoBvPP04vuBCyERrfLB9MwRks+JiHz1dBxgaXgA3Kjwug+Vk0XP5IT9qnO6u1ZSCXl1e5ugHZSLkdAbU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(6486002)(31686004)(478600001)(6666004)(83380400001)(2616005)(54906003)(316002)(186003)(6506007)(110136005)(6636002)(53546011)(6512007)(26005)(2906002)(31696002)(66556008)(8936002)(41300700001)(66476007)(5660300002)(4744005)(66946007)(4326008)(8676002)(86362001)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWZlVHhiV0s3eTRIdTdSMTRMMXF6Y2o1V1NocGEvZTQwSnVNbXBRcUVQMTVQ?=
 =?utf-8?B?N1MreDB4TkNkOU5KdS9FTlZIUjJLNzU5aC9GcU53WXp6RjBWTzJ1Vzk5dndW?=
 =?utf-8?B?RFVqQ015emxNbHNoeVVCZnl1OGVXNjJDVG9rUFk0Q3BqVjdyem1SWnVnNFNn?=
 =?utf-8?B?K3BvNkZqV1o4LzNSZ2JWbFIxQjRlNTNCMVhKc2dXNUU4Rkg0RlFwNDQwSEtz?=
 =?utf-8?B?YkFSMTc0K0JEY0kvc0VLOEtsTFFwT0pyQjQwdmZPcTRIZGR5ODlsM1FZSTB2?=
 =?utf-8?B?SGJNNnVlZDRzYVhpOTJQWXpKNGk5eDBqbWhnaDRZZ2FHM2pqRTYxbGpiSmx3?=
 =?utf-8?B?WnJvM2ZyMVpPQkZjV1ZjMHcvTnpjQzhmUWxObUIrM1k2T3MrZ2lnNENyYTZK?=
 =?utf-8?B?ZnBUZW5tQjRsRmpWWExkWHkvUnE0YkV4TmR4N0pUb1gxbmc5RDlmTzh1RTVJ?=
 =?utf-8?B?SGg1Smw5eGFUdEROVkQrOUs5ZWZYK2pHb2lHcEwzaTRwRU1LUUl5a1J0MTVQ?=
 =?utf-8?B?UUY2b2c0V0tkYnRrb3dteTUzQ0l3cWdnaTlZRFJWd01FWDF5UjlaMkdwTUxm?=
 =?utf-8?B?RkJvZnY0cU00VjRNZWprZ2lwK2xaSXV5NEp1T0o2NUIxQ0NQRzljb2Qrb2dj?=
 =?utf-8?B?QTIyVGk2eVI5VjU2bDNZa2JQa2h6MmtVYXVvUGZXSElVeUVVb2p2NkVQMVBM?=
 =?utf-8?B?VGR2TnAwUDM5a1VteHg2Umpod3NKK3p1SE1HVkVGUm53aU9tMUk1UlYrT3VG?=
 =?utf-8?B?TkVZZ2hKcUlldk5vaEt4R1ljeTBrM3paTTh0eGFycG5uMjhrdEE3RmFjREFs?=
 =?utf-8?B?M0tBTkM2blRiSjVGRkNtNUhMeDI0TmN4eXE2L3BzaXNTems5dndxWllMdEN2?=
 =?utf-8?B?NzFHS2ZocTZOOUhBVEFMQXBRblNLa2NOYnI4cHpaZjI1RndqQjVIL2IvMG5k?=
 =?utf-8?B?SEZGVmlCTHZtWjFDYytsM3gzRGhDYzBnd2d1S1l0MnFPS3gwYlo2QzF4QTlw?=
 =?utf-8?B?UWZqUERWRytIaDVJczZ3V2ZDTm5PSTFRWU1uNVl5RTY0QTVQWW0rSmVSVmdM?=
 =?utf-8?B?dDNKQnhrT0tUM3RPNlhmWmJBaEpYQ0Z3cHl0NWt2d2x6enA4ZjV1MHF5NlFD?=
 =?utf-8?B?UElPbmVHUk1FVkFsallqbmVuV3B3ZUFFSzRGQ0E0cVZCTllURGhYWi9BclJa?=
 =?utf-8?B?aFhwazVJL0Fpa0hUaHgzWTZwd09HL1R6ZlN6YUxRV3Z1eXl0Tmh6UjBOMmN3?=
 =?utf-8?B?MHh0TFcrN0YycGE0d3J5WFRzNDJEZ1JJU2RmSFVBdnV5Y3VOMllVN3ZtRERa?=
 =?utf-8?B?d2VMNlJ2K1lUbWxCZ2d3d0NHdkNHcG5wQW9LRVJaMjFDeTBVVmtrSDJ0dTMw?=
 =?utf-8?B?ckZTT0VZeDRtbEZmczNlK2FCSitlaG1JbDRLSS9mV1hKeUNXMzJ3U2N3a045?=
 =?utf-8?B?NWZtaUozbUZGM1NDWG1yU3p4MVBUUzFBL085eEkvd3dmaVMrMk4wQWtwVTdM?=
 =?utf-8?B?UnhEZFd1b0dOeHhWOUdkQ3ZDV0tJOTJsdkZXa2lEQWJlamQ3dFo4bWNyb2V1?=
 =?utf-8?B?cEt4Z0xQVU13WkpYWjlkY01CamtJYlRGWnlwdTFaT1JUTkNZdG1mcHdzMkN1?=
 =?utf-8?B?MXZlS0V4aVhqbm45d00rNUlURm9pUFZybFROYXpOWXpOZ2pFZ1c0ZEgvakdw?=
 =?utf-8?B?Q0x6UjlKWCs1d3pQSjkwd2NyVW1sNm5uSzJ1YXppVGVKL0dzMEd6dTNITlBh?=
 =?utf-8?B?d0dBU2kwa3lPVmFJQkZYcGhRKzZucHVaRTdPZFlKdDE3cE1EZFdRV2NJU05O?=
 =?utf-8?B?MEhvcExlUGlTMDViSEI3NGdMTGhucUVpRkZoRCsycUxQWFcyd1hGaUFuQzdy?=
 =?utf-8?B?UFZwaVBsTEx6aVU0eDVWZXFaOXJHM0lwb0R4MnI3ajNPbC95Tm5CTEJ0a256?=
 =?utf-8?B?SmZ2MlM1cVJmRGU5WWxJbjM4RkQxR2FnOVQwSzh3TmpSK2UvY0tJTS9rRk90?=
 =?utf-8?B?T0RTc1ZiUVNWRXYyRUgyTUV3NERMVEVRNHgxeENPTDJOeThCTkV3UWw0MitT?=
 =?utf-8?B?YVdMMmJyWEhCSHNVVmdGZndHZHRJdUowWUlPVGZxUGVxKzMyMFFma2RzMmNQ?=
 =?utf-8?B?b1AvMDd3L2NNM1ZWbHQrdUVGVUhyYzBJNHdKMHYrVFNYeUIyL1NZdlBOOHJ4?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kLOQNRHzkSEcZvQWGn9r4eRU2z4r0HhZm6SPM+sHo+BqD9qd6cjApaG4hU0IZ19vxmua27f2GkOB1QzDWyOgaYzoSjg+KYLQLVz5MGqm3MowHqvtOI3Ojxtp8ciY+e3z8ONciqvpgiBssbbS5CLPeczpIdR1LXHgPQ5+IJO108DmcLNhJbhD8NLFZHBGQ2vK5ez1ruIiPoUNaU03uVJwlBbBYbIbS+y133VEPP6OErKo48B563562GUxXdOyKJA8cn7H5rJBvNV1kNyiTTSDvtSITGTfy6JeuKm5RYxpAj+do/2tNz2eLy4BlkOsCTbQuHCIFoXddejTNOFGQc9UH/+R4IkPT+j4k9ab8uAYjNCKoeSE8ztvowTVWksBzhJ9EK/mrQVf3o/mksc1Geu1JbSIx3elMC+6vdqsVpft0xquYB9vnGDq1T60hgZ+EsSWI0brnGouOTij5gePVnkxAMCYou+q1yg63iV3NlQtOEBnwKcrzNdehm4VFqcMVhlayHSwQdCf8cYzowtXmkIt1SsvmPTXotbT+poD3w5vaQEL3RIpFZAal31CAwwfGy6RCZzg+PaW4Tb+SJDDsaw5EDAPJNYDmaGHS/hQkwuWghfytjyH7955HqqqBNlcVfdYPeVVnDiaO7tJbM791QAECd30OiXQhsa7sU5NghemiI1thbIqx10v7pB9IIaHnI+w/LNWpbCdvaQmZtVZ32ga94qkWwheV9Bu0evsjFNNYgZ9eTHwvLyeshfI/9Yr2mraGz0gmiP76iMAoGyjU0TJoyMASrpLk0pXmVlq1qZDDX4BU1jmd2EsUeyPXSEnBY3R
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f87175f-922b-46b7-0285-08daf7ead887
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 17:55:25.9261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKBwIr4YvUVdaqmjrhmtHBKWkem+dwsM8Iux5nrl0UR3OomwHoSpP0assXZa9P79Fow/GbghXdyA1NMgPz62qP5Te5IfJawCPWac6GlQgVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_15,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301160134
X-Proofpoint-GUID: mvqY2J0KlsToRAtSO41V8xPucKJZuW0f
X-Proofpoint-ORIG-GUID: mvqY2J0KlsToRAtSO41V8xPucKJZuW0f
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/23 8:24 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the scsi-mkp tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> drivers/scsi/cxlflash/superpipe.c: In function 'read_cap16':
> drivers/scsi/cxlflash/superpipe.c:364:65: error: incompatible type for argument 8 of 'scsi_execute_cmd'
>   364 |                                   CMD_BUFSIZE, to, CMD_RETRIES, exec_args);
>       |                                                                 ^~~~~~~~~

Sorry and thanks. I'll send an updated patchset.
