Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E746CAE67
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjC0TR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjC0TRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:17:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D001721;
        Mon, 27 Mar 2023 12:17:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RJ5Kmd008836;
        Mon, 27 Mar 2023 19:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=DyQf1+mmfNAtItp04y3HdJ554+++s0Sgg1tKKOc2Jcg=;
 b=l6dCPuMn211E83sf+tgGUDzhw97+zCuTWv/uYEHVvZujkGQErbssC3TKkkrpOszeuekQ
 O1j7+r+UD6lIscqnxGdFwAf563cy+GiYOiITy0ZCWi5UAPN0qUirvfZHjIA1vBdBU6W6
 Zi1wmZXxjebSA3OP+K45MSYBQCm+QW87LnvEMbmLoz+mAx9wjxXRdgqPVBtws5v/94EO
 zTK024ZY4phNEinGCuIVvkhgo8UrAPxdlCh5bhc8H2uTDAWVayPe3l6MX5xfGo7u2QlT
 ksMCI1Qs9zEoYgGcm3cRyEXzFJp7VMlLy+J/kiXaJ4Lz9K6gq2kKlcOd7Y3ZEp7VmSVS XA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkgytr0r2-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 19:17:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32RITinB019759;
        Mon, 27 Mar 2023 19:10:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd5n09d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 19:10:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rx8U5yxRgxmAaA+3VkIu2lUE9/+eOEHFBe9FgUajK1fF4PYUSFh3C/uo+3fbirCZE5iLzy52wxNVRynY+3ozV+ipegoFquyXbVt0th04THOqX8ahd8vOldmIF61sj7Cjrv/FBAy8r2Yw9ZBiJGh1Nh7gw5TrETrAt3TbEXTKdn2TE8zVyf0BDaNkxNiiqXYFGYuLLsfvmEWUt1xtutlNgf85+m2ljGNP9aigbhpXfhkF9LdGacODI1xsuGRoJU5PHVYRoDlWrLQLMgJsnGYZWPLDDIyyMxMD7VvcdNYJFOyfG/5ylmg3IxQMRI+6rIXXlAQ6LJ+Jhj4ZGH5ro0aGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyQf1+mmfNAtItp04y3HdJ554+++s0Sgg1tKKOc2Jcg=;
 b=e6TtCqktGdXf43f4kXRKznggqVxpWo8FgJnu6S1fB/Rf4vaZeckeLvSnKHPxOLU/PeRNQgh0Y7HoFNvv4tVFldB/15hyVty+abnMR4W2S+pwpOv7OJayJB167kA7eSoPuSUbkE8Xjc1tnAepM2GvBdFG5THBw2f1vp1cnEDXYIWutPsgAlAlZsKnAWGnX67TbQ5sO1eb32/gs64XSKx6eWOCly5Lx1+4KjnX8H8npAZSFXZNZJtJdgtwjJqnhviIzY4EJAMpN1bSWevvLTAdleGnwnjfC8BYKcF9PbSEwIRFX9GapCg6HXfqDqgDJjYuwK9+szW89GgrvVZMSIA9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyQf1+mmfNAtItp04y3HdJ554+++s0Sgg1tKKOc2Jcg=;
 b=rjk6Jp/xv21MM6OJke+nmyUJcujueiSCdHdwReirrNs1t8+KF7k8nk/G9lwhKoW0/CDyWC7sIghWVZvoFwrf8slSvpH0gDeYc0vb9Q5cfk+6IBK7LE8hjVZtTEhFUtx6UWBVjraFGk5fZlc3RqcOFlmq00RGPwAk1lSipyKvsIc=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:10:41 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e9ed:8782:64cb:cfc3%6]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 19:10:41 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     rafael@kernel.org, lenb@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        kvijayab@amd.com
