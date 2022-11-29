Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678CA63C568
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbiK2Qov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbiK2Qoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0271A391FA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:34 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGQ1w2012682;
        Tue, 29 Nov 2022 16:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=taTuMBdeCzrsJbclfSwuzOKHSTxTipNHacRm4Y2ejAw=;
 b=1hpbYzBm7SkOQ4l86esgEzgmxegjfSAvGkCOC0PJKaB9XaqKT6BFc4bSTnWKy+9yFhxk
 4MxOOlswyvJgQFov2AVwMIsulKG4zRCSnguXXGXOv0M183iZpmAF8cmBU+Q6/4P5V2TU
 mIzbmzzwVPyKWMnaF6TrqVOfrPQrEtTttwIF16L1BL7qtOZ+wfGYCVQNDRms0AgRM234
 utadTXxgt1HRp2CsN8U8Eg45X2Rmo8svW1MwP9bdRmb73Euk9CHd/20hAUmF0DRHaWLx
 wRd2BD8dXA7vq41B+JDRtBkMREZwiG3AoQOkZa73DfZ3TvtZLXRi+12r2Jyr01Q1M+q+ dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemdn83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATG7rBS030968;
        Tue, 29 Nov 2022 16:44:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398771pv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYjNEjvBf0AFuZbqWJc6jEDRg4uVgWyTH9EQdvph55Pl57/6bf4pLSNRVMqbORJjnAtyGiZvGW67Mg4INlKdCwkvN4pzvAdUtH+ASpNSCzusftbLVQXfMfmDCUM24E2U47y7bxy8wPFevKrQSeTWzN7ODWJ5KC01c9RBVOyGy42uJUEwkLFEom0nJ0fjkttc2MprKqgFI7GzDlqLRWJVE5eSz9lWdrd9fnD3ynQ9wKEbLmqoXaFtjs5cEx2hw2YC/5/wLDS/8E6GH/ZLRORaPuW/EQaebzxH8nn46YcYwIHOTVkh1BIU8wXaV25z5zOCYB2qsyCJHCqPxjtqQ9Z/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taTuMBdeCzrsJbclfSwuzOKHSTxTipNHacRm4Y2ejAw=;
 b=I64EikNDKc7G1Zh6dYdGeTzCJUCJeDDiHtKdG02CLi0r217BW6pmITd7U7RSrqn2M7eGyFYcWi4TdpuhPW45CL3QhyvT68Q8jKKU2LzbZzBq9uLvKtZARikD6evjSv/8asyTw+CQQdAfgIXfvi2OvGdOjHY3RkMb4juG0r/cggDCGJmc1iDYYiDRTjbkTo9aKU7lncPo+GJN9wpX0EImxWsaLxQ9cxw2rsc8y1g1aZvB05Y2Lat1rgK57KVgtut5kRjm2QfoXsQ9xtUMc2nAAwOoJAFVSLWb4qYvV318B34bTP6B9S90iJyKVVJs7XVs5AmuYZh5Ks+hixDPn96a+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taTuMBdeCzrsJbclfSwuzOKHSTxTipNHacRm4Y2ejAw=;
 b=UzzXLKNlpoRNStp/de4eXygLtF1EOBWh5wX+5MI6m9xb104UQ00XOuieWe5MyDQHTUs3CXXoNzdfGorn7ZToX8/0j0oxJhDUFnLmSI9Q6FVUqfQE3c80Y8BWD6lBKpGHdrz2BizhEAGSHSLsYcIIHSJN+AxGL4W0ZGWk3/RvCy8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:44:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 00/43] VMA type safety through VMA iterator
