Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AB7642CE4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiLEQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiLEQcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:32:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40CE1DA50;
        Mon,  5 Dec 2022 08:32:51 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5FmSrX031059;
        Mon, 5 Dec 2022 16:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=HmUknPKehfmwOKCjqceNHmSEPBtZqknlCR5dmDXWl5s=;
 b=AZETqHcY9JOJwvzbaKQiayvBqQkScjr21wnF7XZa4QHU0OtWGnuF7u9hViMheBXc21SR
 fkxpbYceLvprmBp/DToDZtjSLuu/NT3D72v9Osvd/QJ21MVS/Txi9FE0eT+z/S61IjSU
 +iYciRlW92m8csCX4DstuvUa1S2XSTUIi9IGmEOoJ8avDfPqkIj8ulFtq5qp+PG4SIlG
 2T1Z+0mR/OYARPSLx0oiMJdBZN37NhsInrnzJeoi3NQJ6Aug3aeKgE0u2jqm/NjdA20o
 OShsJDVUoVl66zVA3DNGgVwez3Vn2AomOcnkQkCBlWl/MEVWscokZF5y0gdGH3shT9E8 Uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yeqm9vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQvSE039173;
        Mon, 5 Dec 2022 16:32:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ucdnhqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxRBxYkK7s5G4qfCK+VyLh7qiK5zILlIT/7Fr5DqhNnAJ/5OuN6fGKrreMXq8k4AifeCpVhVfgINcXv3yMjkadvk4NQBNVv2JK1ezwJs9VpUQYw/l5pPIuhqK86S4MsgJqCsWUDXnKE2vQ+jrMeCGb4WhN5MLxOu9sDqF17T9AbxtVrF5tz7iYX1/eByoGdwTfkYF98MynT/gEp7U/p6iCqViqrb2wQHRl0YHPZrqKLFeK35Hbr2C3HeIGlfita4T9sckem3nDa72ktZdk/zld/uhM/sYNJXb7kykGSI1pr2zWAnPz4E0s29XggFlaqrTOSTjrtclXw6SETqKc0MTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmUknPKehfmwOKCjqceNHmSEPBtZqknlCR5dmDXWl5s=;
 b=mjL5z7V/utQ4SQ5ignqamh8VCHYHPmcb4HOsTKBWWFqFqVzxvKrkHTHjHnrAW1z0B2a1DO4G+9PBhNIMLThtvDTvnL3tVZxN6qYwh+sOx70sBzHCimJtuoy3p3gUxKLyZcMCLb60UktXSEgOc+hx/zAMSGpw/4gYBIzcreyicmQEqpfHf3y1xnNQpgGXHfDKEtYGTOVLC5WpMyxENZSE4P26N6Q88xIuMLjGyqbDvGxVHAcVECqm1zQTG2oRBKjqLh+EFgMHjDJoqZbLSJYs9V1XQsbEhGptCTP8APAGZQ71pz8pZoMUhhu2f7Vo2N7PaEIWUZ+m2DIzA/A3XBMH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmUknPKehfmwOKCjqceNHmSEPBtZqknlCR5dmDXWl5s=;
 b=I7ltCO6YEAWj1G+AIkUox6YpTVRwCtSFKKd92aH9fguH/tlKvIZVSpKuK6qUqrPFHaIfOGq199+Ap6SaDwjuuxFc3ki3o9OiFFm8GQkmgYwZFr1lFLooRyX8v5pzcX66D9Ir2gGmLYgoPU+kHegX8JUAX/5uNj+ozkMaophXHwk=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DS7PR10MB7324.namprd10.prod.outlook.com (2603:10b6:8:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 16:32:43 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:32:43 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v10 07/13] kbuild: generate an address ranges map at vmlinux link time
