Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFBB642CE1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiLEQdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiLEQcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:32:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18A2A47C;
        Mon,  5 Dec 2022 08:32:39 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Fc1ew007848;
        Mon, 5 Dec 2022 16:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=+EJgf+FKhVfVOHEciAku17ISGJp+6CdvI1h63mdLzHA=;
 b=USpY/yrsGbJPZ4xGN/249Gpnr3foF5R0r9/YbZGHWTDYlkzssnjUsAZcfJngyu1pe7i/
 5hoWfs/acPsHmF9XcCL3ADZ9vkpmHxPuTVzcCGTDD1YdSiAcTlxK5EKAOdKZU4Zjkk5r
 0Uz6fDE2APy1A7wAR9rESMBvxMcyW0B7XOA6a9u7c1vog8LZrRY1Xk508pK78Awzy5Uy
 KV8Uy8IBz5x6OzT4kdJ+gnkxoFuZxSp13abzQiyFah1KYsztf1wbnXlMorraex4PcOQa
 b8qILs38sG/1rNX7iJb8GyILJ8thAlOZGT9GIJ0OQ5yiyTS19RNtabRstTgisBi9XZ/A ZA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ybgmbey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQvuW009447;
        Mon, 5 Dec 2022 16:32:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ugeda68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9xioKqdgoMzOcb6lymtpau2dom5412VnbALqF6Ne7NnrEuyf284x9X90DFhP2IGVusYjjbNgqIhNlj4YnUVJcWbj9zTZpHd0NGpGcQfrnk2Tk+jvy1lKH4fTatVV7l1ZOckMAzTMEAy2K2y2D7dS6ImRGV3wYZ8dAALdwV8e0BXzU4X9kqxNJUGOSi2Mnun7Uon5eFh/mG/HnePTBwgW9bX6xDTUomaMrukvvgrrhCf4y0PAM8FzxYGP+UwhHMeKtuxlw0WO8KYSKgLIz+PK4V+35Y0BtZSVrf/wW6acS/GyqvjqvVYY6SLxLwMvxm/kBLo3+Cb5C/eabxpYR5Tvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EJgf+FKhVfVOHEciAku17ISGJp+6CdvI1h63mdLzHA=;
 b=O7RIkh+5bRVVj6xzvWUQMKRVri2BSf6TC0vBWJ/3oTdZv2dTatc6gbtEfXccopott61yDzRnzVrrFrGi9dZjqzmQbTT34JN43MbSl+kviTj69gi8vX6/Yuagk5uvp1x5x0eoll7LMKeivCbIBRwW/7RGUANOP05t2MFfyLON+r7MBe9/eV3xIazVvVg0z66zX0nmluKkeMzqlY/xIjmFesElY7DP+OQmnGVCS9pDyyf/9ciaZBeZwYAvqCcOgFMFpbyDaOnr9lGrYFdJpuYGlV7lv0MyBURSYHBAurEe+I4Hm8d76z2SNiBpkcUk6qPrpT2mNxBtRxq/gCnNs3Fi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EJgf+FKhVfVOHEciAku17ISGJp+6CdvI1h63mdLzHA=;
 b=e+el9rgVUANI9/MJfxikw944nPVcibPchjx1ZCgjhcjPHJD6FFga+vSQO8Iu/6tNAINclv4e/VLQ4vgmO23h3hJEzJ2nu3v5YYU+VeNyQJT7fcfZetXB+pE/3plL6aWDOnwYBY4IaurIj0HMSsGIAfWcfzDlkhb+PUSjCog7mbI=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DS7PR10MB7324.namprd10.prod.outlook.com (2603:10b6:8:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 16:32:31 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:32:31 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v10 04/13] kbuild: fix up substitutions in makefiles to allow for tristate checker
