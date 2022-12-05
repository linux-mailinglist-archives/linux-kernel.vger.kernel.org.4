Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89507642CF6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiLEQev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiLEQdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:33:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546FC1F9F8;
        Mon,  5 Dec 2022 08:33:33 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Fk189018570;
        Mon, 5 Dec 2022 16:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=nB/TI+yi4xJXPvGW7ZydQLZZ5QhREcsRqGfho6p6tWs=;
 b=0i4R6BxkHIUl39ciLlRZ4CtQJJcaepAjOjn1r+F3zdRBz1CNoTlThXl8HafjA1piZKF3
 ++If7x5eqoA94mUGZUG5gi9YXKKxIdyPWXqA93dULld/j8lDW7EbfGmgj7xd1TNHH/Q0
 dHDBMIDy2OFIgrS0UvXQVSAfy4Z8AY6+0zOd3Ki3KfvQOo+i5NfQ1tonienAm4BS7b44
 s3amKVS5LsjRAzLovYtjUMUlP2OWocI8mDsX/RYSg9lBHCPgmeiX8OT+mgmdVUhhuwFd
 oIh6Yd+wFOoAooxTvcyBKYFl3qgPkaEBBKEMa+UzaYCyiO3iCjh6/u+WRvMziRNmLdqS /A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yb3c9t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:33:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQu6o027839;
        Mon, 5 Dec 2022 16:33:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ua9dpwh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:33:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxROQjXjqBcffY1EUvmq8jpXrDyDaKmIymcUHecIXQ3SkwunQN0oPCjbAE1hRA/X6cWwzIpBL5rEj3l1Yhs4mPUI+jQsXH9+wIrt1eWkSOwy+0jDBYoWsutW2dVnM/0dWAqkd7BdI908mNWXTk8RiufTOR9Z1Ym41m0+rB7HaYw+7LSOJmLySd/chiUUbEshQyfXDWbmFKMk1K45AypoO19Hb7QnKWPBZNEqednYMyQmxjgJFhnc8r2Bu+XIINB25UZb+3gDZGhzuHA380/osRQqGk2uzp37fxblndaSy5Ci5+k2i4ielyzhQzCSBc7exLurtifkuzYfFoOc80eXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nB/TI+yi4xJXPvGW7ZydQLZZ5QhREcsRqGfho6p6tWs=;
 b=XWm6FjQ9O3gPBjV4ORCnNe6sq71LDO3y8OuPI6XixOzfiFLZVZ9jEvGQYTnRM1Cftv8+FbOT59p1kaGLUTGZE4cicwNqx071Q7GwZ3nDlc/NBs7Xson846y7xJD0nheDY+cT6IPhHmzEWj5/ZGGu7pccExGU0633d00GfAo9Q4ux6kHEbh4pM2im2CUO1KwX6hswiY9v5JkZuF6utOOECBrHzDloVx8uZjFWMLjQxH4hDC0e6t6eG76qA6AD9W9ALV2M04CvNJrI9VwZubfA9FutUvqk8OYwZtjtQ/hKJfrPf1eMhGy8nIJa5Uw6aOyvK3iFUHX1f/HQq5yFmoAxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nB/TI+yi4xJXPvGW7ZydQLZZ5QhREcsRqGfho6p6tWs=;
 b=ATRrdH2oAiH6surarQd9GGQeY8iUkIBN7ZeQng/uDUuysPdblf6pRvwM4iQK9WbAtgRw56RhhWYheP97qGR/vDXVV7tnDMNJ8p/5aZgcXCaAwit+X5jNTCUJwlAU7c8Nb6C4WwucQT5bAWFtyRl+v+NwOm4kOCNonAvRJsmr8xs=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB5721.namprd10.prod.outlook.com (2603:10b6:510:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 16:33:22 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:33:22 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v10 12/13] kallsyms: add /proc/kallmodsyms for text symbol disambiguation
