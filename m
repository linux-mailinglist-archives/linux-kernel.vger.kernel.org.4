Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE396A90DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCCGXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCGXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:23:46 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA5512587
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 22:23:45 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3234Unpa023493
        for <linux-kernel@vger.kernel.org>; Thu, 2 Mar 2023 22:23:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id : mime-version;
 s=s2048-2021-q4; bh=WzbF+tKK7VH5Jh8sVA8Gm9VPjHt8CtnRx0l5UFNmvkw=;
 b=Car2loA0l1Q6yo+1GCJBPzU4rI2Q5c2vpipnkSx30MAGBNe1qdYFdw7hggIgI2Uv7VDt
 CQ7uyLJGC6AM595zO1lG0lnYPzlJI2z9x+SjXX2dTMZ/kNL+VFtzhX+CH3CG/X9jn9v3
 roiuqgiXyegO07hA/JQDARkKEpiN0ray7iaJoQGYi1PQLHvL+NbMu2tdPR2apNmaidKT
 MCCHj4PglOeI3uQ4nqPpHKDcSpexlbqyWwu8EX1UwT9o6ankwUlpgtK7CsEMTerOhq4e
 jZw70vrvzG5A5/IYjYLQks+xMm/H+rhC6Ezt25fst1m68rv/jg7Poce6AOVP8F0s6eSz xw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2hrvse75-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 22:23:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoVnVQVZgtLfGoo/nGRw+U9ySL01S4B9ygAQXzF86ndaGWwKCwv0Pl0pDBs3rMeyxT0S1BWhIVWbWlEwAIl37rvdh8MOZNdBAYnB4OX87OF7D9ftvmZvNEx9LSTwRSKedwB0kR5+TAzhr0F+vx0+bSKSO0Gujc4nPaRvkRp4b8hnGTZPa35IU6uF/jgmCy7sDyDeGLfkrd/B/I6sqzncsf6CCshQKWBT/2TJkfs/oB3KqdVGQF3C7f9TPpQ11uG0e49JmZrpLtDV/AjHH/K1TAuXaCpK+mlG1f8A+3ymz8o8WbBOV/e8vYnzh1ihAftUkhDxNihFIQYAzrrxo/34ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzbF+tKK7VH5Jh8sVA8Gm9VPjHt8CtnRx0l5UFNmvkw=;
 b=YrnP1AS24/d96+FxRB2jJXylXS95h8nYxRN9th2fI9AzzG20fZyYZnZLJmU1VmM5KLAEeVNyyVLGPZkLPceKIuOG/G3FWVSke8XfUGDnNUU1zDcpgQnozj6j5BNEejGYiQhs/B0EFpHUaU0RtY5j34jLY9O2D8Ch8PssTOOUH/dcvwt/7bgwFcPIbqhrY7iyExYhFiDnSVtyUV+tRKl1rdAzLr4ukGZFHRxZib6h68oq03EqfvA5v9mAf+vrDWpqKtgibCQ+7SrY6UB9FFNOuHUkEyS6YztsVOsyKvY8UxZL7TNV3Bebb25wEedokfVTuAQ7xxa4LcTEPFkFnWs4GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by PH0PR15MB4216.namprd15.prod.outlook.com (2603:10b6:510::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.20; Fri, 3 Mar 2023 06:23:42 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::4376:73:fdf9:d34a]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::4376:73:fdf9:d34a%6]) with mapi id 15.20.6156.018; Fri, 3 Mar 2023
 06:23:41 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Nick Terrell <terrelln@meta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>