Date:   Mon,  5 Dec 2022 16:31:48 +0000
Message-Id: <20221205163157.269335-5-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0069.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::33) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DS7PR10MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: fce2952a-ccdc-480b-9cfc-08dad6de4e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1sLyrcH4sN6GthlPrPVZvHbjMWfK1oAw+JoJ5wwxsVgCb/kOzPenXo3Qiu/qhwi3jMMr0meyJG++3Ns5fpXtDnb/ygnlISzDAWiHYS+YkLykoDSUhkXluX2zPufh/H8IspthhPcEMZW3U/2es5LDJA2lond/UbvgRGJx58E20awyQsr6skFJVZ9Dqmht+KsZ+btJs9RlIv7cchAIh6Qm/lse3Qs5trs/lLBNRs3iTQnHAnsqe2TwSKRcU186Jv74PFD63GHoVTa3AOUW3uwFekE7HBlO0qFVIP/Z5yHslngrAoH+wUoqoZmBOFDa4MWRPhkGb5qGQxABKz2GhzCkOM9Qi1nv0kFNWSJUbOJCH6F4Gv+3ujR/b81jAVksNKEO1JEpEtHSx04b9/htVy5DypZ64TvG+YWqR6RREWDz2gl6VcFDIW8xd4sMrr7+JLtk3c1JwI6MThzXJNaK05FI4dA6PHOLgQVLkTyRNlWBksfe8zIFHevwx+rAuyaue/zSLiI73XQ6BDyanmup4rvpTxxTXkceNAplK8ecRFDOnEj1+lWXXUfKzL99lv7RPVfaaVBj6o02b2sWhoJaboRCDZ47NC2vmSJvYE/jGs0PQaTijFaKPXleheZD+nb3PRG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(86362001)(36756003)(1076003)(2616005)(41300700001)(66946007)(4326008)(66476007)(66556008)(8676002)(30864003)(44832011)(8936002)(5660300002)(6506007)(6486002)(107886003)(478600001)(6666004)(316002)(186003)(6512007)(38100700002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ng+ov+Hd8n00ofVrnfdtKpYDHtpCAmXoWfqKO6QrKBtg9+jfJVuMHxc6X3SX?=
 =?us-ascii?Q?acqAJ4M+0/xLEUaqUNyW71m1cYzyrKjiP20+f4O+qsyo+JmgJDoBHc04RBgT?=
 =?us-ascii?Q?1TUKH/BFGtZ9b4g3046X+H4TE5LAHxynwftI9oY2OlHLy2+jt86rpXyeq94s?=
 =?us-ascii?Q?iYz+u8UueVU4iQNUFE2Zjw+7rV3Q1ikOipm11Hx2oVIu/4XVFmxZiiiJaI3d?=
 =?us-ascii?Q?n1Sooo81G7WCK8EXCj2ROC4EKWaYYiLgTdSJX6dPCfC6fiHw2KkjTtj2AvrW?=
 =?us-ascii?Q?TLqWK0n+td9YPi5+edyrFmdfVK23zJ/cqSemtOmMYhdtxw8a37FQgLch/Hsq?=
 =?us-ascii?Q?TpyvrhMJ79LwfabowojrKOf5AU8Nhm7HwmrSwIXTHJSh27vxCJ4suk9pvTIN?=
 =?us-ascii?Q?UPqHDupR456hRU1HebVJKWYmbQbT7qtGB/rodPbON2tHWQ61oSSdRvR48gkn?=
 =?us-ascii?Q?D5ZA3OfRgErgDU5/VQ/2uaCxcJPA/uRIoSwZURzhO/VHYPVhDQYrfyxVZNop?=
 =?us-ascii?Q?AhPXbBKHRqNi/N5Ym7E9dxbhQm7A1xwfw9JzNW8lm6tuMfShDjlT4lTy8X5+?=
 =?us-ascii?Q?UKyhj9NLZr9iiJIhy0ek/rQpG0UMRg6AFvh5J90uU/Kxs8yMOHHC8L7rFwNy?=
 =?us-ascii?Q?ROPnlK2pVLDkHgDHH7hhWyzAdIZA7mDoUIphqbxGDq+E5nhZwViQ4R0km/kE?=
 =?us-ascii?Q?lUzdM8/Xcf9XvYukv9BKgPKj1eBKGPyysEgk07EoOekw/AMKcNZPv6mKW+Wl?=
 =?us-ascii?Q?yHV/4qXASjnfUwhxLJCBcVeiid6NOculFeqMSFLlQestmdyHwLT2ZjqoqQ4N?=
 =?us-ascii?Q?9tL8KurUu1m1B3Yrtxghb6qS+g9HX1anmXacF0LmQkwvTBuSa1yEwNod3Msg?=
 =?us-ascii?Q?DWYPnbsIOchgVU3GWvU6Viv17vhzwK/AEs+9ZvDTGpruBFAhLxSrSe/ukocS?=
 =?us-ascii?Q?xTHt9H2MASnUEsQCKw5kqw+lqDcdJEPV4I98BZ/glVK0OF24nrC+C5elmWUB?=
 =?us-ascii?Q?O/Uju/GJGhZVvu4w0y4tXz0aGp+5WjXO4JnOCVP/V2Oy18aJ82ke4U39rbHt?=
 =?us-ascii?Q?BtMmPy4ayFgDsXJXWFA9avWugEaq/dHQEyuYSl8CBocaDXtkR486+aJG7doJ?=
 =?us-ascii?Q?dUER2VouwHetFtAcXPu2FEEjZsIWF7DqZ6rIXtVSXVVY5CAhrKxm8HSE/0o4?=
 =?us-ascii?Q?lyAbc7OuCoBubTnEFIxZoQy209FiCX0En+0rGXlx3nwbLuMnnqbFzxRZu9xU?=
 =?us-ascii?Q?1Me0V92Gw5wSIl8gFZsOZVpoVmKUeYwRXN8x1NMQr8seJ2LRDRRrxGkpuhMk?=
 =?us-ascii?Q?+9py+ZIyXjRgGBvaouyAzt0DZfO/ISWKl8KEN4reKg1ghRUJSYRaHY3l2+s1?=
 =?us-ascii?Q?NmqDzWio0p9YnssNmy+Jel8cfEvDrgCxlv7h4i2xECLhNDPJmSKoUDROeApJ?=
 =?us-ascii?Q?AkEwF52OVb7I4MqRRCMCKHLvLGButlHJ8eB3EtBwaorwk9WcFIlLiizaWLoo?=
 =?us-ascii?Q?NZQD3NmcfhzS+VpkxA7S5twKXioJ6lCFvmG6EKH2TipwPij3ehbVQGBnsjjg?=
 =?us-ascii?Q?cKAH/2AY5musd1UG7w8vnaczp9CUDNQ8kfgilpuKjzXo6/rF3ezDVrtUmiU/?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EO0oWHLafYwpFJm/h8GD7wrE7mcW5e4zJDXkGlji6ORK49afZLylFcmNDB+J?=
 =?us-ascii?Q?M6HlDVYnfklsY8lny1ZAF0CPUjqLm12IJxFrZBrMn8EVaHD2vBoZo0wozCzm?=
 =?us-ascii?Q?+Q2yNSUaNc9ivkqPXNEAAaIlEu5FyU4vOLytEpR81qMg2oalngQTQrVLSS2h?=
 =?us-ascii?Q?8mcPT3GAtklh8o1Lhy7ayljUXLWk4q+VAqlFABjCJsMpIvDywQkX6dr0cIFX?=
 =?us-ascii?Q?+kSCr1wK32vyBKwBY1KqvUgpPNlUp0ak56qS74zz7RgRXuprVAvubX0wMDuO?=
 =?us-ascii?Q?Zu7iZzEgvKmbHfVy19hvof/VGpANEy+LmZiKKDcBmx1qrga2MLpd733wtvV1?=
 =?us-ascii?Q?shjF4UBzt9/CDWkB8yY5fkIft8U0lzqF25YJxVddIrGlsgqNRWY5jQCTtYAk?=
 =?us-ascii?Q?Veq/T1mwhitNTzaiiby7JZtny7+xyACDunZOcZ3UmsU06BMz+NgAofHAiCnf?=
 =?us-ascii?Q?wkUlbm5WD7ZFFFRo75Y7Gh1cczvBcHa5yA0CNMJqpJXHDynbUAsW1R60crgE?=
 =?us-ascii?Q?rzdff2j2vgVQKLcvzUppeOnmB7uSzMFCHstm4mtOxS1sJJDadL0U81Iz7EHK?=
 =?us-ascii?Q?c3yAtFk0ReCcepvEKapdrFshC3+eJZCWULPubiewcNdgivtNGehUVSJ9/17b?=
 =?us-ascii?Q?Bkdq/oBH1/t0YuIOWgK5PhU+zcyKGl+CVumB2S+dytJ9u8z70lc2M/Y6aARe?=
 =?us-ascii?Q?F8liE9dVTBDI0/6S5/nM+mOKfXmQ0Yqc33xy8z6YJmSI61u1ZARJ5QwHW0/E?=
 =?us-ascii?Q?FKN32PCzetkqZKlcCDGcrQWzcF0R0ZK8rB77t36RSlpcPVtGLF9I+fsrwkGu?=
 =?us-ascii?Q?4HHI2tpfnlDTDNblUXq/w++1J5tbOg0BuoZXe+6xnzVbN1gk6maqercuULWu?=
 =?us-ascii?Q?kwo3w5SdfOUEazEoybgDC2wdymEspDTVoEcFmY1jSl5BT+XRszHTmQTN8Bpg?=
 =?us-ascii?Q?MYDwYDggejGREVDTlDo4hpXlCJ4g71W40LryTZej3t8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce2952a-ccdc-480b-9cfc-08dad6de4e54
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:32:31.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItO+DuL6AnW78nnyO3TjPsxPP6oh39rqwG0nLvkt/CBPmHfCaUxAg8Kasf/K3WJEPHQnbfsM86he4TJz9/8QAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050137
X-Proofpoint-ORIG-GUID: 5S3HLZht5cFZ5jKdAvofW7VPnzzQ5UoL
X-Proofpoint-GUID: 5S3HLZht5cFZ5jKdAvofW7VPnzzQ5UoL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tristate checker, like the Makefile.modbuiltin that preceded it,
relies on running the makefiles with some CONFIG_ variables set to
uppercase values ('Y' or 'M').  Large portions of the core build system
assume that these values are lowercase, but we mostly don't care about
those because they are only involved in actual building, and make
tristatecheck doesn't build anything (the parts that do need changing so
that recursion etc still worked were changed as part of the tristate
commit).

