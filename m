Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D49642CF5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiLEQeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiLEQdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:33:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986211F9C7;
        Mon,  5 Dec 2022 08:33:32 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Fc1fA007848;
        Mon, 5 Dec 2022 16:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=nBeGtXAEMs7KAvRWYQGzRw9wzNveavWRhFn1oNHr4xI=;
 b=ipuoLx25Yt/L73BwvSqXfu46ZkO6lzJIuR0UFmMWRIoOfyEwPYkc3rZPGy0G7p8Brw/K
 IhsF6zQ8VDCpiWaSKMMUa7jIYLUi/JHu7YCVBltQGSTz/zn7XDtM5E6tpBf5NAVTu2gA
 Ea/Dwy0LXjjw7eKaQMNWFvAPnE1iX2Gw5Zh0Mb7wgMvi/pH1YmVLG6iyz0LxGYS7zgKm
 7NgIftdwMwrDvkQky4T+7hplCQMOv5rtwrNjcv4mm7EkTrgsvjnhncLSbMw4jCUkwYoQ
 8+HuLuv+qzUmXmAQKHOaciH1MGkwC3r0yrE7XlUJBIt8q/EU5HcN3k0W385+6Q3lEnfg Mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ybgmbgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:33:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQwoS012906;
        Mon, 5 Dec 2022 16:33:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m8u925434-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:33:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5/1rCJ9/7W0UI/22xtlUOu5pPfCvrQjkYlBo1MrSWpOfU3flrnxfm1Pt509QwkZxlkmsXF07ks3h5nOCld7/ejaGIBcnxks4XLRVrwv8rQ4SUTleddtuFeiRCluDlT9ZG8VdD1N90U41s0XoH2kRqF3J+vpAbv/HdjKvKgJ2X6MS9KOOK9Q7UYOXWg6qi624+BtcpoxuTtXY8lCNtctqMoJ6+A5ET4AkNLjxCVnoohms59yddf9bWAzRqWEVuV3KRRNlVsyPGi5WDNwjFKF0Tn+vwwntGZMZ7cbIcTdd74FNmDJfEj5U54Yg1FIza2Fsch7EajPFv2hjzoEL+jvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBeGtXAEMs7KAvRWYQGzRw9wzNveavWRhFn1oNHr4xI=;
 b=nwvBjqDPqgHC8UbOnhTuazFOAsfSW6gqzEwCD2EyBCFNss2uJ9Dk7wvxZEzKz2pxioN03sGOBXi7Cew2oZYNh1MLWsLSUPFO/5WUmWd0E7etxEiHbYMEZZK0tbRv9mT7IipcoUMSFnQTVdesl0UKDLsChaXxJ4Yx+XZqwfTVFuelG0VZIzV6EKTKeBibleJG/rLaQXJ8+3fQwIQzwnWAvoLoPAyMDRnXA4vPOwAI2mf/Sfoh1KEkBno6IhwqW5sdiDpP2YhOipXubmPsUmhtmu/laW26iuyVJR5QtISxjxbpo24ynE+0i6uBzjGjb5lOP3N44eICwfC1RB4R7HoHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBeGtXAEMs7KAvRWYQGzRw9wzNveavWRhFn1oNHr4xI=;
 b=KlUpTPzwyRrLMUOv8VeFK2cBhkXMPdoQwuq+X9qZFdeNoPnm4UuS03CVdkYNhh+aEkWwGkazHbc2FFwQXd4JYDHpBgVeOxuB7LPW02MGoGGWGIhAclVDnoz4HI5mf3HbeHUX0DHdriRYpyGvkXx2/sXOc/i9xlx3CndS+OtylsA=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DS7PR10MB7324.namprd10.prod.outlook.com (2603:10b6:8:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 16:33:00 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:33:00 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v10 09/13] kallsyms: introduce sections needed to map symbols to built-in modules
