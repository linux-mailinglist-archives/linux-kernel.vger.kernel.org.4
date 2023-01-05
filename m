Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49BD65F436
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbjAETRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbjAETQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3621EDE82
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:15 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUNSa002761;
        Thu, 5 Jan 2023 19:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=D2mcWKAVukebEq7oYYVYGVxNeBUmJn8wuq7aGHCw3pI=;
 b=mGU+CQJ07YOV/bxCHr0y2oWSAUa+n3yyPTwgazIW0h57DoI5tRpoqXYSECAE6pDRFfl7
 E/6ibpHtlj3ED1NoKmuXdGpjqzAny2ECGFyDwjR4RiYhaK7E3Q6jOqm9zdmQAr2wCWGs
 9jVYi/SLpj8xgztoAih3fTVXDOnTUzYhUCMgEjONtiKKKK4gkl1YaZY0xPxTFPZW8QaF
 rfh0lJ/VnOpRUxBAGtoORbzqMOfr+Dk55y5DDXB9BormR7mSbrfZhxCO2PWiKi4l0rDC
 q7PaRqRHU6+eNWMVwcb/HJkTIcblGGBHfNha8pWYJo3pAeE+60WX3ACGFppMhKUyIFEA Ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp11q09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305Hvlpn023372;
        Thu, 5 Jan 2023 19:16:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6m1t-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8s2JG+6z5dlGWKYWxhiNmFEEEo7v/1zcThNJqwELk2GlknaSsGphMjIFGvWvEMuH0LAk6is3ap0d9bTx1Mjnz29Tk6vEf8rHnF/rFrbqQYOOdaja2OmBYtv1V1dW4tYP+2woH0eYMiVVyEs/7Xtb3lPoiifOJULYGGH7VK3ExTHG3plDYzgZkpvO4IbROaVn4Jhls1A3xAToZIklTQay8jCbyS423ok1syJFIyL6rhQlcoRQBOKiQ+42XEtqo4KnTfBuWWn/6UTVX0dYe/UuNadhQZcThb2sKF0aDKYaXFbL4HEIILnNTOIJ6a0M5s86DQL1HKloA1yRJRnL18+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2mcWKAVukebEq7oYYVYGVxNeBUmJn8wuq7aGHCw3pI=;
 b=l7bio04bdmEXZ0XPrslx7ijvRs+0IKpvU2d6QUjKvwIDcw5SXAxMOdlcpmd+nfFQRTcBNdTHp1b4xryX9iNvGz1dItVqzX/YB0IwxbH7h0jRzzihBoLIUZjwQu05UyswHhMZYBeRzxKGDbL15w32bquqEmEgpW7W+f7M0DFxQxVtGaPrzjaXeJ3X6ZfhD5sLirj9jwRQrgVPsplk3wF3WIAih5pgweGRbBKhSxkgUidovJWKfyCeN3fUOa8hqcP7A4JxuA3d44/UTvN3QKvGEhQYVeXE9aeZCD6SOs/uWF6j1qSBAJx8eDWzUo0DzNPr7pj7EbLaHf+BxO11HjvYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2mcWKAVukebEq7oYYVYGVxNeBUmJn8wuq7aGHCw3pI=;
 b=uj7TtgxaWEh7d7mp9SSjRJbwMQgobIqi69QXaWFxNV+vdwAMssmD/EDRAMNN2QRdye3X39JPwcKGo5t2VNBXefw1oL0Vg/gWREb8aJAEimMooG72r5YDShRG/h74CNoxuDDFJrfqcGXQPjD8h38iCJuSt4Sih8K/XySCRbtDhSE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:00 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 15/44] mm: Change mprotect_fixup to vma iterator
