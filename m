Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B917B70885C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjERTeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjERTeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:34:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48056E51
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:34:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6JD6v018341;
        Thu, 18 May 2023 14:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=t3fMBW05C58TmvbN+ox7McplGzPRCNLchTHdzirfeJQ=;
 b=2TxcilNNxO5FOb/4anGBBLZmGIhqjyHWC4D/quif128BapvMb+RRQRr2LCYrmkR4z6rZ
 Gej2xVeLL8byEAZPqjDJshpVkdDU/9Oj9WZjFF7NmocJ4ji4qy+xrl8icVLnkLXe5HZz
 9Ve9w62VEUTfDBhTSPQX5ilyBh+afkHN0XG/HZfR7vKTu/bVKHtEV7VWHnD+pnk0nStG
 FCcKoUVu0pqhlSXa6fbqNbM0DB+/bXUbPHMeb64fwjyXs/JINslUn7gCyGNxWJ+ZAyZY
 aTHbZ5tR/ZyVDWGnxwzXdPytX1PZq2mOQA1VaxozPDENKM4kucNKA942v3UKbhMU8Rs+ 8Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmx8j2vqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IE0xBg004186;
        Thu, 18 May 2023 14:57:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10d68rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvzBLhA/H9LUphLuIBOIHt0HHB4/Y+aaqD3Xcgy1HPznEhT9ohuTdY7xpzEL4J8Chp/MH8gXK06+Ny3k9C5FHYfy++DVZvywni1wrXN+G6k4UtIPE0/fI+V+K0z5QyvmoAVyHTEM637KGIpzDS7oPPA5MwoWhFYnYmJYvBC2vcJ7o/FuLMqwIOXP0AiP0coNvixuAXB5nuP0by0kZC3vjwPyvGz+1YFDKIoMaYiHQdWpEfainncudkcozn/HQSL1hQtFHE+1e/CP3Gflpue0/8vpHtBcTVdZn0SZQv5LQ4HcYDXpbxIYrGxpZYpNL3WfMwzvqWoKotI4bVGWWn4L2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3fMBW05C58TmvbN+ox7McplGzPRCNLchTHdzirfeJQ=;
 b=czZTgSzlG8XsTkqfOAvcjYoeOuQJUdYqHkeaIsOAcgC/TueA57C3NJOyZnOQ8Qgv/cXiXpkpLTRXK7CSYtcvSB63sOm2QgP6Nqm6s1dA1fbhyAuSmNUH5VkSxGIRVI5Cv8RtMp9Dg+uNRbteVvNAh9UBqcLOUhHmGVqkjQnLEdrIOCBihgMKowEJNVTavjCNzuUT+d9cHEx0vnJE13367A+1FqaEoh4boXt1axyil45VyF0F1GPAZdCpVyJFLmjX4irgTA+m/jM+RFVTa2Hl2TnMpSufgRU1grdHcvC73NVj4rjrlFSM1cj73hW81ukcWMwecSJM26Is/A36ikUbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3fMBW05C58TmvbN+ox7McplGzPRCNLchTHdzirfeJQ=;
 b=XP2UxOoGOhlachBBxmc5YZI8r1NJgcKugs+RUOChbNXRDw2iyUi80GemrhHlSwr3RBCpojqXLiVtt5ZjeKvlsJ8AM1ldTFp5BaosR99Cf3rzyhXo1td5MfQQDbNvnEDTZ+DwEpglVPmeJc/BuyNcD42lbOUtBYbiVVZpGnzCL2A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:57:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:57:11 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 33/35] maple_tree: Update testing code for mas_{next,prev,walk}
