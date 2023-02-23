Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8B76A1085
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjBWTZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBWTYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:24:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2259619F07;
        Thu, 23 Feb 2023 11:24:51 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NGwcdM011848;
        Thu, 23 Feb 2023 19:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=mgm7yswdmBwx3RoIFA8TyICvWA2LpSqB2iqxz1Aw5wQ=;
 b=hcQD06Z081LlQ+xt5KnOhd5/RZrXXPcCgZhTat+yGr6Csa8lTz6H5gckJSoIGphgQRMg
 dudFd7x2Qj1DRBo7/LSSxKpTwOL4xLXzLXl6ePFA91KzRM7NEECJPWDIPLavoR+zuNy/
 J3dzMrx38YYv175l2GKk41g8BNc0C09cFIezSrwUJajABau0cI/XI5fhmtAst7GQt+GB
 ZqheTIDA7zKv9+dZW+dkXkCBSUKaKPc/2gqiTxsbsqI5NVZMwQynhaYR8pzKRGvgZpM4
 SzoqXbbQHCgU6gCZhwdORbaazIdwHe+IQAKRZtLVQtHg5nJV7r188I4HasxDFzs0yRCE xQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntp9tuhm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 19:24:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31NI9w68013445;
        Thu, 23 Feb 2023 19:24:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4f38um-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 19:24:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eInT1OWrzctx/FbkeU01FWgl82hiGBX3uS/rmkJX9136ABq7V7jPaGDswmY3ukjJElpjA0lvncWSu2vzGBywGjDGLurCw1PzXQER9R0UZnKlRzBQ+4SqJBtRfQXbW+A3h3Z4eDRFq+Wk2odUE5/DOMxNqWb5zx+kFMuIpBvLVduorUTqTodiouw5t161IJv5iCTZQfh62r6QIWo38lf412K1epgeVpxZvb/t9SXjGBNo35nF1z7z07JW5cLB53TnGj7XMowa7lVrNsGXtSUEM64ciRDadTCRvvq1T0lqfxsOQGNeK9CougldqFEhuCWcjK2GbdY5QDnqzwXhJWM7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgm7yswdmBwx3RoIFA8TyICvWA2LpSqB2iqxz1Aw5wQ=;
 b=NmbZyW9+aZTmClJPQNSHrHTj2wsJuGuwJNC/gYGKzLMRF3mgsZMa2J0EQ+XLxJ9KmMGUXg3e7yyhtUyS/BPaFeHBoNOINfLBTSozwN4T9EKLPeJOY6egpMIb10+yc9pCMwVRoi7FwnsQQI2H4laQ4ODs/Tnmus4ZxtMPW5r6Selj0AO4TVoeq7IIVJtl/DBNBJNR217YGc44Q7vZVXIRH+M9W+mNvXGxicY6SmE+rYdHqRwh8YyXQQuhT4MYHEm5QptlKPSzWgjtxrL12jWNb50xR0o041EJi69zSssOrW1xA/QAiz9mgZVeh+kWN+Lemq1cPKtFWYe2PTwprFXCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgm7yswdmBwx3RoIFA8TyICvWA2LpSqB2iqxz1Aw5wQ=;
 b=ibo+r83mknkKWqAbq77Kw7iGSwf2YhYlEmDhpmxkb7wzCuBfVKVbc5fhWts/HPT/t8JroMSUETDVmsd5ktYgN7MWovgjFv1NWATPvBuS6MSFoQf/OtfPM5+9GcimzT/lz06fUcnRb/AHLEpVINQUuX3euDVmArGvNV5pqaLZxwg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DM6PR10MB4395.namprd10.prod.outlook.com (2603:10b6:5:211::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Thu, 23 Feb
 2023 19:24:38 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 19:24:38 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Lee Jones <lee@kernel.org>
Cc:     DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 18/27] kbuild, mfd: remove MODULE_LICENSE in non-modules
References: <20230222121453.91915-1-nick.alcock@oracle.com>
        <20230222121453.91915-19-nick.alcock@oracle.com>
        <OS3PR01MB8460D00B7C988DCC13173CAAC2AA9@OS3PR01MB8460.jpnprd01.prod.outlook.com>
        <Y/duxo1aKFibuZtF@google.com>
