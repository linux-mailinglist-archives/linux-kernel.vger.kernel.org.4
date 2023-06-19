Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27A5735A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjFSPAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjFSO7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:59:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7967211A;
        Mon, 19 Jun 2023 07:59:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J9nGPX006551;
        Mon, 19 Jun 2023 14:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=OiB5s3stXpg5sNJ7GH1oar2b9BAnXvOVsmLMSoajXcM=;
 b=U7yJIuURq578aUj2joEzA7EejNzFIkbQnrPQX7OKereEAu4hrEEec5yxl8gwHAxg6r3W
 gsdTVWQM+zPyL7VVv0reKluJ5dqxA7URUV/U9hTwIoDRkvUj2DD+LIvTm3TWjKa2Qw1w
 NFZ/iVMthhYJVRKvw1YAxNkaD3sXmuPIpdDhwswFe1S3RDp3Hv+Xo7gDEp1bGPyuIByz
 9749X6c1bdWNYy1DP3h86CUeokazwwSs3FhCuAKewi+kTWdGdOY6zo/QEUme+kZoke4o
 MYul7Ps29WBh3JELEWrSU8paGBIRG5gqJscs54coxRPIIqrwp+qdGwzqc8BLOKYEsb7N 5A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3jx6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 14:58:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35JEXvUK008354;
        Mon, 19 Jun 2023 14:58:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9393spd8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 14:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+DM2K6BtNphuwl4abvTBQ6ezwgylWx/149tDMrQzmdglhc3Lyq3v1ULPelR4Hj+FrThKWEwQU6ezAfdo3DTW4Zoir4HOjDjnGCG/g8eLfLNJWPpontGLoEdDkVCLG0HFDY38MfntW+g4+mDLn4TSwhxVHunxM0HHI+h4If9aYE9RqeN0dvSS4j9P4jRdSuIB832jfhi4mVKnilhRTdUEni0UNqdRylk3H6N2qhAGv33h7kDL71TVODZJkELtd6rkH6gPr/pofC/MKOgvY4gThOUAvSbpbGMw9Wg5VEuroVdharUvd3lypgFQzfijisujn2Aeg9Beh+/3+NE5TRAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiB5s3stXpg5sNJ7GH1oar2b9BAnXvOVsmLMSoajXcM=;
 b=J0//H6sN/mvCtsnL2ummc+rhsLu5UcqRbCgYBMGOzclEJokDyR1tA7sMgMvihruTRwxKzQuSTTuO4FWKQ0NOT79MjJhDWOzD+gvLoNok+zZBt8jbMkVqpKahnNwzyCJ0Hn7gWVcvULRUEgXhu9wXh3wrOf5p6dsyZEtMV+LwqmOw1zJ0FV7YO3lSWBnpLS+l5804VTHnQH4xZbzZTeTrYtv4Z2Mee0hSe9faC7p23jLeI1nYhnaRg1TbLtAjnsGaxfDz51piX7B4mXxoBRJPsmHLpMaBiHqc55tedcQrus8jLsBDkFf8UZUGFS+DYmRpfbBUFNU4b0IXE6wSJuxE2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiB5s3stXpg5sNJ7GH1oar2b9BAnXvOVsmLMSoajXcM=;
 b=KkYJlSFoymgyWrZVeolX+UYh33vRrgKNnhGYcXR+7IOr5OzadaFAwMX/om8wrD1AKUS1IYQBo2Bg0b3lrsQq0AAa5Ne3If4u5lOqzU/wrqaubVWrnbg5BoAyPSDzJnZjt+0iPUgSa+yAtN8W4LNh4neSnwhnUatd0hf6pBZnRpk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM4PR10MB7426.namprd10.prod.outlook.com (2603:10b6:8:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 14:58:25 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 14:58:21 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, geert@linux-m68k.org,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Cc:     kernel@xen0n.name, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, hpa@zytor.com,
        keescook@chromium.org, paulmck@kernel.org, peterz@infradead.org,
        frederic@kernel.org, akpm@linux-foundation.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, rmk+kernel@armlinux.org.uk,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        anshuman.khandual@arm.com, ziy@nvidia.com, masahiroy@kernel.org,
        ndesaulniers@google.com, mhiramat@kernel.org, ojeda@kernel.org,
        thunder.leizhen@huawei.com, xin3.li@intel.com, tj@kernel.org,
        gregkh@linuxfoundation.org, tsi@tuyoix.net, bhe@redhat.com,
        hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
        eric.devolder@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v2 04/13] ia64/kexec: refactor for kernel/Kconfig.kexec