Date:   Mon,  5 Dec 2022 16:31:56 +0000
Message-Id: <20221205163157.269335-13-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: 3419ee3b-851e-4d70-cd03-08dad6de61e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVYkKWvllfEZMe9N9bxpaIeYfe48QfQnfVtjStqi0EUR/Kcp2ns4/eO4qiC+1IEfatntqehg/Y6aWxCKnlYrSjPWcuh9uX7um1CBm3rWO0sP3Ruy4PO0V5RrzsN2/sQegOw+ag1Abfx8Vkv7iqPn/hmJmKyhnNqyLckuLB1NmmJLrqAEcCUp0wxWRH625PJGnOAN/GSF0g0+2AzsUCCblNhdreHVpNcaqCcBrV/H2R1wMX2vwkn0Z2DMRUF7/ui01H/wCLtUWvYFs/6rE5/2LM00YBrFIbeMzZxskedjNVQLARkQucaBrqCZlJKkJmAs1niGbgLYHucFxTzak/sTa6j0mhVvZCXMXMt2YcmbU3/wb6ZroOhrlQMuuzST24fIpFDZaE1Y93P4xgxd0oDR4r3Lf4JIphW/KPpwoyaRxxfuz7zZTh7Qu6pHhOhztkhpHOHckAsOllgirJZcAXWme4q0nf8pqP+2xQPJliyMxCMMSBGXckYIUshuy8wZeFL/nKz3WuMSBQ63IbuxbLaQGODqkmZCYSb3T32nY4nUfxsQquFRwtFnpozYVLtBJSKoL/ysJP8FaB3HSYABBXdmgb3srBDSWa4lZiE5qhqQd1XGJsRQz/e0wESNlYmlJRPOARcepwTzR3ziJvWe2qUfxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(316002)(6486002)(107886003)(478600001)(6666004)(6506007)(6512007)(66946007)(8676002)(4326008)(66476007)(66556008)(83380400001)(30864003)(8936002)(5660300002)(44832011)(186003)(41300700001)(2906002)(1076003)(36756003)(2616005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MLKszoSr+RIbK6UdDVzYYgTM7+oDClp7LYAXyhfuWcy29TYnCUQ6QiVht0RZ?=
 =?us-ascii?Q?ueXtSiiWE+nThPzbb9DCwNTFmfZqiRiugx3UQXU1S/1mL/6istwfTmQ5NAhQ?=
 =?us-ascii?Q?BzI9bXMGxzf+LEtGMQU4zzA7YVyjoF99+7NG4ELufKPuOa60FuUOT1W3w2iA?=
 =?us-ascii?Q?FmzFsi4wbuHjkrAKrPk7m44mEhVcCPvMkpBwRXI+xCW31E3vd9MHO+cVDKl/?=
 =?us-ascii?Q?btQ4X1jJhkG4NxQiPIvuY05POIxwpv+fIzHIpgTwNPgzSROsfqYPd8FFsngC?=
 =?us-ascii?Q?vJYfaxXs4CsnrLzyTl5mH2J8ooMVupnT2oQ3sCpvbmtE0b3Nu4Nz/MpwpaSL?=
 =?us-ascii?Q?PrqO/RE/s6HVru3QW2RSRnC97/wVo3ybo4AVHnT9cjJabF8MpRsGN0nD0Co2?=
 =?us-ascii?Q?eaxhYocCTiv4HmfROzQCSNGlJ+VF5M0j44KAU41gDVnWc8FM4wB+q2dZzD18?=
 =?us-ascii?Q?xe0Q4BlDCN9bZS0e4GWvh9IGI+1Xs8+CgXb2tvCLm/2Dg9XNM2Av6z0gp2ua?=
 =?us-ascii?Q?fOmE15xKCtA+o7sRDD/KDI+nIQf/63jWT81gs5T29eZJNLmD7P+Nvzyf4ajN?=
 =?us-ascii?Q?Qxrf4WvOZk3rLwttevJcWWzF1Xp5diM3/v6hmNE3cxtgQtNIA6BRAjWSjA4A?=
 =?us-ascii?Q?zWuF+pDcwZ2nhVW5MrRNO84z4JQHW7nXeZMZMYc54gM9eGZ96SMuN0pQb2MO?=
 =?us-ascii?Q?dkt69wPwbF4pAd5hNfvvMjL7V6YCB8mOZnpmULuTGpL/dLLogz9WHRzoIap/?=
 =?us-ascii?Q?z9yZterJVgCatYBtkCLGpy0bfgZdtrqXT+mi+epqBg8G1kUA3UT1yFTTAXmI?=
 =?us-ascii?Q?FvnspQO2lIYTF4bL6DVfKgxA8/9tcOoOgLhSxss7Qxekh6a/sg0ytXLuMXcE?=
 =?us-ascii?Q?hPLZCysTfrkN0Yes0aPOhJT9rk2DDuhPn22b5h8WZOmGL1kUZtAylMHvfE2w?=
 =?us-ascii?Q?GvMmkM1nAAT2BUqxr8SaklzW2OKIzjA3fmXHf8wkZRw09mJw5mM80lfoKAae?=
 =?us-ascii?Q?9zmyXV6pam6qvHJbiVzTKOdMCNtNX58cLEmFx3yhk4BSN1aMEUQP1DyvTEd8?=
 =?us-ascii?Q?wswaaNkEDlQj5S/NfOdGfxoiJsFIlWMY/zEmpK6/7UzItYJi5cnCw+/Do+y0?=
 =?us-ascii?Q?3jdwI45jdZCol9MrQxIf1hRCBPuhBRETsAxPH0uw5vTvx3e7AX+nBNocbl5R?=
 =?us-ascii?Q?PSNMo2pKqom54NCGGSMl6RXWJ2VdV7SgoXSKivuB4u3otvdzwo5LG504ddJF?=
 =?us-ascii?Q?JX0LGGKgbK6VrvZKxF/QLM/hzRRV0FI+1EHYxiH0H8xkKk62qSCy7QJ3ezCt?=
 =?us-ascii?Q?sMjFCeLm3rkZPt4m4UoTFuI06VaiixlrYuNLtSjd/Tv6REcPiFLVTMhuaLgM?=
 =?us-ascii?Q?c3QnP/z0lD4AEmPl8ONtaZdXxrG4IwsM9yQHGw7Y97Vpft4IN7HubYbX8Hy2?=
 =?us-ascii?Q?dEValRvoCZ9FMAiACMaUx+FEjgyS6LHppWMV8X1n9vhigaz+X09NCDYO7wSt?=
 =?us-ascii?Q?60YuO///Ewf3xkrPnLAkr7y7/rvFDuBzZrDNPRVIGngCjHiJJAbAc2kcecHa?=
 =?us-ascii?Q?WoLhimIc8kUKuDbQBPTpOj0pCal/23OVakILgXAa/R2wy5Q4td9e8jaSaCR9?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KU2wXOTn+9K8Dx4vQTlKm8uGeUNt0hR4b8TSVR/TxcScOTWQa7fermwCzaBv?=
 =?us-ascii?Q?Do6sEuyMLJx9iXhtF3ZMQuCyUp/SxrMM614UKOTpmhN+T5R+7RoewTQ8Kp2P?=
 =?us-ascii?Q?G0VFyE+888zt2MZ0fD4YkYooOHRigiR+i8Tjo9aHswNriU6ebei1vg/pu0/C?=
 =?us-ascii?Q?Ty9gLP9SGxa8TLkk7/20+hU8row/TT1+8IXt4r+Te3a6NjYlDOC5gfPRLwqf?=
 =?us-ascii?Q?hvfWFdbpYFkgfv/OYwL1t8mnP1ThyRbRoh1uAHU/xJKni+eKIonUFoU6ZUcN?=
 =?us-ascii?Q?Rh1VtD+ZajfOqY1CS7h/MTQ2QrlTywolTmVqlhw7UYEVHYyl15Alp+eSVXB8?=
 =?us-ascii?Q?muRNbm6E6yDGGANl4sGaqks6oPf0HfC6egmD4AP6njFCUQ4jjcFEsxd+nOWU?=
 =?us-ascii?Q?eZWUxnaVG17WG6OA5AuI+4vUGio6KLBGJHnPCl10B90GxyxBKZEDOnRiBpyx?=
 =?us-ascii?Q?ka+GD4JAFNtOW1Hu1KKr9+YOVqXGiDGiEJzh7QocIPjomtlKwqJU5ygObIiT?=
 =?us-ascii?Q?niwQkYuf6gyLatjQRbm98mX02szMB9NapYIv4quh6Z03r36MwK+Toadj0RG0?=
 =?us-ascii?Q?d1ogf7isCUphqZ4BSsWzknlq//wZVsLf4BQ+3ujjx+l0mmr+oBs0NBelDCrH?=
 =?us-ascii?Q?hekwfx6794OO6CdfCxw1eQ0MFUPNIESvRJwmX1FDEAbezJZ+fu90w6jSHE8J?=
 =?us-ascii?Q?3uv8XPDu818qW208NGpib29js+/7UiLjf/DOKxxrLdJVmE7UmocGCVcTkO/D?=
 =?us-ascii?Q?delsyq3uXiUJSMxJ3taj6uNRZYPiK/oPZOzebIClWuSjFFtFS1oYDuoptHy3?=
 =?us-ascii?Q?8OrESfogYhXsXwtC83zqBZXMgFOTgKKww69SAr3pNJmDB88VVNSjOufM/Rsg?=
 =?us-ascii?Q?Yl5xbE/2EfDxqDv0pl32YHvscWb+juzTvpVcwq2/fuhluMNKr+qh+p1QdE2y?=
 =?us-ascii?Q?t7CsWii3hDedJkFntGtM0C1lPpdTvjs7R0EX9NzgAjI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3419ee3b-851e-4d70-cd03-08dad6de61e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:33:04.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NsWeNgbFzBNU6RHfURm6a4dKGZe0mZrMdoKPMi94E8OTnEu++Yw+18U1S46sl++aB33BK25UqbO6hDsuQAH2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050138
X-Proofpoint-ORIG-GUID: GyqHBe2gfCzU-kVDkvS5qEDNHVX-0Ytu
X-Proofpoint-GUID: GyqHBe2gfCzU-kVDkvS5qEDNHVX-0Ytu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the tables added in the previous commits to introduce a new
/proc/kallmodsyms, in which [module names] are also given for things
that *could* have been modular had they not been built in to the kernel.
So symbols that are part of, say, ext4 are reported as [ext4] even if
ext4 happens to be buiilt in to the kernel in this configuration.

This helps disambiguate symbols with identical names when some are in
built-in modules are some are not, but if symbols are still ambiguous,
{object file names} are added as needed to disambiguate them.  The
object file names are only shown if they would prevent ambiguity, and
are minimized by chopping off as many leading path components as
possible without (symbol, module, objfile) combinations becoming
ambiguous again.  (Not every symbol with an {object file name} is
necessarily ambiguous, but at least one symbol in any such object file
would have been ambiguous if the object file was not mentioned.)

Symbols that are part of multiple modules at the same time are shown
with [multiple] [module names]: consumers will have to be ready to
handle such lines.  Also, kernel symbols for built-in modules will be
sorted by address, as usual for the core kernel, so will probably appear
interspersed with other symbols that are part of different modules and
non-modular always-built-in symbols, which, as usual, have no
square-bracketed module denotation.  This differs from /proc/kallsyms;
even though /proc/kallsyms shows the same symbols as /proc/kallmodsyms
in the same order, the only modules it names are loadable ones, which
are necessarily in single contiguous blocks and thus shown contiguously.

The result looks like this: ([...] to show where lines are omitted for
brevity):

ffffffff97606e50 t not_visible
ffffffff97606e70 T perf_msr_probe
ffffffff97606f80 t test_msr     [rapl]
ffffffff97606fa0 t __rapl_pmu_event_start       [rapl]
[...]
ffffffffa6007350 t rapl_pmu_event_stop  [rapl]
ffffffffa6007440 t rapl_pmu_event_del   [rapl]
ffffffffa6007460 t rapl_hrtimer_handle  [rapl]
ffffffffa6007500 t rapl_pmu_event_read  [rapl]
ffffffffa6007520 t rapl_pmu_event_init  [rapl]
ffffffffa6007630 t rapl_cpu_offline     [rapl]
ffffffffa6007710 t amd_pmu_event_map    {core.o}
ffffffffa6007750 t amd_pmu_add_event    {core.o}
ffffffffa6007760 t amd_put_event_constraints_f17h       {core.o}

The [rapl] notation is emitted even if rapl is built into the kernel
(but, obviously, not if it's not in the .config at all, or is in a
loadable module that is not loaded). The {core.o} is an object file
name.

Further down, we see what happens when object files are reused by
multiple modules, all of which are built in to the kernel, and some of
which have symbols that would be ambiguous without an object file name
attached in addition to the module names:

ffffffff97d7aed0 t liquidio_pcie_mmio_enabled   [liquidio]
ffffffff97d7aef0 t liquidio_pcie_resume [liquidio]
ffffffff97d7af00 t liquidio_ptp_adjtime [liquidio]
ffffffff97d7af50 t liquidio_ptp_enable  [liquidio]
ffffffff97d7af70 t liquidio_get_stats64 [liquidio]
ffffffff97d7b0f0 t liquidio_fix_features        [liquidio]
ffffffff97d7b1c0 t liquidio_get_port_parent_id  [liquidio]
[...]
ffffffff97d824c0 t lio_vf_rep_modinit   [liquidio]
ffffffff97d824f0 t lio_vf_rep_modexit   [liquidio]
ffffffff97d82520 t lio_ethtool_get_channels     [liquidio] [liquidio_vf]
ffffffff97d82600 t lio_ethtool_get_ringparam    [liquidio] [liquidio_vf]
ffffffff97d826a0 t lio_get_msglevel     [liquidio] [liquidio_vf]
ffffffff97d826c0 t lio_vf_set_msglevel  [liquidio] [liquidio_vf]
ffffffff97d826e0 t lio_get_pauseparam   [liquidio] [liquidio_vf]
ffffffff97d82710 t lio_get_ethtool_stats        [liquidio] [liquidio_vf]
ffffffff97d82e70 t lio_vf_get_ethtool_stats     [liquidio] [liquidio_vf]
[...]
ffffffff97d91a80 t cn23xx_vf_mbox_thread        [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91aa0 t cpumask_weight.constprop.0   [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91ac0 t cn23xx_vf_msix_interrupt_handler     [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91bd0 t cn23xx_vf_get_oq_ticks       [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91c00 t cn23xx_vf_ask_pf_to_do_flr   [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91c70 t cn23xx_octeon_pfvf_handshake [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91e20 t cn23xx_setup_octeon_vf_device        [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d92060 t octeon_mbox_read     [liquidio] [liquidio_vf]
ffffffff97d92230 t octeon_mbox_write    [liquidio] [liquidio_vf]
[...]
ffffffff97d946b0 t octeon_alloc_soft_command_resp       [liquidio] [liquidio_vf]
ffffffff97d947e0 t octnet_send_nic_data_pkt     [liquidio] [liquidio_vf]
ffffffff97d94820 t octnet_send_nic_ctrl_pkt     [liquidio] [liquidio_vf]
ffffffff97d94ab0 t liquidio_get_stats64 [liquidio_vf]
ffffffff97d94c10 t liquidio_fix_features        [liquidio_vf]
ffffffff97d94cd0 t wait_for_pending_requests    [liquidio_vf]

Like /proc/kallsyms, the output is driven by address, so keeps the
curious property of /proc/kallsyms that symbols may appear repeatedly
with different addresses: but now, unlike in /proc/kallsyms, we can see
that those symbols appear repeatedly because they are *different
symbols* that ultimately belong to different modules or different object
files within a module, all of which are built in to the kernel.

As with /proc/kallsyms, non-root usage produces addresses that are
all zero.

I am not wedded to the name or format of /proc/kallmodsyms, but felt it
best to split it out of /proc/kallsyms to avoid breaking existing
kallsyms parsers.

This is currently driven by a new config option, but now that
kallmodsyms data uses very little space, this option might be something
people don't want to bother with: maybe we can just control it via
CONFIG_KALLSYMS or something.

Internally, this uses a new kallsyms_builtin_module_address() almost
identical to kallsyms_sym_address() to get the address corresponding to
a given .kallsyms_modules index, and a new get_builtin_modobj_idx quite
similar to get_symbol_pos to determine the index in the
.kallsyms_modules and .kallsyms_objfiles arrays that relate to a given
address.  We save a little time by exploiting the fact that all callers
will only ever traverse this list from start to end by allowing them to
pass in the previous index returned from this function as a hint: thus
very few bsearches are actually needed.  (In theory this could change to
just walk straight down kallsyms_module_addresses/offsets and not bother
bsearching at all, but doing it this way is hardly any slower and much
more robust.)

We explicitly filter out displaying modules for non-text symbols
(perhaps this could be lifted for initialized data symbols in future).
There might be occasional incorrect module or objfile names for section
start/end symbols.

The display process is complicated a little by the weird format of the
.kallsyms_mod_objnames table: we have to look for multimodule entries
and print them as space-separated lists of module names.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v9: add objfile support.  Commit message adjustments.
    v10: Slight conflict adjustments.

 kernel/kallsyms.c          | 277 ++++++++++++++++++++++++++++++++++---
 kernel/kallsyms_internal.h |  14 ++
 2 files changed, 274 insertions(+), 17 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 83f499182c9a..5306208060a0 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -163,6 +163,25 @@ unsigned long kallsyms_sym_address(int idx)
 	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
 }
 
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long kallsyms_builtin_module_address(int idx)
+{
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		return kallsyms_module_addresses[idx];
+
+	/* values are unsigned offsets if --absolute-percpu is not in effect */
+	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
+		return kallsyms_relative_base + (u32)kallsyms_module_offsets[idx];
+
+	/* ...otherwise, positive offsets are absolute values */
+	if (kallsyms_module_offsets[idx] >= 0)
+		return kallsyms_module_offsets[idx];
+
+	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
+	return kallsyms_relative_base - 1 - kallsyms_module_offsets[idx];
+}
+#endif
+
 static bool cleanup_symbol_name(char *s)
 {
 	char *res;
@@ -385,6 +404,54 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	return low;
 }
 
+/*
+ * The caller passes in an address, and we return an index to the corresponding
+ * builtin module index in .kallsyms_modules and .kallsyms_objfiles, or
+ * (unsigned long) -1 if none match.
+ *
+ * The hint_idx, if set, is a hint as to the possible return value, to handle
+ * the common case in which consecutive runs of addresses relate to the same
+ * index.
+ */
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long get_builtin_modobj_idx(unsigned long addr, unsigned long hint_idx)
+{
+	unsigned long low, high, mid;
+
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		BUG_ON(!kallsyms_module_addresses);
+	else
+		BUG_ON(!kallsyms_module_offsets);
+
+	/*
+	 * Do a binary search on the sorted kallsyms_modules array.  The last
+	 * entry in this array indicates the end of the text section, not an
+	 * object file.
+	 */
+	low = 0;
+	high = kallsyms_num_modules - 1;
+
+	if (hint_idx > low && hint_idx < (high - 1) &&
+	    addr >= kallsyms_builtin_module_address(hint_idx) &&
+	    addr < kallsyms_builtin_module_address(hint_idx + 1))
+		return hint_idx;
+
+	if (addr >= kallsyms_builtin_module_address(low)
+	    && addr < kallsyms_builtin_module_address(high)) {
+		while (high - low > 1) {
+			mid = low + (high - low) / 2;
+			if (kallsyms_builtin_module_address(mid) <= addr)
+				low = mid;
+			else
+				high = mid;
+		}
+		return low;
+	}
+
+	return (unsigned long) -1;
+}
+#endif
+
 /*
  * Lookup an address but don't bother to find any names.
  */
@@ -656,6 +723,9 @@ struct kallsym_iter {
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
+	const char *builtin_module_names;
+	const char *builtin_objfile_name;
+	unsigned long hint_builtin_modobj_idx;
 	int exported;
 	int show_value;
 };
@@ -686,6 +756,9 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
 				     &iter->exported);
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
+
 	if (ret < 0) {
 		iter->pos_mod_end = iter->pos;
 		return 0;
@@ -705,6 +778,9 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 					 &iter->value, &iter->type,
 					 iter->name, iter->module_name,
 					 &iter->exported);
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
+
 	if (ret < 0) {
 		iter->pos_ftrace_mod_end = iter->pos;
 		return 0;
@@ -719,6 +795,8 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
 
 	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
 	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			      &iter->value, &iter->type,
 			      iter->name);
@@ -739,23 +817,74 @@ static int get_ksymbol_kprobe(struct kallsym_iter *iter)
 {
 	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
 	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
 				  &iter->value, &iter->type,
 				  iter->name) < 0 ? 0 : 1;
 }
 
 /* Returns space to next name. */
-static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
+static unsigned long get_ksymbol_core(struct kallsym_iter *iter, int kallmodsyms)
 {
 	unsigned off = iter->nameoff;
 
-	iter->module_name[0] = '\0';
+	iter->exported = 0;
 	iter->value = kallsyms_sym_address(iter->pos);
 
 	iter->type = kallsyms_get_symbol_type(off);
 
+	iter->module_name[0] = '\0';
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
+
 	off = kallsyms_expand_symbol(off, iter->name, ARRAY_SIZE(iter->name));
+#ifdef CONFIG_KALLMODSYMS
+	if (kallmodsyms) {
+		unsigned long modobj_idx = (unsigned long) -1;
+
+		if (kallsyms_module_offsets)
+			modobj_idx =
+			  get_builtin_modobj_idx(iter->value,
+						 iter->hint_builtin_modobj_idx);
 
+		/*
+		 * This is a built-in module iff the tables of built-in modules
+		 * (address->module name mappings), object files (ditto), and
+		 * module/objfile names are known, and if the address was found
+		 * there, and if the corresponding module index is nonzero, and
+		 * iff this is a text (or weak) symbol.  All other cases mean
+		 * off the end of the binary or in a non-modular range in
+		 * between one or more modules.
+		 *
+		 * The same rules are true for kallsyms_objfiles, except that
+		 * zero entries are much more common because we only record
+		 * object file names if we need them to disambiguate one or more
+		 * symbols: see scripts/kallsyms.c:disambiguate_syms.
+		 *
+		 * (Also guard against corrupt kallsyms_modules or
+		 * kallsyms_objfiles arrays pointing off the end of
+		 * kallsyms_mod_objnames.)
+		 */
+		if (kallsyms_modules != NULL && kallsyms_mod_objnames != NULL &&
+		    kallsyms_objfiles != NULL &&
+		    (iter->type == 't' || iter->type == 'T' ||
+		     iter->type == 'w' || iter->type == 'W') &&
+		    modobj_idx != (unsigned long) -1) {
+
+			if (kallsyms_modules[modobj_idx] != 0 &&
+			    kallsyms_modules[modobj_idx] < kallsyms_mod_objnames_len)
+				iter->builtin_module_names =
+					&kallsyms_mod_objnames[kallsyms_modules[modobj_idx]];
+
+			if (kallsyms_objfiles[modobj_idx] != 0 &&
+			    kallsyms_objfiles[modobj_idx] < kallsyms_mod_objnames_len)
+				iter->builtin_objfile_name =
+					&kallsyms_mod_objnames[kallsyms_objfiles[modobj_idx]];
+		}
+		iter->hint_builtin_modobj_idx = modobj_idx;
+	}
+#endif
 	return off - iter->nameoff;
 }
 
@@ -801,7 +930,7 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 }
 
 /* Returns false if pos at or past end of file. */
-static int update_iter(struct kallsym_iter *iter, loff_t pos)
+static int update_iter(struct kallsym_iter *iter, loff_t pos, int kallmodsyms)
 {
 	/* Module symbols can be accessed randomly. */
 	if (pos >= kallsyms_num_syms)
@@ -811,7 +940,7 @@ static int update_iter(struct kallsym_iter *iter, loff_t pos)
 	if (pos != iter->pos)
 		reset_iter(iter, pos);
 
-	iter->nameoff += get_ksymbol_core(iter);
+	iter->nameoff += get_ksymbol_core(iter, kallmodsyms);
 	iter->pos++;
 
 	return 1;
@@ -821,14 +950,14 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	(*pos)++;
 
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return p;
 }
 
 static void *s_start(struct seq_file *m, loff_t *pos)
 {
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return m->private;
 }
@@ -837,7 +966,7 @@ static void s_stop(struct seq_file *m, void *p)
 {
 }
 
-static int s_show(struct seq_file *m, void *p)
+static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 {
 	void *value;
 	struct kallsym_iter *iter = m->private;
@@ -848,23 +977,82 @@ static int s_show(struct seq_file *m, void *p)
 
 	value = iter->show_value ? (void *)iter->value : NULL;
 
-	if (iter->module_name[0]) {
+	/*
+	 * Real module, or built-in module and /proc/kallsyms being shown.
+	 */
+	if (iter->module_name[0] != '\0' ||
+	    (iter->builtin_module_names != NULL && kallmodsyms != 0)) {
 		char type;
 
 		/*
-		 * Label it "global" if it is exported,
-		 * "local" if not exported.
+		 * Label it "global" if it is exported, "local" if not exported.
 		 */
 		type = iter->exported ? toupper(iter->type) :
 					tolower(iter->type);
-		seq_printf(m, "%px %c %s\t[%s]\n", value,
-			   type, iter->name, iter->module_name);
-	} else
-		seq_printf(m, "%px %c %s\n", value,
+#ifdef CONFIG_KALLMODSYMS
+		if (kallmodsyms) {
+			/*
+			 * /proc/kallmodsyms, built as a module.
+			 */
+			if (iter->builtin_module_names == NULL)
+				seq_printf(m, "%px %c %s\t[%s]", value,
+					   type, iter->name,
+					   iter->module_name);
+			/*
+			 * /proc/kallmodsyms, single-module symbol.
+			 */
+			else if (*iter->builtin_module_names != '\0')
+				seq_printf(m, "%px %c %s\t[%s]", value,
+					   type, iter->name,
+					   iter->builtin_module_names);
+			/*
+			 * /proc/kallmodsyms, multimodule symbol.  Formatted
+			 * as \0MODULE_COUNTmodule-1\0module-2\0, where
+			 * MODULE_COUNT is a single byte, 2 or higher.
+			 */
+			else {
+				size_t i = *(char *)(iter->builtin_module_names + 1);
+				const char *walk = iter->builtin_module_names + 2;
+
+				seq_printf(m, "%px %c %s\t[%s]", value,
+					   type, iter->name, walk);
+
+                                while (--i > 0) {
+					walk += strlen(walk) + 1;
+					seq_printf(m, " [%s]", walk);
+				}
+			}
+			/*
+			 * Possibly there is an objfile name too, if needed to
+			 * disambiguate at least one symbol.
+			 */
+			if (iter->builtin_objfile_name)
+				seq_printf(m, " {%s.o}", iter->builtin_objfile_name);
+
+			seq_printf(m, "\n");
+		} else				/* !kallmodsyms */
+#endif /* CONFIG_KALLMODSYMS */
+			seq_printf(m, "%px %c %s\t[%s]\n", value,
+				   type, iter->name, iter->module_name);
+	} else {
+		seq_printf(m, "%px %c %s", value,
 			   iter->type, iter->name);
+#ifdef CONFIG_KALLMODSYMS
+		if (kallmodsyms) {
+			if (iter->builtin_objfile_name)
+				seq_printf(m, "\t{%s.o}", iter->builtin_objfile_name);
+		}
+#endif /* CONFIG_KALLMODSYMS */
+		seq_printf(m, "\n");
+	}
 	return 0;
 }
 
+static int s_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 0);
+}
+
 static const struct seq_operations kallsyms_op = {
 	.start = s_start,
 	.next = s_next,
@@ -872,6 +1060,36 @@ static const struct seq_operations kallsyms_op = {
 	.show = s_show
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static int s_mod_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 1);
+}
+
+static void *s_mod_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	(*pos)++;
+
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return p;
+}
+
+static void *s_mod_start(struct seq_file *m, loff_t *pos)
+{
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return m->private;
+}
+
+static const struct seq_operations kallmodsyms_op = {
+	.start = s_mod_start,
+	.next = s_mod_next,
+	.stop = s_stop,
+	.show = s_mod_show
+};
+#endif
+
 #ifdef CONFIG_BPF_SYSCALL
 
 struct bpf_iter__ksym {
@@ -997,7 +1215,8 @@ bool kallsyms_show_value(const struct cred *cred)
 	}
 }
 
-static int kallsyms_open(struct inode *inode, struct file *file)
+static int kallsyms_open_internal(struct inode *inode, struct file *file,
+	const struct seq_operations *ops)
 {
 	/*
 	 * We keep iterator in m->private, since normal case is to
@@ -1005,7 +1224,7 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	 * using get_symbol_offset for every symbol.
 	 */
 	struct kallsym_iter *iter;
-	iter = __seq_open_private(file, &kallsyms_op, sizeof(*iter));
+	iter = __seq_open_private(file, ops, sizeof(*iter));
 	if (!iter)
 		return -ENOMEM;
 	reset_iter(iter, 0);
@@ -1018,6 +1237,18 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int kallsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallsyms_op);
+}
+
+#ifdef CONFIG_KALLMODSYMS
+static int kallmodsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallmodsyms_op);
+}
+#endif
+
 #ifdef	CONFIG_KGDB_KDB
 const char *kdb_walk_kallsyms(loff_t *pos)
 {
@@ -1028,7 +1259,7 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 		reset_iter(&kdb_walk_kallsyms_iter, 0);
 	}
 	while (1) {
-		if (!update_iter(&kdb_walk_kallsyms_iter, *pos))
+		if (!update_iter(&kdb_walk_kallsyms_iter, *pos, 0))
 			return NULL;
 		++*pos;
 		/* Some debugging symbols have no name.  Ignore them. */
@@ -1045,9 +1276,21 @@ static const struct proc_ops kallsyms_proc_ops = {
 	.proc_release	= seq_release_private,
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static const struct proc_ops kallmodsyms_proc_ops = {
+	.proc_open	= kallmodsyms_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= seq_release_private,
+};
+#endif
+
 static int __init kallsyms_init(void)
 {
 	proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
+#ifdef CONFIG_KALLMODSYMS
+	proc_create("kallmodsyms", 0444, NULL, &kallmodsyms_proc_ops);
+#endif
 	return 0;
 }
 device_initcall(kallsyms_init);
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 27fabdcc40f5..91534a75c996 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -22,8 +22,22 @@ __section(".rodata") __attribute__((weak));
 extern const unsigned long kallsyms_relative_base
 __section(".rodata") __attribute__((weak));
 
+extern const unsigned long kallsyms_num_modules
+__section(".rodata") __attribute__((weak));
+
+extern const unsigned long kallsyms_num_objfiles
+__section(".rodata") __attribute__((weak));
+
+extern const unsigned long kallsyms_mod_objnames_len
+__section(".rodata") __attribute__((weak));
+
 extern const char kallsyms_token_table[] __weak;
 extern const u16 kallsyms_token_index[] __weak;
+extern const unsigned long kallsyms_module_addresses[] __weak;
+extern const int kallsyms_module_offsets[] __weak;
+extern const u32 kallsyms_modules[] __weak;
+extern const u32 kallsyms_objfiles[] __weak;
+extern const char kallsyms_mod_objnames[] __weak;
 
 extern const unsigned int kallsyms_markers[] __weak;
 extern const u8 kallsyms_seqs_of_names[] __weak;
-- 
2.38.0.266.g481848f278

