Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE565F42A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbjAETQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjAETQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5561B6386
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:02 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ITwdC029112;
        Thu, 5 Jan 2023 19:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=+jMDOV2IIQpB+2+2GrbuhEjyuyAvdUt3VdFCtIO5T6c=;
 b=hlyEVuwdWKOk88dYdIpMYscBitsGaG0Hx/braZ4JqtL1nCbvWc9nk+9q7U5UafmBT+6b
 kTy4mwV8ciGqIBxDMPXvw6CvqH3987s/6vSt2xuTGMrYaiSORccfLj9AuuO/46JT24Q/
 9TVxPZ0YUbKFC0JKVD2N1nVEkKRO006poLRipp/8ro1+nHGO/J8bhc2NF7NfFBy2SXFf
 BEwTo2pbqQx0sNozAnmxarAc2WGCiebK3yUzUF17U0X4Ans9mn0EWNneyZW6sEtVx0Nx
 8E1en2Vx/WF3MBPigHIdwW5XytRsKoAjZJW1xGqyTuyl2vuIXqfEB9QgBPWd9asyMpzn aQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0asrjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I6Xlm027985;
        Thu, 5 Jan 2023 19:15:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwft03xr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idsnICwmNsswHOfOVGoQ0Vgt3Db0PPaTkVAR3hStw/pbU6wN6k2wceoLUrhq6AdTFDcuyV2waP/Jun2zgUa0/hsSXLzAmosHsokdHGFzY0LLFkoGKb1n+dNd4Vcxrsq77BOnX2G6UXhfCePiBW9ECdkCN/zmYULbHqi/nuCTrQcFr3qtkGkDp76wKkwFOL0/wW24SoztchFud1twcBE2Fby6OTANlxxF46DprVhHSPiSCJRzxbsgf3ya84HYfeUYDMESfJxMolbE9ZGwoDD+eh3FbwHAURIoPLOJyejk0yvbKiRKzXdsNp5ZJzwV1S3W3qxwGxDjEck8GfmlW6wTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jMDOV2IIQpB+2+2GrbuhEjyuyAvdUt3VdFCtIO5T6c=;
 b=YxMVQ0jAnjnxi8ms4R8lFCQPpMAx1as91LH9P/I1eO4lZO+AvwTKpgmpbvWl3wnZeysLWOqJLbdxrkDVlX0JCWI3oSBxiv0g1NFBmV8DlTrExhG2nl3X3CF/qqA/de8jSud5+9OAGSm8gr4K3FhTWyFvXbI/54u5WWJTuYEIfNKwT6S77b32rbxTm2Zy1Lm5GLLRjDUElMfMpvE4ID/PLEaBonwzrJLHRZt9wz0sELV55f7dqvUXR2a5bxP1V+izoJtqXYRr6vnaLRsnI4FFg8Auwi3p+nukCtRn0ghm4ACTbfRL3ffiTmh5AuYy0Zw4f/IzAOtpiM2UIMfjXhenTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jMDOV2IIQpB+2+2GrbuhEjyuyAvdUt3VdFCtIO5T6c=;
 b=yKMZMwNVqhoDHBnRnC68ahlEC0JE0pIwM5qunhzoyPzLzJJWaIqvehgWsUF/46TfmLLH4/j4iLauRaQvxQRub+cP8m7qCj5XvePfWsc3rhSVB8llaJ0Qjesh5MxCxCqrEIK4x4MQwW8fNcwCPgNWe1kF5rXstfc0LEfSNmuPkA4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5231.namprd10.prod.outlook.com (2603:10b6:5:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:15:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:15:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 00/44] VMA tree type safety and remove __vma_adjust()
