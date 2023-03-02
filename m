Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591216A8BCD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjCBW1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCBW1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:27:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10E94AFE2;
        Thu,  2 Mar 2023 14:27:45 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K42QI013609;
        Thu, 2 Mar 2023 21:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=jgp/aR8kPTKaMIKaCkqjhjWfZr077ycjLwDmRrhKOuk=;
 b=lRy0dtLoiX+OOzmv9bTIXKnGaLsNZ/dbJdaCDgR2gFazTLRsnvIsTmVBgWFzaBCOvbSg
 IAgs5KYzO5AmI0BQ+uzn0aCDJ/gq+qQjXPSpaAZwgWNGbBqmr2RaETGevcrN5vxGR5H2
 g6Qg1Q1vp4UFjjJVnr7xboKYyNrt8sefnN62B9Sqbnxbm5OuWKkQhWdj+lodywPuESgg
 hNOwnIXnqLv2SenCYg+HJQUE2JBlhb8rauqJtxOKe+AgZVs9+1Q0+/QKmhCIqyQs17J3
 oPvDhlaQCWA3S1pgQjGqNtLlUNHUU6xiQLUhG0FEFXjKvsOnZSLyV4AwAVhi0nCUlUp1 qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb6emxry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KIJiH005287;
        Thu, 2 Mar 2023 21:18:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8saxwmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feaOVZ0d5Cylr2QUkdpY4NeoRmhyEtmKPRYPbRmCh/c3ojiZZd/0jqeMUm1KhAl6z1bysv3NSHvdMpD3Egp1s8HFi7uVYfitcpp74ynyvMvb6fwMaQpDc4+W1tXq2EwFzZAz40R6Rh/ks09c84DXwxvSjT+/id+WX79gFOiXfeCvZ5mf0mMcrYCXt7IvnAk1m2PEDYCf/lG6pUoA4WJIHRLPdeexB28mGFRVYfPeymllMviodelnpVyg36eKjPHJ8yNZ3XzuWhVARGzm1D2EdT2y7e34kDzpHpJ69KuHPy1JxNKRFN6YNq0svaxI/d5phTWeO2e9GNPzq5QXG4MZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgp/aR8kPTKaMIKaCkqjhjWfZr077ycjLwDmRrhKOuk=;
 b=iT1H4IRhDE88chPvVxkcPyrVo9GB16s6kscNIbSXUMEaiGa9dxnB3tXrwKlFF/2bWofXNA6382GbOdW+HMln9aZFRz3NSMdh//BIjocKGdSRKIqk+AYEN8HmfIeE9ZydAP5Qz7Lbvz3mDj5VBH38i7qGzQFdxwHgKeRakVh2lHrIx0mxohG0xbhElNvEmC8R79S++GwL+7xoeCyuVybKw5mLm55q9rVuUgoRENzI6hllzIUNeDvobKN63wiFEoOPcq4hoBu27pYbZR+0lZ9SJ39T3Nbv3z6Ew35bzUVUj1+DDjaYsEcNEn4VJXf9n/1D8M0oXP4T7rWj89guBCHjgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgp/aR8kPTKaMIKaCkqjhjWfZr077ycjLwDmRrhKOuk=;
 b=tE5ZTvx6iJRhM9OlhILY0OMewLm8y0pXMHuHhHCwl9ECD2pyHYIjtJTJe2nG3yve20DYAi64IcE3Mpuu0sIwu1qJ39mG/PHHbLdraVt6fWaRqBRAq7TUdin8u+xgwzbYl+8MxIsFk/DQkCmxdweBW4chYeX1Bs4v+P8zq0rUdIg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 21:18:30 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:18:30 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: [PATCH 04/17] arm-cci: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:46 +0000