Emacs:  ... it's not just a way of life, it's a text editor!
Date:   Thu, 23 Feb 2023 19:24:33 +0000
In-Reply-To: <Y/duxo1aKFibuZtF@google.com> (Lee Jones's message of "Thu, 23
        Feb 2023 13:48:54 +0000")
Message-ID: <87ttzcmbgu.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::8) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DM6PR10MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 19372982-8c56-4f59-a45c-08db15d39af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thgwT6V1XqEyJD7mXtEP69+4KmEoFzJERWpb2JJxpqr/03ofg3JBXnJm1p+ZGWHjdQk5IqzNUfSJih9ZsIvbFBMX+gMYGQg6IDxUnU2HK3a1+4zkxruDhHYqFQ/hAhAXjfszuVHEQStcliLOPpMIoLX6ipWyLi1JOEvJm+DqLt4X6Ld2H24geK3UKjGqujKi/q+UMfy1dUcAQqFBUwT6KqrTL2j3Hz83xHiTal7N7GFTW9dZMWd2O7rxe73h19GQbIJ0Gvg5lIKCPDqKmcvJPutisSl7SnLtuQ245f1wxWZFz07hVATBbaQycnpTnzLCkv1wp+nxgGNP+ncj7VV66UI1y6qNXMybBuVzGQNPaeR0Ve897M++w0u+aHkwsaKZ95ZAjQs5Hp/KzwOOuqW3RrddfyJ5bRYVOVlvuJCLw0QBwqzr49ZUyt0QxQnfXQHAWgVTX0BL9P2l45sNGUeWcMYoZ9riyuQFKXkSFwRf0ED9OjkQdunL41YWXmfoEeN6eBKinzSBV3mxxgiUhsxXgcNY0SX6gtAe3VcCTpRMKPkJ9FuKiIaZ5HlThbjMd7iHFh3ifjf4vMxutKWSfrP+WnUWj8yfEgJpFMjw+AyLlqzFaI5NUo7YX81tBfDGK+T2teGD5CIvwBRrMYFljgF4LQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199018)(478600001)(54906003)(66946007)(66476007)(66556008)(83380400001)(8676002)(8936002)(316002)(5660300002)(6916009)(4326008)(41300700001)(6666004)(6506007)(6512007)(53546011)(186003)(9686003)(6486002)(36756003)(86362001)(2906002)(44832011)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gZ31oOeDQ453ZzI6kITvPh9FteeSRcEv1AyTMVbiiYlQA4ofJOa0YlgjlIlb?=
 =?us-ascii?Q?8QbxKo5nNmLaIvkd4dF/oDf3gIi9zMm4reu8cJ2PcmXtPgyhT+CJr5IUvv3E?=
 =?us-ascii?Q?6jwDzQOEvgBANEr7gmzyWstYCHcR3u2DRcDvjwuAOeqJTgODiTyRGXyJ1qzl?=
 =?us-ascii?Q?ibV5+rhUo4aurdwJydeKT4iQkbfN+VfGVZB3SI62BRzj9eQaR6P2JlL+P2sL?=
 =?us-ascii?Q?vtR3JKXolAvSavSZ6XF1HR+3PXT6MluJ4L9Jg3Yn3TElwILm2KVFksOwBNOy?=
 =?us-ascii?Q?0nCpG3bZOX8kObBMwCzdT5Ayrco6M/GbygQX/XF5YDEaU7CWj9P0akM/hKWj?=
 =?us-ascii?Q?iPbLvL3gAlrFPajZk17YFajyCIbP5tWRoejwTWjK1/JV14BopHzFKXWT6BAy?=
 =?us-ascii?Q?+Bzvb0TP+/Pyy8iuw7PF5qXVIxESTcl3Dh6nUusKRzutWwKDnDalLWg398h/?=
 =?us-ascii?Q?cFT+rartwHAMreTdffKk0VWzv/9BEloe8vCt5gkMkn3kjj+hB8FhvbDmJTtH?=
 =?us-ascii?Q?mYCRNImm1a83itaCHZLHD3NwNBjs/LwRc/C2OVbxd7qysBUoeURcGTOQHxd6?=
 =?us-ascii?Q?OCZMDcgIjVf/Eb2OLNcTXfc+onZzEZ4pLmZVXCcMv5ym1vDX+0+ya3ZdC2rl?=
 =?us-ascii?Q?AoWYUBIIMp58AtsuXRuR0iT/0TfIwq990lb4KIru0b3OwSJC8HNhuhz31BaZ?=
 =?us-ascii?Q?PDPZoS7JDxyY9DnPz+k/J/QTwTHgWbkbO56ec4Pi9Co2yJExHlzdHZ1r9Z3r?=
 =?us-ascii?Q?f+XF3EpILStvd2rAExN0KCRSfh7JA6OLvHHMErYfbv3t2KJeSnSRiOVh2amT?=
 =?us-ascii?Q?bj4uF7GDfS/9aMBavxBP7i8tsMDz7/4PaRRcgpVl5dLbXfYZhtXCavPGo9bd?=
 =?us-ascii?Q?YyKSqQhygjO7OKnz8t4+bF5fOdxS0SEeNZ05sPNw5VdwgfjkP2i2Z8DkwI84?=
 =?us-ascii?Q?ikrw2a3yuvGmncqQMi+tV1h8xi8GIe7SXQy9pTJbwVcqyRG+dvEhhi3yWPiX?=
 =?us-ascii?Q?3YAg1dgWpDAGAK3tibHsNcvgnVjg2Bwcf2POGgrP0Lzlb8tkdkgpjRaZpqIX?=
 =?us-ascii?Q?+G8S1zMWBfk5dEictYdVR1yg9Au1A7MHHc1Zmc12yJEVgEZZScoVt4ukROst?=
 =?us-ascii?Q?crQW/rbDyKYVbutOHbuyQwe+BdmffJGyibaciC9sXPdmB9hWzaVPLtB07b0s?=
 =?us-ascii?Q?SnBjexRiYtKDg5L+M6FKRNWa44gvVC2//XTH1w6mdY/GBx5XOVvX4E1IM1nJ?=
 =?us-ascii?Q?QaQR3CrKuZplkvRrOtdqm0HJePBaNQyIpWIlIXR3Oe5wTgRbC3p2cwHeNg/D?=
 =?us-ascii?Q?rmkkaiTJu3ZoNIE8IrzQ4jP8o5DI6F6AQpMtBwuQ5/Df/fWHhsUOVIr35lze?=
 =?us-ascii?Q?EHzZmtsNp4k3I5YT7UXb9gJe/pl0LGwvW5GrGXcO5XILauHSZQ8YrquNdKXV?=
 =?us-ascii?Q?qZt9pQw98R0DmQ2eSedCbOCrhH+heJ0VwuOS//Z7iiX+ddIrWAN1D/GOVsMV?=
 =?us-ascii?Q?2UyQUhHr6dzSPW7yAECOR2DImbDNIcnogPGjfc36fyXg+sgEXymJ0kFaLP3u?=
 =?us-ascii?Q?Ht31rI6+tq7DxwlHRBch9FJ2qXuQq+wdTbm7M8WLXFlKRufIy/9+mDt+MUzm?=
 =?us-ascii?Q?9I2tWX7SVydHuwNIlZSbpag=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nNiNmcewWn/3DEM7IBh/fLp1xYgi37Gq6beG+ZJPR5oFTt5tp77nZGu7p7sK6J0bssnwA0WQJtCRNez08IZ9Brg6QnQrHRV93ssM/Vw/gGXmk8/LNshPIg3HUuabfpamPmGrMHopTT1K32UGYmkxpiSTnPsiXfjOz5OrPEAVUwEEQF0Nzb9ujLpSln4hN4tnMAzuX1ca1qN3x42PVDpYPmXe4dlsyqbRSpupNyc+e5+dI7bji9qK3vJ6ejcDBd1xczFOLOowS8BW3+gh85zhtDJVWrtGYfwvJ6/y0CZxxslajJq6t16ntKCU1P9mLflMG1jDFplIg7yfJrn+0VdeRSCEcqo0O7trit15Xp897zPUt9Xeq54vab8EeRzW1hemve5bgCboKUpvzqyOe4PqjpLa4V9BoiC21DtdTpLIQSubYHNzi49epv3X/LyFD3Q+nwtifEgLr/RL+0nC63ZJD2r76W+LxJJ4GDEkDQUDnflAzHVhpb38v6+YB2FOdr7mzoRNTtkppRh3cCopbK2ibVwwqOueIxNhVe1p05NCmvtZCr3Ymyfa3yAW+zHoud+r+cDqI12U8b4LB/HqkRq9tXriuWHlBEAwTXs52vtwUigWQJ4jbq92sVVps4mCDuugBGY8mCa7pHdE5fEAntnqEZBqb7xSuZ9jmZzU4vsuRCvUjASdLY4rnPS0IjhgifCe04NE8Xj3Y8z+GJClarVhjSIwsUqVGo7z2RxtaNJBEGoseIqLeWtvD2/rve/b6iWGjHWg5N96VXtpuyFbepZcPZWvDfkVg9oFzRgBULfrHgxVGj7PWR0M1YriJt8XRFHus85XZInypyBTGo0nZgrYztjccwwr7RSsdg3qQ0+5r4nkNRZI3sAk2lJoJY7RJiWDpoS/QEIRv3mXHo2+0XWvnw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19372982-8c56-4f59-a45c-08db15d39af4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 19:24:38.6626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVWAFWdx4f5r9ghQftfcSThaa8YP9+x73RUnEUhuxvyvXaJgpOlHTQY7ezI8MGNUEu9CnJQ5syYPfT488itLug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_13,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=909 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302230160
