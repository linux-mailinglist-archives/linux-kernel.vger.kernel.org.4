Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6736A1E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjBXPJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBXPJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:09:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBE846097;
        Fri, 24 Feb 2023 07:08:57 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEmxXG024952;
        Fri, 24 Feb 2023 15:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=kEq1scAGqiTNwGibN+DOvTZZxXB5BzSbOwMFJHQ23N4=;
 b=rR1lFz0stEECwPH2VHKeInYYmlf3ztb/jSULUmGbb4qcVAyP1t2K5xI0/2Wz1oyfkzu1
 +VarrOKwS+v7rabNufjBHFjs2aI8/56Rn1i4gQyWK5a6BCU70BEKOubLbMw89ukpISV2
 8EDHOpWbglZnVTKzh8dOQ4SgiCz5MGKN8ll9+l/pD3Vs2oweO559tE0EhS5xLhzZLjvT
 F/A9YNH4Y3W2ZHcPXV909V+By/eMdJkHumy2tr6L/m1dxY89P9Y89Llsmb9Z0cCwq/16
 rKzJbIGBhin2wHrliGz0a2XAlPixv8SeLqbEolU+IbHcjhj49JjV8nf0LyD1O7l6F6bf lw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dwapg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:08:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODoOxY017987;
        Fri, 24 Feb 2023 15:08:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49v7ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:08:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzb+LteXIjGkWObYb3uybr8AinUn+Ixz82oTl552mBRsdXnW9pe/6NhHIQoypD3uVekYqTYfC2Fy6CUhLMz/vh7jh27DzN9bYYPRDFU9BpQHPMg/GHk8ndtT3rv1hdSOOiuDP0NfA5ahBljb/nJO+t9uuMBohoBN/mqkfjMuMUgL7xxSpv7n1v4rOf9WPeTZYkq3gNVCqkoEoqEwr9W4gcW+Whcmpb7losdtpGAV/MwQv72KhzVinSg6aNnlCh0eiGrdG20Ev2y/rWfqvk+Jr/6zE+jLW8K1XvNIXMy3F6ZvulZyfkm5vj+CQ0ZDazpXqdM+VrLwf0Cn1mTYAj1hcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEq1scAGqiTNwGibN+DOvTZZxXB5BzSbOwMFJHQ23N4=;
 b=VsiTpUh9lmHVcfiJPmq+CgIbXtMvOTpw2yAb9g2XkINpq5s+yhAXIdw2wIIizqrgsDb7SAGtt6LtoNONE2D//oigAAg4SXaF7jKMUxIOkRSYsm4cPy+FdXZWhlbxxQR7L3KaSDNQuSDxT7zTR0/YFwyHD3L9SNLkgcZRJn+phZGSzCpVg6CtjSp2ceqLoiJFINCJVNwTLPhfIfmRvsMFwoiZLQXm0+glitbFTB6r+spXHfa1aqzT9BtpYre3QNbWIsOZFQYqU5uundbcelz3efIW7ytMdxVeRzJGE3j+HVYJ+QOdaK9d6bJ+bkA9U5zaehvCqTIL73xjbceELHVWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEq1scAGqiTNwGibN+DOvTZZxXB5BzSbOwMFJHQ23N4=;
 b=NrHYkbkRl72uJLap6558/ymTMTnbJ9Wa+XeDwQLTO62pqelQlvIhvDFjxTbD7EVFemskK9F6CJSVMcpNmmxxLmCetFt0Sra1cyyWw4SRmyb8om69GGTLFWTVj2U69+qsYKcpeq8ucbZ1Rga5UY1WNtRVXJBN2G2Y5qsNpnA3MH0=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5610.namprd10.prod.outlook.com (2603:10b6:510:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:08:30 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:08:29 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/27] gpio: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:07:45 +0000