Date:   Mon, 19 Jun 2023 10:57:52 -0400
Message-Id: <20230619145801.1064716-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230619145801.1064716-1-eric.devolder@oracle.com>
References: <20230619145801.1064716-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:8:57::24) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DM4PR10MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8e853b-3005-4ccd-cc3b-08db70d59ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLYr1lSCxl4hnEyN0YGUxc/IFhKSkEc4KzA5cEhWTzkX5jATNzOW4Vd7yHnLc84blhcx92bTduoj/GvfRyGa3+4+9Pzm/gudilSQn+keYUlClQ78HFUZqxVXYdN3kOVau6U07rG04KNaet20zP0b4IiZ0ddXTaCkE9di99yKBvPKYoISrxo0N1N0OabD45zQgyJtiHVMl91kX8miBlR9KDgXhgs7WD8SJwb1AmZ+i4jBEsCEKxA41oViifbcQgh5S6fVnTOA1zmzAcZ6elhclNNdxN5ac1K1mhXl5zAbhupmq6Wq2HoWg30AxiBJvof/gAho4caFLh8BvIlEIKj1POwSMaRB+A7WgTYnKtapxXUHacu1uZtLg6xNW9Y7xu2foO+GwIhkWs5bJ7K4P1FkOcvbndI3XlBjpI1oMJ5hSl9kYsazHALHURjvIyWic8yYo9zNJE5TAhvpjVVlHMDQlGbB9sDPcs/EkkXq2Zil4SaLBiBgINnFadV/az9V++CAfiZMhfCxvuHmmJFLSVUGQOU17NOiJxuMMQoVSAbydL7peXztbb1rCPt2O0X8PmOMmgz8UgiQdiNwAM5EYIciGZAYQLAS7D4iqxb9IJzroL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(186003)(478600001)(6666004)(6486002)(86362001)(26005)(1076003)(6506007)(6512007)(107886003)(2616005)(38100700002)(316002)(83380400001)(66946007)(66556008)(66476007)(4326008)(921005)(8676002)(8936002)(7416002)(5660300002)(7366002)(7406005)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aYhKRly86io+xuAZUKIfkdztZ6llh6qGGYnLEe2/V0nNj4BxAwn1kvXj2EXd?=
 =?us-ascii?Q?fTi9PDnxP4oYn4TBwi78U1ti9KfCGUezah2CXdbWecRf2oUbXQ+kKQYz5TC+?=
 =?us-ascii?Q?2g34nVCGgvjYafd+oliKNmVs7qgz0htyinSgdbv6GPBsP7TCOIJ/FJgCK1Zc?=
 =?us-ascii?Q?9FZ6nrw28yiGJJwSMoSk+6o2f5vqUAfnp4R8C5xQH3mise+H6Mjf8cYvI4k3?=
 =?us-ascii?Q?R64ptzDw/LJov+k73zu/xSynFjj3nyYuBJ9UmRVv7g5GPTk5f9kkd3ZqePNA?=
 =?us-ascii?Q?pDDboIyJaCSJXRGtIr2rcxblDFSeYemBvzLfjom6zIFFbo8qsSilhW0d1Jpe?=
 =?us-ascii?Q?/Ip+0tQ+Pq+y0DS0vorKhIRD6xB99sS1gMPtbujPed+hyfSg3GLhZkk6xoOU?=
 =?us-ascii?Q?HPERa4mvAfVVzGi7v2bozkpRH9ICRz8ayaLn/N4R56qiNMukirnzlsNewWXd?=
 =?us-ascii?Q?BFAvMe5wOahS53GqXdt+chVrV1ANUkjFJQXEVvRnveQihyWdKyZCjejQMNqN?=
 =?us-ascii?Q?uJfiA/C+wHLpnZrNyrcZeiNmRg4qmbj9IQPzwb1131xRCSMeQZLKu9sQsPbx?=
 =?us-ascii?Q?gv8D8xtiksjAL5CQsAbzWNwaGLYPyZVHhy1OQQmdg13jWXssgoLlB9AMfF6M?=
 =?us-ascii?Q?m5gKLB++7871KupoyVjBgeqUw4+l+uC5zHHKPof446+ca4olgzgJbT1EFlAk?=
 =?us-ascii?Q?1/srPkyG6I90rtVoDV/Aly3O9HCWAAjx7Obhh6mz6IvlG75Dt25TwTRE+wy/?=
 =?us-ascii?Q?0ZB4hboaDXQGhpaPE5QKd1fwitWp9PweaZngnY/y3vVYC6xfvxYvcXlMeZP+?=
 =?us-ascii?Q?4wYVynANHl+Ut42G9m5ghJW9VEUEN/qeqAA2er6XmUkVv/WTS9hdXbLqs5je?=
 =?us-ascii?Q?FxbEKMXetQv82Mb5weKxOGbXo6exNx0aiKBBx/cGCA7A5L3GPjOXwLLrw7Yf?=
 =?us-ascii?Q?I9cLo/WAo1iUp+22PPtCTT+zPZOUugyENZmN9y7IeHJY+fKthyCuySHtpUq5?=
 =?us-ascii?Q?trxD2ycYMrZW5r8PL7Cz2985zBC35kL4YfoN5tOVnsZaj2Pg7TzkCIwFF9kv?=
 =?us-ascii?Q?EtKnMuUu/cGSMniH9z+m28TGfxJ8h/ZcNKUEudrIadoH9NzvB3sp1t8Eh6Bo?=
 =?us-ascii?Q?eee/K8HKyPO3PjkpVjZQfsLeTIgtuvCnNObRWZKMzSqKcFoIoe0UH2LzouFq?=
 =?us-ascii?Q?IOs3tfq/fVkDkpYCzyVj5SKUrnjd/rzcsAOPRIjvg9KnGJr6CF+DprwOHNDJ?=
 =?us-ascii?Q?JxidxVgw/XGk1hdJ5uCrEAdkxU3GINCFTjy7MLLSTSqOoAc9JOwsjZze9PaO?=
 =?us-ascii?Q?cqX8lhTWI1KOT2/74x/hDxzIua8BtI6VZJmvjX35EJItNG6jSOeVEmm/ALPu?=
 =?us-ascii?Q?jkDXmE4yup3XHevnaNxPvcfmVLJvz3n3qqetIwHMv1X2dDLu3S8zOwGzrJZ+?=
 =?us-ascii?Q?wTkFDfN9S7fohQFOxpIxhLEYWYR0MTUR6/LjSA6JHYlf8T+x7tY/EWbKasxm?=
 =?us-ascii?Q?lmRHVl1Vl5Jq+Q7nFYzVRVFBz3L4TaKjqu6bixrnaMWwBTxXnnGjJC7yu3X+?=
 =?us-ascii?Q?9nN0XG3z6BFav+Kpx5UQlh7kIPPXKcVcBcNf3HHTf76FfEzknN0e71PeKct/?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?23bvCx4FqiUmtG2pNR0gjKIPpzp8y1gEf45PHwr/SFJFbJwxEjPURhuQWFLi?=
 =?us-ascii?Q?tkwNTU+mNhoQUBeJ+Xxx/pRWTSh6xt8UAaFt9bh4/F+kBqdfrOSdblv6k9+0?=
 =?us-ascii?Q?au1YHVJQSC4D0akMgD+fqboh44aO6uQsFrsQkn07iAZhaPBm8V+mpye2AuHE?=
 =?us-ascii?Q?h/3TaOK6vSRsZVXt3Qo/kZB90Fk4HOcwNCFDGDZooPcJULEgcqJxGttCtBvk?=
 =?us-ascii?Q?qOwl5xuySqfmNqaScNHAfEykjzhDOu2Y1wbaE/3TzCW7GDHEcfYVQN425ge2?=
 =?us-ascii?Q?DwvU0lBS0fZlEMy/8bsDVOHodjFVQZ063XBeRv2NaWgG+Dq08Nta5q36/yei?=
 =?us-ascii?Q?JMO1hoGMsuevwnc1or+KMIZZMpzXqfkkC9y5wSFMr52V4uEWoprJJc9DMzXG?=
 =?us-ascii?Q?ApojbF5ePvyeFvxDQPdI5jbCjy7By88uRDiV4tPx1eB1N70EVf+qcrxy/rOF?=
 =?us-ascii?Q?pP5BgNR1nCb7gNKOpVuVaoO56AOrWArABTqifBUgLz9tjlwDSzBAYw/gv0Ty?=
 =?us-ascii?Q?9BVj1yHlo7QZFzs6vphrwLBKzso9NUxxnZjXzHubK0LIt//iQSirD7q6PXUI?=
 =?us-ascii?Q?Or/w+2AHku/RYPIusOTxlLfe+PHknilT3vA7XQoZwy5jSR1yqvJ1XAowHRvh?=
 =?us-ascii?Q?dUuzmTSxiALh9omBwfpjCULSQASbo+fCyURRXIH3XTrv5MKmKfndIidNjocC?=
 =?us-ascii?Q?rW9+V90tbD6Ip9MrsAYiGDX+OtBx6aoc/iih8ozXWSrReMB2cwV7OMm5tHS7?=
 =?us-ascii?Q?aTl4HaNax3Ui+fvTqWApufAqDcwaux4eIRWMg/JbUS56DrGrPx7L8oUokrzt?=
 =?us-ascii?Q?0MAjk9gtNP1X4B84jS+Jv+WIzxEiuJhoW8gqdy8O4ch1yZMCuZDLDg+pilka?=
 =?us-ascii?Q?P2s5MvHJQKrlZzVIuZ7D5ypP9OKV1G/STMFpuh+bYNAAUn/rFldwmYTkyyVi?=
 =?us-ascii?Q?Ce3E2PQgvdmHDH9oC6djqWn8eA8IKga4V1XBHo3zEwlQOmm/f11MS7bJhgtp?=
 =?us-ascii?Q?uvbTLtlD3DX6IKaUG65fsE0dUT3np7K967d2/fre+3ihS6uQTCn3Sm6LmRM/?=
 =?us-ascii?Q?9VtPKwSI/dLQhQqM2lbifucEJEhxDI9qLXtQm+ey7qn0Wp+gHBiHXnmfQxl5?=
 =?us-ascii?Q?B8Ss1nBplDK9V9ocYRm1+oQaG4+wV7uHI443KLJ33APl4RVD73yQYyKT3InL?=
 =?us-ascii?Q?oAiQDf7cDJvQ6bpjzo6sZRjFY1dbOH2IVBgHnAepvxMaypSABq/Gd4Tp7Aty?=
 =?us-ascii?Q?792UevdiGd9wkzaE2ZuMNSNWltRv3BKnlKQxXDj6sWhGpTqZxwZTjNiKqI+6?=
 =?us-ascii?Q?MVEod5TrCn8uikIXc1PfqMo25m0VR9Usxy3FGOxxGpyQ0wGtLyVCv2v+GjmQ?=
 =?us-ascii?Q?WautLF7iDBVlopwDTq+w/oeVFF+4fyTyJfalAOhM9qOaY4lECKobpeTTnP9l?=
 =?us-ascii?Q?ZX30nA4U4QnvUcQEu203tFl0EcDXI9Uz8AfrfItWDCpeThtWsC5hkDtemgMI?=
 =?us-ascii?Q?g6Lbz4FJSiRbAdB5flVIYUdve2t8bLeyHgBoBUOiSySZOHGOpw23cM98o60l?=
 =?us-ascii?Q?1qnV/mxP3gmja4XuMwS00YmslKDGWouRnizHArnMOOz1k5I7POStzQ4u9Qmw?=
 =?us-ascii?Q?DyacO6OOl0VwEVoankLrJxrkS3ounXv8v+DP2JIDqehUE7GFKRJnWqX3UbuZ?=
 =?us-ascii?Q?jeYR5u2vi1nC9cXl+c1kuOzJdaO6KcqW8tLA+/wmdkXRPmUxzX6jnuxroIQb?=
 =?us-ascii?Q?hZTbAC/O/Q6/LWUfbvjv7DJVLRWTTXdSIdVmE66UAuEB1pzEIn94AFWoM3J5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: fC9IiO7We+9HVpF3uGwt3A3sNWykSAkRF2+up+BIBLw2qbkru2E0pGggoFf2YQcIoat4d611ruuFk3Nl9wcN5QJHRjjtAdMH4b8qz+VHu540MWB5as1OJl5Gk8CPjUMvyw14TqcWOl+7TmGz5l+FayhIFzyTvdmtuOWTTw8vK42SYoc6dLOq0e8snh+20HsuLfItM6cdC92jX+jztWNnclGsl3dOHO5qiSd4e3rQjOLoMIW1pqJmnMNqnQM75phOJzhmbKbVkN1cdG8OvIWsLF7jnln8CzymODKetudcB6eMbDPYbf7gxEKUdn6nuXsPeJ62j0Ds8GCnURdcx+cg0FlpsIPx5pN/6ryeDTypLymJrNWkDH0nUnX9GbSOAXdfYobnwgajFWDrq2mC8fbnNnmy5H0fdviGPLIQfH+kv2Yj4F4HTGKv9EzpoHGisaF81FT6jDiwbYlOlA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8e853b-3005-4ccd-cc3b-08db70d59ff2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 14:58:21.8481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiYfODiRYYS2jvBjKQgcTbu1HL2V3ABWB1O9khLXn6nCDx+ta8SxyNnrSyLCgaUEn41lGxlLdaIrUepDVbS4qEe52Ht3cdk8a2bsWJVm6GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190137