Cc:     miguel.luis@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH 1/1] x86/acpi: acpi_is_processor_usable() dropping possible cpus
Date:   Mon, 27 Mar 2023 15:10:26 -0400
Message-Id: <20230327191026.3454-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230327191026.3454-1-eric.devolder@oracle.com>
References: <20230327191026.3454-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:806:22::10) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CO6PR10MB5538:EE_
X-MS-Office365-Filtering-Correlation-Id: f385ac9b-a4a2-4287-b550-08db2ef6f522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRilchcWtJEEIun6zJ5sy6KMH5r1U1TCWNiloRkaUMZZyIRgMXQgaTDEcmM9FDp91kjuQot6rx4hhXC4jXUrx1zuGKqY4OVYKtgBsh1pWHIWb5V6tmNjEwWNfyw4496VdkqJAp26v7VOrtrw/hWnZtFljP9mrFkgIlmiYPFhWlxUTIJoim+Kq/sjDj4nQNA9rmKX+d6JSqcnmXtC9lBgPP4ndXumNk8IMH80uiKdXsFTb7L3RyL5XCC0RQxlNDOrJo2wtif/7eJ2h4nBc3vNCVGrT+TNDdEr+z0ERYm3YV6wp4g39EP62xueu6gzxP47pGVkkryqWkt7iKwU5+uQ202kntEhHRhXcv5rCVGEfx1sEbUXR5UvKSyEiLnDEnF7+a5CJUYl/6+HweW36mXo70zZ94rthBVsvFwThGO5ikR6LUGXfmngMGX+ESK4WB/jqBLKUuvOmONNFnbDicHP3TAGHUR9xrX80N2gJYwWB56bvXU/lanm7GbRbieDKluNzaBRJNMNexOOigYzCSp1+yP7GxXMzh5iWeg7sB0/LU/4pXtArwaEIOyROnvsoK9ZA/xo+WOr+qstyliA/m4atKiHsTRlNTYPKHwe8M1Xx9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(107886003)(6666004)(41300700001)(6506007)(6512007)(1076003)(26005)(38100700002)(4326008)(66556008)(66946007)(66476007)(316002)(36756003)(86362001)(8676002)(478600001)(2906002)(7416002)(8936002)(5660300002)(921005)(6486002)(2616005)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jG3nsQQL7JbereBXObEI4p1EWVymrBZ2gqexpMMiYQaimGD76zrI4cmZBOk0?=
 =?us-ascii?Q?S6K/EMIjCxYLliUwllVnfFGjqEIGwLs5Uj+Y8H6DFuYluMTexprGYnPLp8yE?=
 =?us-ascii?Q?Iem8Gb3gqEk8flEzM61uQ4uRV4uUnv/K7cqEi7LXrfRAyyG0eJda4bHVPpwx?=
 =?us-ascii?Q?NSJQnLRteh1ksyQlXwbV1bEN8jB1F/2IwCFmwbflfFMjcFO+YoTB0hx0EVD0?=
 =?us-ascii?Q?xloj/jJJB9uuxkYW/rajeu/1LutbyHees3c2md4QnzNiFtcGS5miQA1dId74?=
 =?us-ascii?Q?kXrPQ8PNDdKXun47YQztjE+/a4b6ch79sCmHm7cYA2T46QhbrRD5FiIzyi1h?=
 =?us-ascii?Q?6P35cfpfgYTZ+vOW0jRPTeNMFy5RLt6lKfmVqjInjxVmuqAODKe7nSOwWVOq?=
 =?us-ascii?Q?bh3QEtwSOqtUAqoATsHuvprxhl9hh1vhlt2Y6dA5Jf7FkFOYNzKg6Z7AFut0?=
 =?us-ascii?Q?xCnpqingdbbLkdJM3IIHObXiL2ClQ9iA0J4zub8ZCdRR1rZmYOEsIcx6dCAk?=
 =?us-ascii?Q?zn5QvT2UIzfi1Qf/WniDZRLT9ovPP8GMmtBybm+nETOHTFDXxFw0fVTxTuZ6?=
 =?us-ascii?Q?BnAU3C4MEzhSqN6So6k9eNMVfrg3nYgwBGNzEIvvcAYb3haSNkPs98W/oMan?=
 =?us-ascii?Q?YYr62qh+ye57U/XyAB48jGGcVK6v7BgMuexWcEzdQJ/Z4IvA0mhWZsAiHdHH?=
 =?us-ascii?Q?jH8SC+QTNU3IWRqx0gO5Jn6KB89Su2xzWuqksDKS8SCn2RiQ3YSbJE3eYCSj?=
 =?us-ascii?Q?AaGWxQSGUQ3pvdfAD7z6l5zLCnNYwfIsn1lxlHrpDj6/XFI0OL4kvUGcW96V?=
 =?us-ascii?Q?3f3yXVu69/4rCaDWSxYuqVBXI2Wl8THfK/+OU75pAN3aaIvmnFRBn4cqjiLf?=
 =?us-ascii?Q?nydCLcBKMuuZv4Cn/HtMNMJGfM79mzYhrPIgNlt1GAH96lmQbIN9F+4BTVXA?=
 =?us-ascii?Q?ByYB7pl0jz3wN8LAExltER50oR7Qqz3ACsHPmaGs3aWsjMBW02UauZqm6HkU?=
 =?us-ascii?Q?O1XBnV/N5lT6L6feuZ4o1y8v58hCIjILkffoul0zpXZktsH3VWxy5Bba+6Cu?=
 =?us-ascii?Q?N8jxU91+hUj1v4ewN0FNdLTY8wTy1J32NK4oy+DrkwY0h5ztzEPbCmvQ2HUr?=
 =?us-ascii?Q?sTW2Wut63MAn4cfa5ISL/3a7YBdHiJRJ/9qpYGNQxnCkMldC++gnqsCzFzGy?=
 =?us-ascii?Q?u2OOoDR/AzIc2t+JcJsXDK9YCQjYmumWZCx0BVvvaMcDh2EaBW3G4Vsj4Zgu?=
 =?us-ascii?Q?LQ3CuLKY98cviwPMB9bz46MGZ5o7eNeplD5yZff35MMOpLc6K3iXIl5hNmPA?=
 =?us-ascii?Q?R6JcmYf0P24ChS2+0kMpf25tCsCuOdhQSfkk7WOKsjsuB6APp76gjpxUY0+F?=
 =?us-ascii?Q?Bzc7G5OUaN5IvdpKJxVNI8bZ9C8WVRQXdaBXCVd+6tqRJRtVGM1CohxC1HQf?=
 =?us-ascii?Q?ImBuwXeUUjaBop9zHFe1ThJLQB6AXrc0wwT0uOciApsh/LOOU0MXa+9UvQX/?=
 =?us-ascii?Q?8MpLJCicvOLpTvt+5/ou5l9jstmzA15bZ+l2V6pzXistXiiEcrKHMAF6axBE?=
 =?us-ascii?Q?S6Yif7xuQrAgU3pwY1Y+fpr8BYczb5DC08s4/Mid9RZdytb8G1ki6gKIP09W?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DKTcU1BdQJ7S3v2ERDs4yYVD7T3KcUwoEtyk3hwVg7j9V53aJ3e3c3cF7wVR?=
 =?us-ascii?Q?4aeRCiggUHP/EOuB49hlVEEa7bC5CVNMoI6GWfgCmFaQpMSydl2fh0zW9eil?=
 =?us-ascii?Q?l3PCbgPQsg+fv77IoNkeyOeulWw/I5JDxtepBb6u1CnjdqXqQNCizNAeoOy2?=
 =?us-ascii?Q?ulFUG0bZfto2KlRNGpxtTZNgI4E233lWihU6soeKRLId2y1D/Rga9WyvEyA9?=
 =?us-ascii?Q?9JWuUfGj3/oRgpc0HfQRQ9WmEryhWN+uQIFn8pLlaK7aeZFErC+DJAsLfNV6?=
 =?us-ascii?Q?saTDhqgzwnhnPIXFWQmGxWtDhvlj4iwQru4NJhn3Da8lTgUcSqoLb7qXrw8f?=
 =?us-ascii?Q?5VOVYiSOzZ/kbJGfeRyyr4VkvW34Pts0gQ9y0k/424lgQBKs2lFsLx4UnNr+?=
 =?us-ascii?Q?aCYHyfZV3PbKo8IKkGJaa/DQ3qxjcbu797U2Tt39bply/Db3v+pLR/RXJTRS?=
 =?us-ascii?Q?rTv/68wIzx79hLZeq/nL/k1d2NDGl5e/Gam52uzJgHbJxGA+OvtPq5XU0GTj?=
 =?us-ascii?Q?ibdnW5tzDY2I7hdvLGAi7DexbRGLoxjna90kG22yx9ax5pyhvBRo047cX2pF?=
 =?us-ascii?Q?hA3YGdh2jpdi85XuQV5ZYLeiXg9BMwcg5Do0b3yYpW3/fWYDleXzg5hVg/xH?=
 =?us-ascii?Q?CWZvyt6TxiUsLVLE7xg90q6ooujXe836ox86Oq2UtJhmyJzp9JBsVKL4hkUC?=
 =?us-ascii?Q?+l0kl/QLShCqhRV0ieP+zjmj60CEtQbW0t/roMJ47OCwz1BXNLiD5RAjRbLW?=
 =?us-ascii?Q?qkBswFVk5/is6aJ8paRw98ibacX+F7dPjHfGqhckbaYxG8o9FXgnyGW5JJA9?=
 =?us-ascii?Q?WKrdLHKck+f7yQc0KCAwteybN/FzJrQ+6UWS+I1zuPPDQgYZU+jHU5/7JJZ0?=
 =?us-ascii?Q?hBNiq90nO882BWccF1hh71MIzVZgw537ie8OzMQoiadoa0ie21RPr8pDsDZV?=
 =?us-ascii?Q?wlw8sjijLkDgWgw8RbHucY28xqYEnSL3+bl8ntg2EZQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f385ac9b-a4a2-4287-b550-08db2ef6f522
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:10:41.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvv8CyjQYuxhtJAvv8KnI82/yTORFVRf3iBh2/by4VYUqQpMhl1sJm8gaMVwgp3EdvzkQ8NDGO2LQeBROdY0SOYfyMtiZtS20MVz0hsBhYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=970 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270157
X-Proofpoint-ORIG-GUID: PHqgH0EoLbTP6PDgJKHWl_PISscFUurp
X-Proofpoint-GUID: PHqgH0EoLbTP6PDgJKHWl_PISscFUurp
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic in acpi_is_processor_usable() requires the Online Capable
bit be set for hotpluggable cpus.  The Online Capable bit is
introduced in ACPI 6.3 and MADT.revision 5.

