Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5355662BDB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjAIQ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjAIQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:56:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CED3AB36
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:55:57 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309GpPgW032528;
        Mon, 9 Jan 2023 16:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=nZlpcmEzdnTbt5gCGG2O2UDCUcNsLrGalRmve0Qc7LI=;
 b=KOypUgxYiSZ7jVwGn+P6GT/qDxyJfG2kkt70QO98u00qymiMv+dbu4XF51TT7ZWOWKHf
 b7Y13APktRXMcpEQicQfqnCGQZgXnFCylG7mr/EZxMT85+Oa12l9UjU7Y7AK3qDLKp46
 T0Zn98CePj8aMtjt4p9yg03A+W3Gf95yEENPUy3IovFNSe/J71QB56XE6TbcshtEZDbb
 IOw3VEpj0dDh2kfr1bBnMY4KiRu4EqJPIa6p6n5uyERSVvv5TuLbaTtDiM7kxvgCDTxi
 SQSsdR4B8Dcspk+PLU7l/T2MHLcIPzoDFUAJ3EcIdwCn2MsBx99tqCzKasYX0KyFX5o8 +A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mydxmagys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 16:55:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309GqnWf002376;
        Mon, 9 Jan 2023 16:55:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy648ww6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 16:55:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCe81AN0D6XlBSUjqrYnPiBsvZsrahIbMNJ2xHrxnqewjwHTo1Lm93Mq4wCA8NkMFVZX3hTXbT9N/DGV+MS5eUXJK8e5aqb3K963PprediNiCMSSTQI0H+lAx4aD0Fu14YrC3QrQRrRYqaeKzB3jdu1tOVuVnSdlw0rNStuBgXyLPSzfgIHTQe28TVA37VQANA08Einqb87OX/FxRkNhdP6K90minm0uiAUYst4En1YhsmX6hgwRd5jmRqltNK8Mp3f2HdtGQWqdiX2GJYXa+bmpnAHF6Q3FTlncls/GLAUbJ0beop3yi0itmj3mvT5SYMZJEnOebF9VEHCMN1x8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZlpcmEzdnTbt5gCGG2O2UDCUcNsLrGalRmve0Qc7LI=;
 b=CvFUY1GL6Ug9CFn0U/zqo71zM1g4DSvpeDF5SUAbbrqiLEKI1/DA/smismjwd2OaSkawEi4kDBZkWsJvOUjzeXFODO86W1CyEdejBJPJ/Zsi0qfcWn+o4J9lKQrPTeAEhmp7XPh+j6hanBYcLEkaBuPSFMjJU6+mgZDTsL6sF/HHvP2GreXRCuuRM22yCy1MQjkk8s6QgoPLod73MbW5e2o0tzAsOKy6B09cKllKOVOQe5fFw5Jif/GHWp9HQpX38vk1mkMg0mrmwIQssnef4vf+TU0xMavlKI0NEz5WRON9qMkvEur6HD0jwoBNTX0O0g5wefsBVL3lRnSRrfQRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZlpcmEzdnTbt5gCGG2O2UDCUcNsLrGalRmve0Qc7LI=;
 b=ac/nvZ2uwlo4U58HKTS/UM4rS3IdPEdfVHQbrstudVpSst/1lCwWyWLAhvNtllCYgPmDC7EoOCgshyVc8O1KwfJkRZE2Al8RLeBnEzWl/1dMsdMy/qU+mQAvptRC1a9KtPIVxs/k2emSoIzr3ZOFfJF+r2aTaTxpIaAJXg6TTho=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6306.namprd10.prod.outlook.com (2603:10b6:806:272::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Mon, 9 Jan
 2023 16:55:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Mon, 9 Jan 2023
 16:55:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH] maple_tree: Fix handle of invalidated state in
 mas_wr_store_setup()
Thread-Topic: [PATCH] maple_tree: Fix handle of invalidated state in
 mas_wr_store_setup()
