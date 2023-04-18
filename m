Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374546E5F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjDRLKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDRLKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:10:11 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0654C26AD;
        Tue, 18 Apr 2023 04:10:09 -0700 (PDT)
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IA0PCx026459;
        Tue, 18 Apr 2023 04:10:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=P6g88m7KcnMJzM7JWWSBYG5ntcrxAgGOtgnifKlBJXo=;
 b=wkhoWkRbDTRBPa35emp95zhXcRhhTRrmuum4KMrIOY8GD7uNqYiMebJJbgVQh8CLdWUe
 EPkxBNM7b5CQqG815rVVQMrnDRWcis6Wff5j70eI6PVjkUmAz3D5dKSesci6sG7W5CWX
 pAiW+WpkPXdyK7ytoKqo8zue8QniKPdjqTTDyCx0xaisAGw/j8wy85fV5yf1y+nrg2u2
 Xy7odWzRgV1erk7YeoyIm+IX+yjfPUx8xXQOqdf/54y6JTQeFnlpWYeuWKt9xY9JhiPX
 6wk9ULFu1X/+yw7sAt1VNMPNYFafUeOVT6+XPHKiYjkvo17lPlFXUKds8v5+kiaRqw5b hA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3pyqu8dyka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 04:10:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+2kN9DZUFHO1RH/bUCfyHYzqCSFm21tzljjI0M7zQaeS37PZYRQkTM5QibBw6RK/f7g9pMACowT7ShnEcClTVaTiA6ojF95sJt50JEZQk36Sx91Gdt04p5vsJMYw4CnX+izpuFpEMDEptuGQN38wpRY4PtxnxDZp6revkK3GvcDKUk9hsmRy8FmmwfqBHdHeYfDj7C2kkILOVlY/5u2cgHfYeAS1fGCwJ3LBkMCxkDz3hcTfSgnvgos/7mXFsNpTVVICanOhHDacJ/CTUjlZWXGvT6hVCeUZk3NdRh/M0x+2KZ86LSDI2UMMAgwuc3ZpNqc1HYKNsBA6F1/qzGrJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6g88m7KcnMJzM7JWWSBYG5ntcrxAgGOtgnifKlBJXo=;
 b=ST0AN/6Ey7ej1B5FRknaugOrXe7WkeyQLS16/exjl9w5oTGJh072O089bXlBaM7SeTD4RxOVx1d/GATIf1eGvXhPwVYYOqfLprMyllHdSUmC7q0LjMdkORqAvephF6ojSe/3ZeruC7u6kXlgYy7oO+W6mX3hEZ/lhohxUTrk+2qoxrwGNZcI/7hToDpEcncTyuXP2kgRnv2hrgUQRtIiPFHC3snrpz0tNBHOXUMs36Fp+i4+wXnj9VyHWDdq+WXxbyhVexqpMQ/Lpe3xkIJhF+tu+M3/qoumfXpoEobtZZKmC9xl/rncFLGOGbEpgQtfnfdB+Q/XPdC264jbuTUztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6g88m7KcnMJzM7JWWSBYG5ntcrxAgGOtgnifKlBJXo=;
 b=e97HDtwij7exvR/tz9+MxWQPULz1BTmry7+7jSuxwQv+JknRKXQu9h5OHLKlywF8rnuxVh9ZRfxmfHJP2idCP2XKaLbTi3Yg9y+1dyQtTI3wPwQK2vmVtFA1W2mFXXuTC/4GeJaxRdNjwIdnLY8qFcZMiKbqZi39QK9gR3Bk6gwLUQZrJxzJilkeuL+ficxz7e9cd6MyrpwYbBpeTgfCqIcYvPdUb65Y3dprwBqcbEo+6XHs+L4i68BHWGGswMSwh9RUqeuCxuIaYarfzhH0EBp+Hwr5qUO7aTjydhCB9tKZtWs3FQXWuVBIws53k85DWGEOWZEh8Jv9Ru9rIWVeXA==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by IA1PR02MB9418.namprd02.prod.outlook.com (2603:10b6:208:3fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Tue, 18 Apr
 2023 11:10:04 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 11:10:03 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     paul@paul-moore.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH v2 0/2] audit: syscall audit optimization (> +6% faster)