Thread-Topic: [PATCH v2 15/44] mm: Change mprotect_fixup to vma iterator
Thread-Index: AQHZITojC1aO2fk7xUeU8jhHjC9bew==
Date:   Thu, 5 Jan 2023 19:15:56 +0000
Message-ID: <20230105191517.3099082-16-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: b12dccd9-8e7d-45ac-2932-08daef5147c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mRZDTnTMviRjm9CzuAesFaPbTZc9LABtcaEb+BsgU92zQQ9aGZyofgBde78ReREap57IOGEamlkdfQ7+jPNpx6j77J5TmAi3I6z5X18CRVGCp9vGQ5uI59CwGOkyWGHOVqdhcXWBszKgQWEm8rh6PHt9f6jX0PuPLW4A/HLbb4XSiQUaBErR76PTHVxmMZ51/mQF5wjgHZQp4vx/zuUAFaUumHB33syPX+oAQ5ZaM99XZTt9y+mtzmjEhl+d6+bbUDx7sHp16mi28bRbHKlbTIQbFXee/HyjMMbr5AuRNI5iNtIHQBSCPSc6Q+dZnLqdybE26+qp5TdKfuafp+GTnMwO1eu508gK/XcAB4MxSNDxRI/jpjBcoY+DWMbfHFXKhKpq7cm50AmWrkwPN7J2IYYfcXq/Cyxq2SpbwyxtNdd56KxBnvN7fg33o6SkM+GSKf28uTm7FWh7i8No+ZmmiPrzROY8cMsSp0VvvITE0Rf53iZETHFVV4GbHIQFPxGMGOSpI6puyI09SGrJHLoRoeqqYdz0XdQQghdA5PIXqoqx7Ww9ct4qJhhYZu5pa/RY/GPHndJ5rlVIPbMBq/6J2AOwppJJr6/DowHAs5RNauto4+fCMLkVHyuMKo1Zdcbcc/VzJVBeO+NsZeP9XdetkaESnPnuKhM4Y6Qsk4+K78IaVd3sO9ApR32I3Q7AGhSW2LaJo6rryOqDlhAafxTcqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lpP0K/cloY9UCn6/6mZWFzq7h8xxv5BTIK7wKbzmvFnhSM6/FET+2RbJjb?=
 =?iso-8859-1?Q?H0QG3DjG6A/F53ziH/p5txT0wT0IfNIXFXsQUhiQBtSFhVmCCQNZYY5Yak?=
 =?iso-8859-1?Q?KLmZy+ljRuWy/xhpbFBsrVT+oarXj5/pO/p8ReO6TJpcY6yQuJBzeLlKQr?=
 =?iso-8859-1?Q?i8pt0KXl37fL1fPbwNFb9gk3tsGS8EtrZggjb/Uj9rXhnzyWnjdzrk2Uxs?=
 =?iso-8859-1?Q?crFGRfO1TbFAvLsMslmugTbKlGBbnATLV285rjHw4M6BDF7mooFC3M1gDh?=
 =?iso-8859-1?Q?rzhSgy0FkE6wCeWgveRNij5AxvoEzrSxzMcuX4ykRFex3pwJerg9XqnUj3?=
 =?iso-8859-1?Q?znnGQ2A1bjjKTXfF0O+otrASf5aFJ1VNNNy8qlyu6tYnGsSOzF3VCi2qHg?=
 =?iso-8859-1?Q?Q0btktBuQOZRfqCFZVTrOVz9oFUU0gpfQ1I5mph3U7jlefmOVSF1QXBhNZ?=
 =?iso-8859-1?Q?8/1O1Pn4l4ZEkbmAg5veycF2grEtCP5nKFRmw35cX5BywjKa1lEctydAT+?=
 =?iso-8859-1?Q?v3S1dX306WJZADP3B8KO/YbWk/OuxiM9CAm0A1YfljIa9Hlp8bZkWCjAyj?=
 =?iso-8859-1?Q?6mnfOI98Eq+pAB+CNi2Fvfbq/sLpV0wRshESRneFY3UyBqpCT6PcGi0stE?=
 =?iso-8859-1?Q?l4DVwAYHc2u1WtWiSccSPS8LFYK6QU7z6/bcytRXyBfKtpCEqbMGSlfrzn?=
 =?iso-8859-1?Q?ttDcEaZ5Y1JYr3IpJJmWb9oi4xbpR1OQC1o7xorog86dnAZ2lrlRhDiwjD?=
 =?iso-8859-1?Q?zq642t5wG0w19od/Qed5349mFo6Qrl4CfPoxwKMn9o77AXnRfpTejvpX03?=
 =?iso-8859-1?Q?Mybld8u5H9zBKsWLWGUR+QhERgvkTda34dIo4Ab+T9Fa63EtULaEID79Cg?=
 =?iso-8859-1?Q?lBIyWo+6YyhtauDqikldSOlhem6oNBeVdyipPGIoVKsoM5NWCzXgUipTVy?=
 =?iso-8859-1?Q?fvskSa/BV7otOwfPTqu678pQqWx4NuGKA+huWokXNfEgArEvboGCNP29Qn?=
 =?iso-8859-1?Q?hkoiSCvCS+t06P0bdK/cmrJxLcszyp09CHQZRA78b+DfLaFPqW/FCYD0oJ?=
 =?iso-8859-1?Q?Tq1FkCwlK99AmwUsuRuvwSS3CT804i4eMJqW1W7M05S/FxHdJa1EYQs1Dl?=
 =?iso-8859-1?Q?aJEoMWHYkd9grv78pnL/+/T/YfnN+g2hWXmCZFKD/iyZ0yFzytxaOeClx0?=
 =?iso-8859-1?Q?YSq8DuCyYRlyqpGDF6TV56qro+WK5rZJFnFsreAc00J0q1VCb/vy+CXa/8?=
 =?iso-8859-1?Q?KEHYzuHLZ/HKsa+aXYoU2bYn/LUiZFVaErEYLO9VJEeRvPVy2FbI9CsRLA?=
 =?iso-8859-1?Q?BVSJHJC9oLgXlKGYnICWPs4ggDX0EMoKSHylpMoJ6cF9WssWu98ye00nT+?=
 =?iso-8859-1?Q?W38GLjaVjTByngM/4TmqPp27G5U0v2DHdRLthf4PY0NaW1sYOu2fVMJLfV?=
 =?iso-8859-1?Q?1tMJ4aTAHW5qyCBlUbs5ZOOiM9Fo6Le2q8TCpL0OqXbdhsdeJ+QWI04nuY?=
 =?iso-8859-1?Q?pnYM1mvUKiOtjcpERlj0F2Efamw5kGTTo/Y+UJZcVAA2RbsRMV+wWZxTM4?=
 =?iso-8859-1?Q?yp5uaReHqDMKmnvlXWrgCEW3r0CGyqTABmKxZn8RKHLNrBC0qwhfkj1vpj?=
 =?iso-8859-1?Q?BZH2rB91IrIBcuOothTWdVZ046GBEd8DbyEbIwh3i0AnLgiqOpxzqNmA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6bd7hqwChbmwzbfk4GRigRWACnyt6bqvhaNDIQXli5BOYk2bWYe6bubHOIqtDuuD00mBC0ZQy2eoLqAa/BGX0EckJbYMNCrnDft2UIDX0KE91d19eg/U7JMUFDQglj4eWNeyvlfvn53WJXMsEENdGUvVeINE2c+ZpPwytN7IGsdyYsKOOPHCzqc7DbI/Y28yUGUao2P2oFUMXD869sytigniuvbSK1PXu6IVrDljHgP+x4GL8+5rrFHKVgHVTGr5SgqlCZy2bMFtSt9XksClf87Wk1m26Dvhi6oS19XN83yBUOLTkqPDkeoxzw4opfex57QGIuBdWF8HZZf4OQtYEHrVQo/JWYkZyNB7eX33N1bZwPSTZ7QcX/lTn+aLluYV53WkydT5oqcYsi89CAZ/MOEMH9jwdfrwiWUzRuDBd6gmoitXoZnEsz3MHEE47l1CJD1Vu0k6Oezvtl9efDqJEBJj4DJOkdC0OmYOjpGdVQp77JDBPBERAowdACUC8DkYhXLmTgla2G65KEy15Dz4T+5pTVlm/+WCjXGymUrObMMF+W0D5bzZbNqI3uuRK0/2sAyejSGxSKYRUR2yx7C/HTvI539bVLV7+H+ckH/bEZyW/7i+El4S1Dbec0s1/eVIKeOk17Qs3qCMvvv/Hx4ntpHL9DxNcts/6s980bIPU+RgPGlDEGBOT3kEf8kjljk48QclKFb3OnHuQPnTfcaWYzgVoOg/0EvS18FHK1bj7BGIbcewPpHriSoCbRozCzz2fr8dJw5Cf4mGlmoESturLIiYzY6iJX+g/NDToUyxALmI6UN7nPFszvY1HGKr/JAOYvIMPa92yglfw/SrYy9Wh/wqMhsuKZ0ih9NKOoOvswwdhi+P2TxaIJRkbeGdh3QCtSPOd8Px4xhIodlfTHa4hw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12dccd9-8e7d-45ac-2932-08daef5147c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:56.9381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4sPXSMp4j9M2VwQywQWH1buCcAkjpQ9zJ0Bm8HBpbup8pgpc6+rOEWwuMI4TThIwreYQJ3ykTzDn0CUoGQTpaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: mGauV3OtX3pt1Yd3qMPMU05B59AftB8h
