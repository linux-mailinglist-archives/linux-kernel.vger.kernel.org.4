Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA515FB7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiJKPxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiJKPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:52:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0514243326;
        Tue, 11 Oct 2022 08:51:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BFOQj6028190;
        Tue, 11 Oct 2022 15:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SL9u6P9Pr1i1wKOUL6cbb5+Fi7uDRntjgaT8r9uuxOc=;
 b=dEWnbtxWGyN9NVsXdXfwuhQEl1wvFmPFVULtZad4pHPz3boPhLHdTYMEk3G52ChXKaWz
 5Hky/6I0tEeblQJLinnWM3HC7B/+pE0aEj1cYJ+qOtH7Q50dpudpbLOw1u5tjAieWyyb
 dqYe+aq2Wi8nA3VBFxv/VmmOjtNtSpsBPvmESKwZ1/breY73Z2LNRknkAeMQNF0tWM22
 vGTq7beh+0Z7cSPXmq6vdAYMcCBoUBt7X8i4xUvaQXylHYbueD4Ji9gdD+eH8cJ/RuQD
 maXVe39V2fHjUsgGJ35XklzCFpmiWX6NfoVp6yygLrXfXH8Kq0vg3u4ejEiqOa3PqYaR Jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k3002y7ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 15:51:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29BERA3I008701;
        Tue, 11 Oct 2022 15:51:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn40eaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Oct 2022 15:51:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvHkHRLakn4GVF9Lm7XYHvUxjSbalPwtgO+AVd6tg/vw5SjGxvw/4/+uLPJF3kB37OG3leEh4rCpfH5PkjoYCVGlTX1GO4PYEKafp3E3GOzIwSQ7l9PsN2GKJ8MNQs6KX04Pc2mxpWfDXR7Y3mTwth4JWisTmJK61L6AYhWX9WrhqRhYrH8gAatK25CD+043WY7ekLG1o6U5sTersPBJyeOVANkVeb/3FB0LFX8qX3uqK1PXho9hO6n1RYVhTFKMc1s1cMG0yNoSS3djq2sIogdB9VknIWXKlRztcbaekMqbvmI+dOOUlhJ/K2iOLNTEL9p34bIXzwxVMPorlWDq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SL9u6P9Pr1i1wKOUL6cbb5+Fi7uDRntjgaT8r9uuxOc=;
 b=YctnTmG+H6gwAHvBuDw2jQJNeMpFxCHkmaHYtWvf5zI0RGSUfDg4cKQSd6k17Eoqi4A1rHsned8rcjj8AfcS3unHSFjPfWVCYfql9pqPBoYqGVW7EoLISs5QnX5OkWb1VZ6Su+IF8PmUwPJ+LYcZPSfjH6a47CXtNxlkwlZGVO3NCtIOC9urBbmc//Ls058nzU6McbpWZxfxkMiKtP4C7Bh6aFippIMALZG2GtQsTOXG4jQ1AZ5x7jB+zgrbflSPPiFtLh8edNJs45Y+gpW+PKdMyqPevg8kPqaQNRx/+YwwzUMqWfDIDUX1eLtk3+0TY9n4cV4QDx4opy7gn/f65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SL9u6P9Pr1i1wKOUL6cbb5+Fi7uDRntjgaT8r9uuxOc=;
 b=j5t6sZDZdglXh46482ZzhxDrMX17xpvu0L+PBZd7weuPRbIlVr28LORPTVWWvoyLbJPcq6hqiFNAwJGpjYZXhySJJ4gHb175CvT/7KqnG6UCcKevu4LpJMmgsPwJ2J4pRGJUKE/XEQnz7ZSDlLNr+prFVqWoeI/F9rwoENVxsmM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW5PR10MB5691.namprd10.prod.outlook.com (2603:10b6:303:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 15:50:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::2d77:5bd1:1bba:df5e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::2d77:5bd1:1bba:df5e%2]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 15:50:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: Observed recent memory leak in __anon_vma_prepare
