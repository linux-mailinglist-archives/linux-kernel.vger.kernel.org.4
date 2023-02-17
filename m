Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71CA69AE6B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBQOxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjBQOwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:52:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F166E674;
        Fri, 17 Feb 2023 06:52:39 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7hppX001445;
        Fri, 17 Feb 2023 14:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=RZ3+H+fZHEUXqkEwroqaZl51WLH83Jjvfci+DXKIcy0=;
 b=Dcmv+Y8Lpf6LrsR3e6RYGDE38MBCNK1Za37ddVYVQcP4gU9UWoTc56ZZCBkodVKrsAhW
 ZSuXuYqBNu0KkHDo1+scBZLSGfQqBI35QDS3IZdJgOYtNR91R0Ustg3C8iJecLq5WtGn
 OjwmB8/pNeLM4ZsigOuDc4TZNFhYkB0ZsrV4Z0P6yqMze24gc6Wr2jqGFxrYL3sNpclt
 X1ln+cG1LBBeYUeHAQZjQ5yHhr9yQzzmdIvoGqxhE9NpkEUiMe1LZMOzVPxgXtkMyAdz
 LQHP0KVUIlBm8U3UfYZvNZd3kUl19XUnTHvn3kO/8YvOFSv2QUnurZg4ojFi45P8XtQm 5w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1ednuhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCNNvF022784;
        Fri, 17 Feb 2023 14:12:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa58bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sdkd77WGyKmEDRx3Zhw9dZYa4kFA/snPak6P/sGyD30DINP7Vulrn9H753n+hOWn8Tt+v8TMwAL0regs6wWVDkx271vgB5wuxAobrGxYx5imVilP0jptr8SjES/LXY4M24pws4vpQhDWeNeu+MRaRJLPP8mDCv1sBXnJ/orFbp22zZoJGq+wV6VCAs06/lwPZ3fePMiSozz71UM0g384xm+CHO1+SMsBixZnxlbFrMrhcMqF4QxMOcfFD2rCktsolmffQEUro1mnGliQxi9dONZ0vrfGas9ZCoIllPp0GL3jkOi3aPzfxWhhkJim4rzZHq+76dN3rC5wUp8Mp/lvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZ3+H+fZHEUXqkEwroqaZl51WLH83Jjvfci+DXKIcy0=;
 b=oawjz//JOdoZiTjdpAA+8NI9OI2wf3NViEA51T6DuQV3vP29GdVV+XXfJgBUrrl8nsWZXvJps2bZ8qrn++I+9OhgYbgGGSax6YZpmvNYoAc9UOMvCYEH4VTH7LwHmKdT8sctT4M8FKsTTjjEN56DRB5e8kNs+Bp9+3CzOOh4NfXFCs2xFOUFoZYlFBhfoL9R1sC9Y1jIVCbp+hds6yPReKChabyB0NEdie63v0YHhtauC2NWcLmRNaGvGvCFpTzji+mu5wRaOEw+KMktgo5VghlWKknfOdbQcWUnmkGU6n7c7xHB2JUFEXw9pyBxPkJOfM7N3SY4JB+Er8+IE+XeDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ3+H+fZHEUXqkEwroqaZl51WLH83Jjvfci+DXKIcy0=;
 b=bH6fR99jVh7rK4uVBtpx9jqSHNTtxKUM4Qalfo7AIvrdFJDZbTgBVHBWPvI2/Gs90gCTkWWxcM69gRlDbaFj8n/YZrnOZHejsGYTbIfk91oNtF5HLSppFNb6ZRsXtqUaZKobVJcN/GrG+XLePcBkUzmxtJSNvrwR4h6sDwumA8I=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.12; Fri, 17 Feb
 2023 14:12:02 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:12:02 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/24] kbuild, soc: apple: apple-pmgr-pwrstate: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:46 +0000