X-Proofpoint-ORIG-GUID: mGauV3OtX3pt1Yd3qMPMU05B59AftB8h
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
index ab913243a367..b98647eeae9f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -758,6 +758,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	unsigned long stack_expand;
 	unsigned long rlim_stack;
 	struct mmu_gather tlb;
+	struct vma_iterator vmi;
=20
 #ifdef CONFIG_STACK_GROWSUP
 	/* Limit stack size */
@@ -812,8 +813,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
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
index 9c790c88f691..98c91a25d257 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2188,9 +2188,9 @@ extern unsigned long change_protection(struct mmu_gat=
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
index 908df12caa26..7e6cb2165000 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -548,9 +548,9 @@ static const struct mm_walk_ops prot_none_walk_ops =3D =
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
@@ -605,7 +605,7 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_s=
truct *vma,
 	 * First try to merge with previous and/or next vma.
 	 */
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*pprev =3D vma_merge(mm, *pprev, start, end, newflags,
+	*pprev =3D vmi_vma_merge(vmi, mm, *pprev, start, end, newflags,
 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*pprev) {
@@ -617,13 +617,13 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area=
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
@@ -672,7 +672,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
 	struct mmu_gather tlb;
-	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
+	struct vma_iterator vmi;
=20
 	start =3D untagged_addr(start);
=20
@@ -704,8 +704,8 @@ static int do_mprotect_pkey(unsigned long start, size_t=
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
@@ -728,18 +728,22 @@ static int do_mprotect_pkey(unsigned long start, size=
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
@@ -782,25 +786,18 @@ static int do_mprotect_pkey(unsigned long start, size=
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
