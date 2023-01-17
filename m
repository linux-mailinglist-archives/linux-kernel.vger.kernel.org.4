Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FE766D453
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbjAQCen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbjAQCeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA16252A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:22 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H0901T000915;
        Tue, 17 Jan 2023 02:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AXHRmex9kN1yB2UuFyS7ra5T5N+f1/L6yN09mI+0khE=;
 b=DWgGXkqkIAqVZMrFUv2QKzWJFRHmL2CvDhg2kZmGSyy04dVhHI4vXt+1p0SjpGpLgb/L
 /LdimUB/PlerYWh0IRV8Toe5IaWmjX2GARaR+QQHa+phkeCvMSnbCFtSMk6Neu9ekL9Z
 oRd2RKy64BLx4IIuYgPgieOVLmyCeagOGXxSz8FoJC4GFYXEASvpSXtiqYILlMGNHAo0
 TemK0QH0FS5QOD4udzApk+ntyFNEyXLriXKK0AawBTVMYbeBxJUFNY4eBnvT6YmSzLH3
 Cr93bsFIdwsf9RpU54AzdCz6NW3iOxAm80qmfZVPpp1HvNr0Vhn2W1/9OXb0YbjnQzvx zA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medbqb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMM4rY028480;
        Tue, 17 Jan 2023 02:34:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfxkx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQQLW4ZxOzV/vQjxeJxxS3ckPgrJCdKkN+iBulh5o4UiaHLxPby3j/0bgfrpg1VfcjzPzEXwKr8XgRPjVAwPUYRZwIGRum0kmHuDWejxh4TGe6d3fZaXIbIUQUdfCLWwuH5Yb8e8GOZKT9NRb9VnDgJO2EnjgyHeX/0AHNjXSuxzqfVOgK2FhgwCCiZxbhto/mF4fVOKtllBfpSTYj3TdxAvUrMugcw1A3/P16NfKKpFcId/+Tq9AcBfFB5YtQ2/joUySAkYecp9Iu2p5ggECVTejPnWcGksO16t29swR4jSOPVXp9sIf+wGT2eBgKtzdTI4CupNzx3NUimwIO8PhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXHRmex9kN1yB2UuFyS7ra5T5N+f1/L6yN09mI+0khE=;
 b=XB/2tqyUZZe0xwrz/ToTkRnGVJgA1jnX1PzlgPUc3lyqsosC+CDursiAWKBHV/EBrJ3Tsu8SFpC9dByqMoIfIYLGZF8AfALpsJa6cKZfyOmUIv0VFx35xnFayMEkQ4rjm+HRY0m1O48zbWNKyfj+Rn0qJbvh/Gpz1dMgZhPPTsmbAjgP42TFW5+ja3brf2sl8HPPnvOeY1A3DzEnF/bc+kVyvtZiG1KXzqskGXUJf/1yxw+ibMGnHjyrMY/saoxHcCjIpNantHQBCFjRrVRjWGci4ijjDX0DWdKPPQEYxbuE+fiFakkv1v59vECwdLIMWzX6iYqPMlWZuKY5jWk/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXHRmex9kN1yB2UuFyS7ra5T5N+f1/L6yN09mI+0khE=;
 b=tplOauUWhLVNBfnke4wqlgEyTJyp9Y377KlBkVBWQgx1HQk8XXI57BWC6OyVAMRtWZgco3L87pI5pSESjJGjAh5FjZxggwYRcUclnml1ppGqfgKyKlzAxbKrCwTVQ8H3j0X/OIJimZiIGXEgAmeXMjW6HPIwInYFtZMNIO18s1k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 02/48] maple_tree: Fix potential rcu issue