Message-Id: <20230217141059.392471-12-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0413.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e80314-2128-4c48-a6ab-08db10f0f0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3bAZ12leO15zrTtciR8e2gRIb57IPFs+Lv8CuscRluyCb7n0Oqjtw3UdEJPBnYyn1YXFLk1cas5KDoAsZcvvprbtUHvc/gBzYB9wz37ldGV1+UzneIqWhpvfNKrJJVbRGrfC8JsvscM5q1a/ZWTW8Zp9kjax7Dc/NmaIaC4QGqEpnnAbTUEMdAH/U15DiOrexZ821twiOnO8bfxboEBA5bNDtu9wfGsGwhWOVIUjfMMkB2pUTD6ix/zSxXv7AIMp0ldIhXsSH0E4ONoYWu9Fl2p8yquelLhxQ8cBX8Dprkk+XV+P7aoI1W/MWdrPdjJh/9qBYqgt7YSTva60BR0J+bl13OoHsrXvl6Smhy+g7ZuSZaG9KBWEkUqNs/Ki8v01aMRc4sjjg5l/L2K/4n+fwwN7OOHa8IuybY+c/O+jLJeRMuGxeSiEBWSSOs34PN8ZfsSoiVcBWZ0NHWtp4HXSFaCWo4hXNyQ5Uv81C12UgdllrVAE4ugouxTPbpmKJUIEF1OraIP+Wyn1t26ZgAQU2UUWnwavfIs/dx/3CgnPu0Ju1sbHQZ4VrYL/BQSIe9DQZc7mDpID2n4UgTNzgxRzcEBSaBl944/qS8Kcgjf9acRSEiKcRZLu/Yewoflr+7NcE4iQ5Z3yLu/OHn5IhNETHuISa7OynaCE9hH+Clu/Do4OL2548r96s7Rbzh3gNFGklHyl8wzT9LCdepWB+TqdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(376002)(39860400002)(366004)(47660400002)(451199018)(2906002)(44832011)(5660300002)(36756003)(8936002)(86362001)(41300700001)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(83380400001)(2616005)(6512007)(186003)(6506007)(1076003)(6666004)(6486002)(478600001)(46800400005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9FaqCS3ETvfIR/XZg2YDZzsLU9Ktd91b85qu1NLQUFL+JS/alO71ab7GEINd?=
 =?us-ascii?Q?g/O4igpWD/Z+oNi/JX3OxpG/dpuGzG67Qxfyq9+RkkivQ3F5KMAWf1iNQCi2?=
 =?us-ascii?Q?wD+1IOvIS0jCbnBnBu+BRK9edegJfwb94Y1MeMNlFlBhsonQVauyRUOtKhEy?=
 =?us-ascii?Q?3gzSejtB2HSjujl6koi2sL3SIIHEBsmzeOBkdYUnH08VINxi5lu5aoJnBcTI?=
 =?us-ascii?Q?j71RXyhp7EOaoujM0JmO9P3tppBeye3XMfoic2kTpYcpu64RDKP65QzJjNCh?=
 =?us-ascii?Q?f/ZC829KbCIiqIZ+rbw0EpXkRPgJ6FPSpS7FzAGZMovTcKn7LaSm8TanEX3p?=
 =?us-ascii?Q?RoT1i86CZ9/cgpfxUAFrRuqTeC7JnZNpUSm/c2l57xp9iJMfur81+a8V/z2v?=
 =?us-ascii?Q?0/gK2N2zAs2vUWoQby/4l+hFtSuJVzP3FD0l44Ek+xqZEvsHLAyjePQ7UZqD?=
 =?us-ascii?Q?z3oeyBVj3JRHyEg8NzKK6QJfRSCyErf6xDn5HB5etodywgj7ASJ/Gw3XHucP?=
 =?us-ascii?Q?iIlrA4AQZ78HtjN9K8MtHPnYjQQYvAsGkTJtfL7/jtEvBm3YtAkPUU7fW7zB?=
 =?us-ascii?Q?vRxdDXNU1Vb8GlhhaUb0evj6kZje8RfBkj7/m3GK3JtI089pKDV1yGUBSpvG?=
 =?us-ascii?Q?2E5iMAmEEynCi5gpJO1pAy1w41R2e8P2d15XfkoTP6BF8iPel+f6AofXFKiM?=
 =?us-ascii?Q?n6kw+zIk+fjLDYarw0x1UkHYGbyl/pySZR7UW0TpuhF/x7KLZSfGj47xKHjZ?=
 =?us-ascii?Q?md7geBOGOFmM+00bYYtyNxILNmajk6Gr1h83H9SrT2BBsTswu9dwRgAhOKrR?=
 =?us-ascii?Q?mx742V4hgvgBCAX61Is1GQYJJ5+6dUSX7vPuxt6/Iq3pkVZheBWKemCkNis0?=
 =?us-ascii?Q?POgsr0Hpa/+Nx+IwSayqyhA12xqxl9fDmd3RAhoNp7SwHPigcJ9JFaHTqeGL?=
 =?us-ascii?Q?OStGzGHNRXkuPz/vRu9WeSw/qDXN7JTMUNcr4H+3pq2+hTP/Uvz6NCK+uDZs?=
 =?us-ascii?Q?/QzvB7dilyqT2Bw06pV6aHJ/YXhisNLUCVAx5pewd6N4Cw0Dw7dLCZ6fjKp8?=
 =?us-ascii?Q?lUs3wcrHMYGhnOoGGaALU+MuuLZhc2oJU+wtDgDutc73GCuHJ31iMRahhota?=
 =?us-ascii?Q?+glgNzclkXYzuPIx2KqG6FXNf1LeGK4RiFneVGcTDgzrA4qqWokDybLHE/KD?=
 =?us-ascii?Q?x1iOk3oFGRCxmuYDC8PJytbbv5HitZZKummW/i9SmyBfrap0xUfqvOos6+mV?=
 =?us-ascii?Q?OZZct0ESWlYlA28sOdnY/SjKZf21mcHPzCFVJ7iGjIhcjKi/ww5uZxw4+57O?=
 =?us-ascii?Q?KRbOdOR00Snoc7K3pAcb7FjoXYXyEEHTewbfMmCOLTcz5jNWrbl5AUjB4BQG?=
 =?us-ascii?Q?2iATlfidMDF5aajkBJ86Gxsl/Qxn36gcQzKNTdQXuXAx4RUiVhIIAr+0YPJS?=
 =?us-ascii?Q?oJMLMcnoEkNW7xsiFbOiCVnD74v1+TQ3PIqmCtqE0QsQzf6axOEDdqInTdVh?=
 =?us-ascii?Q?ZnXeCKxpifniBYwu6jUe+cMbkQ/zYNitd/d7+GPkIaxOWS9cT4kQWIo1U5P9?=
 =?us-ascii?Q?1yV8ix/yFN4GBpo7xU2wfNPhZMOjSBrE3uulQOl33EzlKBhcT/V1RTEWqEB5?=
 =?us-ascii?Q?eYd9Q2OjETf3bmtfCJufZpU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tg35kzScJsewVhmiaiD0EZ3ggFQWvaUvC5MHZ+3Nl6Nv3B6RxfgV4ajlTuwv?=
 =?us-ascii?Q?8RSIlR3qfyfXfBTJzEEfqx3vauPXVIjnmT+p4h5jAaQDccMDQQNhydJlQ1SY?=
 =?us-ascii?Q?R2rX/W1I4f1j/Cfqu8ciBjFHuXKgkpiCQLNbRf6O9pGeHGs8k5gVwWH5VFOz?=
 =?us-ascii?Q?za0ct83JX8FNeeLKCL6glr0ouQhYPl7l155i9vjPiWdYsQyabZ2hFFo2tPUu?=
 =?us-ascii?Q?NSZtnegWDWMtdNfwmfo2L+BmTsaCCwa4pM6nWxwfXw7qqWobzURerX4yJvVZ?=
 =?us-ascii?Q?FovGGe1aMORlm7pl0mEg0wlxw1vByVwMf+0RGS5IJE2OzS9enCArDXEaB/a+?=
 =?us-ascii?Q?/dzNzSwZ4rNsiD9x+dUUPedt1B9zlFwFA7gg3lwxzVEwGVHqFJ/G3m2WLOIz?=
 =?us-ascii?Q?0m9y7aJcppFavY+ADyiFbWx4bjShC0Xjfo/o+g61KoJRgPQBbtJCaM2a1sFE?=
 =?us-ascii?Q?QIe41Y9h/zDEhjR6Iq8BKCDqt0WSh43uk1P22xaF3mHV+VDtbagepUvqol6S?=
 =?us-ascii?Q?WsnFvS2QF256yBnNf9srnb0x3bfuyME/bpaszhF+1mfojynO/1F8FYswUQNj?=
 =?us-ascii?Q?uOCiDK+qO1x5MtevAoHAXpvWPqqSCDARAkoMh6I5/bsOb52HAgCxqFKrjIMQ?=
 =?us-ascii?Q?clNo8fvRNpm1MrXiynG0J9L1hDgaasJWsVM5gEUUCipMNn62afHWkauscEAU?=
 =?us-ascii?Q?LXzTXdnmY5uY0ao47sPvE8kz42NbDnVNP1EMvXHf3p0GNWviCP2IeTMXhfYa?=
 =?us-ascii?Q?WajR41TRTAHjvrqwnS9zaheidoRPnHBNcMlfwjopODxOE2rcMF9ob01C3aby?=
 =?us-ascii?Q?J8fus9PYQDnePBoUJEWM2GwU2vM+jengHzUOssQQj0R+mZaq76HqPSh1/eMi?=
 =?us-ascii?Q?tvQ5aLgXh0mbW1AdctwQm/CZuc0LlaWZbKfOa5DfbGPmzL+ZnN1OQYBOymvO?=
 =?us-ascii?Q?S84ffbqFRwtF5rVIkh/fGSb7U//zZi9mVaE/IeB3snJW/RbWWrqaeCxh5dyc?=
 =?us-ascii?Q?gXE2kGjwBBXIQA/iPcsYyac/UA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e80314-2128-4c48-a6ab-08db10f0f0b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:12:02.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhbwluDRm1zAf8qektT94CrGlApvzVuVPjoQEEjrmzqVES8b5PTCaMezTGn6F0Ql6aJYOs04rQSkhEeUbwcNKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-GUID: QIdI0ACLoBbwV2ELYkrwmX_ldks_41lI
X-Proofpoint-ORIG-GUID: QIdI0ACLoBbwV2ELYkrwmX_ldks_41lI
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
Cc: Hector Martin <marcan@marcan.st>
Cc: Sven Peter <sven@svenpeter.dev>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/soc/apple/apple-pmgr-pwrstate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/apple/apple-pmgr-pwrstate.c b/drivers/soc/apple/apple-pmgr-pwrstate.c
index e1122288409a..2c15474c7b53 100644
--- a/drivers/soc/apple/apple-pmgr-pwrstate.c
+++ b/drivers/soc/apple/apple-pmgr-pwrstate.c
@@ -319,6 +319,5 @@ static struct platform_driver apple_pmgr_ps_driver = {
 
 MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
 MODULE_DESCRIPTION("PMGR power state driver for Apple SoCs");
-MODULE_LICENSE("GPL v2");
 
 module_platform_driver(apple_pmgr_ps_driver);
-- 
2.39.1.268.g9de2f9a303