Date:   Mon,  5 Dec 2022 16:31:53 +0000
Message-Id: <20221205163157.269335-10-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0009.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DS7PR10MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 29411d67-2c55-492e-cbac-08dad6de5a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31QypZFNgEzfPNBQSEwKoT++nkSxPiBG3SAZcSNV68WsP47HeY0GepLY+jbUBA262UpcLoXL6+cttgF4gzQCcElGvcl4mZoLQLMcifXIRvpgazhaculvnTJjOPoY0c2rUXHu6V26u39PRYlkOcoNx1tpA+sbpXITxOoj+78Xm1iMoF0c+5t2fL3jYiGJQsl+vhqK/OR9ngpbBJtY6qlqdJDhJICtCM1ciCH3+9AA650RQamHnhMkW6dj+JDteVzUR6yB0N3Go/IiWvzjXbM3bZqjTZDkD28CegX8/cvBxlwaL/lTJE67+nuHLyhTVXs1/tEigyHiuYtInS///vK3madZnzy+5+YtW9ebyJ4y+bbpjsExh/exahfVgO9B9dbkVndcu9DHUZKbvyGt2G7GGVplM3lN4xd8fT3ub/40R8ohgDVCZXOgF/dKa304nUfAbJOxJABkEGPAsoVWRW3PXilH9wOLX7UhiTnxh2RvACjPrHWCWamnMduaXcCceFa5nC2749SbLqZDzlQg9eQCO6IlMpz9q31FdSU/BZ7iRE6ej37JEq6NNMw9Nv2E4dfPZkdHHJvhj6naRUON1sGLRZxkCbVJpNJLGU2Tu1b+8/h0bm64Klv6XlnrYSZ8o9LXiVOcE1AWm28xyuifqv1leg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(86362001)(36756003)(1076003)(2616005)(41300700001)(66946007)(4326008)(66476007)(66556008)(8676002)(30864003)(44832011)(8936002)(5660300002)(6506007)(6486002)(107886003)(478600001)(6666004)(316002)(45080400002)(186003)(6512007)(38100700002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zQvgeYJ3pdQlPM3FRl0xnJXla74MP4mH9PbABnYMMX/ksc0m9jzyZEuCpUjV?=
 =?us-ascii?Q?XMI1yEqbYOsjLRk9B2aPCUUWxUzrJaIDs01Jo6QMa8FJ+AZ2Rzkl2tuRr27p?=
 =?us-ascii?Q?mCubUWh5WZP3t81L1w7qwrp2/3EkMt1myK5tSQidOetdrmDcPtRTYnvN3UWw?=
 =?us-ascii?Q?Q8niQE1OI1tAUuWy3ctApCYMK/KWDFR10NucXh1dL10VLcKSussDRWIaTYGj?=
 =?us-ascii?Q?7RdH2VfUMaq1GYvX0U6wd7lZ7TdOlXyH7nYjip9rPZXvC1HM5KnnTIJH3xiX?=
 =?us-ascii?Q?Y4UFjcHAbegIdaYAwn1ifCrCOxthZFLd9mu1+XgOj5S+in41AoOD5+K+RXUW?=
 =?us-ascii?Q?MyuhveoVH0azJeXVCOl0rURj5HqwmDOJJm1e/NtWqSdIoBpPipdKDQkjdE5n?=
 =?us-ascii?Q?IGjSsd1ucT2iIV+tUM0SD62s/UmC7JHVM4GV2wPx/DIYxHXZK1CRw/bl/CTk?=
 =?us-ascii?Q?ExrAbXjoDZ6HDIZn6Tly90azeRBeIEjCxZYzm0WCzG839JKNYXiW5I1+BS8n?=
 =?us-ascii?Q?JTF/tfkOyyWtOtNAN2MwnEN9cBIW/SA2M7HbLW0UHg7TC95ofutFwF9XNX+3?=
 =?us-ascii?Q?+tcsKMYEP/DEM49g+j9x473hFcZb7/5X7cs0QHq4wPZQ9+eUl197kUKjZTMM?=
 =?us-ascii?Q?3nGo7NTO5hSDDFVsOxnp1fFJbIubK1TUDUrQRv5lRJW3bVD7qmu3bxv4MMxS?=
 =?us-ascii?Q?TwxnQM0AKs+sVyUiLeE/EuasT/XMPfG2wqZ9gojn877bCHYgn2heqQjNmxQN?=
 =?us-ascii?Q?iGg/mFT/MZ7Zc+31V40bsQ1pslYI7KUh6RADVupj0icvYx517c51FjeDoHAA?=
 =?us-ascii?Q?cMkYOgIH/bgc3xQr8oUFC+op7qstlPsqw1brLEzhaQ/ooB4PAnoaKblX6KcB?=
 =?us-ascii?Q?Xt/IyfRYaNrxQr8abAhNVQJEfWAoJz8OLAqYaECSm9VENxBH0YnfDb+FMxHE?=
 =?us-ascii?Q?6FGzMdTYZRKvoQnM/PCnRGrj5CPdGfEgdY9ZXVT0QRi84q8deL3TJk9zXpKd?=
 =?us-ascii?Q?3gJ1eOsSmk+9q2tpWUemLe9UWhB74uD2pVajI/gvBdsbei+6o2/+BJsZ1poY?=
 =?us-ascii?Q?wofPprH1JPkirwEXrtX9cMplt1NEUITD5z9opDOPh78bHncmFRFmn/zE1t3n?=
 =?us-ascii?Q?ecP5o4Zl+7eEvGJq7tIA5YwFE4Cl+CZrPmM7efZWvcsE7x159enEUXQRvvGb?=
 =?us-ascii?Q?9J+j9xYObeYGn8ZJPqfHlwWPTmqIx2sdxFrweLS5XjM6ZpsNcE0JWvjRIZuW?=
 =?us-ascii?Q?H1/M4rVsaJMatZd2/wxHYmcTAX/CcXrhRf4/l5D3QkSR8qEKOGI8PkDgWvMR?=
 =?us-ascii?Q?OhQrymb4A5BC7f0yxWYiJoqaZ+puIhkzfClE/v8CReG9NstBU+1o/t7RUmbw?=
 =?us-ascii?Q?Gj4VRQE4s9hY43KaahDslwEE4Po0MgGVk7IQGxQs8WqNRE5OWG98AI/bnJgl?=
 =?us-ascii?Q?tYXICIAWMfunYezKXjuDc+44zfqDmVZEMJcwAqxsxLd81/FJd75KeqZtyH8i?=
 =?us-ascii?Q?KnCwG6bvGYq4RkfCi1iUj1n6c9aSgb7TStM9v4oweQgIfeBIlJ0xQiXOdegp?=
 =?us-ascii?Q?iXXYZXM0RsrI1XwzlEesyl6st5tEhA3G1nvdWN0fYdGqeTlL9ItLhK4X+jWb?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?n3I5lwdW+tPyCDRNkkbs8+nYf6wMEbUpf9Ir+12LVqDj28QZrs4r980yjMRd?=
 =?us-ascii?Q?KU6hW/9u/VqtjTrCSMaZkfJsDBU2s+AGR+7+jXMVo9HV8GctIXT+meqk17TD?=
 =?us-ascii?Q?I0tQLXmC6v1SOKG5C0YWsW021qLVWkerKL0g24YvGyMqQIBVXPj+1Iki7PgW?=
 =?us-ascii?Q?+bVEXPmO2HhQ1GVgIKGB26HpFmKYKVD20/Oq6HMOEasOdu12whbBgJ/mtzvM?=
 =?us-ascii?Q?eaE1wZ7gtiI1rWbnqfPHUVmo0FQ9ejSnF2522z5llUhQbnA+HaTUgC0k/0Jf?=
 =?us-ascii?Q?bFcKP8lvo4i26XPDjtN9HcbbYWzbRSZ0726tAOazmUuwnn0JojbYgW+eJuwb?=
 =?us-ascii?Q?H5gYzVoq6Dww2XoFLJDe42+OPScTuBl9lkxKyvkI63x+J3dH22b5Xzo5Luv/?=
 =?us-ascii?Q?DofiC4Pmbk+qOn6PILRQvm1GviZGN7taOBj+1ALGL9Lnyh8r/VC6qj0ZOMNR?=
 =?us-ascii?Q?e/pSdYiu1GD+bpwmzoz+jI4dWZHRxKQ9GyGr5vihqvjpTtsgyMMFRnnOdWkW?=
 =?us-ascii?Q?IsbB9mfMpYAVPnZ8PA+C4crlnVV4zCKSKGzPJlkVIR79xdheJELax6tB/u+c?=
 =?us-ascii?Q?eDLG2Xzgw63IIIPgrFsNEWN1RfXlvzG4wEPhoEogWCv2/HBrzjnrIJtkiqn7?=
 =?us-ascii?Q?Q2vFRy02bJwN9fhNEboXLTtjqeaQBiQmIYRi1sDp9cmTLBYSC+DNiMWAUBZW?=
 =?us-ascii?Q?s7we27XNt2ZiUZtUwDQ+o0rQIB9kbyW36kiUP6coV54FWZG+Op5hKDDGSp+9?=
 =?us-ascii?Q?jGEqCM/ZeY0hYasESC7wWBw2Y7CM09di0IB8jGbb9Vl3sqzxr0wWJCncW0cU?=
 =?us-ascii?Q?F9yRwMy7X51tamY93pORt3GtLACbvr/2IG3Mu/HlwyhG+KVWJ1yeBU/3zNHK?=
 =?us-ascii?Q?dIxbW0y3Rve8F8xCjNgyNToONcAbs8Fazpn9YSLPS0qtEN1OP9PZ+shLjkHT?=
 =?us-ascii?Q?WDkEXB2/vZ9gNIipBZgracPPhTXYxqvQIpuWy+Fduuk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29411d67-2c55-492e-cbac-08dad6de5a6c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:32:51.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6s+NQPei2ihQDziOD86HfKq7CEW38N6NQstvUhUxM9bit5JlH/s9/wPTPkiIP7NUqbWaS01HE+ytoz4ofPsgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050138