X-Proofpoint-GUID: qyWiWPh8fNpTwDOut7B4GCNbyCC79bp6
X-Proofpoint-ORIG-GUID: qyWiWPh8fNpTwDOut7B4GCNbyCC79bp6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kexec and crash kernel options are provided in the common
kernel/Kconfig.kexec. Utilize the common options and provide
the ARCH_SUPPORTS_ and ARCH_SELECTS_ entries to recreate the
equivalent set of KEXEC and CRASH options.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/ia64/Kconfig | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 21fa63ce5ffc..df54a038e6da 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -360,31 +360,13 @@ config IA64_HP_AML_NFW
 	  the "force" module parameter, e.g., with the "aml_nfw.force"
 	  kernel command line option.
 
-config KEXEC
-	bool "kexec system call"
-	depends on !SMP || HOTPLUG_CPU
-	select KEXEC_CORE
-	help
-	  kexec is a system call that implements the ability to shutdown your
-	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is independent of the system firmware.   And like a reboot
-	  you can start any kernel with it, not just Linux.
-
-	  The name comes from the similarity to the exec system call.
-
-	  It is an ongoing process to be certain the hardware in a machine
-	  is properly shutdown, so do not be surprised if this code does not
-	  initially work for you.  As of this writing the exact hardware
-	  interface is strongly in flux, so no good recommendation can be
-	  made.
+endmenu
 
-config CRASH_DUMP
-	  bool "kernel crash dumps"
-	  depends on IA64_MCA_RECOVERY && (!SMP || HOTPLUG_CPU)
-	  help
-	    Generate crash dump after being started by kexec.
+config ARCH_SUPPORTS_KEXEC
+	def_bool !SMP || HOTPLUG_CPU
 
-endmenu
+config ARCH_SUPPORTS_CRASH_DUMP
+	def_bool IA64_MCA_RECOVERY && (!SMP || HOTPLUG_CPU)
 
 menu "Power management and ACPI options"
 
-- 
2.31.1

