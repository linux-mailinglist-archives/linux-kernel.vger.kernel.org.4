Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF695730CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbjFOBjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbjFOBjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:39:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A06213B;
        Wed, 14 Jun 2023 18:39:04 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EK0AeI018100;
        Thu, 15 Jun 2023 01:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=z3+jd5Wmo9QDrWquFqnAycWF0gsY8By+s150rtNpmo8=;
 b=Kg7Rcc89jDkdF4ssozuF1NeETLe4cZ2q/yub7MAGe7xF1hd01P26xbZ1vzO4ZCiZMftt
 sXHK/5+hJdJdTBRKU301ux99dSKX/nFmQtNXsyaFfCPlq4gSzlJ2LarU3YFG7M1KpsNk
 Qxbks4EFsQ2BfSae8rR0Uptap68hJEKzYyFjsCi+ihwv7ohgMfV9TM2ZyAXh6sEJdFaN
 0NUWsQYEdI/Y9Sz5Wbt+CKWoZf0hcknvp8XiuBZYNrb4n7tgnCiH51o57O7RW/J1ZhFW
 TEG+6FPi1igT/qq9kJP9h3k7OS2Jy5AdB9ieYOf/HPOoLA4K1njxXpUgcaQFbxrX7HNC Dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d8vp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:38:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35ENHB9g017707;
        Thu, 15 Jun 2023 01:38:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm61rns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:38:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJ2FDeUkvR52WUCMRFKX5kXrT45H8uPbr39vsRg+BEz9eaz+Qx6YYBFZfCwieDuQtrRV29qDFTfOCXnJOV47hEshe1tEGRNbCANG8NRcL4rhm+S4nCFAW/ropRQNWDj1ELMV9nh28E9X1Kuco8DO7+gtyQ+7PG14BM7oK8uQCSAPIy7IMMghA7jMB1Pgk/3HbRlptoWmvcQOvjzvN8w4Rdpb0AWY0Azw+TCmJNRaJ90F1u++qZ6Cng7pFs3kfm/zndzJ8Xb19tbcTxHKFykop2NA6Xuo1eMcd4lyiZbLEd9EEA5im84adXk2tVZLvPzUifzYQzaGWLqtJepMLUrHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3+jd5Wmo9QDrWquFqnAycWF0gsY8By+s150rtNpmo8=;
 b=VKGc91iPQpPEbh2yCPTvovDqA9g11ZNUSTAnTr9OPZIEhzyR8QlrhK2fTy8YLxGY4E6XUfPMwoxdlE+uS/sQp89buo8D5MH+Pm759N2PWU+axLmDY/R8Gbn4I2Jf77G/txbQhcBJIYtSKfly+lLEfEwjNPs9qUlaX6b05T8N7ul/+UTiZNudw1Tec6Wpz62LfS3LgkhKwmSMauFUG1KgvWlCalanh/tc0l/mLtkZn6Ld7/nRG2T9VURY+g0rg5oiALRGdX5hUvEtcT6Nb9QCmd0NCIZHIUAfaGab9FjvrORnbsfthhnhd1rJMHBrRuF7oFz5dSu8JMJ82V8ROCAJeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3+jd5Wmo9QDrWquFqnAycWF0gsY8By+s150rtNpmo8=;
 b=KQcaBtrw4CjafSS+Ygrg1jXF7p55ySMPVYoJ5XrbwYG3Py69pHR/GpZWFv0qQJ8ZCYruUY1FIoFf6yh4TchtEyfuZlL1j/qYYJIaQANHi/rwU7+wyRqJ4xXMXTQjoFy/xKFRmeTVLRTdSAJSk4Pbyw5w66ZjTGZ4NnIu3t4mhK8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO1PR10MB4580.namprd10.prod.outlook.com (2603:10b6:303:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 01:38:52 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 01:38:51 +0000
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <alice.chao@mediatek.com>,
        <naomi.chu@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <cc.chou@mediatek.com>, <eddie.huang@mediatek.com>
Subject: Re: [PATCH v2 0/2] ufs: mcq: Share first hwq for dev comamnd and IO
 request
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r0qdwlls.fsf@ca-mkp.ca.oracle.com>
References: <20230610021553.1213-1-powen.kao@mediatek.com>
Date:   Wed, 14 Jun 2023 21:38:45 -0400
In-Reply-To: <20230610021553.1213-1-powen.kao@mediatek.com> (Po-Wen Kao's
        message of "Sat, 10 Jun 2023 10:15:50 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0357.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CO1PR10MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c23b0f-8c9a-4df1-562e-08db6d4145dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAbQgVec909BLXMi2qa6RFUQSmGuNqEfvXyoLfX3GRJFgkbeMskDEdlSre+2tFYUcS869wOyQQJ520urCwMG4t/2eXBc3DaJIHESAeeZAUr+MNS85mWSjvYsAfUn0Y4+xPMrWOFJpPNOroHBCXXthUfPck/GOv0pS7YlJHQE0EuviiQjxnYlMvH36CcJ2Y/ILjpz6BTzpi6HGOJm0xrWjAiZK7dRDxes+IepaphHyaR9I+1dTVh7pHkyGOEBUWcL7zqM3/4G1fkLRaIDHmiaLFooT0Ed2itPICokHJTaxzphCkw/A+L6/S8Ip0tbsRHY9h2BMGqUKnfqmdnEZy/yEHq+wkEy/+nKlvias1A0DtZaR3Pe+rCQ9uZnK1tEzU5D/S9WBtsFxOkegZTSsVYQ6hkaHCWNW07rFHdL8vFdCKNVFUabXE/HlO5OUv02IncK0kCAHKTyGa2uHp/H32jZR8E1tqn/YZPLViZT8X0nhkbVIdw21y0rkZQ1DgJPZd5dl3suHyvOKZHlTDzbvmOVjXaQdOcsm/yPSOYGEMMq9jDm4ofaQ6WLfUi+MagE3Sz1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199021)(41300700001)(5660300002)(7416002)(8676002)(8936002)(2906002)(558084003)(86362001)(478600001)(186003)(6512007)(26005)(6506007)(6666004)(36916002)(6486002)(38100700002)(316002)(66946007)(66556008)(6916009)(4326008)(66476007)(83380400001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t0RFwTXAknGfsiXDYQ9ExV5o9tKkVg0Rs3+GG2djwhkfXipDYyEvG83sIQNz?=
 =?us-ascii?Q?3QQO6TIr5XeaEUBt0k42g14QZjkDkmIcBtIqACmf1kCwVmL+vhZnbxWUrX2n?=
 =?us-ascii?Q?b4LxtBbg1p25jrqTf1KdXp2MLqXs8poltRLfsRnpmpqx7h7HSm6uOHRwVM44?=
 =?us-ascii?Q?EBLoghZyISsshDqZLVfaU+KWWOVp9MTRKMg057jDu1X51BotWqHX9HJlXE/z?=
 =?us-ascii?Q?nmPm/wNJV+1JoVjhXUgbqKh2/m0U8W5pAitTHgMSENaYCMhlgWuRsS1zNf3o?=
 =?us-ascii?Q?QPUF8n+Gjv702Fa+uDWpuWrPCPHoKzjm7KW8uD9j4iIVHHEZZM8Awmnx1LY/?=
 =?us-ascii?Q?Gslz06loCplHLHy3fX3XqS+PlIogWLqttLx0SN1l1l5CiF+JWxIy19ARzs07?=
 =?us-ascii?Q?cPPfDs0+Kv5YxY/CBrDg+1H6otd6QMN5iTuBnX4lm/xO7alWkH5Xvbnna0wy?=
 =?us-ascii?Q?WPjIGEvN50Cg6AadJ0QyRxbRYhMELqy8KaYoGDPWwYygc3+n9GwDl7BmJuqA?=
 =?us-ascii?Q?lsFTxm+TZheLkoyWYOI/4nC5f4tu+A2FjJEErP16VUZvzAIOOHlmweHS7OMW?=
 =?us-ascii?Q?gLzBCpiSIy3e/PWSnPTQ2Pl3Mgo8UESFaHEHZWySi+QkfLnLyW5rqsKorv5I?=
 =?us-ascii?Q?LMsAa4uvQiS6AfdabfRTv/vnfycN2W2Npo0FimEcP++j5l88GD56E8a7KOe3?=
 =?us-ascii?Q?35qeeNKfrzt6vNSq7ER1T2tucAyYciERJhD+1yqO7vWPlAEuqDs7Sq8Fk0E8?=
 =?us-ascii?Q?RC7158wwXytGjJGZJfYP7y7FAbdYjFZtcMZZ7Kg+GnRetxgzbQNmVdYOKBu+?=
 =?us-ascii?Q?43TX7ofDU4pK15FDU728+ZBTKb/RvGkXUpmc//fCMajWkOC3+IpWIbwbzGAh?=
 =?us-ascii?Q?JZDVFsnC2pQFsBrvhyNuLjmV2DtVUMtZLLVpcR4AgpGdhOiCVCzqrV3gyRkL?=
 =?us-ascii?Q?X+G7syJp5jkL+HEWFDMNhFD0O3LwuUx3lnoMjwM3ndUfmvSTPQtg3DjH3OJO?=
 =?us-ascii?Q?ZXlaxKBIJCqmXhzcdIrzHo3qEPR1UaScPsiepGBOAz4F4TyuAo6Bpon3dCjo?=
 =?us-ascii?Q?V9lJ/hfALwastiq5KXFwgBubBJFLPHJmGh1Ip3e46+oQdshjg8TrZ9HGTBm4?=
 =?us-ascii?Q?GjJDkhY6yV5tk8v61Gt61PQa4zk71A+dc7c1woCcf2dT0+oXXq9oHEGYBtI4?=
 =?us-ascii?Q?GFoEGqNXdCe/K/OdrbHFF9UyOIb7xiaq/hfbWo3QrOKhApFDX1gq09hvdeIP?=
 =?us-ascii?Q?ftQOPbMwoYD0cyL16/OmqSiTYiUJsvfgQTapo28fgJxVGaqFQ1V4ah2S4zaB?=
 =?us-ascii?Q?9GVbwliCxyMFjZEMWsdTZTij/uR1xFcMLA/lfvxFmIGIfqfDzOT4qfbHwxxv?=
 =?us-ascii?Q?y4Y2gHzObRadyvxQnqcLhqXCjlcU6bddpR8v4KGgbWCdPNJiz3xZEdWjdHBr?=
 =?us-ascii?Q?E9P6jW3SIz3tdaM30r235/NbO0CZ6expr9+YczybKdJteDnMbNoQB3JPDtSm?=
 =?us-ascii?Q?gF7pM3Kc2AW+XDG6/MJWdOPvezCSuVp87XwRD82ZKfkiFPTZKvkO4zSa/Bz+?=
 =?us-ascii?Q?U06kojFARMlyeVu2ZSeQbbpJWT7InYh//kYM4YTfkVsxZ43cTME1x8yBAUR0?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YCUQTVJahSoNtYKzdv9STdzJhbwT+4VCsq2nhlsRaGbhoUMUonKIv4mrRbn6V44ZB7DqTzLwSCgq88fvl/dYlmNLMgS5eurI9XYAygffMCMYOctvaOjr302Y2q9H4J/cuE75WqWbM4HBWzj087Fai0i5MfuCk22G5TiX17nMf3JnFYlriD1R0zOAo7taY6mbutjZPesxettzRFXpknf1RV6HhByPfJSDIGTlX5FuFlw7TokAQLCxE4WjH+gUlXgpPebA4eht07AGd6KsyvS5AxDlVPHHOOk+UxneoWzOkb4DYami/1PE0nvD7wPpwce3lHtHzlNYeRjgrOSUh1VWJegq5pFrdHS3kLaLZFau7ZwG88FLo8L78Vl9To/C6W3+qAuxO6jD+A0qME/AGgvm/FSqfcBX1g3b8Km1gyE5Z7Ok9IhSaFqyXr8NxLlYZ/jwPqAey0vl3GGr7zEhJ2dyj6ZYqszBsGiJibB2D+fY2Ike2y0ODiyDSU+1zlC7fakeN++9hN1TTt7PoIzmkyAIRDJCgvrp/jQmo/yHCkUZ0jLSwXeudtFn/CHgcU2K9VRPte7TTsyQmAcKgSjDhLincW/T3t46cEH6tXBzIJY2dXu60+xSBiPS1UOZuzLzTqukGyzH55ZVVU5LzaI427OP8hoHu1cfEBBV9Skmmci36GZGI7l6kBiBlpgOgLNa3IzrUTl0S+8paHai+3O11Xx7BqdWBhNBtGjOdGI9cUoeHsRX3dQVxSrVge7mhZvo8vGbldG+u/h+8pqQZ16+l5prhRjc+O1q2XvP5vY9zSWby8tqqsrNe0RN/oT/mq7+ugv+Tg+CaMirMdyrkRqxS26gYnHOADSVkJiiv2oTPT6AGMVmTjpqy52jiq/RhhEtkzY/K3/EZXjhOAtNp1UcNJuMNQv2q1hC0iiMja89cnA6qWI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c23b0f-8c9a-4df1-562e-08db6d4145dc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 01:38:51.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amtkW8xyAb+bM2sOiPgUDjJ+rp403Q2RytpXN8PsYgxIgqb5Y7UY8yc3b4QNbnift0krEHU/G7yNYkV2t6OVfaTS7iDuQdV61prIde2bPyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=759 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150012
X-Proofpoint-ORIG-GUID: uwDA2cbtSoB4kKVx2rufHxXVuucJ7f0p
X-Proofpoint-GUID: uwDA2cbtSoB4kKVx2rufHxXVuucJ7f0p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Po-Wen,

> v1 -> v2:
> - Remove accidentally added ufshcd_add_command_trace() call in
>   [PATCH v1 1/2]
> - Add Test-by tag for both patch and refactor commit message

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