X-Proofpoint-ORIG-GUID: p1VWc0XnHSJCH4MtZs_gj2zPZyiJ7F72
X-Proofpoint-GUID: p1VWc0XnHSJCH4MtZs_gj2zPZyiJ7F72
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part of the kallmodsyms machinery, allowing disambiguation of
every symbol in the kernel by annotating symbols that are part of
built-in modules with their module name.  In order to do this we need a
space-efficient way to associate symbols with modules without annotating
every single symbol.

The mapping needed to do this consists of three new symbols, computed by
integrating the information in the (just-added) .tmp_vmlinux.ranges and
modules.builtin.objs: taken together, they map address ranges
(corresponding to object files on the input) to the names of zero or
more modules containing those address ranges.

 - kallsyms_module_addresses/kallsyms_module_offsets encodes the
   address/offset of each object file (derived from the linker map), in
   exactly the same way as kallsyms_addresses/kallsyms_offsets does
   for symbols.  There is no size: instead, the object files are assumed
   to tile the address space.  (This is slightly more space-efficient
   than using a size).  Non-text-section addresses are skipped: for now,
   all the users of this interface only need module/non-module
   information for instruction pointer addresses, not absolute-addressed
   symbols and the like.  This restriction can easily be lifted in
   future.  (Regarding the name: right now the entries correspond pretty
   closely to object files, so we could call the section
   kallsyms_objfiles or something, but the optimizer added in the next
   commit will change this.)

 - kallsyms_mod_objnames encodes the name of each module in a modified
   form of strtab: notably, if an object file appears in *multiple*
   modules, all of which are built in, this is encoded via a zero byte,
   a one-byte module count, then a series of that many null-terminated
   strings.  As a special case, the table starts with a single zero byte
   which does *not* represent the start of a multi-module list.

   (The name is "objnames" because in an upcoming commit it will store
   some object file names too.)

 - kallsyms_modules connects the two, encoding a table associated 1:1
   with kallsyms_module_addresses / kallsyms_module_offsets, pointing
   at an offset in kallsyms_module_names describing which module (or
   modules, for a multi-module list) the code occupying this address
   range is part of.  If an address range is part of no module (always
   built-in) it points at 0 (the null byte at the start of the
   kallsyms_module_names list).