Date:   Thu, 18 May 2023 10:55:42 -0400
Message-Id: <20230518145544.1722059-34-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: a66dcb6f-8f0b-4464-68b2-08db57b028d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6ZRT2Vn6Ncz4xwnQD7eyoDNBdveVnnDPP1MnVP/DYGpRvLhRvyPM1DqOxiEIE78qQWaKRI8nmu0+Tje53fT4cLj+2InJlNqzm+YhZPGA8DAFe29JuGrCsy+JkEq+lUqh8cp7ZV8b+eNuQ4JQ83kj5WMF/XupVyCoFiuRhgeFZvOQ+GzInFdy3pMEf7G9MQc8Nl9XXcOqQOhK1DLEcmYjvfpKZKGzy843q9MAwUfwtA3hGr5IC8PRigFljni4RXhwhXm7C/fsy3nY/w8icKdBtsqWeFPSdmLuNfqAp4NcJ5G2CGVIzPr0c19yLVP/EJbzt4GxtSVyoMo4hm3h6BMeDKy92gNKOhDWpqMLuAh+DO9AsAabtf9ioJE3hjSq62REfK5klqIn0mgE7hjH7MfzPGux5yn5MwatrMVGOl9BGrdqRYx9ZAfC5gqguS0acOFhwzFrQ6l1sIRY7XwtCJlpiavJ46Glb71lLP1U+379F/Tlu7OIwo2K/Gsw04rbwe3RgPPJrP4SxKfUc0bjsY4VZ1bXTUt1ry1gJlQzabBfdPWAgpF8X4PmPiVR/aoBzGS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(41300700001)(6666004)(316002)(66556008)(66476007)(66946007)(6916009)(4326008)(6486002)(8676002)(8936002)(478600001)(5660300002)(107886003)(86362001)(26005)(6506007)(15650500001)(6512007)(1076003)(30864003)(186003)(2906002)(38100700002)(83380400001)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHJFN2ZZV0dsMzN3Znpkdmx1THkwdkI0VklrQm95dXY0Mi8xY2ZONytpQUhC?=
 =?utf-8?B?TFFQeGp3NjgzNDV6YkJSSTFpUUNmT256bktLdHlhOTBlalVPNHJmbHlYd1gz?=
 =?utf-8?B?c2VYK2FvZ3dFRTIxb3RCNWtEa1VSQlpPaVdWbWgvOHdmNzlzR1pONG4wZ1dD?=
 =?utf-8?B?UlFnSVovV0lJbWI1R2FFYmFOckVtc3lyTTRka0l0VW8yUmFYR0pCOXpSL003?=
 =?utf-8?B?TzRMTEk4S3RGZkdUeEJoVEJLcmk2U1RtOC9YRjZVZ0xMcnFQZHFnVTFCQ1J6?=
 =?utf-8?B?SWZwY2hvQk5DSHBSYi8xSi9Qd0J3MDZFSEd4ejNnN1J0STh3UElOWUNwNFFM?=
 =?utf-8?B?ZHZiZFR4V0xYdFFYNjRtU3JjbXBpQVJud0dWaldWd0lXaFVyTEJTRXhkUjcw?=
 =?utf-8?B?OVhFYkNldkc2cUhTcGQ4dEIvZ0o3VThTaU5FUytMeStXNmRNTFM4bFZxVyt3?=
 =?utf-8?B?M25hM0p6U2ZNcFUxUUVCcVZqMkltNTg0M0pmMlo1d2wxLzdDZVhwZ3Nkd3pN?=
 =?utf-8?B?YlF5dmgvSkIzN2tHN0dwbDhPelJvcERkZU5ncXpzSzd0dGEyME5BdWdxZ3FD?=
 =?utf-8?B?Y1plK1hGQmVlVFlKUFJQZ2p0L0lrM2dCd0tKRW5GSGJzUlhoSnJMVFQ0RFhB?=
 =?utf-8?B?eGhQMTdYWis4alpxUEkvZm9aNjR5QTA1Zk4zM08wSGFHc1gxOHZ0RUlWVS94?=
 =?utf-8?B?UTFsSEQwanNVZWdWVWFld2hOV2Z0RXdTWUdlOGkxc0NLREdVY3NxSjBoUDJM?=
 =?utf-8?B?WlloWUs1OWQxUGNRMm91Sk1pZWJoaS96eVphQ1k2bzVFQU1xUGxZRHlCd0J0?=
 =?utf-8?B?OXUwaXUraGNUMGF6OFFwYnEwZHF4RnhJVW1DQmxkdnlHTEh0bVVLZ01qMHlN?=
 =?utf-8?B?YlJjRmFhWGpCYUJJS3lvN1A0Nlo3MlA4T3M3ZjUxVDBNZ01RU0g5dXphdDMy?=
 =?utf-8?B?TU14dCtFSnI4RDJES1NjNnRnMEtWcmV2UTRYVXFadVhKWVAxYThuYmI4OFA4?=
 =?utf-8?B?d0FiVUVrZGQ3Y3poSnQrSno4Q3lJdWI2ZW1pMDFscHZhQnlMZnFZT1lSUGFa?=
 =?utf-8?B?Q0EyU2k0ei9lWUV0dkFGS2dsQUlHZThmd2xhbTlSUjY1aTRHdGozVndCNzlO?=
 =?utf-8?B?MXNhNm0wZlZSQ0FiTnkwdjlCY08waitEbWFsSnptY3BuSk5RWllqWEJFejhC?=
 =?utf-8?B?ZUFFNDBlNXFicjZydWducWEvVUVCSFFjeEZwaHB6cC9GWjgrd3lFOWFWQU5X?=
 =?utf-8?B?SHlBODZ0UmV2Z0sxVkltMCtWYXZOOGlJdGF0eEJhdmltU3VpZDRrZWt1bVpk?=
 =?utf-8?B?eVBVK0JSOWF5akQyWDRuSFJ3QnBlK0ZsNmhxY2liU3hJRmxmbFVKSFVSRDdX?=
 =?utf-8?B?eW11M2M4RkgybStycmxxMS9rUFhNVDJiVmQwVE90VlVyZEkrS2FZQkhKY0k5?=
 =?utf-8?B?dlAyWjlhQVhhYndTY1B6Ky9qdDlnQTV2bGNOLzJrUGRaUlZhNzRhd014UjZW?=
 =?utf-8?B?cHpoMzg1andiLzFDMUJ5UUNnRk1SZ2JLR0RSVlFlVjNRbDRGSGF0bmJ4ZmRF?=
 =?utf-8?B?a2VvaTRKQmt4YkhRcEFPRzh2bGZidWt1cElqcEthdnR1b3NGdTBoQ3BhRml1?=
 =?utf-8?B?UEd1V2JWUzQ2ZlRteThKdVkza3o1cXRQdlZxRTRLd1JMK2JCUkp4aDY5SUZH?=
 =?utf-8?B?cVdobERsVWJnWWJ2S3EyRm8zQWFEdGh4dWtUNEZ6SlBIWVg2b3dUUU04K3Bq?=
 =?utf-8?B?WHdzTlFRL1E4UTFmd3ExelFoelVYTldTTFdCb0Nhc3craGdzaytUT2wvY3dj?=
 =?utf-8?B?c25ybkZaaDhnR1g1alFMK1lpSlVQaWdYUWtsekU4c200S3JaaE5tYjBTVml4?=
 =?utf-8?B?ZDRWYkZjQkl3TmFHcUVWMTJUZk84SkxCWENpbDczQ1doOVUxc0NQbzBQRmxj?=
 =?utf-8?B?VG9FQ0xiWFdyS0Q2MThlWExOUXQvSUFLZFN2SkJPcUlvc2lheVN4MkpicGJS?=
 =?utf-8?B?SW9lMXYvVk01LzdTT1hQQjFNREMrNlZpQlVkTmp0QW9rMG5aZzd5TkZreUVR?=
 =?utf-8?B?NndrcDQ3RHh1Yk1JcXV2VWJkcVZzdHh4cGJ3RzMwcUlpZVpFM0ppc2QzTU5k?=
 =?utf-8?B?cTNiMnhRM29nMHM1UytZREZLMDFwSWpBNnhQRUZQUFZlZ25RdEFBa0lkNW5p?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0L2TgwAHgybs/Y/UFHbw1j0VIjPpr1/n4WJ5cUXH93go5Z7BOdMS+/G2kcKMQaAzj5nnTtMXs0Qq4XjZKP+2ek83l+/feuHicUFIwhoT8ngGVQfbUk/K9E7nsf3DPyhOFG8LB9d6BKfkQ9quzr5TRjJLrvLAnGe7IjIVPbgh6sAmfBD/TNWipjrXz55JHxYtdxq42qbqdghh/yDF1W4k/qwF4yD1zgXJBnXswrAnHmKeHmVz8fXbQs2QOaSGopas+cnbOvPGOssiivl5ngM4IzHn+rdS1oAw5GkXJBNmFkwlZtmFX7/b/AUgZh6dDFGBme1F9JBzCMVZNqT4kdgHS/bPYA5PFjm4EqicdM1pxeeJreVK5vEWbdc7FvA32hH+zLf1/e52IXSOTJazcJhlxW0gcC+eyFLL/9aZKgxvntcAgBLwIZ8PYBFygX3tu0gY7E0OnlsCaXX3m/Hu9BKanUEBJ65fo2zI+jvNfLDThzxfnqa1dv0Vy8NB+ayRyolcEollmrsh7Mauoxe9ShzUxBM9T/VTauT12LDBzT4utwBfDgpA4lWgJKaciP49EQZNoYyzWD49v5Zvvn6F3gmyv9riT7ZKnPnuuF8yCv8r8S1e1xSTkRgY02PEIKw3GaOiOpmGny5vP4ykVCFMacPzUfjuhmVcD/v0eTSKpRwGOVswqSCwOsMwzI6ZIy+DZbrEH8KcYwES2avm8sG+esbLGTUycsq65ieM2XhUVupuDwf1i/pYaWHqec1xQkSnot6MYtrh7LQ9r9StIZF5ndY2JbLdS1PbeRi/hDC501nD2Dwb4BXwNn7m0jGWDsUpDM7vqTS3uhZbCwYwYm/6WeO9kKeYTEK8OXUqEni9cJDML75nACDlTdIowydfvnmFvbNVfYNnNkAQXRN4xJ0uV8mrPA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66dcb6f-8f0b-4464-68b2-08db57b028d9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:57:11.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dzqf9NEvvBGi5iI4hfz991/BDahs+DoOgyNnlu8ZeSlIRhAlRWMvl6iVkU+ihnftA8ubIZy4uHn3V+E1vQMBDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: Rtr1LnFISVkvoALC5cIXo2bb-HdjRorr