However, as currently coded, for MADT.revision < 5,
acpi_is_processor_usable() no longer allows for possible hot
pluggable cpus, which is a regressive change in behavior.

This patch restores the behavior where for MADT.revision < 5, the
presence of the lapic/x2apic structure implies a possible hotpluggable
cpu.

Fixes: e2869bd7af60 ("x86/acpi/boot: Do not register processors that cannot be onlined for x2APIC")
Suggested-by: Miguel Luis <miguel.luis@oracle.com>
Suggested-by: Boris Ostrovsky <boris.ovstrosky@oracle.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/acpi/boot.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 1c38174b5f01..7b5b8ed018b0 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -193,7 +193,13 @@ static bool __init acpi_is_processor_usable(u32 lapic_flags)
 	if (lapic_flags & ACPI_MADT_ENABLED)
 		return true;
 
-	if (acpi_support_online_capable && (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
+	/*
+	 * Prior to MADT.revision 5, the presence of the Local x2/APIC
+	 * structure _implicitly_ noted a possible hotpluggable cpu.
+	 * Starting with MADT.revision 5, the Online Capable bit
+	 * _explicitly_ indicates a hotpluggable cpu.
+	 */
+	if (!acpi_support_online_capable || (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
 		return true;
 
 	return false;
-- 
2.31.1