There is no optimization yet: kallsyms_modules and
kallsyms_module_names will almost certainly contain many duplicate
entries, and kallsyms_module_{addresses,offsets} may contain
consecutive entries that point to the same place.  The size hit is
fairly substantial as a result, though still much less than a naive
implementation mapping each symbol to a module name would be: 50KiB or
so.

Since this commit is the first user of the modules_builtin iterator,
introduce rules to actually build it when CONFIG_KALLMODSYMS is set.
Since it's also the first user of the new Kconfig symbol to enable
compiling-out of /proc/kallmodsyms support, introduce that symbol too.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v9: Rename .kallsyms_module_names to .kallsyms_mod_objnames now that it
        contains object file names too.  Adjustments to the Kconfig wording;
        adjustments to modules_thick.builtin rules.  Adjust to getopt_long
        use in scripts/kallsyms.

 scripts/Makefile   |   6 +
 scripts/kallsyms.c | 375 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 373 insertions(+), 8 deletions(-)

diff --git a/scripts/Makefile b/scripts/Makefile
index 356cafcd313d..9312d36107aa 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -33,6 +33,12 @@ ifdef CONFIG_BUILDTIME_MCOUNT_SORT
 HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
 endif
 
+kallsyms-objs  := kallsyms.o
+
+ifdef CONFIG_KALLMODSYMS
+kallsyms-objs += modules_builtin.o
+endif
+
 # The following programs are only built on demand
 hostprogs += unifdef
 
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 04e04fbd9625..48bf4661bd09 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,10 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
+ * Usage: nm -n vmlinux
+ *        | scripts/kallsyms [--all-symbols] [--absolute-percpu]
+ *             [--base-relative] [--builtin=modules.builtin.objs]
+ *        > symbols.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
@@ -25,6 +28,10 @@
 #include <string.h>
 #include <ctype.h>
 #include <limits.h>
