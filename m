Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1833374B2E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGGOQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGOQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:16:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03AEE72;
        Fri,  7 Jul 2023 07:16:33 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367Cx8X2028521;
        Fri, 7 Jul 2023 14:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=b3MMC7Ndb37LHEFW5pD0+EQ3vfUM6EQvfjBVMUnk2EM=;
 b=Zbxp51JrBxwkOqxZEmhjd+Rid7MtyVVYwxcreHKRX2CyXvDIfupLdKeRUn1Jdyk6utLt
 1K5KcKskQDTmLVw+8dDh4z1ms2z30DjhSjyr1EENqDD+sUWLmmWAb6SyucXsUuMLM9D2
 TI+8Mv3TeLUBoI5DILQW6O/IwgxbnGuDGbTmmIpUzpVJoBZrVDjKr+zFjKP7rr2kiNWK
 ra6aY/hNLhgDW4/bFklaWGHJcFPc6TY3jjvAohEyxiXVu9hX7nh9cuBKrUfOx3ip57iJ
 RR8cP0twP1zaRx5YP6mpKxEMHdNhBe+FD9Ui4mZBayWSgO05na+7Ilhp4eMJsPfK7VZX Zg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpjaq0903-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 14:16:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367DqwKB010145;
        Fri, 7 Jul 2023 14:16:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8fvvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 14:16:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fyud7f4krcKbw3U+FhkhpZLB4QQ4JdVN/I86lJMkYpMDDwDge1Ar4KO1dNBIiFL2h2gsEfNTqJFnDy7M3hoahF0J28TYm2TcyBAIgtghbB8rcoeWiaWNecFUahAaKMUGRsl1Lwx5RJWR37zyX54MzKbR71nfYmNquLUNikx3NA5Qp21ouXWzBJO6H+ltra8TDZZ7ZZW0MmB6XnN9cNeIySN5n+u+S5hRtmdAovj8l9VwKMR/yMiEK+UOBGEuAmwcpzQS49vt0TWvnLVGNsc0ditRXtUVIbMEs666A8q7PtxrADzopgTi84vEdbcQlMk6lbBQX8uzXMXSq6L3gn8nIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3MMC7Ndb37LHEFW5pD0+EQ3vfUM6EQvfjBVMUnk2EM=;
 b=KoipdWBc4Ik5YzYh50ynRPcvBlNByQUgn3La7IEL+TaXajjR3zLKTRZlSuyyCeSRpEdgnjCLdqAWDXrMgw7FRDMD4xAS/m++yUB8MKn+20wnzWzkcppIkaJIHEBR7/Ue+pan+ONhNk2c324iVT9kxyL0NT5Uhw4Fv/sV9o1+PmSoERwoDEx/OZkF4Z9vFtDayDEDsNWg0PoDi/+VOmjnP0MkZwz8XLlUReSQV3rk1HUbRB1dKdEKgG2buBh1vNvR02jcukVcqSZj9bmpZVFpA0sEj7orQvll35tzED6NgKfnbxP5GorcLI4lrJ3GR9ybBOifgyjlVOz37DIbAeNJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3MMC7Ndb37LHEFW5pD0+EQ3vfUM6EQvfjBVMUnk2EM=;
 b=PltdWNXT91YP/OIoxydgtu1zbn5L7JHQC6Fyk/V3JGsLX4Y/dZBEI0DUG7jcFCnh2XZaQzJ6AAWPW42fZyHqdkaMchCgO5tCwPTmAsGs7ZwfwWGihzM04qszhSn8pPhiO1oWLzgwMpuogC16olf0jNRqfI2XuHGscTIbKadNgf8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB7348.namprd10.prod.outlook.com (2603:10b6:8:eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 14:16:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 14:16:04 +0000
Date:   Fri, 7 Jul 2023 10:16:00 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, david@fries.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, zbr@ioremap.net,
        brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 6/6] connector/cn_proc: Selftest for proc connector
