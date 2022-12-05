Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72891642CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiLEQfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiLEQds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:33:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038A11FCF7;
        Mon,  5 Dec 2022 08:33:34 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Fhwbv007846;
        Mon, 5 Dec 2022 16:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=14R3otcJhcIArEc1TbFipBQ3dJK1VYzJrrjSZH9V3/8=;
 b=QVvGDf19IJff/sxX5OM2FgLnUcAWvEz0gOYYi2oFQWdVKtkUhNQMJ/w81M6EKAAyYzEN
 lICVSgCSZHrOjBXKIzqARN96E1oiN4Ow6Ds/v0AzKzK+4HxlFedMM9jZyBBGHhj9qLv0
 k/b7l7e6x92Pwpr/b9nIeRSevQO3vsinI3JzrJ3VpWaoC2/cAccSSs8WpFWNGtdPI/4g
 cgo3XrqGJk9T83t9PFWG8+EQEObOmvS7AA8vOijFt0z0BoTddj1ugKM84KYwCSYzY/LE
 GiXqHlNfJCqcnkqHqOuV4PfiNosgjFF/vdqz1o9bEDYCGoRdrbhj9h8SzJ7XzbE16DrI 8w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ybgmbgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:33:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQu6n027839;
        Mon, 5 Dec 2022 16:33:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ua9dpwh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:33:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWrWc2MqaaIfkTNhXQ2IHvfHktUlKtMXpEJ45K+bm/DDRLTGtKxvhQscoqFrsDq7RmLV1Sy0fJZ07p2bZjvzTqr2AmD8/VCioRK9iEF/juixwkG0v6b6enaFy5dX+3RzeD7sMzdCqY3+y9vmdiXJefHZ06rno3MOhK9WMIZnaDmg+ibicDsE6bE6ECUj4OizS4XB/Ob6ZXu1GDLUk4ErCKJKYAGpqPnR9wYglT8tRO5h3RUGdSfH3Gu3gzhTd3gcZMCLOfN8PoGwOS1EfLub8Il1AGAh1s6l8EOOvyOTFQp0Y3UqTBJUoEAtEWSx5AysWIWSXkjiSEC9wYZ8b1KbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14R3otcJhcIArEc1TbFipBQ3dJK1VYzJrrjSZH9V3/8=;
 b=J37dEPiTGFFctKGtSp/J8fF1W4z2NO1Av7BTiUDBBBKrlDWl9V30XcLAvLKOyfEjdofvrU37/k2XhFyCyGmPvPiJC2VXV5oAiWEm7lidWJGOW9rIk1gdOVwx8m75iCGp25Wh2Kvw2V8gw0upstbBQMKNLnVZ3FJ6kAmrf2CuefussF6wqD4T8FAXu18vhRWBPUTrYnKLUziEsRhM4uWESN0C8mXFVU8RnjBAJRJqwLM3rVPc4avrDQSgJh2YPVRJMXsdcBMMs9JnipxLs1CHAPT2NUZjHiBckpnQDFRWG0pXlXqeedl6NOWycEE/XH5M83xjk8BFBPxuGfq3Q8Jl6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14R3otcJhcIArEc1TbFipBQ3dJK1VYzJrrjSZH9V3/8=;
 b=gk1HX4B2jT8wei7W+lC+l/3HOx2+/hAbjFfdpbw4HrHKJluYsw/XgNLXLC75ly42EYjVF0yfrg2bCIhqtJWScTHRtRA6o8IbJAj6gBtlRpWYoTK26HITcXGB392jDMV4+/4tkBrzVONY+s1Q1EXE8CCDWXqmcUzLh8TziNtWHLg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB5721.namprd10.prod.outlook.com (2603:10b6:510:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 16:33:21 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:33:21 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v10 11/13] kallsyms: distinguish text symbols fully using object file names
