Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ABC63C573
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbiK2Qpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiK2Qom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165A65DBA1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:40 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPitX017353;
        Tue, 29 Nov 2022 16:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ybgEjmcxyXzn6SLbjDkyF2beeUDZYojyrkcHjBc8Iu8=;
 b=OEWLMLbffHslJ/18Awg0yEguRcbo8lLg/dSWzbvLaNtsva0VU4aDiTM1RrVHRD0x88tj
 g5xgn9RPqQULJk1tNz4uuhefqZb9ud/GaIsu7xtXJgJHrWW1KkifilIoM/GVU6hKcdeu
 nc/2saK2pcL033QvI4i5bQHtIbutQytAobF1Zfo1s/nseqy+iVIgGYP5Bg4ZAnKoj9oa
 JL2ip7jK5QnFtbcv0Aoq2N3La4806l5TZamj8+8Q37dUsqu5HSZ7EHlQosl1nIbFDEoE
 7cpV/x1DmUvPccmjt6DD43LU5uuelbU3QQzQSYw7KYw+orSdhY3wln3CtDvPFwp3Gj8z cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xht6hmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPg027963;
        Tue, 29 Nov 2022 16:44:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4Akz1FZz6jA+McFm5JBGtYqorh1BhVYiYUwLfwBZjGD9zZXWhz/YykpYmrWFFAosji93kjUtNo2R6/GXvnE0+PYXuSBPiqSwsa6VcZeE2Quy4eI+/b8PDq2XN+2V92yCMe5FyUKb/roLh7LEo8a4c3yB0yZx7vNQm7YWH9aCQPmi3zBvJJbpoKLuMsNLkx3UEsbkwZOF+GcM0X+XLrwfnLctCV5L3aZ3cfyohArouzW8//hv78yEtriPf/v3BU2LgDq6be//df5yl7tEmwLLryzJrixYHlHWV430tdJ/Hqf2ba7G4potFxs5R4PriwPsJSrfcauZrUzxOXwjzb6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybgEjmcxyXzn6SLbjDkyF2beeUDZYojyrkcHjBc8Iu8=;
 b=JNg+JsuugaTMXV/Mnb9/VK3sLuoEa44oFFxPn5feOFPX1q3MfSHfqzY4+2KSQWPPf/MbQ8dzJnOfdtFyawf33FV+yA12UYsqEeRB6zNKgkkCptpPcYsKT1XMJ3Vww9XIgOPn44IX0XeXGzGbNUKmt13p9q33or5NE4WzkEuPsV439lGx8aev40sV13swWnbn5q63PdTwFW30ycBnYwS6m8Ml8l0Oe5p+w0cgP5nJ0RGobmJAP8SBMFwrzzZZvJRpLCcfFws997uVrgp5FFfnVFcb8rVM+2MtuLRayjRhLnuh4Qa7gDYoaJVvAHkA2A0B4fuGfIQ7ZFh/w+j4jxtghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybgEjmcxyXzn6SLbjDkyF2beeUDZYojyrkcHjBc8Iu8=;
 b=fyRMBgAzrhMmL5hUyslvImeTLw/aH2XQ3hsKoTiAZvbEGh3KfhuODjexI0Rg66c9QSTZdJz2Uz5kHG2mx14atRVDkYcxhSLeJgLjbBIGWGx6ovuHu+6urEIw9G5DqG5oHsOSdwxm5cOA94f4DlzEh4bGTG4vyuEFzL/gTmx/VNs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 15/43] mm: Change mprotect_fixup to vma iterator
