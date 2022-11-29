Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982F963C580
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiK2Qqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbiK2QpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:45:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336FE4A07D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:45 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPo8k012293;
        Tue, 29 Nov 2022 16:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=iX98eDd1yhxIyFEsnty6d6K/n9n4hTMHagteSF399+w=;
 b=EamjOWs0oFlHrO8kFZp3ZVCG7byhMc+ElsvlDDCtqJeh5OM9s18Eyy/JuryxCdcFmykh
 Mr1Mv/C20psMRnTbo7gV0wtDx6qjVEy4X4IQpvlBawlWm5W9dHMhX3xvNINxN9nE4ReT
 agXt2R4ksMeNi9BozRC89k29UENWRlXq7qHfrVYIr4aIZT9NreN2FKPYoNfP3cQaYNbq
 cYWLQJwvCp8Jk3qTG9pOd0tgmdDclINYyVbprPxs3vEcaMQe9D9YsxEBATVpuhVdc1ne
 czr5D0XY+PVUD+Uu3itijopp8HMrqr0el9d9Q+Vy++zQtejxosAKPXYcE/TMaqPI4tlt +w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemdn9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPt027963;
        Tue, 29 Nov 2022 16:44:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lY7dvvPehCg4JkfibMaK5DUi+Wb/XkUl3487wQ15WFw4zKHi8FFCMrTQKUhu/V3l+CvAd2u3GG6iGfqg2v4OvpiVy/f9wN6G3PgZVveLDzlOC9DdeeTMqkE1/lRaMGz7ivhXFj9AImtZbbrYa1McUPd//aIBrUwtm306HkNb5tNUVZ6Hs39UKfTt5b5Q9d8LKT3Fpd/o8OAfC1e3AZGQ07XWdDGrZcIPShBBikrvh4NOWGlmjZk6XnBc8C36t4foCpvOs35Fs5a54mfUQNK+jxIKlZJwlyqT+b3JKubAAK0culVa3jrsIJBJmlyzM2Z8BUtcyrcmGL0IF2T6sCQBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX98eDd1yhxIyFEsnty6d6K/n9n4hTMHagteSF399+w=;
 b=LyAhYKUT3FB/fmslCRfmM8EMGkJr7pFeFGhBh/7x3B3jDstjOpRjbGOmLowRrEJrj4WvllxizxkYKkRPxSsEcvyKLHF4qt3mJh7bFoTZ6iKY+jm+X6UIzBYUOoB0OwaXwbzGqDDKfKwpWddlHLdlbqxy5mbetkljlui4FrlmgimGBJYC4g4k9O1xEdCsAH4JTK7o1vfrFWnV4s+0fsmUp/uvro/VGO+MmjPgygDuGpEfdFgapTGpL4USx3sQxlWUGXax/yf5GDDhlVGqbDcEyAofUDrpu/YrPdbRGr9Rs6MAyomE6SqJymmG/Rd260JxzxrOSXLM65EYqTCiof4Yyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX98eDd1yhxIyFEsnty6d6K/n9n4hTMHagteSF399+w=;
 b=hsVZ5lTQTf/QG2Ix0232AqM/AnPvoi4XHMm/8G2bTOuS4LoYo23WkeH1p3ne8sUXxVDMy7FhN3bAM5kxMyOhs/xWCDOzpdSErCV+mPA//X0374gQcbS5dSrt+LdLIRg7MkH3zauAsFPZS2uredh/yUCRX/kqzLpeg3yC+S86Xlk=
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
Subject: [PATCH 26/43] mmap: Convert __vma_adjust() to use vma iterator
Thread-Topic: [PATCH 26/43] mmap: Convert __vma_adjust() to use vma iterator
Thread-Index: AQHZBBHbBu3yBS2EGEWq7dlxvaSQLQ==
Date:   Tue, 29 Nov 2022 16:44:32 +0000
Message-ID: <20221129164352.3374638-27-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: 2cce1989-d201-4721-62d9-08dad228fee5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ipPkMT8BSeOt9n36wP45j8aUWlWU0bIliXgSxHttznuhL0QcEEifMczT7fwska0/byoFODizbXqKOLeKHI1KlCodqoGaQfnJOdprsLlQo0UuHeDZzU8N7BIAUWDFecmP7wsPce7pNub13KdEHCNjypdG/n+SxfcJ+rfalLRRYgrGosg26RzWlNRZ62Sd8d8bfTY9V8ggrU4DWW+JeTEbO6UkoAzcw8WJhDBU15akDDkvcy1wUZ+RsbIjrHU4jzcdKKNT3Nm/ZphmNbabb3Nw3va8QKwpBGdu0+UyMnbToFE1k40i5OS/DaRoEMM4b4Taiuq89sD506+ABcE+LzJzGe44OpZmRRNev5XLLS/CVmXDK5nlGstu+fvlNxKH3D2jm6bpf8h6+VFtlVNq/Gjp46S060a8nNEbUIgbdNOIz/32/2nYkkLdFebrRhoJzKkYDffdx7cC+q35IqccecAcCC0r2oRtOxU32Gy4+1NeN+EgJCEti/BBdxZeP+pwFT2JGOAcF4T5BEfqaTpmEyAS9nsu2sDx2yakS+wwadErE0ush+EtSNjrL+FTFmIX/iaEST4ICKkhEZ4tigjHTd9dM85W1h19aejSD5T8739aoYg+LzrfLwa5sjZ/8TzaCuc4Wtsi2SFDSZs/U+h+h/mgS0ViEEgH4iRJUdBsKoyq6VBbibTf2TtTJNSN1cCtjBB6/EU12WEcO+2HjlWkEF+72w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?C/RmGgX+0gsESoKiRIrvCBqOO15Jy13TX12wSdHTBhR+Kx4XLa8Oanc7Dt?=
 =?iso-8859-1?Q?nrzG+KCU7gMdemF8I0qpO5Ve5sjqeXIIBuAUfU19U9ZLwkv88KO7BrqTPn?=
 =?iso-8859-1?Q?X3hdT4U47OaK6gyyTeBHbSWPOl7yviLrgC2Pmm8dqW3sKVOQrizD9U7t5a?=
 =?iso-8859-1?Q?WhN28i60TUyLTBJTj/cYPd2aXVuhrjP8yKa5cfifTo4WtUM2uw2sK+z8g8?=
 =?iso-8859-1?Q?En+klg4CC+G4UOt43dbNvUA8XrgRrbh+16S1x0liwEvjm9IOINdcVZgmwa?=
 =?iso-8859-1?Q?gGNXP+3ZdPPsxjCCR5Gu6DRcl3WeIL+P2FoV+Q6BlBusA6pg/U2hUT1HkT?=
 =?iso-8859-1?Q?iqqFoN6HhIKBWAC9a7mP+yZEkkrgYsQlQ+xjd5lFwNyVVITxfjYomtQkq+?=
 =?iso-8859-1?Q?Xew6ea5427nBATBdHRLu8pz8OofM9XOicDZr+EURijGuAsMSphXYd1dAeb?=
 =?iso-8859-1?Q?VCIZdRC1SECE+cN8fwJ+gBJupN20D2scacvPbMpWYA2dvluXu0NZ+cWvYL?=
 =?iso-8859-1?Q?LiGaSz1x/cUu26ECNJIeGdF2NNNHiSNNCIkdTQfrBCbOtL/7UwbvukQ4I0?=
 =?iso-8859-1?Q?QglHvv5dvuOIMUbXkSS4H7qyQNyOOEnJhlTpx+fecBWbZzY7isFBIzj2QH?=
 =?iso-8859-1?Q?JB4Kw6xZcVjN+AndNkb9dEg6j+OsGrtct384sZigfxWUIOz9UyrCkCaD6q?=
 =?iso-8859-1?Q?uiHvW98S/WZSoBTUs9buQ9xu4Z2wXl6wuf7QlOyBKP369uQNXjJn6JS5tl?=
 =?iso-8859-1?Q?Mwd8IRKhqs/ke9UJAd513VN8w8yx4KrdQdzz6tJQ3e+tctgmzbGpsO6x0T?=
 =?iso-8859-1?Q?Mgu3Y1JTYZJwi/iTSrWmr9441vJkk3alt8oRutspsbrXKOPKTOkQVhvYz9?=
 =?iso-8859-1?Q?e2E2sEaX9cIj+mhbmiNp/XfK16ZuuRBR8orWIs9G+rKKM7ofGWMl+09SEi?=
 =?iso-8859-1?Q?r9I6RJf5BfpaC6uarSRwNZKtAIwqHmTZQcWwARxhHCGT43i50Hx83SoZ9d?=
 =?iso-8859-1?Q?wiM5m9QEFS3f33Fmmd2R7xwQYRq/nCptKRkqZdAuPeYk81SMv8z4udzTtU?=
 =?iso-8859-1?Q?yu7LL8dt7pPdR3cq27lq2U4ZuwOPsJi2tn1XCPECYwN8vPCdBD/Sp58TWZ?=
 =?iso-8859-1?Q?4OSc+qj8/BZWD43nbUaApsJgfRJQzmfF4Y6ANiiov2Ck4xHAFS1PrW3LP9?=
 =?iso-8859-1?Q?ZuKWnS8RwLIn3XpKDeej7VGuIlXWfyIZOETWoz0gpjsOck9kxmuQqgzXQN?=
 =?iso-8859-1?Q?95MwhKLyo/MmLblp0MkmShgAHTs9jVRODUk2hcbd4srkN93dJY6A9jHgky?=
 =?iso-8859-1?Q?sM6bdJ3SDV/MEa0imJUhWHFcLsFAs7SqKVe10i6eux78yP54rd0X/ztSCP?=
 =?iso-8859-1?Q?4p3++IV3I5z1V6hedmAaOAfJXBxAm/SJUKJvxlHdQIg17OZecLgjJOHCmj?=
 =?iso-8859-1?Q?SxXgsStVN6C9PN1lKKZahPqHbYuYpKDmfVjzLP9dyqWH+rz1kpx83znoc9?=
 =?iso-8859-1?Q?hI2O+6/VmHXTu3V4PBEm5HAsdxCoVjzHgqjlE96kEVXIH8rJG9ymSBXz/E?=
 =?iso-8859-1?Q?wnxiMmrnYhWSYwHkX5ZEcXymjmvl0ztqR6Dog6q0ttEeQaupS5+lS1lRd3?=
 =?iso-8859-1?Q?Ca901MVr4fnqAUsVJhCjqn7IpxaIQIUg3LBUTUXeyB1s6xQ3PMALHIjw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j2De7VhoLEUG7nB7lWVEz7CeTgB/YHV4kw1c6naY5EFOWkVC/93CxUaFhB56o/Ar2QMue665Ua+eNo3YSZFJISKzxEcGPCivAGiyH0ASlPPDONbmdnUI4S6gwHb18D/IQOGBcZGNV0jq6737HHPVcLqz+PBEIlN+dKvM7vg70RkqwIQc65pP81PAoLeSn1KP32ZqXmx0Jb+lSaMqKefIjXJX2cL5p2as651RRhjahocbASNLyY1tMfKTPHn9bcDoX9Q3t/Lh6jlQ4dP24N3fuI2WHWHzaq6dvAP4wA6Sdip+yXRul259IvUcZ1fnR4opodE7aoIo83D/fTOBxDdhQ6XAq6Y4Q1c0xmZ0zUqfazhB0EToT7svKI7xl+6QIyLUMax//wshWaVF2xoNGSYtuhMKrrh0jDihSGA/NBliOAUFMH8L3XRflYGftzi06B14IRKW5XlsS8srVQtQ+Qtp3G8ph9T0GyTyuOrJu5T2WUWoPUBetdKWrnNnfCThi5J+Imcj8CRAs+oIksgSD6qX5Z4e82CsZ40cfO02m+9irotZl8YyO2J1s6G5ghHJDr6zwyWXsl3dz4vBdHqKm4sXTLwMMi+5K8ETFcxHIcoxNFuBU38gFpCjT0rp0M/WnMY+S2gm6MHmYr2n9ymjb5q1GHhq8M0iWHNyXoDVhyfSaEgS5IrmkiafayVpXm5rywDF4Ap5deIy7Yc5YO4r7RBuGqnrtOsceZwQwdHul4Mr3faLjc3QvjX3NgQvMgz9FIo6ejBaTt4TCo7R4ghk/irtfk8/tQ0d9EYee56RtNmOwRypfe+kCiSifLwz+mnJhki8xrktMsjjZuu/bQ3AdRkCos9+6TakfVDk1ywnHCMonjpDDpNy+w7xABW3fCdfAvzMszRDtYq1ADy7ZCwhY4eBow==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cce1989-d201-4721-62d9-08dad228fee5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:32.0350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I5CNUUWS1UxmdYqP4JzW49WZ7v92iaxbJD+Fxr5NJmPaCjCJ9KRlNSPxMgMf7N2O3N2X8nkfOZlXUHjSYpcC4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: x-Ff6NPBMnOx2aj5y4LmrWcA7Er89BtQ
