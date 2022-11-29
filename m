Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA82863C583
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiK2Qqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbiK2QpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:45:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D5C62EA9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:46 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGP14n031318;
        Tue, 29 Nov 2022 16:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NRieCVJGLiJr8Cxv3p04LvXsdygC2aLULrDvNR7t6dY=;
 b=izbdvQhb/BJyzXX5IWlyl4bJ9YMAsrJuDjxyyYEHjy4KbcclEN3VJ1ePtLquBRTkc6YB
 TeI/NUetZYSQwJU4R1XsNQqTfjiyxeaFoNlHJAh4/RLvm0T9xYKryDrO5DA2EU5kJ+Ir
 dz1hRP1qMXekO9DonVbWrHqhxpKVKyAsMOv3z15zOI/pGydu7xAN0EkWGgZyC3BSMD/6
 YHjpyxmIZQ1MGE2E2wP2zstecuQUOXJPrQC69Dc8g+bjJ4JeAZ22XeMiGVgvdbI6FsO1
 NYKCwCcxEOv+WwKhEzUOjNkbUvHkHhs7Bq6cAjbjkmNgArvnnVMmr/ewVXv4VA46Y4up 4A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3xat2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATGbKZS019412;
        Tue, 29 Nov 2022 16:44:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398dr60s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqHFUPuuPVVWVznN0KLBfLtsv51sOQAzsUZsVkLzXWAtQvszckBdyxrTiN/iaAxYxmLf5E+KIE36o2uiJ/xkZ0+S9cjc59eYbCXalTYhBq3hha7wiUtSixUztduMQsbeQn9VKlNtT53OU1P0Z2WFWmdzL8TgNm97wm8f1eKW9SnNOSx4d07Gf0snPdVBkgncJsjARY9HfJN1XgxdtutUqg8Dut7AobLRRRQAvIjaX6Q4xZ4+RKtR8k+HOY3kqmA/lGWwl/HP2PWooiygtfqll02EqzfGRWdbs9bn25Pte4AfHb6wmtMdfrAKBDRE4+BA6zEpLCWiC6s8tq1NIM8obA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRieCVJGLiJr8Cxv3p04LvXsdygC2aLULrDvNR7t6dY=;
 b=LyI2Jt9QcUoQRaQaL8Avp4Jd4a+HeqnZ/ppD/1I7z5E8owYbaebfvpPhwTQSsmK3QMsiDBWis5llMqkHgt4DI7Ai5keetbZnTvLKAjEzKuxVoQ+sJgiODJGoSEzLgqSZtsL6KY81WM05i+SbE0vc6rLAOyhxytHGpRT4gWKTM1jF+NS8OAnek89ZecYy0eCbXcCeD/39bjPGMML+NhXRPLFB787aoWVGNVUlHkO8LqllkOKwgSrw4I30vAUOgnKS+aMW+vxgyG0f0KenVChH6ololEkoqYVcI+CYx4tBz00Du5/gixdHuFExs8Zs4W6kO9doY4qNRQ7leErfQed3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRieCVJGLiJr8Cxv3p04LvXsdygC2aLULrDvNR7t6dY=;
 b=oJ6uDbaspD2alI88uNMNjdBH3bmHwthzZFaocPzXCS+pQBCEqSq36Vw1JASSAKz5tdUrVPJncKPckyRVTgQvRlDkzpVvJU+Xom8BIK5s2TPeBpzbEs5eLlZCpocAgrEHBRefK/u4OIEWgwhHOsP2awd4LBH8AV8IxVykUKgDlJk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 27/43] mm: Pass through vma iterator to __vma_adjust()