Thread-Topic: [PATCH v2 00/44] VMA tree type safety and remove __vma_adjust()
Thread-Index: AQHZIToccOuEFtBclUuUQ7tIi7gZoQ==
Date:   Thu, 5 Jan 2023 19:15:44 +0000
Message-ID: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS7PR10MB5231:EE_
x-ms-office365-filtering-correlation-id: 40f074fc-cf9c-4155-20fe-08daef513e97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kwN7emaFQHs/4uJUn+cWEUE8cOiV4e+1/lY5o0kBOmIPbXhMZm5/BLvWo07CEyON6GaEQf6HwRAUhQ210P42JsBQC1EPYsOwmeZPWRtJVMC+fmp7D/LWFAmY1jFZfObF4305Tzj8V2khoZ7HL2Q4aI6fuBFETk82ayfwVSJBvcKpZTwIsILYujYGMouCTDWjcGhJXZn8GcAzmEyedB1MPaT3HtKbgj1c7Zyrp7MRTNmtFxqHvhmW4HrL/aKU3hUA88vmE0fADGCrTIncuBOo2nXMViIE9VYmuF9+CA4DsOvXRo3BowSwOKE9imtt6s+P3iuipJOnmxM6NTwoIzuITwJ1OCmZiFFx8SBhaAs4YbnyhWTYsednfFSlNeH5IHS9WiCh/SLhiN7e0sSktdvfVGl2UhpRlQZ1eBv7Xku9W7y9xIoH7A9UecU4WXmO1P6aAqe4Bn68MvYnESIR90+zpV7OITk5RwZUzDgyTOSBnHttzpnk7Jo6XUwiCgHRj1HkfQAipnXC28O/o49omFzrao2xVmOOwCDjL7YPNtjRmmcbSTHenxoCJczepikVRPYnOogY5bnpTextj/Ka72N7IZKEb2gjkWO4rbqsEUkVORan2218nAf/A5yy6eG001pEGE64+bSt3EfVEVSmluUH327/vcE4S8kLCwaQWZrqOAjauNOJ2D0i4rSUykGMoVD539ws8ST/nd8F/VJbavjPuwI1KJlxN+jw21r7Vk8Mtyz9Oh7E1JeDUDB33MEx81zVVhv1FgJEc1X3lNITYQ626w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(110136005)(316002)(6486002)(966005)(186003)(26005)(71200400001)(107886003)(91956017)(64756008)(66446008)(2616005)(6506007)(4326008)(66476007)(76116006)(478600001)(41300700001)(44832011)(8936002)(83380400001)(5660300002)(66556008)(66946007)(6512007)(2906002)(8676002)(38100700002)(1076003)(122000001)(38070700005)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gtVxmRYDhj9fiju04GOKsrWGo0P9BwKbwWLprZBorojh/QC1C8dDdOE07j?=
 =?iso-8859-1?Q?pwIhc18bOWNjMCKD0HbwXegtrIGizR7/iNG5u35jjxx7xMipKH0wHavQR2?=
 =?iso-8859-1?Q?B/dROzPkQk0JLoCGlhVh4dyeMIvDA9ji0UP/K2sdJ3NTIx5zexM/O0p9mH?=
 =?iso-8859-1?Q?OmJLD/TrHjkVqq+yTNjsQI/erWTSmQjxESI5C/Pk4hqsl/1NrRXMpDxUN2?=
 =?iso-8859-1?Q?HuSXmtblMg/PIxV8u3E1B/YtITuV7oGvOCZBGHp0StWYOqBRmo3zdBYOp+?=
 =?iso-8859-1?Q?rb4OYR6N1hZ/QiSwr9KmxAaWDds20Vuw3nb5vwcjuub6caCI0/eJCIfGDm?=
 =?iso-8859-1?Q?pnsVMn0XIQj7tvinJExSqDOuwW44Zcj1waBqUGGc3kzyZ8+MCxG6x6ZTaT?=
 =?iso-8859-1?Q?vlinQQPknV8ImWk4il/MadTdUI78oTZCzD1JlxI7Kj6Ec7i7EBvkBSDo7G?=
 =?iso-8859-1?Q?yS+3jIOdEUduL21GqbYYDAj9oQhRxCcO4UUZ1fQq9vo3Vu+MwtOSjkEYUK?=
 =?iso-8859-1?Q?aSReA0psEnkADrATdtTJV4nHp0tuLJug1dsND7cnrQ/R7k/Z9ySHm2N5Es?=
 =?iso-8859-1?Q?UAUd7XM0RA9QXwFcKnEXCr3sKHOYu5n4mP3n3oWxMFNiEhGDW48dECBkUi?=
 =?iso-8859-1?Q?XFt0tkFITcVn1rMVJCaj5qXG/AceYzNAbvKw+0uQHtUBCjJKoG9HU6WNHu?=
 =?iso-8859-1?Q?d5RWzb5Goze1gpDbh4BDOPLAyJ1/GhL7d3163hNyHUo+8vvpS9jjyKiCnK?=
 =?iso-8859-1?Q?Pg44uT/LlRepnzuRt7PAD1yT3JBSknHrQlChGkwhG7aT4IkfNaIJzTnJck?=
 =?iso-8859-1?Q?kT5MXFt4AZOcRiERHRejq1sxhyEGZugmkOg7xhqAbaj/zgJ7P5xD2B23Wb?=
 =?iso-8859-1?Q?fiuIgo7ahZNnR1uilhmUcL1PVE8CcTtolFQANjesp7kUGAitb4fXH8Is5j?=
 =?iso-8859-1?Q?HPUl8NNmOsttk4N1Rn7KXbcxgtFUItuVgOjvkv2A5STrnjvkexQi+szQbG?=
 =?iso-8859-1?Q?eLXlOxL0u7eN0mjrTp/X1pu9g0oUHB936SIEtE/2ZsuC+M9OSIYtDbU6s8?=
 =?iso-8859-1?Q?dU+estul3443j/ceI/4BUBiXdg02R1pWuwmFbjUT2ADDgHBg137QgeJgrQ?=
 =?iso-8859-1?Q?+0VuaLTvafxzN1ATdKYzXdvAOqQ3FrKIbLO6OvmEQ3/OVSetcpKF0eOP69?=
 =?iso-8859-1?Q?8Cn4IN/pQe6MIO3xWmWbepyq20wjn8SEI5OqmgjGxRCj5B1Nlep/+NBPUH?=
 =?iso-8859-1?Q?Ctt9UbAWB3efEBdQRDrksHFLqz5NbCPVqvmk1aG01kC5+dXtAhE24CB6Uo?=
 =?iso-8859-1?Q?Bq4rfnSuT9u3C01LmULq0PhzK3BPwdi5ngut6OxojLiakFx1uvnYvLR9Yc?=
 =?iso-8859-1?Q?ACe8C31k8btlHlyQoJ4k5+O8RfoxpKIzbV2+imLmMNDawIaZwqIJVcQTVV?=
 =?iso-8859-1?Q?xTOLX6Sshei+IbeTrWjLdeKvfXGtgrV5X7elyj9c7Y2iYbKJIX2emop5t8?=
 =?iso-8859-1?Q?utHtWUSFaGYcbTdBofksCjzc+hamExnEJJPJ/uiVN/F6nsol14tIMRYuG+?=
 =?iso-8859-1?Q?ECHzy8y1I3X5eKEFyCGqx8hNqo5bCzllJZiU5dCAFz7t4afQTVCdA8EoIP?=
 =?iso-8859-1?Q?d8PEMHjgMNYBLi0sOT0XkKZM0pqDwl008VjrPCxOZ2du9pV6XS9mUtGw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B25gX4QlBgqIWJeajLfyICDPCRQfcbF8XXjC1NrDoq+mCZNlnM3HcfPQM6X6D3FJFEhi8Q3FtPko/RQFBCobQ4Czea1NieexHmAGmf9Hp21jtu+M3wJ1OAT1RcQlzv3CMDPwqemY9QHAwlSh3lhsNcfkOI3N5O7fUi1HkztrK3QTK6PADF1T+6HmQ94uEo2ouej5n8RnWMte0AvZJjw6nsWKt6mDvfOlAcT23WpSi9Un+eirHYfufKiGl3IqbeP6YfmcuWGVZQXT+hqsl7Q1BWVRwKT3M0gjH5weNrmCVkoyAfMnwJhLvvzRwtOl2R1Un9BFZ0vLq+YcpLsowNcu+uWW7Igambjxsu4b1d0LHR+k0sKt0oP2iM4PrQyYgklyNCyL2kYlMNrgnW5L2MRTShoOtRTAFbUVUO+/xHXmzrB6b4AjBOYGpS/GSPznU8s7inFDTta6XdSHJIxpUXXh1/N1YHkMy0v5oxkKrNEzfEjOcEqJ8wZU0pNgoAMhy0Py/gOroJBiAtT4G7eJlfGts5enp2+NB8LWp/TdEzHVTOvX2G5Xx6rIKyInuWbmFAJ7KYbM70wgFfQ7e3xvAnTg3NMX6EFiVq+r26oTvUeIpD8AgCW+z3etvoFIMuMQiTLGlzqwwTJJKNZoCBRzNqhpj0CCWXBIXRRkd6ovs1A9Ta8BiGtqO9BF9Zwwt8LyRkTxBqMkT1gt0IHOQ0n3yEbargqXLW+D9lxJ3CVptGN3V6UR5+jzlqFyaVqNCRiD/50YGjZ5R2K05tYhWA3k2Ew593SYx1rGEQvmZoxREO6aRwgES8+wL3NxBwhXUYAAbT+1sxwZT6z5R5GOedtkL5oLT0f0ralFG6N+FJ2wMaMUTF7Jth7DNzS42CG9TeRzwHncqeBW3ZDWgI3bjEenlq8kGA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f074fc-cf9c-4155-20fe-08daef513e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:44.7202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z44lwaWnV7YGF3brVIG7JwR6nke45r7bWbzPICRBT8Pn0rCMTFufNFDBYg1OXjlsPtLarBLC0ikT6HPqk7OvcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050152
