Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4776D73B927
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjFWNxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjFWNxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:53:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39683
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:53:40 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDohwe002441;
        Fri, 23 Jun 2023 13:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=XomQMZQUY4Tv+rvGi2acRWw1pWw42fEscpVjiF+JfMI=;
 b=qjx67A0aA+C1DHK4OdmZKjw265/PiNNKSnYXpKYu3mZPDm6gR8/RU0O4Di0PIom4gfpe
 SEkWzONp8DAZc5Rtu8lWuaXSPQMNAFMvAbNFxp1UHpVmcimalPEAKqpN1sZFO2GlGXB2
 wXk/NbbVbq++Dd+8Tl5bc+G7+qYV7AmTsAgxZyuhR7M5TpP+yms674bZcudtRbN+1Vq5
 CepXWG3AGnokkC02lVehbI9YN+1iec1TkuvQVhMLNWqqgKsumtSePYh+3L+lK8BZsq99
 X+MWIrQFfGm8wlxd8L1d4DTKBj/mAx4W5jV4pS7z8x89PJTcKCVTk0P/8+onaL73q7S2 iA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vcv8b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 13:53:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35ND1XqK007741;
        Fri, 23 Jun 2023 13:53:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w19fe1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 13:53:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJE5IkpIpBxka0/FbDXMBd5w7Pp9mRwgEhuFB5MZps7rCVr9NjDV0ClK4bw3MU+IdJ3UJv6Waw8cbO8Q6/qc61rYQCAJHU5VgYPKvcNe0KNqrnwEbrni0swfHghknQiHYQ+vKpBg8pN0b2O0l4N0TLI/+AmhzE3Q8adOx5E3EbmR7NwXjQQjSuzIhVKrMumup3A8MNDzVhDdSdWRs4XARG+I2tT0rM1UFaFpybP9NcqEr/PaxgZzX3LY72OTCRxAr3P3uHxF9SZTh2Y8DEKW5JfjHnieSkF0IieaJUIKic9UKwBRt7eqc+hJfxKkbFcpb3JupSDeXFmjqwHX96H0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XomQMZQUY4Tv+rvGi2acRWw1pWw42fEscpVjiF+JfMI=;
 b=HPO97sgAip8iOjoglVNV+se8XyOeAGezsZZ9Tjirs/boBTx3lqX1shQ3DARZm87cwRIA8XS7IGusd2DnM7yVNuAcqYX1LkoJlV7UGP+FZm+UJDqNUB3TowJ6u7pLm7lgtDiyNxOCMsJdH0iOYwH67IS5e9InHIzuzckK1jdHovnoF4fbAI8UOLxUW0L5kPK1EM3e7wQX3roam7srMz2CmOCnGR1NJEfvoCdxvRgTdJz96dRKMkWU/vCpILeRfzUYMG9AiIVpqLoGZjGbAOqfm2to8sxW0r6RtMtuvrOnuE3ocA5AGrAyr3+LP3M0OjUDyu0j4AEddf+gEoFPMTUAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XomQMZQUY4Tv+rvGi2acRWw1pWw42fEscpVjiF+JfMI=;
 b=WNrrWGfx8Cxt2HTQNI0YJvmKCDB6rA1oJ49TdOgG9/aPsPXXR7HZUKd25W9G16INRsEZGNipnxiblotO0CnwdIxsOkvPprQDPllMjfuREbCcGyG7vbzphICAixdKet/FEB7hV948Nywy6xVOn+JVRhIWLNs7GMk2x3xj1b4rQ8Q=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CH2PR10MB4343.namprd10.prod.outlook.com (2603:10b6:610:a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 13:53:17 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 13:53:17 +0000
Message-ID: <78557979-4de5-7012-d513-c4524477181f@oracle.com>
Date:   Fri, 23 Jun 2023 08:53:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] FS: JFS: Check for read-only mounted filesystem in
 txBegin