+#include <assert.h>
+#include "modules_builtin.h"
+
+#include "../include/generated/autoconf.h"
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 
@@ -86,11 +93,118 @@ static int token_profit[0x10000];
 static unsigned char best_table[256][2];
 static unsigned char best_table_len[256];
 
+#ifdef CONFIG_KALLMODSYMS
+static unsigned int strhash(const char *s)
+{
+	/* fnv32 hash */
+	unsigned int hash = 2166136261U;
+
+	for (; *s; s++)
+		hash = (hash ^ *s) * 0x01000193;
+	return hash;
+}
+
+#define OBJ2MOD_BITS 10
+#define OBJ2MOD_N (1 << OBJ2MOD_BITS)
+#define OBJ2MOD_MASK (OBJ2MOD_N - 1)
+struct obj2mod_elem {
+	char *obj;
+	char *mods;		/* sorted module name strtab */
+	size_t nmods;		/* number of modules in "mods" */
+	size_t mods_size;	/* size of all mods together */
+	int mod_offset;		/* offset of module name in .kallsyms_mod_objnames */
+	struct obj2mod_elem *obj2mod_next;
+};
+
+/*
+ * Map from object files to obj2mod entries (a unique mapping).
+ */
+
+static struct obj2mod_elem *obj2mod[OBJ2MOD_N];
+static size_t num_objfiles;
+
+/*
+ * An ordered list of address ranges and the objfile that occupies that range.
+ */
+struct addrmap_entry {
+	char *obj;
+	unsigned long long addr;
+	unsigned long long end_addr;
+	struct obj2mod_elem *objfile;
+};
+static struct addrmap_entry *addrmap;
+static int addrmap_num, addrmap_alloced;
+
+static void obj2mod_init(void)
+{
+	memset(obj2mod, 0, sizeof(obj2mod));
+}
+
+static struct obj2mod_elem *obj2mod_get(const char *obj)
+{
+	int i = strhash(obj) & OBJ2MOD_MASK;
+	struct obj2mod_elem *elem;
+
+	for (elem = obj2mod[i]; elem; elem = elem->obj2mod_next) {
+		if (strcmp(elem->obj, obj) == 0)
+			return elem;
+	}
+	return NULL;
+}
+
+/*
+ * Note that a given object file is found in some module, interning it in the
+ * obj2mod hash.  Should not be called more than once for any given (module,
+ * object) pair.
+ */
+static void obj2mod_add(char *obj, char *mod)
+{
+	int i = strhash(obj) & OBJ2MOD_MASK;
+	struct obj2mod_elem *elem;
+
+	elem = obj2mod_get(obj);
+	if (!elem) {
+		elem = malloc(sizeof(struct obj2mod_elem));
+		if (!elem)
+			goto oom;
+		memset(elem, 0, sizeof(struct obj2mod_elem));
+		elem->obj = strdup(obj);
+		if (!elem->obj)
+			goto oom;
+		elem->mods = strdup(mod);
+		if (!elem->mods)
+			goto oom;
+
+		elem->obj2mod_next = obj2mod[i];
+		obj2mod[i] = elem;
+		num_objfiles++;
+	} else {
+		elem->mods = realloc(elem->mods, elem->mods_size +
+				     strlen(mod) + 1);
+		if (!elem->mods)
+			goto oom;
+		strcpy(elem->mods + elem->mods_size, mod);
+	}
+
+	elem->mods_size += strlen(mod) + 1;
+	elem->nmods++;
+	if (elem->nmods > 255) {
+		fprintf(stderr, "kallsyms: %s: too many modules associated with this object file\n",
+			obj);
+		exit(EXIT_FAILURE);
+	}
+	return;
+oom:
+	fprintf(stderr, "kallsyms: out of memory\n");
+	exit(1);
+}
+#endif /* CONFIG_KALLMODSYMS */
 
 static void usage(void)
 {
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-percpu] "
-			"[--base-relative] [--lto-clang] in.map > out.S\n");
+			"[--base-relative] [--lto-clang] [--builtin=modules.builtin.objs] "
+			" in.map > out.S\n");
 	exit(1);
 }
 
