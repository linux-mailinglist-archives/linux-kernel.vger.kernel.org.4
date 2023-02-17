Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA68E69AF12
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjBQPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQPJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:09:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BDC422F;
        Fri, 17 Feb 2023 07:09:37 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7iRYO005239;
        Fri, 17 Feb 2023 14:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/ahjCV/Nk8MVwdWzffjHr5S0Ar9A6NrQPB1ERYWHDac=;
 b=qUzDsmm86OkDXY0PW9Vb5rXgs667UUO0Lq4tY5V3aCgsNNQKu2PmFEJDFdF++03Meh9y
 Upe4a8bi6yFKgt2C+0KPQjpl0ePhmR7yVpvhzmNbuSr8X3TFndh9rSGjLp/x6VkIXSYo
 uyFJGfJB3Nyh/yLyagAP6r2vcVF9yGaEXH72rWZ/Tx2RxL20vFk+Rg628sPv0n96sHVT
 fdw5zCK9EpvDe/k7wnRet5V3U/L7IWJWdf2fpQ6dXC3yY7aNT+wVo4zSXNOdl/MOHIqF
 FL4WcVaG/fZzDx7m9gZz7RqmcxuSgR3HbvgAkavYUDoxJNmh6Uxl4t3cI7V5rFAkozBX EQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np3ju5yas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCt9t8022800;
        Fri, 17 Feb 2023 14:12:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa58nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVIcsr10GzqXY7HYgnUGYhRgYdQt1II5LYZ+G6WqoHffMvXvLB/kMKFZF4sg2dVcqRjZS6lcDkZL19K3ErH58WGTeapIG/mkndvsgyaGoO7L5txnwcQZyPaEbQix3ndMIC9iOqveXVM2tefOtV4YjwEIlI2NbNe1dHg5j6DYVx/+pvhcif8PfIiEUKM4YWQslgQEvvPuJYBSRo+RKjU5L1GH5Mnjz//Wdaej4CeG2NsHh/Z4DaNudjK/QjSAhsC7VLdvqD9QF4wGm3odhef8sHYgp0mk5Q4qBYtpo+Ocyr1hQoJ795qVw90lJUJmp6ygkpmudaa15jDCygX7WcN32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ahjCV/Nk8MVwdWzffjHr5S0Ar9A6NrQPB1ERYWHDac=;
 b=AdoLJgcsSByu2JBndgJFUxL9Ag47ELWZoYZI+yW8PcKVlwn4Z2Zvn+idQVZ9I3384+CW3/CWhcYCzUYtGkyDD08f2hw4L/9+AqkjBIwG1ZANtv+Erdh8FwfAKDL6ikFHowr2ILiV3L4SY58NYrQ75G35BZSDoxrlZC4e75ryTuvuqqSy4hkA8H4DK+JAkxrDHYSevi5MBT7RU+FkkYP6B9elXgCQswfm5SpWq/JbIIbvZKCcvyxkr6LnMAnwzrkHEiAHsQMpDKnObLdSunCRbFdzhukDCyDVlUASiknK35HU7yD9XG1ObZwFkylTMETnHEArZ/kpPGH/N6Dk18+SzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ahjCV/Nk8MVwdWzffjHr5S0Ar9A6NrQPB1ERYWHDac=;
 b=EqJSiuXqLAx3Hf6RNbOB9lvGF0v9e8HEPC9ZGxxzncvKaAEtszuciPh3wKK9Xnzqo84lR8gNW98Pj3m1RGMUvClLRTS+6i47tD1ETnf/wkFG9RjlMSMFjjvAFLBIvgWxp8DU5sOEu2bioYz6GowclRSYi4Eet/h89sePZCd2/1Y=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH3PR10MB7493.namprd10.prod.outlook.com (2603:10b6:610:15d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 14:12:16 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:12:16 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 14/24] kbuild, firmware: imx: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:49 +0000