X-Proofpoint-GUID: GdP15n586AjnMP59kNe1oBDKea2KrrLD
X-Proofpoint-ORIG-GUID: GdP15n586AjnMP59kNe1oBDKea2KrrLD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Feb 2023, Lee Jones stated:

> On Wed, 22 Feb 2023, DLG Adam Ward wrote:
>
>> On 22/02/2023 12:15, Nick Alcock wrote:
>> >Since commit 8b41fc4454e ("kbuild: create modules.builtin without Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations are used to identify modules. As a consequence, uses of the macro in non-modules will cause modprobe to misidentify their containing object file as a module when it is not (false positives), and modprobe might succeed rather than failing with a suitable error message.
>> >
>> >So remove it in the files in this commit, none of which can be built as modules.
>> 
>> Makes sense - but if you need to do a V2, would you mind removing the erroneous claim on DA9055 at the same time?

I don't know what this means. There are two references to DA9055 in this
patch, both in context (not in modified lines), one in
drivers/mfd/da9055-core.c, the other in rivers/mfd/da9055-i2c.c. To me
these both seem likely to be DA9055-related. Are you saying that one of
them isn't?

> Could you do this anyway please.  While you're at it, please remove the
> 'kbuild' reference from the subject line, thanks.

I was going to say that it seems to be in active use, but I just checked
and a total of zero files touched by this series have ever used 'kbuild'
in their log prefixes anywhere. So... dropped, series-wide. (By the
overdesigned approach of using a kbuild: prefix if and only if at least
one file in the files touched in that commit has used that prefix
somewhere in its history.)

-- 
NULL && (void)
