Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17427076C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjERAKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjERAJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:09:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21C63AAF
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:09:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGuNY002458;
        Thu, 18 May 2023 00:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=5Maj2StIVSh2zLYYgSvMY23AjJhVuyl+Rkx7v0jx9sg=;
 b=kE5HVoxUr89QhacRt3YeuTnMxEdSUY4kDD9qxcuN1gyLW3tcpNeToHMrYm4Bm3Jz8vhA
 P7Gb3tS3g7/2OcyFK2KKiBFQkoF6mC4CaVliEJvbpH6cUrC5sqd9KieFB7dWVmBg58zv
 HjalQpHsKYdPZhykAAg+tDaTtSIIe5iyd5+x7jH+/fwMGM+vKGppIjs6G85Kjmay7eTh
 6CTCj4rq5VGiBd3/kgiztlq0BrbxCUcN9xTnqiRHzTZZ8fJmZTDNo8WG8/pLF6K16Enp
 k2CIC9YWGfG/veey1iSPoFK6fwrT+M5RWAFzxaAD3GHqfb4FLV0XjUWFxYngieGbsRI4 sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxps1drb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HNFIrl004186;
        Thu, 18 May 2023 00:09:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10cd35x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IO4rzFU+AMFGAHh42zz3NorE+k0gWWYvfnYIcZa/LG4GtpBjrEwevr6V6o/TYOJ+QOprIK9+jYy8MbtfPAt5pynDgVaSjo8ftmHhyTlVKMFc69BFcG6I5qpIkptaKaLVsZlrqf/psywPMCI+/emmX9G21pwSCm+yXqN4tyhPXxqRD0WSKoF0LIauQf/Ht6Yr8+pvzD8U/Yzvl16dvk0H2p7t8LVnwbRaiX30VOG8cyvmFo2d57VWG8YBuieN480PD4PjO0kl8yyLXoAwGY4xIyDKJWsdvT/qGuNzNs2x8sAr2vXpTmJUUUlpcon65N8bRM0yY6SrieoOsl3tm+cICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Maj2StIVSh2zLYYgSvMY23AjJhVuyl+Rkx7v0jx9sg=;
 b=Gm8CqcsVpZElIA1Zc/dY0l5TpY3OZGcVOvdwwjszpR4WWemrMA0qabejdN1TRfnpkFChFBkn0EO5v/JFlknE1wkNn2kUMeTmfIJH4iKVLoFaxOnzvd1J85/9sxL8FMdq2mTSEYCNrzIYZtcIOWPInujyl9hUCDDEqWPycIpCJFwiKdZUw5XR7YgxG47I+TYEnOhbAoJLCq9QIHRYcipXbv4EOw3l0S8i4fETzHFCVu+aeCXarSnk0AEQBVVfzFM943l1FbfQr5l0nvPPVlG/w/POn1inByzsANnkdLBbiAw/B1yBZ7+bfZwsSSekztPc3KxHUET3ArjuFbXabRWbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Maj2StIVSh2zLYYgSvMY23AjJhVuyl+Rkx7v0jx9sg=;
 b=bQ8aemQsPQLAKYXikWX6dP21GXdvC+ceDNVtpjqluSrqJO/Jwljza3kb13/XsVmtmsohPapwEKM8YlCt+xuq8U1rhzoxRkHL0K6qJCI17w+f6KIiHgc/1cwSZeCfHBoXVlztno9LL38KQLNWfFvVvvedld/IPqtcnVQnTE1YQig=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 00:09:30 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 00:09:29 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [RFC PATCH 4/8] vhost-net: Move vhost_net_open