Thread-Topic: Observed recent memory leak in __anon_vma_prepare
Thread-Index: AQHY3V03loebH+661EK2n5Cgj3aUWK4JV7+A
Date:   Tue, 11 Oct 2022 15:50:59 +0000
Message-ID: <20221011155051.qgwfbbeeshvoaotj@revolver>
References: <CAKXUXMzmfeF9K4SkUcR2i6T+ZqEXvwod4hOzCPfQowMJULy7eg@mail.gmail.com>
In-Reply-To: <CAKXUXMzmfeF9K4SkUcR2i6T+ZqEXvwod4hOzCPfQowMJULy7eg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|MW5PR10MB5691:EE_
x-ms-office365-filtering-correlation-id: 30a640fb-2bfa-4297-da61-08daaba06498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iycwdFuX1s21iMkXoqqed+7WI6OpYwaRuhldKMZyqpbrqJGVF/npxZ6QkBuvwBTJVv51DqpwDzvH3IHHVUrwKQZcg2seGs8F3SaI7m4mCFm0ST+Dm92GkEL0uuOm2yzWdEcBTFSBjQI5UX0lFEuUsuo+b2kMTre5/oX88EN1hjdWeq98YrtWYfXbLL/3tZN5QCTIehUnxL/hzd4VyxLZVeVPbHGNj6LU5xDnwykflBC+R5xeVcAAiIwaUCOQ2bY0HJCjWbTMbE2i8VsYgCHB8BOGSCLctUoq6PdO7yTMUZHSqUOGRFdey/XziZUKFBd1+T6iqcOD3vGKxRmfk42g5XX7zjuQjCnYiKB7s0CFc+9j9k/y9gOPhsKMFVI5qoOxfPRGArDQ+EMO3FDw57cxy0wodIpDWdaKyRz6xlc2uPSJJ9vPCzxWNWHLR2jmI/9eB1Y6jnCY9BG2jsHtGL/k2E1dpz4X4nA3y/Or4MaGq6MVtLZ+0lJ12V+JHfMr6XCceznDBwgJV8A/Z4186BDhqVBWn5w7ZfU/SLyD7PbrThH1rmweFjTwtsYS0Xf548TvuLkrW+Zm95BYcG+dI+Pe+v01mu5BUDBpdxaKF/fcSppyU+TfGwoZt64OCskRlKIOtPnC3K94uUsB5XdMV3LEcUJEm6hDsZIAt6pOjTJiDMmCEySRussdtlDvsPDpCtwXGCAplWIpaDJymFGTzsBijw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(5660300002)(122000001)(8936002)(6512007)(38070700005)(26005)(6506007)(86362001)(6916009)(54906003)(9686003)(71200400001)(44832011)(478600001)(6486002)(33716001)(66556008)(966005)(76116006)(64756008)(91956017)(4326008)(8676002)(66446008)(66476007)(83380400001)(41300700001)(316002)(186003)(1076003)(66946007)(2906002)(38100700002)(3716004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X6PVWs7iCc3Moe+Pc/36EEe3zUdildYXec900ygdEMt8ldJaEuX7PcW2drvK?=
 =?us-ascii?Q?zoqTI1noLc9ary7jF/B0Xa8hpy5zEwVw3OTJYI/rcMsWHXDhCYrigwndt3Ef?=
 =?us-ascii?Q?xeDCJ4qoVT/Wy/fijb5rALXok/FoDliup7DCFrggQyXgxHN4CcNaVIQgedMO?=
 =?us-ascii?Q?XoRt7pHztblHzjnehLi+xGmN9OocueYWQ3KMs1NVaCSzC/Vd6p6YFKzhmPhs?=
 =?us-ascii?Q?m+vlBI5YyaoqGXgG3mulCldTKQNxgYkGPCmFtoGAJd2iog11KMZZokS/jZRY?=
 =?us-ascii?Q?bTmg1glmfrve2PZjD4WvPIwzEjtLN7CDWEMgeZp2c8sVSwhN/dhZ/foTlOvf?=
 =?us-ascii?Q?CrvVrpjUC8GklQARguePXh7b77KowIps0Tv/Lb2Jqpb2Fr8pF+mwqQfBdtkg?=
 =?us-ascii?Q?piiCnUuXLjhnXHxgKQhai5bBCiFbsXc8f9TVqXBU44CG45VrbaaWKcJol9mD?=
 =?us-ascii?Q?S11nMnrCyrzXjmm4eIElcMJcDWSjNxQqiF1CwL5j2HNxtKkg0EbKsERZkLxi?=
 =?us-ascii?Q?UKgoqoowlNroaM5VJ3PlAmALJ7n6zbu6Ivb+/vH8+xb3z8YKyM/lzFWT53BN?=
 =?us-ascii?Q?RfAPKkowQPbcibyF07c7PLWHytVgOmtObdrAO9eKDgPJxbvGgrs3T6BuM/9A?=
 =?us-ascii?Q?4roNwu6jXzNHwxeM4rAol6dZyzXZB2LtfjamZXKJMFWhr1qb0KveqlxG/O2N?=
 =?us-ascii?Q?PDxkuP/GOGPVP749syCGYgDRvT/pEQQOzGJOCHVyPh6Uxth0sopG2PLEbFFB?=
 =?us-ascii?Q?3cAnCyi27b5+KzUHIpkeSMjapQujfUez3eO105+QjdtifFYzAIaiexehzOt6?=
 =?us-ascii?Q?vPFIavBYYVODuBnutOCFt4Z8KXbqTp7J4excu4qwqW3lnS2bXxh7s8kpYUW0?=
 =?us-ascii?Q?w8HiYA6iKww20Hh6x2DqDGb5y5NDDobrveA9ybhdjxHKgn40tFOFCzMJTeo5?=
 =?us-ascii?Q?Wq+aA29L3UwLyO3R4lG94K1uCnfeJ0L/zkgRK1Brh8yg2R3ByCDrGf3AQEnZ?=
 =?us-ascii?Q?81yiL8LOz824hsqvx5E5nrSmBXi8D45bzmlhsKZyj0IuyudXUsLqfR0fQOXd?=
 =?us-ascii?Q?bvVl6btR8O+bSyyJJL20ulR8Q6O/E3dRVp6Jbq47Fx5bowUgmX+Grn/tRPWG?=
 =?us-ascii?Q?5iHjjEiH12inKtwqZxdIJ+0aqy6gceaL4il2t0dvQHLNvEFwCeljuFku5emy?=
 =?us-ascii?Q?OL3lQ0KIxOoyq2qsBKVYESx7UoPTVUOs48WIwuKepcRrXuBcPuER0tPtxLpk?=
 =?us-ascii?Q?JWc9gsJBarksgMYCrrDFH5bOceoRn+71J3ofDtk5LeAAwDUq/w/SS6zeDHVS?=
 =?us-ascii?Q?v8++D9KPdx9jkjTsEwW51ImkP9LJWgQs/DUEiBabeF9s1Irdss6y6zpiuYjx?=
 =?us-ascii?Q?SNz4G0PwhUiiDgK4L8ZwUqrKkKrhKgl6CZAJX9yo2LOUqR63gzj3cfU665uR?=
 =?us-ascii?Q?qPOkCZhTJMCzk+9d16Rzb0mzRyod03ggg3ZiO2e+ahplFUVmVPWkt7CXVorJ?=
 =?us-ascii?Q?FDZYij7W1daLAD9/DgF6OIGeNBcHBeMNkLuMJAzMXG8SnUwcIqUq0p49L01R?=
 =?us-ascii?Q?8pl6/BUFOjE9njZay3yFsAb1q4uMuYDHHb+MqZF1H3jRChVdbowjBVyj65M4?=
 =?us-ascii?Q?Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FF296D72C96A5C4E95F582B6363DAEFB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a640fb-2bfa-4297-da61-08daaba06498
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 15:50:59.6733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hh1C1eIVoVd4HmeOrI5PO1LL92m8nfr+yoIUvNSFGFoXLd9Gxn0sAKsy7eIPjuMo1ZWv1+GPZG7WKCovk6DbbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=966 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210110091
X-Proofpoint-ORIG-GUID: JRO9nITHeR30ZOns1fVeQ1wVMf8hbSWc
X-Proofpoint-GUID: JRO9nITHeR30ZOns1fVeQ1wVMf8hbSWc
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lukas Bulwahn <lukas.bulwahn@gmail.com> [221011 12:35]:
> Dear Liam, dear Matthew, dear all,
>=20
> The reproducer for the 'memory leak in __anon_vma_prepare' bug (see
> https://elisa-builder-00.iol.unh.edu/syzkaller-next/report?id=3D3113810b9=
abd3dfeb581759df93d3171d1a90f18)
> is reproducible, it is triggering the memory leak on the current
> mainline (commit 60bb8154d1d7), and it was not triggering on v6.0. My
> build config is a x86_64 defconfig.
>=20
> My git bisection showed that:
>=20
> 524e00b36e8c547f5582eef3fb645a8d9fc5e3df is the first bad commit
> commit 524e00b36e8c547f5582eef3fb645a8d9fc5e3df
> Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Date:   Tue Sep 6 19:48:48 2022 +0000
>=20
> The git bisect log is below, note that the commits 7fdbd37da5c6,
> d0cf3dd47f0d and 0c563f148043 are marked good in the git bisect as
> they caused bugs "BUG: Bad rss-counter state mm: ... type:MM_ANONPAGES
> val:2". This bug report might have overshadowed the actual issue, and
> hence the bug might have been introduced earlier, but was only visible
> once the Bad rss-counter state bug disappeared.
>=20
>=20

...

> # first bad commit: [524e00b36e8c547f5582eef3fb645a8d9fc5e3df] mm:
> remove rb tree.
>=20
>=20
> If there is more information needed or other bisection to be done,
> please let me know.


Lukas,

Thanks for the report.  I am trying to reproduce this issue and have not
been able to trigger a memory leak.  So far I have built using the
defconfig from arch/x86/configs/x86_64_defconfig and run the C code from
the end of your report above.  It also produces some output that is not
captured in your report.  Are you sure it's the defconfig being used?

------
# ./repro
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such
file or directory
write to /proc/sys/net/core/bpf_jit_kallsyms failed: No such file or
directory
write to /proc/sys/net/core/bpf_jit_harden failed: No such file or
directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such
file or directory
------

Note your output does not mention softlockup or hung_task issues.  This
is on 6.0.0-rc3-00207-g524e00b36e8c.  It is also worth noting that the
resulting kernel does not have /sys/kernel/debug/kmemleak.

I have also tested your reproducer with my own config which does have
the kmemleak debug file, but it did not trigger a memory leak either.  I
suspect I am missing a config option?  Are you using gcc or clang?

Thanks,
Liam=
