Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE386A2315
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjBXUP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBXUP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:15:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53C31B2D6;
        Fri, 24 Feb 2023 12:15:25 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEoAeA008499;
        Fri, 24 Feb 2023 15:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=MGl4RSJiWlJzRgpVI595JOFNc04yw6U1cud/BgTdOxc=;
 b=mKc37L3ni8LK3ydi+W4Ph0dSHr+2TOsN/XMEQtxNlRFR2cF6hUl96xdUDNMNJmjODH2R
 hEyt6Z5ontGIqCdw/pdDd1MKPsVQey5iKK2OndgSlbny5hBl8BeSI6WHLw9hEpxDIe3V
 VEKfplhP4NkH1aDz6UqHRsTaSasxt7LVSUtyJq/TG9fC23f7rG3BG61/jAC0tU52uGZR
 g4xD6WCMEWa54QfSQQ4nosT6eHsbw/ELemgKSuhLHwZYJyglD7yv3FDwBC49XTsYBaen
 zT1kRFJcOG4Kxyvh4b1lKMtJPKkZUtVJzXt4sgI2hdaExBvSdby5qu1cl9IJeURSb1XU Sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnkbw72u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODmmuC030302;
        Fri, 24 Feb 2023 15:09:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49kx2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5G962tct5zn0gau38y4oVRswkak15tmoJbfTBTIbOt0VAJBN0V1F4Sq6BHwNv7uHsmpoV36x/YCcbsL+giv5YKqwUf4wXJopwW63OZIDuymewxYDZg4GkXMeYdEBRl9SRYrHKTvdgIt0P4lN0YTgZDRW05rZgCY14J0RoZDH+2xiyeM9ewata7CRT4Q0XIXqbEVtQQTubY0R6PuIxVj9USuiLQYfwECJ3tVOvd9GuuW+bHBNHbaQDf1ocFZPvxOFgaqRLBxUoVmLjgci1/2EVjKhhscYnINCMwDxCT9dsCoHrA+8qecY7MwG6uc57bIz82lAR3YkVBtAqh0CkesJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGl4RSJiWlJzRgpVI595JOFNc04yw6U1cud/BgTdOxc=;
 b=d7kg0vmZ20wak1sxkubtfhnDESw3nGle5u1W+vev66PzgevfZV8Q5YXhNK+xJKPh0CInbaNlQkMQhgSLcPeMTJL3Di5hlFrt6ElwEKS2L0QtTrmB48rf6eSeF59FV+ntH1v9UHEL0kq1OfTN9OI8gBlk3UZngnKMOGePUaSSozEK4uqIwI7busLHO//siYH1MeVQB7fXd0sT9NaM3HUPfFoxI5aGtMe+Ikq1cvRn4I2Zvue/N7NNiHpZs7tIGISrJ/9fZSB1lW5Xvk3sWBBlXUyzs+ZFjlWucDsTNoMGr3SHe6e8dAVxc02d/vu/1kyOJnVPR8tqC1IuPTLpVRIpVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGl4RSJiWlJzRgpVI595JOFNc04yw6U1cud/BgTdOxc=;
 b=CpSyELF4zJ4sEvDOaVcemc0DFk9FJ6bKsgXnG22khwKPhqQZG1/cIA+11lrgc3ptj9w+ytz/4DirB8SnhSuwKJUkoeK7MxfC7xroiQLohgKtfEjKCbdm8s30BeyPiSklVtTE6g6pp6nNok2gLg0RDDUwNZRUJswl/sArTTxLXQA=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5610.namprd10.prod.outlook.com (2603:10b6:510:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:09:33 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:09:33 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 15/27] memory: tegra: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:07:59 +0000