X-Proofpoint-GUID: 30aAgKwaa2E7UjyUHPZe_OecvGio66W-
X-Proofpoint-ORIG-GUID: 30aAgKwaa2E7UjyUHPZe_OecvGio66W-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Andrew,

This patch set does two things: 1. Clean up, including removal of
__vma_adjust() and 2. Extends the VMA iterator API to provide type
safety to the VMA operations using the maple tree, as requested by Linus
[1].

It also addresses another issue of usability brought up by Linus about
needing to modify the maple state within the loops.  The maple state has
been replaced by the VMA iterator and the iterator is now modified
within the MM code so the caller should not need to worry about doing
the work themselves when tree modifications occur.

This brought up a potential inconsistency of the iterator state and what
the user expects, so the inconsistency is addressed to keep the VMA
iterator safe for use after the looping over a VMA range.  This is
addressed in patch 3 ("maple_tree: Reduce user error potential") and 4
("test_maple_tree: Test modifications while iterating").

While cleaning up the state, the duplicate locking code in mm/mmap.c
introduced by the maple tree has been address by abstracting it to two
functions: vma_prepare() and vma_complete().  These abstractions allowed
for a much simpler __vma_adjust(), which eventually leads to the removal
of the __vma_adjust() function by placing the logic into the vma_merge()
function itself.