Thread-Topic: [PATCH 27/43] mm: Pass through vma iterator to __vma_adjust()
Thread-Index: AQHZBBHb715FSo7juE2ZW4C4HlLCLQ==
Date:   Tue, 29 Nov 2022 16:44:32 +0000
Message-ID: <20221129164352.3374638-28-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: 82ea0d23-f84d-4a59-4a70-08dad228ff2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9lVVEqhLGquMlw0LAmnIBpMODRwDT58HD7kQAXYS8Jb3z5jB6k+CslxHxansbYfkRzdl7UFFsMcWVI0UkM3hzOD0Aq2nfvyyBVFc0pAOOXtHRPpus2RYoe5ACurEM7VwoRyxo7CWwppBwXHAf01yPkharZTHzQvOd5Lx/pfVawNRMpDTtooyEU25QyDB3S6Byj3/1Wnf/Bb+I3DmF93OZ1ywVFEYVvNCoOcm1pzn/1KFpcOl1xUf3z6Se8Ts0kYoICp3S+I/pxXwkpytPhM/U1+f1G1WHbyvqcXFLyIB9HpMB8khox/214yqA2Zb0RK8QfGao8bT24NeHtH/Y4Zb2hFQTfo++k3RbTtOADfwOW4i/YSLOOJ1yCWglPCdmzb88PWnXV4LKt4FgP8a09vOZXslgTjlG7Lr1dtt5NGAuI3HjDkHoq1C4LCWyO3nPX0UZYEqXfSHT3qIc46E/ByCKSgcKdIH2apRwr/ZAFIIGApLKvNLMCfOvM9EfOkfP9hfBKpCHq0gcbnkRe7i3TD7/rp0Temd4asS1BXIvh+mZNjlztNy4f5Plc9D18xlC33R8SDcVtQxjvtYYNbXO2eYvZ+AUOvGADa9RyOyA9eIMSVindx18QoATNxFacN91fm9xZWDM4YFftbCWTz3/TyEoLX4i0guzJORMdev+1fqrBOUBUMzifJhFK3NBuiH8gtR3HXfkRquAMGb1Xjeh2BsoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HFTEWYBqRDOHD7s4tRDkVtnrZ9xvwfevNaS73PA66Q2WG+TwUNeXImIvqZ?=
 =?iso-8859-1?Q?HhYE7U1cHT62A1ZUNL6Epv8W4QPla12zJCcw5hXGDfhFsHSX5zIZC6VeGP?=
 =?iso-8859-1?Q?C7vnTnkztNN68sXamOn5/24epcsTuXuwCXKUohrvlCcOaVpIjv1hZpNCYS?=
 =?iso-8859-1?Q?TlDJCYYFTyCd2ZMRToD1vF8zs3oOHrfCcS9Od+V3ev7FR99FNJhsLDYAY6?=
 =?iso-8859-1?Q?no0x0IF2skaUgLGm02DizNPDnrD34JKmgNKdf9mLQbKxboNmWp4JySACbw?=
 =?iso-8859-1?Q?RKTvMaczyoZZdowKPFCm9sqWKmyy41jt5uobMngGCOULG6CVv7ulw2aAv9?=
 =?iso-8859-1?Q?yvcr5Nrm3b1JL0w1mflywjORkXoELps1FvRerk93l5mam4EbbUhpVXYeBV?=
 =?iso-8859-1?Q?tMGdSs+aL4knC836d14eMKbsdaC3rMH/WFEJOx18UsvCD4xWJ1ENrYBOab?=
 =?iso-8859-1?Q?oSfT3PCHVJ1QWMJeKkZIOibJBSpAmWGJgJqJnY4U/gMAlYRtIlRAHi/9mN?=
 =?iso-8859-1?Q?OwiJ9K9toedZGwmfm8PHO7+G+JfRkVkmhvz0gHNnuX/mDYYY29zRNLl+8Q?=
 =?iso-8859-1?Q?Zpo+fbkBNfiYZTLpNthOeiTGUQPrLB7hS8n191RK7Q9c+U5AhpjeUezaG/?=
 =?iso-8859-1?Q?g2Ij64lPjKtn2cvFM1Y+L6hhY0GzrkRva9D5d3YjnwPWs6FsWxtF7yl8EN?=
 =?iso-8859-1?Q?AeFzuQ4VRPL0z15Q558SQ5XPa7sm9xHq9qwO19r3rgHLTStt1TL7F9vn+v?=
 =?iso-8859-1?Q?RZXSY0Z1L3D3BK4ZnYfkZ6K/M8tbbH7FvXgn0qGKqiW77L8R11cJ3MZdZg?=
 =?iso-8859-1?Q?2Y76Ui64JMEbXJ9koF+sgMZyRvTWMZn4029DsAEjRhD7MUWEhwPMKQboBJ?=
 =?iso-8859-1?Q?F8iwE6BUtgqNJQ9yc6p27aKQl9nvNWTNCEY0xHuOwOC9yChrIYx7B+IjZ1?=
 =?iso-8859-1?Q?vBERD61oXoYkUcWxVinUOCFALq0LuZC3ine4f77rbiEwfilzSj+Y2X3PKS?=
 =?iso-8859-1?Q?acvIRby0Ax9yUMkjZZb+rwUb/BoFfVb9AUMexd3MNrWxhWk2sV2scYP94b?=
 =?iso-8859-1?Q?tmG8PxIrpLqIxrH/Sln3JJHQYOW5y/PMdZoicQ5MQsmz9ry3s7O88E+bmo?=
 =?iso-8859-1?Q?3JJ/eSd446HW/I9Yzz9IGgno9x1rg2KGLuk3yQXkaHr9mpBGqKoYkI52TT?=
 =?iso-8859-1?Q?yQh/jkJhj+Y6Tvc57AUGRyUHUj9QarOFBhO4xBAPGIQGSmvsWzsHH6pAf9?=
 =?iso-8859-1?Q?Ri4hndVJxNbwEvgmThOamHhlFmjQbf0Dk1p7OuB94a8WVgM4Lk7NRcfpuD?=
 =?iso-8859-1?Q?FbRwinWhs4lkAWrykYpYh4pOZCRHsLVjP+XcjiXp1CqomfcjBjq29jZPuz?=
 =?iso-8859-1?Q?YtwOgXF/NKVcuz/aEUdROwz2r9RfERl/LplvvICbE0k+ucPSAaiqZ7R9Jz?=
 =?iso-8859-1?Q?aIFdc+0svueHV2L0w+zSK25GrJZwC4r5rJtmZ9J0y2eJdPsURRNgc9BgMm?=
 =?iso-8859-1?Q?u3NdSvMo5IFe3s2hvT/WzFekXiFaZWPhkfVFffOEtvUvL/aW4mXiJpnpEL?=
 =?iso-8859-1?Q?ltsjEYTt1xMJgcUsNrdi0/aFPGtmb0PM7P5u5QGVM1JdqmEXnj1hy72n+b?=
 =?iso-8859-1?Q?MleNyGvp5MgR2QePjRDmW50BzrEvdzSNXlra3+XUJVefMItC3UQ0M4CA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5ABPVsaa1vAYaIbhf+n2EQdVx4N8Xzvmstx5pp34RCJgj226boVRmHumo0aESZKHs74Wpmin8UCUDKBk1fFr67yCeHWhJOpjHFCVL4SSA1Xw8/Yc+NHSNBQd3mwyi0pEsAPWOGZl7JYxI4mnHP/whtiwGnrdD8S5QBhEMiM5tvFyyXtyf0xYlB9pIvABBoQjTteBu3nFnTe0s9IPuAgANw95GUzjmcqm4RJiOUklUyfDqSK9sYmVIiuRuO+asuC7XUApAjaaYCMhiz+g4pe/6BP7gXC26BuH06+8AdRMGCH0EUG2Eul4Xva5a9rJ92dggUbNxZhasgKJh6LCY8YRp/Ar8CQn9KehTK+pdhj7kdzZ+QqR53U0qrJzb/SJEZxekk+koXGe2ZkBHchNSxxqYIpuogUdVv7mZ4CQ+zBcD4VVwTJoKGcGlReH86gj3twFbSHNzhps5b9NsMZIguE2mAJ3V8bhtNkihoAuklzRStABeC/A+DThjxWvnrTceHJ5cPwiiKYRbiGKF3aKYUyHWA1dCcujI/3TIntvLPMP3sPe0Av7V5l8xv6DTQyrgx6QPuEKTIWUL56oZfW5V5NAajHxZJD0FtvdDZE99GRKJ+7NNSoXlGMUpTj3JUh+OKKM6zIyg0X7iByF86zIUpGMkJdn0YTHo5xf1m7LhSy7YdGrJQrcGo+ZOwJXAMCSb+kcuYb2/LVQwY5Y+QvA0pLss5yNzK7M33MN22FlfE7jb2nTvbztslze4BEbuwAG2Qk6PHes36qgO9XhTC844T5hrlc+e5HNsX7ppLZAYTgKNQn7HUbDALYg4FDjwzT6j3XFnFX7lv/dOtc1IbovwcuV47kmizoY3duurw1C7wlu5Q0+D0BQNRl7tGVQDxpibsZFRFHzq6s7WuxMW1zMrGeUrQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ea0d23-f84d-4a59-4a70-08dad228ff2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:32.5037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3/25NIuw5chmnPL4reisQoKWik4+4vtqZuuwX7OffHDuZ4OnruX2TR6DgNQ/t7SMywjSH1eaX1T+vZEXABqdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: izlFNsYdgq_YVIkU8LFI0omdEAfJT23Y