Message-ID: <20230707141600.qikwqtnkgq4gtkcu@revolver>
References: <20230704001136.2301645-1-anjali.k.kulkarni@oracle.com>
 <20230704001136.2301645-7-anjali.k.kulkarni@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704001136.2301645-7-anjali.k.kulkarni@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BL0PR02CA0115.namprd02.prod.outlook.com
 (2603:10b6:208:35::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7d9501-63cb-4267-df56-08db7ef4b31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/qR6sTF9nyuH5/Bkn7Fmu3t30bfnVN9UhFw3fRNZnIh6aG5D8H2SRQjqp5fxyC5+1aD4NpEme8/p099K+/HsaSZYh5o+l2bPYxPla8BBn8F25QSUO/7J4UAFcSCSqfWqi7gmwKPpyZIMFyObxmOdvmCGEVw4ZwtKCpJrn3haqUxtC+aQf3YafPISHTAmdSwxqonJqifxl+h25UZV5A6yOnw8RCdF4rXbkUmJxrt7ZNNyr4KuL1zapXTPt8iXs+j7JuoG8f/fqHNQLewsgJNJqMhbP2kzXWugI7mdd+eV5ki1oDTVpm5d3YVTrvWniSKlz8Autxq0tGrWu2RXy4MwnPInNT1w/vQMB3NkrN7NrBbgcBzOI2E0uD+KEy4V8TaSHiiI33Z2lnjvtq06JmpG4j4R0nP1CR9jSuZIxqLeji5E5xxWeyTxxb0wOVbshY4MB5GcVWW92eV2+t8NgqahX854Q3wjH7KQeo11hXqAlqWNYtOar6ycO4luFO2ejplVn9JdpGjyRdEsfkfBv1aK4Dg6FMtM3c2woKGJJ6UtZoy0wGE3oUDqFoj0u1W9JBD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(66556008)(41300700001)(9686003)(6512007)(478600001)(33716001)(86362001)(38100700002)(6486002)(66476007)(6666004)(83380400001)(316002)(66946007)(6636002)(4326008)(2906002)(6862004)(8936002)(5660300002)(8676002)(186003)(7416002)(26005)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZKFCtw8VL4jjmjeIwjLODaQAQNsRzKTa7IJJhb3n+CSwNe6pWOlrma71xgr3?=
 =?us-ascii?Q?lPXh6l7vUzKvjlsSDqapZHbtNuy9WvRZ1Tl+PPFbQBWMxNPR5HF6gTyzGLSS?=
 =?us-ascii?Q?EI/cP0INKkagdlp352b/xYlo/TSKZaULjW5PcPkEE6spqVLunry1S8NnMiDD?=
 =?us-ascii?Q?C3Uppqy0IOPHeTuGDDwyIPUCpcGd963lkeMy+jLZoQHqO/LWcRV76cHBhjmT?=
 =?us-ascii?Q?kupRSXpY9qk/LHMsuPuUyMu535B97bcMfiK5XNaBMdUQOoXViBIfOc3dkZgf?=
 =?us-ascii?Q?JxgEWPIWk0v5RakrRI/3QQ42O4kb33UOkoGxhJcrF/DJGZNliL+L2AvDAqVZ?=
 =?us-ascii?Q?u9SBbC2ylXQrkTP+/xVIsnuUeES/Uc9f3CBV8bMXuS2+kTY9kKW9+3BQBcsw?=
 =?us-ascii?Q?+/UqCgbiUApHd74ZDl2vi/GOwGVDxwDBA+btxuT6MmncvBG1CMbyCo66weCw?=
 =?us-ascii?Q?oTYuBf4MNxiRPOgPydBUmElEmzbhhuCmBSoI1H+KLlh7FkGFZolEBXd0xE9K?=
 =?us-ascii?Q?OTKZT7qoAN0x01nC2H01Ex3hEpSoxwgBefICbmigTcS/JJuIx0fqhIkrBuac?=
 =?us-ascii?Q?nCneYARztiZATy1cg2Wu3/2KhvRPkxewCOM5CKCI7/Goo4Dk/oalhRtDjXJt?=
 =?us-ascii?Q?wqjyNq7CO7/0xyirNCVZt3oU+Kgp6Gmbk88nKjMI+nPsVpaeP2eW6uulPTrO?=
 =?us-ascii?Q?O1dLcN/LHDM/NuInrc49vhfM6/SQJNNZBHQLYGnz2MpIpL41ouWjjS3kDFk2?=
 =?us-ascii?Q?tMEVgRYGNmJoOIRYLZPJ2RLDWw8+UcYPsFcqk/a75R56764Q/sGvBwOnCZaM?=
 =?us-ascii?Q?yeWK4nE7Hj7c3GRenhibORM/3yJnBzG6Z9gqtzdw7yIKDNjEUWFtsyo+P6ak?=
 =?us-ascii?Q?z/8dW+kd0VbiatLOEoxKanjGkEd0o8ympcFpyS+NaZTA6/0HDb/y8kSUTusV?=
 =?us-ascii?Q?gFrYFGZew/UUgomjXwAaPEEMQW2+gfBmB5JOAScx/pzgWFApp4j5BW+0dFhI?=
 =?us-ascii?Q?+LzhFoENloqJsO/X0hVoVIY1FMipLlxBO3JdLeneNA/dy37N1ObtP0sQytln?=
 =?us-ascii?Q?8IbD+SfZ92/eR4S3Rhmf7fDAKCXYvQ120/nvkATZueQiZ4+EAgkHc2MkTCbD?=
 =?us-ascii?Q?kLrEsfUZboQFMtVSwwPzhQNnk9sGqbmYBtTCea5aBwNR+a0Htwq8Hvlt637T?=
 =?us-ascii?Q?Fdp4pz1rEUqAPTG4op2aIoe2KXv1wDF6uu430jMEumiwgUaSlL9BvB6NjeMP?=
 =?us-ascii?Q?/v36bqoo4kbokgeBu7Ave2/RObmGbynno7kD/MMO1bqNZCHx0O0Sq81pPwA2?=
 =?us-ascii?Q?v7hHvx6lLU39X9QTyh5kmL60BnxUlwON0hEDVDYdzD3iZ8pGUalOiGqVa5QY?=
 =?us-ascii?Q?mJwYrLwyad8mOe6Di0AEr+ogBLkcrK8lMsj58Rdbot5t7WNsDozHnG9O5nsq?=
 =?us-ascii?Q?7A1WLtxNytWZNrFusIS9Wai2HqV9jE4tY8RNbyn75rXqsg7m8UeYJevWwm+y?=
 =?us-ascii?Q?wxKT8qTD1LoKZO+Re2AotuvqOlBK50Yt5T24gcfmJgxCCqQnHSrlSxFPUKP8?=
 =?us-ascii?Q?HhCbUdi2wDpdHLR6gzEabxyIP/o0+7tbfd3acokjv3tT2zYrxo+fnCuXv/y/?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?gdRs3pY47IZLvycW99hdkSPR7vaxM0dhKAUWP3lvBa5Qvmm+zXhhYMOmDXUP?=
 =?us-ascii?Q?1+e0tpPa37OsmxKI25NmdRJVRCbcPDTUNi1gYX8zADyARu89tCqw8Pm52dyh?=
 =?us-ascii?Q?gSh1g3bAheP0oS7lo/zWSDCx/Cu9F3UEXwjLUSBWu1i7cUJR4ilhygUFQkPz?=
 =?us-ascii?Q?uVM+qhsMQaS6P/Wy8utTyGx2DdMUIHfEfK9ucNtd6ZsJ+Uqf+pL9CyCSf+VD?=
 =?us-ascii?Q?/l0hZ7frDWmUZdwN2lYOTi+5g2k0EQOpsRQSBwonOSbmGu681IaXI5L7TBM3?=
 =?us-ascii?Q?nLPZ4jAHZ4GhGtm3gKOmaGBZBE5xLAVSRrozsWYJ45RuerwUAC6QfGLBhE5S?=
 =?us-ascii?Q?gyKXR/NmD6Omyzck6oWUDs5it/Ov9yxgNIiqTIiENmM/lbHbbvnnZ7JeEuWr?=
 =?us-ascii?Q?UW7kMEP+OBZzgeJfUSWPsvFLQrQEQBh3U4NGofePvOqtWy9SOHahLAuM4la2?=
 =?us-ascii?Q?54pbWtcWrekfy3gz9mMNNNEU7bpu+18vKKq2D9EHp8BBbSsf7+45V4Y8GfUm?=
 =?us-ascii?Q?E/hBxg6w+MM60djibxExsnNnY49YJJR0SRFzxLLPq2qUt21nHg9GHZ/Z5MMV?=
 =?us-ascii?Q?7qSBWyTpK5aXeqca+i+fPfoADeVJH71uvuwMOWyANXr49G+FCcwE2T2RjwgA?=
 =?us-ascii?Q?96f18Pn662fDpvCa0tOgMS/apzayYtQNHKFD4zCpDSLVepdv4MbgffthLj/M?=
 =?us-ascii?Q?OSUL4RGp/ymnpv+p6opBhSO6xrYXRD3R9rgtyJMR6/U9my03UYTrSqDm/IG6?=
 =?us-ascii?Q?02S4C5CXUjtx5/dwQskViNWyoOf/4hes3IjJ1qdKMmwz203wEgvDr366Ra+s?=
 =?us-ascii?Q?Eru9FOB3a+R1iZtjuvi7gbLfjv0P2Qs9ShZOdMwy6TzlBsS+1UgOZ+0W8TuH?=
 =?us-ascii?Q?S8EbVCk7q3j4lzN+X+rSANsVsveM/ZN0FX4mmKDrCKpRO0T5d3eDoYwdXF2w?=
 =?us-ascii?Q?SKpIFQUYlbFwFO1G5+Gekrmdu41sGsEFZUgtuNHXZHL/2hnlpmvoeAh5YaJw?=
 =?us-ascii?Q?WkeL/G3VxPXlQdyeojvdk7juJ1gCg+SY1SdeYvwnPjjCh90BlYAp6znzAJVn?=
 =?us-ascii?Q?wRkc6eGbJqFz+vuGdA/ow6kntWwfkC9oHNHQ2+zzMtjAepqcyio=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7d9501-63cb-4267-df56-08db7ef4b31c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 14:16:04.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyTDZWcVC8Bm0+Upcc6ov7U1RPUXvj0AsepdtUtnNYJF9iWWZx3CIkeLMAnhPdqVN1KVJKWJVUTm/xYoWhfIVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070132
X-Proofpoint-GUID: r5NCdpcAfaTE00OG5xB_3ltrKKTDZlln
X-Proofpoint-ORIG-GUID: r5NCdpcAfaTE00OG5xB_3ltrKKTDZlln
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [691231 23:00]:
> Run as ./proc_filter -f to run new filter code. Run without "-f" to run
> usual proc connector code without the new filtering code.
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/connector/Makefile    |   6 +
>  .../testing/selftests/connector/proc_filter.c | 310 ++++++++++++++++++
>  3 files changed, 317 insertions(+)
>  create mode 100644 tools/testing/selftests/connector/Makefile
>  create mode 100644 tools/testing/selftests/connector/proc_filter.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 90a62cf75008..7c9673951f9a 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -7,6 +7,7 @@ TARGETS += breakpoints
>  TARGETS += capabilities
>  TARGETS += cgroup
>  TARGETS += clone3
> +TARGETS += connector
>  TARGETS += core
>  TARGETS += cpufreq
>  TARGETS += cpu-hotplug
> diff --git a/tools/testing/selftests/connector/Makefile b/tools/testing/selftests/connector/Makefile
> new file mode 100644
> index 000000000000..21c9f3a973a0
> --- /dev/null
> +++ b/tools/testing/selftests/connector/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS += -Wall
> +
> +TEST_GEN_PROGS = proc_filter
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
> new file mode 100644
> index 000000000000..4fe8c6763fd8
> --- /dev/null
> +++ b/tools/testing/selftests/connector/proc_filter.c
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <sys/types.h>
> +#include <sys/epoll.h>
> +#include <sys/socket.h>
> +#include <linux/netlink.h>
> +#include <linux/connector.h>
> +#include <linux/cn_proc.h>
> +
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <strings.h>
> +#include <errno.h>
> +#include <signal.h>
> +#include <string.h>
> +
> +#include "../kselftest.h"
> +
> +#define NL_MESSAGE_SIZE (sizeof(struct nlmsghdr) + sizeof(struct cn_msg) + \
> +			 sizeof(struct proc_input))
> +#define NL_MESSAGE_SIZE_NF (sizeof(struct nlmsghdr) + sizeof(struct cn_msg) + \
> +			 sizeof(int))
> +
> +#define MAX_EVENTS 1
> +
> +volatile static int interrupted;
> +static int nl_sock, ret_errno, tcount;
> +static struct epoll_event evn;
> +
> +static int filter;
> +
> +#ifdef ENABLE_PRINTS
> +#define Printf printf
> +#else
> +#define Printf ksft_print_msg
> +#endif
> +
> +int send_message(void *pinp)
> +{
> +	char buff[NL_MESSAGE_SIZE];
> +	struct nlmsghdr *hdr;
> +	struct cn_msg *msg;
> +
> +	hdr = (struct nlmsghdr *)buff;
> +	if (filter)
> +		hdr->nlmsg_len = NL_MESSAGE_SIZE;
> +	else
> +		hdr->nlmsg_len = NL_MESSAGE_SIZE_NF;
> +	hdr->nlmsg_type = NLMSG_DONE;
> +	hdr->nlmsg_flags = 0;
> +	hdr->nlmsg_seq = 0;
> +	hdr->nlmsg_pid = getpid();
> +
> +	msg = (struct cn_msg *)NLMSG_DATA(hdr);
> +	msg->id.idx = CN_IDX_PROC;
> +	msg->id.val = CN_VAL_PROC;
> +	msg->seq = 0;
> +	msg->ack = 0;
> +	msg->flags = 0;
> +
> +	if (filter) {
> +		msg->len = sizeof(struct proc_input);
> +		((struct proc_input *)msg->data)->mcast_op =
> +			((struct proc_input *)pinp)->mcast_op;
> +		((struct proc_input *)msg->data)->event_type =
> +			((struct proc_input *)pinp)->event_type;
> +	} else {
> +		msg->len = sizeof(int);
> +		*(int *)msg->data = *(enum proc_cn_mcast_op *)pinp;
> +	}
> +
> +	if (send(nl_sock, hdr, hdr->nlmsg_len, 0) == -1) {
> +		ret_errno = errno;
> +		perror("send failed");
> +		return -3;
> +	}
> +	return 0;
> +}
> +
> +int register_proc_netlink(int *efd, void *input)
> +{
> +	struct sockaddr_nl sa_nl;
> +	int err = 0, epoll_fd;
> +
> +	nl_sock = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_CONNECTOR);
> +
> +	if (nl_sock == -1) {
> +		ret_errno = errno;
> +		perror("socket failed");
> +		return -1;
> +	}
> +
> +	bzero(&sa_nl, sizeof(sa_nl));
> +	sa_nl.nl_family = AF_NETLINK;
> +	sa_nl.nl_groups = CN_IDX_PROC;
> +	sa_nl.nl_pid    = getpid();
> +
> +	if (bind(nl_sock, (struct sockaddr *)&sa_nl, sizeof(sa_nl)) == -1) {
> +		ret_errno = errno;
> +		perror("bind failed");
> +		return -2;
> +	}
> +
> +	epoll_fd = epoll_create1(EPOLL_CLOEXEC);
> +	if (epoll_fd < 0) {
> +		ret_errno = errno;
> +		perror("epoll_create1 failed");
> +		return -2;
> +	}
> +
> +	err = send_message(input);
> +
> +	if (err < 0)
> +		return err;
> +
> +	evn.events = EPOLLIN;
> +	evn.data.fd = nl_sock;
> +	if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, nl_sock, &evn) < 0) {
> +		ret_errno = errno;
> +		perror("epoll_ctl failed");
> +		return -3;
> +	}
> +	*efd = epoll_fd;
> +	return 0;
> +}
> +
> +static void sigint(int sig)
> +{
> +	interrupted = 1;
> +}
> +
> +int handle_packet(char *buff, int fd, struct proc_event *event)
> +{
> +	struct nlmsghdr *hdr;
> +
> +	hdr = (struct nlmsghdr *)buff;
> +
> +	if (hdr->nlmsg_type == NLMSG_ERROR) {
> +		perror("NLMSG_ERROR error\n");
> +		return -3;
> +	} else if (hdr->nlmsg_type == NLMSG_DONE) {
> +		event = (struct proc_event *)
> +			((struct cn_msg *)NLMSG_DATA(hdr))->data;
> +		tcount++;
> +		switch (event->what) {
> +		case PROC_EVENT_EXIT:
> +			Printf("Exit process %d (tgid %d) with code %d, signal %d\n",
> +			       event->event_data.exit.process_pid,
> +			       event->event_data.exit.process_tgid,
> +			       event->event_data.exit.exit_code,
> +			       event->event_data.exit.exit_signal);
> +			break;
> +		case PROC_EVENT_FORK:
> +			Printf("Fork process %d (tgid %d), parent %d (tgid %d)\n",
> +			       event->event_data.fork.child_pid,
> +			       event->event_data.fork.child_tgid,
> +			       event->event_data.fork.parent_pid,
> +			       event->event_data.fork.parent_tgid);
> +			break;
> +		case PROC_EVENT_EXEC:
> +			Printf("Exec process %d (tgid %d)\n",
> +			       event->event_data.exec.process_pid,
> +			       event->event_data.exec.process_tgid);
> +			break;
> +		case PROC_EVENT_UID:
> +			Printf("UID process %d (tgid %d) uid %d euid %d\n",
> +			       event->event_data.id.process_pid,
> +			       event->event_data.id.process_tgid,
> +			       event->event_data.id.r.ruid,
> +			       event->event_data.id.e.euid);
> +			break;
> +		case PROC_EVENT_GID:
> +			Printf("GID process %d (tgid %d) gid %d egid %d\n",
> +			       event->event_data.id.process_pid,
> +			       event->event_data.id.process_tgid,
> +			       event->event_data.id.r.rgid,
> +			       event->event_data.id.e.egid);
> +			break;
> +		case PROC_EVENT_SID:
> +			Printf("SID process %d (tgid %d)\n",
> +			       event->event_data.sid.process_pid,
> +			       event->event_data.sid.process_tgid);
> +			break;
> +		case PROC_EVENT_PTRACE:
> +			Printf("Ptrace process %d (tgid %d), Tracer %d (tgid %d)\n",
> +			       event->event_data.ptrace.process_pid,
> +			       event->event_data.ptrace.process_tgid,
> +			       event->event_data.ptrace.tracer_pid,
> +			       event->event_data.ptrace.tracer_tgid);
> +			break;
> +		case PROC_EVENT_COMM:
> +			Printf("Comm process %d (tgid %d) comm %s\n",
> +			       event->event_data.comm.process_pid,
> +			       event->event_data.comm.process_tgid,
> +			       event->event_data.comm.comm);
> +			break;
> +		case PROC_EVENT_COREDUMP:
> +			Printf("Coredump process %d (tgid %d) parent %d, (tgid %d)\n",
> +			       event->event_data.coredump.process_pid,
> +			       event->event_data.coredump.process_tgid,
> +			       event->event_data.coredump.parent_pid,
> +			       event->event_data.coredump.parent_tgid);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +	return 0;
> +}
> +
> +int handle_events(int epoll_fd, struct proc_event *pev)
> +{
> +	char buff[CONNECTOR_MAX_MSG_SIZE];
> +	struct epoll_event ev[MAX_EVENTS];
> +	int i, event_count = 0, err = 0;
> +
> +	event_count = epoll_wait(epoll_fd, ev, MAX_EVENTS, -1);
> +	if (event_count < 0) {
> +		ret_errno = errno;
> +		if (ret_errno != EINTR)
> +			perror("epoll_wait failed");
> +		return -3;
> +	}
> +	for (i = 0; i < event_count; i++) {
> +		if (!(ev[i].events & EPOLLIN))
> +			continue;
> +		if (recv(ev[i].data.fd, buff, sizeof(buff), 0) == -1) {
> +			ret_errno = errno;
> +			perror("recv failed");
> +			return -3;
> +		}
> +		err = handle_packet(buff, ev[i].data.fd, pev);
> +		if (err < 0)
> +			return err;
> +	}
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int epoll_fd, err;
> +	struct proc_event proc_ev;
> +	struct proc_input input;
> +
> +	signal(SIGINT, sigint);
> +
> +	if (argc > 2) {
> +		printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
> +		exit(1);
> +	}
> +
> +	if (argc == 2) {
> +		if (strcmp(argv[1], "-f") == 0) {
> +			filter = 1;
> +		} else {
> +			printf("Valid option : -f (for filter feature)\n");
> +			exit(1);
> +		}
> +	}
> +
> +	if (filter) {
> +		input.event_type = PROC_EVENT_NONZERO_EXIT;
> +		input.mcast_op = PROC_CN_MCAST_LISTEN;
> +		err = register_proc_netlink(&epoll_fd, (void*)&input);
> +	} else {
> +		enum proc_cn_mcast_op op = PROC_CN_MCAST_LISTEN;
> +		err = register_proc_netlink(&epoll_fd, (void*)&op);
> +	}
> +
> +	if (err < 0) {
> +		if (err == -2)
> +			close(nl_sock);
> +		if (err == -3) {
> +			close(nl_sock);
> +			close(epoll_fd);
> +		}
> +		exit(1);
> +	}
> +
> +	while (!interrupted) {
> +		err = handle_events(epoll_fd, &proc_ev);
> +		if (err < 0) {
> +			if (ret_errno == EINTR)
> +				continue;
> +			if (err == -2)
> +				close(nl_sock);
> +			if (err == -3) {
> +				close(nl_sock);
> +				close(epoll_fd);
> +			}
> +			exit(1);
> +		}
> +	}
> +
> +	if (filter) {
> +		input.mcast_op = PROC_CN_MCAST_IGNORE;
> +		send_message((void*)&input);
> +	} else {
> +		enum proc_cn_mcast_op op = PROC_CN_MCAST_IGNORE;
> +		send_message((void*)&op);
> +	}
> +
> +	close(epoll_fd);
> +	close(nl_sock);
> +
> +	printf("Done total count: %d\n", tcount);
> +	exit(0);
> +}
> -- 
> 2.41.0
> 