Date:   Wed, 17 May 2023 19:09:16 -0500
Message-Id: <20230518000920.191583-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518000920.191583-1-michael.christie@oracle.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:5:120::41) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d882bcf-2970-41d9-dd11-08db57342641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faBddcoomc8c12dMfiS7injDwHIwNH4S9XKglDBrkFFLUy800kW30lShGDm+LQ5H/8WmgH+k7kTIz6A1ko8r6psTGMfn3ZJQs5WpFZF+ujC6itn0R2iWbnB3nLo9TLdQ9Gx3MYkq+4edgvcwuYzqGTiQfKJ1sfuc3lxplrXxIj944RhYVwUHzMz4tk/WrLN8a6YWnT8lro6oR5Cu75SNIv1sKDlBqrZodXfjTX/gUgcVgUy0ASijaOQSfkgzGTAIP00H2MF7+C23mk6p21d8T8uqwy4POxXM4fO0ZunZh/F62O82Qwwrs8+YyBPQIsffKhtt75/n+Vna7AmtMSRyyCMtiI/ivDKu4yiJgQcPlUwjmORURaPSZxfeU4eScro8Fn17g7mzSpq25WYqq/yZ4XJtdLLpe6LuuMr1p3nC32WZZ2j9nTMLi4vEQbphFLeuaXZycGCNa3A1C8LAzmyADHRIX2E0qjJylXbq56WU50yCAG9jDMJ3+YKbAp4JOXk+B5ONiBXh2dSfzDvzs1rYbf0UrQ/HNWk8qRxIImnXa0uEcUVKon5hgKxM1cS4Rv7VFXGbhJBCFABFA6Q/9Mp8FmpLLGRVpynlPnzWMY+AAbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(921005)(8936002)(7416002)(38100700002)(5660300002)(86362001)(6512007)(26005)(1076003)(6506007)(186003)(6486002)(6666004)(107886003)(36756003)(316002)(2616005)(83380400001)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TX2yJu8wyozRebIK7R3irGJ3Y4dE5MqIcXDS/uDigq2VghXIdIXUU5kc2iJN?=
 =?us-ascii?Q?7XXo2eplFq/F2e4ZJK/MLTYgCc98r1uMmTyoahpC5LD9IWiq6nzNjiYXOQUa?=
 =?us-ascii?Q?wYQgCMFIIaeXcRMkEort9ZI04RqwEIPOKw6flrFdrnb9d8HWaXjE6PIKSCfX?=
 =?us-ascii?Q?vxGatThzp9sqAvZIhkhU3UB5LWpV9Zf0LOnlOD/wygr7BEDIzbZ7Ug1JIPD2?=
 =?us-ascii?Q?7jeqDRnFkwJ78Kh6tHahttR39Eb4w0xSWo0L5nuxov9NqKMVBWv4U02X73JZ?=
 =?us-ascii?Q?5BPg9dqeiU93kMOs6v78HbN80Dllz6I7qfCODZmsVvZVVtMwidPDUTjSMU7m?=
 =?us-ascii?Q?moy0MfjMSuXT+XQVlQwWPmzpUTZqEYbtZPM8zKMbUk/sJrzuUWRuAShCsgy5?=
 =?us-ascii?Q?4OUXAt3KlNvrR9fOroMI65V7jXy3wMJ88JvX1GJompqW4FOxRsxEFtil9nNj?=
 =?us-ascii?Q?VwCq4Q2rJ32L7usa/3UHEAq1nRaf4d5Z0kREF7P/rTDatqwDGuCGeyBfO4tc?=
 =?us-ascii?Q?QZAZ3PzXpAE73XTxBvdywJzrGH6pYJreGocEoMdpAGzJ/Vj3IqaeXHo2snwP?=
 =?us-ascii?Q?Y37QCUH8QL9e2miWXmRHk2qc3P/oBuDGvZGXdUsWpZ9DqnN8A/8WMEHlZcOw?=
 =?us-ascii?Q?/Vbuy4ud8vWJMHsSjgGH0H4mPQrmQPykJ1pTk6S7CPqYdFWI0CwCGCaEscvH?=
 =?us-ascii?Q?VnmiAg3alB5ILdhioGviYK/gSXW/kU5/63cmxdKJaQ9gdM4VQ18cEJqcBEvY?=
 =?us-ascii?Q?ic+2wGTybRZdrpS6vZueDWb44X6ZnjVet8V4X5zCBQFDCan00LednUsg7fnl?=
 =?us-ascii?Q?ZAsfBVt0ySYzRAAWLO/fInCfBjUXHQrNlLVSCDNLVn37wiZRChT9SR4/Tmg9?=
 =?us-ascii?Q?pD3hREnaWrN8hVfHfSiJ8H9e+NvTwdlIMYuehFSzilWpCLI4e5rKsXKsEEFC?=
 =?us-ascii?Q?SOIPAZTnBgV4hHuBGJiW1jaZj7JZS42HoAwBFQQKuNPcD6dAQQJZwB5QR+7j?=
 =?us-ascii?Q?+rsrl+PGe5t42Lm69RlDk0WsOxr50fHsLhpKO9SMpL0kxVN0y2HcabXYZtdg?=
 =?us-ascii?Q?gHVm5ebreNRBkwmXiSipS/5h7l63dy4Yeg79kw8jhZzzsgUueZ2R1U1nLcan?=
 =?us-ascii?Q?18Iqke9LBUREGkTpLvrR6XsfoMeUddt8fCpHNJFZG8nrckdPFR+DjZVdatAN?=
 =?us-ascii?Q?8PgoFAv+HIo1vA49r3lRjv0BEZogH8HFrBQagDOuwf7Rc/Kd0WTjs8A7tj2z?=
 =?us-ascii?Q?fn1iTtXjSZAK6tOJApnqxLf9sGpmuLU0bxYjZMObe9L9wZt8uFVQ5jA32SkN?=
 =?us-ascii?Q?dvy8f3gzz14z1SkECRcuR4cl1tlpt+27zfiaVqNBdmmGOdyn3YMeX5zdnA9p?=
 =?us-ascii?Q?dALkiiJXX0psnnHVPEa1vIvOYklHj4ZnQRlsrWAYWR4GalBgXHAsnI5Hn5Sl?=
 =?us-ascii?Q?rv/d+9pW/AQcLS1FwZBziDjiigzcA76TcLCtcAp74a0q2OcSBOsf63Bb6i/E?=
 =?us-ascii?Q?Nc3e6K2+7SL21E47J+5iarZ0kV3n7gqvFArSbfqiALIEHjvH7s41a/bkmyFq?=
 =?us-ascii?Q?dFytFVKiZvPddjJ0NWJjm2Zvtasby8s8ZbjsNZrCC4QQynVk/wpLPzq1Tpng?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Bh9LhDKPFmA78GYsqRQBihXa6YjpWxOomr0Kdkm0ZlpxgF1pL7zG0C7WS7va?=
 =?us-ascii?Q?H/nw7QXdnzZTapgxzTF7a6zycmhrasxUDS6O1OoHLxEH6gIfZCTRcrXGaiwV?=
 =?us-ascii?Q?lMZuSjIM1uEstNDjStipwX8XQiiio1j8i8y7JD8vTbXsnPlRsjRespE49qWN?=
 =?us-ascii?Q?syECdxsotpSg6d1ewGWkwHlo4e1DHeXlea1qzWRYCKsC2o0A126NGQC6HuCt?=
 =?us-ascii?Q?Pz/cIPwZ1fpzcW2WcNAVV3vrEe9HWFkgUWCATLPzuKLzt0ELi0kB0gLYRNhz?=
 =?us-ascii?Q?7ZpqmFrNkylZZysSlsyRCpqLOdwlj8N/nm1d0LjQuE1OnwejJT7Wmti8JPN1?=
 =?us-ascii?Q?6AKuE0BrIHY/3uSGIqveK+WV7uzMgTskMMCLiTgFw6CIAKjJ7qXoAgyevoTn?=
 =?us-ascii?Q?qDe7/WKAj66br0dlrLCzaVtTrW8toHh4VMl2GAfrDLorHufgIMZCXFMfEFLl?=
 =?us-ascii?Q?rQdamFbW67XpaYpdnRBaYRgABYpuKV62tZof331m0kkatRM2ci31iAx9es2H?=
 =?us-ascii?Q?qJSL+Qf/5OlI+TZMfzZG14rxETT5dNT2Et1ylBaRsQGqjGJfNKlUIZvBARn9?=
 =?us-ascii?Q?Cdg4G178jbfFUCrT3Mzl4AtHQmOnbkhHpYgtSI/EfknZL3uTsY3j1FxgSw+G?=
 =?us-ascii?Q?dF4ZkbNGkZBlWnRNc1riOH6NFh1U/Syll8+g3Hr+/XBEdpdFBaCqbnyQQAj2?=
 =?us-ascii?Q?4eZinI1Or6Gm43aD4QmpeYTwgv7DykbYXwr64a6JnNfut680LL18uQUiA62C?=
 =?us-ascii?Q?lVc24wRfGY13WxqwqXAL0L0PEQD5g9qfe1xtgZMgBsUYETLCMFYr5ocrvGaw?=
 =?us-ascii?Q?DvtEznpfukzYxbtVADHmRM8iDGrd+umkgs03hrHaNPRHqmbNYtEark0i3yWh?=
 =?us-ascii?Q?JXWdljYhN1c7LXY1tRE2LNE197yFLjr1LP99VAa6Ci87WJ5YhRHqOcw3G2uP?=
 =?us-ascii?Q?IOdedkFOBwudYMQFGsiBsFc2ApdtbIhC0f5eD/cbmoFelml6/tjisPVJOn39?=
 =?us-ascii?Q?GS3xD0K++zLgLRCeOI0HO+l4qL6djvCo/DVchXpJzI6I+2J01BctVLG6aEsn?=
 =?us-ascii?Q?GewpRjSl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d882bcf-2970-41d9-dd11-08db57342641
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 00:09:29.6107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfcBwpvl92ljhfqtZT4CMJVlLsHoxfbUtvocImYAXcUKMEiEUtulEzhRXDGmFzgTncXnQYdaRGGYh977OIGomm661HaaHNFU/15yK84TUPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170199
X-Proofpoint-GUID: E8zxi8LsnmLnQpAoCi0HTZBfj2S7n4fE
X-Proofpoint-ORIG-GUID: E8zxi8LsnmLnQpAoCi0HTZBfj2S7n4fE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves vhost_net_open so in the next patches we can pass
vhost_dev_init a new helper which will use the stop/flush functions.
There is no functionality changes in this patch.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/net.c | 134 ++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 67 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 07181cd8d52e..8557072ff05e 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1285,73 +1285,6 @@ static void handle_rx_net(struct vhost_work *work)
 	handle_rx(net);
 }
 