But some makefiles that are not part of the core build system also
contain assumptions that CONFIG_ variables are always lowercase (every
one of these was also broken wrt the old modules.builtin machinery, but
now this is part of a verifier, the problems are more obvious).  In most
cases this is just something like

obj-$(subst m,y,$(CONFIG_FOO)) += blah.o

to indicate that blah.o is always built in even if CONFIG_FOO is a
module.  There is a new macro to help this relatively common case, which
should now be rewritten as

obj-$(call always_built_in,$(CONFIG_FOO)) += blah.o

One other case we handle is that in net/dccp where things are built as
modules iff any member of some other set are modular; this is now
handled like so:

obj-$(call module_if_any_modular,$(CONFIG_IP_DCCP)$(CONFIG_IPV6)) += dccp_ipv6.o
dccp_ipv6-$(call module_if_any_modular,$(CONFIG_IP_DCCP)$(CONFIG_IPV6)) := ipv6.o

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---

Notes:
    v10: new.

 drivers/Makefile                         |  2 +-
 drivers/hv/Makefile                      |  2 +-
 drivers/mmc/Makefile                     |  2 +-
 drivers/net/wireless/silabs/wfx/Makefile |  2 +-
 drivers/s390/char/Makefile               |  2 +-
 drivers/s390/crypto/Makefile             |  2 +-
 net/8021q/Makefile                       |  2 +-
 net/Makefile                             |  2 +-
 net/bridge/Makefile                      |  4 ++--
 net/dccp/Makefile                        |  4 ++--
 net/ipv6/Makefile                        |  2 +-
 net/l2tp/Makefile                        | 12 ++++++------
 net/netfilter/Makefile                   |  2 +-
 net/netlabel/Makefile                    |  2 +-
 net/sctp/Makefile                        |  2 +-
 scripts/Kbuild.include                   | 15 +++++++++++++++
 16 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index bdf1c66141c9..a6d3296f0c23 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -159,7 +159,7 @@ obj-$(CONFIG_SOUNDWIRE)		+= soundwire/
 
 # Virtualization drivers
 obj-$(CONFIG_VIRT_DRIVERS)	+= virt/