1. https://lore.kernel.org/linux-mm/CAHk-=3Dwg9WQXBGkNdKD2bqocnN73rDswuWsav=
BB7T-tekykEn_A@mail.gmail.com/

Changes since v1:
 - Changed the subject to better highlight the removal of __vma_adjust()
 - Converted damon test code to use the maple tree functions as apposed
   to vma_mas_store().  This added an extra patch to the series
 - Wrap debug output in vma_iter_store() with DEBUG_VM_MAPLE_TREE config
   option
 - Fix comment in mm/rmap.c referencing __vma_adjust()

v1: https://lore.kernel.org/linux-mm/20221129164352.3374638-1-Liam.Howlett@=
oracle.com/

Liam R. Howlett (44):
  maple_tree: Add mas_init() function
  maple_tree: Fix potential rcu issue
  maple_tree: Reduce user error potential
  test_maple_tree: Test modifications while iterating
  mm: Expand vma iterator interface.
  mm/mmap: convert brk to use vma iterator
  kernel/fork: Convert forking to using the vmi iterator
  mmap: Convert vma_link() vma iterator
  mm/mmap: Remove preallocation from do_mas_align_munmap()
  mmap: Change do_mas_munmap and do_mas_aligned_munmap() to use vma
    iterator
  mmap: Convert vma_expand() to use vma iterator
  mm: Add temporary vma iterator versions of vma_merge(), split_vma(),
    and __split_vma()
  ipc/shm: Use the vma iterator for munmap calls
  userfaultfd: Use vma iterator
  mm: Change mprotect_fixup to vma iterator
  mlock: Convert mlock to vma iterator
  coredump: Convert to vma iterator
  mempolicy: Convert to vma iterator
  task_mmu: Convert to vma iterator
  sched: Convert to vma iterator
  madvise: Use vmi iterator for __split_vma() and vma_merge()
  mmap: Pass through vmi iterator to __split_vma()
  mmap: Use vmi version of vma_merge()
  mm/mremap: Use vmi version of vma_merge()
  mm: Switch vma_merge(), split_vma(), and __split_vma to vma iterator
  mm/damon: Stop using vma_mas_store() for maple tree store
  mmap: Convert __vma_adjust() to use vma iterator
  mm: Pass through vma iterator to __vma_adjust()
  madvise: Use split_vma() instead of __split_vma()
  mm: Remove unnecessary write to vma iterator in __vma_adjust()
  mm: Pass vma iterator through to __vma_adjust()
  mm: Add vma iterator to vma_adjust() arguments
  mmap: Clean up mmap_region() unrolling
  mm: Change munmap splitting order and move_vma()
  mm/mmap: move anon_vma setting in __vma_adjust()
  mm/mmap: Refactor locking out of __vma_adjust()
  mm/mmap: Use vma_prepare() and vma_complete() in vma_expand()
  mm/mmap: Introduce init_vma_prep() and init_multi_vma_prep()
  mm: Don't use __vma_adjust() in __split_vma()
  mm/mmap: Don't use __vma_adjust() in shift_arg_pages()
  mm/mmap: Introduce dup_vma_anon() helper
  mm/mmap: Convert do_brk_flags() to use vma_prepare() and
    vma_complete()
  mm/mmap: Remove __vma_adjust()
  vma_merge: Set vma iterator to correct position.

 fs/coredump.c              |    8 +-
 fs/exec.c                  |   16 +-
 fs/proc/task_mmu.c         |   14 +-
 fs/userfaultfd.c           |   88 ++-
 include/linux/maple_tree.h |   11 +
 include/linux/mm.h         |   87 ++-
 include/linux/mm_types.h   |    4 +-
 ipc/shm.c                  |   11 +-
 kernel/events/uprobes.c    |    2 +-
 kernel/fork.c              |   19 +-
 kernel/sched/fair.c        |   14 +-
 lib/maple_tree.c           |   12 +-
 lib/test_maple_tree.c      |   72 +++
 mm/damon/vaddr-test.h      |    6 +-
 mm/filemap.c               |    2 +-
 mm/internal.h              |   13 +
 mm/madvise.c               |   13 +-
 mm/mempolicy.c             |   25 +-
 mm/mlock.c                 |   57 +-
 mm/mmap.c                  | 1076 ++++++++++++++++++------------------
 mm/mprotect.c              |   47 +-
 mm/mremap.c                |   42 +-
 mm/rmap.c                  |   15 +-
 23 files changed, 876 insertions(+), 778 deletions(-)

--=20
2.35.1