Date:   Mon,  5 Dec 2022 16:31:55 +0000
Message-Id: <20221205163157.269335-12-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0004.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::9) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af3e139-6c6d-4e08-e70f-08dad6de5f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dhCUgy3yc7rW4r5ywUFpDG8gm1tRs9BJWPFUe9zF46ROxTtIi6U++edWT9tKfSTeR6AOeXRGPR81+9xOU1rgLQmHDO+I1XzmTydDfZ6N5VYTMIvDkNevy5hwGuRstOywRNFv3IHMUc7qGwxgMcW24lEDrDQnB1yR10nqpzUI1bdEjiSuBXE+llUzpdANuQKUBoq/2P2u1WYFhkz/QdW70/I0fKezM8f6HiFebHzzu32wPWVs1QaVDsPlZsZD+7ctg0SCANuydcKjMvftorcy/AOWVwK16Q6nnDb8k3VhFJhR3APFMIlqT+/BHc3caLZJ+p6bsaKnOhGxKKuLS8BDhiQh6zv0ZYp0gNBvuAIprle+tsz7/K5uPS/kJjfA9r4YBukwe0aspkcwXI4m8MH412X46b9mm4BnrbTPwodkQSdBAo96EfugLV+3oS9kc9RtSWU3V5HLW3N3DwPKp0NAhvih2MKqwUrwq9MqJuQpbjL2CDhLvEWtQ7zRQOQ9WVbQCpsJFxssgaDIh/PaY+oCnTtKSTns8WcHnhA9crVcXkTUY5zCAb/KsjuFxsDBLiPu5smSNy9K7W2dyy+aKNrMEbbzIiMzHpRqjPltvv9e7Xl4p03eFyAJwjiXoWchy1xTugdp/n/+jWOhb4E8O/QDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(316002)(6486002)(107886003)(478600001)(6666004)(6506007)(6512007)(66946007)(8676002)(4326008)(66476007)(66556008)(83380400001)(30864003)(8936002)(5660300002)(44832011)(186003)(41300700001)(2906002)(1076003)(36756003)(2616005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2MBeMIMlNyLbfKTrnHMbsalk+c4J69EfGL6KTVgeyWfdpO2aVFMLVN/V0NCC?=
 =?us-ascii?Q?7NtZ803oTpdyRG1JsPIUTvqGQuyE18scheSGo1nmDjLPCLzQ2cO6upGEwvJE?=
 =?us-ascii?Q?+Lem1f/2QXYP24vb/O7e4L32fYmmP0jN845EqOzvBpGcVZBTVqR6o+Xgq3bo?=
 =?us-ascii?Q?pzcYCgjEnIAz9la/mGUn9YSbkEvLdmIuGH/hzNXMnIXN3P8k/eA1JbAAlzEL?=
 =?us-ascii?Q?ViakPmNK7qJGVy9xYO5tbBlYDo0LnU3R9Jc9IkcDv1iQxu5oW1TVaps55P7j?=
 =?us-ascii?Q?sXElQP+/7AclAtVTTJ4T4uevQTr7H65oqTkeWxu4h0IKfFzZmpVdxv79Ajtu?=
 =?us-ascii?Q?PQ8DM2gHlECwVVkeHc9kC787r7hgAscIrPrW/DgLIeiv4vaa5VSqZEVSlIdf?=
 =?us-ascii?Q?5qyZbwBvecFwLounYmagBZ4QITi3WPTqmfoQPKOV0arEaAM2M5MqIjK2ZJ0j?=
 =?us-ascii?Q?8tnOUXXvYwgeNJ3OAnT2iD6FRC8eNFlkeLVqe1NrmiUawiqh/sOl903gfGDr?=
 =?us-ascii?Q?u3DJiS2BTRCUSZ3XVsD/T3DF5zszyBk3NPZSg0ZiRTQxhN0jP6S3EuijVzs3?=
 =?us-ascii?Q?j8XWq4zy7VkQF+m8hqt7jkbaiLTrtRfkOwDcajIT7wBexzLUzf8hWnblUE/d?=
 =?us-ascii?Q?rGcZXZr3OsS/dnNYOW3qPgRwMT4NTvVoVm4t4bT25KY+2viitQ3Olx5r4jif?=
 =?us-ascii?Q?KRqouI/CwzevImz0vbh6sqF4U6Sb/opqfW4bMFaa7a86Zc6x1cTZCCcyBR+B?=
 =?us-ascii?Q?yx+W7UARozN9NXpV+PXVSFBuT7yIbrHcoCcceSJS9f89/Le2Gm0i+/ESPNKz?=
 =?us-ascii?Q?uJ4mtMBTQ2ou8J0HvodKlNkt+YVS1IRYU1WsoOtIhbxXiovmP10myYMD7cx1?=
 =?us-ascii?Q?bGQZt2rw4NZPaSuayjrHuIu1Vn4wQX9OQCAK+kZLSQP59117XIMJVi/b/9l8?=
 =?us-ascii?Q?Gl5zlUJtO+SPRnEoiMM68KGMPD1CQzLiSoosZLfaTFAldHDRmW/Fj0oMxGB3?=
 =?us-ascii?Q?A2jWnDRAXRWGp2g5fTyLj33xv3b1mLBnpJ8QtkAtKXHXqkeRRy8MvpeYgVWf?=
 =?us-ascii?Q?Y8Be/1gSpOnJaU2S4Wr9/JJdLgeN9DIb7JuQJ9ynfHfT8JO95Oa0IQd0LzHh?=
 =?us-ascii?Q?U/FGVfH+3xY90vNFGnG64fxMEunzvqS8OdeyUzpfZZtPdP7GW4R9DZy/qZ1i?=
 =?us-ascii?Q?G70oRQVIxI+U5ClRdLREftNcPDtv/XZ9RIQy4q9H9i9Fo9KlcKbJUmnLf/xW?=
 =?us-ascii?Q?1gVZB6W61MUCFtkbPJcljDLr2wJfgpZq1eK5pqaVOJEPlbN+LdXdGO/BTsnT?=
 =?us-ascii?Q?ONicDbVOZmUWGikzd4PPBufhG/rWbzAjjV6zNq3q3ujyZ94ElwgXevP258qc?=
 =?us-ascii?Q?nQIZR425Qz/Z04B9XDXr8iu8MAsCtXpzVkURhlw7Z4iyS3GOn/gScmfyrxho?=
 =?us-ascii?Q?GmLqLksRqmCeYVKeJ4zr7fhYafIVR9h7ZnlXnWZonII2IxAJTJAucuGhTilI?=
 =?us-ascii?Q?j5SbTabxA3VD0K9AYpt2/6I35SXpOyjTcjjrMO69h6P6XO9dmoIIAN4OzMR5?=
 =?us-ascii?Q?USQBmUfUnz00UdsTQtD6ODZpW+xO9nFsNCeuzHNec3SvGDCUjaSfeg/LvdYR?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?01cz2mwmxMEBp+tzdTcgkvVokXgIwk/GNNQVUZVobaFZONMeNCf6ClovlBoi?=
 =?us-ascii?Q?GShavM2EYgCcZtkAaccASVYZggUV5kkUehLTnrRUc/grSMbTpE1q1t7DNezh?=
 =?us-ascii?Q?Z1FeaNkRUOzvT8gW4HBHwZ9baTNE0hy320M/vLqr4/VogyCwHmlInJr+Mm+V?=
 =?us-ascii?Q?RxYrIxdpHgGtAAbxadvFiZpSsGrcoTzMmNSPe7l0RolA93zIJE5LNq7/0ivB?=
 =?us-ascii?Q?Qmcg30zr99fR3L2sCc56LyeIW74C3anDy3cbqBY027Tyte7Jx2NBAf3YkSPh?=
 =?us-ascii?Q?1VWAZbKin9wIQ5rMDRvZ9Ic6hEpEttsV7IeYKPZtOWLKF4jyZzhVJlp26xbh?=
 =?us-ascii?Q?OVvcJ3zS2DHECoV/DcB8w+KLF8nSRrl2IfOiijKBtPUqG8qR5n6sFecga396?=
 =?us-ascii?Q?lAlEZsYuzwbgtqGnXK4TLyDbW+RlunaQ9QZCE7/nqGjbKGv4s4c65arPVAuL?=
 =?us-ascii?Q?fW48J5frggf6xUNOURTbqJKbj6RcnHovZtl6xoEuKKKMcCbgVnqzhUGJ/WRP?=
 =?us-ascii?Q?UHt2BrnYEXoyHKw7FXOQlIhFO/ewvgq86nniJT8YJWMuV5m4GSzv1ONxJJ37?=
 =?us-ascii?Q?7INLyosrKD84TM0wSpEuSDtWDpqsdzkcnBDpD/e4ad2V1GjRYMgSw6MuJZD0?=
 =?us-ascii?Q?WOYqIRN1ZzcnFO+OEvzzqvHYepa9xtgu+dyIDJ0oJ3mbQH6RQrlX6ZugNSfk?=
 =?us-ascii?Q?EVlXR2fc5eiBv+qf+x0AuoMKnygkjrIWPTWycDkhFirkTnjFtp+VNCUjXVU8?=
 =?us-ascii?Q?x+xblBz5DK+Pz9B6xmj5dJ4HLOBXkaTvCG6TsaV/c53WULU3bZo2cwwIJxPT?=
 =?us-ascii?Q?H+jOl+xzDmbBLwXimc32t8ePqSZ5HmQTUgq8kWAQCcTCs6sqI/WZNGMhfjYe?=
 =?us-ascii?Q?tEPBRV4ZutLEoeKW0RD6g7j7BCpgs9HdJOy0tkmmSKtuvpPmbgff0bWD4EC6?=
 =?us-ascii?Q?v1uk3+B8FakexN5C/CMNFcntE9QyqSMBHTodgKUtMu4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af3e139-6c6d-4e08-e70f-08dad6de5f41
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:32:59.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9RJDL7hz2qwE2hdh8kr1zYq3VqHhKoMSKhAs8rS9SYsustVvRWp+cLJ62Y9yT9SXf1JbGxCkeXqlREHq3q3hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050138
X-Proofpoint-ORIG-GUID: fRggojZ87wb_FNM_XnLwsqQNHMboa5Nx
X-Proofpoint-GUID: fRggojZ87wb_FNM_XnLwsqQNHMboa5Nx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commits before this one will let /proc/kallmodsyms distinguish
identically-named text symbols located in different built-in object
files from each other; but identically-named symbols can appear in any
object files at all, including object files that cannot be built as
modules.  Even modules can have identically-named symbols in them, in
distinct translation units.  (This might seem like overdesign, after
all, how many such symbols can there be? But Some config options
introduce huge numbers of such symbols, notably _sub_I_65535_1: these
all contain code and might show up in trace output, but appear in almost
every compiled object file.  Distinguishing them really needs machine
assistance: nobody wants to figure out which of three thousand
_sub_I_65535_1's is which by hand!)

We already have nearly all the machinery to disambiguate such symbols
reliably.  Since any given object file emitted by the compiler can
contain at most one definition of a given symbol, it suffices to name
the object files containing any symbol which is otherwise ambiguous.
(No others need be named, saving a bunch of space).

We associate address ranges with object file names using a new
.kallsyms_objfiles section just like the previously-added
.kallsyms_modules section.

But that's not quite enough.  Even the object file name is ambiguous in
some cases: e.g. there are a lot of files named "core.o" in the kernel.
We could just store the full pathname for every object file, but this is
needlessly wasteful: doing this eats more than 50KiB in object file
names alone, and nearly all the content of every name is repeated for
many names.  But if we store the object file names in the same section
as the built-in module names, drop the .o, and store minimal path
suffixes, we can save almost all that space.  (For example, "core.o"
would be stored as "core" unless there are ambiguous symbols in two
different object files both named "core", in which case they'd be named
"sched/core" and "futex/core", etc, possibly re-extending to
"kernel/sched/core" if still ambiguous).

We do this by a repeated-rehashing process. First, we compute a hash
value for symbol\0modhash for every symbol (the modhash is ignored if
this is a built-in symbol).  Any two symbols with the same such hash are
identically-named: add the maximally-shortened (one-component,
.o-stripped) object file name for all such symbols, and rehash, this
time hashing symbol\0objname\0modhash.  Any two symbols which still have
the same hash are still ambiguous: lengthen the name given to one of the
symbols' object files and repeat -- we pick the object file with the
longest full pathname so that we can disambiguate e.g.
arch/x86/kernel/smp.o and kernel/smp.o from each other.
Eventually, all the ambiguity will go away.  (We do have to take care
not to re-lengthen anything we already lengthened in any given hashing
round.)

This involves multiple sorting passes but the impact on compilation time
appears to be nearly zero, and the impact on space in the running kernel
is noticeable: only a few dozen names usually need lengthening, so we
can completely ignore the overhead from storing repeated path components
because there are hardly any of them.

But that's not all.  We can also do similar optimization tricks to what
was done with .kallsyms_modules, reusing module names and names of
already-emitted object files: so any given object file name only appears
once in the strtab, and can be cited by many address ranges and even by
module entries.

Put all this together and the net overhead of this in my testing is
about 3KiB of new object file names in the .kallsyms_mod_objnames table
and 6KiB for the .kallsyms_objfiles table (mostly zeroes: in future
maybe we can find a way to elide some of those, but 6KiB is small enough
that it's not worth taking too much effort).

No ambiguous textual symbols remain outside actual modules (which can
still contain identically-named symbols in different object files
because kallsyms doesn't run over them so none of these tables can be
built for them.  At least, it doesn't yet).  We warn about any ambiguous
symbols we find at build time.

(Caveat: the nvhe module on aarch64 is still linked with ld -r, which
causes its contents to appear to come from a single object file when the
linker emits its final mapfile.  We spot such unfixable ambiguous
symbols and don't warn about them because there's nothing we can do. The
solution is probably to fix nvhe so it uses thin archives like
everything else does.)

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v9: new.
    v10: Handle objnames that are substrings of other objnames.  Warn
         about conflicts which seem to be the result of ld -r.  Fix
         potential infloop emitting .kallsyms_mod_objnames.
         Mention ultimate user (kallmodsyms), problems with ld -r and
         aarch64 nvhe in commit log.

 scripts/kallsyms.c | 595 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 582 insertions(+), 13 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 4d8289040ad5..ecb993efe499 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -115,6 +115,9 @@ static unsigned int memhash(char *s, size_t len)
 	return hash;
 }
 
+/*
+ * Object file -> module and shortened object file name tracking machinery.
+ */
 #define OBJ2MOD_BITS 10
 #define OBJ2MOD_N (1 << OBJ2MOD_BITS)
 #define OBJ2MOD_MASK (OBJ2MOD_N - 1)
@@ -145,15 +148,40 @@ struct obj2mod_elem {
 	struct obj2mod_elem *mod2obj_next;
 };
 
+/*
+ * Shortened object file names.  These are only ever consulted after checking
+ * the obj2mod hashes: names that already exist in there are used directly from
+ * there (pointed to via the mod_xref field) rather than being re-emitted.
+ * Entries that do not exist there are added to the end of the mod_objnames
+ * list.
+ */
+struct obj2short_elem {
+	const char *obj;
+	char *desuffixed;	/* objname sans suffix */
+	const char *short_obj;	/* shortened at / and suffix */
+	int short_offset;	/* offset of short name in .kallsyms_mod_objnames */
+	int last_rehash;	/* used during disambiguate_hash_syms */
+
+	struct obj2mod_elem *mod_xref;
+	struct obj2short_elem *short_xref;
+	struct obj2short_elem *short_next;
+};
+
 /*
  * Map from object files to obj2mod entries (a unique mapping), and vice versa
  * (not unique, but entries for objfiles in more than one module in this hash
- * are ignored).
+ * are ignored); also map from object file names to shortened names for them
+ * (also unique: there is no point storing both longer and shorter forms of one
+ * name, so if a longer name is needed we consistently use it instead of the
+ * shorter form.)
+ *
+ * obj2short is populated very late, at disambiguate_syms time.
  */
 
 static struct obj2mod_elem *obj2mod[OBJ2MOD_N];
 static struct obj2mod_elem *mod2obj[OBJ2MOD_N];
-static size_t num_objfiles;
+static struct obj2short_elem *obj2short[OBJ2MOD_N];
+static size_t num_objfiles, num_shortnames;
 
 /*
  * An ordered list of address ranges and the objfile that occupies that range.
@@ -167,6 +195,9 @@ struct addrmap_entry {
 static struct addrmap_entry *addrmap;
 static int addrmap_num, addrmap_alloced;
 
+static void disambiguate_syms(void);
+static void optimize_objnames(void);
+
 static void obj2mod_init(void)
 {
 	memset(obj2mod, 0, sizeof(obj2mod));
@@ -184,6 +215,18 @@ static struct obj2mod_elem *obj2mod_get(const char *obj)
 	return NULL;
 }
 
+static struct obj2short_elem *obj2short_get(const char *obj)
+{
+	int i = strhash(obj) & OBJ2MOD_MASK;
+	struct obj2short_elem *elem;
+
+	for (elem = obj2short[i]; elem; elem = elem->short_next) {
+		if (strcmp(elem->obj, obj) == 0)
+			return elem;
+	}
+	return NULL;
+}
+
 /*
  * Note that a given object file is found in some module, interning it in the
  * obj2mod hash.  Should not be called more than once for any given (module,
@@ -256,6 +299,12 @@ static int qmodhash(const void *a, const void *b)
 	return 0;
 }
 
+static int qobj2short(const void *a, const void *b)
+{
+	return strcmp((*(struct obj2short_elem **)a)->short_obj,
+		      (*(struct obj2short_elem **)b)->short_obj);
+}
+
 /*
  * Associate all object files in obj2mod which refer to the same module with a
  * single obj2mod entry for emission, preferring to point into the module list
@@ -395,6 +444,370 @@ static void optimize_obj2mod(void)
 	fprintf(stderr, "kallsyms: out of memory optimizing module list\n");
 	exit(EXIT_FAILURE);
 }
+
+/*
+ * Associate all short-name entries in obj2short that refer to the same short
+ * name with a single entry for emission, either (preferably) a module that
+ * shares that name or (alternatively) the first obj2short entry referencing
+ * that name.
+ */
+static void optimize_objnames(void)
+{
+	size_t i;
+	size_t num_objnames = 0;
+	struct obj2short_elem *elem;
+	struct obj2short_elem **uniq;
+	struct obj2short_elem *last;
+
+	uniq = malloc(sizeof(struct obj2short_elem *) * num_shortnames);
+	if (uniq == NULL) {
+		fprintf(stderr, "kallsyms: out of memory optimizing object file name list\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/*
+	 * Much like optimize_obj2mod, except there is no need to canonicalize
+	 * anything or handle multimodule entries, and we need to chase down
+	 * possible entries in mod2obj first (so as not to duplicate them in the
+	 * final kallsyms_mod_objnames strtab).
+	 */
+	for (i = 0; i < OBJ2MOD_N; i++)
+		for (elem = obj2short[i]; elem; elem = elem->short_next)
+			uniq[num_objnames++] = elem;
+
+	qsort(uniq, num_objnames, sizeof(struct obj2short_elem *), qobj2short);
+
+	for (i = 0, last = NULL; i < num_objnames; i++) {
+		int h = strhash(uniq[i]->short_obj) & OBJ2MOD_MASK;
+		struct obj2mod_elem *mod_elem;
+
+		for (mod_elem = mod2obj[h]; mod_elem;
+		     mod_elem = mod_elem->mod2obj_next) {
+			/*
+			 * mod_elem entries are only valid if they are for
+			 * single-module objfiles: see obj2mod_add
+			 */
+			if (mod_elem->nmods > 1)
+				continue;
+
+			if (strcmp(mod_elem->mods, uniq[i]->short_obj) != 0)
+				continue;
+			uniq[i]->mod_xref = mod_elem;
+			break;
+		}
+
+		/*
+		 * Only look for a short_xref match if we don't already have one
+		 * in mod_xref.  (This means that multiple objfiles with the
+		 * same short name that is also a module name all chain directly
+		 * to the module name via mod_xref, rather than going through a
+		 * chain of short_xrefs.)
+		 */
+		if (uniq[i]->mod_xref)
+			continue;
+
+		if (last != NULL && strcmp(last->short_obj,
+					   uniq[i]->short_obj) == 0) {
+			uniq[i]->short_xref = last;
+			continue;
+		}
+
+		last = uniq[i];
+	}
+
+	free(uniq);
+}
+
+/*
+ * Used inside disambiguate_syms to identify colliding symbols.  We spot this by
+ * hashing symbol\0modhash (or just the symbol name if this is in the core
+ * kernel) and seeing if that collides.  (This means we don't need to bother
+ * canonicalizing the module list, since optimize_obj2mod already did it for
+ * us.)
+ *
+ * If that collides, we try disambiguating by adding ever-longer pieces of the
+ * object file name before the modhash until we no longer collide.  The result
+ * of this repeated addition becomes the obj2short hashtab.
+ */
+struct sym_maybe_collides {
+	struct sym_entry *sym;
+	struct addrmap_entry *addr;
+	unsigned int symhash;
+	int warned;
+};
+
+static int qsymhash(const void *a, const void *b)
+{
+	const struct sym_maybe_collides *el_a = a;
+	const struct sym_maybe_collides *el_b = b;
+	if (el_a->symhash < el_b->symhash)
+		return -1;
+	else if (el_a->symhash > el_b->symhash)
+		return 1;
+	return 0;
+}
+
+static int find_addrmap(const void *a, const void *b)
+{
+	const struct sym_entry *sym = a;
+	const struct addrmap_entry *map = b;
+
+	if (sym->addr < map->addr)
+		return -1;
+	else if (sym->addr >= map->end_addr)
+		return 1;
+	return 0;
+}
+
+/*
+ * Allocate or lengthen an object file name for a symbol that needs it.
+ */
+static int lengthen_short_name(struct sym_maybe_collides *sym,
+			       struct sym_maybe_collides *last_sym,
+			       int hash_cycle)
+{
+	struct obj2short_elem *short_objname;
+
+	/*
+	 * If both symbols come from the same object file, skip as unresolvable
+	 * and avoid retrying.  This can happen if the intermediate object file
+	 * was partially linked via ld -r, concealing the original object file
+	 * names from the linker and thus from us.
+	 */
+	if (strcmp(last_sym->addr->obj, sym->addr->obj) == 0) {
+		if (!sym->warned && !last_sym->warned) {
+			fprintf(stderr, "Symbol %s appears multiple times in %s; likely linked with ld -r; entry in /proc/kallmodsyms will be ambiguous\n",
+				&sym->sym->sym[1], sym->addr->obj);
+		}
+		sym->warned = 1;
+		last_sym->warned = 1;
+		return 0;
+	}
+
+	/*
+	 * Always lengthen the symbol that has the longest objname to lengthen,
+	 * ensuring that where one objname is a strict subset of another, we
+	 * always lengthen the one that will eventually resolve the ambiguity.
+	 */
+	if (strlen(last_sym->addr->obj) > strlen(sym->addr->obj)) {
+		struct sym_maybe_collides *tmp;
+
+		tmp = sym;
+		sym = last_sym;
+		last_sym = tmp;
+	}
+
+	short_objname = obj2short_get(sym->addr->obj);
+
+	if (!short_objname) {
+		int i = strhash(sym->addr->obj) & OBJ2MOD_MASK;
+		char *p;
+
+		short_objname = malloc(sizeof(struct obj2short_elem));
+		if (short_objname == NULL)
+			goto oom;
+
+		/*
+		 * New symbol: try maximal shortening, which is just the object
+		 * file name (no directory) with the suffix removed (the suffix
+		 * is useless for disambiguation since it is almost always .o).
+		 *
+		 * Add a bit of paranoia to allow for names starting with /,
+		 * ending with ., and names with no suffix.  (At least two of
+		 * these are most unlikely, but possible.)
+		 */
+
+		memset(short_objname, 0, sizeof(struct obj2short_elem));
+		short_objname->obj = sym->addr->obj;
+
+		p = strrchr(sym->addr->obj, '.');
+		if (p)
+			short_objname->desuffixed = strndup(sym->addr->obj,
+							    p - sym->addr->obj);
+		else
+			short_objname->desuffixed = strdup(sym->addr->obj);
+
+		if (short_objname->desuffixed == NULL)
+			goto oom;
+
+		p = strrchr(short_objname->desuffixed, '/');
+		if (p && p[1] != 0)
+			short_objname->short_obj = p + 1;
+		else
+			short_objname->short_obj = short_objname->desuffixed;
+
+		short_objname->short_next = obj2short[i];
+		short_objname->last_rehash = hash_cycle;
+		obj2short[i] = short_objname;
+
+		num_shortnames++;
+		return 1;
+	}
+
+	/*
+	 * Objname already lengthened by a previous symbol clash: do nothing
+	 * until we rehash again.
+	 */
+	if (short_objname->last_rehash == hash_cycle)
+		return 0;
+	short_objname->last_rehash = hash_cycle;
+
+	/*
+	 * Existing symbol: lengthen the objname we already have.
+	 */
+
+	if (short_objname->desuffixed == short_objname->short_obj) {
+		fprintf(stderr, "Cannot disambiguate %s: objname %s is "
+			"max-length but still colliding\n",
+			&sym->sym->sym[1], short_objname->short_obj);
+		return 0;
+	}
+
+	/*
+	 * Allow for absolute paths, where the first byte is '/'.
+	 */
+
+	if (short_objname->desuffixed >= short_objname->short_obj - 2)
+		short_objname->short_obj = short_objname->desuffixed;
+	else {
+		for (short_objname->short_obj -= 2;
+		     short_objname->short_obj > short_objname->desuffixed &&
+		     *short_objname->short_obj != '/';
+		     short_objname->short_obj--);
+
+		if (*short_objname->short_obj == '/')
+			short_objname->short_obj++;
+	}
+	return 1;
+ oom:
+	fprintf(stderr, "Out of memory disambiguating syms\n");
+	exit(EXIT_FAILURE);
+}
+
+/*
+ * Do one round of disambiguation-check symbol hashing, factoring in the current
+ * set of applicable shortened object file names for those symbols that need
+ * them.
+ */
+static void disambiguate_hash_syms(struct sym_maybe_collides *syms)
+{
+	size_t i;
+	for (i = 0; i < table_cnt; i++) {
+		struct obj2short_elem *short_objname = NULL;
+		char *tmp, *p;
+		size_t tmp_size;
+
+		if (syms[i].sym == NULL) {
+			syms[i].symhash = 0;
+			continue;
+		}
+
+		short_objname = obj2short_get(syms[i].addr->obj);
+
+		tmp_size = strlen((char *) &(syms[i].sym->sym[1])) + 1;
+
+		if (short_objname)
+			tmp_size += strlen(short_objname->short_obj) + 1;
+
+		if (syms[i].addr->objfile)
+			tmp_size += sizeof(syms[i].addr->objfile->modhash);
+
+		tmp = malloc(tmp_size);
+		if (tmp == NULL) {
+			fprintf(stderr, "Out of memory disambiguating syms\n");
+			exit(EXIT_FAILURE);
+		}
+
+		p = stpcpy(tmp, (char *) &(syms[i].sym->sym[1]));
+		p++;
+		if (short_objname) {
+			p = stpcpy(p, short_objname->short_obj);
+			p++;
+		}
+		if (syms[i].addr->objfile)
+			memcpy(p, &(syms[i].addr->objfile->modhash),
+			       sizeof(syms[i].addr->objfile->modhash));
+
+		syms[i].symhash = memhash(tmp, tmp_size);
+		free(tmp);
+	}
+
+	qsort(syms, table_cnt, sizeof (struct sym_maybe_collides), qsymhash);
+}
+
+/*
+ * Figure out which object file names are necessary to disambiguate all symbols
+ * in the linked kernel: transform them for minimum length while retaining
+ * disambiguity: point to them in obj2short.
+ */
+static void disambiguate_syms(void)
+{
+	size_t i;
+	int retry;
+	int hash_cycle = 0;
+	unsigned int lasthash;
+	struct sym_maybe_collides *syms;
+
+	syms = calloc(table_cnt, sizeof(struct sym_maybe_collides));
+
+	if (syms == NULL)
+		goto oom;
+
+	/*
+	 * Initial table population: symbol-dependent things not affected by
+	 * disambiguation rounds.
+	 */
+	for (i = 0; i < table_cnt; i++) {
+		struct addrmap_entry *addr;
+
+		/*
+		 * Only bother doing anything for function symbols.
+		 */
+		if (table[i]->sym[0] != 't' && table[i]->sym[0] != 'T' &&
+		    table[i]->sym[0] != 'w' && table[i]->sym[0] != 'W')
+			continue;
+
+		addr = bsearch(table[i], addrmap, addrmap_num,
+			       sizeof(struct addrmap_entry), find_addrmap);
+
+		/*
+		 * Some function symbols (section start symbols, discarded
+		 * non-text-range symbols, etc) don't appear in the linker map
+		 * at all.
+		 */
+		if (addr == NULL)
+			continue;
+
+		syms[i].sym = table[i];
+		syms[i].addr = addr;
+	}
+
+	do {
+		hash_cycle++;
+		retry = 0;
+		lasthash = 0;
+		disambiguate_hash_syms(syms);
+
+		for (i = 0; i < table_cnt; i++) {
+			if (syms[i].sym == NULL)
+				continue;
+			if (syms[i].symhash == lasthash) {
+				if (lengthen_short_name(&syms[i], &syms[i-1],
+							hash_cycle))
+					retry = 1;
+			}
+			lasthash = syms[i].symhash;
+		}
+	} while (retry);
+
+	free(syms);
+	return;
+ oom:
+	fprintf(stderr, "kallsyms: out of memory disambiguating syms\n");
+	exit(EXIT_FAILURE);
+
+}
+
 #endif /* CONFIG_KALLMODSYMS */
 
 static void usage(void)
@@ -426,6 +839,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"kallsyms_relative_base",
 		"kallsyms_num_syms",
 		"kallsyms_num_modules",
+		"kallsyms_num_objfiles",
 		"kallsyms_names",
 		"kallsyms_markers",
 		"kallsyms_token_table",
@@ -433,6 +847,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"kallsyms_module_offsets",
 		"kallsyms_module_addresses",
 		"kallsyms_modules",
+		"kallsyms_objfiles",
 		"kallsyms_mod_objnames",
 		"kallsyms_mod_objnames_len",
 		/* Exclude linker generated symbols which vary between passes */
@@ -702,6 +1117,7 @@ static void output_address(unsigned long long addr)
 static void output_kallmodsyms_mod_objnames(void)
 {
 	struct obj2mod_elem *elem;
+	struct obj2short_elem *short_elem;
 	size_t offset = 1;
 	size_t i;
 
@@ -757,15 +1173,77 @@ static void output_kallmodsyms_mod_objnames(void)
 			}
 		}
 	}
+
+	/*
+	 * Module names are done; now emit objfile names that don't match
+	 * objfile names.  They go in the same section to enable deduplication
+	 * between (maximally-shortened) objfile names and module names.
+	 * (This is another reason why objfile names drop the suffix.)
+	 */
+	for (i = 0; i < OBJ2MOD_N; i++) {
+		for (short_elem = obj2short[i]; short_elem;
+		     short_elem = short_elem->short_next) {
+
+			struct obj2short_elem *out_elem = short_elem;
+
+			/* Already emitted? */
+			if (out_elem->mod_xref)
+				continue;
+
+			if (out_elem->short_xref)
+				out_elem = out_elem->short_xref;
+
+			if (out_elem->short_offset != 0)
+				continue;
+
+			printf("/* 0x%lx: shortened from %s */\n", offset,
+			       out_elem->obj);
+
+			out_elem->short_offset = offset;
+			printf("\t.asciz\t\"%s\"\n", out_elem->short_obj);
+			offset += strlen(out_elem->short_obj) + 1;
+		}
+	}
+
 	printf("\n");
 	output_label("kallsyms_mod_objnames_len");
 	printf("\t.long\t%zi\n", offset);
 }
 
+/*
+ * Return 1 if this address range cites the same built-in module and objfile
+ * name as the previous one.
+ */
+static int same_kallmodsyms_range(int i)
+{
+	struct obj2short_elem *last_short;
+	struct obj2short_elem *this_short;
+	if (i == 0)
+		return 0;
+
+	last_short = obj2short_get(addrmap[i-1].obj);
+	this_short = obj2short_get(addrmap[i].obj);
+
+	if (addrmap[i-1].objfile == addrmap[i].objfile) {
+
+		if ((last_short == NULL && this_short != NULL) ||
+		    (last_short != NULL && this_short == NULL))
+			return 0;
+
+		if (last_short == NULL && this_short == NULL)
+			return 1;
+
+		if (strcmp(last_short->short_obj, this_short->short_obj) == 0)
+			return 1;
+	}
+	return 0;
+}
+
 static void output_kallmodsyms_objfiles(void)
 {
 	size_t i = 0;
 	size_t emitted_offsets = 0;
+	size_t emitted_modules = 0;
 	size_t emitted_objfiles = 0;
 
 	if (base_relative)
@@ -777,12 +1255,15 @@ static void output_kallmodsyms_objfiles(void)
 		long long offset;
 		int overflow;
 
-                /*
-                 * Fuse consecutive address ranges citing the same object file
-                 * into one.
-                 */
-                if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
-                        continue;
+		printf("/* 0x%llx--0x%llx: %s */\n", addrmap[i].addr,
+		       addrmap[i].end_addr, addrmap[i].obj);
+
+		/*
+		 * Fuse consecutive address ranges citing the same built-in
+		 * module and objfile name into one.
+		 */
+		if (same_kallmodsyms_range(i))
+			continue;
 
 		if (base_relative) {
 			if (!absolute_percpu) {
@@ -809,11 +1290,12 @@ static void output_kallmodsyms_objfiles(void)
 
 	for (i = 0; i < addrmap_num; i++) {
 		struct obj2mod_elem *elem = addrmap[i].objfile;
+		struct obj2mod_elem *orig_elem = NULL;
 		int orig_nmods;
 		const char *orig_modname;
 		int mod_offset;
 
-		if (i > 0 && addrmap[i-1].objfile == addrmap[i].objfile)
+		if (same_kallmodsyms_range(i))
 			continue;
 
 		/*
@@ -821,8 +1303,10 @@ static void output_kallmodsyms_objfiles(void)
 		 * built-in module.
 		 */
 		if (addrmap[i].objfile == NULL) {
+			printf("/* 0x%llx--0x%llx: %s: built-in */\n",
+			       addrmap[i].addr, addrmap[i].end_addr, addrmap[i].obj);
 			printf("\t.long\t0x0\n");
-			emitted_objfiles++;
+			emitted_modules++;
 			continue;
 		}
 
@@ -837,8 +1321,10 @@ static void output_kallmodsyms_objfiles(void)
 		 * always points at the start of the xref target, so its offset
 		 * can be used as is.
 		 */
-		if (elem->xref)
+		if (elem->xref) {
+			orig_elem = elem;
 			elem = elem->xref;
+		}
 
 		if (elem->nmods == 1 || orig_nmods > 1) {
 
@@ -874,6 +1360,19 @@ static void output_kallmodsyms_objfiles(void)
 			 * the multimodule entry.
 			 */
 			mod_offset += onemod - elem->mods + 2;
+
+			/*
+			 * If this was the result of an xref chase, store this
+			 * mod_offset in the original entry so we can just reuse
+			 * it if an objfile shares this name.
+			 */
+
+			printf("/* 0x%llx--0x%llx: %s: single-module ref to %s in multimodule at %x */\n",
+			       addrmap[i].addr, addrmap[i].end_addr,
+			       orig_elem->mods, onemod, elem->mod_offset);
+
+			if (orig_elem)
+				orig_elem->mod_offset = mod_offset;
 		}
 
 		/*
@@ -883,12 +1382,68 @@ static void output_kallmodsyms_objfiles(void)
 		assert(elem->mod_offset != 0);
 
 		printf("\t.long\t0x%x\n", mod_offset);
-		emitted_objfiles++;
+		emitted_modules++;
 	}
 
-	assert(emitted_offsets == emitted_objfiles);
+	assert(emitted_offsets == emitted_modules);
 	output_label("kallsyms_num_modules");
+	printf("\t.long\t%zi\n", emitted_modules);
+
+	output_label("kallsyms_objfiles");
+
+	for (i = 0; i < addrmap_num; i++) {
+		struct obj2short_elem *elem;
+		int mod_offset;
+
+		if (same_kallmodsyms_range(i))
+			continue;
+
+		/*
+		 * No corresponding objfile name: no disambiguation needed;
+		 * point at 0.
+		 */
+		elem = obj2short_get(addrmap[i].obj);
+
+		if (elem == NULL) {
+			printf("/* 0x%llx--0x%llx: %s: unambiguous */\n",
+			       addrmap[i].addr, addrmap[i].end_addr,
+			       addrmap[i].obj);
+			printf("\t.long\t0x0\n");
+			emitted_objfiles++;
+			continue;
+		}
+
+		/*
+		 * Maybe the name is also used for a module: if it is, it cannot
+		 * be a multimodule.
+		 */
+
+		if (elem->mod_xref) {
+			assert(elem->mod_xref->nmods == 1);
+			mod_offset = elem->mod_xref->mod_offset;
+			printf("/* 0x%llx--0x%llx: %s: shortened as %s, references module */\n",
+			       addrmap[i].addr, addrmap[i].end_addr,
+			       addrmap[i].obj, elem->short_obj);
+		} else {
+			/*
+			 * A name only used for objfiles.  Chase down xrefs to
+			 * reuse existing entries.
+			 */
+			if (elem->short_xref)
+				elem = elem->short_xref;
+
+			mod_offset = elem->short_offset;
+			printf("/* 0x%llx--0x%llx: %s: shortened as %s */\n",
+			       addrmap[i].addr, addrmap[i].end_addr,
+			       addrmap[i].obj, elem->short_obj);
+		}
+		printf("\t.long\t0x%x\n", mod_offset);
+		emitted_objfiles++;
+	}
+	assert(emitted_offsets == emitted_objfiles);
+	output_label("kallsyms_num_objfiles");
 	printf("\t.long\t%zi\n", emitted_objfiles);
+
 	printf("\n");
 }
 #endif /* CONFIG_KALLMODSYMS */
@@ -1501,6 +2056,20 @@ static void read_modules(const char *modules_builtin)
 	 * Read linker map.
 	 */
 	read_linker_map();
+
+	/*
+	 * Now the modules are sorted out and we know their address ranges, use
+	 * the modhashes computed in optimize_obj2mod to identify any symbols
+	 * that are still ambiguous and set up the minimal representation of
+	 * their objfile name to disambiguate them.
+	 */
+	disambiguate_syms();
+
+	/*
+	 * Now we have objfile names, optimize the objfile list.
+	 */
+	optimize_objnames();
+
 }
 #else
 static void read_modules(const char *unused) {}
-- 
2.38.0.266.g481848f278

