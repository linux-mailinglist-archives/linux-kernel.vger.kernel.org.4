Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C406A1E28
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBXPKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjBXPKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:10:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D3D69AD5;
        Fri, 24 Feb 2023 07:10:01 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEmscw005529;
        Fri, 24 Feb 2023 15:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=pbbk6/TKjvBf9mjEtDs/U142IASsK6WOqgpJw6lo9ro=;
 b=yYcXWkJXPJpsdVtiD/E6eTZaUsmU2/X5U+LGuoKw7/yRueyVNUTl7Nn2vLvdvRc9iU2x
 5SPAj8aBucW0wTljWBWbTjpMtcsZLywWJzGlKav/NaD2NF6a8J8TvanZXyE8FstwpIC7
 f+7ucwR2VE0XqGXyk1QPsgS5akZKzgQ4tHtaH3TTKvxt2GimC5bkrp1RBZYMoWFmLrsJ
 R3JW3xW21f8QJfOmVeTZWn8eUm/ruXDMBhIUSiJ/SEZT0uIXEawrgLCPcwc+2fYORvW8
 oL9mbiOzKbJuOgHQmoV4CAaIop4n3ZFcU9586miKi2R753jdX1SfcOgYVlqh4jR8PW43 +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntp9twefu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODb3Zg030263;
        Fri, 24 Feb 2023 15:08:59 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49kwb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntfFoPWox0XGpcvo17EBI2DOcZuPNEgO0kpJUCaiffENAcsZterOJvsN6ExsbUTzLILTh4qZBhwzm0846SrTwzqQCcPW4Fi3YsMeYWDsPZiNlzE2gRfWpzXTJl+A4ApDIGGFhPYxo+GyqPa5tXlIqqKvGL+DTjcREfgtQdS5Se8RstE4+1268HeKKnOUN+8bo0ycegpst2fu/s0mpOfQnIXRB3yRIw9hCgwG2e7WcnhoQ37FsxMYO+dF+naVgWp+lI35MmmLXz20jxZeE9E+uU/L6YiWb/Lk0ohfFuitFVWCsH1ZQGBPVctLMmStSHlIT52E9TINagaKsi8j1w65OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbbk6/TKjvBf9mjEtDs/U142IASsK6WOqgpJw6lo9ro=;
 b=HglROs2hoHH6HIG5tuAmsmSAB6/3Jl4o3y0c/NhueCP38WYg+6o8edFgtWVD1y35p95uMIoBx6pSw4tUrHTR7cUpApBGCLy3se44pyXmrWO3rLFbw06msAnKNvBuXWCDNNY6gg3BeiqGI9LH/xheGnIxhu36lMu7wJo5dTlrv40EP33GLM1iGZ+oLZUobQpMbxy2fO2Uu24/kOYvM36hcACdiU1qAssB2hU/KIbhW4lY1FVagKPMz4wnzOpSZNg55vUGKKYPCsO2uRtojaQvGDCL2B+iwXHLg+XrerMWeHRlBZOTzSnUlg97qZfnXdChl+5DnZlsyLRCmt8+lqVy6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbbk6/TKjvBf9mjEtDs/U142IASsK6WOqgpJw6lo9ro=;
 b=CdO3dWuDGa7RgeiUCqIvGSYriEhUUUeIAbgEceDftQ7qF6KaX4peFTx84qxNuG/1m/JU4XNy0+Ik6E3arkBcML2zPKVeEuQ+/KNI8Johx4Qhn+/Qpuyky7oZChqi651/7yxZYIwRLJ6zS17UTRO66xrOxZM/4n8m7r1njN6LkXM=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5303.namprd10.prod.outlook.com (2603:10b6:408:125::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:08:57 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:08:57 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 07/27] iommu/sun50i: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:07:51 +0000