Subject: [GIT PULL] zstd changes for v6.3-rc1
Thread-Topic: [GIT PULL] zstd changes for v6.3-rc1
Thread-Index: AQHZTZizPPDdAbP3s0il0/S8yASGsA==
Date:   Fri, 3 Mar 2023 06:23:41 +0000
Message-ID: <C8C4DFDA-998F-48AD-93C9-DE16F8080A02@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|PH0PR15MB4216:EE_
x-ms-office365-filtering-correlation-id: bd0ccefa-2d40-428b-dfcd-08db1bafd585
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3vyPkP6FgAodW/z2Q3UtBRaZkOv+9SZC6sFqa8Nivh0j/8d6SFlZ5MecP9xAb+Q8y72c2QUYEoA4phhP4E4j/NWgVTKWfTbauQEpYknCkDYe8te/vul2mQX+C0m9CjOKSEtHF/7u+0gt6Jnye/7EovQmxJuZn35A13iHrZD86at8iqf9FnK+TJmb0r57IJoYAeNnDuSkuCzJmlm/LaeBKKPzK42hgvT8S57SDmIvvhSPwhtyTCtN/Ju511ZpmNKDvkRN5VIABIPE+GBmMx8ZZg/rtnDdJQbDDwzjUkN1iZXiQ4C7lGRMSMVoTLx+O3/9g6IF6qU0gK8Dw6SHPQnK9d0zkZ7pZXQPXAMt6hKnJ4c6BG7Crb3fBQZyh9jD0dE164gwZxTTEnq4tVXHgWe8dWn3jEFazHeTt+JAvOX2HBP4Bnnc7zNK8oVAhyeaSrQoADykvRX0PLE73qN0p+d1lqxFerOFVzN5IltmI++g8lUnX+SU0EHqpC7uHk1M8AsiQNpr41RyEst4Y2hJMxuGX+Z4OnDG9sqK0UioplX+eq5XV4exLVJI498HJWTpg4zNL4js0c/Fa0JOjFigQippHy2sXNG/CIf0LJeMCZIzFqlThuQMEOYgfa7BsJth1UKZIVYq62NsAQcKgYYQ59FohwFiCiczTUhXCIO4FxE28Z794dLypH3isQylxgAY2VAtvZ05B8b1d9TFkUNqBXxCEXAspfMLb4zJWqdec0g/b3E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199018)(5660300002)(6916009)(41300700001)(36756003)(83380400001)(8936002)(2616005)(66556008)(316002)(66446008)(66946007)(2906002)(66476007)(76116006)(8676002)(64756008)(33656002)(4326008)(6486002)(38100700002)(966005)(186003)(6512007)(71200400001)(6506007)(26005)(86362001)(122000001)(478600001)(54906003)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7usg23+hf6XfY4C9itANn2tMYXnZNDyPFYFaXgu+RZLYK+c/OhwLUQC2/Snd?=
 =?us-ascii?Q?TZQjKuhF2/ArfzX2M+UUcjQl3LPmt1O+1qSDgW8qSTV3Cz+L6gRGu8YpDs1m?=
 =?us-ascii?Q?MIvJI4y6TqbkHhnWc6oqz1AVm6ags2tnxTXDyAA3sd8SAyh9i700hMkU17MB?=
 =?us-ascii?Q?WP7TYcZ0c9C9e41J1uPKRr2yQ4/UWNAtaSebYerRygFdjFfpn0lrm092O+ej?=
 =?us-ascii?Q?bqnzqDHJKwTiw0/MIzcpklbyAsXLKfXpmQnKtWipQ89gthSR+RZDNeHklZS7?=
 =?us-ascii?Q?Uoz4Bw5LPYB3ghP9HFJFltXjZL1JffwPCotqqB4G25BuRuZZSQU4Lgd9W9CI?=
 =?us-ascii?Q?org/FCKU7+6fUTLPr7J/aCSQn7W1s05ReAFuU8e4IBnOoUU3ahwsPZdpRjd8?=
 =?us-ascii?Q?Mv+gERZjr2Lh1RAz9y2j4fsVU4fscYM5vHgNXOviSTmoOwpOOrosoUNbWVVz?=
 =?us-ascii?Q?2FO0zhwKPqpLvzuOXUo6kcNms3KW6fW04Qt7l9O6nrjWHJF6mgF5JuLT8eL+?=
 =?us-ascii?Q?7IwEBxYQ13WtFn23XYa8ILEYbgOBRx8Z3DPc2MSe2LnqLhq/jg/etNLnRzmY?=
 =?us-ascii?Q?D2xKEcsbYIhp486Pjt/xkklyYzrMBB9vBNijGpm754ubeAieif8LQ6sPVPVv?=
 =?us-ascii?Q?1N5PgWLTwnoKUirMCpxocEWElB3gmA1YpbAUdAgaCdXLLGd6SeNj4iJtOKRj?=
 =?us-ascii?Q?QHBw+wX0bfzRqAT642MoNDTC8ZyDZTQPmnWps5IphHC/n0u7M/FvSNkAVw9i?=
 =?us-ascii?Q?3oe1M+OUnJqUYw8r6ELAF7u5V9b/ptIbFH3ramUSt1aXnzFLgvmeXNuDKkl6?=
 =?us-ascii?Q?86gI1s88NnSKYjU5YfL+RYRno5/cpRulbKOxXGFS4VQCfC+EXBZGZKyqCuPW?=
 =?us-ascii?Q?O6E/W3RzmMArslYdckacfE8wZH7/b7j7pUmhAg2yqvuCqXqwJxC3YPJkSSRp?=
 =?us-ascii?Q?i1Jmi3vHu/XKFj4P/VZy3nkjyfJMxBBrRG2dGaljvPHtZqCnDDateR5aA3RP?=
 =?us-ascii?Q?8/dy5J3xDyYQQEmfc7GmRuXKUzNy2nbyzPzQbSfI2b4kvPi53FL0LuQwCIEx?=
 =?us-ascii?Q?yxG/k5WV+I4QNQPIn9ZQ9B+wdJuBG3NTTeGXqVv9PmJ0/kuiXE1kjmVvgF6D?=
 =?us-ascii?Q?pN4Hi7oYBcFOHh6d22Iuq5+sVcUGIF/mPAzSFoKUIS7bFLR2dSJLEm36EW1w?=
 =?us-ascii?Q?lmx8R6G/obcY2MEKvvsHKNzvz2sj5CAAB1uuMvtTilNwFfucx+KD4pQJLlf8?=
 =?us-ascii?Q?4x+jiOtzWOh5NzHNLxet2Z/NTJwEHik2DwFsl+wZYwijfZdGIpcX80/WkRth?=
 =?us-ascii?Q?GI7wXGqWN9B/O+3T/tHOqCUG8xZtV6+SwDH8dH1f8e/HlJ7KrCVUwsIJeN0a?=
 =?us-ascii?Q?ZbnFfTj+2BFoHwjSc8mP4htX1n1JTIqKImQL/IJ2zCjVuBtAA4ahkgpc3Z/R?=
 =?us-ascii?Q?Vnvkpm66L4yI0WRAb/RUG7f3IEzWqd6YnSrz4fIQCIfP9rxAN9pSjZI27YNG?=
 =?us-ascii?Q?T+/59VhOiGsUpXkUxAFeecuZMQwvQevcqTTv3VdLzeAwFHZiuW4qqrPeVCRG?=
 =?us-ascii?Q?yCGetdgWTYngnLeLU9clUh2HHtUnZ8FLmfldugZd?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AD0D6A2D10F22D41B092A333F59E369A@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0ccefa-2d40-428b-dfcd-08db1bafd585
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 06:23:41.8292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohPolRAnYsne+rLnsy0Hg8cEd+z0RjHBJ04s1VyKqep1gJ2uyLkIkhMu1qAsyjLPqAoB5ynBaoRHhGif3Oxanw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4216
X-Proofpoint-ORIG-GUID: E8OXjwgPQm_2G0AZbhAmkzKMNgikuqD_
X-Proofpoint-GUID: E8OXjwgPQm_2G0AZbhAmkzKMNgikuqD_
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c9c3395d5e3dcc6daee66c6908354d47bf98cb0c:

 Linux 6.2 (2023-02-19 14:24:22 -0800)

