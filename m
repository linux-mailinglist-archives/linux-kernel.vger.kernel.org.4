Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C108A6A1E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjBXPLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBXPLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:11:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5774392BB;
        Fri, 24 Feb 2023 07:10:28 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEo1Ab012036;
        Fri, 24 Feb 2023 15:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=4ylDccIUfnWDqhO1yL0oNaOMt8BcHXP4g8xqjvn6nDA=;
 b=nrgVjn1YTY5Qt0pI9Zls+FMQ2SNAugDFuIu7xXidYbSzr5HuglQG1uZIPaTx6Ux5sAAu
 LqHYVgcc2OjCswJ9lmzS7WT+heE43JM6x02S59h8d42Dv2v9PubbcOTBtWU9IZIQp0dW
 +g8dSGfYLtMH/GQIvHCU+m2bI9KnbLFWEbXrmwuJFHJQFujYzIa8WMlaL8HZbGoYOgq2
 qXSq5oWcuXvHKQcPkZkapVUJq1PrTCTHrv23JUx3D7QyRGb0KIvXFXOlNOgAQgW7AlsN
 1gy97v2Wp9omTOxzp0vzQ3pDeIQFj6LeLGoPjpqZqPIi1THE9BHJBNILUkO3dlJzTb43 Tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpjad7yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OEm3SK025885;
        Fri, 24 Feb 2023 15:09:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49kfs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNLavepIuL54eGp46DEVFY9kAos7JgqspT9fj31+IlVWL+Kdd7jztuVC/R6ZdL8GyD6HPVg49jlMBXY/9bD9i3xQVcxfUqG3QEMvSMqi8OCFkkgJuf9xp8PvKZav1+phORdec/P2lXMt243/+ZehDhy6js46pnSl0rQVLJX3DKvzW6NGOBVbzxTkjmkSILpvtI4ID6vxdE3GnyeByH1foIa+i11ho6sTPL/MgVEaOjYZLRSYx5w7w+gAqBxseE2Pf+wljGLROJCC0Saiu4Mm2fp5QhvT3Q90HcIo8RC4ThXgwkCnboCQLKWiZ8RukbOAM4jc5Ssphsi50GSsItcEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ylDccIUfnWDqhO1yL0oNaOMt8BcHXP4g8xqjvn6nDA=;
 b=UWnl5oX/9Sacp7EbrBuOoP7yJn6rtHN/Gg41+zUSbS0hvFE3S2qDM0jg+TQQqI0Zf3uC4fEozxdgkGuvNx5w2Px4wE5w9Idh8p7JMG1pKExYo1ktlhdBRmBT2WEsvXIJO+xv/P+NYd8iHgGqImFzr2cZFvWLk/KMAKFhdKkDJkZlooMRtSLIR4O1exDj085TEa7xak4cYXvCzPS1taZSbiCDaz9Sw/zG8wM7wG5/DOWTWFeECSkic7h3zg74uQV+WXYUclHdlhtUHib/ahlN/bI/yQD5HhjpB4m7LWvrr6onmgm67JWsxPHw8Y7DP8VLzcP3Pt0Eg6GJs3ASUYUQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ylDccIUfnWDqhO1yL0oNaOMt8BcHXP4g8xqjvn6nDA=;
 b=ykkgy4S5+gdWNBjL3EioNc3FZz0LVlOhkilWeN5FQarL9Lqwcx2T8mgvk9L8wriUJhhLBgHKCAZxMi4YPlpWL3oqVSrvzB/3dF76ilmwdvipG+2l6v2kXKaJACOM1YcxbwMfWz/KOZaM9Dr759yuBGGiWStK8MFJdpLqTaVE4DU=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5303.namprd10.prod.outlook.com (2603:10b6:408:125::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:09:29 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:09:29 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 14/27] power: reset: mt6397: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:07:58 +0000