Thread-Topic: [PATCH 00/43] VMA type safety through VMA iterator
Thread-Index: AQHZBBHT7th0AJMxTE605yCVrxP9DQ==
Date:   Tue, 29 Nov 2022 16:44:19 +0000
Message-ID: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5321:EE_
x-ms-office365-filtering-correlation-id: 24c3e1ac-132b-4b1e-f081-08dad228f62d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGo9CgCQBBOo/XgQDi1TMO+7zVxWJU5QC1RbXXlpky2Tl61+k7xlOxjVo5KOqsDYecUJ2ZF6Ad/VYzPrCK/kQ7FfYWX3BaP3vX5gkEofQGi/1OdjiJDd+BIDFTdcQ21YLVgXlCsJDZzKpp/puXXP9eWgtVlHE5IgLt17JVAtVh8F2NIVe+Teuaxnkpgd5cU3/pG9iMyGAvtYqggd6X37Swp99X2mKUTUOB2KOwoUlI27BhGtlPIIHxBNOf9rt5d0cyToUL4wrLjzBIspD4YWUCK93mtZk0wNdAv07yi1yl4Kr/lldVQTsrM00l94hr7To+2Up8XEHU2Fxdh0h4naoh9BpnN+ev4jMojACE5C9/DFutOQdtBhHQAFvPOJD/JemiIJemamEe57uvliPsxM+V5h39m/TIsZlrI5YmDYKsDNmDVJP8By6jGJwnuOXcZ065gwJJwSb4NXKkit87162+99fov1GXRMOu6B3jZaVJ6LH4wpwhdCEwYdsT74nJVagUm/5Ef6hmg/k58rjHtl9XmwT/CSxpTHuQgrAgFlk/uDeoFfV/5DGHiYEyGKkytcsxzvwQ/n7PPc6qj8RE1jREf016WpcFULOaYZOeCAWrG2I4OGLW9EbEwN/NO8x6BnfUPaa9V4h6sl+09HcuJBaaj9ZyIKdo9J+lvAxbqpRVY0M1VuwSMqeP2h9VwsuZUGPFsFE3sMPsbwyxmSjgmCi+4m3VG5LuPkk3T28eete/c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(83380400001)(71200400001)(6506007)(107886003)(110136005)(966005)(6486002)(86362001)(36756003)(38070700005)(6512007)(38100700002)(122000001)(2616005)(26005)(1076003)(186003)(8936002)(5660300002)(66446008)(478600001)(44832011)(8676002)(66946007)(66556008)(64756008)(76116006)(66476007)(41300700001)(4326008)(2906002)(91956017)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6HUBFoLE2x4EUgsz+mI8X3wbgnihOypExglSFYXC0GG1hHJHB7x45nNhnz?=
 =?iso-8859-1?Q?AJj7WBvWgs+LlQs7mRozLKTGw9QRpcgltm0If0a/R50ENmDX4xkDLIuOVw?=
 =?iso-8859-1?Q?u4jcHipFWtKtNmOXPjsbXbnLD2o2dSfIVBwni7rTThrTiDAHKVaD3PZEws?=
 =?iso-8859-1?Q?ULtTP1Gkx1dZkf96WLbo9Yl4xIsmSEvv19NmC9y5LVEYPtTuANNwpjcnmH?=
 =?iso-8859-1?Q?BnXQx+G8MWTbLm4nG/be1iz7ywIf+ZxUyUEAOD973uttQtoyOgfP4ByzML?=
 =?iso-8859-1?Q?744L/tb+Y1c/s6lSe2UitiR9dTvXboOUWx/vtHrFzabfh4QPOeVw/vkPE4?=
 =?iso-8859-1?Q?7V4gwD+50T+mGP1hEtZWSgYiKPt0VdOLVtbWzxt3nc7XdEekcRl6vvurL4?=
 =?iso-8859-1?Q?HmROS54dVgi4HrYOBmXQQuXxBNkKvdmft1wD70S7EDxMtiafzv+fWpUBZJ?=
 =?iso-8859-1?Q?E/ZcDVKcGoIeeAlNAGav0YTEN9s7zNH/nH6FiRZkug6SPZz2FOOSk4va7G?=
 =?iso-8859-1?Q?DjnP7uD+BzycRP7FZsuPMemIlRsCrAC/LcN81Mk7hDl9nEtSkd/Dz1SuCx?=
 =?iso-8859-1?Q?tjsgJtKJT3wtk+JIchUAWrwgOBfvQqLhOUpckJ8PwgXOH4u3Q6t17ldubh?=
 =?iso-8859-1?Q?fXNJ5FS0pNGkFuLLId4MLROvMZiddx3EHjBLIWyCbd1plQyfqwqLkCJq0D?=
 =?iso-8859-1?Q?of988L0IW1a+od+GBWpRE7A3AMpUwCwubrz4vT8MTaIwyoi5hckOTb54h7?=
 =?iso-8859-1?Q?dFxDpjMUanu8kSD63eA58ZcdGaYDr45o96hmHTR1OLCfwfwNq+8/bkPQeO?=
 =?iso-8859-1?Q?RVZFSsd3MJXF6mQu8vJaTtqA/jkNfSxLVUqYOE6C8pspfE8/rs0zpRu0Lq?=
 =?iso-8859-1?Q?tfnxtn3j8AmXlbh0EfERrdTsAsLD/ZrPJ1otwTwZSkiBV2rBa60COiYgrj?=
 =?iso-8859-1?Q?8t1jUBBnbQhcOjP045NIbHFzdnUezdsjmS6ZZU0YJPN14qenwvMvXv5oW/?=
 =?iso-8859-1?Q?Zu7fV21fgdL+a0QllGE9jUVLzfOI+45Ho+duOArbvTnnB80ag3lQvIAl48?=
 =?iso-8859-1?Q?HnKnTWvD/6vu9yTglQLb5WPq4/q4mG83GJchycZ5XnIqzYq1hrTsGPQmKX?=
 =?iso-8859-1?Q?YTzrPyFGtTJLfnQEvcAKJmnLY97iuh1gUZZV5gjFP6jBWWhyQ6SlBj4cv6?=
 =?iso-8859-1?Q?JBg2r18Hix6uUQbvoMvbnrgcEsC0VIjY93Xc3ISU146H0NfEaZ9mJrEDSS?=
 =?iso-8859-1?Q?FdJpGU4QV/cuCKf7MQhi2GCquiWkFoODFfA7VcqELstpRrqj16S7eUWJ92?=
 =?iso-8859-1?Q?7lePHafdoQWnqqRHT4PJYG6IXepSOt9jSFPQQXH2ynCLqFIAdWFcUq4dJ1?=
 =?iso-8859-1?Q?Igf14u8QKbM8r1NntUwb4ncF2WtvJTMkXbeKMm1knUCv/fb9X5HDbWx93J?=
 =?iso-8859-1?Q?fsrv9GwFTaPhhwNxOOxKla5AQ+3//1jiYldlRS3kCO7GovFZroGvNgkP4o?=
 =?iso-8859-1?Q?rCu9g0RVLyOXbDELpP2X2BDbR1Mljgjg4bM4DzE0MlQGOxn7P2YieljOfJ?=
 =?iso-8859-1?Q?QnpfV8Tc9jb/Gq5vLl3Z1w2Y0saGDmrHP6OD9otL3nKFooe5qtQQNgHopL?=
 =?iso-8859-1?Q?qkoK48WjV9ak6QehvTd0zujMxeJCDxsmh8q6GOUvBpuwZbZHtgCx3ppw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /tt0F/v7c3WEFsTpbpviIyj59/xtKT59wUVCfnErSrIXaZ9vznpAMi1JQOSQPhyW4PSw6nTAbRyGN9QNgpwg0SB8K6mcdl4xXgZ8Wgs1H5R4SaXVLXPtrLCgD/hAH3LcZcKjo7ks6HlMOXQCm98ekbUnSeigyuaLkZtwf22MJ/PTejYirMaWBfkhWEtgO5C6sbK9ZAmX8GfMPD+nXEgbvpIQP4TQFPm8fTMAC5PvXW8NH2u+9OeNV8172J5BLLfra2NPq/6nAUSU0GI6TmOWedyLLIP6DoWgqBZgwkaHg05cZI3REdoCFSV8wSTG3Tqa+/XaKXYHgNMQTA2o5phQsNnjB9dhhwdUmwILoHX0gUq5xX/iPlsOYx0h4A2/dfOiN3a2zpobRqxOIS9Zy5p/oPNxihUZaHG153KYWGAMJbEp++/Z5ykt2kGn5f3P7Vi65C83tgn1NfPAY923yxbxViU4x7611nieQI5+tlmUGXfRwb3xKGY+mYOb6Dg+vqHm7edJAbFq6K4N4Dz9h1OyziPueHM85P5qSx0dZ9fIkJmORHXinPv0QQPeLkWQD7vDkDI4Bn59Va2AHVJGHd7hqk9leT64xlLdfrc/n4mKd75tSbTWVvie71rPasVQ7UpcPBITp0rKO4C/Oc0lKpkQKf4aDJhEvhBlqYnqKqcos8Qf4S3WrOmSHW8Avu3fCOOWPZ2DJIFtjyjcD/LR0hW3hMBO5iLL2G/5EQhbVkTj4jkY02ADosTMB7zt122kHAj+ingVPTPzWT+CnGJjAprm8OD0rwWFe0c2run2Sjm6fgBVAVZN5FiyV1Su9T6nZqaxIQDCFFptk/KtSweAvQ31fFm41WSYaOKu/Bk7rHDYqx1fHzeXGhw3al2NKZ8ldrd0bVsrDw3lSz4HmA0kkhmzew==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c3e1ac-132b-4b1e-f081-08dad228f62d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:19.6920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/ecNqALAs/5SJRddRaBUq+Rfn3U/Jo84PGP6jSXpkM8q9qglQBV2UmbXOYfT8Vj/DZp/nKlg/KLuK4utxX0sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: uYB9xlqoFcHSrNssFxGFbUuaCyGP-p1l