X-Proofpoint-ORIG-GUID: Rtr1LnFISVkvoALC5cIXo2bb-HdjRorr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the functions have changed the limits, update the testing of
the maple tree to test these new settings.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 638 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 633 insertions(+), 5 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index d295fdee2fae..9939be34e516 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1322,6 +1322,7 @@ static noinline void __init check_root_expand(struct maple_tree *mt)
 	mas_lock(&mas);
 	mas_set(&mas, 3);
 	ptr = mas_walk(&mas);
+	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, ptr != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
@@ -1391,7 +1392,7 @@ static noinline void __init check_root_expand(struct maple_tree *mt)
 	mas_store_gfp(&mas, ptr, GFP_KERNEL);
 	ptr = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, ptr != NULL);
-	MT_BUG_ON(mt, (mas.index != 1) && (mas.last != ULONG_MAX));
+	MT_BUG_ON(mt, (mas.index != ULONG_MAX) && (mas.last != ULONG_MAX));
 
 	mas_set(&mas, 1);
 	ptr = mas_prev(&mas, 0);
@@ -1800,7 +1801,6 @@ static noinline void __init check_iteration(struct maple_tree *mt)
 			mas.index = 760;
 			mas.last = 765;
 			mas_store(&mas, val);
-			mas_next(&mas, ULONG_MAX);
 		}
 		i++;
 	}