Thread-Index: AQHZJEs16LTgU8asl06B/cuTn0zvJw==
Date:   Mon, 9 Jan 2023 16:55:42 +0000
Message-ID: <20230109165455.647400-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SN7PR10MB6306:EE_
x-ms-office365-filtering-correlation-id: 1e10343e-096c-4844-85b9-08daf2625836
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5vrdtz6E4rAl85dlOi6gtcSoQoU/5cNU1XhWLPoTluieuMsGERQYnYR8+wUiMs2RlY4kSlT7RXLzbOiiFlG5/yNkw1xrUfmXnJY+krMHUcELPDLxhaiaHZDoEajIzuUC+AcZoa5vubhDBxOJHuQ8fNh7L2N/OgOlKqY9c0uJPX2wktUrUFXTcEmnflVE/zwQ28otO/GCzfNi19WfT5kdXL379e6jPcB2c5NNV9Xiss2IOVu7TirMG35bLfrrwdC9xQOqxfTfSrog6tjoIL4iLsdptbfMItkNVBxVbydiEfwH6rAbt9n2Vj63re6uL393L+9GpMpBKGRV93gAT04WEWn5koyWnLfo+2IK0MyQxPDpf358L7EI4rngK4Ugq8XKZiyrmZMFd0uWMfIT9N/lF8omIZbxp40eCHna8Lrz2f0tfhsC8SpwaPMZrn01UzEt/5oevSTE6lVzf0sWxcQ9n+Ok+NCk80wIfz4Jei6/aZY0UcBaTB9R4EQA3b8Gw689weBRyh4X1NBxMNNteB9LeiBnUfj3pfGjGR1xT4MwkgHjrdYmZSH18Ye4kqKDBDUZk4qDgDdOUlXHrQgibTI78ptDbtKan42jy36dAdGpGlYDLjokfqbOnk5Vy5vGq+5ZK1GXK/IFrrp8rBvshHbbcFAQ4xmV/Yn6+SMPxsZuVl1ceMNqwi3UD/yb08JIFYGInJmPKiCnS2f0OnEnFa3Zum8FrHcknNwnNOp0kf21SE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(86362001)(54906003)(110136005)(478600001)(6486002)(966005)(316002)(38070700005)(36756003)(38100700002)(122000001)(83380400001)(2616005)(1076003)(6506007)(6512007)(186003)(26005)(5660300002)(66446008)(2906002)(4744005)(64756008)(44832011)(71200400001)(8676002)(41300700001)(91956017)(66556008)(4326008)(66476007)(8936002)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6r4+7PLZPaE/plJDFcC2IcNJmFiuj/lGFjE50xWTI7lOZAKNZIW1l71Wmc?=
 =?iso-8859-1?Q?peDJOFf4qtaWCaoAUanzkdzYryc0tZvF9ocoGMplep1gamIfM98mNWMHrN?=
 =?iso-8859-1?Q?33kcC3/GyJg4IlGqNPK8478mVg4IWvf8eI3TiSe+/2BLbkRiJHeSjt3N4V?=
 =?iso-8859-1?Q?2CqQLvliRmbKcM6HfjD0t6zhWVbVhSCqebD+lguDwBeaFnzSfhyJtd8C2L?=
 =?iso-8859-1?Q?PLC1cu5L02i+imz+SZ9ws90UZ/sY5nl2PDWpW1GAksxSiy1jaud6oV6Q4x?=
 =?iso-8859-1?Q?MqB1wTFN2A0XdjRtBflPTLzNOPAMGsQnWf7BfA3eomySyY2WK4Y4pQEYwM?=
 =?iso-8859-1?Q?WirEmDeaN/2lXkjb8SAatEEJdhM59WPzOJlNXiop00//GyvUt2awr3VIP8?=
 =?iso-8859-1?Q?weQ8tbgGRe3P1xj0Dz/cG10IPJinM8f7dQfP4wUFWFFqVr8bcZ+zzTeKOx?=
 =?iso-8859-1?Q?0Y7wJCXgRXzgU5ykSQ0kcbvyDY16PDA3dwZsm/eo33F0szsnvk0tTutG65?=
 =?iso-8859-1?Q?XA9DrfDiTsqiY1xXLgeOz1CxJnV4gTAzlNBN25JhOwX1RzyJsUrPn2yP9N?=
 =?iso-8859-1?Q?+Lf43x9d0gh5JYpXlql4xLpPZP4iBPs7LfEcHpl9R9cmAhDnxmxa2fMqNL?=
 =?iso-8859-1?Q?X4EpVqjXNc27eaN9uw3lYCH1DJr6SKzrYpyj56cUuXk2uXh10m3ND+i5m4?=
 =?iso-8859-1?Q?dHxOLBeuROgU6BC/GZxXSjt3hlzG69T7k7gD2xgxezhKerWJUcREoBlrUS?=
 =?iso-8859-1?Q?GlWlc1Y9XHfWJtNDhPU77ekrYlh6d/nX8xi2Sy5wnLtkxIYKFvpzDBzK7/?=
 =?iso-8859-1?Q?Ltl7GJMynstWDfqzg5vKuan+uZeykYb/RkpTKzQ2xyzxkDZlK/gHE3fAaE?=
 =?iso-8859-1?Q?YykPElngF5gbrTxPR+NfXaEvM/G/rw9Y16pPi3rq5wkdPbNRfv8WTd/YY0?=
 =?iso-8859-1?Q?8pvqW08O8wQzyEe1jD/wV3DkjoZ8QBb+ySFhXKFUGn8x8WPlmc2B02Gman?=
 =?iso-8859-1?Q?E9d/ujZ7qUSGRn/r0NC0d8GNdI2otsMhMj5VDK9lOSeuGUVerpW7Y6JB5R?=
 =?iso-8859-1?Q?/ks2CZ2GDsS33uYku5BS2P17bi8DWXjab6jUwunQG/0CrXXoW4hCVtpz5r?=
 =?iso-8859-1?Q?TQcY3iIeqaZ41M2fF4NJssSUlc8Jh9sgnEWPA2ch6lNBveiTUDMIjUdhDK?=
 =?iso-8859-1?Q?ttx6xCxvuevhq/F/YaEOBbBlsNnV6WjcRaxfS83nb3zekK0vV5JYMR/0rc?=
 =?iso-8859-1?Q?WI2NwHtsa/ReXhaBLL+n8aPjRhX15GjK4dzYLRLzaWTqKsTg8EwN4YNPiq?=
 =?iso-8859-1?Q?lzcKm9H9K/djcWBn/rmxhFll5ZduM61ErZPtOz0FztuMdpX5b/pmGTcWjX?=
 =?iso-8859-1?Q?kTZGSEFfVCPC0qvcc+tSC0riD7gd/mkYeydEpoX4g0xqaaxvIu24FUF34S?=
 =?iso-8859-1?Q?3dNKN4PnO5104Yfmvx6kHJJAXt3nJ247QAX5H/EPvlYnJK9QvtxwW19BDt?=
 =?iso-8859-1?Q?ScuYzZZNty+SAvIrr6DdQ2bZFnYwSo5XcKAPgTrHHXO1WvZEOofIUF8qTi?=
 =?iso-8859-1?Q?Uq57QNCoxlLW+/u9ACYkD9/AC1w4ixcxkAIaKMfCIbLmuTpkXFhi10q0my?=
 =?iso-8859-1?Q?xfhXCRHf+NsAncIGfVXJRKlrfeN7jjJEcuP4rG6O/VvOh6VYs13jVzPw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZtRzQMHSaNT6g5Np053XhpStu7QvJkbChqq0Mf/7EnTDQTxpD168pPUhOFoPlVZp/gbsDOnKbiJCJL59sAKwKrQ7mphn/uvCwZavFmZ8TGZaK1TcEk4HztSuS3Cgw8ogbJRN9WEqurkpgnrAAQ3YppH2gYTdy5sXk64YqaRjcb4iUZ0kXmUQtmVK3N9wkurAZnxN1OvApdGVgD5MIna4QOO28jufT5dq6+CHC7biK1yQsntfsLGOoVuDPDlXJMXiXKln69cP+ksYiXvFrVehHrVx28QOzfu7C/7VEEtI/ltynbYdT0yZ9t9Wysgm52lzyNVUHjxAc0EVkI/OwHgjofEZ0nNXbicE3FenxEHGIxGDO65AYLFPs20/Uygx9OlBoHrrY6B10Xpxa6AW1/JchEqbOzzCafiqGgINeuv6t3HbBmrmkVNLpLEiNB7UgGN+ZyflfhmsL9HVTcqHzPRgRnMpBZc0H9ipG2+mFXEbVizuMYnlX9T4rNXACkZRCnTkmoBj7mW2gBKteGA/M6AIFv1kV+Wl7lFX+FpqogoUSrCsP7tXM9YXGhvuFiPxHBnFBedXfGnsDE3gXJvRz+yuVkaXYPormp9VksJZonvPrpgeqoTCX8o6A/PGei5M0xLs37LOGnZqRFP15xMCy6FfbQj0TEeW1E3JSMOMCQQ+KcndRBXEq90Rr+8nFqIrJj7cN3idzwa3JdPzHUpyGLpcswxXnfeTTyJNWbMi3s7euHwMpqgU132LI4aIvL9+7kmKUNYpil4G17c7a/+ozaaPK/Vhu0pDOdw3POoGKMfN5VnHm6eb3Enlz7KtynRbkiKR0zFdG8alNCmA4pICfnk8XZAIEZwLuhjzduvBrB8CgGeyc5jRowHwOKefSgVHOkuIj9I2KTSCo3/Ch0JjFpbzFw9tFNQBUyxhGJjhqFQMD34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e10343e-096c-4844-85b9-08daf2625836
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 16:55:42.6406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycXn0bLxpIohKemL+uLNJ9T3U04XjBHv8ECBG3WWZmtICZfEYKEtWS7PUWiA98avlYKV/tCTrThCzH6DHZeLag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_10,2023-01-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090122
X-Proofpoint-ORIG-GUID: 2EUb_7UCI0v6k3Qp0dVrR4zjEuqRVFBr
X-Proofpoint-GUID: 2EUb_7UCI0v6k3Qp0dVrR4zjEuqRVFBr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an invalidated maple state is encountered during write, reset the
maple state to MAS_START.  This will result in a re-walk of the tree to
the correct location for the write.

Link: https://lore.kernel.org/all/20230107020126.1627-1-sj@kernel.org/
Reported-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 14cff87cf058..59c4879ac714 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5620,6 +5620,9 @@ static inline void mte_destroy_walk(struct maple_enod=
e *enode,
=20
 static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 {
+	if (unlikely(mas_is_paused(wr_mas->mas)))
+		mas_reset(wr_mas->mas);
+
 	if (!mas_is_start(wr_mas->mas)) {
 		if (mas_is_none(wr_mas->mas)) {
 			mas_reset(wr_mas->mas);
--=20
2.35.1