Thread-Topic: [PATCH 15/43] mm: Change mprotect_fixup to vma iterator
Thread-Index: AQHZBBHYq25QsAsFGkuJY4+12x9qFA==
Date:   Tue, 29 Nov 2022 16:44:26 +0000
Message-ID: <20221129164352.3374638-16-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: a81fd741-1559-4f0b-14a4-08dad228fb3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AhP29fq4oiWkcLtZfK2FfBDQN8hLrBJybBQEp3AWHEYTfQeNwX8FkGZ2wavL7Tw3QpDXfJ3zCDB/eBoLrdYxTOAvifJpYzdgbf1mHZpjpUy/36OD0KtIRWtS6TqR18Rc7I1PGtOe66Z5z4SBfF6AVeVioRQh58jvRHSu7tUhLQZqyzNxOe3RPXtH76E9WstdJNup8nIdX3qOzZXXeuftgS7lufiJsNtPjkv30mDHT+K6M4YQj2dbwa02bGP/FjzQsyfWZL23UafTG97H63NaR7DApVD6NcBMJ3e3lA1yqm99buVeAGRyH8Xcay/mlXrKPUVc37uOGgHnbngg3vKwfw6CecYKthzaFuDnB8XXbvNXgC20uB7oLA3XdKgRr1/sT8ugS2zsOdzx1CRLIzdrgnzijdfI+ilmyRIito92FnSD5rC9Tr9UhT9cSInqXy/vumeOEHnlfzSjhNi+xFKkxUE4mGKdAUwGiokQ8AkLCrve17Hssx7mpguPDasXuzrft59M8MOsNK13aU3tr6AhjhqTg6iQ5WyGbdWi7nAW7Vcbw7ktP4SSttQZVQwpNa8kSunATywNQ5lUMtLPiLkC4f4mcqWHF8g1zlxa9urd65PB+mbHHsAhcMpvq7k4QjAGXjRQSZJDHNzEfZMztS/qY9qVVRaM4cpS+wo4sPov3qA9LsZU4J/mbhSuvYFLza4Ct3q6nIvY53BrfZO2tIslJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mpTdzyUUghgHK8x5tmaAbRKMIBV8y/w8dPze5xLingkBzwMEoKIphPDM+F?=
 =?iso-8859-1?Q?YaRy7hdzPBr7zT06k8uFXUCH86CiNLAg0WP5TabsR+3nF1Px2NYjsRNv+/?=
 =?iso-8859-1?Q?ZXP2Gd5sedF6jRNvPVDSAT+poCp9dKFL4N+7+LXSTdsuQ6NN80JeoIuQqp?=
 =?iso-8859-1?Q?kTTJi8Pv9joLOi4P4kXstzdfYfvYsrWBNE6VRd0xk7Tf3jNEr+CkU/Q6Lz?=
 =?iso-8859-1?Q?klYbOeKgjP1q0bTd8fSXV5J6OHwbRnzUBbJg+jLJoAspWyy1u5P/XCo1wM?=
 =?iso-8859-1?Q?KnZDqP95AtDihcMMOw2W67668UbgCkT3GC75DCtx4qP3J7a/9sv40AdrGI?=
 =?iso-8859-1?Q?z/ABZLSDTaquQl7Ek98hfYgQGGZsax+sVOBCmXAhFMryg4rBgdBYi1N/WA?=
 =?iso-8859-1?Q?agmFrMywzPjQPAaBzC/H+joGc/EtjdExRx2EX09vyVmZ6b+w+A4UDgKuKH?=
 =?iso-8859-1?Q?A4GUQ/fsvgJKeNFrxAebEOwKL2FydW8hwidkMXy3WmiAO6rZHJV+SgIxF9?=
 =?iso-8859-1?Q?VdvQ8XOhrsyz/oFwiGHgSS2iSoWwPFbAzRAJJgZtQPfrAfHqKv9WhWSF5x?=
 =?iso-8859-1?Q?vWhibJB23rq60Kh30AsyBhMcY0xjTnm78UVw5Q+kpoWod4LR5GTnex1Ct4?=
 =?iso-8859-1?Q?iz7G9yHiw6An+0xejKpzrbLq/P2aE7PG+n/cZbMwxMbjdlWlebw1z7a6eZ?=
 =?iso-8859-1?Q?wT/L5b2QT21yyYLS/UzyxGA4oAmQ4KWhkIuN5Ng5xZCzFE5SoY+68aXAr7?=
 =?iso-8859-1?Q?bVPmBjRYqHdZpR3vXkHJmIP1aRGCaHBlANQmd8eCtP6HK8M9J5Z8ufbQPl?=
 =?iso-8859-1?Q?P+KZqBUjsnwN2ryB6jwFoFuIO4stKwVQcEXMXCIBICXDi9EJ1Jpuh6djiq?=
 =?iso-8859-1?Q?vkRbI+J9HKkxlUMkGlza7f/cVzbjN93WyZCJnX/Lc7/LSCNzYyLadjVwZB?=
 =?iso-8859-1?Q?OgVAU0SNAQslT2WoY1g1jnS7xwdmIdfmK5EyFb2lR66eNGg0/ljzQVD6Kz?=
 =?iso-8859-1?Q?QycxUx1aY3dKEyH6fpP54hHXjGW1/zW4EqhjKI8IEpX20XDRSZmtDTdMAg?=
 =?iso-8859-1?Q?ajDRXklH0aEuY1ttQlaaATotHatYxiABMkXD9I1BCav+ZqWm2HfFbypL7G?=
 =?iso-8859-1?Q?6U+KfKqEvNeegGCg7Sg1FNYzxwaDqaRrzUC+1cEu7yKlPgWNRzU8IQ73n2?=
 =?iso-8859-1?Q?PuPswQGGyfQW5tvMvPQV45g4UuBvq1BpLP7ZvsS8I9aOB7t6cC+E/aY3wP?=
 =?iso-8859-1?Q?TaGO0o5v4vkW9XTviCAuC1M3Tuk8zAlxsnr9uT+FG23tFD5mcZzt0U3MEV?=
 =?iso-8859-1?Q?vZDtvaP7AYSzOacjG8bY6SWiSS20/xKaCnSgihDrsabfwA06Qx9Ctg+6fs?=
 =?iso-8859-1?Q?2HFvC2acLLEy9Iaws3W5EBSE4S4aNheNwE27LOkQvn8QDSISpSRWYqiPNP?=
 =?iso-8859-1?Q?+gFpucQ9Eeb2x30f3Bj80cemVw4AgVeWuO5+Gx8DgnCkoiQZNxAaGzwcVK?=
 =?iso-8859-1?Q?PlYp5d42Wl5O/kR2/O5SzXMi+FVk28CeboROwoTLhVrl8m5RyAPSGdLFGR?=
 =?iso-8859-1?Q?N/JKgw/5g4TN6VBZFWSSXrnFr7zyakXSIs1WlrsvQ/37dAzXhrqMd2S4Nu?=
 =?iso-8859-1?Q?kHU+INVH80QDbSOhwdHBSIYpQPc9JBTj4hApClfHStZHHhhPAW4Bs4TA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +/Yk90iMIPqAYKwZCH6m7PaVxzeJRXEazq1iN1/cnwy4t+SDrB8BeOuS08q1PFJ44hIEl5maolm+Cmc61GYDS6QfCET1xlVjunJdQo6Pesss17uCGKC9zgUR6TGUsXwpMCTXIFQVlV+DrAQoMt0RbY3OZs+609FRyXUJcKGtAQj3jvp775xl4zNPxgScdfZ72Jq3htPUOVIaQtfIXqQXs9ZkeExhRUp/vyjG4b6dzxxgjuKpIwnQpqu76/xfInoZfd4VyFfNwKerCUnfE0bVi3c4Yszy5U8tFLuwVYWEL9fk4Q7JAuR5CWqRMfpsLbgsvpx7bY1JlHMdqjYWiZeiHuSTDjPZ/rrByRGjN2wsgPvnTBR3YtcjlWo8Ibyou01CBvbtKzGlTMwiH1MMBFHvRJvzULPs1LTjK4NJrk6Txz1S52Oe8a2HhxRMwt+eEmFLS9d4/F6BAEQLXMOyVRjuclVWXzpFXCDCw2wE8jCR9HRmP2fwOJDOGimPW5+2Xqw1pUWY/Qn6zB+BPy6FaMl9/UHJF2BO1Ka7lZvJph4rJkeqV35I3BR4JU6JPRYBgi70XbCoeJsdaH1tuaM1mhjBLhlKBOc+U0XNCVnLFbaq4LVqKASxBW5GDyaPd+6q2E/AGexTrPxM4QZYl3JkY1qNWGKCTdrFemjVe4clSv9cmJCX+AHswnCVGYDgQ8uI5j7ByocTbPVsZTccmOXdBSCt4HxWvOtgF2uhlme3ZKLj2hl8KETXbu8GjDouqqAMGlqP52DwMmT/86Q5+3kXEKVj4OU+BSE0VvZ4ACnS/vsM89Umy12GiB46uAN60KS3IzRz1st8Q4NI54WShYB84UO9nTfw61uzVm5nh0zHblumySY8Do1SdGCX4f0TcBLohoi7tkPqxfVjxKHJUWP2ESsbXQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81fd741-1559-4f0b-14a4-08dad228fb3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:26.9884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4gwJkyMRyt4Nyrs4r/j2weEKx3xWZlARv32Z8swXSNqVx037+jR0rq54XoZCKUmapeFF14BGnrlRwZ0rawemZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: sX_l3AvoDQGt89o4MDAYimroHTiCh36M