-static int vhost_net_open(struct inode *inode, struct file *f)
-{
-	struct vhost_net *n;
-	struct vhost_dev *dev;
-	struct vhost_virtqueue **vqs;
-	void **queue;
-	struct xdp_buff *xdp;
-	int i;
-
-	n = kvmalloc(sizeof *n, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
-	if (!n)
-		return -ENOMEM;
-	vqs = kmalloc_array(VHOST_NET_VQ_MAX, sizeof(*vqs), GFP_KERNEL);
-	if (!vqs) {
-		kvfree(n);
-		return -ENOMEM;
-	}
-
-	queue = kmalloc_array(VHOST_NET_BATCH, sizeof(void *),
-			      GFP_KERNEL);
-	if (!queue) {
-		kfree(vqs);
-		kvfree(n);
-		return -ENOMEM;
-	}
-	n->vqs[VHOST_NET_VQ_RX].rxq.queue = queue;
-
-	xdp = kmalloc_array(VHOST_NET_BATCH, sizeof(*xdp), GFP_KERNEL);
-	if (!xdp) {
-		kfree(vqs);
-		kvfree(n);
-		kfree(queue);
-		return -ENOMEM;
-	}
-	n->vqs[VHOST_NET_VQ_TX].xdp = xdp;
-
-	dev = &n->dev;
-	vqs[VHOST_NET_VQ_TX] = &n->vqs[VHOST_NET_VQ_TX].vq;
-	vqs[VHOST_NET_VQ_RX] = &n->vqs[VHOST_NET_VQ_RX].vq;
-	n->vqs[VHOST_NET_VQ_TX].vq.handle_kick = handle_tx_kick;
-	n->vqs[VHOST_NET_VQ_RX].vq.handle_kick = handle_rx_kick;
-	for (i = 0; i < VHOST_NET_VQ_MAX; i++) {
-		n->vqs[i].ubufs = NULL;
-		n->vqs[i].ubuf_info = NULL;
-		n->vqs[i].upend_idx = 0;
-		n->vqs[i].done_idx = 0;
-		n->vqs[i].batched_xdp = 0;
-		n->vqs[i].vhost_hlen = 0;
-		n->vqs[i].sock_hlen = 0;
-		n->vqs[i].rx_ring = NULL;
-		vhost_net_buf_init(&n->vqs[i].rxq);
-	}
-	vhost_dev_init(dev, vqs, VHOST_NET_VQ_MAX,
-		       UIO_MAXIOV + VHOST_NET_BATCH,
-		       VHOST_NET_PKT_WEIGHT, VHOST_NET_WEIGHT, true,
-		       NULL);
-
-	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev);
-	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev);
-
-	f->private_data = n;
-	n->page_frag.page = NULL;
-	n->refcnt_bias = 0;
-
-	return 0;
-}
-
 static struct socket *vhost_net_stop_vq(struct vhost_net *n,
 					struct vhost_virtqueue *vq)
 {
@@ -1421,6 +1354,73 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	return 0;
 }
 
