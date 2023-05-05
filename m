Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162796F8742
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjEERLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjEERLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:11:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A88C1990C
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:11:44 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345EXsBQ012508;
        Fri, 5 May 2023 17:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Fun+cfLeguW6hDf95SzDkbWyT4OqCM1mBzJEvI6ZPMA=;
 b=qoi0vwq0LE0xBnNWUEmYvd8usq+jYg66Up2L83fQFMQTvoeCTYniE1qjcC3GTxAqbDNh
 Tz7LBFk/jfMk9j4Ytb2oLkcGFf+rKgAa5IMpjYNUrmb7OnpN7q0dGCn2gf1MbxYeLU2m
 2S8VoyJDVyZvRfqaURgd6MeVEHdggPK0Fp5cJhi+nIC0zmFUeeFeRqBvMMGCb8azMsy/
 887JO27YDATpzk939clKFOsMdBCowvHCP05oCW1xKGsKs44LHtMtSxDshU+PAomLrbG2
 ben0KX4MP2/NyGghMJ0/MCm9WHwWEmC4XN0WH3cIgXsMNOAmS51mJnpOlg6iIMlw7WIx rA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d5kb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:11:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345FZHP2027434;
        Fri, 5 May 2023 17:11:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spgdtcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:11:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8hCTgs5YaHCmzZEuYQzzRVaFBEEC3ixhPm7M4I0NUELaVPXryglN6zzufnTm+2dxhYh82owRVmTOGo36x7LEbhUVsE6IYG+jWcfvuXhF+qaOk6eOV3j1kFiVqu56v+zm0vNqPIDg9WG4rJ4APCA+vz92Q7EWX4xFODssR7572KLz0jt48lUZLCFfuA8p7K5Dbl9ixPlwEPjWTjpN6Wsljn432JmvIBTI8zv/UH8KJk2QWzOZ0saS5/ARqvHyi5mKmyzVZUItxigmvtxwkoYd1uyI/7D7rrFRMQ2+WDh55KLuJuxHSHieAQtJU2qRqoe90FQxR5shkdRw+t5X5Re1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fun+cfLeguW6hDf95SzDkbWyT4OqCM1mBzJEvI6ZPMA=;
 b=mg/S769kifLMpMKupbdgwahMSj1YrUazCsxdsDun4aYH7WaNl3dlj1vSRtEATUEGNMvNFi84Zl9HYZoj0vlNAqINjJyOfjoZ6WNzgKEub22rMawQ5KN0bpvVvmBHhguVvmteapzn3VCCiQdpcUCKubF8kD1BCFyockgn/YiyDubsAKD7dYcCrCp50rnI1BZ6p44POF9V6CZZyJempnvujm6CkioxmOd9SRAWkXE0WfMWBOpLjQE3qNsMQoiLu7ynkpD5PFjYwi/7S90o7Ppz5ZBkxANwivo2HKZZVwbeuEZGkRTvN/9jRPCCabXRognDrVU3FRwXB8RQcz/GSFTUbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fun+cfLeguW6hDf95SzDkbWyT4OqCM1mBzJEvI6ZPMA=;
 b=yLkdaue/3ReC4GHfRmkftlklFvgNDuv4HX+Tb8wpZfX0qSvjD6N9BH3A9oZc+sBHY0521/v3pcJ6gMB+7NQ1XsYFnTb3Z9uKMExjysXZ5p/ae1jYzXgMlHo6wxgV9evgjR2E2RVEJyAsqUsnyo7BjTyWR83VbEdPjoNYi5PMt5E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4774.namprd10.prod.outlook.com (2603:10b6:510:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Fri, 5 May
 2023 17:11:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:11:28 +0000
Date:   Fri, 5 May 2023 13:11:25 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 33/34] maple_tree: Add testing for mas_{prev,next}_range()
Message-ID: <20230505171125.3icrksk7vem4fnqr@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230425140955.3834476-34-Liam.Howlett@oracle.com>
 <202304260916.KTgrhA2f-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304260916.KTgrhA2f-lkp@intel.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0050.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f674202-776b-4deb-fb79-08db4d8bc3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XD9etukM26nfOTuPmLQuFKyCZFTUySS8PDpo+jPj12pbLl275rjXunf3izPD50N2/bQL/ReQETLUSITkpw5fhQNkhHzH5+i8QS1PTjxjxzlW1McNHyoaDKBAoMv74ERljyRXFqaGSrAxhEhHn2JPtIbOL8I1Pvnelqa3EpLvrr0gNshyJc2d3jgrzYDcQ8m6tkcnJ/iwrQ2XDrOkBmpOlZsmR5lxEdx20LCIxxroZFfq5rkVep0YBvr8DFk5RZYHTW2WcF6rTr0bQG+APFHzDdEQpKJTtu6JLRL0O3NlMcw0Va7ioLI9mraRGFSbMS6646CtQD9A37nYbBmo0Mn4LwlTGRe5m5gVu5s+yR37ApG0NqeNUtAVgrfxwY7u+XYr4JtBxeayDANYk7o0D6G2dAz37cI6FQ3VYtfF333m6yKl1pnrtoJ687LX1jcqI4jL+gqMrmcOfQeKPugil4hjWLtsUr3CihTwK69wdcPkhinGGq5et9OAISJMbXvel9dmZEEnQ2wXwlBCgbme+kLOQAT37BMCGOx0pCiL+6XUme9HJ7np8eqgKaSzrfssT3aaN6moVDpdGkYvbmvgYeTgQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(30864003)(41300700001)(8936002)(8676002)(5660300002)(2906002)(86362001)(38100700002)(6486002)(6666004)(54906003)(9686003)(186003)(966005)(6512007)(6506007)(83380400001)(1076003)(26005)(4326008)(66476007)(66946007)(6916009)(33716001)(66556008)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sq0hsJK1MaV9BCw0Vw1p7diRL2iiuLc39ckZ83kAiUx+E9rylxge1d50p4ku?=
 =?us-ascii?Q?phokSdrHgF6XJeb6cWTbSgM7ezohczfYaH4+CrZ4kVtEt4kzhD35JXLSObng?=
 =?us-ascii?Q?aEu96EzM+rU5A17menc486PPLB57MAZWCBlngcakuVAvK/a8LoIH7LFZhoTX?=
 =?us-ascii?Q?TnijS2x06B78r7R3DYIUFVwzHSPDSh+QI9VUbC9ER5xL4YVbd7VndFc5L9J8?=
 =?us-ascii?Q?TTid0T5XQ4wzC3vvdrAORGZ9wNa+yOj8ECtucE23OzkuLP5Gz9qygDraB6+K?=
 =?us-ascii?Q?nFQd77SCDrFBShQvljUHmRC0xFIltdCVUM4Ws1FFsumDXSuKi1JNlKQ7Za98?=
 =?us-ascii?Q?xYzAx2V7wBA0IHdZ3qt4sTlF2DzdlYlV2HmWZoOVnNmgYbqhVROsSSfBiMCE?=
 =?us-ascii?Q?2qSPxHzVfxtrpmk8k2V71S03ENUn0nY7bhQsjSAsmtPLBz3wT9xiUd+Usu8i?=
 =?us-ascii?Q?CFwTOsG3v1GXj6vJGepGnrP02n6h+ZHSsqVsIdEMCbStYWituGTbX96EMjeg?=
 =?us-ascii?Q?UF8agHIgJ34Bsazubl0xHi7DeszP70LOb5auswAKwK7CBDVbPHslgpmQEc5F?=
 =?us-ascii?Q?RVre2rjXZFwi6JmCe0TYekDl3fwhtSf+O5orj5AyelMoCWwjvRUYk9dmhQUP?=
 =?us-ascii?Q?2L/U9tU2oPte9MB+z0TQ5CGiWrlp+pvx2BolXj4j69Z6ZYzkLi/dL29BjEN1?=
 =?us-ascii?Q?3gagv5ABF/RGoEIbeNX4aeuJysJUFIevJUVouJZFbhvMoUN/pOFbWh1PS6eb?=
 =?us-ascii?Q?0XOTbXbA7QsXA8CB6TOJOPnplxXXWhzYDdEQtT6vyTtXxELu5mAFv9UM7fkh?=
 =?us-ascii?Q?HiChf2yqdfbIC+6R60+reIup8KIwDNmvbfycTiScGqFDkzC7REiS6a4SCcYU?=
 =?us-ascii?Q?6ep7cq7xpZN3msmZ0IyHs/P/uzihhBClTGvjZtIC3Nsj6p8ob5ZMJC7fcs02?=
 =?us-ascii?Q?MgVK46wEH11C1Hfi1LZ02elgr96n5ybs2dX3K0bSE549QGaTJkgmHasdX194?=
 =?us-ascii?Q?czds5m/vxNz53Bc6yrd2v6OX+7r32ZDo0A9urelCPMhLd9vCjgX8Ug8gmqfQ?=
 =?us-ascii?Q?Xp+mAMLtmiZVsYILvA1WR7jDxI0/BnKCLHHrjSlrEcuFapKf4uiGAhMESECP?=
 =?us-ascii?Q?hiCIZ3lHiIkX67dO8zvFvB1hw+Wy5aTUAfO71JCTkdI1GZR//fB2nZST3214?=
 =?us-ascii?Q?Zert4CmKvqdbClY48sLsrVueSPSJkVtNXds8pkJUd2GZcv0etr0fb6QR7iY2?=
 =?us-ascii?Q?B7LQnBAI7izWcjViwIly5tI9MS8vqV8hXhmIcFq7o7EphiWabFDBFRjkq+pS?=
 =?us-ascii?Q?vJJj4hOamkSGxFBG9KEVrWJ8/g3nA8gg3Q7sR8UUGFNJsSmAsQeaOLWnQ217?=
 =?us-ascii?Q?sxfZ4gcC0sDbJedbWArPMxlZ/SDHH1PfFOiMW+QW7fw7+4+U8+VgzGCFtSHF?=
 =?us-ascii?Q?YD0BzPHi8IYlwa8fUnFLP4DVorPVBlT6urdsUDhK8QVT3QnTHwzkfPLjHOeH?=
 =?us-ascii?Q?/+lyO1NBkmyCseHG9DUCK18XVmKPpHC04z/kB+YoiJbG/U2Uyk/bYQT75wxn?=
 =?us-ascii?Q?gFKea1oVBHXCqJI7iDrJ6cXsUgFDDD/Z1Tz4gwWBhLYcsxngOmuc/KlM2i5g?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5lYs/TyWbZjfdm3kR4dqTHd7bucglGjIAcJPAOpXaDA4Eur4aOszW5J6jBF+?=
 =?us-ascii?Q?2s1/VP329hD+WkBMa7pPKfuisdJY7Ms6q/VTUngGcSaOJcP1zwQn6FdFZnXP?=
 =?us-ascii?Q?fbNCbFl9kbJzIINYi3f1nikT61QWDYnXZqm9OrFS44I1t2aIentTOKOUy08L?=
 =?us-ascii?Q?xs6JYSHn83CqhR3QL+Ai2dypYo/lEPtFNFHFQrunfB341ctdm0j5lZCmR6v8?=
 =?us-ascii?Q?909q1MlAEIepdvxBeH4wv1Dxz0K0ylNRzOh7zDs/4AQaWiRrECeNouqY4v5/?=
 =?us-ascii?Q?7uNw9rffY3cdpz5nAhwi12N2BSAD4VM5mryqRSLit+D0ZkSNlN5oEX778Bi4?=
 =?us-ascii?Q?PmvV3IS55fdBWkB0IVcwuIPEjWZLLPtt9EODG820h+B76NXxfJ8b9UdZ03xn?=
 =?us-ascii?Q?6IU93IWYMrzS4w9wRgvkZXo5ceq11g9Xm7VdCzwIi8o0ommMSmnnFWGCwUZV?=
 =?us-ascii?Q?AFux6mIz+jSyghFtbU/FoJMjU6vU6B55uJjBzPEjKW6x3nJTQX9bLg2dzSAT?=
 =?us-ascii?Q?6Cv6fUsVDo3T/tZE7uVGQFgELu1syrGL8xb93TNS/E+xMQ4ylJ3NWQ7GzP/F?=
 =?us-ascii?Q?G3npn/B7e1vWIL1vFLZdfh2rQLuUCfnR5JcaBeQwR3cen9EfAQ5pyTb2DQRA?=
 =?us-ascii?Q?7HXOLLTA9IvnCokUNbqt5le3cOteTOdMNgpFPKSC2yutpQCj2pT9pzWBIceO?=
 =?us-ascii?Q?EBh8f3nT7a3JS/mFZsqDda5vx7lowb4KQoagEZ70m8Whn7X5nnr4lLvUFQWl?=
 =?us-ascii?Q?n/nqxCf7go/8H8catzU+6Vqe+5WlQXt5e4iA/Qo7jWB1b4/YXVXu8n/UoSYX?=
 =?us-ascii?Q?39cfI6EEqzG4htHni+ur8VdqV2q3mfDC7zzH84aeCvN8yDqo8ev4jcp90Qqw?=
 =?us-ascii?Q?r54Rjq2b6pZXGTYAAPTQAkQ+8POjyUhWTWlyGIt/z1u5HdXFlAytoWLUsRTz?=
 =?us-ascii?Q?IjPgrH+zRA+1LXeiUwYhIg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f674202-776b-4deb-fb79-08db4d8bc3a6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:11:28.3920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7zAkqTzdDzZ0nDRRJgjM+Cx1U4xR9snY09A5Ma5hJuU5x9mJSuA+jo/RRF5QHbG6wWBkXRbplKKtohVV3/aCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_23,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050142