X-Proofpoint-ORIG-GUID: sX_l3AvoDQGt89o4MDAYimroHTiCh36M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c          |  5 ++++-
 include/linux/mm.h |  6 +++---
 mm/mprotect.c      | 47 ++++++++++++++++++++++------------------------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a0b1f0337a62..de9eaf5926bc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -757,6 +757,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	unsigned long stack_expand;
 	unsigned long rlim_stack;
 	struct mmu_gather tlb;
+	struct vma_iterator vmi;
=20
 #ifdef CONFIG_STACK_GROWSUP
 	/* Limit stack size */
@@ -811,8 +812,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	vm_flags |=3D mm->def_flags;
 	vm_flags |=3D VM_STACK_INCOMPLETE_SETUP;
=20
+	vma_iter_init(&vmi, mm, vma->vm_start);
+
 	tlb_gather_mmu(&tlb, mm);
-	ret =3D mprotect_fixup(&tlb, vma, &prev, vma->vm_start, vma->vm_end,
+	ret =3D mprotect_fixup(&vmi, &tlb, vma, &prev, vma->vm_start, vma->vm_end=
,
 			vm_flags);
 	tlb_finish_mmu(&tlb);
=20
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b9a6599f98b9..17623a774e02 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2046,9 +2046,9 @@ extern unsigned long change_protection(struct mmu_gat=
her *tlb,
 			      struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
 			      unsigned long cp_flags);
-extern int mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *v=
ma,
-			  struct vm_area_struct **pprev, unsigned long start,
-			  unsigned long end, unsigned long newflags);
+extern int mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb=
,
+	  struct vm_area_struct *vma, struct vm_area_struct **pprev,
+	  unsigned long start, unsigned long end, unsigned long newflags);
=20
 /*
  * doesn't attempt to fault and will return short.
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 668bfaa6ed2a..994e8d991e78 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -545,9 +545,9 @@ static const struct mm_walk_ops prot_none_walk_ops =3D =
{
 };
=20
 int
-mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
-	       struct vm_area_struct **pprev, unsigned long start,
-	       unsigned long end, unsigned long newflags)
+mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
+	       struct vm_area_struct *vma, struct vm_area_struct **pprev,
+	       unsigned long start, unsigned long end, unsigned long newflags)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	unsigned long oldflags =3D vma->vm_flags;
@@ -602,7 +602,7 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_s=
truct *vma,
 	 * First try to merge with previous and/or next vma.
 	 */
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*pprev =3D vma_merge(mm, *pprev, start, end, newflags,
+	*pprev =3D vmi_vma_merge(vmi, mm, *pprev, start, end, newflags,
 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*pprev) {
@@ -614,13 +614,13 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area=
_struct *vma,
 	*pprev =3D vma;
=20
 	if (start !=3D vma->vm_start) {
-		error =3D split_vma(mm, vma, start, 1);
+		error =3D vmi_split_vma(vmi, mm, vma, start, 1);
 		if (error)
 			goto fail;
 	}
=20
 	if (end !=3D vma->vm_end) {
-		error =3D split_vma(mm, vma, end, 0);
+		error =3D vmi_split_vma(vmi, mm, vma, end, 0);
 		if (error)
 			goto fail;
 	}
@@ -678,7 +678,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
 	struct mmu_gather tlb;
-	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
=20
 	start =3D untagged_addr(start);
=20
@@ -710,8 +710,8 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	mas_set(&mas, start);
-	vma =3D mas_find(&mas, ULONG_MAX);
+	vma_iter_init(&vmi, current->mm, start);
+	vma =3D vma_find(&vmi, end);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
@@ -734,18 +734,22 @@ static int do_mprotect_pkey(unsigned long start, size=
_t len,
 		}
 	}
=20
+	prev =3D vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev =3D vma;
-	else
-		prev =3D mas_prev(&mas, 0);
=20
 	tlb_gather_mmu(&tlb, current->mm);
-	for (nstart =3D start ; ; ) {
+	nstart =3D start;
+	tmp =3D vma->vm_start;
+	for_each_vma_range(vmi, vma, end) {
 		unsigned long mask_off_old_flags;
 		unsigned long newflags;
 		int new_vma_pkey;
=20
-		/* Here we know that vma->vm_start <=3D nstart < vma->vm_end. */
+		if (vma->vm_start !=3D tmp) {
+			error =3D -ENOMEM;
+			break;
+		}
=20
 		/* Does the application expect PROT_READ to imply PROT_EXEC */
 		if (rier && (vma->vm_flags & VM_MAYEXEC))
@@ -789,25 +793,18 @@ static int do_mprotect_pkey(unsigned long start, size=
_t len,
 				break;
 		}
=20
-		error =3D mprotect_fixup(&tlb, vma, &prev, nstart, tmp, newflags);
+		error =3D mprotect_fixup(&vmi, &tlb, vma, &prev, nstart, tmp, newflags);
 		if (error)
 			break;
=20
 		nstart =3D tmp;
-
-		if (nstart < prev->vm_end)
-			nstart =3D prev->vm_end;
-		if (nstart >=3D end)
-			break;
-
-		vma =3D find_vma(current->mm, prev->vm_end);
-		if (!vma || vma->vm_start !=3D nstart) {
-			error =3D -ENOMEM;
-			break;
-		}
 		prot =3D reqprot;
 	}
 	tlb_finish_mmu(&tlb);
+
+	if (vma_iter_end(&vmi) < end)
+		error =3D -ENOMEM;
+
 out:
 	mmap_write_unlock(current->mm);
 	return error;
--=20
2.35.1
