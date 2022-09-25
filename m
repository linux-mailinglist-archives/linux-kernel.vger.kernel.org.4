Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5115E9530
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 20:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiIYSDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 14:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiIYSDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 14:03:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0109E28E03;
        Sun, 25 Sep 2022 11:03:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28P9RIiu027704;
        Sun, 25 Sep 2022 18:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=4h2f2w+z87ag5Cpeke6NS8biH2p7ejC+/j3TYX28PXk=;
 b=gqAbeQy7BFyx9AQPzxZcHV/gFlNiqSZsy4/Nqdxe3qIW8vuv+pLfApMkfCOoh8TljfBS
 KEipQA1nvazaCFuahziCblkHEfTR8pFHHKcQhArJCvk0RqOHvZQxhYl45Bzc78+dBmGS
 1rmyRTQBp5FSYtiM5OlDyfVfH7N/6oUqSwVJQ0r5pymiaD686G+ohJsf4Cdj4coL5AFR
 FFjPnczK1Asc1Rbu7GlZb1Niga2fquLgdlKhvNJcnVJUlGBU4aM9EUhoyh4MlEBZByI8
 b26Gl2R6svKIx/B81qkKAx1FMxlJ0pbuZbg6ydvWZeX6q7ecw/171p3lSEosib3X7N/2 kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrwa0rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 18:03:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28PCGeCv020505;
        Sun, 25 Sep 2022 18:03:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpu841ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Sep 2022 18:03:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fet26Ks/mBbLVkFbzTpOqZ2hKRX4KHAR2CZQqo3/dQ6uAU7rdsYLTD/tBErmGfWLv+2MuLEER1YXqObdLHIOvW3rxMCmdUPY0NSfzjrdbb4orbRDWv8ZkzcwOq5gZlrQ9tNTSIYrmKgTAnywPCOmcpaVh99EmW+n+Kqr0ups3goon/rJ+PYqVlSGYq3qLR7q7B6IzsEuQJVOIxByjK8JX2odx/dSPZqrPpfbjo6JXxWAKaKJhoOoMu6cu+LMq74lUkEnFTsa+4f2cfVpln7lIzSLSF0zBGYeR/mpSrkF1fdoRhNothX4kcGEQ0i/Hp1OdA6RbRJX36AZQqWgXriokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h2f2w+z87ag5Cpeke6NS8biH2p7ejC+/j3TYX28PXk=;
 b=gB/Y5ntB5QJCXKzPXjkm/7y3pNsr6eXFWvxDBUDhmNYw0hqDBLC2NCApck+rwBbxEi83M+DbAMHFK6NulYurFXS4/Kni6qa4S6GpzvnJlUCHPKa/SIlMX0udnIlpZsgul5C0JfZcs/lZE3gDimipMgdF67a3tVFTg8OcS8ACHmRJ1s1qXJqbKpZjAfI14UVEesHieig0wJryvM6gOEJUy6FoeVQ0sw0jVVqlxkdw9Tsr6Md1wfb91pFAvQXKRcr5xpTlyLFDvbTA7Ul/bcDrGcrURHVUVSGopNZUQv79yiBoh26ZFZFmUUQGeKSOqr6sNcunSFb270S6Kk4kZPbhFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h2f2w+z87ag5Cpeke6NS8biH2p7ejC+/j3TYX28PXk=;
 b=H61v1g3/0fk60Rw6qXxtmO103ZbWXE0KX9wph5iocCfyykeeu6JGQgns294wvHAQv8WqT/v4x5q+sSKtq+bTkqBAwSXsEVz8bPyv7PAfWhwl+TttwJMCWLy/N+8FcrD8a40O3desjYYEYAM1ypc/IIs7PAAuISmi7BNkzmwFjCI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4463.namprd10.prod.outlook.com (2603:10b6:a03:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sun, 25 Sep
 2022 18:02:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%5]) with mapi id 15.20.5654.020; Sun, 25 Sep 2022
 18:02:54 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>