Message-Id: <20230224150811.80316-15-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0430.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::34) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 308c56d7-ad51-435f-46b7-08db16792041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kujL3MZfkJIKS9UU8SY6WU+pXVNZJ+RGb7xxl5cMU2wypviKjFj5LIliwUfUhQRtMtzFiNMJ1H6Y35ZTaeDROzzG0qURN59j98LIxu3kj9ydVW3fKnzE32VHmZfK7Vf+kmOPyyJf9fmG0BgR/fmmnnBG0HJot/0dcwdckTVvP5mnKd83IVnKUNI5JItYiPqLY2ODljoYULvtgAVHReNMj0TpYSl5eYHZsKJwBzv0UIBsBqbRy+wKWBFKt9of9Go8ybBuqX3W4cE2CY2zywtFBnfCyl6XWg/8SVc20JIzbuNP6tt3iBu/3FYP01bsRxtmTXiFUnX7hj4UDDrPQAc0dRsOeHJCPTcxnIOVMFfs3beVBZvD1rbd/DVyxOM4/EWxmHL0CUFRP0OQAHkkjT2Aub7slBsUpWPYTZVP9ac9NM3N409294VfbmGRhek+0w9kQ8anY2n3fVFwEHCqBodwu4Li77YcOyPQaT+ah76QZAH6KumQIREJa+JPXrPhit31E2+zlks0qHyXvK7ZY+pbnxDt/yC8/ltpou4Wbb44wP+LVmQ1Bwqmy1qFJQE3xdmdgtX1M0Ot8eLaArtAIyW0F7lD7zmP4lOlExis5FcOcdTkNmWoNrks9zOKot4WaGCM3BrFpT8QwWL2KKKq23Cl8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(36756003)(6506007)(83380400001)(2616005)(1076003)(6512007)(6666004)(186003)(8936002)(7416002)(41300700001)(6916009)(4326008)(44832011)(8676002)(5660300002)(2906002)(6486002)(478600001)(66946007)(66556008)(66476007)(54906003)(316002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qUyEspPJW0wyQvbh2ptt7BwDOhHanBF+HZVrha7KSN7P0C01wwhQV5xb+V9Z?=
 =?us-ascii?Q?U1i/Kv8K0LeS15AXJUhbnkXV1i6fLsTTo17tM//5H2tvMqSw/8CMraUo8KK8?=
 =?us-ascii?Q?ykAoehKOhcH23L1wFs+Th57KXY0MPqtaZjAskxTpuubuRHKhFEj40VDbxdNb?=
 =?us-ascii?Q?r9EXljKCi3aPIurGsw1ff551NNSH4OO3VA3iWiNX73+E+5mcFOtj6AOo7P1v?=
 =?us-ascii?Q?C0xUeDm2lhS83XG+AeHU9gDRTd1xSVTCPkUlG4AGukOLkrF+8UWMHd9KmKvp?=
 =?us-ascii?Q?JI2YhgztgmV5YD4ASjCBABDO9kjOsvZn8DQXb8Zepkt2OU0f71EjkMJF9IhB?=
 =?us-ascii?Q?3xLhoztk4nZAODnKaxK4LhIPEw/kDWu9i6qN4LrBc7kkRpX3IIledZPjvNOC?=
 =?us-ascii?Q?w6Xd59apxZyJfNMEPvTOAiv/TdqIZSsXArzgNnlVsUnzSdrSjX2LkjMyNk8v?=
 =?us-ascii?Q?L+OBLQDj2pkiBnOQDRRky2PRV/dwN/eHNXGMOZxJoq2m33RiRIpgaD2G6NlE?=
 =?us-ascii?Q?IMFnisJrO3SD03CyVX8uB660w4IZ9k5AKeZHO9mR7BXuLdcov/s3YGoXFIKz?=
 =?us-ascii?Q?uBtM2mRPqbqDKO8JmHnryuQw8mhhWXM4xe1Yuu8CF7z+dVwP7Su5SDFLkgqt?=
 =?us-ascii?Q?P+ZbVyuAgADlNZIKdZm9m1lYpDK+OzGZf1BRRRIhRyjE8nUJwtTs6q62MNxx?=
 =?us-ascii?Q?AuqWxwta464ZNs4MMSo+qQPcRkKrp3VcSDHKLw/ot4CDCkzNaIQ2tCd4MPpw?=
 =?us-ascii?Q?OpkK77ypSB6hC6BmixwJAygQ7SrIidffTz/W5Dy7ITXMICtqf5mHjwNP3INE?=
 =?us-ascii?Q?zSCcIBObWErW/bM1n1W35/H5wubi5+uD/jQFBTTt0MFpWytz/a8resP0K0sx?=
 =?us-ascii?Q?e4PH/oJH1OYf//ReqexfL4N3gsCRhYCW27N9L1eWcAUhZ7MjLPB0XKzLPzkH?=
 =?us-ascii?Q?+o9JdqVU7zSjP7lGA8UBkV/8AIMLGgCzhQRh1R5jvBWmguMAxXKr9KqOHkOf?=
 =?us-ascii?Q?SHb8+J3QC+1gi5WhEB1yS8IxgpBHjHNSHAQontwz/Vw8Ttel8+w34IJIXP9s?=
 =?us-ascii?Q?lj7oq+OExqXYR/B/QgYsX1i0mdtP8OPTsJPgxbhHuDFAyzGH2O4RGhPCatox?=
 =?us-ascii?Q?k4Uu1jY5kKR4Y5wJLM73hz4qGtiqfP1o9rB48V6GDlhL/RN+R9rifqqfcGrF?=
 =?us-ascii?Q?wvG4/PBVuDqFDfkIGwmkue91RpyrSKHFQ+2O5SKaBvBVaeGibHgTB0k/FyaG?=
 =?us-ascii?Q?6RHiLYuBHDZphyVJmS7bGUF0nTdsdSZg2vGnKuMsnszfQNANpfM68Mv1NQbT?=
 =?us-ascii?Q?qohqVD1W9sNWe9gpe3k5GCGAutOtqTyhSVc1XnvwEmOWOcENkMeGuCDKbgah?=
 =?us-ascii?Q?JPXPx+DvqiZxoxK6QhRu4+6tpWtJ9vB+XlNqYhPdSRuOXB7SpDROWyqAq0Ti?=
 =?us-ascii?Q?lKQ9WbTcuGt2YAcdtIfkw7LdX+naS0Jz5vbHIHBTzGmFbmF39f2CEqIkV1m0?=
 =?us-ascii?Q?dIMJA+oKXHi0mulWiuuEC+if7yXFbyMwaZCb8o3nP2AhBejnpt7lykUaLeKD?=
 =?us-ascii?Q?Sg39o00a15utblkWsZSWXFPSN6wxEfmU4SVPxNMhNtZ7rdQibb4T4WuhQQuD?=
 =?us-ascii?Q?bnc1/NmenRrs0YfL3StnnYw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Vrxiy4jw9cl3vGJoEOk8rHQSM7BnYvCm/pb+BfpgwBwNr0N0HAQy744f5rIQ?=
 =?us-ascii?Q?Xe/x0kZzmhPS9RAZ1BNj8+W+Zhoj+u6FLXi55dc0jPMx2TZgqzH8nK6z1vkb?=
 =?us-ascii?Q?P5vEKCaxdOKB08SeTFdrlMGrzcEyFy3wpBCLeULOShleenwOl/2mfwb+6Rvv?=
 =?us-ascii?Q?G1ydnyICr1RNtj2wPbZ08sFOr4FLQaSyc4bNm/zriEhcjheIpRzdtpafbBPJ?=
 =?us-ascii?Q?4aIPTCv3JxADZS99RcvXcN8YflOxLTkI6nVjm8sEN9pj3cNECzQCs5fh0FvJ?=
 =?us-ascii?Q?6UmsyA5VYBDUtdh6Zld0nF6lZA350IYbh1ZjmdjMbNUmqYi0VwpAPIZNwZal?=
 =?us-ascii?Q?a4l4vjBmx5R4Vy7Ws8Ehc3ew0RkZ1cd38R6TOHvfsMWa4sdxISYKsJEs4o5Y?=
 =?us-ascii?Q?VLYQrcXmKaFtYL/r3GRllLav4Sc0TCc7Nr4AQmBFRBoWgdreXJhGUfAjlDlr?=
 =?us-ascii?Q?PvR5TbRu0DjWctAOZ6cb71C7Q/kQqayu5zO+mZgsy8LywxqMrj7T46DpcLg8?=
 =?us-ascii?Q?eyY3dDA71zu8/12HfVYcf4hdptoVgKIO/mj7a1ZeqlrhV78QA2SBO4AY8EFc?=
 =?us-ascii?Q?WsKBb0HYPBMmY7FVnZFvn/Tz/3TmFID6QS+g1/Qk3aqIPkgYRXbLXDPAIqtN?=
 =?us-ascii?Q?hVMYeOI9ZVHC8MqOY2Rii9fpG/0TIbork7yJKy/Xex4xob9EFWeqicc0dpGX?=
 =?us-ascii?Q?xTsuWJuK9gmpctDdpLF5TZG695Z+e8mml6J2EXykO1VGaNg6pIXI3uVfvPnl?=
 =?us-ascii?Q?4p95nB6hs9hu0VDMV3uT5HBKCZmP5rDC/UZN3EHvNXQ4IJkk85AUePIM2Z8a?=
 =?us-ascii?Q?EKwNpQvU+qFZAOJXhtiYTVAqltncuhI9qf11+WiKDqtbpPAeEFh2C9qPgd5U?=
 =?us-ascii?Q?Jp7w2HpNCpQOfVvTTLLx3VCq5d5rwJuy8Yv3DG3POiW73DDaxygPucQ9lGVW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308c56d7-ad51-435f-46b7-08db16792041
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:09:29.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNgpZOJ+opiOxYFn0caAAC/9T/ZI2IGbQ23sF6mY6rg8k66oND7pNQou7mzwqedyGbUjHoto0ED3cGqE7CWiGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-ORIG-GUID: uY7VfHO6pGIx6XyXcujNZ9RP3hqW7T3a
X-Proofpoint-GUID: uY7VfHO6pGIx6XyXcujNZ9RP3hqW7T3a
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
Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
---
 drivers/power/reset/mt6323-poweroff.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/mt6323-poweroff.c
index d90e76fcb938..108167f7738b 100644
--- a/drivers/power/reset/mt6323-poweroff.c
+++ b/drivers/power/reset/mt6323-poweroff.c
@@ -97,4 +97,3 @@ module_platform_driver(mt6323_pwrc_driver);
 
 MODULE_DESCRIPTION("Poweroff driver for MT6323 PMIC");
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