@@ -2011,7 +2011,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 
 	val = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, val != NULL);
-	MT_BUG_ON(mt, mas.index != ULONG_MAX);
+	MT_BUG_ON(mt, mas.index != 0x7d6);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
 
 	val = mas_prev(&mas, 0);
@@ -2035,7 +2035,8 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 	val = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, val != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
-	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.last != 5);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
 
 	mas.index = 0;
 	mas.last = 5;
@@ -2047,7 +2048,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 	val = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, val != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
-	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.last != 9);
 	mas_unlock(&mas);
 
 	mtree_destroy(mt);
@@ -2750,6 +2751,629 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
 	mt_set_non_kernel(0);
 }
 
+/*
+ * Check MAS_START, MAS_PAUSE, active (implied), and MAS_NONE transitions.
+ *
+ * The table below shows the single entry tree (0-0 pointer) and normal tree
+ * with nodes.
+ *
+ * Function	ENTRY	Start		Result		index & last
+ *     ┬          ┬       ┬               ┬                ┬
+ *     │          │       │               │                └─ the final range
+ *     │          │       │               └─ The node value after execution
+ *     │          │       └─ The node value before execution
+ *     │          └─ If the entry exists or does not exists (DNE)
+ *     └─ The function name
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_next()
+ *  - after last
+ *			Single entry tree at 0-0
+ *			------------------------
+ *		DNE	MAS_START	MAS_NONE	1 - oo
+ *		DNE	MAS_PAUSE	MAS_NONE	1 - oo
+ *		DNE	MAS_ROOT	MAS_NONE	1 - oo
+ *			when index = 0
+ *		DNE	MAS_NONE	MAS_ROOT	0
+ *			when index > 0
+ *		DNE	MAS_NONE	MAS_NONE	1 - oo
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		set to last range
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		set to last range
+ *		exists	MAS_NONE	active		range
+ *		exists	active		active		range
+ *		DNE	active		active		set to last range
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_prev()
+ * - before index
+ *			Single entry tree at 0-0
+ *			------------------------
+ *				if index > 0
+ *		exists	MAS_START	MAS_ROOT	0
+ *		exists	MAS_PAUSE	MAS_ROOT	0
+ *		exists	MAS_NONE	MAS_ROOT	0
+ *
+ *				if index == 0
+ *		DNE	MAS_START	MAS_NONE	0
+ *		DNE	MAS_PAUSE	MAS_NONE	0
+ *		DNE	MAS_NONE	MAS_NONE	0
+ *		DNE	MAS_ROOT	MAS_NONE	0
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		set to min
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		set to min
+ *		exists	MAS_NONE	active		range
+ *		DNE	MAS_NONE	MAS_NONE	set to min
+ *		any	MAS_ROOT	MAS_NONE	0
+ *		exists	active		active		range
+ *		DNE	active		active		last range
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_find()
+ *  - at index or next
+ *			Single entry tree at 0-0
+ *			------------------------
+ *				if index >  0
+ *		DNE	MAS_START	MAS_NONE	0
+ *		DNE	MAS_PAUSE	MAS_NONE	0
+ *		DNE	MAS_ROOT	MAS_NONE	0
+ *		DNE	MAS_NONE	MAS_NONE	0
+ *				if index ==  0
+ *		exists	MAS_START	MAS_ROOT	0
+ *		exists	MAS_PAUSE	MAS_ROOT	0
+ *		exists	MAS_NONE	MAS_ROOT	0
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		set to max
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		set to max
+ *		exists	MAS_NONE	active		range
+ *		exists	active		active		range
+ *		DNE	active		active		last range (max < last)
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_find_rev()
+ *  - at index or before
+ *			Single entry tree at 0-0
+ *			------------------------
+ *				if index >  0
+ *		exists	MAS_START	MAS_ROOT	0
+ *		exists	MAS_PAUSE	MAS_ROOT	0
+ *		exists	MAS_NONE	MAS_ROOT	0
+ *				if index ==  0
+ *		DNE	MAS_START	MAS_NONE	0
+ *		DNE	MAS_PAUSE	MAS_NONE	0
+ *		DNE	MAS_NONE	MAS_NONE	0
+ *		DNE	MAS_ROOT	MAS_NONE	0
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		set to min
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		set to min
+ *		exists	MAS_NONE	active		range
+ *		exists	active		active		range
+ *		DNE	active		active		last range (min > index)
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_walk()
+ * - Look up index
+ *			Single entry tree at 0-0
+ *			------------------------
+ *				if index >  0
+ *		DNE	MAS_START	MAS_ROOT	1 - oo
+ *		DNE	MAS_PAUSE	MAS_ROOT	1 - oo
+ *		DNE	MAS_NONE	MAS_ROOT	1 - oo
+ *		DNE	MAS_ROOT	MAS_ROOT	1 - oo
+ *				if index ==  0
+ *		exists	MAS_START	MAS_ROOT	0
+ *		exists	MAS_PAUSE	MAS_ROOT	0
+ *		exists	MAS_NONE	MAS_ROOT	0
+ *		exists	MAS_ROOT	MAS_ROOT	0
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		range of NULL
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		range of NULL
+ *		exists	MAS_NONE	active		range
+ *		DNE	MAS_NONE	active		range of NULL
+ *		exists	active		active		range
+ *		DNE	active		active		range of NULL
+ */
+
+#define mas_active(x)		(((x).node != MAS_ROOT) && \
+				 ((x).node != MAS_START) && \
+				 ((x).node != MAS_PAUSE) && \
+				 ((x).node != MAS_NONE))
+static noinline void __init check_state_handling(struct maple_tree *mt)
+{
+	MA_STATE(mas, mt, 0, 0);
+	void *entry, *ptr = (void *) 0x1234500;
+	void *ptr2 = &ptr;
+	void *ptr3 = &ptr2;
+
+	/* Check MAS_ROOT First */
+	mtree_store_range(mt, 0, 0, ptr, GFP_KERNEL);
+
+	mas_lock(&mas);
+	/* prev: Start -> none */
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* prev: Start -> root */
+	mas_set(&mas, 10);
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* prev: pause -> root */
+	mas_set(&mas, 10);
+	mas_pause(&mas);
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* next: start -> none */
+	mas_set(&mas, 0);
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* next: start -> none */
+	mas_set(&mas, 10);
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* find: start -> root */
+	mas_set(&mas, 0);
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* find: root -> none */
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* find: none -> none */
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* find: start -> none */
+	mas_set(&mas, 10);
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* find_rev: none -> root */
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* find_rev: start -> root */
+	mas_set(&mas, 0);
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* find_rev: root -> none */
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* find_rev: none -> none */
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* find_rev: start -> root */
+	mas_set(&mas, 10);
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* walk: start -> none */
+	mas_set(&mas, 10);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* walk: pause -> none*/
+	mas_set(&mas, 10);
+	mas_pause(&mas);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* walk: none -> none */
+	mas.index = mas.last = 10;
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* walk: none -> none */
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* walk: start -> root */
+	mas_set(&mas, 0);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* walk: pause -> root */
+	mas_set(&mas, 0);
+	mas_pause(&mas);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* walk: none -> root */
+	mas.node = MAS_NONE;
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* walk: root -> root */
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* walk: root -> none */
+	mas_set(&mas, 10);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* walk: none -> root */
+	mas.index = mas.last = 0;
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	mas_unlock(&mas);
+
+	/* Check when there is an actual node */
+	mtree_store_range(mt, 0, 0, NULL, GFP_KERNEL);
+	mtree_store_range(mt, 0x1000, 0x1500, ptr, GFP_KERNEL);
+	mtree_store_range(mt, 0x2000, 0x2500, ptr2, GFP_KERNEL);
+	mtree_store_range(mt, 0x3000, 0x3500, ptr3, GFP_KERNEL);
+
+	mas_lock(&mas);
+
+	/* next: start ->active */
+	mas_set(&mas, 0);
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next: pause ->active */
+	mas_set(&mas, 0);
+	mas_pause(&mas);
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next: none ->active */
+	mas.index = mas.last = 0;
+	mas.offset = 0;
+	mas.node = MAS_NONE;
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next:active ->active */
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr2);
+	MT_BUG_ON(mt, mas.index != 0x2000);
+	MT_BUG_ON(mt, mas.last != 0x2500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next:active -> active out of range*/
+	entry = mas_next(&mas, 0x2999);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x2501);
+	MT_BUG_ON(mt, mas.last != 0x2fff);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* Continue after out of range*/
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr3);
+	MT_BUG_ON(mt, mas.index != 0x3000);
+	MT_BUG_ON(mt, mas.last != 0x3500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next:active -> active out of range*/
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x3501);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next: none -> active, skip value at location */
+	mas_set(&mas, 0);
+	entry = mas_next(&mas, ULONG_MAX);
+	mas.node = MAS_NONE;
+	mas.offset = 0;
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr2);
+	MT_BUG_ON(mt, mas.index != 0x2000);
+	MT_BUG_ON(mt, mas.last != 0x2500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev:active ->active */
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev:active -> active out of range*/
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev: pause ->active */
+	mas_set(&mas, 0x3600);
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr3);
+	mas_pause(&mas);
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr2);
+	MT_BUG_ON(mt, mas.index != 0x2000);
+	MT_BUG_ON(mt, mas.last != 0x2500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev:active -> active out of range*/
+	entry = mas_prev(&mas, 0x1600);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1501);
+	MT_BUG_ON(mt, mas.last != 0x1FFF);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev: active ->active, continue*/
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find: start ->active */
+	mas_set(&mas, 0);
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find: pause ->active */
+	mas_set(&mas, 0);
+	mas_pause(&mas);
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find: start ->active on value */;
+	mas_set(&mas, 1200);
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find:active ->active */
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr2);
+	MT_BUG_ON(mt, mas.index != 0x2000);
+	MT_BUG_ON(mt, mas.last != 0x2500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+
+	/* find:active -> active (NULL)*/
+	entry = mas_find(&mas, 0x2700);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x2501);
+	MT_BUG_ON(mt, mas.last != 0x2FFF);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find: none ->active */
+	entry = mas_find(&mas, 0x5000);
+	MT_BUG_ON(mt, entry != ptr3);
+	MT_BUG_ON(mt, mas.index != 0x3000);
+	MT_BUG_ON(mt, mas.last != 0x3500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find:active -> active (NULL) end*/
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x3501);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find_rev: active (END) ->active */
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr3);
+	MT_BUG_ON(mt, mas.index != 0x3000);
+	MT_BUG_ON(mt, mas.last != 0x3500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find_rev:active ->active */
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr2);
+	MT_BUG_ON(mt, mas.index != 0x2000);
+	MT_BUG_ON(mt, mas.last != 0x2500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find_rev: pause ->active */
+	mas_pause(&mas);
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find_rev:active -> active */
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find_rev: start ->active */
+	mas_set(&mas, 0x1200);
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk start ->active */
+	mas_set(&mas, 0x1200);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk start ->active */
+	mas_set(&mas, 0x1600);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1501);
+	MT_BUG_ON(mt, mas.last != 0x1fff);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk pause ->active */
+	mas_set(&mas, 0x1200);
+	mas_pause(&mas);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk pause -> active */
+	mas_set(&mas, 0x1600);
+	mas_pause(&mas);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1501);
+	MT_BUG_ON(mt, mas.last != 0x1fff);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk none -> active */
+	mas_set(&mas, 0x1200);
+	mas.node = MAS_NONE;
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk none -> active */
+	mas_set(&mas, 0x1600);
+	mas.node = MAS_NONE;
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1501);
+	MT_BUG_ON(mt, mas.last != 0x1fff);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk active -> active */
+	mas.index = 0x1200;
+	mas.last = 0x1200;
+	mas.offset = 0;
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk active -> active */
+	mas.index = 0x1600;
+	mas.last = 0x1600;
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1501);
+	MT_BUG_ON(mt, mas.last != 0x1fff);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	mas_unlock(&mas);
+}
+
 static DEFINE_MTREE(tree);
 static int __init maple_tree_seed(void)
 {
@@ -3011,6 +3635,10 @@ static int __init maple_tree_seed(void)
 	mtree_destroy(&tree);
 
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_state_handling(&tree);
+	mtree_destroy(&tree);
+
 #if defined(BENCH)
 skip:
 #endif
-- 
2.39.2