Date:   Tue, 18 Apr 2023 11:09:17 +0000
Message-Id: <20230418110919.221578-1-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0070.namprd07.prod.outlook.com
 (2603:10b6:510:f::15) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB8041:EE_|IA1PR02MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f1cc58-d301-4dac-d387-08db3ffd7592
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gn3/iFXvJ+Ent+TDJ4VHuSTopomjv0u3MTL3LTFenyNAkgLkr0vdCC6UMqb5X2u0bkBd6Suf1SjLUdWT9W90hIGbdAVpc08xFCOwdlES4ZMyWmF5E0w3tKyCHrnH78EvM816+2Xm3uVeDY3z1/hygg+vOnvRFS4c3vZgFkn9r6tu0IkX8wcNXOm7l8HTxafxF48teG4XhUGzCWpEvQ/U9GWtGccqTfYURvGBX7TtQgcU4YSYrpK040dLnnNqOQWTjwbIrkCBKzqxrT9FjPC2ZOdfkOpkU2W1LXbLuy74yvPdMPSeq+4nz6PuS194UtZY5u7EmepHVOkK3Dh1hGkg6lewDROYq0+Nx81QNGSrAmJJa2QjW6jFlj7ypFA9FN1CJjMh5V+RefbrpuoDBa4zQEOx9IYgpBC70Yem5QpDBJPRSOjP5GIOKL/6AqvQspJpCSG5uiV0eZUk7pw14HQtH5qZ8KWsBlINDACBNYlvn+QrBfqK8XpnMyGzLnIaGf6P9iISLyBcRVozFeuDJD73AX1wTaQVtMWH/++ki8KYC6n3mA2fDR+1grpZbJece/mKD1OEmPP0vgdtj0rWenROdK/nhtUp0Rg965ZJxI1fPx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199021)(186003)(38350700002)(107886003)(38100700002)(1076003)(6506007)(2906002)(8936002)(6512007)(26005)(5660300002)(44832011)(8676002)(86362001)(4326008)(52116002)(478600001)(66556008)(36756003)(6666004)(316002)(66476007)(41300700001)(966005)(6486002)(66946007)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p86Qlvxl9ABYrddJgxfq9REQK+OHhCzLFIrpoGO7BNI5PF8y59RYSWD5fDYH?=
 =?us-ascii?Q?abgkg3TvY9tV97n2219upjARFMT2fAk9o+lJbQ2YMTHIginozHhhaVdKVZTJ?=
 =?us-ascii?Q?Opj9Ycx/E83DrBv/NwxALk0miUKdW9IohMrJJ+Vlh0w0NrOrrFu27NuYsgVL?=
 =?us-ascii?Q?uOky41FYxLU7UuQs7pxZPUpa6mry8TZBZ2m8RDkIqkfhB6AXHOYHuLh+WZJa?=
 =?us-ascii?Q?FHgAT+VVOVs88sQBdiDbinqYf//KmeLzDx3RNrxVW+EBtiGz/FLpR680bHbH?=
 =?us-ascii?Q?dX9J/xYbZVWiqh1lkKMYnNAOfrYvwzowy0SnAK50YZe81YuGsXUsgR8QqzaF?=
 =?us-ascii?Q?y/CxBe5TFE5anLgzfsiIeNCrSboKU2OhllWSWw8yKvQRmBZ2lACxmb6eNVdh?=
 =?us-ascii?Q?NKYZUD3dKbxSKw2ttkj35qn6zG2HyS5szqplwibWnkfJD73uTyqNGHw9albZ?=
 =?us-ascii?Q?HXXFOL8BVrhAxNs84s9PegbbW/ybruoPIE4UNGiAhREMCU4IDEG1gt6R00nk?=
 =?us-ascii?Q?/7ruiwXbolSmnzAVvYzu9DZUhLj9vcxlNYshSDqtITmXs6/EDpENQRvU6lca?=
 =?us-ascii?Q?RIHFq02PqMItO23olbTyzk5ArSLkFZUzoKDS2ewKd7A4zrxLHOuZ8ykC786y?=
 =?us-ascii?Q?pwJaYwpZQPN0xhlUjKN12DiXjr3G6zWNKgcOWXGe2U/OmxXSB2jV/c/mVNBL?=
 =?us-ascii?Q?a7/TRdnxtINdnMUImUzlZ9XDPYlXdgCAdAQXKQoNTIO619LmhuFFh1KgEkPf?=
 =?us-ascii?Q?ZlzaRjDnEnwn5xrt3BsWCSxsvuvApe+T4Tt7ZxeBK8xv581DRFa187y02bpr?=
 =?us-ascii?Q?xZqOKuoFbleVmSqyOa7tkP+o9RHE+miM16XMmw1LgsdptdWKJBUiYFcLkhn1?=
 =?us-ascii?Q?MD3x8cekd2Eu7PXCT9Ccw5euZDfrEYE2Pbz/5gpVuT/XITEnubGvK6uTopq+?=
 =?us-ascii?Q?8+Gegd3JuU0OIRwRP6w6wG4sQfCbeDFOh2lk6UwwqKi9V/alVTbjz207Yenh?=
 =?us-ascii?Q?ju+5b5FHcOn0R2H7IlqDIJ+R3YoaiVh2QgybEqYlyE5F54aI6dsax27mQ7li?=
 =?us-ascii?Q?edqDIxnE7hskNG4AdVwv4VkvDgzC+5UdsD203pvkApJBeFS4+mzfMmVLcRik?=
 =?us-ascii?Q?udjKYUy1s69O/nEqUZEasErQxc7oQe2jlkOppcxgl3ZJLaqonqATT4ZL88rk?=
 =?us-ascii?Q?b+vlXsrAPcKZHYphuifiX/VEFGgyzLn920X2nSmYUlOaOKSVamtCiBWYUOMO?=
 =?us-ascii?Q?BjY2uMCqM6rmBRdc/kl/AN9dKDYdu8820uPYKpFJ3M438/1xkX4QiajsMYyH?=
 =?us-ascii?Q?sgwRAmu0QvQ9WenzhfriqUNqsmjl9Z3uvUCk4aQmTkiUpAaF9MndMoq06ygq?=
 =?us-ascii?Q?ld2/7oN0TCyQSJIZMBYo73tg0+2zwVQP7yODXbRbuqYd8wMW6KUc55dvkZQ9?=
 =?us-ascii?Q?QKaRYU3PWdPuZRSR524PXf39CKxL6s0SWLliUv7Rbtagi0c+d5xX/ux3X+SX?=
 =?us-ascii?Q?pzIKj38Fk3j3ekMa5AvDRXVIcvJ+T9lGU8scfAWIK/KgXpQ0TX0cczGOVGgu?=
 =?us-ascii?Q?MPJmoZyOAzg/dVnwGyDZFwH9N6JJjWpnqrlGygKAkcMWvABFpuVf7yBZM9I9?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f1cc58-d301-4dac-d387-08db3ffd7592
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 11:10:03.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPtYVwZ2zrmYsVjG5uNq+4oSCdAe0de1gbDrPoXU7h9Khco00j6+0ovLHw2viiqrb9ROA53XB1v0aluXLJWkr0ym+3MenDwWhbYgfVgdxEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9418
X-Proofpoint-GUID: QnOLOMPiVBgKpElsUHQCxsBY6CrJIo_N
X-Proofpoint-ORIG-GUID: QnOLOMPiVBgKpElsUHQCxsBY6CrJIo_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_06,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is an optimization of auditd_test_task() function.
As is described in Patch 1, it improves the performance of syscall
auditing.