Thread-Topic: [PATCH v3 02/48] maple_tree: Fix potential rcu issue
Thread-Index: AQHZKhwt5gpvfZOx6EWnczLg2I9GHA==
Date:   Tue, 17 Jan 2023 02:34:10 +0000
Message-ID: <20230117023335.1690727-3-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: dffc5300-e351-4e13-30ac-08daf833506a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j6FcDX2ZvLSSgaKCwRktVMHxi7qgyPo+FbsgMQUGpEEYLY3Tr7DnvbBWAjBOkW5eVJlZdMsSOohB0mor5+4FkeDxM7RSbOH5z8Izws6FWdt6InFF+AcXh7lSaqANL0OFKfTCkgA0rFaIdMJ3gXJ9sTki3aHHwl7TGGz0Vb5UDsEnI3BGJl2PDlhcmWg2Cdyp/uKBihC+STyz4XDtdzOLO8Y3cAqZ1qCSVLkC/dp2LqJKi16XMJitsEVIru+KW8JUu9WKHgAS0gQCIewBJXFwLA8pR1wqf7nWEr+rHDSgeM5Lhguj6TzIT1p6aPts6gEBawJiCQhlEW3JKK7JaQjKmRNeeHydjz7ew4Nx63p7wu4NLR4fDZuAm/5RH6Lafv1kECfJowWVjArvChn3z+Ms+qq1SGkZrJJo2GLeQ26qiGacs6Fytl4OlupYXtI1cY4nT0+HW/fuvg0uSeDbnt8IY9kG5yJdrBnjVpi0dPYYjX4wHP20C4iXEr+F07mXSDUiDngCMh2KwO+QRTAcoeMsaGoDLOwonoPkGHDpp0S69xVyuzJ72vhccir159YPGnvp0AaMMJ2rLoMYotgpCdOgnApKDCS7W4Y4yUxq5gpDifApduLmnFzAu6N1nZPAZrtVDpn/7vi3oxHR+F98AbRag9Sivr3sEF8YWPbBqf5fhNjQr2Qw7obbp4B5mVFosG/O3DdRdLVEOJaHmflGrlKYag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(4744005)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?chFiIb6SVrInD00ms7OmIPbLEp4CQIBvUDegsIbhNnZUAbwGC9LgDVXyLl?=
 =?iso-8859-1?Q?EOrLG3QNJYHbxy3CXPMy32Eynhwh3XWikFRafl5Fnxpg2sMSzrZBzFnd1Y?=
 =?iso-8859-1?Q?iHfXFbpVX0OlFtzmAfW9VcXRJ5YAxqwfmLIeVNaUueLiAOFfwwSdv0a0A+?=
 =?iso-8859-1?Q?qWlVgiXdtC+Z+GNzMjoIdqj889Ke2m0n7D4wte+YWPBJA0Qr0F2HMcUTSl?=
 =?iso-8859-1?Q?7ytK8rC884M1tslkEBvQ7P+3RJiVz6EyexKXI5c6JIw1r1VUuSjfREe91u?=
 =?iso-8859-1?Q?tleHTY7kGXW7xIpzrVrsoPMrnfIgdAlgR7PsbmKI/OFKXz9zI3Hv/5KEwk?=
 =?iso-8859-1?Q?OhCecv43OM3X4Wks0Z8FgxqBnVQWocL3B7ithnSFZoxXJuJ0NnSl8Slyzp?=
 =?iso-8859-1?Q?vG4/vrkAyS6zPvCBZyT4i3vht5tu1SZloVJfiCYwGc8EouRpQV5pWoTHaV?=
 =?iso-8859-1?Q?vV4RJhpNrrdoSFfSLT3MzkIFq9PwWo9K7egztbsWUie6hw2OPMsiH7/2K4?=
 =?iso-8859-1?Q?ZeniyuZIB8E6FwxAWI3Sp6rOYSf8lMqHhIz9j3vUfbjVLenYUHeII2IIs0?=
 =?iso-8859-1?Q?MX6AXAty3uqxs8j0/a56owexUrdrgZs8CiLUUpVV2OjwGn3UFGjP10fA86?=
 =?iso-8859-1?Q?XqSDa/FboxXAqzE40UMNU7VaxLm4BeApTS9b3sCEP018RKUbfnj0DZZ051?=
 =?iso-8859-1?Q?XGKVCluLEZ1bnqVWe+SnnEGnUgV8PAbTkolJdVoMnStMvhhAxkZDDVx4td?=
 =?iso-8859-1?Q?r8DuUXF148rVuNMtXLjY9G66G2JWdAkuGTKhnI5GITdw4YH1jf7Q2FqteR?=
 =?iso-8859-1?Q?W2mavNj48gAkoeTu1xBSdD/VqEQtXaEKiigXJhMHqXQb9YlEI0igB01Zww?=
 =?iso-8859-1?Q?RXo+x80mgnbYQ7EBHEXuDAwWqSbms8BE5F6raIbxkGUTd/aJpwTYGaCL3+?=
 =?iso-8859-1?Q?YRk9LCGy6Xxb5Yw1a2AuNcY43ihH0bb8SRiJSRDWnuy4pH/60ypmpRtMyT?=
 =?iso-8859-1?Q?yncDXWl9xpooWCPecAaIlRE1h8lqqtqwpBQM7O/A0E+L38pCnlaVAA/FKp?=
 =?iso-8859-1?Q?8pG3jbVRBZdUFJTH0wDBBSehXUXe2PcpXS72fjD7dlhAz8jlgDRhwqVrVB?=
 =?iso-8859-1?Q?j2ftgqVW9dFKsTWKp4t89N8O/KjAkmEqKqji551tSYkN0PU7B5B5Iwjtpc?=
 =?iso-8859-1?Q?emuZzY8c01jzoSRFvj+DlgLAKxB84vaE72jgT3Wl/gUVtseQslQHVdQnkB?=
 =?iso-8859-1?Q?jjzKQij1zwZU4XhuxNwrvzSD+M0yTIPivw3tkF3lrg2JxgQzKH6nQMCfpl?=
 =?iso-8859-1?Q?C6XWPKU0s2hatbU3gvED48JBtqY+HF1zdWji4qyJevqv+Efbp1KVnFm24u?=
 =?iso-8859-1?Q?6n2vNGyfW3DyOO7oAJ3atvH1qYLO1WeUrlvpX6AbrDRZfExstypoZSkpN4?=
 =?iso-8859-1?Q?tP7asBSAdWCNsdqIcX+BpteImG1UiY+cydIIRqhYViC0p3ARwYrk07jx/2?=
 =?iso-8859-1?Q?Kmwn756u+vLZyLjDctF2d8PYmJYSU89SwMrWr/jNb/md+t8famRLZbp2+H?=
 =?iso-8859-1?Q?q51k+c7mjwq4iRrirSQO7msp0fIvbW+OgAn/FquwRhqUkyTJbdCIofE60x?=
 =?iso-8859-1?Q?eQTAUznHZ/1ZldAKCWVQ6dR1uIhrfFYWwPbs1IEgwnt1b4sXiqrj9tuQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5hIlwpO2D4hLLuu4n0PhX0IyKHsyLYIq8TJWmjsLFs4CAUKqDYcizZiuW9O8+NbwBmWkRJC93K246DU2qwNhOhxDtu20AIAXHnEOvmRNLfGZGZPESEv3RrkRTq5iE29SX+DBQqckomxEFM7Id6tYwAQqiQgLVmNRU4DoarFoejdcT4fWee8cQt9nSoPzGlKQj7GGnBxFuNc27WqwnSmJQ2IS6/4Jwj2BFmH6UO4bwlrpPFqS+U5z3N9F7fkIzdc5d9S0g2x0KO08DiqhQTR3YNCrTz5sXGZ1s7QMNB0HfOqbjh1TiriYXfgyNU9OIUIZQKMlRx58O5AKjupFT3XKYcH3yppt27u39Kf52sFNZsC9nIU5alRIH3cDqSlSzPC3n0cD4Ct+7FBUZv6/+U5jDghcRfWZL1N3Ucl5gfs+Nc2DIb8vXV0nwoinMegvnGwbKMBmUj985J99/rE3YYX7ppw7SVVDnt0EvEfGYAYJAMaTp3/T5lJMnsdatYfXWwOxXQsGpKlhIEBl+4pJ8HUwgNdKWkPRSmYI5+HMX3IUISDTvb+vE1ftCUSoM8NMT4a4V70tyjd/v50p/duJ2KF+17UIBHqW6RAj0x8vMcyLEqO4aqIejcgN960QLlWdfzavY9vp597+ScpoQuJotClj9NwtrWyqEw9XWiOEoiRh0tAZLOI2jWiwFtFk+QNnTM3BKHl3zqObtmatjm8WolhNlR+hwQhyjHX1lYGi4xWqDuQYH0VEI7mPrFSsQS3NE0EY/ENcBw8fYgn0DJXCOYpAaulz499bzYeMEmee0g5vNSOTaFJ8hTRA/UEULlyC2cY0e98+DHA6pjLHs85SwnHiY5h+FtLkOek5ieNdVgvEztc1QFR1j40Vp2ovbCCvTApV0PRX07gj781R7ANnfewXkA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffc5300-e351-4e13-30ac-08daf833506a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:10.1253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GnIwSilBdzUAg6XmlQs3LKO2zw13P7vUohN5YBjZVfghXV4TVFXgl30DavgcOvBUt0HQlfhNxHtUKbVx1mjhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: uwJsNK3XVyMkU8TL1o2i-ghJm3J_CYy9
X-Proofpoint-GUID: uwJsNK3XVyMkU8TL1o2i-ghJm3J_CYy9
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

Ensure the node isn't dead after reading the node end.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b990ccea454e..c15e63ac6e93 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4661,13 +4661,13 @@ static inline void *mas_next_nentry(struct ma_state=
 *mas,
 	pivots =3D ma_pivots(node, type);
 	slots =3D ma_slots(node, type);
 	mas->index =3D mas_safe_min(mas, pivots, mas->offset);
+	count =3D ma_data_end(node, type, pivots, mas->max);
 	if (ma_dead_node(node))
 		return NULL;
=20
 	if (mas->index > max)
 		return NULL;
=20
-	count =3D ma_data_end(node, type, pivots, mas->max);
 	if (mas->offset > count)
 		return NULL;
=20
--=20
2.35.1