-obj-$(subst m,y,$(CONFIG_HYPERV))	+= hv/
+obj-$(call always_built_in,$(CONFIG_HYPERV))	+= hv/
 
 obj-$(CONFIG_PM_DEVFREQ)	+= devfreq/
 obj-$(CONFIG_EXTCON)		+= extcon/
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index d76df5c8c2a9..06777af02a78 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -13,4 +13,4 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_fcopy.o hv_utils_transport.o
 
 # Code that must be built-in
-obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o
+obj-$(call always_built_in,$(CONFIG_HYPERV)) += hv_common.o
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index 3ea0126a9a72..1f4f9ce02490 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -4,4 +4,4 @@
 #
 
 obj-$(CONFIG_MMC)		+= core/
-obj-$(subst m,y,$(CONFIG_MMC))	+= host/
+obj-$(call always_built_in,$(CONFIG_MMC))	+= host/
diff --git a/drivers/net/wireless/silabs/wfx/Makefile b/drivers/net/wireless/silabs/wfx/Makefile
index c8b356f71c99..9fe47f5a050a 100644
--- a/drivers/net/wireless/silabs/wfx/Makefile
+++ b/drivers/net/wireless/silabs/wfx/Makefile
@@ -20,6 +20,6 @@ wfx-y := \
 	debug.o
 wfx-$(CONFIG_SPI) += bus_spi.o
 # When CONFIG_MMC == m, append to 'wfx-y' (and not to 'wfx-m')