Message-Id: <20230224150811.80316-16-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::6) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: a4886d32-9795-4b54-9f0e-08db167922e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7BVW7xxzl2aj6CV486icERbi0AI0j/7Dbw9AVwFGYol36TlzigjtZGPYSrTwPbAyVg+X6zy3foD8HnvEWs7l70O0oXytXguRybtKRxt7gTFyzrNUVGhblzw/yGo367Scx21xdWx8sFVV3nlSeIfK8v41jopRLYCYi5IUJOaRj1n4V1cKJ4Ae7W2B7yR0pq4c7MZUS3qEi73NCWiPVSiHGWkI4UlsrYldhR+gmWqo/YWOmrqeX/pKgNOoJuY8nbSxzOQ6byWIYIxGuz+N/21Jcb76h7FrvQdXsCYWsZi5BPiV9ykkg8Uc0P5KCsHcXbFKj1aeCRD/qxesmrfI+aajgH+E9NJyT39GNJqxP1HFlD4tgXARgEwpmgGoEmTLsGeoDM1ufRS+0Q6HLMtJXllg3WU8TwUDK01eqNtTm5JUFMZ7t08fI95wkQTU9pz1rBqvxjpbu7dC3G3My7sjvY4LxhVAcijkIhrSRJs47M1RroYt7lIe/GKUZ37TujNemsV4+o21XwoKN/DuZR3E86zkPJXN9un54wsdpUd+E+dj01B8oRoVkh9tc5oplLumWgu0T1ZhTEZCDtrH7CkGpXu8T8DrhlaHRiL3h6o+LLj/zQ13wZqxhTGP7PWkyX66fM/e5PQavAYGi1SJYey/JvOCHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199018)(6486002)(86362001)(38100700002)(83380400001)(6512007)(6506007)(1076003)(6666004)(36756003)(186003)(2616005)(5660300002)(54906003)(478600001)(44832011)(8936002)(316002)(41300700001)(6916009)(8676002)(66476007)(66946007)(66556008)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dPEUpwTjT6mSVyE1M2U3ZzHXA6WxkvB1sWkblwra0GxgcM6iLi6rVHlx+NBk?=
 =?us-ascii?Q?L5hgCSr9RHDpJBvJT0FDILEjz5kAvOqEB3v6cNYmDutzP6i0mim7v7mTQRTp?=
 =?us-ascii?Q?BOzdoeO0qH+PrQ2ufbtvBN2nvunJPYjvyFH0czYkv20Vh0JjSB3SUJkfB1yC?=
 =?us-ascii?Q?DDeadJrq9YsGmBc5F5/Le+qBiWWqQhVb/Y7+0QwGpl0/sB//+wtSfUZO012U?=
 =?us-ascii?Q?UiJxLnihT/OuTtrM2Zcgt+Xl4vRH49G9ibeKaLd3QhrPiKZu8CtOyBOjPTsZ?=
 =?us-ascii?Q?3DRPjjDVYd66LypFZwx7cpVJTC2fI/CMz1M1JtKclHjtL5P8DA1yl+4ba3jl?=
 =?us-ascii?Q?H5qSL/ZdWhcQNAlVhNZfo/eCdmFCVs0pqjFwGcymBxUtS6AzZ71nGqeEzdU2?=
 =?us-ascii?Q?oJ9S7mbTysSdFHCQVI0Ee//ZAmLInSb7V1K0Da0F/jZsqtOng8JYttp+nuSA?=
 =?us-ascii?Q?0iloUG8xsKPiX4Yi3is6AA3nLreAT3yC4UIwxWkbhrTGcmCw9Y5hHh1UWqvi?=
 =?us-ascii?Q?y1xrg9QUBufXbEvQ+QebMfJKYrrfBZYBBFVf1GjlFDZPB0iy+O/PlO5h4IL1?=
 =?us-ascii?Q?k1kg2J5IpC9MCt5QZxjyb701CS5uNHs23VMNb1yLr/PqY35LLTJwreLypUJX?=
 =?us-ascii?Q?eVTa/CbPNIclTeoe6cjM1vwccOjWSmliaAua6qPgpG2KnkxxXPYV0QmiRVwu?=
 =?us-ascii?Q?gSwFs+mB8GQiQaya83IVYGUSthW+QM5uRwx0BszEGnQTr8CDKu2+QvKMOftm?=
 =?us-ascii?Q?Yw1PsHM+BMWByAnt6w+9A/PC4Pe0+YtgTav/C/276GotPbOps1UT2hku0wrP?=
 =?us-ascii?Q?k/SfVzSuPI+kJwHc+HXRLrHiB8UViHTqQjtdzNYeCHRRs/f42NWh2NQMe2zy?=
 =?us-ascii?Q?uqxhLTT2Ec+W4xv5yhc0sMbXtemBA49vtgTDouCPV+XhO+xS7VDmV4VNgK3S?=
 =?us-ascii?Q?x3qNyrqBhVMmqq6P8oGsyKUKxPzIlHL4VuJySaM2nzGObufa3TzZQPxrMW4H?=
 =?us-ascii?Q?lp9Yd/iZz211I6kUpFjLJhwcSbfLR9fV0Dy7w8qqDSr7ApMhgE1OxomAs37y?=
 =?us-ascii?Q?9vXZYabeHpLhjN0C+C3/Aj96kx7ab0BmqxLj8OtLNGN5YzASDHU11d9GtGK6?=
 =?us-ascii?Q?mNAQEpwQ+gTCJy95RgClyPdQGW75RXYXDCHq388KnSTi676yOOwWhtG8d3xI?=
 =?us-ascii?Q?IjyVEf9uKea91HE970vNPJ57NA6Q+ELrEfUThaeftKeD0MSvPmM1aVPu41DF?=
 =?us-ascii?Q?qM5fJChaRDnfEIClheUhV9Y2leCt/rxWK53urZiXdL0IxW6JDw+06X8PxpOU?=
 =?us-ascii?Q?vIaOQENTrk52kOujF/QTblxOm3TBMNSappru+GPhoHOqGvblVtRSDGx5HdUa?=
 =?us-ascii?Q?mXGhsJGiOlamYOE7ddA1leTMfOLdX7K6p0NHU7WZIkIPS/zOY+hCYfKWPsPO?=
 =?us-ascii?Q?HCAdICR8fkE9u/7ykGqhq7pDgIIsfWI0VTSv8xdeVRvBqpCyQS52eBHTHphT?=
 =?us-ascii?Q?8y2cWwxmhWiSu/d7YjwK1FyK/OlG85SGDhOMgJupMlg1rUmnkTBqM/mV53/y?=
 =?us-ascii?Q?GubAbhfgcSTIdKhodo60kaFa2HWZvl+9Nb7/OWuV/CAugbdI9oDwTbcPJpbJ?=
 =?us-ascii?Q?Q4tZUriVNAEqgEnckK0dh5E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1ZI5qXmrZ9DA7Vq/P0gpVd9nqfFCNmYnW3aKDE5QfTKaTWTjDdaJQrLSazmHy25ZkKENVjrb6WBhbGqDTl5S5N7kv7kku9y6hGs+xRau0X6lC7eVj9CSSvnWNvG0qP5TVegTpyu8gjBIbdMii6+xZYw5chpS7bPKJXrQExT+1kC0Xm5uo36cvpypu29t63v1CSG8zqHt+dzWAXXeUfGjcWbm0sQLk3/tOulKCpyOzWqTgm2ARqvnOGnSduhoijOYW9Q4Zyrwv+JIxWVMh81KhIcMWlm817Tm+h+/WhM1OBGo0yB8CA1G+msCvUTBLj57SfRn0bow9JJ8/7stVdwEQUMX8qzH/CEmILU36/BQqFIEjRSV4G2uJWEeMTrgG5Gdgv7A2u7HYDShvVHzfxPR8f/qOegp7TRpuqp3eQzR5izJ3y/GOL2DPIOurJnaR4QdZilveD50beIxAyEptDmYq+TeWiIT95OWDeTzD2OhYN4FYVGtLhFhlldn1deWBYbulFZZYj3yO/ctrQpuNh6RVvR7Mvr2BDjUtfT3zArKnSIHUVTlTH5W+cEpKkZUnDmViThzJv+uOKBPo5D8m89eau4elZV9yQw6rxr6sg/Y4kMgR2wkuK8FQ8R2y1URGsuceLYwFHuWrCseSi3k9c916B7PVxnMCiMnJcffahA4BHfDdecbo3coWHcBSArHzgqn+WLnV4ttnhlronMvDN7PyYbtwfk06m8zmPlWo5fuFkKOj4RWMzQrMP3+JTBqokFCAvTfO13o4JzxRLTFIIm7KKnEHUEC9wbkf7s7zAICRqmc0bNLRyBcNR3UzftqOrlboaKpmuS/l317JrISY3zaHjYhjAagceT+BvP/CBp72uLgoKpMxFyH8jK3oiifMheJCkcjPYUItfSOzvT1v119zA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4886d32-9795-4b54-9f0e-08db167922e6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:09:33.6388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIsElfCF+jVNY1MOhkF3rXY+hXVxA4YXJ3lDJwdNN4QPgtXLQCwWXmzhe4Gi8UKIZgFiFEQA5fdweeU+kMY03g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240118
X-Proofpoint-GUID: jCquhhr6AzPZwWJvjb1EAzi8xg-tcyGt
X-Proofpoint-ORIG-GUID: jCquhhr6AzPZwWJvjb1EAzi8xg-tcyGt
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
---
 drivers/memory/tegra/tegra186-emc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 26e763bde92a..e935ad4e95b6 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -280,4 +280,3 @@ module_platform_driver(tegra186_emc_driver);
 
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra186 External Memory Controller driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

