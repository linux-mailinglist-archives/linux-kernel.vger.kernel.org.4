Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223D766D45E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbjAQCfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjAQCex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482522A151
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:28 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H093RR023164;
        Tue, 17 Jan 2023 02:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ESC+ic5zu15oUoyA7Izjug28LKeRWDR398Wz95pKC34=;
 b=m8hpLXupYzcWgdWAJNWjijvAPEUJySyoeQGJru94aJK7EjffHXcttZ4HJ3fY7LiDeBd/
 coxGt1sYR8x84bmeu8T6aznyJiiQnKvCLF6nzY2zmaoELxePRJMWiPlAAgCrEl4BlbpK
 iNawBQGvp070291ku3j2B1Alrqa7+mp6Yk2GgPZdmksK8zgOyoEHt4vtzxKrRMHZvjoz
 CXBpYDIphGgvlNcVamoZtZfndbW/tzmp2OFsKMGq+M56OV6D6lCywrzXQCIGHe5tO/lc
 IikdYHPfVxK5Y32rN+3QFdRI5AHZnlPwnjOyFeY1IQY+F9+z/Jc0s1V3AXL0RV+FkPy7 eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jtukq27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNUM0Y004833;
        Tue, 17 Jan 2023 02:34:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10f0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgWi9NFnNg/FPvH3WzKeHAy2xjSrtjEj59rs2EVHk9jfROrac0eK7IkS4lAXbT/fhPuMFti02nZMiRH0dJbPsZs/dQyvQ3Y+64Qzl16NyjPsjg+eiRYCer88AC45ugOE5SRdVmSAFGhMKs9UyDa+Z0ByCHKuIOcG/XSjKMCxvOdBxV2J4/szXjcjSvDNqp64mzw352ra1QE0sWKT0jYdwCssKAwg6SHeslbZ2qPYetxxlXakbzTJiZ0hbMMNhqFAbIK03IWfn3CufR/tWFVEE+G41TxTZiV8cIzO0q+IH4oC9qyMqEh1XwPJ3VkY9+LX5kL4hYbtW27tLSP3ONveWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESC+ic5zu15oUoyA7Izjug28LKeRWDR398Wz95pKC34=;
 b=VVi1C89igG0kspiwI6090OqvOVpetbz95yJUMNGtGsM3FE2AJJYHu175ofRwB/85fuLlH3ejeVFeJKc1p4efWt43ZHe5i0FjyDQJNtyhER7E0GofpP0UDlHA+e1fFnGueZFozp7J+JMmVj8Dd95u64mokpCNHjS/FY8jE8Lr3QT8407ssg5z4oaxSrgXfrdeNBgrKJVoNtU6ZTJHfD18tiRXU4X5k/IR0/kp2RCbPtfBCwuCwrRnj3r4Y8tC8Pqf6bmkc+qM855LxDnGzOpONoNySBSSkDJ+g9sAc+jb9bX6+INa14V2l3R56cKVUX3xGXBSXDgZ/cFyuNjreEnX1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESC+ic5zu15oUoyA7Izjug28LKeRWDR398Wz95pKC34=;
 b=XMTDf5PaPpq5BI1DMI+HT/pYExFqCElLub/IdLag8ee0mmGSrubRdyNPhMZ3rtXmZbfb/+RBAxSC+RWKlwhQtGdV8Ykoo8Nj20Ll9RfFBsEx8DlDPEwE2GWNW2RGUpFL1wLn2l1r/VWvR5Ns3AUQTgYjyL6D59RkNsZGHdVy37E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 24/48] mmap: Pass through vmi iterator to __split_vma()
Thread-Topic: [PATCH v3 24/48] mmap: Pass through vmi iterator to
 __split_vma()
