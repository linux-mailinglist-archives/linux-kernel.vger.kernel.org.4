Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2A76A2179
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjBXS2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBXS2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:28:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDAF15172;
        Fri, 24 Feb 2023 10:28:17 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEoQV2007421;
        Fri, 24 Feb 2023 15:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=t0OqZoo27ysPN9Ov/36W8nrlMlUS/kzBHEeVsqp0YQo=;
 b=jJTsS1bFLPP9EQ/CThxOYJogsGHmEXV8r4EoiPIo9q4xfULIEnDcw5mywVM7ZAixEbm5
 Jt/TFaGX/a5f9gF8p5QVzflMV6qdxle7EPRy7sjtoUoSQYVrHU17qqKpdwj88kzFbgO+
 tmzYTloa98kh5MQztW+uLRWSSUQ60DVVBA6UIgLZ+N5Eyb3ehrOVTtjNqwy8dAFFy99D
 n2wapAKrnAt+Zkyi/uVXh2E3TTRHKad+hTIzIL1dJxny6vJ66LSsVJV8zHNZ89V6+VVC
 xG3UB5kzthFUScBkrW4zwFQchhlzyuHVbrjDSyDTPReyY9RYjetF+wLDyzFgXmUBUNQh yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn90wb66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:10:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OEFH2l025896;
        Fri, 24 Feb 2023 15:09:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49kg7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3Sr4vUy4jhJSEqXH71sEuO/N95Eto9yyaqcAA+C3fRA5pnRVH2ndnhH01BG5UwwK9Kunzu8BYb0zL1nPCFupbZcVQA2PtN1dX8Q2iTEWMEHREuTspy+alfC19A/Qpf76iOtDbqTwVBTkUV4LNd/KAbxTltvrcKC5SNWbiLQ0YwvhannrJEII2Duy1RQfyM9pafNKZLuAzPxxXe48marh7PpPvqO7he4ChReMevbOwDEeZxoQ6k/Y/jeMs/Xkkox5rdPtE6vxjw8GC9zBtlDp2sVkLIdFDG8R08m94SM5jbciiF8fLj2wVcSzTlrx4Pq7mpScalDvRBRxkgmp3c3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0OqZoo27ysPN9Ov/36W8nrlMlUS/kzBHEeVsqp0YQo=;
 b=B4kFY6fb2p5W4QiR7lzkhiVkGFSyYVgV3fZHlOxx2vu5rR9saFpi5Ves+iL9CiJbDfxJXhNG7w+FwoOpgHb6712s8jz8VW03pCS7/73mvfsN4vK3m5mdMS26Aj6mhWkZ9dYBTjELQM8r0vLokYlpwBUvsqG3toD3OnTZ6z7qrv/+rus90pdIJZ7rzw9piN+SfCt7gE5QO/gJB5Qzg3BpcuhucKZjcN6bni+FYkavlFVVZ87hWh5qvFwl7AnD3u7w/qSdcGBt65c9l3bmO9xc7ToVCcRMKq/gwmCvvotYAnNC0QYQuV/6Y0e9V9051P0cU6x0IVZSoQgMV8QYczMzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0OqZoo27ysPN9Ov/36W8nrlMlUS/kzBHEeVsqp0YQo=;
 b=Z/+Xbh65eUsYM8iAPxnTDoP6pBhCOFIGVHLiNpJNIxycRWCU9gZEmBYo8ACX0Z/QX+aAEbznAHwdrPfzLzF7ez+HBWWkU8kwAM1AZ77n8o60RZxg9uxlf+cZQoGLTwEZWaxvUim+qR8DtM2e7BWy54Mn8Qwakg77zzARZ9syEj4=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH0PR10MB5244.namprd10.prod.outlook.com (2603:10b6:610:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:09:57 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:09:57 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Lee Jones <lee@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 20/27] mfd: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:08:04 +0000