-wfx-$(subst m,y,$(CONFIG_MMC)) += bus_sdio.o
+wfx-$(call always_built_in,$(CONFIG_MMC)) += bus_sdio.o
 
 obj-$(CONFIG_WFX) += wfx.o
diff --git a/drivers/s390/char/Makefile b/drivers/s390/char/Makefile
index ce32270082f5..d21086e99528 100644
--- a/drivers/s390/char/Makefile
+++ b/drivers/s390/char/Makefile
@@ -34,7 +34,7 @@ obj-$(CONFIG_SCLP_VT220_TTY) += sclp_vt220.o
 
 obj-$(CONFIG_PCI) += sclp_pci.o
 
-obj-$(subst m,y,$(CONFIG_ZCRYPT)) += sclp_ap.o
+obj-$(call always_built_in,$(CONFIG_ZCRYPT)) += sclp_ap.o
 
 obj-$(CONFIG_VMLOGRDR) += vmlogrdr.o
 obj-$(CONFIG_VMCP) += vmcp.o
diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
index 22d2db690cd3..e3594486d8f3 100644
--- a/drivers/s390/crypto/Makefile
+++ b/drivers/s390/crypto/Makefile
@@ -4,7 +4,7 @@
 #
 
 ap-objs := ap_bus.o ap_card.o ap_queue.o
-obj-$(subst m,y,$(CONFIG_ZCRYPT)) += ap.o
+obj-$(call always_built_in,$(CONFIG_ZCRYPT)) += ap.o
 # zcrypt_api.o and zcrypt_msgtype*.o depend on ap.o
 zcrypt-objs := zcrypt_api.o zcrypt_card.o zcrypt_queue.o
 zcrypt-objs += zcrypt_msgtype6.o zcrypt_msgtype50.o
diff --git a/net/8021q/Makefile b/net/8021q/Makefile
index e05d4d7aab35..50b48af58322 100644
--- a/net/8021q/Makefile
+++ b/net/8021q/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for the Linux VLAN layer.
 #
-obj-$(subst m,y,$(CONFIG_VLAN_8021Q))	+= vlan_core.o
+obj-$(call always_built_in,$(CONFIG_VLAN_8021Q))	+= vlan_core.o
 obj-$(CONFIG_VLAN_8021Q)		+= 8021q.o
 
 8021q-y					:= vlan.o vlan_dev.o vlan_netlink.o
diff --git a/net/Makefile b/net/Makefile
index 6a62e5b27378..94165eb38b65 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -42,7 +42,7 @@ obj-$(CONFIG_PHONET)		+= phonet/
 ifneq ($(CONFIG_VLAN_8021Q),)
 obj-y				+= 8021q/
 endif
-obj-$(CONFIG_IP_DCCP)		+= dccp/
+obj-$(call always_built_in,$(CONFIG_IP_DCCP)) += dccp/
 obj-$(CONFIG_IP_SCTP)		+= sctp/
 obj-$(CONFIG_RDS)		+= rds/
 obj-$(CONFIG_WIRELESS)		+= wireless/