are available in the Git repository at:

 https://github.com/terrelln/linux.git tags/zstd-linus-v6.3

for you to fetch changes up to 9844ed7e93967c0eaa27cab2fc80583e38696a0e:

 Merge tag 'v6.2' into zstd-linus (2023-03-02 22:15:55 -0800)

----------------------------------------------------------------
Zstd fixes for v6.3

A small number of fixes for zstd-v1.5.2.

I'm not pulling in zstd-v1.5.4 from upstream this release because it
didn't have any time to bake in linux-next, but I'm aiming for the next
update in v6.4.

Signed-off-by: Nick Terrell <terrelln@fb.com>

----------------------------------------------------------------
Enrico Scholz (1):
     zstd: fix assert() logic

Kees Cook (1):
     lib: zstd: Fix -Wstringop-overflow warning

Nick Terrell (3):
     Merge branch 'main' into zstd-linus
     lib: zstd: Backport fix for in-place decompression
     Merge tag 'v6.2' into zstd-linus

lib/zstd/common/zstd_deps.h           |  2 +-
lib/zstd/decompress/huf_decompress.c  |  2 +-
lib/zstd/decompress/zstd_decompress.c | 25 ++++++++++++++++++++++---
3 files changed, 24 insertions(+), 5 deletions(-)