X-Proofpoint-GUID: x-Ff6NPBMnOx2aj5y4LmrWcA7Er89BtQ
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

Use the vma iterator internally for __vma_adjust().  Avoid using the
maple tree interface directly for type safety.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h |  3 --
 mm/mmap.c          | 75 ++++++++--------------------------------------
 2 files changed, 13 insertions(+), 65 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2fa8aae4c4f2..3649acb9b0fb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2717,9 +2717,6 @@ extern struct vm_area_struct *copy_vma(struct vm_area=
_struct **,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
=20
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
-void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas);
-
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
 				    unsigned long start,
diff --git a/mm/mmap.c b/mm/mmap.c
index 0c194a2a568d..71e8e9cfd704 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -492,56 +492,6 @@ static void __vma_link_file(struct vm_area_struct *vma=
,
 	flush_dcache_mmap_unlock(mapping);
 }
=20
-/*
- * vma_mas_store() - Store a VMA in the maple tree.
- * @vma: The vm_area_struct
- * @mas: The maple state
- *
- * Efficient way to store a VMA in the maple tree when the @mas has alread=
y
- * walked to the correct location.
- *
- * Note: the end address is inclusive in the maple tree.
- */
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
-{
-	trace_vma_store(mas->tree, vma);
-	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
-	mas_store_prealloc(mas, vma);
-}
-
-/*
- * vma_mas_remove() - Remove a VMA from the maple tree.
- * @vma: The vm_area_struct
- * @mas: The maple state
- *
- * Efficient way to remove a VMA from the maple tree when the @mas has alr=
eady
- * been established and points to the correct location.
- * Note: the end address is inclusive in the maple tree.
- */
-void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
-{
-	trace_vma_mas_szero(mas->tree, vma->vm_start, vma->vm_end - 1);
-	mas->index =3D vma->vm_start;
-	mas->last =3D vma->vm_end - 1;
-	mas_store_prealloc(mas, NULL);
-}
-
-/*
- * vma_mas_szero() - Set a given range to zero.  Used when modifying a
- * vm_area_struct start or end.
- *
- * @mm: The struct_mm
- * @start: The start address to zero
- * @end: The end address to zero.
- */
-static inline void vma_mas_szero(struct ma_state *mas, unsigned long start=
,
-				unsigned long end)
-{
-	trace_vma_mas_szero(mas->tree, start, end - 1);
-	mas_set_range(mas, start, end - 1);
-	mas_store_prealloc(mas, NULL);
-}
-
 static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	VMA_ITERATOR(vmi, mm, 0);