Subject: Re: [PATCH v4 0/7] libsas and drivers: NCQ error handling
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a66npc3b.fsf@ca-mkp.ca.oracle.com>
References: <1663840018-50161-1-git-send-email-john.garry@huawei.com>
Date:   Sun, 25 Sep 2022 14:02:52 -0400
In-Reply-To: <1663840018-50161-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 22 Sep 2022 17:46:51 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0014.namprd12.prod.outlook.com
 (2603:10b6:806:6f::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 422ccf6e-5f77-4d5d-ef06-08da9f202bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OF50K7OkQ+C+N1aRFWcGJC/uTaEsByyXJq6SYz/61FQWM9h25/ezksVQ/1CA6fQs31YtHTs/OLfvhhu8Ile9JDJftTACR6ulngmmXIhl2kvMC7ahwT7dG2dNVP8oWguwwC3TA1yaVQ6/s9XBhpBozo8AQEmb2kIQihZOektNhAz38izhLPxdjrXJ/3EJlqqyCIKbBRlqTfJBHOq+Bek6HwwYBy6MFipfAy70e0Y7238ODNd3L7wjaQuyCYCdUmH9elAn4SQqPlwRljIf2NkqWTcYMEUvdYpkmF/mkayWZGULPlD0k4RMuE9N3VpIKCmnlKHqdQjaW+OFi7zK+Va+Qpel1OMtwp6jvYId2q8zNW80H6Xua4xU5kWKwW79u/AneVSGkdgv6iRf4uP+AvJm2iae8LhInhNNQRp/XLxP7uBE7is71bzzx3eMMHjSyWzGuDUAW+g/FOYXgODRjHHM6sV64iiwO+2PylRr+MQswZ4R2pcGsbi/arRg1DQF3O5Zm37r1URe57w9UWHqAN7fVgbMKvC7It3apQ4hA4f/LYFD9Uxi2y9fNO3vc6dNhWUb46+xoc4pSngiTvb3LJ6iCGRUEUd7dP+5D1FgX21qf3s8Np0Q6EXSJBRJN0/QTcfdKjqN7J7PpPHnG1ACMREibSULto2ttwb3JbdW88+BLWdTjZfHuOjOQubPPJicZCC6DXhs5JcsBur/Hj9RlWw7+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199015)(38100700002)(6512007)(41300700001)(26005)(36916002)(6506007)(186003)(4326008)(8676002)(54906003)(6486002)(478600001)(6916009)(316002)(66946007)(66556008)(66476007)(8936002)(5660300002)(86362001)(2906002)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xH6VO5z90lFPIFqEPr/HxCYTV1LtVlLIaRLnIG0p3HfHTFsUyggBVhq+Xoub?=
 =?us-ascii?Q?h2bVpBvJTG0V5/3lDPMOA1yDJncNAP7+TkrKco0DmHOeHwXPbnZYK+wWtFPX?=
 =?us-ascii?Q?eWvpMWN6cYCWm/fwiCRTI+oX6ubwJlCYHLvXl2MfPAUimid3wAYrbtD5PhIT?=
 =?us-ascii?Q?vsdlIH8NvhSyEQDagaOF/7rnNtIx18EnPQazUQe6dL1Tc28RB4kLgAbmf+u+?=
 =?us-ascii?Q?cCBSxJLWTRBlEzqZseUOFEKlE9ocYuU2srKNSAKiU1SxWBhyXNFm++crRzbw?=
 =?us-ascii?Q?EViIF9G+oTxoNnUFWBoEacDrDBpHzauy6jAugJV7QdanaraG3/p+gur8wAds?=
 =?us-ascii?Q?z8pFIhD3aoW0IVc8ldDMbGRN7v8NB3vN+vWeBYi6xEAaAhQIvbhcFphEUpPD?=
 =?us-ascii?Q?hSGGYzp0jczKmSVEuxf+yH/RV7387wvYbKwtx8YVzGH0ph7MrPRSEhXMErU9?=
 =?us-ascii?Q?75Ma1IG5k33ijRLHskb9iBbOevVFHZ7+piYYjvdEz5xCXQOxLUghb49VlaQS?=
 =?us-ascii?Q?hNq2F31d5ZGygpvJyIwyCvCJl8+/zYKJC+VuoYX1aS4Iy9Lc76ROcI76VtKc?=
 =?us-ascii?Q?ZQwTVIdNbBMXIyv0spYe2UEJlhIFTsYJ4SVUymXwImGk5TMTs7oEOdNYNdhL?=
 =?us-ascii?Q?AalZrkQedcUzpl9YzWfxrxjqr+xLAFetrmzjPQzD5YKn3z0iqk1SFpqh7KZC?=
 =?us-ascii?Q?7fGym1n1vo9B9n4FRIW3SlhJEITwMJLw63LMt9PWDj4MyjQ7TqWKh+US9zSz?=
 =?us-ascii?Q?9mOuKmLIo5Jes++ZgW+Fpt8fjgcpyzyBxcxkeaAEvkm1N0+XxVdYnTmhW8oW?=
 =?us-ascii?Q?vPd4Vzz9URFp1fpgieQTCW33AQpGzLVkzfukNYi5QovmldHHpVbRgx7NsFeN?=
 =?us-ascii?Q?pGnxLoHUPQjTX4oKPCmI6/VFysw2mepMgkgVY4katgtTCSWQd3+hIElvlWbV?=
 =?us-ascii?Q?U2hwKP/gv0a5t9Trsjo6UehGYzc9Zx0AT55cVwK1c237FgqBDQfzrQgbTxCq?=
 =?us-ascii?Q?0KY1kwkYXLOPpUefsYHiCXxdcnZZRXAiEKe1L1voxsHPti0k/XAiBFO+/qTj?=
 =?us-ascii?Q?GvYUwdnpYXUsD7mv6AlFijG2a7iYG8K81kVjCSDjnI+UQNfMn03KECdXnlEy?=
 =?us-ascii?Q?S2w4S2qEz8pUvyaoxxK8pCI2J6md1ni0vp4/r12sYeqme7D+pjRT+Zomuwo1?=
 =?us-ascii?Q?OFDVdEHtqioDUY3ybYcRlCxJ9CfvrfZCGDva5o+GNR1FJt1v7gl1tJTqahL1?=
 =?us-ascii?Q?cA8WtCPzqknTA+AADY0QwhO4f3hFQO+oC/mxmDSGwCk40I/nRS1oqxpgkKJ+?=
 =?us-ascii?Q?M0m/Qs7O2oDBAVuPsz66Dn7iuFkL/68ce/XqlZTQl6BqnSrWOnr96SvYJidC?=
 =?us-ascii?Q?JmNOrllsAOrxnmtA8JzHAw7Lat0UMclX+142G0WTmwxlkMwSf/N+Yi1WHja/?=
 =?us-ascii?Q?6RxN6jYgbtygBIpPRa0xNzHpIcN8vh3/NiOXWcMm17shNmTxZo+sh3yRkUa7?=
 =?us-ascii?Q?QahVZ8oBgTN3ssSadTG837fuPBUUDTywZKuLy4IPc98DOdgF1pNKnct/uxTU?=
 =?us-ascii?Q?/gQoETrA8Eqx6VNsUuudddGNIJflERHDpSEVJiOyg8p5nqJsgCsfZj9vmxHR?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422ccf6e-5f77-4d5d-ef06-08da9f202bad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2022 18:02:54.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOasTHvsh5+8NKURHS43RATiVqYEKj/RJZ7RN7NbD6DUNULLQUrk0ftefZBzCAg4eyL9eNvUZvPJhDKG4N/u9OJb2h6yCQziOUiZ65e6ZqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4463
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-25_01,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=933 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209250132
X-Proofpoint-ORIG-GUID: GY-RmnW0DK7C4mVK70qxWMFqXr4-3U5S
X-Proofpoint-GUID: GY-RmnW0DK7C4mVK70qxWMFqXr4-3U5S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi John!

> Based on mkp-scsi @ 6.1/scsi-staging 7f615c1b5986 ("scsi:
> scsi_transport_fc: Use %u for dev_loss_tmo")

Can you please rebase on top of the latest staging? There are a couple
of pm8001 conflicts.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