Benchmarks
==========

Run the following micro benchmarks:

  (1) dd:
    dd if=/dev/zero of=/dev/null bs=1 count=5M

  (2) UnixBench syscall:
    ./Run syscall -i 10 -c 1

With rule:

  -a never,exit -F arch=b64 -S uname

Results:

  (1) dd
    Base line    : 2.572 sec
    /w this patch: 2.418 sec (6.3% faster)

  (2) UnixBench syscall Index Score
    Base line    : 860
    /w this patch: 953 (10.8% faster)


This patchset consists of the following parts:

  Patch 1: add global auditd_pid to make auditd_test_task() faster
  Patch 2: cleanup: replace auditd_conn.pid with auditd_pid

v1 -> v2:
  - Use global auditd_pid intead of pid.is_auditd
  - Add UnixBench syscall benchmark

v1: https://lore.kernel.org/audit/20230414031325.82840-1-eiichi.tsukata@nutanix.com/

Eiichi Tsukata (2):
  audit: add global auditd_pid to make auditd_test_task() faster
  audit: replace auditd_conn.pid with auditd_pid

 kernel/audit.c | 61 +++++++++++++++++---------------------------------
 kernel/audit.h |  4 +++-
 2 files changed, 24 insertions(+), 41 deletions(-)

-- 
2.39.2