diff --git a/net/bridge/Makefile b/net/bridge/Makefile
index 24bd1c0a9a5a..4f3109e170c8 100644
--- a/net/bridge/Makefile
+++ b/net/bridge/Makefile
@@ -12,10 +12,10 @@ bridge-y	:= br.o br_device.o br_fdb.o br_forward.o br_if.o br_input.o \
 
 bridge-$(CONFIG_SYSFS) += br_sysfs_if.o br_sysfs_br.o
 
-bridge-$(subst m,y,$(CONFIG_BRIDGE_NETFILTER)) += br_nf_core.o
+bridge-$(call always_built_in,$(CONFIG_BRIDGE_NETFILTER)) += br_nf_core.o
 
 br_netfilter-y := br_netfilter_hooks.o
-br_netfilter-$(subst m,y,$(CONFIG_IPV6)) += br_netfilter_ipv6.o
+br_netfilter-$(call always_built_in,$(CONFIG_IPV6)) += br_netfilter_ipv6.o
 obj-$(CONFIG_BRIDGE_NETFILTER) += br_netfilter.o
 
 bridge-$(CONFIG_BRIDGE_IGMP_SNOOPING) += br_multicast.o br_mdb.o br_multicast_eht.o
diff --git a/net/dccp/Makefile b/net/dccp/Makefile
index 5b4ff37bc806..607f6d3dd795 100644
--- a/net/dccp/Makefile
+++ b/net/dccp/Makefile
@@ -17,8 +17,8 @@ dccp-$(CONFIG_IP_DCCP_TFRC_LIB) += ccids/lib/tfrc.o		\
 dccp_ipv4-y := ipv4.o
 
 # build dccp_ipv6 as module whenever either IPv6 or DCCP is a module
-obj-$(subst y,$(CONFIG_IP_DCCP),$(CONFIG_IPV6)) += dccp_ipv6.o
-dccp_ipv6-y := ipv6.o
+obj-$(call module_if_any_modular,$(CONFIG_IP_DCCP)$(CONFIG_IPV6)) += dccp_ipv6.o
+dccp_ipv6-$(call module_if_any_modular,$(CONFIG_IP_DCCP)$(CONFIG_IPV6)) := ipv6.o
 
 obj-$(CONFIG_INET_DCCP_DIAG) += dccp_diag.o
 
diff --git a/net/ipv6/Makefile b/net/ipv6/Makefile
index 3036a45e8a1e..b05b0e4668f5 100644
--- a/net/ipv6/Makefile
+++ b/net/ipv6/Makefile
@@ -47,7 +47,7 @@ obj-y += addrconf_core.o exthdrs_core.o ip6_checksum.o ip6_icmp.o
 obj-$(CONFIG_INET) += output_core.o protocol.o \
 			ip6_offload.o tcpv6_offload.o exthdrs_offload.o
 
-obj-$(subst m,y,$(CONFIG_IPV6)) += inet6_hashtables.o
+obj-$(call always_built_in,$(CONFIG_IPV6)) += inet6_hashtables.o
 
 ifneq ($(CONFIG_IPV6),)
 obj-$(CONFIG_NET_UDP_TUNNEL) += ip6_udp_tunnel.o
diff --git a/net/l2tp/Makefile b/net/l2tp/Makefile
index cf8f27071d3f..ff94be92a36e 100644
--- a/net/l2tp/Makefile
+++ b/net/l2tp/Makefile
@@ -8,11 +8,11 @@ obj-$(CONFIG_L2TP) += l2tp_core.o
 CFLAGS_l2tp_core.o += -I$(src)
 
 # Build l2tp as modules if L2TP is M
-obj-$(subst y,$(CONFIG_L2TP),$(CONFIG_PPPOL2TP)) += l2tp_ppp.o
-obj-$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_IP)) += l2tp_ip.o
-obj-$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_V3)) += l2tp_netlink.o
-obj-$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_ETH)) += l2tp_eth.o
-obj-$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_DEBUGFS)) += l2tp_debugfs.o
+obj-$(subst Y,$(CONFIG_L2TP),$(subst y,$(CONFIG_L2TP),$(CONFIG_PPPOL2TP))) += l2tp_ppp.o
+obj-$(subst Y,$(CONFIG_L2TP),$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_IP))) += l2tp_ip.o
+obj-$(subst Y,$(CONFIG_L2TP),$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_V3))) += l2tp_netlink.o
+obj-$(subst Y,$(CONFIG_L2TP),$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_ETH))) += l2tp_eth.o
+obj-$(subst Y,$(CONFIG_L2TP),$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_DEBUGFS))) += l2tp_debugfs.o
 ifneq ($(CONFIG_IPV6),)