X-Proofpoint-GUID: uYB9xlqoFcHSrNssFxGFbUuaCyGP-p1l
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

These patches are for 6.2.

This patch set expands the VMA iterator API to provide type safety to
the VMA operations using the maple tree, as requested by Linus for 6.2
[1]

It also addresses another issue of usability brought up by Linus about
needing to modify the maple state within the loops.  The maple state is
has been replaced by the VMA iterator and the iterator is now modified
within the MM code so the caller should not need to worry about doing
the work themselves when tree modifications occur.

This brought up a potential inconsistency of the iterator state and what
the user expects, so the inconsistency is addressed to keep the vma
iterator safe for use after the looping over a VMA range.  This is
addressed in patch 3 and 4.

While cleaning up the state, the duplicate locking code introduced by
the maple tree has been address by abstracting it to two functions:
vma_prepare() and vma_complete().  These abstractions allowed for a much
simpler __vma_adjust(), which eventually leads to the removal of the
__vma_adjust() function by placing the logic into the vma_merge()
function itself.


1. https://lore.kernel.org/linux-mm/CAHk-=3Dwg9WQXBGkNdKD2bqocnN73rDswuWsav=
BB7T-tekykEn_A@mail.gmail.com/

Liam R. Howlett (43):
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
 mm/filemap.c               |    2 +-
 mm/internal.h              |   13 +
 mm/madvise.c               |   13 +-
 mm/mempolicy.c             |   25 +-
 mm/mlock.c                 |   57 +-
 mm/mmap.c                  | 1071 ++++++++++++++++++------------------
 mm/mprotect.c              |   47 +-
 mm/mremap.c                |   42 +-
 mm/rmap.c                  |    4 +-
 22 files changed, 862 insertions(+), 770 deletions(-)

--=20
2.35.1