Message-Id: <20230302211759.30135-5-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0248.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::20) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 9712d540-b6a3-4689-2611-08db1b63abac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2VyUc5C5gzwzUFYb30D30AI0grSPPPLaH4CshMdvoTFI1iZK/R/ikqReV2b5hLtlN6xLMuzI64+iP49BmnWarCVhJs9jaGrby2+0yEFxm9MV45e42HZ1KvMqHv7rlSlMcaYX6iWv86M7NZvn0+kd5MgErlJEjn50cO3vIETuVuLQyhrYMEsIqhvfJbvwwhcp2izZu0npzTwVRKntm0DcbfDrA8ypPqw9jV0tA+PkugvVwPD7hkzRnwBiz1dIiqTb/wz1gT1gLwfiZP2ReAWPY8iHNzYWQbJ7SSuHW4OVZ+CLWZt79jHD74f6hvLQVCi1S5cAJwiClo0GJ8xQFa1GLP64LUxNyzToBvIMsejOaQ+0vTDf45R1D9tyKmUDp8HuABvPueemmTm6hx0R8qpWW8tRSG4zYZEK1Ygmj0pyY5DYk/jHgDXXLHBnSPDekI/zhlLqWtJnVilWrvKDbAw8pRjwfmHvEvV1PQ/ELmb9X9wLom2PJwlHkFBP70oH8PRc/RW516eX1u/pYCBEjpGPZv4umLG80JzuIgnH1Nk8zZ92KvocEOfsMdh+sCxqcPTuOJ0ItIz6+TZIOqSMWBz1/5ERMEYbnNt+ES4jWmKSUStFK7i9KdfNINC5Oaw4Y72JqsvgIvADAqK2ctXCtKFSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(5660300002)(44832011)(83380400001)(41300700001)(6916009)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(316002)(38100700002)(36756003)(2906002)(6486002)(478600001)(86362001)(6506007)(186003)(6512007)(6666004)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q/q9KMvDKP8kh/7A4ppOVZWHL/ExGuMm0gD406VRsKl2vAboheuQv2KVrjmf?=
 =?us-ascii?Q?gHY/smAAR08Q6uilmJwTfBtm7ygLu1h054BfjuttGvQtEAE9T+LJ8iBstmlP?=
 =?us-ascii?Q?SiJRFxLjt7GWjqRZ1ZL+eRID3SbWDQ+zTmXeNyzLn/49YusWd2Rcfpfls4J5?=
 =?us-ascii?Q?jCG9HZv3j9kb46/xU+ysRbmQZ1JyXJ7+YsYvYjoMS2LNTXtK7LoknyxPZ/Xt?=
 =?us-ascii?Q?M+y+yiuFcuNmFwfPiL+nrBNSnqXCckJaqDgYLpW8FLnpBOkV/EYu1H8JEUE4?=
 =?us-ascii?Q?xsB5crLeN+331ps8gWwt21l1ieYfPUFPz80Ux8pujEdV8nWdv+oMpwIp8c9t?=
 =?us-ascii?Q?0+YRvBXMON383fN2ldmVptTrlkdJjx7hsviaq+WBaOio7APv0WZSizN5p2nN?=
 =?us-ascii?Q?058dWj71PubZp3vav0h1AkpiH0YL9x3N1gPSe1ET+R8gNom/j+ziqz/pQtoC?=
 =?us-ascii?Q?7Bybeh+PLxnaPTZliWtQnLaQ40vpq3mImdY7HfQg6YgFSCFYmoSKBv5bXFm0?=
 =?us-ascii?Q?RUonuPmkhH4ZpMwF+cRZbkXapopAhcjVsD8ciOiIgCBQFamBROPZCq9XXWI1?=
 =?us-ascii?Q?s61+DZNoj2eYBB8muqGjE/HAcCXNbKGraDgt/wam6hHqsaGDWwyCYZr7bvJB?=
 =?us-ascii?Q?Ig03Ktc9mvxX/ygOwqOddx8cDgS0F1tAywe1KlTefh2+4i3DXpKqQAFOKuEC?=
 =?us-ascii?Q?TOOZElf63XiQw8Dt7iy3lpUrYzhGTzi/3t5nGbsu342l1gEvz9Di14QvPt1c?=
 =?us-ascii?Q?xSC0mGXMDqRhWJoPtfVRore+q3ilE0q9K3r1fi4Z+UhrfDSW3xllXuN/ZROc?=
 =?us-ascii?Q?nE1eMP6I+g57ZCNmN6h7uPVJaB2PsE99K/cspGaF5DhnCXhSAnoiv7SCfshW?=
 =?us-ascii?Q?HD+qu6Q2OVn1GX50fObWtaurxnZfyxIotpnPrLjhFsX9IApFsf43SvjaSsOn?=
 =?us-ascii?Q?kYIkWDHUMqRhaTB/jRP76W4am7qgrG9ul8pfckIFtHVCas+3b4sSEvC7ugb8?=
 =?us-ascii?Q?9kpTd5IpL/OpPkQ4WddDLX0FNIkLj6bsu2ZWONxSsPJRGrhe4PUdeBlr9wKg?=
 =?us-ascii?Q?AaKcjuRIFYdRgkPr0mxiOHY9g/mf8VFYS7jbKnnRtcnuQLLG6Ma7TxkFWnU9?=
 =?us-ascii?Q?bIYKFg1f5CK1hZOI+htc8Vs5OSnHV2l0OZlmgtFOICUBIuCj4DE3yAlsup5Y?=
 =?us-ascii?Q?3hk0j4YK6cDuph8T/Ra6asAHWS68lcWFmd/5V7LMQ01eLS45rp++jWSjOEP+?=
 =?us-ascii?Q?HEMexVL+DSBHkUf4LZN6Edcopj/WlXu2Y/Ler7jJZ+ce7nWqHO3aCOrFppSr?=
 =?us-ascii?Q?pBUqSEjk/K3ZnyvGBIRzI7sO7/gQI1MJ73RtcENiK4p4HibMyUmMBhYIHjcz?=
 =?us-ascii?Q?htrh4gPiec588mpmBnf0x/DASsOyT9q40ZU03yDPkZCFzFcpShWUY4gAbLzz?=
 =?us-ascii?Q?K2vMFUiCsLNAgBU8Yk3EvmOfJv5Wsoi6xyEojqTv/Kj5D2IIzMfop8q+QHH7?=
 =?us-ascii?Q?W0GNLTgGvEhTmo7YpGIAcYptF3UzkPyfsRrQ6HWhTEh+m1utQAc3iD+pYbS2?=
 =?us-ascii?Q?fIA1emVT+C+L2z2yzp4yWiSWEXtfWT4Nwe+VUJjV61bEL0ODvfR+8xqTiQWo?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5kDGfK4+iOEy5TBvd5z2NRrf7muK/Plr+uIlsj/y8PMBRM+wVx+xr9L5/DShrQSDQx6f9H6+36ULqpFxHchHJt65PbLBROv6Owv1Rq/v/2fM60hsuO7a4s7SDJf/APFYTJPiKcJJoe3bJzipufUvfLYGiCmWv0rdLkQKj+SR5fjEhsynke0NZK0926B4n63b4mighUYq3uqZ2bv3Oo3cHHLAa0oGZLUpitif2z+/+hMP5/5dE7kVCseHD/LKZb63JAgKBaJnGmSgW6g7bKOc8o1EuHsNAcXvjOf47UvRG8V9Sz/jYYyx5VYsHb4PWcnzbBIFF73ki+5hYimi4BBdBNNVszteeX1bCFe0wJuSuvBYksZPzEgnPd80QXXu6qgrRYFxyPWlE34J8jJ9WKnodF0Sjf0rEDE5pcMOQ41zZ1Z5ZEdU+fOwl/cSAJXk+K9fvFvRiNOkKLiI7EOmSEEM+O5Bz4reynbAhWUH68E6SuLpAfYMMksrLXWampexZHMjgSTIvItJNRYxCoSKjUmMCrMu3SvvvhvPHAkee2aJQcWy7FC8v7GfBVvYk77wRRuwlAVLGvxKwGuK2YtfXTRPEEgpwQtlqvJQmpwX3q8npBZw8xa+b8trvip3LrMXT8+aWaqA4IHqKSaMEPAbKkgiZxLao/+AyZQNZ/V5jsxCSAy3RNwWrJgiMampMfVIQTiNPzW6g1zSotcTGX5iL1drtbZWety4Bp6Rf/B0T2km/K1WgUNO4aw8YgzAmnk3ptBU7beEboL8DbfRFS6DDmgMrV24FbBM8Q1XGIZ+jOcHmTcXlevt2vI+6Z0weWU85DoL
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9712d540-b6a3-4689-2611-08db1b63abac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:18:29.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+We1jmT/nJN+YXEmqrNSzvoPt+yxYUMF2ey40y+zaNPSoZUHyCAgDnLHczvq/y/gdb9Hppftt3UuqYhHOxgWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020183
X-Proofpoint-ORIG-GUID: 2EAb00-433k9LEalYq17KQSJ8boLOO-n
X-Proofpoint-GUID: 2EAb00-433k9LEalYq17KQSJ8boLOO-n
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
---
 drivers/bus/arm-cci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a9035837..e231e9c05da16 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -583,5 +583,4 @@ EXPORT_SYMBOL_GPL(cci_probed);
 
 early_initcall(cci_init);
 core_initcall(cci_platform_init);
-MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ARM CCI support");
-- 
2.39.1.268.g9de2f9a303