X-Proofpoint-ORIG-GUID: izlFNsYdgq_YVIkU8LFI0omdEAfJT23Y
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

Pass the vma iterator through to __vma_adjust() so the state can be
updated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h |  6 ++++--
 mm/mmap.c          | 31 +++++++++++++++----------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3649acb9b0fb..ed6495c66703 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2692,13 +2692,15 @@ void anon_vma_interval_tree_verify(struct anon_vma_=
chain *node);
=20
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sy=
s_admin);
-extern int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
+extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *v=
ma, unsigned long start,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
 	struct vm_area_struct *expand);
 static inline int vma_adjust(struct vm_area_struct *vma, unsigned long sta=
rt,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert)
 {
-	return __vma_adjust(vma, start, end, pgoff, insert, NULL);
+	VMA_ITERATOR(vmi, vma->vm_mm, start);
+
+	return __vma_adjust(&vmi, vma, start, end, pgoff, insert, NULL);
 }
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
diff --git a/mm/mmap.c b/mm/mmap.c
index 71e8e9cfd704..8db711622d50 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -636,9 +636,9 @@ inline int vma_expand(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
  * are necessary.  The "insert" vma (if any) is to be inserted
  * before we drop the necessary locks.
  */
-int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
-	struct vm_area_struct *expand)
+int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	unsigned long start, unsigned long end, pgoff_t pgoff,
+	struct vm_area_struct *insert, struct vm_area_struct *expand)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *next_next =3D NULL;	/* uninit var warning */
@@ -651,7 +651,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
-	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
 	if (next && !insert) {
@@ -736,7 +735,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		}
 	}