Content-Language: en-US
To:     mirimmad@outlook.com, shaggy@kernel.org
Cc:     Immad Mir <mirimmad17@gmail.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <CY5PR12MB6455588C9343BADC6760A96CC623A@CY5PR12MB6455.namprd12.prod.outlook.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <CY5PR12MB6455588C9343BADC6760A96CC623A@CY5PR12MB6455.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0016.namprd19.prod.outlook.com
 (2603:10b6:610:4d::26) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CH2PR10MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2d9645-6191-4412-2c16-08db73f13287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTNW8bBvOq+I9a5IQezCtgjHVQA/rXhUXjNGeXjGDFQSdEFz0wIEFU9TPk+5koIK2wVjyqcWoliGnm06HeajI9o8dEpr54BJYT2dRR2AG0AuCi5ZgwDTe8s4ff3y3A++3lmby+iDdTGavD+2WsVg2dHE8pw/SDRfAvOw3GlCofUzhV2U7cuoH4ZRnv2mKV+pW+GCWBKAdikYGxjjGyESzBxVhFhjLMUjMRWe1hB0rHhW7rItrNJRTOSMx9RynF6+3xSTHnsN24219g7lZFbPyX8eaIfXgxxjpcAe54eH1lZmij3swQRJo3qooSDY6aw7n9/uJ9MZuT5LUobrIBcmJ85PZTjG4iVicWKOIZZ2gT6WNSbNZlbSd7CJPMKCbog/fFFXOFS+iiQNuvi83qcK/jQCCtM5rITdwI0Tx/qcKzMqHsNPL5Qf6GI+81mZgZyIaTqhTEvFxSvshspr/O5RDFg2UC4ve3MNbN6iqik7gscbfHGXX1PUJRIu3BmjJkasgimvUTF8OFUEZOGxP7HXeowhjTpc6hYLorSSsq0YFMFiYHnChVGVVC7r2RIrhoVMjZSHE+vvsMRfPbfhi3+s8N/EugX/48Fj17MRhRzAYNYSV7n4OXp5Wl6NkjzclYbU8wFKc3621cG9Mc90/vpfaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(4744005)(2906002)(45080400002)(6486002)(38100700002)(2616005)(83380400001)(6512007)(6506007)(186003)(26005)(41300700001)(31696002)(86362001)(478600001)(316002)(66946007)(66556008)(66476007)(36756003)(4326008)(5660300002)(31686004)(8676002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1lyd2JReGttbGxtM20zK2JsbjZQMzQ4OG5DYkNxbHFIOFRqZG9XQ084eFor?=
 =?utf-8?B?VE1SWGdkUVZ3b3pSSGd1aStoSTI4SXNmOGppcU01QXhwSy9SK0dudWt5VWcr?=
 =?utf-8?B?bGdVNkRmdTJkbHlBdGZsUjVJTURRVWxrMk1JbEc4Q1F5dXRjMTFKbCticmd1?=
 =?utf-8?B?WTB5NTZmYmFYTDNSMnp5OW50cXRQdlhXSGN6T2syREV6c3Bla2VreldiSUJi?=
 =?utf-8?B?VXpHRWovZUhQQ1BJNkgxYkxkL3l4S2VNQ1cybm1aVVFQQWhuK0tKYStUblJO?=
 =?utf-8?B?NmFBSk9TaFhkWmlMdmViL2p6OHhNZkFGc3pPZEF4bFYxR21xd0d1aVU4ZFpC?=
 =?utf-8?B?OHB3UVJhaWppZjdROExtdVNkd2JKeDBQaG5DUmNGUjA1TXF0NjZZMXMyQi9E?=
 =?utf-8?B?TXg5V21zV1dJNU9MWjlvbUgvWnhxdFN5Uk9Gbk9vc0tyeVdDSDZVWElvQVV2?=
 =?utf-8?B?MExYeldYOUxWb2E1cHJYVUtjcEtUWDZhVjArUENqVWo0bDVlNmhmdnZ4eFU3?=
 =?utf-8?B?SWZCbGJ4N21ybFhIQ0tmU3dTMG5hQ0UrR0pUeCtLaXZzaDNkMyt3WjhYZ3F5?=
 =?utf-8?B?TEtqcktyaHAvbXQ2YzlaaFJPRTVXUURrc0N2V2t4V0ZNUGNIWm9pVEM4OU12?=
 =?utf-8?B?WEprbFZzMm12amk5c3NjaFBmME44ZStzRnc0TkROR1lBTUp0emZBK2oyR2VU?=
 =?utf-8?B?V09wSUVZOHFLbDdaTTBhamdqcXVMSlN5VDlzdlo3aGdIbFdkakZ3TkRZNnQ0?=
 =?utf-8?B?alJuREtQVUtydlJtbWlhWHAvS2xJRlgySWhDdWRVanVIMVd1Z2J2N0N1NGZN?=
 =?utf-8?B?TFEwV1RmMVBXb2JDRzhoQ0FjQlNDcUhMSEE0VzlhZ1FYaWlvQ1BMUy9xRjNM?=
 =?utf-8?B?MWo0OHlKelYzKy9xL0VqTjBmcGpydUlWY3E4ZmRXVGxNVS9WRUNVMWYxTWtQ?=
 =?utf-8?B?Snp1dDlrVWRPR2lFaDVZRXErajJoVHhMRnpORHpEcHJMakJhOE9sNDlGcFdl?=
 =?utf-8?B?TDMyZVEyMmNDdm1uTEhvc3AzS21RdDdKVHUxRTNtdE5sV3ZsTkpubEJuM2p0?=
 =?utf-8?B?VUhWU3BSbjBwRXEyQ3RWS2R6Ym5FS0o4dnVUZXdtcXBXUnNQRW1JVmdPVWdR?=
 =?utf-8?B?bEpCRVE0L3Zvam14Mjg2eitmd1F5MElIc2xGeE83b0JQT2NpdGsxWllpRlhO?=
 =?utf-8?B?N0l2cXozZXR4bEllOWVVQUJ4Z1dPK0NYSGU5b09WNHlpbjBkNzNRamdncGhT?=
 =?utf-8?B?bVd4VFVYME5zTDEvZ1laNURIeERMcWxJL3pNL2lqT0U4R3RHZHFoZWdsMTJW?=
 =?utf-8?B?T3JMN1AzUjJMNTFOMGJISy9pV21laldpVldGVXJyaXV3RFZXM0tPcCtLT0VM?=
 =?utf-8?B?MS9xZkYwMTdWQWpmaUUxOGhza2lmVzlhU09zeXBMajlvODYrUVFqSHE4bGw1?=
 =?utf-8?B?UnVtRFZoMjhmRis5cG92QmVjekZWYm9ORlo2RHF1bnk1dnM1Z3ovb2RybW1r?=
 =?utf-8?B?MmtZT1haRXBVbE5IdytCRGkva09wRkNZNHBEOC84Z2R0TlZKR2puYjlZRUNJ?=
 =?utf-8?B?bWdXZ3kvdERwOFVzd3UyeTE0MlZrVzM1a09yd2FUOFdFbktaeUhMZStHbUJN?=
 =?utf-8?B?MkFwSnpvenRDdEFlUDVvZDNIMUxXL3JJODZwcW1VTXBzbzduSWs4czZSQ0lv?=
 =?utf-8?B?dnNYU3Z6Vzkvb3lzbnZ6Mm5XMmJuclpPeCsrNmtSMjVFYUdPUGZBWk8xaGJZ?=
 =?utf-8?B?OEgzVUFnWXFHQkNadFp2ZDNpcWZQQWd0SndQN2VlRFFsZCthVTNSdGN1NjVy?=
 =?utf-8?B?V0Rkdm1YSlk5QUNrQTRVRmhyak0xT3hrWHVnY1NUZ1BqMllkYVB2S1pLSzlJ?=
 =?utf-8?B?MGJGQlMvUnd2VW82ODRTR2lFWXg4T0NkWkNwTFpsK2Y3S0hzRFYrb09sRlhu?=
 =?utf-8?B?ZEUxU1oyV2Rzam5mcTFOSVN5Y1Y2VnlqdzQxQ1hsdHozSnNRL0pJTzRQZ0wv?=
 =?utf-8?B?dVJ3K3ZJbXZYTVhVMjA4OU1pWTljcFdmdDUweHkwS3lJSzA2VkVydG1mZ09P?=
 =?utf-8?B?bkR0N0JEYmpuOW5pL1JwUTh3NFZia3Vtdis1SytENXR6L2RYalQ5eG15eUtG?=
 =?utf-8?B?OUp1ZkRiZkpaUTkrTmVmWVl0VUtoOWFCNDZBTytrZkczSXdzZHdiWFFaWFFC?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C3kDS94cYBvpLR3VbnY4vzIXmhPDKzciX/5kxFVg80342FgmE5uAK3wuem2UMiFz/WCVg5xdnD6R3f4wWc75oojMjvRiF++J0/bkYTcokf/0vifg5MIsr/8D9vttChVYwGR/nwNJVmer4i5OA45ofc+Grve7euZKsxJfuEwXEIb88tdxf7ITbW7ce/M7HcXkMSn0Do0Ps8eAu9k5lw/Prl2opo5MY3ybcNnVVWzz+GJvEQ1WQtpuXaPW2ia+Tg6Ib5hta1oD+teOFQr58PMrgn6GV+pyLulg9VkNNISChSsp5nM+JNPjTspmwDnas91UQTf3umR9JnfaLz8ph0Xxk3LEXIEeeZsNWDjUIIhGnIKTDg+BY/lqOw3hzclJpSY4LqiYWiZCb6xKmQKnWmx8t6Q5VUEfQgI2DnT93yOKSgN3qwk4Q/jZLr32eSDbIVRJyNR3m8HRBcVA51w4BgOSBouCWrSuoNtz3bOrU/Lmyau98jJG+61TPvXHzFi1pG2fL6P+JjdOcAvRRhhiH47G63HWfpvwutCgXqmm/TkgXIkQoIqmztJKck7bnFPt2qMJJ1y0m4l+BmFBjxI1Hn3yjr24nnOO+5jRL6AP01+UTxUinWga0fl49CnY4d9t4mPx9Ad/bJqyiDDiJ83Imn+rqi32HHSsHQ8ax8w/OZ6A6muWrOyKFnixcdoiBorJlcauPdj/FluzZ+4/+olEE/G6VHoRTC4zU1iZy5VALPqHIm7Q+kURHLMXye2qMLHJsNpszn1DhrIaHLBjugStXXJsliIl9aXKqF0maePU4hoGk5cljhsH5MniIU9y8LtGlO6XH4sLYqW4njMTNgTSND8uNKOR2p7lHfycJEKmnDqpscbSZrV9AxsHllj6TKLFmpaKkQNeNEJ2jjvNJhNLtq04Pw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2d9645-6191-4412-2c16-08db73f13287
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 13:53:17.6420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEOyXxO+SDuXEJ24Ko0XQDUiGpu9Z7BGQCAG5oWQweNo0i93aUvY44CiAs2+DciVR8yIBlTFikQaNFbkmdIQsotHEf13FNK1lAoo7YxMu5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=952 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230127
X-Proofpoint-GUID: INtjdQClAeJbxIwwUd3BomxEkVEOKP2x
X-Proofpoint-ORIG-GUID: INtjdQClAeJbxIwwUd3BomxEkVEOKP2x
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/23 8:47AM, mirimmad@outlook.com wrote:
> From: Immad Mir <mirimmad17@gmail.com>
> 
>   This patch adds a check for read-only mounted filesystem
>   in txBegin before starting a transaction potentially saving
>   from NULL pointer deref.

Thanks. I like this. Not much else we can do since none of the callers 
anticipate an error. I'll push it to jfs-next.

Shaggy

> 
> Signed-off-by: Immad Mir <mirimmad17@gmail.com>
> ---
>   fs/jfs/jfs_txnmgr.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
> index ffd4feece..87dc4e3a4 100644
> --- a/fs/jfs/jfs_txnmgr.c
> +++ b/fs/jfs/jfs_txnmgr.c
> @@ -353,7 +353,10 @@ tid_t txBegin(struct super_block *sb, int flag)
>   
>   	jfs_info("txBegin: flag = 0x%x", flag);
>   	log = JFS_SBI(sb)->log;
> -
> +	if (!log) {
> +		jfs_error(sb, "read-only filesystem\n");
> +		return 0;
> +	}
>   	TXN_LOCK();
>   
>   	INCREMENT(TxStat.txBegin);