@@ -114,10 +228,16 @@ static bool is_ignored_symbol(const char *name, char type)
 		"kallsyms_offsets",
 		"kallsyms_relative_base",
 		"kallsyms_num_syms",
+		"kallsyms_num_modules",
 		"kallsyms_names",
 		"kallsyms_markers",
 		"kallsyms_token_table",
 		"kallsyms_token_index",
+		"kallsyms_module_offsets",
+		"kallsyms_module_addresses",
+		"kallsyms_modules",
+		"kallsyms_mod_objnames",
+		"kallsyms_mod_objnames_len",
 		/* Exclude linker generated symbols which vary between passes */
 		"_SDA_BASE_",		/* ppc */
 		"_SDA2_BASE_",		/* ppc */
@@ -264,8 +384,8 @@ static struct sym_entry *read_symbol(FILE *in)
 	return sym;
 }
 
-static int symbol_in_range(const struct sym_entry *s,
-			   const struct addr_range *ranges, int entries)
+static int addr_in_range(unsigned long long addr,
+			 const struct addr_range *ranges, int entries)
 {
 	size_t i;
 	const struct addr_range *ar;
@@ -273,7 +393,7 @@ static int symbol_in_range(const struct sym_entry *s,
 	for (i = 0; i < entries; ++i) {
 		ar = &ranges[i];
 
-		if (s->addr >= ar->start && s->addr <= ar->end)
+		if (addr >= ar->start && addr <= ar->end)
 			return 1;
 	}
 
@@ -287,8 +407,8 @@ static int symbol_valid(const struct sym_entry *s)
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
-		if (symbol_in_range(s, text_ranges,
-				    ARRAY_SIZE(text_ranges)) == 0)
+		if (addr_in_range(s->addr, text_ranges,
+				  ARRAY_SIZE(text_ranges)) == 0)
 			return 0;
 		/* Corner case.  Discard any symbols with the same value as
 		 * _etext _einittext; they can move between pass 1 and 2 when
@@ -380,6 +500,121 @@ static void output_address(unsigned long long addr)
 		printf("\tPTR\t_text - %#llx\n", _text - addr);
 }
 
+#ifdef CONFIG_KALLMODSYMS
+/* Output the .kallmodsyms_mod_objnames symbol content. */
+static void output_kallmodsyms_mod_objnames(void)
+{
+	struct obj2mod_elem *elem;
+	size_t offset = 1;
+	size_t i;
+
+	/*
+	 * Traverse and emit, updating mod_offset accordingly.  Emit a single \0
+	 * at the start, to encode non-modular objfiles.
+	 */
+	output_label("kallsyms_mod_objnames");
+	printf("\t.byte\t0\n");
+	for (i = 0; i < OBJ2MOD_N; i++) {
+		for (elem = obj2mod[i]; elem;
+		     elem = elem->obj2mod_next) {
+			const char *onemod;
+			size_t i;
+
+			elem->mod_offset = offset;
+			onemod = elem->mods;
+
+			/*
+			 * Technically this is a waste of space: we could just
+			 * as well implement multimodule entries by pointing one
+			 * byte further back, to the trailing \0 of the previous
+			 * entry, but doing it this way makes it more obvious
+			 * when an entry is a multimodule entry.
+			 */
+			if (elem->nmods != 1) {
+				printf("\t.byte\t0\n");
+				printf("\t.byte\t%zi\n", elem->nmods);
+				offset += 2;
+			}
+
+			for (i = elem->nmods; i > 0; i--) {
+				printf("\t.asciz\t\"%s\"\n", onemod);
+				offset += strlen(onemod) + 1;
+				onemod += strlen(onemod) + 1;
+			}
+		}
+	}
+	printf("\n");
+	output_label("kallsyms_mod_objnames_len");
+	printf("\t.long\t%zi\n", offset);
+}
+
+static void output_kallmodsyms_objfiles(void)
+{
+	size_t i = 0;
+	size_t emitted_offsets = 0;
+	size_t emitted_objfiles = 0;
+
+	if (base_relative)
+		output_label("kallsyms_module_offsets");
+	else
+		output_label("kallsyms_module_addresses");
+
+	for (i = 0; i < addrmap_num; i++) {
+		long long offset;
+		int overflow;
+
+		if (base_relative) {
+			if (!absolute_percpu) {
+				offset = addrmap[i].addr - relative_base;
+				overflow = (offset < 0 || offset > UINT_MAX);
+			} else {
+				offset = relative_base - addrmap[i].addr - 1;
+				overflow = (offset < INT_MIN || offset >= 0);
+			}
+			if (overflow) {
+				fprintf(stderr, "kallsyms failure: "
+					"objfile %s at address %#llx out of range in relative mode\n",
+					addrmap[i].objfile ? addrmap[i].objfile->obj :
+					"in always-built-in object", table[i]->addr);
+				exit(EXIT_FAILURE);
+			}
+			printf("\t.long\t0x%x\n", (int)offset);
+		} else
+			printf("\tPTR\t%#llx\n", addrmap[i].addr);
+		emitted_offsets++;
+	}
+
+	output_label("kallsyms_modules");
+
+	for (i = 0; i < addrmap_num; i++) {
+		struct obj2mod_elem *elem = addrmap[i].objfile;
+		/*
+		 * Address range cites no modular object file: point at 0, the
+		 * built-in module.
+		 */
+		if (addrmap[i].objfile == NULL) {
+			printf("\t.long\t0x0\n");
+			emitted_objfiles++;
+			continue;
+		}
+
+		/*
+		 * Zero offset is the initial \0, there to catch uninitialized
+		 * obj2mod entries, and is forbidden.
+		 */
+		assert(elem->mod_offset != 0);
+
+		printf("\t.long\t0x%x\n", elem->mod_offset);
+		emitted_objfiles++;
+	}
+
+	assert(emitted_offsets == emitted_objfiles);
+	output_label("kallsyms_num_modules");
+	printf("\t.long\t%zi\n", emitted_objfiles);
+	printf("\n");
+}
+#endif /* CONFIG_KALLMODSYMS */
+
 /* uncompress a compressed symbol. When this function is called, the best table
  * might still be compressed itself, so the function needs to be recursive */
 static int expand_symbol(const unsigned char *data, int len, char *result)
@@ -538,6 +773,11 @@ static void write_src(void)
 		printf("\n");
 	}
 
+#ifdef CONFIG_KALLMODSYMS
+	output_kallmodsyms_mod_objnames();
+	output_kallmodsyms_objfiles();
+#endif
+
 	output_label("kallsyms_num_syms");
 	printf("\t.long\t%u\n", table_cnt);
 	printf("\n");
@@ -855,7 +1095,7 @@ static void make_percpus_absolute(void)
 	unsigned int i;
 
 	for (i = 0; i < table_cnt; i++)
-		if (symbol_in_range(table[i], &percpu_range, 1)) {
+		if (addr_in_range(table[i]->addr, &percpu_range, 1)) {
 			/*
 			 * Keep the 'A' override for percpu symbols to
 			 * ensure consistent behavior compared to older
@@ -882,14 +1122,124 @@ static void record_relative_base(void)
 		}
 }
 
+#ifdef CONFIG_KALLMODSYMS
+/*
+ * Read the linker map.
+ */
+static void read_linker_map(void)
+{
+	unsigned long long addr, size;
+	char *obj;
+	FILE *f = fopen(".tmp_vmlinux.ranges", "r");
+
+	if (!f) {
+		fprintf(stderr, "Cannot open '.tmp_vmlinux.ranges'.\n");
+		exit(1);
+	}
+
+	addrmap_num = 0;
+	addrmap_alloced = 4096;
+	addrmap = malloc(sizeof(*addrmap) * addrmap_alloced);
+	if (!addrmap)
+		goto oom;
+
+	/*
+	 * For each address range, add to addrmap the address and the objfile
+	 * entry to which the range maps.  Only add entries relating to text
+	 * ranges.
+	 *
+	 * Ranges that do not correspond to a built-in module, but to an
+	 * always-built-in object file, have no obj2mod_elem and point at NULL
+	 * instead.  Their obj member is still filled out.
+	 */
+
+	while (fscanf(f, "%llx %llx %ms\n", &addr, &size, &obj) == 3) {
+		struct obj2mod_elem *elem = obj2mod_get(obj);
+
+		if (addr == 0 || size == 0 ||
+		    !addr_in_range(addr, text_ranges, ARRAY_SIZE(text_ranges))) {
+			free(obj);
+			continue;
+		}
+
+		if (addrmap_num >= addrmap_alloced) {
+			addrmap_alloced *= 2;
+			addrmap = realloc(addrmap,
+			    sizeof(*addrmap) * addrmap_alloced);
+			if (!addrmap)
+				goto oom;
+		}
+
+		addrmap[addrmap_num].addr = addr;
+		addrmap[addrmap_num].end_addr = addr + size;
+		addrmap[addrmap_num].objfile = elem;
+		addrmap[addrmap_num].obj = obj;
+		addrmap_num++;
+	}
+	fclose(f);
+	return;
+
+oom:
+	fprintf(stderr, "kallsyms: out of memory\n");
+	exit(1);
+}
+
+/*
+ * Read "modules.builtin.objs" (the list of built-in modules).  Construct the
+ * obj2mod hash to track objfile -> module mappings.  Read ".tmp_vmlinux.ranges"
+ * (the linker map) and build addrmap[], which maps address ranges to built-in
+ * module names (using obj2mod).
+ */
+static void read_modules(const char *modules_builtin)
+{
+	struct modules_builtin_iter *i;
+	char *module_name = NULL;
+	char **module_paths;
+
+	obj2mod_init();
+	/*
+	 * Iterate over all modules in modules.builtin.objs and add each.
+	 */
+	i = modules_builtin_iter_new(modules_builtin);
+	if (i == NULL) {
+		fprintf(stderr, "Cannot iterate over builtin modules.\n");
+		exit(1);
+	}
+
+	while ((module_paths = modules_builtin_iter_next(i, &module_name))) {
+		char **walk = module_paths;
+		while (*walk) {
+			obj2mod_add(*walk, module_name);
+			walk++;
+		}
+		free(module_paths);
+	}
+
+	free(module_name);
+	modules_builtin_iter_free(i);
+
+	/*
+	 * Read linker map.
+	 */
+	read_linker_map();
+}
+#else
+static void read_modules(const char *unused) {}
+#endif /* CONFIG_KALLMODSYMS */
+
 int main(int argc, char **argv)
 {
+	char *modules_builtin = "modules.builtin.objs";
+
 	while (1) {
+		static int has_modules_builtin;
+
 		static struct option long_options[] = {
 			{"all-symbols",     no_argument, &all_symbols,     1},
 			{"absolute-percpu", no_argument, &absolute_percpu, 1},
 			{"base-relative",   no_argument, &base_relative,   1},
 			{"lto-clang",       no_argument, &lto_clang,       1},
+			{"builtin",         required_argument, &has_modules_builtin, 1},
 			{},
 		};
 
@@ -899,12 +1249,21 @@ int main(int argc, char **argv)
 			break;
 		if (c != 0)
 			usage();
+
+		if (has_modules_builtin) {
+			modules_builtin = strdup(optarg);
+			if (!modules_builtin) {
+				fprintf(stderr, "Out of memory parsing args\n");
+				exit(1);
+			}
+		}
 	}
 
 	if (optind >= argc)
 		usage();
 
 	read_map(argv[optind]);
+	read_modules(modules_builtin);
 	shrink_table();
 	if (absolute_percpu)
 		make_percpus_absolute();
-- 
2.38.0.266.g481848f278