-obj-$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_IP)) += l2tp_ip6.o
+obj-$(subst Y,$(CONFIG_L2TP),$(subst y,$(CONFIG_L2TP),$(CONFIG_L2TP_IP))) += l2tp_ip6.o
 endif
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index 0f060d100880..a6f65c956b1b 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -6,7 +6,7 @@ nf_conntrack-y	:= nf_conntrack_core.o nf_conntrack_standalone.o nf_conntrack_exp
 		   nf_conntrack_proto_icmp.o \
 		   nf_conntrack_extend.o nf_conntrack_acct.o nf_conntrack_seqadj.o
 
-nf_conntrack-$(subst m,y,$(CONFIG_IPV6)) += nf_conntrack_proto_icmpv6.o
+nf_conntrack-$(call always_built_in,$(CONFIG_IPV6)) += nf_conntrack_proto_icmpv6.o
 nf_conntrack-$(CONFIG_NF_CONNTRACK_TIMEOUT) += nf_conntrack_timeout.o
 nf_conntrack-$(CONFIG_NF_CONNTRACK_TIMESTAMP) += nf_conntrack_timestamp.o
 nf_conntrack-$(CONFIG_NF_CONNTRACK_EVENTS) += nf_conntrack_ecache.o
diff --git a/net/netlabel/Makefile b/net/netlabel/Makefile
index 5a46381a64e7..8052bd8e7af8 100644
--- a/net/netlabel/Makefile
+++ b/net/netlabel/Makefile
@@ -13,4 +13,4 @@ obj-y	+= netlabel_mgmt.o
 # protocol modules
 obj-y	+= netlabel_unlabeled.o
 obj-y	+= netlabel_cipso_v4.o
-obj-$(subst m,y,$(CONFIG_IPV6)) += netlabel_calipso.o
+obj-$(call always_built_in,$(CONFIG_IPV6)) += netlabel_calipso.o
diff --git a/net/sctp/Makefile b/net/sctp/Makefile
index e845e4588535..683a345f3626 100644
--- a/net/sctp/Makefile
+++ b/net/sctp/Makefile
@@ -21,4 +21,4 @@ sctp-$(CONFIG_SCTP_DBG_OBJCNT) += objcnt.o
 sctp-$(CONFIG_PROC_FS) += proc.o
 sctp-$(CONFIG_SYSCTL) += sysctl.o
 
-sctp-$(subst m,y,$(CONFIG_IPV6))	+= ipv6.o
+sctp-$(call always_built_in,$(CONFIG_IPV6))	+= ipv6.o
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 8042c067312e..701bbb499427 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -188,6 +188,21 @@ cmd_and_fixdep =                                                             \
 # and if so will execute $(rule_foo).
 if_changed_rule = $(if $(if-changed-cond),$(rule_$(1)),@:)
 
+# Usage. $(call always-built-in,CONFIG_VAR)
+# Expands to y if CONFIG_VAR is m, suitable for always-built-in pieces
+# of things that otherwise may be modular.
+always_built_in = $(subst M,Y,$(subst m,y,$(1)))
+
+# Usage, obj-$(call module_if_any_modular,$(CONCATENATED)$(CONFIG)$(VARS))
+# Expands to m if any of the concatenated config vars are m, otherwise
+# y if any of them are y, otherwise n
+module_if_any_modular = $(strip \
+    $(if $(findstring m,$(subst M,m,$(1))), \
+        $(if $(findstring M,$(1)),M,m), \
+        $(if $(findstring y,$(subst Y,y,$(1))), \
+            $(if $(findstring Y,$(1)),Y,y), \
+            $(if $(findstring N,$(1)),N,n))))
+
 ###
 # why - tell why a target got built
 #       enabled by make V=2
-- 
2.38.0.266.g481848f278