Message-Id: <20230224150811.80316-8-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0257.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::19) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e3b5cb-3c7a-40e2-1a1c-08db16790d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7SF7EhS12VfINeeHSHrMtzMA4lmhYDg7ojt7L5l6RFuEXojd6gU7TJstAwLKxqMl9HAAZsdsaCqfHoddMTz3SeI+Fp6LDb7bk8ln03tnYml0Rn8C+9Ad6EIoHIIBKcgKgDcdQMSIYzUMMt0YK2Sq+0My/CpVd6vMdtN0vJC6xN2yHkmiNMI9szCHjMnrNEXHY9ocAf4XnvJnJDxM2n/Yi5FD0YtLQ2oxPnbXCDV28/XOPc+Ib8cdHvYNLnVFMvOoJ5QgUGnaTj65+WzkdeopkXZFu9mu40OMe3VwP36Kcm9LnyFz0ujUJd2GnOLe7v2pkhtrQ3Gt+xngbTQNsZyWuqPDgqo5+6L08M/7eAqHOouyy7fbCOAeth29Y0RJ5NgRf9Kf8wA/tOCQS1c652ZbQn3qc4IyL3bn+4UgFynV3yJnLBsN5WW8ytX5+tqvrfArDlRSEWv7Uu31QFYCz78vlQ8xThAdwB4cvHp8od+zUnP02xTlPoPVzMU4WtQ4PV+oJ982vTix/pnLbRu08/Ogs2/b0Ab5kGuvAGR0slip2v9XYkhy6Cd+81Up5vuE1VBsPpOEOvIm5DA0aUh6atlTLUHrc3lYjMIaW0iCmhiGp5O5M8z8rMpOFptkt8nYjF53LKpcQyTMu7F8ucfYT/OnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(36756003)(6506007)(83380400001)(2616005)(1076003)(6512007)(6666004)(186003)(8936002)(7416002)(41300700001)(6916009)(4326008)(44832011)(8676002)(5660300002)(2906002)(6486002)(478600001)(66946007)(66556008)(66476007)(54906003)(316002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nqoyoC7a7QetaiVEMoTz0TjBOBQyhgk19yHcVy2pDwyz5CeTSuEycncpvJsN?=
 =?us-ascii?Q?PGaSeTv0oqiC65PhKwW3R1WSZBmK4Qqt5ngaILuFjBgkjhMnLq/TjvTZRSO3?=
 =?us-ascii?Q?xuIzUecUsctbDvAl7YvSFTS3nj/uYGEd8dcOjQlMEa8I5O8eVUGAU4LxGvrQ?=
 =?us-ascii?Q?OLRHrZ/Ry2TR3PoZX2beoe4SPPLYpoIoMPntcZHY+QzEIRaOmMEY/DcXE2ys?=
 =?us-ascii?Q?KG6rEgx1GHMQXnghy+V60bgGei3pgnfd/aXGi03yfAabwuGyFUJ/sIzPD54U?=
 =?us-ascii?Q?TV0q8qNG9xCUO6Bhfdwo53CgdNi5KB5Vp5e5siho765Cz+04XnHal+XvyCsH?=
 =?us-ascii?Q?rd93L0UDUV8nA17mMO6YPFHFaE3VnUVPtpSAGA1O6iIaxbi3gc6MX22k2mE7?=
 =?us-ascii?Q?coKyNjXiwu0LLMNinnWh7CwzVhCTajfVGbzANpePUc0Qjbwp/uPy0Ct8p4ae?=
 =?us-ascii?Q?Q58tGb8m/XcHO29Q1rzhR/dkGfmewgle7t7KM37Kcw11LeKEaf/VWSEGkw+J?=
 =?us-ascii?Q?TCJPQkdVGDdIKkdT9W4dKFEEEKvJcfuUEfKn6rwao5X7bJAQUmEPuxyYx41T?=
 =?us-ascii?Q?Bz0+EnLJ/Y9OI/H55I0wSbTk50rYGJwchwLJrE/ds8vpaLxOxhSMHxeZTYBA?=
 =?us-ascii?Q?sK116EI26R2jLyvJ0ScCuOQo4vq7gL5TAW3bw8Dkk7fRt5roNqe9Drl+rSYy?=
 =?us-ascii?Q?0KYHj2mUfjYpJ4OB0ANTEuf8Z5nlwRKyorlZd/AXqpsQIZfNHYdPP8s3gon6?=
 =?us-ascii?Q?E1k6ydizv4F74zl+6qRrUcXBCDXnHCx6hiemXguZ2F6XRMjSqWvBWxzmcpqO?=
 =?us-ascii?Q?9NH2GGaCs6WquSWl3t70kHkWPbvNgOqVeFCTkq77/kcqUmfEjIS7owGwKvOU?=
 =?us-ascii?Q?g1jcoOI4Sxcu0N2jmNfYTyxzJQg7mrX4LM5xFjw571RIFk/maEkOEzo1fDMp?=
 =?us-ascii?Q?8WX38Qo8Zv9TRW8c0RMlLKjf6/SQg8YHlqrdsla8hlTdEw7nUkTfuYHazSMU?=
 =?us-ascii?Q?I9lDzhORzEZF+md6Kk5kefevM52sYkwZwrAVwu9QwxnEPJxBUZSilvQhdJ0m?=
 =?us-ascii?Q?CRUvP/qf/0fkTqourQFWybSAOMuysYBBDEFtI9jwYrJRUkBS9L0eNV1tIGo8?=
 =?us-ascii?Q?ni9EnwTKDf8B8fXhmLnlzCl+L1dXOc4ary8P2p8K8ykD3HYLM2asfMX9D3Fz?=
 =?us-ascii?Q?vtR+mGUmvddT0tkcBF7OxcJZUyCqLlUB3PCBzJf01dpxh90Hhw//py4mbd4c?=
 =?us-ascii?Q?1VQ2L1hKmxnStqe4s2SJWzo6OQGR/+sElChll9t9NijZGBRxZpC9PPRIDSTC?=
 =?us-ascii?Q?hgR2/yjp1ct8liv4Xa305ev0JBnbfVGDtYRIhh9PPWIDBmROd/r084lGzHtZ?=
 =?us-ascii?Q?1nAyXm/6botVxQPRoK4pBr3AbfkdtVEW8IidQa0xZd/w3nFgg3Bs++11aSs8?=
 =?us-ascii?Q?k//ffcD5ZZqLjTbm+HurNTw/CNDTiGtyOh/i71N9S6yzDHAtK4oWa9K4X3Wq?=
 =?us-ascii?Q?O4luM2pbrYNfImTHE9MybGE+P9byr5kdGoajl587R61dfFMr4/KqzyiBSyZe?=
 =?us-ascii?Q?XGp29UNbLveXyDU3k4BZn/PO4bh1XpL9EM9oD1IKlTWahUIFOnUPnf6QpPG+?=
 =?us-ascii?Q?1TgAgr/6iKpyRqK1uBXEMDU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Dtn2ilCyZ6Hp9ZRDR7V6MZ5ffKGpdF9ixjmEQFM2RgaF9k3ZQYbt2TYpyPzH?=
 =?us-ascii?Q?76IEtrBLSIjCuUKx0KDJHG/RfiAgukWSo9qYqimXHP60TzIvD12AgZT52/Oy?=
 =?us-ascii?Q?k+MiR7XvioKrFQUz+zn0/KpTRnxneix+2QHy24Kaw3RrNUaxNC6MMOlyfkHd?=
 =?us-ascii?Q?+SPQ3DIefRLsj0L6lhMLkP3s+Ewa0DiqoNWiP8manCO+6p8rbTSxfBot7nLK?=
 =?us-ascii?Q?7GwLvEs28YkxHF6kva0bsOAJa56vfgReq7X4sDEkYn3E1y7RUx1YnHv/+LgQ?=
 =?us-ascii?Q?YtSSqFQIgBYAochk+EteY90J/XadJPh6nDMDSMzSZxmisZE6/kzzpS9jHwOg?=
 =?us-ascii?Q?zqou4yexAjBH8o34kc41B7/U8ZrCiurivM7sLeGWtSNL+vNIBUUFkmgbVTtE?=
 =?us-ascii?Q?BIiKCcuBm6ElugY4dDVxsR5ik8+8fZcVVJw2BSqXANK+V1F5FxvgdsYHg/Y5?=
 =?us-ascii?Q?+5vAHVn4F9U1zITpeeljXzq0yL3h5dyqLQ0AZyansNvWqTgqtTGzatgIWryO?=
 =?us-ascii?Q?aJmmj6jB8hw3wPdb46A/B4TUbArnYBgJuc9YbnHCQ1lQWNQMugRmh1V/bSyN?=
 =?us-ascii?Q?3MR3on9ymiORTvytpJm+NQjhCffeBkZXK/zaGNmCl3qKqFUipGG9X48dkgBH?=
 =?us-ascii?Q?xCRrvI/EV/P0xHluW9m4xWXhaOMTtSW0FbgMcx2shxVnXWL2a3Rp3KFtVJW/?=
 =?us-ascii?Q?b4CXuUZwomZXC0cIK3RntaClFzYsrxFZqG7kqqUPjzJqZL1gtzX+UOTVELaw?=
 =?us-ascii?Q?EKnf6LLo3kw39F81g/Wel5tGlsMtTl2Tn+/N4G6uC/2PvuAkJdiNo0pr4cIv?=
 =?us-ascii?Q?A663j7yqUVHMKi0LixNVkKni8C0uKTpa9tBKffMfGJWPFfyS4sFfsQTCu0j3?=
 =?us-ascii?Q?WaivmMa1FTs/6UZhq/cyVX4jSztawEf04tNZGw0hGjg27+nLqX9yFFCKq+NZ?=
 =?us-ascii?Q?6rxeXrJx3jIyvdQKh9Evwj7XMHsDW3HFEFqP3nJ7uNyMrAgc17iQ2tUVp4y6?=
 =?us-ascii?Q?a+iUTk0g2Dbfg8TpHCt2x3PxKS23XUjowTts72KDp3P8RVLr50ymKcuDweC3?=
 =?us-ascii?Q?ymtXoRCK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e3b5cb-3c7a-40e2-1a1c-08db16790d2f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:08:57.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mixb4F6y+NwZ8XCzZvHwjFP1EKj9NFkW9Rtsl7c2PRULED2CpBsnFN6CgynDQuI2QGDrbkNYv3kQzHli6i9k5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240118
X-Proofpoint-GUID: IviPnrD6gFjqjMcmyFup4X8Y37HrtzUj
X-Proofpoint-ORIG-GUID: IviPnrD6gFjqjMcmyFup4X8Y37HrtzUj
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
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: iommu@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
---
 drivers/iommu/sun50i-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 5b585eace3d4..63ac9d15b859 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -1077,4 +1077,3 @@ builtin_platform_driver_probe(sun50i_iommu_driver, sun50i_iommu_probe);
 MODULE_DESCRIPTION("Allwinner H6 IOMMU driver");
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
 MODULE_AUTHOR("zhuxianbin <zhuxianbin@allwinnertech.com>");
-MODULE_LICENSE("Dual BSD/GPL");
-- 
2.39.1.268.g9de2f9a303