@@ -701,7 +651,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
 	if (next && !insert) {
@@ -786,7 +736,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		}
 	}
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (vma_iter_prealloc(&vmi, vma))
 		return -ENOMEM;
=20
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
@@ -832,7 +782,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (start !=3D vma->vm_start) {
 		if ((vma->vm_start < start) &&
 		    (!insert || (insert->vm_end !=3D start))) {
-			vma_mas_szero(&mas, vma->vm_start, start);
+			vma_iter_clear(&vmi, vma->vm_start, start);
 			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
 		} else {
 			vma_changed =3D true;
@@ -842,8 +792,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (end !=3D vma->vm_end) {
 		if (vma->vm_end > end) {
 			if (!insert || (insert->vm_start !=3D end)) {
-				vma_mas_szero(&mas, end, vma->vm_end);
-				mas_reset(&mas);
+				vma_iter_clear(&vmi, end, vma->vm_end);
+				vma_iter_set(&vmi, vma->vm_end);
 				VM_WARN_ON(insert &&
 					   insert->vm_end < vma->vm_end);
 			}
@@ -854,13 +804,13 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (vma_changed)
-		vma_mas_store(vma, &mas);
+		vma_iter_store(&vmi, vma);
=20
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
-		vma_mas_store(next, &mas);
+		vma_iter_store(&vmi, next);
 	}
=20
 	if (file) {
@@ -880,8 +830,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		mas_reset(&mas);
-		vma_mas_store(insert, &mas);
+		vma_iter_store(&vmi, insert);
 		mm->map_count++;
 	}
=20
@@ -927,7 +876,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (insert && file)
 		uprobe_mmap(insert);
=20
-	mas_destroy(&mas);
+	vma_iter_free(&vmi);
 	validate_mm(mm);
=20
 	return 0;
@@ -2058,7 +2007,8 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end =3D address;
 				/* Overwrite old entry in mtree. */
-				vma_mas_store(vma, &mas);
+				mas_set_range(&mas, vma->vm_start, address - 1);
+				mas_store_prealloc(&mas, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
=20
@@ -2140,7 +2090,8 @@ int expand_downwards(struct vm_area_struct *vma, unsi=
gned long address)
 				vma->vm_start =3D address;
 				vma->vm_pgoff -=3D grow;
 				/* Overwrite old entry in mtree. */
-				vma_mas_store(vma, &mas);
+				mas_set_range(&mas, address, vma->vm_end - 1);
+				mas_store_prealloc(&mas, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
=20
--=20
2.35.1
