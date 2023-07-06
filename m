Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC36F74933E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 03:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjGFBms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 21:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGFBmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:42:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E9A122;
        Wed,  5 Jul 2023 18:42:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36605H5p021669;
        Thu, 6 Jul 2023 01:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=c8GD1Dxva+lPMqbs4KMfAQ+X/lVEotfjukN/yAfD3hU=;
 b=2OXaxvHNcpkOKchuC8glx43xNB+1jgw7vevWO3MF/QCe+YpUXcs9Pks+pcGWYSuuKSMv
 DPo0k77UiQMUdlPPJ/oEc/FN1UYS/pZz+k3pGLE/bkY0/l+3PulOYmNNKbjJGjGXKh4J
 ipUEo85j0iWgcTB46KgYpHRCELTT4vmTllSt8Tvb5hwUT9utysAfFOIzKz+ndIHNTTei
 p1GpRGXjA7pb2NJIzBVpwixvU0/j3WMpZYywtIUGkMFWMHjhOwFKSD1nknWazBwl2hMp
 IhRKob7hYr6yIn256FGel9ucKz9wG+9SrvXnVAvnyW3O03nD8+44tygi5RWx09ZsLDc0 wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnf138d6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 01:42:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365NlZeh025202;
        Thu, 6 Jul 2023 01:42:37 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak6tu3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 01:42:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfNTfCLTiq5HEOnGSyz3ljNVSiVhiom1K7U5Fn8YpaCsd5WFwUsZJ9DI5HSfs1UF0mT3AOYRo7DGVLUb8DT/IXJ3/ONgTHuAwy6CXweuWmPqwLjNOq3MIg0C2Hh3pUCCwZfH25KKtYwH4Ucmz6TjIj98UzikPZOf3ZiMmqG0iuMLvV4pVSyU9kiuIwrn8eMQ9v76tiq0lVgMC9Tv2F6W+9Gk5W2p6n4wEVvCFbUpOJfJoa7QIUkU3uAoHb6YIxUcxnAlnvdRgZW/Z0C78A9PA242jNkFfq+NEvboQIEekDxDkwxTYohygomV8KxL4MzIj1lsI+QNzcbTI3otRRwxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8GD1Dxva+lPMqbs4KMfAQ+X/lVEotfjukN/yAfD3hU=;
 b=X/c83bPFkBJulR/x4VdYUCxRf8jcE/aWXHEI5U4zFzI6aRhAhVkTG9Iwa2dUZsNpkllJ24r/zfXV0s/ydDDX3cjWCX7fuCf5d6nYJfR8AurCLWWuQCP07Z9YH936ME6KX/PhYHm51Wpowyk3UtG4/bAnPDIFKDm8QCDStaPC+axiDhqvey9BGyZyosc36pWfMbT6A/pMHktLccaG+MqXzthb8sRO/iJ6YJdY+UC2B7ca3e33L0lG02aMTq1eqtsQFzNzkYJEuZjtCHZy1ESXxJqE1kYprz+ye4niSpPsFGE3Y7bSPNxiTd7mAirRtB5mjXXIt0IWwC9vyIfIJ9nQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8GD1Dxva+lPMqbs4KMfAQ+X/lVEotfjukN/yAfD3hU=;
 b=gHXULp7XrQuIQ9LkOsdAt/5CRx8KNGWSp13hC8SwSCOQuryPXI/HbxpKjpUKezuPQhwgo7Upczl/J4CV1SVvZO9R6/l7WONYDAlboSVJFpwLj4yz557Oc09dM3UTx/HZ5WqmlnMmy7Gf9VaUMz+a7EBLa8bEltLTAMDVsBZgqiM=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 01:42:34 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::9f29:328c:1592:d5bb]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::9f29:328c:1592:d5bb%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 01:42:34 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sagar Biradar <sagar.biradar@microchip.com>,
        John Garry <john.g.garry@oracle.com>,
        Gilbert Wu <gilbert.wu@microchip.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: aacraid: avoid -Warray-bounds warning
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rbtlssg.fsf@ca-mkp.ca.oracle.com>
References: <20230703114851.1194510-1-arnd@kernel.org>
Date:   Wed, 05 Jul 2023 21:42:31 -0400
In-Reply-To: <20230703114851.1194510-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Mon, 3 Jul 2023 13:48:46 +0200")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:180::22) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|CO1PR10MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 148d27e8-5821-4e9f-fe3a-08db7dc24545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6PnVHHxy3nsyD8IX1gpljMDldn8b3zQYkvEhTHTpz14Rwhnuh4594qK3HWUfZTJ3zKgWDCF0tQafruaH2WJ/R5jwb94BFN+GPfSVME2ywo6MFQqwxUmq7K72GxxpZESL0o4rUzE+G3oSzyYcicOTenYU8Pz+FxOBPC/LHVUvbHd1P4n2nBPVyEVGLdOpiI4sV6z7y2MBF4u5bml0hWz0twtLJUC567nL9VJi3pd0HSqVbXc1zpyWdPm+k9PHb0ejSbQJF3naMqSGE2NrOug7MwOdOXXuf2V4MPkRavRKSz6rBI2FnwW857cTH/GItRJ9p11hsEIXyi9Vv96fxma8otRILWMDsKqRCbSj9DZCAcvSjijIbrtdyj4qomNq5z7NRf7pWa8JUQJeJ7AWA1BT/L6Sgq+YXNKfy3+z43ScHsolNl4IPsKa61rM2tBCYVCTvsE5xbpIwbq81WwkFFYBVFaD7pMpeXtUYWbo8YnRX8sNqHznYhrTyehNrpDkal4gqATGR6Gtj7ZLBb/sHhAUCFC1YylN1bxsD6MMajwLgvmU76SKffg72e7/csUAe1S4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(6512007)(6666004)(6486002)(478600001)(54906003)(36916002)(186003)(6506007)(26005)(2906002)(6916009)(66476007)(316002)(8936002)(66556008)(8676002)(41300700001)(5660300002)(4326008)(66946007)(38100700002)(558084003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+jDIQprgDN1X9WfMCqT1izSHmBZQIlsqQXsuLDDrXINwRiQEAPDAkci4zVGF?=
 =?us-ascii?Q?yqmYnGZE+Euwwrn79No039PvbMvcEoy5+kjlTA4J2MdVRT7uBUEEs8qqD7Z/?=
 =?us-ascii?Q?j/bBwo8W981IsnvR69wL8YIjvt0Xt9j0F/+6JvzsdNTjp7E3QVNzAuUCJ1ds?=
 =?us-ascii?Q?DSBXcrIXN1Ge5SFTy+85LXi5FEYWG0/g0nR3yc/rQJvs4SvxzV+A3p+86a7E?=
 =?us-ascii?Q?/wSX+HL2ZaqbV9xA35tvcyA6hPMk0s1voKrGQChvdk4tLNdoojqycbf6WFe3?=
 =?us-ascii?Q?8a7wB+9MDPbuwT5QVHoqroYe4HzDd14MNUvwS5kg2tKTwOum6VRrfOQGZtVe?=
 =?us-ascii?Q?dzSJbbQI8BQxymBhbzA/sVUOvTOnSg4lob2NENvC+RmI6KUMCRe6P6ynQXLz?=
 =?us-ascii?Q?LlB2cHxapccXPjZXIu1O1BbsbNlAD5vO7nFGRci7i7JU/BATEbyMm04QchUe?=
 =?us-ascii?Q?fmFE59mAINomQafWDjPPe12wWv836gdrVz9Dip0jwP7Afx8awyFFHF1RBy9u?=
 =?us-ascii?Q?1MOpddvWfqVHRZPzk/ZABiBVeGGl8GJa9a66R36ilFODoZ7hFWfKLAAOOeDW?=
 =?us-ascii?Q?nQvQ15/k6vmbi6LWKT8f84dGu9jHYlZCmmNJcKujoEnBXE5mm/lzoisl2Hjg?=
 =?us-ascii?Q?1lFH8+eR+jtaULw8bxpCRo8g+llQb0ZH2Zjyl9AHz9DmpHrRAWKiVzG3nmNN?=
 =?us-ascii?Q?GIiZJwg9V9HE8wJQTIO5Wh3U+Kb85fLoXeyi3LPFIZurLtMofCZGtZt2nhcv?=
 =?us-ascii?Q?nrn+0WI63CebOZWZ0PzNS7GLlo/GRwyZETLmgF4eQ3DrTlfdI7JGga5vvevd?=
 =?us-ascii?Q?GpFu9E5/HQUm5cHgov7MQyFU6BtM6Tralpi9SQHwOpEPL5IFRopL322zHUe0?=
 =?us-ascii?Q?wIeja5RLDFmX197063Mp8O6gerog4FOgnb4cFAJPlahVBoZ+ivUiB4lSRNAg?=
 =?us-ascii?Q?ryx5LH4mP6cC2/ziq5k/iaxJy2p8sM9h3qJJlVRkL5B3GbR1E/HTMmyJLylz?=
 =?us-ascii?Q?KL1cOZb039ckPpHOjUV9QCl2ac0xw/Z2bDVOEUcIG1RsQD8yz+co7X0mO5Ec?=
 =?us-ascii?Q?lRRB6CAwkI3Fn5afMM0dqkaPQbfc0eGHkPPUhbUJIqeTBtSQSlN3doQFwl0A?=
 =?us-ascii?Q?Prf57H26eiAvHc16NCnMiKg86JahDO+BWgNXkDtXekKO3GVx4yaiwtEjje0O?=
 =?us-ascii?Q?sRFTCXvhMugTjPiUhx98+is1IrRWeOC/gKtuCdsZDneb8+ZkqWa+A6n0OAJz?=
 =?us-ascii?Q?FHeKehFMSzwcx3cYPF3b9pC1J/tOpbOPnr9OuCu/xMx1vYvZDBhUDB9W7uPk?=
 =?us-ascii?Q?J1kImcMCwAOh6bws6+8xbExq1e2ZwunKwXBqPQwLlesyKVfN7K32vClpFx5B?=
 =?us-ascii?Q?LJob+HsY10ZQSgP3kOKEN4vsnszAu5RapfYSgq39PL8lvDRTIJCC9fccX4PN?=
 =?us-ascii?Q?R9InYkrqFB8ufRNct6roVTB5819q/+fu8AIdCH8Fav4atcomX4o8BuvlWGJy?=
 =?us-ascii?Q?5bhuT/x7M77HLM+TTAnKTzELZw+CV6TTEXgMX+u3CnTvOavLEwam4N2TyjpE?=
 =?us-ascii?Q?SIKCClaYcdSyywAZHpBnSzxmbbxXONwxeBKqP+2I8R4bpgqleYafdDOxPmOL?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g3PKg6HOmSNBqSGOf9pjQz8lzwLV4ce1KvCoYRryd9EMhd8T9nf70giib5smxTUnUbv0oTYYZuY0nSN+i6R4sgsYNvS/E6jPuGqh33ZNouhXy3hQteKKGy10JJpZYmKRTqz2ksgMzf8MiWjiV0PqQHVHMbUnhlzM39TzeGGDTayto6QdvvpbbYq5H4mBFh071KtCPbxzC4qTF4dMWV9cmXCTC56roP4+KDGw+S+c2qs2bPygfX5peTee2BS0pApfRjTsvsf7sGhoGGLiW5jDjO5NPnL/+XBBaLJAlFoJpnCteuaBToRH4omthVxvtKvwyn5dBm9pMCzCOa4LERx57y3iWnEl7kHE5c6JwyVHFRdpxY4o2oAAl7WeOWqHap7Opmmc23L1+4iWsO/+K3iOi7i+3KX9JZUh2BMYMAXITbGxVrfLqgSLcsabo+1L7a0Vb84ivIhw3uuWs3AcXwhy67K2d9jf4SmdNzDhxtSUzWX/QPFcacr25LnmpW1+l5gUU/AYWhc4MmSzTJsT3NP97wKZ5w+UaKna87Z2QWjWhcrR50cxgnPN0KAAFZWiaQ5CQPUY5X378Uefx6jXpDG/T1F0/ml6Fyfh9gKoeUntle38W4u9ZfWXzIpcd9vu8UiBPI8KhUpVfGXQp8Ag1XdC7bqYzj77gJjktwM7jEBHYSTkG1pffu6a4QfKE78UVGLSmsS1S4EsPevXksOBD/zpoGB2e9xIbH7xUpEmIGCNMsMdEUjg2y1F75OsVyZsuhsg3nJ2ByQyWSwF8Dd/mUwSaY52IsFSPi4k+DZELB7LqZWs4CDCn6UW0SyIvQQjKZMsDADNUhpoiZyKe0rRPKV5B1rXrGVdMthBAC94RzhTw8sD8ZhuZAPqFLM6snQnEN8T3HozouIWvz9GAkZiQVHQpRloaCQ0fm6KJDKDmZVmjRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148d27e8-5821-4e9f-fe3a-08db7dc24545
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 01:42:34.3452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJ2AnRokyRtBQZij7THWmksJrylichFDWQvOvI+n7b+Z6U3Y3W2o2Tce1zlj4VGCYPkAYwM1gaUr2Y1f/QCbl+qWc5gTBfV/JtO9w/AgGFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=540 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060013
X-Proofpoint-GUID: f1uv4VaSoQSOjO5pRbsMqPVsGfDLcUDZ
X-Proofpoint-ORIG-GUID: f1uv4VaSoQSOjO5pRbsMqPVsGfDLcUDZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> The one-element array in aac_aifcmd is actually meant as a flexible
> array, and causes an overflow warning that can be avoided using the
> normal flex arrays:

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