=20
-	if (vma_iter_prealloc(&vmi, vma))
+	if (vma_iter_prealloc(vmi, vma))
 		return -ENOMEM;
=20
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
@@ -782,7 +781,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (start !=3D vma->vm_start) {
 		if ((vma->vm_start < start) &&
 		    (!insert || (insert->vm_end !=3D start))) {
-			vma_iter_clear(&vmi, vma->vm_start, start);
+			vma_iter_clear(vmi, vma->vm_start, start);
 			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
 		} else {
 			vma_changed =3D true;
@@ -792,8 +791,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (end !=3D vma->vm_end) {
 		if (vma->vm_end > end) {
 			if (!insert || (insert->vm_start !=3D end)) {
-				vma_iter_clear(&vmi, end, vma->vm_end);
-				vma_iter_set(&vmi, vma->vm_end);
+				vma_iter_clear(vmi, end, vma->vm_end);
+				vma_iter_set(vmi, vma->vm_end);
 				VM_WARN_ON(insert &&
 					   insert->vm_end < vma->vm_end);
 			}
@@ -804,13 +803,13 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (vma_changed)
-		vma_iter_store(&vmi, vma);
+		vma_iter_store(vmi, vma);
=20
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
-		vma_iter_store(&vmi, next);
+		vma_iter_store(vmi, next);
 	}
=20
 	if (file) {
@@ -830,7 +829,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		vma_iter_store(&vmi, insert);
+		vma_iter_store(vmi, insert);
 		mm->map_count++;
 	}
=20
@@ -876,7 +875,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (insert && file)
 		uprobe_mmap(insert);
=20
-	vma_iter_free(&vmi);
+	vma_iter_free(vmi);
 	validate_mm(mm);
=20
 	return 0;
@@ -1070,20 +1069,20 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
 	if (merge_prev && merge_next &&
 			is_mergeable_anon_vma(prev->anon_vma,
 				next->anon_vma, NULL)) {	 /* cases 1, 6 */
-		err =3D __vma_adjust(prev, prev->vm_start,
+		err =3D __vma_adjust(vmi, prev, prev->vm_start,
 					next->vm_end, prev->vm_pgoff, NULL,
 					prev);
 		res =3D prev;
 	} else if (merge_prev) {			/* cases 2, 5, 7 */
-		err =3D __vma_adjust(prev, prev->vm_start,
+		err =3D __vma_adjust(vmi, prev, prev->vm_start,
 					end, prev->vm_pgoff, NULL, prev);
 		res =3D prev;
 	} else if (merge_next) {
 		if (prev && addr < prev->vm_end)	/* case 4 */
-			err =3D __vma_adjust(prev, prev->vm_start,
+			err =3D __vma_adjust(vmi, prev, prev->vm_start,
 					addr, prev->vm_pgoff, NULL, next);
 		else					/* cases 3, 8 */
-			err =3D __vma_adjust(mid, addr, next->vm_end,
+			err =3D __vma_adjust(vmi, mid, addr, next->vm_end,
 					next->vm_pgoff - pglen, NULL, next);
 		res =3D next;
 	}
--=20
2.35.1