Thread-Index: AQHZKhwybTMHeSzSyUCS1hIePXgbmw==
Date:   Tue, 17 Jan 2023 02:34:17 +0000
Message-ID: <20230117023335.1690727-25-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: 886b1650-7390-4c30-1471-08daf8335702
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0+aqTbjMDhThziBaqbzY4TnLhdHmtUaMAfqXitNvALtAwGVWYYhKGquNGPzJQ1JoCJbyBDqfLkxzm0JiCT06YxyRe9+j8hz3wGsfaVCT4g18Tvo12e6qekm+CO8eKdJXQi4xMNb39ljs6nDKCXv5UpYwLLbbUYk6dUtb8hr88WSHIvXbHgPhYBZNnBvYL2HpW1j2UdGwTjEuumyl+iQcRdku12z92SrTcwXZrmv0zg4pFXkcP3gJ95Z8a+54QvYSULNr1rDFxugcZ/Hr+a4zuFhZIiFcRtLLB9oNnAAAUuwra9DY3Gu2kER0ZP6/RSZuC6H4hW7K9SC0ZbbiTKwm61bfrHjtvsy538VP0nsdnsnLDCxeDpfqq0Lfk84jfOStEWJYuE/qPex/yA+wlAP1J+0w6BZQv6d0EABZN1momTNIS7wQUgnyHe7P6/Cbhvj2OAmnMq/+fbhlG8t8SrWhNwEHZZnUbaHRQQfEQ2OosD5HP/24ALN+rpHzRBQWMbWGfas9+x4HYfqcjEqQtrZPCjKkfACJbT0toam/EySuWBFFaaPtf2L7o82yS7YWLfSId3NgmFmBxMMx9SiwxerpHVBRuL+DLegV0flFxztv5RFC23hgL8N9kryqbdlAqdkz7zALOxVUi0zJj+urrptQpPQzbgPtehX26LKZX7zOPz1vrFSeHOmmHLvGzpujoYjfGfH2V2obGFB1Zk0DTFNPZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(4744005)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NPOlv6x0IazOULdeV5NzRROLwow67WVY8Uyi48k0oy/0G6UgrwTBlN2Cv6?=
 =?iso-8859-1?Q?yH9+/G6ItqFTW0iJaliZGyZvtUOEV7pHtD2ztge/++NPT1AQ5JEEjgDoec?=
 =?iso-8859-1?Q?FGsKK2ddknLlg0B6FNwnrkGy2KJmtVp/R9x0zUiX62J8n7xSfs+BMxItTA?=
 =?iso-8859-1?Q?D87pwbmljSLTumFg4dteKH+jwZL69yt0KagkcsRtPEMyweXSkhWsnH39D8?=
 =?iso-8859-1?Q?rRGD9Ui/JHVvfW2j4GO275BT3iu5nE35FA9bbjcmt8NiFEgZ6sggO6XA1O?=
 =?iso-8859-1?Q?cmkJozaTZf7+GuuckjuQROsxjbdTmgatSKSBtKFiBEHI8/V5W9ovlaKUBa?=
 =?iso-8859-1?Q?qWIl5cy7FeGXFg/RXVybI6IMGmS1e4BOBwuluFPN0D8itG8PMIedQsKXr5?=
 =?iso-8859-1?Q?lXHK3b2LO5GwpZp4fU3al5uAMlVkqnm8Ds7au7K693r9pr3vwP5Qq7CRCR?=
 =?iso-8859-1?Q?hOVNQ0Z9F0eTQwJ6cwFhHL8SunKSiburwrLF0p+/XyN105jotqRU04DeOQ?=
 =?iso-8859-1?Q?QATkgtlXZf3EVSepjRCwhC6ioWmddhtBS30FHnzBfvv8995HA4SRfu9ysu?=
 =?iso-8859-1?Q?gK4VTZSt5sUl87M8zT8Zimmj9qoPLmX0YM1nIG/LqikpGD0SQ8/kQ85jXd?=
 =?iso-8859-1?Q?D+0iMHvu7guK+8LUoS4zQwvBWX5SEq4yoLY5fEUG0lqM6EeEh33+OJMnIZ?=
 =?iso-8859-1?Q?Or63c50pZxmOFAvpj5U8zYB7D/fR738OF7EgrtwbtGH0EJRst3hLYamTzM?=
 =?iso-8859-1?Q?KMn6h1p2sAJsmdu5bBZtWNrN7GsZzjqNi3Cbvgi9/PUzx6A5p0IYZf1hKb?=
 =?iso-8859-1?Q?0wn3zHNHpn6Pxv96o3me8u4OiVciIlczvYkpQDrei3K0iEohAWvyEqQHaV?=
 =?iso-8859-1?Q?3c+64LclmRcyA92rQOs8eMM3A0E44NL9ipyrIiNzpxMlhfq0CPklndDOCH?=
 =?iso-8859-1?Q?Gn9DrB5jYIjBn9WRW4j7FCrSQAsUdN9JwXz2AN7rUFS/slRHDDPkRuIB/T?=
 =?iso-8859-1?Q?+UYahYl0wEHfPD7ezdXhKYGTBOPFT/869mUjdWM7bMLEAKH3G7hp02hQvD?=
 =?iso-8859-1?Q?gma5817ofy56/k6HgMLZPIPb8YbgyKn/6+a0vcQtO/WPgd/ckP5XomH5l8?=
 =?iso-8859-1?Q?z50lTXSBxsOO4XB0zIhZ7+AgEC9SwDmPSPzDwImDcWZ0Z0gP7oyEIh/CVH?=
 =?iso-8859-1?Q?jLsocvUFnzHMi9UK6oenXN7ZUtiQ1KGgxM00dLnQOoKWGseM0xxf0H2ZgI?=
 =?iso-8859-1?Q?IvWz/b0FfbtufUvF5OH4z6VYVcAXEAtGtUd7t/EcZ6CbgrPNwpVtn6NjIM?=
 =?iso-8859-1?Q?JIu72OiwHtQ3KXh8Lfe1eDIoT8Zz1x0qQZ+sV6Ncm3kCU3nnZ/MnX/Kz4D?=
 =?iso-8859-1?Q?MsIiW++kZZy1x5HoRy0ESDU8BNxeWS6loqhB14fn5Vp24lgxfHJ46VeYdF?=
 =?iso-8859-1?Q?yKlmcEYJ4oaDNXg4JhKNjq/sfuTmoGLwrQVR+JDLgh9olXsQ2mUR3CCelH?=
 =?iso-8859-1?Q?tjpWijhkV3AlNATEPDcRL7EGibHt3cuEUVY6ok/4d8Y0o52+XLW6Pf1PWe?=
 =?iso-8859-1?Q?8Uo+qeizsAK7T2xBkfZ6JOe1RamAJvrlUkk0tUQq+9UpY2lsVlIg+fNrVQ?=
 =?iso-8859-1?Q?/n46a5tdIWF+APxGMjH12PLV2fC65uLbrP5ay/c78EgpMPzofGx6HcJA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BGDw3AGapHlU6t9lLU68ZdfeHCqtJ9lM7Wrb0w8X83YxEwYOM36ir8nMPEclQODpBvDTJh7IW7BkHOlIxdZyTO/G/jOdCBXsf3L/3qjpAdu3FY6pdm81KRa56C62ix4sJ4lwroXWSjhAj8EJSdsiS+gx5eTm0vIbeSvEHCinMFUDs0F54Wz0OiG4uZPp2poo3AYOfYHuadDfkvHDdFQHhyJCGS4RdU8IdHGn+iUiRFalOKAA9jH+Gm9o0XFOd5E/onlG/eOeO2oroGVT4BFw+eYQHIjIEuCw5/ZgxmsjI1XmacRGYO7LKlfXqYoZmltKlYO6q4LQ/OP70mbBz5k0HgtRWlpxBeeCWuPmcty4HL4oEGg9IY1EjmWoTHd0o+7ZSfpd3QfCZ9VUTaVsVD76atAK+wuDcNwyiSaEfuncp/m9p2e1uZvLxALSe2OJ1EF97BMMx+xP8wl0wxOT5qgO77UFWO4AaKuqsDyPQfSMK/Rd5hI5rOy4hOpMZVOdE31sdXoxZUyyyK30LkeAv4Ro9LTULHVCnhIUZZMDrvJZ2GwyLDAr42lMmKDkbQ6xueulftbzk+WYv4I+twDBVbtLGaC0Yw76ZTdqSDQcRDGoF8n49BRZ9Fb4s920EoGwH3G1fxzeMQwnMei5Umj59DlcAVw7gBYEx+gbj4hZnx2XnSbxQuWSXSs28oymgXgeReyc7txjqzK0URHsnwIykWnJDm+rR49QUAmsYQfbBjdYgHXyPSqCY+2BhS3PuBMdq9YCF53192m7lgzV3AAy7F1D/Ic+lHFkLQ/+ju1DJ2rXll4Jf8DgENzjgT7J/7gahCyfM+JCyDQhuvkE0nyQ/fvgd42sVQQM+rDgLj/tpgRqaNdK3p1Lupt6pYa9JoNolK7Nv5UGvTdJoSoBRZ6YGHhxCQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886b1650-7390-4c30-1471-08daf8335702
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:17.8123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOk0GGq+ag+p7N8TMC6a5V0rkWRkfgwz0IRj5l1GhsPnhRV+eisqkVTxIkRSn/f+WmjqpwCTOAqDM/wApiDIjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-GUID: pFvjUUNJvVFTFzupUwwQwFHvfiTbUp8J
X-Proofpoint-ORIG-GUID: pFvjUUNJvVFTFzupUwwQwFHvfiTbUp8J
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
 mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1fd6962f440a..530a58e88d66 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2387,7 +2387,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
 			goto map_count_exceeded;
=20
-		error =3D __split_vma(mm, vma, start, 0);
+		error =3D vmi__split_vma(vmi, mm, vma, start, 0);
 		if (error)
 			goto start_split_failed;
=20
@@ -2408,7 +2408,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		if (next->vm_end > end) {
 			struct vm_area_struct *split;
=20
-			error =3D __split_vma(mm, next, end, 1);
+			error =3D vmi__split_vma(vmi, mm, next, end, 1);
 			if (error)
 				goto end_split_failed;
=20
--=20
2.35.1