Date:   Mon,  5 Dec 2022 16:31:51 +0000
Message-Id: <20221205163157.269335-8-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::8) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DS7PR10MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd7cb37-bd56-4e76-7107-08dad6de5583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WN/dy2O1zY9zUNm/5h+bPY1ODfMb21MZPCuQN0uqzY04P4RZDEwK0ios2AxFIrGAEh8hY1vC9oZbcm80FrUKkR8zp5PCPm718I9fvxQbfuzh2iOKsoDs44tGpbueLe9zRkgMswuDG7lEWPF7qlLxMoixnoS0E2ES6jgsvcgx0WvJZUvwLUUIMzT9SCxC2Cg43OnEG3LKbNTLhB0kf62/cswBvsms47llzNjglc8mA0xj1XUOL3zCamjjk9rLiujLU2Z/KgwvQwlIWolkE2VmeWnwZLpcM0UYrxXRTV4zsq20jpZZRH92cV4ogWNZJ2qXddS8JWLqP8nfzIa11GoDtaJXMQf9fFdQjAbABKYu4IuwJ4PTlrMUvj5OCjcIT98JU0oHl6RKZzKRBAMuqbQHCEbPdfB0POvsbXDdZ5iYvN+vaOuFStVzN9rfw3LoX9+sDueQCRCi8q1yiLso4pi3HjJJ9l3JiJmZA8rKpjQum72s4wr6V3EzFBPuDEl5QyRfFwunTlk1LIsQjVdQY+z2zg74ri01h3csra86EPEbiq5PN+WDfN9cJfhM039XADHsLevl+fDBBU06tETbIeXb4vV/r/lrPNE6MtfvWNWFzdCSZQ9xDpw2SDP8+iZv5DZfbSO+uwKdppSE1bNs9SDxEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(86362001)(36756003)(1076003)(2616005)(41300700001)(66946007)(4326008)(66476007)(66556008)(8676002)(44832011)(8936002)(5660300002)(6506007)(6486002)(107886003)(478600001)(6666004)(316002)(186003)(6512007)(38100700002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rA9hNnko6xWb27amdR92SjFgEAyxn/gZRZINFkh3kNsrVmynYc2ztqLhlLsY?=
 =?us-ascii?Q?unrgLDr1LmhpvPvkJMNjtZ2M8aDD4piJh3C3UeOdg7gnt/UDif9pGSc1Egtj?=
 =?us-ascii?Q?GtxDyK4NVUK0uxFBDbBSVwWLpnH6MFGOaX7Ni+5Alx4mvw+FO55qsH+5+ZAz?=
 =?us-ascii?Q?LePWk//IzyZPDNTyf378UkdFzn7xxm0Y72j8aS67d7tYFhPddYBnPY1BelKn?=
 =?us-ascii?Q?5e+kla6R54eOsANPkewJamoTiWzB0WivNfjbFFR9Q/lsIn9rMDOn2VcRlT8r?=
 =?us-ascii?Q?8CLVHu6fvszeJdDcp3Y2sp/ofHWbBF8eNnbEQ/cYjzKIghpHqJZEhX3kG0u0?=
 =?us-ascii?Q?03Sa6YvJtkx+YfxyLN0YNewiyexO9DjXZKUzPC7m8jtZ3cSYFa8jPV074naI?=
 =?us-ascii?Q?7tUZsYuXD+ZULQB0lJDzHvZV4Kfty6ugDjTChBjAqKbj65hcA0mUU/ZSiP0g?=
 =?us-ascii?Q?rH4O9ogaJYMz+M7Okl5Z6eYRu0lgY/rPJ4j7rSd4q1yGTijM1O/koV4rmqC3?=
 =?us-ascii?Q?Ppl4U1FuApH1rQ2opcYBfIeHZdMZqq3Ha+OWY211z/CmvE0kXMsZ7sBm58CN?=
 =?us-ascii?Q?xDxTUpntd0J+7684ixKACb+s+04vKlIQckI4pz2447cOxFZYYs9wX/D+kz9r?=
 =?us-ascii?Q?n/QDpt6VhBIDcBHSNf/9IU3ewqGqyF+A6IHH1BqMeIqMW1Kt5ITt5tQx6O5F?=
 =?us-ascii?Q?IdZpYQcgEPe5Aflqg/+MpQmSMK7UPkFwN8gsF0fe6Zl/EycwqCB1NoOHYfyJ?=
 =?us-ascii?Q?przNioqCU5E3fX/Lwn5HMiefpV5WyP6kiGvf+IYgUUfzV5Yt/vhySmSLZ8Qh?=
 =?us-ascii?Q?Klay3KEYxBDaw0UkMSyFDq7wsl5/EEFhstluLmj3aywynL7W26xFUpcZkn/H?=
 =?us-ascii?Q?KHZVby0vjSrNZTggxfdVmEUMm0+nUKRsesPKyq/U8fJAfboi2gIqqUG2MAye?=
 =?us-ascii?Q?oo/AQhrh6RwwlAz1IOhD4iGn0jw9B/DB+7QKHizv3H2bn3LdvX0yzM9CDG2X?=
 =?us-ascii?Q?5NNALKC1RYOSfVPRD7THGEYqEzKIZfD39ZyiiLJDgwBaZ1VhisTgLjg61oBu?=
 =?us-ascii?Q?fYAdXmTA3U6WMb66lXe0++O0actiYjHHc2VYwyeAUypxoNp+M8azbSFL2ztA?=
 =?us-ascii?Q?zc5zfJCo2YpUhrfWXp/4kwZA1Rr55B4dQscaD5hYzhD7D/xceBI3XMySjck6?=
 =?us-ascii?Q?078Wmfzqgu+BPS+boeGrWQRE3QQKkgOEWebEoeX0LbETgM14/s0S1IDboXZ0?=
 =?us-ascii?Q?MfM3ZIQhQXHXJDtEw3S4YxuKjKC3NWm9h94FQfxYaaI7Z1mUTWoeOwtGCpz3?=
 =?us-ascii?Q?UiAk9Sm5MIBkF0oPCkSZ2gGCMXSA96kTHLcML/fcJoUBwx0iPVBFj4Ike7Ct?=
 =?us-ascii?Q?yQ4ONVFlsCtXpGeEeD87RuIhvZV41PhKvONfjrKOrzDUXvmR4tZJ1NyLFBxI?=
 =?us-ascii?Q?NUIta/vqAszcByQTosQi7q6fWqYmEDoCLKdEw6CptDfU0TaB+9kxD4lrJWlz?=
 =?us-ascii?Q?4LnTviQJnM7xXEgM97K7yNggUGvWPM/SWvSMWhIPRzxKeBhJMPoLWU+dsbua?=
 =?us-ascii?Q?Ohh1c7nZFb3gf30dD5Lex4/8rfRXUbMOSOg4d6JfPVDJmzI1Kji/XKWcqkHa?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0DLIgnR8bSFRuP7jRBwu1AeMArmnDV/akCRHneBWrB/UXYynx/lFTy52JW3Z?=
 =?us-ascii?Q?jUkKIqMyhMgImqsrp7ftBKkzdb1KprrlPlQOikITzWHA+J1drJ9Gy3qDiRFH?=
 =?us-ascii?Q?5WHQVyjinvAlj1i7+/DTagI0dke7B267KNdzQq5tDKKNDw19v9DbteclQoxj?=
 =?us-ascii?Q?0lcgTg1MSgtMOj+82m8BGvozawdHuOuLMKRbwRdjucTsyvYGzFh9QPWdn3bO?=
 =?us-ascii?Q?mD+aa9pDYebf0WXKiDzKAtSnhnpihKhgau59ZhcuXFnsh6E43VxFURxBQYtx?=
 =?us-ascii?Q?Yp0vX1+leS9vp8F9UfwZJSGVj7sUIG4zYRjo8BSRXKJ0J4MNzZ8R2P45OiAi?=
 =?us-ascii?Q?bi8fkf97Ib3e1B4uqwywJ0UujGPLyHO6jATlTwbFwdmVaGevRbGnLwO7V652?=
 =?us-ascii?Q?+KLf3r6Y15zOFeXzSJUBDWT/DY60YI/AaQjjKszxUf7zAFJP+9sXvmy4OWHu?=
 =?us-ascii?Q?9vNpdl/rjJLvXXfPmpy0jdlY0gzsEa/+y6tmeCTmetJ4F/pZXnY4uwRUxqcx?=
 =?us-ascii?Q?H/ZoFx130K9PsJN5VYam1X2PHMZ5hIic0S0DYul5vM6ve6Frk6ymfSrGT9p7?=
 =?us-ascii?Q?L9c7ZMxsQfjLmSVN39njejGuJMl0p4oiaDLUJBwsqnf+RgZNwPuCIKjmVD5i?=
 =?us-ascii?Q?j0maYjU0e/aoH3GAr84nhyi8HCZSC6NLenm49HFk75O8vv5LbBO5yKBfk9Vl?=
 =?us-ascii?Q?vAaygkveE10SBsaVn5BcLiJJG54RPL45ObnvDDsFsLu8Fsj3kSKrW4iWpCsq?=
 =?us-ascii?Q?K4lQhFBuC1VzIPKbYTKOG6vW3D/AKuXQ19OcT+qiuSRTQ7W4VQcNSVXmw8wA?=
 =?us-ascii?Q?n5MLPYCStAr4cpY9T4JfnaTqp/DCrhfbI8agLsuPCD9nm6L9FhhyElBHcdxz?=
 =?us-ascii?Q?uHmDKy+OCqkpbmxj7Q9Wugv0+ZevHvCK4zPQB4uO73g3Ud5+lH53DER2TZ86?=
 =?us-ascii?Q?qZhJvTL+n5eQpss0fdfsnPedKZl2WDm6jg0vWCuG2GI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd7cb37-bd56-4e76-7107-08dad6de5583
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:32:43.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZxXhgOnBtkNLchqQyBFoAHJLgBkfj4R6m6L6lZlxLCGKt3LOtcCLgb7KSF/do3gCesXYF5ihU0+M7/1vUZfCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050137
X-Proofpoint-GUID: ADxBPUqObwMMh_bwklZw5xDHmzc_nhAs
X-Proofpoint-ORIG-GUID: ADxBPUqObwMMh_bwklZw5xDHmzc_nhAs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This emits a new file, .tmp_vmlinux.ranges, which maps address
range/size pairs in vmlinux to the object files which make them up,
e.g., in part:

0x0000000000000000 0x30 arch/x86/kernel/cpu/common.o
0x0000000000001000 0x1000 arch/x86/events/intel/ds.o
0x0000000000002000 0x4000 arch/x86/kernel/irq_64.o
0x0000000000006000 0x5000 arch/x86/kernel/process.o
0x000000000000b000 0x1000 arch/x86/kernel/cpu/common.o
0x000000000000c000 0x5000 arch/x86/mm/cpu_entry_area.o
0x0000000000011000 0x10 arch/x86/kernel/espfix_64.o
0x0000000000011010 0x2 arch/x86/kernel/cpu/common.o
[...]

This will be used by kallmodsyms to let us associate symbols with
built-in modules at address-range granularity (i.e., space-efficiently),
and to let us disambiguate symbols with identical name and module by
annotating them with the translation unit they come from.

In my simple tests this seems to work with clang too, but if I'm not
sure how stable the format of clang's linker mapfiles is: if it turns
out not to work in some versions, the mapfile-massaging awk script added
here might need some adjustment.

CONFIG_LTO_CLANG by default optimizes by working from the LTOed
vmlinux.o file: but this doesn't work for kallmodsyms, as the resulting
mapfile lists vmlinux.o as the source object file in all cases, ruining
its attempt to disambiguate symbols using object file names.  So we
suppress that optimization in this case.

We also suppress it when IBT is enabled, but IBT *requires* use of the
intermediate vmlinux.o, since that's the .o that objtool has run over.
We lift this restriction in the next commit.

(There are similar problems with everything else that uses ld -r: since
this amounts, in total, to a few parts of KVM on aarch64, I haven't
implemented a general ld -r fix: the fix in the next commit is specific
to vmlinux.o.)

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v6: use ${wl} where appropriate to avoid failure on UML
    v10: mention ultimate use in kallmodsyms, conflicts with IBT and ld -r

 scripts/link-vmlinux.sh | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 32e573943cf0..a40d372b1289 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -60,7 +60,10 @@ vmlinux_link()
 	# skip output file argument
 	shift
 
-	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
+	# kallmodsyms needs a linker mapfile that contains original object
+	# file names, so cannot use this optimization.
+	if { is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; } && \
+	   ! is_enabled CONFIG_KALLMODSYMS; then
 		# Use vmlinux.o instead of performing the slow LTO link again.
 		objs=vmlinux.o
 		libs=
@@ -94,7 +97,7 @@ vmlinux_link()
 		ldflags="${ldflags} ${wl}--strip-debug"
 	fi
 
-	if is_enabled CONFIG_VMLINUX_MAP; then
+	if is_enabled CONFIG_VMLINUX_MAP || is_enabled CONFIG_KALLMODSYMS; then
 		ldflags="${ldflags} ${wl}-Map=${output}.map"
 	fi
 
@@ -144,6 +147,21 @@ kallsyms()
 {
 	local kallsymopt;
 
+	# read the linker map to identify ranges of addresses:
+	#   - for each *.o file, report address, size, pathname
+	#       - most such lines will have four fields
+	#       - but sometimes there is a line break after the first field
+	#   - start reading at "Linker script and memory map"
+	#   - stop reading at ".brk"
+	if is_enabled CONFIG_KALLMODSYMS; then
+		${AWK} '
+		    /\.o$/ && start==1 { print $(NF-2), $(NF-1), $NF }
+		    /^Linker script and memory map/ { start = 1 }
+		    /^\.brk/ { exit(0) }
+		' ${3} | sort > .tmp_vmlinux.ranges
+	fi
+
+	# get kallsyms options
 	if is_enabled CONFIG_KALLSYMS_ALL; then
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
@@ -175,7 +193,7 @@ kallsyms_step()
 
 	vmlinux_link ${kallsyms_vmlinux} "${kallsymso_prev}" ${btf_vmlinux_bin_o}
 	mksysmap ${kallsyms_vmlinux} ${kallsyms_vmlinux}.syms
-	kallsyms ${kallsyms_vmlinux}.syms ${kallsyms_S}
+	kallsyms ${kallsyms_vmlinux}.syms ${kallsyms_S} ${kallsyms_vmlinux}.map
 
 	info AS ${kallsyms_S}
 	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
-- 
2.38.0.266.g481848f278