Message-Id: <20230217141059.392471-15-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0182.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::7) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH3PR10MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dd5d16-5710-4dff-9415-08db10f0f937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1CbZl68epCe9KeqRslvPIFdZXWJhOyt1/JlWjTeCQ6oiqCBfx74y1OKNeffGLCIPc8gTcXSGlYWJhZZkH+mL1IsZEZnlfcmpSQoBlg1XQqzYEjJkAy5/CimrwladumgLmo2SdTdqm0rTyGpJ/e4g5rN0jTRboqmwrHiHupGK5QmPxbBFZW94EC5JHATS60PXYiAC4zebmDwMdt0HRAxZ1zFsK8QDA83CHYFOMRdCwcBKi91ZnCgYnjZ8quTkG+tN/u9Hv0qsQLgTkiRwUR6LkgnGOce0bP3kgsb1In9KjNQTWz0duLbpHDovTQPH0JiF8dvb6BIAVu0/6o2jFSiQ5wRKPg+cUV9Kuw1Umm519n7w0b077Re0IxuJGmYXPNuCIhHCS+tOPSQ1a3+DgT7sHG7SpSguJizOZHTgJB2NnoQRkdLQFXa3IZriSkfnyjwH2oDogrqkBU7mW8Vli2FvWWLA9SekHRq1dlOp/rIR8QcGQF9a6jnmx385eCc2iZJh8c+e6tj8wEvYRRJADixo8tjFrgE1aFnRn8ZJHmcslDy0ML3ESdLBcZBn1pWFNhjb3Vr1vNcihyW2fZC4piGWnA335FeBKMUDj038ba73vLNVKQDlT7fvMPhI98WFC9TVHRr/xeDwV6O3y+46hTbJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199018)(38100700002)(2906002)(36756003)(6512007)(2616005)(478600001)(186003)(86362001)(1076003)(6506007)(6666004)(6486002)(83380400001)(44832011)(41300700001)(8936002)(6916009)(5660300002)(4326008)(66946007)(316002)(66476007)(66556008)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3qOAtVyKgiFZ9d6to4lmhg7YgOhrqCxaYckr45DyMdi8Y9hK3bYtr279kTKs?=
 =?us-ascii?Q?9UU53vbpR6/dk0CQGG9k6ewZ1xDJMau5aO5NOUxUYSMsX6/a21qr45fEwF4E?=
 =?us-ascii?Q?sHAjacwiDl6Ti/sY2dkD1gYTHjRWZMCnWqm58nrkKvaoe+zS0s2sldGAx6qO?=
 =?us-ascii?Q?vfNV30lGJH8ng3F8iYS5TmbDR/SSgm4AnZNOV4tHuIyu4XU0lD+a6LUUVfiN?=
 =?us-ascii?Q?PPU2mrFlRGxeT9Jd/hcyONGPdXfjMTYrj7wmwT4d4UtwGvschH+FJtQCXBB9?=
 =?us-ascii?Q?kq7q0SqyTd6XFRA0NOU2UWyHBJoCSl9mtTjebjRIbMaj3nbHLjkQDcRQFMVM?=
 =?us-ascii?Q?5ClKU/p/XKKRSm0fLgixVgw+EOsC+9f1vJix3EKiCiXhM7M0vokyCNKQ9S2m?=
 =?us-ascii?Q?N/jLralTLy2uNEFwpW7W7W1ogs6FuRzf3V4dyTwDygrydadNkvpu+m88J29K?=
 =?us-ascii?Q?Uvft6sZEagUV7RZVmN/L2srm1KQSC7Ne0qBRmZUi6kDD71nzbCUQzcG0PbJb?=
 =?us-ascii?Q?kptBNP7RzGQn1STP0pE6FUTiH0CtP0n6k8Izblpsb2smhW9MCMOtiRxvujij?=
 =?us-ascii?Q?2Zqu+uQix9RUGcLuFYjOBs3ZP+HAqaLv7dOsjBGnldzP9fYZ9j3lvIuU0vCC?=
 =?us-ascii?Q?+B2Fv6M3COu2kQtrdm+RZGEDAP8ZtQ100CXhkKjxDCW6d06ucBRTmE0S9Jui?=
 =?us-ascii?Q?oAtD1aoC2z2e8ZLy79lwK0GpfX/oBvfkv0LqYZ9G+4jqEQVjBoiTxOnWgqyv?=
 =?us-ascii?Q?7UMubSmrLCkkfVXBzm40QLCoKAuY+NTaLtmSqVZ1oSKqwDI7L/Mlb1SrSX2Q?=
 =?us-ascii?Q?v6aSSk12I9rm7KatB5ZTx8urPSDlQ16CB0C+8Wn9TzCSSz3H5/mzF+GYJUFe?=
 =?us-ascii?Q?dJ3FSFwbJDMCAIVFjC1rrsfom4KbfYQPbmWQ4z6sTCZ99rl+qOgZw1pRFTTK?=
 =?us-ascii?Q?L2p92ntHECinKdK5kVYrmDhseyCadLf92CF2WecI2b9TWg6qf868Md2HaOVu?=
 =?us-ascii?Q?1VS3xY5K2iqZXhQzoAAobfuE50LkoUQqyRP3mslwzC1mDErcwOBkL5v6XIMS?=
 =?us-ascii?Q?9jWsxRXI+Yv1zeenilvd/F9kZAYsbVXsEUPgDVJVYXYeDaPPNywEouIGOR4k?=
 =?us-ascii?Q?7OcMVOW15ik/YHCHW0Mz3bNVGVo9UupQ9v8UZdSXSAfX21FJwdCIFMsiknF7?=
 =?us-ascii?Q?MlyDVpuLHDgJjZkwxGyiNawf7TvX24Nn0uuNRbaKHnmAYF1QM/6n84Lc1F8q?=
 =?us-ascii?Q?WION5PV7xaLJ8PBGotzRA/NaActlQ7CbQXWjx5twFjtZBjoOMvP3UHiheUrk?=
 =?us-ascii?Q?Q0LISxztgsJfTWazA4KyTHRY36JPOv8jeFlkAZt3Z0zDNm51EgNg0sXNVfRs?=
 =?us-ascii?Q?LU+VoHdYCBwKDdN1sZMsIyyN9500rjsNhrFNlL6qo3m6olitZw5WiMPPLADc?=
 =?us-ascii?Q?y41nse4wsR1xBKyuAXIgzP85t+E3Q2BHYeFpIRoXCCqbS74dT+beUYQQtsuQ?=
 =?us-ascii?Q?pocL+FdEvYxftvFWhbS0tWdfQKYd1qjolj0Va14aVplAWXdITslfbK32Bt3I?=
 =?us-ascii?Q?lxG04gItthsjFa8hMS3YssMXv6MtOOpZ8dnsgSEqKZah/Kw9/QdOZZVi5zX0?=
 =?us-ascii?Q?tXefu5wG/BOvLw34TR+3TZA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CimQ8sWUe6SY5CxG4DwAYM2CV1s0JFpvzZ/IIUD0TXohyzzW3EANOG9hAjnGu/0wsIRlrVtl9/cPVu04M2D6oS3NbNUfM09Q8Kp7LeeaMw4RWLxDlFkEIcE4eAV3JM94OrOq5kViOZVHw1PgRITY5LtnBwceBlObYl45m4OxW6VZzAKLYcXrRoniPJhmd356T0uPvBtNMVUqMSc95eMDk9JjE6JfzWuYQhs2Pz2N5IIR2MkhIITrU11ywKgUq7NWrF+Gon9+kC92aUGe6DNGSwBt9tY+0Hi5Tws4eoIhnGyVhY9VvOu3jCTQeJDZbA2xIA4gUqqWVKVmE7KCBv5/mNM2b4oINNnG2ohsJZaCh8pF4MtOWoVOrucjN4dUqjrKZDGqpTLM5udulxzO3RGJprtx61jv4mdDnQJVNnDpk55Q+xAXB/oJLJatOX60/vooiGl253MO7nFq6ZxPYTglyfrBKLtzIZEGNnSfCA0jtZzQTmLBddNz6E1sy01rbt5HzQApTRYqp0StTGL92Ly5gJVDn/CT2vuEC+jaO9+9Fa9e/iPynFxxWJCgbBH7QqNocNR4Q4hNGEzjkwfjhn3Jc3X4XL9yEm3iLcS3CxV+R0Hh9RvxE3UFSgbrG4vLcBs/HJ8EkbQNL8jSHonfqEyxhL5pFQUdsdD6v1EHeCHkE6zfg2pQ6xLaaOeVuY+FA14lPWdkl4chVuJvrV1piZqq7wns84NHasSfCVROTbzg+JTkXwBgWrj+Myt1YZsWCnmUba6tzseUbPGBKbCmaVAf48Z5fRQ8lHXu09IIgzv0JbpPMup77oRa7L9HxH+eZF74SrxKGksodRVLhjgpG9BcRz3xvij7OHPPR+pJSQ3+RqzgCh9pfWDRbcAfj4nvPcuJmBgJqn1wC5p0LKPInwDpyug7yJsWWpTI+EhNF+mDgUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dd5d16-5710-4dff-9415-08db10f0f937
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:12:16.4765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3JszGbes1KZApOQDTC/l66NiKoqY5YPsgvt59tqaEzjXFzMvLAqGzzhM3QqDf26thOzRsBCQzFtYl4TCIjplA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-ORIG-GUID: Jzg_7cMm4gWp2R7zQGfMl0JDTe2UJL6T
X-Proofpoint-GUID: Jzg_7cMm4gWp2R7zQGfMl0JDTe2UJL6T
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
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/bus/imx-weim.c         | 1 -
 drivers/firmware/imx/imx-scu.c | 1 -
 drivers/firmware/imx/scu-pd.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 828c66bbaa67..a3a99299ad15 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -405,4 +405,3 @@ module_exit(weim_exit);
 
 MODULE_AUTHOR("Freescale Semiconductor Inc.");
 MODULE_DESCRIPTION("i.MX EIM Controller Driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index dca79caccd01..886bbc81e0b4 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -358,4 +358,3 @@ builtin_platform_driver(imx_scu_driver);
 
 MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("IMX SCU firmware protocol driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 2a4f07423365..7e8810bdfe0e 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -421,4 +421,3 @@ builtin_platform_driver(imx_sc_pd_driver);
 
 MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("IMX SCU Power Domain driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