Message-Id: <20230224150811.80316-21-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0040.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::28) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH0PR10MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8635b2-0179-4428-2185-08db167930ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRExDC3OS+ByYaSyfXFdtWaenVhFIyQnusLoYv/uE3bc2kvlXWe23i7w1wpYInqU+LXgA6g/XZL/d+V8l4v7wksf0SW9zxl6WcllJu6VNsx4U9M1jpTl1SW/QlEfRe5mQE5CvXQadNfTK7z+rW0I96ejYz8Z3q8ZNssX8nuyUKdQrjKlMpwcgBByoe+zIvlv3pTCF5RQ5uWwRJUBkJmGxwdKK4HUCDIVh4Kgs/mGwjty1PBZUxOWg8iyNImKb/45SJ7QKwAm1I2hm8XjoQd6mBuOa9Easz5ssP11Rgsitvst7uxsbnN+3LxaXNB8TxbH7T4OgkG+V1aHZ1kJ5DqVOkfRyXwYgFu9noyEzdkShGkKM27g5r1a6jJqvmAmpNZgU19GRN4WQORocR4WxHveZnNE4F7+Ym+MQU+0LE/iUEiPn0eOqLnmaLwf44YjajE+mNHPYfqFGK+rLGsDM/+JJuVBra4YFr7NvA5sTfu7n1OyujXKYmnIM6T9AoPPrRIE2pK/htYQ0zuLVYh1yBXfw57z2Yvdriz6Jn42cV4dXx+tLSkCo0wwmkMN6HulNtbIdVBuIB2lojpPSMCoTFGqmBlh+fIpyh1iJHzqW0PYdCobP5EgfSqQp9JBrVRkRkkXAqpN9Hc3G9ARZRElwNgY1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(54906003)(316002)(6486002)(8936002)(66946007)(44832011)(4326008)(38100700002)(41300700001)(8676002)(66556008)(6916009)(5660300002)(6512007)(83380400001)(66476007)(1076003)(478600001)(186003)(6506007)(6666004)(36756003)(2906002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aaiI0UlhXLaC9juAH9HUWYvdvbdPyJKuHZRGKwsd1EgdH7+lyzqeFyLkkvZN?=
 =?us-ascii?Q?SF2kWueUgbBemfO20/o1aBHRgxGsh4Yhvce+qb0phm1ZmpT+fcY3yHvgppP2?=
 =?us-ascii?Q?anAznd7PO/RQBZBRxrFLa5NWmiBYZT3NZFk/v9BhL1r0YCiGBH5gVl9BgkbP?=
 =?us-ascii?Q?iARWD5SprhFXacmMyh8Av3Rk8YeKD6YAcH+Uvt2oBFKDCJqE8omr3z5ScfT2?=
 =?us-ascii?Q?WbprxS1+dIlBQzrzr+D42BToty3mvk45Y01mXWQVmT6oBeo5CoXjYS++e3RD?=
 =?us-ascii?Q?HpCqyYY5XLTOptxkYDNWTScWl0ymbIqP3FObdFa3fvOfh1n+/GDaGvrTAOYN?=
 =?us-ascii?Q?FEWS0dc9uhrOFXQCXe3baL36wk89nv68cyesNvoDTvyygG6NNhpYcTUupuct?=
 =?us-ascii?Q?sy6yO3sKBLliDjxbFKSlqldc7mOhLsPGxCmejphvoHVkTC/QEE+D1SXstoAu?=
 =?us-ascii?Q?+5vfoxb0SNa69eE2CZceTTvV7nduhAHT1yn9IvbEnKvKxD+JTgl5mi98yUap?=
 =?us-ascii?Q?vNmcAFPDizHvyGPop1EYp1xyNG531h7WNibUYVC/PGEkd2IGgFJtCZP8NHVD?=
 =?us-ascii?Q?w5N1qN/I1RXdDuaovV/aRA3CaxPu5dK/rUjYlLtIgygFlpO8CrTWP0QGU6aY?=
 =?us-ascii?Q?deUaDwFIG1dsZctCsR41wQSaOmFyIU7JDmDukJLeQx3O22GYFu2/bGWOTnHl?=
 =?us-ascii?Q?aD7MvpHqe3PfLLpchZkz5CDAsiZ61ZvLaXLUN+C9Y0v/ZMEYzkFudXqgvQUi?=
 =?us-ascii?Q?WNm+i5RprOENsEXAHxaG6gEOZDW6MbOAh/kz2mTA1k35cDIgjUxIOD5tCmz7?=
 =?us-ascii?Q?9ASLVBu0wnOaXBlxN8rjk27WbB3fyZ4Kzv6iPZi65ZnDRa2tn4P68wMFln8F?=
 =?us-ascii?Q?aEJRi3Jh8uSUZd1ho0x31xyU2aeBx6lOkhdthZkgSEdDBFweFGsIEbJDR+yM?=
 =?us-ascii?Q?v9UtrO5JL5B/McVn30Xv6wUGBKEsaLxg7W1a1B7v8vJBg2grK0iB8jZHi+QW?=
 =?us-ascii?Q?255ATI7d4eIF5ag5oyTupVAbSGQO1FUQ78Wwws60VKHwGrLklQCq9ZTYguUB?=
 =?us-ascii?Q?BoRLanbmg674moYMjDBjK4ZFpRJBtpWMbQ35coEq2E7WxSb0xzxX2vFw8raf?=
 =?us-ascii?Q?eOOLagDo2kyzD8KuResH1j+Vf4LVCcVnC/zuXj/1GtDe6vAuVToGxRbpGI5V?=
 =?us-ascii?Q?qdX5E/VqLaRnExgTsExamDvjphIMS/O9f2MlUNqIbkgeex+Up0PfHxMuW8nW?=
 =?us-ascii?Q?q0RcaaBMwtC4Pbr5fpgXKEmREgn/Aki5T1P/u1fl/qvla06PG0XBbJEcNVs7?=
 =?us-ascii?Q?Nyo5fAV2hPn7jZkBxNXMZ/mq3hLojULeomQAjMIaQVPWkWJZ8oQkCUrxwGIR?=
 =?us-ascii?Q?xOsoIxKPQQpN82ifpAxExRYib1B2ra36apw2BkfjUQlZ2+FzlrZA0zpTt3p7?=
 =?us-ascii?Q?2kag6yc6cpJiz3hDJuPdG4OiZD7LfTrWFTB3q/ZGBRvHarL3uwLSKxfi7Y6I?=
 =?us-ascii?Q?u61sozoKsh7TRGLiwYZ43p8RA7gYLK5CZFKUHTDAGoXgJ+F7k+t+Ox6XewME?=
 =?us-ascii?Q?8VDyiT9kCm4EGO4ImcNlTN4T3WvcMaBU+dlClWgna3dToYF0ItfGF0A0XeTK?=
 =?us-ascii?Q?3nsDEa6wGXcfcmzT7OnqNiQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0IhGtNYgUTKJN9tvlgHNMwb9tJRNpuB/ZD1OIefxKm0j+iUHkwrFCNYf6PLG?=
 =?us-ascii?Q?M4UTdMiD/LKB6cpZim1m3nKXnNfFO1Y2dqrKr68rHT48wAegoYaZR9RgOPdx?=
 =?us-ascii?Q?tjlVz5Jn8AwMf39tjJLFlZ0rlvzHZg7jVxZaLgvsHCuDmMA3PlYux5hgYYwV?=
 =?us-ascii?Q?c2mLOoWUbNV+h2aA4l1iJRhkBJNpxXrw+zObp/K3Ve82wEqEcOP5WddrPcM4?=
 =?us-ascii?Q?S2+4C2/cEu0EWFKSQt+JJj8uxYoogTDzgjzTdESKs9PJX5qmoYSbNL+a/Ruj?=
 =?us-ascii?Q?PSXreT9/32vNn/zcnqR5AyciHpBmh64X9Uw7ZlQ2+T3ZYkaCNxOi6A4IfFv8?=
 =?us-ascii?Q?WLS/QUp3FMkKG8mcs5s0yk5+R6WJ6sjKGKbTrQ9C7ucESHF81dRxrHBygX9a?=
 =?us-ascii?Q?lQl46sX7k4rzs8NIVL/InIQHMjwXH35ywSkYl1MdCilDMB7qFY+opSpJ5VZw?=
 =?us-ascii?Q?A8pXdoEE8PWB2Cu1/uP44RQAwkwoJwEpIk64XYMPLIFPRhcREB8VegPtQcj8?=
 =?us-ascii?Q?ICWOoO2Z48yGGNlTkwo9WUcZ5o8z28v2PqwiEtpYgtuKxiNN6sQnTgMKoA28?=
 =?us-ascii?Q?5BlO1lorpBiqsyY1wmi2q6CSSJtPA28upkYAyEu5SF+HUOEXVBgnbIPsjRXA?=
 =?us-ascii?Q?MLn1JgyfTmmEL48X3mn5PuL2STkkIXz8JlbrJVkdjIQcieWppQG2pDTCkXKe?=
 =?us-ascii?Q?XVBIG10BQTQTlMag/Yu1F0GqK0FZkKI7T/j41SEk6J8wnmfs73HKn5b+clZa?=
 =?us-ascii?Q?TmyABivJDhDNYzXUyjB+ks2ervL9H3pIuvNHQXTFbNts3aBNbqQL+tLFLSUd?=
 =?us-ascii?Q?9kNsSOrbm4GYNvpu99CadbM2roHcca0DJQinPyODgf9RAuA4i0LPjAdV+s9G?=
 =?us-ascii?Q?QAPdd3EtPJB7kUVaGnKkTMbmZRbfm9P1j1wrpWE+DlbW2t5kGBZyQXNrIRyV?=
 =?us-ascii?Q?uBOsoK7C9DAhjsK5atPctwI8rZ2FdBSFlpoZObKvPg4stHcfxv3IHO79RPL+?=
 =?us-ascii?Q?j9KW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8635b2-0179-4428-2185-08db167930ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:09:56.9558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glIjmjA+6O+sBbUBKkDJZ13dk/AGxhoCBa7170V2fCCSR3HR04KD1gLsxWtwAG68ADx/QLiRiOGwVIwFPOyK3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-ORIG-GUID: XmHiMydVc82shoOW8S6zYGyRQ62oZ_dl
X-Proofpoint-GUID: XmHiMydVc82shoOW8S6zYGyRQ62oZ_dl
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
Cc: Lee Jones <lee@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/mfd/stmpe-i2c.c | 1 -
 drivers/mfd/stmpe-spi.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index d4944fc1feb1..7998e0db1e15 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -135,6 +135,5 @@ static void __exit stmpe_exit(void)
 }
 module_exit(stmpe_exit);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("STMPE MFD I2C Interface Driver");
 MODULE_AUTHOR("Rabin Vincent <rabin.vincent@stericsson.com>");
diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index e9cbf33502b3..792236f56399 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -154,6 +154,5 @@ static void __exit stmpe_exit(void)
 }
 module_exit(stmpe_exit);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("STMPE MFD SPI Interface Driver");
 MODULE_AUTHOR("Viresh Kumar <vireshk@kernel.org>");
-- 
2.39.1.268.g9de2f9a303

