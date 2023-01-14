Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4981066A834
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjANB0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjANB0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:26:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34649FF5;
        Fri, 13 Jan 2023 17:26:35 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DNdxq4007591;
        Sat, 14 Jan 2023 01:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=WuEyVEzKPY1dz///J0HkhbPrC46V8MUbVfgSoSmK5oM=;
 b=kJOp4rWFXdfjw2opCLulAHK4OrATRWhny8qxMSSfg7hB5Wtr/EZq+R+qpn/bR0ov0Ymg
 BWwh8Mg2h7DPITnoCF7ijLRmdzWV7hz9UV2dwsWDaYRLI1fgxDVC8DQl35UlkcHbNvIg
 ggH0nXWJWsuMTrMjHt5pBH4W4yfkhQssnEKc4DRSuXplokAWgQ+GGydYmN67YLUbEvdA
 3Hdrp3uCsL9eS4fFgfYqF7XaGhlWlbRwxlafVB/5EJei+cySeuY87fI+7mUZ047FRhI8
 KZeVyWXDDMdCIJJU3Qlkw6D6P32HSbz67UOTBpbjm3oLP6WfBqpe0kWEezC+Ztvvwkqn bQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0scp1tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 01:26:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30E1J3ff002679;
        Sat, 14 Jan 2023 01:26:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n3jm983nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 01:26:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOe/YyJtVrMxMznICVjv+d5Pa9MqDPpAo5cvJ15AFUUw3HRkeY4Hk/bh2z3/xdbALKTCRVXAPYx1FnGdo69WRwtifFTTknpJ8ucLWCmWG5C92JSuMtQaKvue/sWMeCsbj5bnSWMgtY8m3ti0BpuQnZV+TFLX1x5aE6ZamnwdAPf8Livkps/ftfnWg5a9uSeSLsHK21K2I863rBlxmc7i5t9sazVtWqC2WgAp1GvU4YmdjZLwXpzrtdzyzAZaZ7Qb3KtiAEdMnproLlUYz5DAOZ5bAi2hiw115l+0eo/s9kXhyskNk+L3atCDUvIRcMBKCmf5o0ybK/Od2driiGcAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuEyVEzKPY1dz///J0HkhbPrC46V8MUbVfgSoSmK5oM=;
 b=aWwrCypQCSK0l4zpfpkNvk3J6C+pQIcj339lrceuKwGdjTrllLLFdmtnDP7F7sYGdNeBA/u03eGmuznnxwqgMT2yu0X1Ud/BtxmkH/01Okg1qlQyXb9zABtH/tHYC4NcaRXnV2aFfNYwbiFg9BnyOZ1zB1f7M1xp/SoGCT1MJBtToYYL+7BdZaQFyHrVNZmSD0pthygkr8hBaCBBPgESheEuWg5XC2h6k5kVDqZQpzWatB6r96HD1DahTTEgZsuyhAewUVL+LH+ABDUhUl2fQxNZ49KRta/3UtmKyHDDDwn4oRCpuWTlrKc/dJmQj2VetM4ScUEpM8xH0ppo7KEHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuEyVEzKPY1dz///J0HkhbPrC46V8MUbVfgSoSmK5oM=;
 b=HOCq37H2xul37wsnyqP1P0OO3aVQdxR4hclFs5diAzIQTIi1EDraFGmtPgjP0BVQfT7b/3ZP72jGV95vW+5UjTlhwQmrKDFfoS/cFpEP7Fn+0eFaTuuiFpEoZVwH+8rocI7evG6/BRRiOh2aHj4fvaBhduFDNP79zTUTYhV8Ptc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB4862.namprd10.prod.outlook.com (2603:10b6:5:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Sat, 14 Jan
 2023 01:26:27 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Sat, 14 Jan 2023
 01:26:27 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: uapi: Replace 0-length array with flexible array
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tu0tucsm.fsf@ca-mkp.ca.oracle.com>
References: <20230105233042.never.913-kees@kernel.org>
Date:   Fri, 13 Jan 2023 20:26:24 -0500
In-Reply-To: <20230105233042.never.913-kees@kernel.org> (Kees Cook's message
        of "Thu, 5 Jan 2023 15:30:46 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB4862:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed5f5bf-fc35-4ce6-7354-08daf5ce5b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGqFq9MPq3jnkuEtKO3Qjtk7bx2PBf+Tl0e/zanz4sUPuKnYL83dF1ljfnQPA4eUp+pABgMR3dOaipBZvBrzPK1bc10Iu+giIJJLSa6hELev7cJmFK7rkpuJPgc30kdFL5Q8ez71lL7YLESYYcFjvcBAHojdvtjNlDTDw8gaDBKtKGl8MJzsJTHKOOExCfCvwOuDy4n3saIAImxBm6m+waJtcdXCUHWVC4KTTvZW12GdtmrIbA4H5D64glrMySS35WUz+OjgY7Ra34VWM/bTFqM7I7SOOUMVRPtR9L4TReVnjUVKanbiNN195kljrswaqyaAXusYwoOXUcpKzF21Rk75gsbAvoLNQAbia05+tPXGazj8cb7OV+HqqdFOm0BQN3qAFx/Mjco8d7+OwaYFCc2/5BIiuBT4BycU2xl1vPlwiBjfzWi4iCSaN+64kHHfE2qVz2mJLVDFTD1O4cm0whjE9M2RKiEIu0NXO1qyDFTl3M26IeTc20/o9ruUsSYU0v+UGf53hHxrS1qlAIzsy1IQ9rKkpzDTlVpbiQQI/V/zFrBNF5RPmcOZ94k8/PuG9ku/AGeadnPQfJ0TP2rvtaMFWQmCZc387FYw+bTuw2I8tsuRYie8mw9ybGPrgN9Dr5pvD3+Z85T9rceDvDC9EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(8936002)(86362001)(6486002)(558084003)(5660300002)(4326008)(36916002)(83380400001)(6506007)(26005)(478600001)(186003)(6512007)(6666004)(38100700002)(6916009)(66556008)(8676002)(66476007)(66946007)(41300700001)(316002)(2906002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nqK2wpEjUqcfxYLyEqN70AetwopZkYudjjs4EDEl77VyHkcOoBlZkhKgL3bD?=
 =?us-ascii?Q?cdhT1Brr9ZGxFRPhm2fj8iZ+7A9X3HQ4DwQQevZribsSFQNeWzhHtmkr82fm?=
 =?us-ascii?Q?QsAvyt33vDDORD+1r06IrnWK7vDKa08Je4h53wQPwQ+QHpgQ4H5t3u9M8CQA?=
 =?us-ascii?Q?43DVT8pfg+m3xF5hH/N6HZePeL0210opCD637tykdV2gzqTVAEjOcvz9sq88?=
 =?us-ascii?Q?lpiuFElI5mbWB8nlMB9VoOdndx9T9vXcC46GGwv67FHG0uFztweUTSMhX1So?=
 =?us-ascii?Q?nVj0+4H9fuH69JyInU3PgTUnHtQo3n1AQeDJYm/wUbiF+sI3LqmWSA9lzzDw?=
 =?us-ascii?Q?KN/g7swpl7trJnh9q9LJb6Nq6Fmh6RXK749j6+LyHsWM1DJqc4zxhhssoXGk?=
 =?us-ascii?Q?Q7MKQ1YJSPQWLoYHYqU93HLy35QbGahOqNOJezS+5rjXeF11BK3O1RLg9lgq?=
 =?us-ascii?Q?xyTdNLQCaT1nsfZDNTgw+RA+fsa1lzRJjMdmoDfyPHal3RTNfNJE+rxl4khX?=
 =?us-ascii?Q?s9W2u46zTixIBcnn7t0bG1nTMhtbOLnhSzx1a98/UHpVUeM6CZHr3EuI4CuK?=
 =?us-ascii?Q?wQG5aCscmVSAmfC9KNTeReIks0eMb+owy8XMbJEMHx7aexsAMNdK2gtlIRHG?=
 =?us-ascii?Q?Z2ejmT6NhFcA+xQjZ9XMK2g4u+jbIjCT/XdVVWvxa7J4jvU7zrcdds7YEDib?=
 =?us-ascii?Q?p1hLpHxiN75epG9Yls0LuuX2xWebMCu/ktSJrvYOEv2Nb17f1qUy7wlLljT3?=
 =?us-ascii?Q?G/Q5ksTLLyxJ8pzgFGoUH13ginn3NLjdpi04zL/zL/tzqosuTlizh1qG1ZsM?=
 =?us-ascii?Q?P+nkv9aXgdHmLmmihHxcTnItLPxYnfZljka5+m/hDSVCsBhnIwo58zdxg0mY?=
 =?us-ascii?Q?gWzeDdym13Gta+1xnqbHKPqYOgRXJ+pVxzbvj9iF+lKv+4LgEbszA4+7Gl45?=
 =?us-ascii?Q?NrPZbihk4020O/1RQKPYIsem+81QwJ07IRgCzKMMY3GLX3KUPASei3WWTj9P?=
 =?us-ascii?Q?iRwcM00OZLe5E+NpR6Nfu6OTgtJ+tt21r9MTYDuEDZoFhBB0P55g8PAaKF2q?=
 =?us-ascii?Q?Kbz10SEvJYqdg3xjsoZfZVYvCUnnfCbqsjFsgJu/A6SMP5UZyZAsXWFjPdCk?=
 =?us-ascii?Q?2uNyM5A97pxiVbATJXWCDvrfN4HD+5VBJAfCavgiqoEvK6jDyPGmyOrl9fsz?=
 =?us-ascii?Q?WJI6fXV9kDodj2VPClELgZUSmylZ3R/lf4OIQo+K8cmE4X9i6SP4HvIljl9t?=
 =?us-ascii?Q?TLMkLlb2QzLoaoUw+vdv0Kegiilwk0uWnVfv4dA0KvupVCqPyOHqmADTjEDR?=
 =?us-ascii?Q?ZuAI5uqU47mJXOn5GEjXRqNkxLfz0q84s/n/71yHIbtaScQXMia4tr15zSIC?=
 =?us-ascii?Q?rMR/3rQmD1HV4MULOr+pyQlRmibpM+l94yaGD702kk2SumqeEE9MYQ6SWK83?=
 =?us-ascii?Q?xnJTFYJQNI3vYlmTIpkcKAOr9sta/eAoU+zD8Yu2KupFxWoAX4peWoHVlPOv?=
 =?us-ascii?Q?Sxrr1RFaLEWqEXRR7LjuKX4if4zS1ENjL+K0JyjjN4w0ygB911nMUQlIzkpx?=
 =?us-ascii?Q?EW8I3RzTWVAuHQbnhABQqX3IyfYYfejvGlLngN31OgHH3P7EmhIC7HV4MORW?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cXodfAbslrKeKyY7+Fl6z9UnB4ZU5gkwhUeeHon+i7k79Ib51vGVeRMH1R1I5cNRCMfiYqpKXhw9GkWK1P93XdAjJuVUVLRNR1OqAaRjsCd2xaGybSjrJ7buvRx8qaPr3ntmCPCp1JaDBndv0PQE2PKfuTd/N4NU4duFfCVDpFlfr9FukIGgFrZbAFg27MNshuJtrTEi7TfV+RtCNA/RMPUKdbTb0vZqd0QS6IClhoOUt/WHbmoT+K/eLZgsxsKPdl0+T23mlPOoOO5ynAgLRclrWYINvrMv+hMZXXn+g6zeuBPWA0jqcbycctifRHwjLm7Y3ZGmCSZcBNz+k4XhNnNIS9m0IraUXief8jwx6jwhTjFX+bOy+7WJX4mCAGV8cj8Ipbrb1TQ+sDI3Toj7zOzsyF4k63oYUzM6Ck8mUoo2DDJBLMC+cuELjUmsbNX46eWY9VNSsklHafMqoKiY0R59kwEIfIVr37TlKlm10r9BUjaE/EbuAB3Ffp9F6TzaRnABix9EtaqJSmn7/tmPAeLUXUufA9cmIMUGAC08JJqAPvlC7M+rt9WwSSXYSxSNw53ETDr9b8DhFFWy1E2S3O/1TFGNTg9Q9GYwCeECYaf/IZj6wpNArqGkab/YcN/OYh7qO76b1o3JywJyY0fAXDHddjo9rtzjnNarxpHFx+AG7Jx8YKOccae7F5fNNU7zudSlRxw14VBvrygAarImn7lN+VJlrFJK/TjhCT1/VWDp9zuRZ7XD1+MHydmxNvQLnRNvdmMM7+m3zeDYdH1gh1KWvihZujsXE0xSZgYqqA0h2y/8gmQcv/u9Et5fEbDAT6ysKZhTXspC/EIf1yLE2HzOeg9cZeO+N0Px2A5G0x4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed5f5bf-fc35-4ce6-7354-08daf5ce5b71
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2023 01:26:27.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEcnfKCsDBZN2J3wdGtTGhL0g/dZ+z5GKB1I+AnKcJ35rBTi7bPzc1e77eX12MiEdxhJE3i2jFCsb3KtTDxqzmX2pNQdDaT7yESodpapwkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_12,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=755 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301140007
X-Proofpoint-GUID: XowjRDbQDoMxcIziej7MfC9iL_CLqCy3
X-Proofpoint-ORIG-GUID: XowjRDbQDoMxcIziej7MfC9iL_CLqCy3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> Zero-length arrays are deprecated[1]. Replace struct
> fc_bsg_host_vendor_reply's "vendor_rsp" 0-length array with a flexible
> array. Detected with GCC 13, using -fstrict-flex-arrays=3:

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
