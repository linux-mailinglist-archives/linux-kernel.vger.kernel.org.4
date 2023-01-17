Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFF966D47E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbjAQClm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbjAQCkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:40:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AC030EB6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:36:40 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H092Bj023154;
        Tue, 17 Jan 2023 02:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=W8WYftfghkyy9i+wCjEEsXwxkO+1L7ReQdE94cpveKU=;
 b=IDODokaQps9LvzWMauJpcQprYsO7mXoP15JVL2rRgtycI+1G4tKrHNWOT/Y+6CB1CfpR
 6nYSmra3GyiFkj3IUzV6ghg5SHiN/9dOdOXewdGMNuBRtCYxGOnlwHu113lzuzBWyPju
 Ol6kvB/Tmbgpz9n+K8Zg5YtV1RUqUid89DNL3ww+5Un78UUkqeYTWIQhfV8/lnw7CD3v
 bu3rG+R/TP96m62qh2jZsmyncwlpyEZZDU/Z0a2IlvyOobmLGQ1NJu7YZ2piwRdoA8tv
 b3LevG6oxDasrOPQ6cJLxJiJO1SGJVS4RlrIGgNQpLVlNMBVG1wgPvQ+C5rtuD3FGWxt 8g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jtukq2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMXP49028373;
        Tue, 17 Jan 2023 02:35:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfy4x-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBmWL7FoTNfPsyYOSw+HgDFnsWjMj6J4GXpWFfcq42kws1bnF0xJTGU9/r3Ff8LpK7j02lM7DWUETHnvtsrlkM8GfCr8+fF0gz0gG62Ee7EACXG4Sv0nxRyFm4D1XMJFfexqOZZDrY05wRGj/hd4nAYvPYPVd99Y2YJp4O45GBpe40PwknZKJDaCsgDxC5tJgg/AL74i8LObX6jlItOWqFXOrOEPG/P82P9u9emHvT3k7D7xbMDKoIGdNOwawHYxMcKMPqx3t9/xt8Yuq/y2+Xl9sfuD60u5AyDlOC6QjwLRfiy9x196U1KJTUsE9PJZ6EGEQjHBmZ1z+r9d7V+bTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8WYftfghkyy9i+wCjEEsXwxkO+1L7ReQdE94cpveKU=;
 b=Og+qZVAOlKpDG+QXBwAlHQ8A538w9RQYXxzVKIafDgAZmL3fd/jDDissYY17br5jKLIrs8or6+tPz1K1wmPCztRG8s77fQdVCEKFwDs/D5Q/b+l4p0KXsJDlb2U9e7BZDBzH6i1z/8310jJaNrwqlNckqB+IeND3FBT6GeOs3ecOvnI9To7w9BfcVnyeRVlT8+LuIOoEx+njBV7RC3WdnVqgCl63l9n9sV6ZuqjiprQdMWG1rniH6tXtzOG071vRVG/hHB8q5uHTlxLifcZH10kGFHDe+23kR2DBA2CLwHPBLNNpgRyDyLNCF+Z9ZvTgz68kRfE8GzJuDxJPGOtdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8WYftfghkyy9i+wCjEEsXwxkO+1L7ReQdE94cpveKU=;
 b=dbWsUCwYLPMfMcoiG75Bslb5iCrNwCBxy9nMQYQOFiJis5pJDM+DKbSHGc2s2ZGjOEfAJhoccKnzXRQsUbKyFv12pacajPhxJhT50ql1Jr546070vW8dclFXnZRsbeoXVWrVmflGiissKSEOo+j5zNud35hCpajMCE9Lf2oKcgI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:35:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:35:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 48/48] vma_merge: Set vma iterator to correct position.
Thread-Topic: [PATCH v3 48/48] vma_merge: Set vma iterator to correct
 position.