Message-Id: <20230224150811.80316-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0083.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c83737-7137-4eaf-ad88-08db1678fce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YI++CtrEoAqLW6B0UBB4gqPSQwYC2GXRQ6zfxdqROUUJ6Mbdn4vWVAi/qubHiEqYq/CPORQDV1zpKQHsdmbXQmv4OHqHDem64JXvXQVX301szSUXdaDrGGxqyhpWqhEpUY5oct7fxWuGv+mZ5n5KHIbb1xqOjrnh0NtqtkDuFYqNOZ9TasM+W7zRaX7REE6ersj4rIYg8bHGmdJjXaK6GRwNb6FEX5S5SuoGMDEWObBE/IF7xfjV16lONS31AjSONPmi5w2U8qeE198VYtXIHeI2HIn20J+sVn1dM9LV1/bBcIap6Ps7Ig5K22rp4BTFnecBDtXVP1KIT19mNtGB+oiFDHOUJGkTuafu+EgJx6512v609u8JkDV5uyeZOSqwmXfjhIwkkYjApsUtND4dcw6JnHSBC8FA4235ZSimHVNC2lXWrMuKsi1WBm2JRw+ZyIexSW+Q87QUhrYLKKfoffLiAfjkVhS037+ovS3ZPysMH7h5NoR4FIZdU3qQL0mtNrXUt5LhDcjb2J/bXT49LqGVu1CnmB80hnvYUMYXBpYxsUSb+u4RexY2UEvCixZrEnr9mfo52kjZNHp/gyG80nyif8rMFZ7Xc8qMhkDU8wdJ2ZqC4WPZa0TkpbW4vL+BESMBbt8OnzIq+LXgp6VyDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199018)(6486002)(86362001)(38100700002)(83380400001)(6512007)(6506007)(1076003)(6666004)(36756003)(186003)(2616005)(5660300002)(7416002)(54906003)(478600001)(44832011)(8936002)(316002)(41300700001)(6916009)(8676002)(66476007)(66946007)(66556008)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JVd0KdrSAp31zQLLRnq/2cri2+fJjvqE56u+twSl2GbRXlxpTL3OdHng/pn3?=
 =?us-ascii?Q?nQqs5kCx6Jgdp06SuTK1tDqDLE3jfONjaEawy8ZmMrVoBEbbIR0tBc03w8NK?=
 =?us-ascii?Q?V3+xgfBm896D3Gmia5ByYd9KtHeZLAqcs7ZOhZ2gf2FhJI8BlxPCWKlrJBXZ?=
 =?us-ascii?Q?XY3FSFSpK1/kY9vtDJxHrGTEoiNoxrX6OccXFuX7v47kOtW03IozLrENsKGc?=
 =?us-ascii?Q?pt80PvIkjBdSzmwjBvZhLTJv6sWZo2G6JF+fm+W5YOSOcCDvcphMFyYhAM8H?=
 =?us-ascii?Q?vIaxqHanfaRXGqMmS24aUJzVx0I9x4ohZ3ggS54W92bYdMymE3wHk4s+Xo+W?=
 =?us-ascii?Q?bHWtNOkIbWOqJ+PO8l/6rFjThkDEmulR6GMl/HzO3ni9WBrTbcEvqXQjN2aa?=
 =?us-ascii?Q?amPRFGu7eVKj2GGxGZkusKfn8JRpcWOSlcRfZuzUEp98rkCYGg89lEJ2R37q?=
 =?us-ascii?Q?zqlBBb4TxZqndofGt4uyf3bGxFSkCttXRlshHvi7iH9EohHBXqV7tv+zZoLs?=
 =?us-ascii?Q?vsTmj6B0GNu2Hp1kEOw29MBx7ujWsh+O4nN4Ii4vIHdU3xgZx4yDpDSh8qA6?=
 =?us-ascii?Q?2lA6m6mUpqXXCup25CU0BeT9/OXtZ/o8zA+uxI8+gZug3mJj2K3Trqsxd9n7?=
 =?us-ascii?Q?cTfHZyBWO8PNSS5yrkw6InpMD/IG8/RcBQLJA/cOTb17Vvc7lyjEKs9b29IM?=
 =?us-ascii?Q?3L118kr8YgBt5FDnLZy0UAEqPAD1EQoYQ558a5rVy929h6i94LyxMHsDZbXa?=
 =?us-ascii?Q?9QhzRoWDjU0tcFSaYMrujBwB1M3SwjFE8DywUbGoOleSWk4jSndORvlAhgKV?=
 =?us-ascii?Q?EH0gW+6dAV9xmGfs/BOIPcePcQLDmN22YSfHhtpjbh2Ds4SaDMMi0qU8Wdl1?=
 =?us-ascii?Q?QbOS6TPTOHQ3CGWUiMBTQBMEWWqZ6f3UBoX7rPFqGgbp8AEVvTu615YsDVVY?=
 =?us-ascii?Q?1FP1rysmTj1wM15giZTmsxBy6KIkE4c5ZkUN2QvKXTXaoN4iok5TGA+gXhxR?=
 =?us-ascii?Q?ubvum8vWzacLgWKBnI321dkimOOJnmxMQUA4pGz2PII4baqv88Hsg53n8k+S?=
 =?us-ascii?Q?1wrPUe5JvDKtjg8N+Bc7mcTUnCW0N33dYTyzZ+TV3vnX8RtMxSthqJCVMXbj?=
 =?us-ascii?Q?hvJ6m5WKe5Zi2Ekb92MYwzLoLDdpGwoC1K3Zy6Iy+/R6uwOwYi/WCgySgDRy?=
 =?us-ascii?Q?DPezbJJ4aNHYqHzj1wjZnSE2b0yWfpu0p79gp/ZX3Q3dY4jjsem5frsiHamP?=
 =?us-ascii?Q?+6+ueLvjI5rbfUQongspYGBKeuQBKdfvYQHy7QZVKjm+EblBM9KKrIIA3n7s?=
 =?us-ascii?Q?waRxu3zlcwfJF+hH2HSuRM70JSzjYdod7L3noWguDFE+v24Y88WCzoY6BDRR?=
 =?us-ascii?Q?D3cKA/KoC7zqmRDLKKeUIQQYVISV8qz+I1YjtOeksgoVdp7jjA5Vi/E6cKh/?=
 =?us-ascii?Q?nvwXCKVVRCTSQuhw4NbHILBoDtAu3GcoKEwJThk97VZDyVSYshfX7BX5g815?=
 =?us-ascii?Q?UV6W33D7fd5s21OMvjondkYx4b8gTMNcU+LckbGKV2OFTedQwqcfUy53Fg3X?=
 =?us-ascii?Q?mMncBSyTXe0pXihK0nWDYIZ1PNi2NNcK4gV+fwy40wFDt668kzXpPvaWRlsL?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?RN3OMlpXrpER+C826Unfgs5CHUpgEOcsqeeYtFmw4ewEj6HZSVd90iYt63UK?=
 =?us-ascii?Q?LH+RAi5cozbYx3oQQTDDN0dtvLezxWgfeztT008QQ43gvXi/7OZ4qNlxPyyO?=
 =?us-ascii?Q?YlIQaowLgEWHGfJAAlJyOP+HCODcrPj1JG5josnIaNxKNbpbKka2f3UMZVj9?=
 =?us-ascii?Q?87cqdLCbq/BlH9aMrRYYq17H6xGWH9WrvizRClio/HKLYqQPnt5L/SP2cs20?=
 =?us-ascii?Q?hZEJDjDhxRN6i9juIfsF8UgXzzXHrnMGd842CT0wOYchaxciy9f03Gy/D3Hu?=
 =?us-ascii?Q?iUgl88YDS0VVjfmnMVHUBzw8Pf416QmNLPSMw2IZIJdYPQgB66H5jXtS+y3v?=
 =?us-ascii?Q?bTT89NWrZKB9hox91lfVzTJbgJ+cJuSkC7vUDzX9oydGt4kNPgKbIzVCwmvl?=
 =?us-ascii?Q?8nCADlCQod+z8kSSqgLJi3/5FdFP7iL0ujSuXmC1eGbpvkMUs4oSWCHclh5/?=
 =?us-ascii?Q?MWOTQ22IRQVUJuK9z4MtI7bUpz+r8VMb6iK7iYF1lmuqJihW5IvWL8nown5+?=
 =?us-ascii?Q?mS1JwOde1iE80hPRHD+1btmUUwoapI/ZUPEimwcppODXmndrs+l0VieafEWX?=
 =?us-ascii?Q?vkOsXjy1mfCx+jms9ywZUcjs82e0UVfaSoBK+xzkaVPMeFePpA6C3X7+wIv/?=
 =?us-ascii?Q?H3Y8y4Lgt3JiF6+sZPbSycGw0RGDLrjfHBbrJtXp7Ta8YRPgbwTGmY0fSomc?=
 =?us-ascii?Q?p8qeVs41ZBve2soZDUfV/3PzRCOnsEDLOvfBR+G2hEX9c5UvLQG+Sa8mCbJN?=
 =?us-ascii?Q?0iTeec9XxY5j+IZMKKBHLlmW6OmMlRlPREICfLTzCuGxJk7tDNe26rJsuYe1?=
 =?us-ascii?Q?DZnee8NaBJAKUoHu9wUZynfAm2He/jQHQhnFBemIwHga3BFpaXVAP8IGDCun?=
 =?us-ascii?Q?bz8v46TV4aGQ7sQD5pjkj2g4wpvqbrjN3BwPDAhDljn/V/H09Skhq9lAXr4J?=
 =?us-ascii?Q?bRUnhTvw6UM9BlDcGC68Hg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c83737-7137-4eaf-ad88-08db1678fce0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:08:29.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzySSTxk5l60huXPNov7lKv+EXUF1O8JtoOqOzvuAYtTYTbyFVEwinAQXjP27zZOr0QDEDxYorfg6BNhu+asJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-GUID: rixJvrPBNlFdeyiCkduM9WYP08lJe-w9
X-Proofpoint-ORIG-GUID: rixJvrPBNlFdeyiCkduM9WYP08lJe-w9
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-gpio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpio/gpio-imx-scu.c | 1 -
 drivers/gpio/gpio-mxs.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-imx-scu.c b/drivers/gpio/gpio-imx-scu.c
index 17be21b8f3b7..e190bde5397d 100644
--- a/drivers/gpio/gpio-imx-scu.c
+++ b/drivers/gpio/gpio-imx-scu.c
@@ -136,4 +136,3 @@ subsys_initcall_sync(_imx_scu_gpio_init);
 
 MODULE_AUTHOR("Shenwei Wang <shenwei.wang@nxp.com>");
 MODULE_DESCRIPTION("NXP GPIO over IMX SCU API");
-MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 7f59e5d936c2..390e619a2831 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -364,4 +364,3 @@ MODULE_AUTHOR("Freescale Semiconductor, "
 	      "Daniel Mack <danielncaiaq.de>, "
 	      "Juergen Beisert <kernel@pengutronix.de>");
 MODULE_DESCRIPTION("Freescale MXS GPIO");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