X-Proofpoint-GUID: R7hcpzHwI3JT5sCl4GT-cr88efsDXq9G
X-Proofpoint-ORIG-GUID: R7hcpzHwI3JT5sCl4GT-cr88efsDXq9G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel test robot <lkp@intel.com> [230425 21:42]:
> Hi Liam,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on linus/master v6.3 next-20230425]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Liam-R-Howlett/maple_tree-Fix-static-analyser-cppcheck-issue/20230425-233958
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230425140955.3834476-34-Liam.Howlett%40oracle.com
> patch subject: [PATCH 33/34] maple_tree: Add testing for mas_{prev,next}_range()
> config: hexagon-randconfig-r045-20230424 (https://download.01.org/0day-ci/archive/20230426/202304260916.KTgrhA2f-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/571139f33a7ede9db66c7892c40e88ed66a32bc5
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Liam-R-Howlett/maple_tree-Fix-static-analyser-cppcheck-issue/20230425-233958
>         git checkout 571139f33a7ede9db66c7892c40e88ed66a32bc5
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304260916.KTgrhA2f-lkp@intel.com/

Thanks.  This will be fixed in v2.

> 
> All errors (new ones prefixed by >>):
> 
> >> lib/test_maple_tree.c:3437:17: error: call to undeclared function 'mas_find_range'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                    void *entry = mas_find_range(&mas, ULONG_MAX);
>                                  ^
> >> lib/test_maple_tree.c:3437:9: error: incompatible integer to pointer conversion initializing 'void *' with an expression of type 'int' [-Wint-conversion]
>                    void *entry = mas_find_range(&mas, ULONG_MAX);
>                          ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    lib/test_maple_tree.c:3443:2: error: call to undeclared function 'mas_find_range'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            mas_contiguous(&mas, test, ULONG_MAX) {
>            ^
>    include/linux/maple_tree.h:545:22: note: expanded from macro 'mas_contiguous'
>            while (((__entry) = mas_find_range((__mas), (__max))) != NULL)
>                                ^
> >> lib/test_maple_tree.c:3443:2: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
>            mas_contiguous(&mas, test, ULONG_MAX) {
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/maple_tree.h:545:20: note: expanded from macro 'mas_contiguous'
>            while (((__entry) = mas_find_range((__mas), (__max))) != NULL)
>                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    lib/test_maple_tree.c:3453:2: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
>            mas_contiguous(&mas, test, ULONG_MAX) {
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/maple_tree.h:545:20: note: expanded from macro 'mas_contiguous'
>            while (((__entry) = mas_find_range((__mas), (__max))) != NULL)
>                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    lib/test_maple_tree.c:3464:2: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
>            mas_contiguous(&mas, test, 340) {
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/maple_tree.h:545:20: note: expanded from macro 'mas_contiguous'
>            while (((__entry) = mas_find_range((__mas), (__max))) != NULL)
>                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    lib/test_maple_tree.c:3476:7: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
>            test = mas_find_range(&mas, ULONG_MAX);
>                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> lib/test_maple_tree.c:3482:9: error: call to undeclared function 'mas_find_range_rev'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            test = mas_find_range_rev(&mas, 0);
>                   ^
>    lib/test_maple_tree.c:3482:7: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
>            test = mas_find_range_rev(&mas, 0);
>                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    lib/test_maple_tree.c:3487:7: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
>            test = mas_find_range_rev(&mas, 0);
>                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    lib/test_maple_tree.c:3493:7: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
>            test = mas_find_range_rev(&mas, 340);
>                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    11 errors generated.
> 
> 
> vim +/mas_find_range +3437 lib/test_maple_tree.c
> 
>   3358	
>   3359	static noinline void __init check_slot_iterators(struct maple_tree *mt)
>   3360	{
>   3361		MA_STATE(mas, mt, 0, 0);
>   3362		unsigned long i, index = 40;
>   3363		unsigned char offset = 0;
>   3364		void *test;
>   3365	
>   3366		mt_set_non_kernel(99999);
>   3367	
>   3368		mas_lock(&mas);
>   3369		for (i = 0; i <= index; i++) {
>   3370			unsigned long end = 5;
>   3371			if (i > 20 && i < 35)
>   3372				end = 9;
>   3373			mas_set_range(&mas, i*10, i*10 + end);
>   3374			mas_store_gfp(&mas, xa_mk_value(i), GFP_KERNEL);
>   3375		}
>   3376	
>   3377		i = 21;
>   3378		mas_set(&mas, i*10);
>   3379		MAS_BUG_ON(&mas, mas_walk(&mas) != xa_mk_value(i));
>   3380		MAS_BUG_ON(&mas, mas_prev_range(&mas, 0) != NULL);
>   3381		MAS_BUG_ON(&mas, mas.index != 206);
>   3382		MAS_BUG_ON(&mas, mas.last != 209);
>   3383	
>   3384		i--;
>   3385		MAS_BUG_ON(&mas, mas_prev_range(&mas, 0) != xa_mk_value(i));
>   3386		MAS_BUG_ON(&mas, mas.index != 200);
>   3387		MAS_BUG_ON(&mas, mas.last != 205);
>   3388	
>   3389		i = 25;
>   3390		mas_set(&mas, i*10);
>   3391		MAS_BUG_ON(&mas, mas_walk(&mas) != xa_mk_value(i));
>   3392		MAS_BUG_ON(&mas, mas.offset != 0);
>   3393	
>   3394		/* Previous range is in another node */
>   3395		i--;
>   3396		MAS_BUG_ON(&mas, mas_prev_range(&mas, 0) != xa_mk_value(i));
>   3397		MAS_BUG_ON(&mas, mas.index != 240);
>   3398		MAS_BUG_ON(&mas, mas.last != 249);
>   3399	
>   3400		/* Shift back with mas_next */
>   3401		i++;
>   3402		MAS_BUG_ON(&mas, mas_next_range(&mas, ULONG_MAX) != xa_mk_value(i));
>   3403		MAS_BUG_ON(&mas, mas.index != 250);
>   3404		MAS_BUG_ON(&mas, mas.last != 259);
>   3405	
>   3406		i = 33;
>   3407		mas_set(&mas, i*10);
>   3408		MAS_BUG_ON(&mas, mas_walk(&mas) != xa_mk_value(i));
>   3409		MAS_BUG_ON(&mas, mas.index != 330);
>   3410		MAS_BUG_ON(&mas, mas.last != 339);
>   3411	
>   3412		/* Next range is in another node */
>   3413		i++;
>   3414		MAS_BUG_ON(&mas, mas_next_range(&mas, ULONG_MAX) != xa_mk_value(i));
>   3415		MAS_BUG_ON(&mas, mas.offset != 0);
>   3416		MAS_BUG_ON(&mas, mas.index != 340);
>   3417		MAS_BUG_ON(&mas, mas.last != 349);
>   3418	
>   3419		/* Next out of range */
>   3420		i++;
>   3421		MAS_BUG_ON(&mas, mas_next_range(&mas, i*10 - 1) != NULL);
>   3422		/* maple state does not move */
>   3423		MAS_BUG_ON(&mas, mas.offset != 0);
>   3424		MAS_BUG_ON(&mas, mas.index != 340);
>   3425		MAS_BUG_ON(&mas, mas.last != 349);
>   3426	
>   3427		/* Prev out of range */
>   3428		i--;
>   3429		MAS_BUG_ON(&mas, mas_prev_range(&mas, i*10 + 1) != NULL);
>   3430		/* maple state does not move */
>   3431		MAS_BUG_ON(&mas, mas.offset != 0);
>   3432		MAS_BUG_ON(&mas, mas.index != 340);
>   3433		MAS_BUG_ON(&mas, mas.last != 349);
>   3434	
>   3435		mas_set(&mas, 210);
>   3436		for (i = 210; i<= 350; i += 10) {
> > 3437			void *entry = mas_find_range(&mas, ULONG_MAX);
>   3438	
>   3439			MAS_BUG_ON(&mas, entry != xa_mk_value(i/10));
>   3440		}
>   3441	
>   3442		mas_set(&mas, 0);
> > 3443		mas_contiguous(&mas, test, ULONG_MAX) {
>   3444			MAS_BUG_ON(&mas, test != xa_mk_value(0));
>   3445			MAS_BUG_ON(&mas, mas.index != 0);
>   3446			MAS_BUG_ON(&mas, mas.last != 5);
>   3447		}
>   3448		MAS_BUG_ON(&mas, test != NULL);
>   3449		MAS_BUG_ON(&mas, mas.index != 6);
>   3450		MAS_BUG_ON(&mas, mas.last != 9);
>   3451	
>   3452		mas_set(&mas, 6);
>   3453		mas_contiguous(&mas, test, ULONG_MAX) {
>   3454			MAS_BUG_ON(&mas, test != xa_mk_value(1));
>   3455			MAS_BUG_ON(&mas, mas.index != 10);
>   3456			MAS_BUG_ON(&mas, mas.last != 15);
>   3457		}
>   3458		MAS_BUG_ON(&mas, test != NULL);
>   3459		MAS_BUG_ON(&mas, mas.index != 16);
>   3460		MAS_BUG_ON(&mas, mas.last != 19);
>   3461	
>   3462		i = 210;
>   3463		mas_set(&mas, i);
>   3464		mas_contiguous(&mas, test, 340) {
>   3465			MAS_BUG_ON(&mas, test != xa_mk_value(i/10));
>   3466			MAS_BUG_ON(&mas, mas.index != i);
>   3467			MAS_BUG_ON(&mas, mas.last != i+9);
>   3468			i+=10;
>   3469			offset = mas.offset;
>   3470		}
>   3471		/* Hit the limit, iterator is at the limit. */
>   3472		MAS_BUG_ON(&mas, offset != mas.offset);
>   3473		MAS_BUG_ON(&mas, test != NULL);
>   3474		MAS_BUG_ON(&mas, mas.index != 340);
>   3475		MAS_BUG_ON(&mas, mas.last != 349);
>   3476		test = mas_find_range(&mas, ULONG_MAX);
>   3477		MAS_BUG_ON(&mas, test != xa_mk_value(35));
>   3478		MAS_BUG_ON(&mas, mas.index != 350);
>   3479		MAS_BUG_ON(&mas, mas.last != 355);
>   3480	
>   3481	
> > 3482		test = mas_find_range_rev(&mas, 0);
>   3483		MAS_BUG_ON(&mas, test != xa_mk_value(34));
>   3484		MAS_BUG_ON(&mas, mas.index != 340);
>   3485		MAS_BUG_ON(&mas, mas.last != 349);
>   3486		mas_set(&mas, 345);
>   3487		test = mas_find_range_rev(&mas, 0);
>   3488		MAS_BUG_ON(&mas, test != xa_mk_value(34));
>   3489		MAS_BUG_ON(&mas, mas.index != 340);
>   3490		MAS_BUG_ON(&mas, mas.last != 349);
>   3491	
>   3492		offset = mas.offset;
>   3493		test = mas_find_range_rev(&mas, 340);
>   3494		MAS_BUG_ON(&mas, offset != mas.offset);
>   3495		MAS_BUG_ON(&mas, test != NULL);
>   3496		MAS_BUG_ON(&mas, mas.index != 340);
>   3497		MAS_BUG_ON(&mas, mas.last != 349);
>   3498	
>   3499		mas_unlock(&mas);
>   3500		mt_set_non_kernel(0);
>   3501	}
>   3502	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