+static int vhost_net_open(struct inode *inode, struct file *f)
+{
+	struct vhost_net *n;
+	struct vhost_dev *dev;
+	struct vhost_virtqueue **vqs;
+	void **queue;
+	struct xdp_buff *xdp;
+	int i;
+
+	n = kvmalloc(sizeof *n, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
+	if (!n)
+		return -ENOMEM;
+	vqs = kmalloc_array(VHOST_NET_VQ_MAX, sizeof(*vqs), GFP_KERNEL);
+	if (!vqs) {
+		kvfree(n);
+		return -ENOMEM;
+	}
+
+	queue = kmalloc_array(VHOST_NET_BATCH, sizeof(void *),
+			      GFP_KERNEL);
+	if (!queue) {
+		kfree(vqs);
+		kvfree(n);
+		return -ENOMEM;
+	}
+	n->vqs[VHOST_NET_VQ_RX].rxq.queue = queue;
+
+	xdp = kmalloc_array(VHOST_NET_BATCH, sizeof(*xdp), GFP_KERNEL);
+	if (!xdp) {
+		kfree(vqs);
+		kvfree(n);
+		kfree(queue);
+		return -ENOMEM;
+	}
+	n->vqs[VHOST_NET_VQ_TX].xdp = xdp;
+
+	dev = &n->dev;
+	vqs[VHOST_NET_VQ_TX] = &n->vqs[VHOST_NET_VQ_TX].vq;
+	vqs[VHOST_NET_VQ_RX] = &n->vqs[VHOST_NET_VQ_RX].vq;
+	n->vqs[VHOST_NET_VQ_TX].vq.handle_kick = handle_tx_kick;
+	n->vqs[VHOST_NET_VQ_RX].vq.handle_kick = handle_rx_kick;
+	for (i = 0; i < VHOST_NET_VQ_MAX; i++) {
+		n->vqs[i].ubufs = NULL;
+		n->vqs[i].ubuf_info = NULL;
+		n->vqs[i].upend_idx = 0;
+		n->vqs[i].done_idx = 0;
+		n->vqs[i].batched_xdp = 0;
+		n->vqs[i].vhost_hlen = 0;
+		n->vqs[i].sock_hlen = 0;
+		n->vqs[i].rx_ring = NULL;
+		vhost_net_buf_init(&n->vqs[i].rxq);
+	}
+	vhost_dev_init(dev, vqs, VHOST_NET_VQ_MAX,
+		       UIO_MAXIOV + VHOST_NET_BATCH,
+		       VHOST_NET_PKT_WEIGHT, VHOST_NET_WEIGHT, true,
+		       NULL);
+
+	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev);
+	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev);
+
+	f->private_data = n;
+	n->page_frag.page = NULL;
+	n->refcnt_bias = 0;
+
+	return 0;
+}
+
 static struct socket *get_raw_socket(int fd)
 {
 	int r;
-- 
2.25.1

