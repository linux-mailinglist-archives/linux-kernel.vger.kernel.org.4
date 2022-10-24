Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B0260B5B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiJXShc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiJXSg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:36:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B4BA2ABE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:18:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OD4Iai005939;
        Mon, 24 Oct 2022 15:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bLQwIHydo53434X0wQQ8/E7O8RAXBWJzojGMnULryrw=;
 b=2CKiocv5n4PFpNmmJ9c+bl+DuiDa0qDpC87+rxUlgY75YXzHJ3PruYI4ZB1mp1sNBnCW
 Xlz4Wx66x7eTWbq9X2HwdM84oBIdpcaf+d0LYV+zrJimS7C24bUkj9i/51L7rtO8XLjY
 oYBaqgCs8Y1jM6GIYb6gh1w40oQ5dkgPxNggPTOEk9nBY0g0eCk+aXwZHcRghdBn86cu
 ztxIDp75Qy8MYT9NgB9kzp1h57pHm4sVcTGIDlIubAl3UlP20yTOkMBNf0ag6GDK05PW
 Qj0ZiyhkZe7pmLCaYl+3pwNCczWWAT9ps30CgmpD2IFc0XbS+hPry7LV69pTmqCCYPkv Vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xduu9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 15:07:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OE6DbD012765;
        Mon, 24 Oct 2022 15:07:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y3pv4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 15:07:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qp5QDi0mvjdofcS229xxgv4Xbed8EBRoCquaElpnqXASpMaaDPRmzd4Km7zrcjULwm1CHfwrlFyi88lPJgB9y9Yz3E9yGdbHIcUkqU7bdII49udDYWbQmtibv1Zb8EbMPtV+1xIgujsucY24e2rp09cU2392TwO0/Qq0rxz98okbVLFvuV+pcO8B7GTxCvK15B74F1CjLeTa3HsJ8Fhylt0ZQ1Zq1NyeX6SCTINIUGH0yoCZ0dBJnEvM5hjPmgrRR7l7ImyFlSBd4qev4SrDMq9ZpHtAmHPRf0X8cF4DCOaj5hmeYnH3WhoMQFNc4nuy+WlkqBiI0Ox54DRBgnMyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLQwIHydo53434X0wQQ8/E7O8RAXBWJzojGMnULryrw=;
 b=ImBy4euFiWRzYeL6f2bS0mjwbFDVgru2J99CxjJUxymDUdA9SgAUlG2sjheHt1QgkrlZPj73m9sCH8SgKMe2tiY+wG4U0jhDYIOVwNOlAlKMVW/FL+0T8JCBBWFpJWrRy5WdPYckA1KfR+2LOuUUHipr0f/q2zO5xcLU97GCXA6aWSaCyShx5a0jR8ERxOmH9WXg2EK+7cuRaLkFyCIUlIM7W5vk4SS1DpLYwc25YXb4GYYQ4zgO5JYhW8NzpRpbgzyboJhpZhWon7jnKuFCz/xD365p6rsPrjC8jUd6UaRVh2xn02xcQE4ecNlSVZkmRdv6EGf55+b+Ag0ZazrYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLQwIHydo53434X0wQQ8/E7O8RAXBWJzojGMnULryrw=;
 b=LQ03axoCI7JnuA+madV2U81BrJH4yUKcKPu09Gh5OnhXjgQ3PmL5wpGkD3ICZOoM7Z1/bLLMljKLSvrmob5nrH7rUKp7zqPrfaoncjtnJ5hsya6A5CC+Dw+d3GytNTw0YrAt5fQnRdHYAmRPK7y1pkCO2YME5/P+8Nd8ZYSwmgE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6054.namprd10.prod.outlook.com (2603:10b6:8:cd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.35; Mon, 24 Oct 2022 15:07:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 15:07:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        SeongJae Park <sj@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: Re: [linus:master] [i915]  f683b9d613:
 igt.gem_userptr_blits.probe.fail
Thread-Topic: [linus:master] [i915]  f683b9d613:
 igt.gem_userptr_blits.probe.fail
Thread-Index: AQHY52ZPgWXQSVJFM0ahQR2v+R0nKa4dpeQA
Date:   Mon, 24 Oct 2022 15:07:54 +0000
Message-ID: <20221024150734.zjo46njdblmykczj@revolver>
References: <202210241246.68be2f11-oliver.sang@intel.com>
In-Reply-To: <202210241246.68be2f11-oliver.sang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS0PR10MB6054:EE_
x-ms-office365-filtering-correlation-id: 67d34217-405f-4e36-212e-08dab5d186fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CjJww7PyhGtT2hq+zwa5rftoX0nZeyLRu3HMtkEBY9RD6I9gxhAoUBNxYEq11ttWXs0QtTtt5G1uPFygwUUcIvEx7whJ4gkbhXQlOFHlc60pjheF0GUd0sV66WamMgtVbzOBQuEpSmGqDyEBRwqsKQvL9XVSwJM/TLXS/jGLCXivUpto+n/bHt2eqISb69L6ksQfRu93nKcmWZmus3yfEs0ugnIstPddGgGTx0d3ifqs8bQlFGDnhdlyTqmozMToBqmDHn2UU+CcXHi3CNgS9J3+yK/W7H3yc5UXjaPuzbBw5eexYGfda6Kn970r+63c5Cyalw4SegUJz9f6FDRDWz/qUTkeKwC4YfWNdoLYapQyfnMBXgcLt74NRje9QxPpSEquVP51ypXgpvqjxsZLtozWYrUvoRUgG73TJe9URPvf5M3weaptxdzjXu7gLtMzjZFyvhpCDuGAyYSUWPNWt0fg50Is9PxXOOMZTkJi/I2GJ+Nb8bzUfKAjJjUiyTfJWLxHtqJjvZ7xOqBP8pf2a9fkUKQGilTDbFJLZzE3gg+DtTVOfW+2wXAw45+PD1w8LD2QRw8PgnsbC/SScl9MPXBsytzYN7NxB/zI6B54QTcczCX2+len0cnV7f1sLwE3h9jpow0dfxyLwofgx9CKJBTz6WwVYjmiX0SReH5jz3LG6kSZOVhhXWUgGBj4yf/TWyc2o7uG2IwIZaev6RcOiEgNC0bt8A0W+Ycippfaflg3IgC6IMXRptlNQxlBoeeVXfQ2KmGSnoP2QurxeDnNz3zSXcQXUZGXipPBQFlgpnVAfrAJf3Zm/trrDsnsV4urRSW+X1C11H4juF3ixMOYTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199015)(2906002)(966005)(4001150100001)(9686003)(71200400001)(478600001)(1076003)(186003)(33716001)(6486002)(38100700002)(6916009)(122000001)(54906003)(66446008)(66556008)(8936002)(316002)(38070700005)(6506007)(91956017)(66476007)(66946007)(8676002)(41300700001)(4326008)(64756008)(76116006)(6512007)(44832011)(83380400001)(7416002)(5660300002)(86362001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fiALzd31CGtF+h1UVx5zD8uIyUKz8zQiu65L3eu+CJ3afCx8cqaOjn3uM9Yl?=
 =?us-ascii?Q?UrsihHPUY7NzNHx1a9g4nHJYFkwO6+v+S8HBJ98T5ezhycjFGZiOOvSswyTK?=
 =?us-ascii?Q?dNv12DVTISv4/P8o9I55zNxn7DuP3pIXWHzU4TSbsEUbO+AEGvrXkH7Z0Sqi?=
 =?us-ascii?Q?WMXBX7XO14ipElDdlmlGVrNtPNeoGqHul1UKYcLtSy4OqDwJKDtN3tAFc9JC?=
 =?us-ascii?Q?2NI8YkZ8rZ6MOUjbl6c1bYZBmitFMHXa6STgkk8neSPJeGwbn39h28zq4jeM?=
 =?us-ascii?Q?AzJJzQ+oT0nSpUTovXLSxYCI319eurI0x41/gy+N3m+3hjCIasPEbCMTD15k?=
 =?us-ascii?Q?dfU2BUARsRaK3k07v/Yl0vSiKkK4i8wEeM5weW6mNiziX6hQQPROvyUauUSY?=
 =?us-ascii?Q?av8JOPnzBkU4JQNC6mcFoTO6bj3DO19RCJFSklt5McZ6hXQzFFo7ZxHsmIZ4?=
 =?us-ascii?Q?0mMSdHinHcmcP8t1adP5zYKsmblg1+xgc5ujTxybbSEBRgtXJwBlATGi4Dao?=
 =?us-ascii?Q?17AsgHcZ+JsTcE43tmiUF1FXjxZfGK3Bpzl9BmTPqW6TYE+xbAsWjnxS7yFp?=
 =?us-ascii?Q?tytjh9ShYmI2xdiLoaX7UoVZrr/39zlF57XUwW/CgZfUimc0PoPIVGYeus5Y?=
 =?us-ascii?Q?y5tScrsXWNHqCefa8B5kLVNfUDW9obL6E4h70eDlLkeJ1G9cRV8+yWRBnbmJ?=
 =?us-ascii?Q?mntGBRsZSx9sCsgeD6xutlWf3gyyKl6xPM/9IW8esIY65X+ox+FpZfm/O3BN?=
 =?us-ascii?Q?VUckvMiPZWV97+i+hym43x8W6a67P7pOCXjfHZuTxv5yyqpHgI16gLBlFkzv?=
 =?us-ascii?Q?UlcBdxk/vHG1rp/GkiTagHdqVJr4MANtDVq5S2GahYnjvMvLYHz7LzN3PC6B?=
 =?us-ascii?Q?A/quICXMyFWEb58ydjT6z4VIFrxI9+MdjLJW/tYsOS+lFMtd49xkMZPfEze6?=
 =?us-ascii?Q?38c9VS+TzkQQFHHmvGp7l9G+uJ3Sc8ImjRtPdpcG6tG0nq8GBJfpehxrERLi?=
 =?us-ascii?Q?/aBONmIT4SfQSu44kscp1h8xQ4QwjBs/+NB+b4FzHjYG8ukDxT0eowfQi12a?=
 =?us-ascii?Q?b8laxzSdFdFI2X9+I0VuJVcZvAwrVOCjS6XHDKbN3+EWhTtS6kXCPblhfUjH?=
 =?us-ascii?Q?F1mpWWL/N1Yluwr8tmOrXj/2Kj9mLw2VGbCkZry3RpZc95E9rwmGUQS9sS8h?=
 =?us-ascii?Q?XCG8sKnMzUvTuNUIb9rvODApJA6matqH7tWCqWzFX2idecshnu0b3AFHMaim?=
 =?us-ascii?Q?zZ6GAV58Hnue1JYXxULweaeSvXFlyGIvrck6xbOG2tiLoeM46yaV3LoncBWj?=
 =?us-ascii?Q?SOfr0B1zZEsQroVNbyAbykuHqdKVmwuDcHb0ci2Mw4itqdvk+figMgXmRe4c?=
 =?us-ascii?Q?17xesoHIhDLuKrsM4DhBOUVS08mAevpGcxZHWuPOFHKejsauSqtOLDeFctag?=
 =?us-ascii?Q?z9DWpm04Zr8Gh8ZmjXoL6fkswFVq7k1t5pcz1elfbu8DqrRMLHfI1ArwBRVe?=
 =?us-ascii?Q?AY+9j3DptnHr1iXTr2tbN3vx6+4Vsj3mNIc3dLrRS339LAZmZ+yWwJ8LiC3y?=
 =?us-ascii?Q?gHQPbHChTrUdNGhBqndnq5RrLq9DoR12EL+VfW/5GIS7Q2GNF3uX1ZjBssll?=
 =?us-ascii?Q?9g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D9036337C0897D4E9DF5ABE4FC02F776@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d34217-405f-4e36-212e-08dab5d186fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 15:07:54.3365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2bx2fVXyB64yzgCOGApwfsamva2yU6YNpEgW5xvJNJVazhdgJWh1A2mXeBjlCxRH/k/djFIJhI6qL7caSbGnTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240092
X-Proofpoint-GUID: Od2fGoqPHYui47Qw3xhLnjMapYUq6u8B
X-Proofpoint-ORIG-GUID: Od2fGoqPHYui47Qw3xhLnjMapYUq6u8B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel test robot <oliver.sang@intel.com> [221024 01:06]:
>=20
> Greeting,
>=20
> FYI, we noticed igt.gem_userptr_blits.probe.fail due to commit (built wit=
h gcc-11):
>=20
> commit: f683b9d613193362ceb954c216f663a43c027302 ("i915: use the VMA iter=
ator")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
> in testcase: igt
> version: igt-x86_64-cf55acde-1_20221012
> with following parameters:
>=20
> 	group: group-13
>=20
>=20
>=20
> on test machine: 20 threads 1 sockets (Commet Lake) with 16G memory
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>=20
>=20
>=20
>=20
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/r/202210241246.68be2f11-oliver.sang@intel=
.com
>=20
>=20
>=20
> 2022-10-24 03:27:39 build/tests/gem_userptr_blits --run-subtest probe
> IGT-Version: 1.26-gcf55acde (x86_64) (Linux: 6.0.0-rc3-00280-gf683b9d6131=
9 x86_64)
> Aperture size is 268435456 MiB
> Total RAM is 13505 MiB
> Not enough RAM to run test, reducing buffer count.
> Test requirement not met in function __igt_unique____real_main2320, file =
../tests/i915/gem_userptr_blits.c:2401:
> Test requirement: has_userptr(fd)
> Starting subtest: probe
> (gem_userptr_blits:1984) CRITICAL: Test assertion failure function test_p=
robe, file ../tests/i915/gem_userptr_blits.c:2231:
> (gem_userptr_blits:1984) CRITICAL: Failed assertion: __gem_userptr(fd, pt=
r + 4096, 3*4096, 0, 0x2, &handle) =3D=3D expected
> (gem_userptr_blits:1984) CRITICAL: Last errno: 14, Bad address
> (gem_userptr_blits:1984) CRITICAL: error: 0 !=3D -14
> Subtest probe failed.
> **** DEBUG ****
> (gem_userptr_blits:1984) DEBUG: Test requirement passed: has_userptr_prob=
e(fd)
> (gem_userptr_blits:1984) CRITICAL: Test assertion failure function test_p=
robe, file ../tests/i915/gem_userptr_blits.c:2231:
> (gem_userptr_blits:1984) CRITICAL: Failed assertion: __gem_userptr(fd, pt=
r + 4096, 3*4096, 0, 0x2, &handle) =3D=3D expected
> (gem_userptr_blits:1984) CRITICAL: Last errno: 14, Bad address
> (gem_userptr_blits:1984) CRITICAL: error: 0 !=3D -14
> (gem_userptr_blits:1984) igt_core-INFO: Stack trace:
> (gem_userptr_blits:1984) igt_core-INFO:   #0 [__igt_fail_assert+0x106]
> (gem_userptr_blits:1984) igt_core-INFO:   #1 ../tests/i915/gem_userptr_bl=
its.c:801 __igt_unique____real_main2320()
> (gem_userptr_blits:1984) igt_core-INFO:   #2 ../tests/i915/gem_userptr_bl=
its.c:2320 main()
> (gem_userptr_blits:1984) igt_core-INFO:   #3 ../csu/libc-start.c:308 __li=
bc_start_main()
> (gem_userptr_blits:1984) igt_core-INFO:   #4 [_start+0x2a]
> ****  END  ****
> Stack trace:
>   #0 [__igt_fail_assert+0x106]
>   #1 ../tests/i915/gem_userptr_blits.c:801 __igt_unique____real_main2320(=
)
>   #2 ../tests/i915/gem_userptr_blits.c:2320 main()
>   #3 ../csu/libc-start.c:308 __libc_start_main()
>   #4 [_start+0x2a]
> Subtest probe: FAIL (0.052s)
>=20
>=20
>=20
> To reproduce:
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>=20
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>=20

These steps seem insufficient.  Initially, it failed complaining about a
missing config so I created the directory manually and copied the
confing in only to have it fail again:

lkp-tests/filters/need_kconfig_hw.rb:11:in `load_kernel_context':
context.yaml doesn't exist:
/pkg/linux/x86_64-rhel-8.3-func/gcc-11/f683b9d613193362ceb954c216f663a43c02=
7302/context.yaml

Is there a full set of instructions for recreation?

Thanks,
Liam