Thread-Index: AQHZKhw2HKF3fJU6YEaIPad0cYeJFA==
Date:   Tue, 17 Jan 2023 02:34:24 +0000
Message-ID: <20230117023335.1690727-49-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4814:EE_
x-ms-office365-filtering-correlation-id: 6d001483-ccf3-4af1-dd8b-08daf8337032
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8xUSL8n5YPf/Rl/mVVKiokZvGTszmluOZHnYf0UGwGrsjE7HBPdDwlYOFOcKszYTWr7frLDffaXpznwg83ufccJ7/I6eq17S9iA0eixzKa90wXVXDZ+sK7CWYv4ibq26wYjevi60BZ7C/uaFWhm5HKUDn3twIAvu9aKDnZ54X1LDHWNsek6FlcIdDDM0bQ0We1pbh/BTUMXcs/jopbM2QTM6Z3MoHuQrN7j/dqDXVc+1oPlFtkpVwfsM8r0H6HE9u2ehOKxv/FZaGKL+iWvym2KiSi9+PqFUFg+t+whxAUnvfnOZvMcd8dfAL+MpbFhZ+Xs+/2945kPjWUVqcOgBqlKx3ui3eGnG1pLSgtLmbDBLJcJW/scwqQGdSLtqhNhzf9+ZxsrenecSOPvkY5q/Zss6wcayGTIkLVxx8xSMm3GD5Way9LDxtUDGN7p6GCniTz1yAKiL5zQYOxXSyNciCg0sRcXuF7aRd4uWlJSKFaNpC871xvb3DjqpcFRnNBHCoIT5W54nPGXJgU244c26bOWc/+I4YCbXloc5mRIQB1WRuntkzyVgNu3Ugna7PTwFpCMRz3pB4eA8HvFSfUIkNvZ6qS2eyNxJBOinbJJrNyYFFGo8cZeVNtO3JZo26K5CnQemBmIhX0Sayl/eAo/OwU5/WCND77D1uPORtHT5thmoQsGFvzx3HU/XD925MoqMqlhIPOxEPjW/hMT5ooNDzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(6486002)(6512007)(478600001)(186003)(26005)(6666004)(107886003)(71200400001)(6506007)(91956017)(66556008)(66946007)(2616005)(76116006)(66476007)(122000001)(110136005)(316002)(64756008)(8676002)(4326008)(54906003)(66446008)(36756003)(83380400001)(8936002)(41300700001)(1076003)(44832011)(2906002)(4744005)(38070700005)(38100700002)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pOrO/Glwke+5dHMNlS2HTujubOGnzke9DZP5AX2/OJ67eIxQvPkTT+/r73?=
 =?iso-8859-1?Q?SkV5SwCPTgGporsAkb1iQlneWVO0ED7OCA+KpmrrIABW4hu2bicYLczilS?=
 =?iso-8859-1?Q?ie1weCyDKWKU3XG+VHKf/y4Mb/jGuHnqVMUiryQMJ1ytRF7UhI2Y/lrl7I?=
 =?iso-8859-1?Q?f/aH+qLshpmpBnX/9WZgAaYIKRRXwF+YNKk9nCD/d4xeK7a9s1BX2FP1ks?=
 =?iso-8859-1?Q?iSXGajKJac2Cb7/9c9gdXcCpgZJMBUmpS1LFm0rmJrvbD+LCWxTNbmLaYC?=
 =?iso-8859-1?Q?ot+3kltISJXvmRYmedInp1EQcIHt0bjqAn1VoJwNQT5xOJ9JfMyQnZgAZH?=
 =?iso-8859-1?Q?f00YAQOduns7uTJFQdxQX8q2fvuGFMGpGSEd9ULV10H0IUfkIZqfuuz8Mn?=
 =?iso-8859-1?Q?2iaTG0vS2Uqe7pz0XWGY+/SU8SDLTQK2IyaRUlQt6H0D57SGr+izLHzIdb?=
 =?iso-8859-1?Q?Eba/oNmPc4SBUtTcmEeGagrGxYcEp8uEioyOVSLXmq7YxKApoYKPAN3YKa?=
 =?iso-8859-1?Q?g3D3XwdkY8tLim6wH+I35kiBMujIUcFqdZqvKjVhAYRFDIGtKjHRwU8IBQ?=
 =?iso-8859-1?Q?gZFq0NDl8Wu+dDMJDHW5GJrwzzxTLNy6jUv/acO16qWx1CeRHeDD9m2t4f?=
 =?iso-8859-1?Q?b7hLUxv/6KFoEPNxL4P8Wu+cDYdAOhBejx7h+bPXwqG7JIIRNC5d7oxmzl?=
 =?iso-8859-1?Q?iGqhbt+eRUKzwb3M16JptvZ1Ze2l4jhkhiumQqli9oTw4YgrX+9cVRpe5A?=
 =?iso-8859-1?Q?tYbov1BvPijeol4/cqtWSYAFVZeAwLWPQZgdLWBKMD9k0ImHqdvpKUina0?=
 =?iso-8859-1?Q?rqr2/yn2zIxJkax7jEfe/rKuMCwb4/CeQWpykeg7l02UfCAIhp2K0SCVLs?=
 =?iso-8859-1?Q?9ygvJfiY+crfak79LqJzqoI7RvCpQFJSZpANg4uIKY9PBviqR0LvDlRWr8?=
 =?iso-8859-1?Q?Y7bXLb4KpOB9HLalysWKA2leYrcbNHV9iT60QJam3yBylJs4GEFOFLO1hu?=
 =?iso-8859-1?Q?XY/lwGshHzAIJURcbsLaFB1FG+DEq6I9XYq53jgI7s/W2hjizN3aqoeBS1?=
 =?iso-8859-1?Q?30fz+nq1Gm4LrivucSSVMtzvqqlUE78IABZSxeD4jsSktUVoqFjpmtcIYj?=
 =?iso-8859-1?Q?VFmf98XzhHY8EbGoNzRTVSLoPSzicKsO5++tsALNC9JfBR8vbW/HeAi9Ax?=
 =?iso-8859-1?Q?uA+97+kyVVXF5UFPOJx3kMnzd/nUYrSxud2L2m449r2zzhBE2H7R6uvj7C?=
 =?iso-8859-1?Q?n6wXvnF3i1+TyCz9KU2ipzd2bCuiStNY/wuOWxZHNImt45rVqXPe8UTiWm?=
 =?iso-8859-1?Q?gmNMnjvXa8SC2TXzBsqlqmYph+aFX7blbNQUXztTDa9wzCFoxIp1AfaTSc?=
 =?iso-8859-1?Q?rhimtmj2y8diktoPwmqkZ8MUIuXpBwQ+rPJhIuBtIYErWxN9+XAEJBzQXk?=
 =?iso-8859-1?Q?dwUmB6Ny4hfNonsVrq/nUQuWdNYmWxWcZG5FIHNBTaOnx7kpuSxrFzN9qu?=
 =?iso-8859-1?Q?zIhTmedqGyLPldDZcCin7nwYBsS/5Kpv1rR6qdk9mSJ2XgQZfvkGyifxzV?=
 =?iso-8859-1?Q?AgZFej7mV3obScLjpKczQfY6LVccAVftnM3tq3+VVwwGFNPSFnjkWfh8xW?=
 =?iso-8859-1?Q?qm9ROBmzgzmrM+kugYIXwWFhuTycLJT3VYbUFYn8AoHpr+cEs7rxS5mQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MEWsoDxhQx8Ms8d/C6n8FrdpSdKmVdTs2UeikX5QMGhk8j9+ZhDlp6l/cPKUC2DQ8GrPlJj/0KpsbrrBgjX8XGAP6+2a4OAQABLLgeobtKQA5B7yIWn+HSTAXh8yXIqtBGB4uXt5bDRXHxfB0EFK+58ayCCa1Mj+3Hz6QqgKehHRkz4P5tPcNxJSqk5zpX3EbYRIkIxJuJwSNIkuBzBffuctKi7uD4HW99M7YqkhsF8ow2Thc2X4ui8sRSTt8mA0UwD0RYhEgGVN2rs1KWqFL4tT7ssg70RLUfR3WXTnVV8cP1nqBVCtAup7A/b2hDjLR6JWvjD8+iWIKYL27guvMfnXw5EjZnsqUe4W+yc/jx/VKSjGy18kFkIZC5OFSXdiLSFYMalLZSWMWJkMiQDUNyd1TbDqPgZU4EnmTe79B4mzm3MCXgADH5pF5iryCYHzKCVMTdwFWlXkiDd/iu1RG4pst2ROrBauWsliTh3e60G5JC5VB5O/0syXhehU/FNHBlF4HdOiRUl+JOBb60QweSBi+icZ21JJdJpZhhCKfNWA1yXFGsbA5xvrc/aZlYVsTn7dtCXgbUOcs1r/YbpWubt1jq7+VS28I75PuNleHz4T2/ZJc6Ps1qClgpRyBni6lCzbzBKQ67v0CrXrjgwGJfL2keQM7npoN9Ye7dTU80Ux8cHYal7DNwQn4gBdFfDoB+oHcz8ilpbU1fbD27fahqU7tBRBmHW1LnmbG0UjUb3aomuQGz9VDb7VwBGYmNEWxWeIAIHMQfMS25QVtPlk938+u45qj6/JQ+8fEkrLZIhS9cFNUIbWjZQmeWSkRqnDZdfkBJ60eMt8g+IiCUmqe8QrCYC7AbO3Y73s34WUmV9IHK4pYb2lWzV9I9fVnxlySgigZ1atFYxsyxnov9M52A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d001483-ccf3-4af1-dd8b-08daf8337032
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:24.7181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Jtoh8g4OvL7SovK2lvgc8aBC+2S4htxQGYp22oz0kVl14QdUiIPGS81RN8ucdjKCvOsBoIzahiY4x9gt1ZvRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: ap6mpDMoLW9sD9AXM-lLBoC8BKQxZ0K8
X-Proofpoint-ORIG-GUID: ap6mpDMoLW9sD9AXM-lLBoC8BKQxZ0K8
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

When merging the previous value, set the vma iterator to the previous
slot.  Don't use the vma iterator to get the next/prev so that it is in
the correct position for a write.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bf24c46c3c3f..89109a43f35a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -935,6 +935,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *v=
mi, struct mm_struct *mm,
 		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
 				   pgoff, vm_userfaultfd_ctx, anon_name)) {
 			merge_prev =3D true;
+			vma_prev(vmi);
 		}
 	}
 	/* Can we merge the successor? */
@@ -1026,9 +1027,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator =
*vmi, struct mm_struct *mm,
 	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
=20
-	if (res)
-		vma_iter_set(vmi, end);
-
 	return res;
 }
=20
--=20
2.35.1
