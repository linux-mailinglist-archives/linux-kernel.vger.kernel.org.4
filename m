Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7433163C582
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiK2Qqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbiK2QpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:45:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2492A64561
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:47 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPqQV012398;
        Tue, 29 Nov 2022 16:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bhltz9kTcsgGhTlVX5M8hR0m0heTmi+4drVsBC/8924=;
 b=L0rVtcw7FQ9pG6Dj6sEUGT/HBuOo6grxYB4U/2owUdMNCzxlWdE8a0/tdGC88gkT/PO+
 kWt732wh9AvrmV2pSQYPg3o40qJB62DMhIQkYf76tyoIYXQKnzN211M88BvI5QA/FL8o
 Hh8G7dp4u79XHigeYhifCeUtuOt3G7Onced2LG/AfaQNpxgQfxyT1vYr05t9p1VWyHWV
 Fd34UAIRU+0kwuUCM9WNN9UqR3XVKidXMZUunMw5y34IaGrbFAxxDMBkfepC6lvVY2ga
 1xtYt+EQsezcTQTIBqVTiAUE5q/q31g6YVd8AQkIxol+04Hz61iTsYjMNFiuPtWfMSiF Mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemdna4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATGbKZT019412;
        Tue, 29 Nov 2022 16:44:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398dr60s-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7roZT3tNN15whU0b/CwSGVSBvHaj7+omC5kjh1uPWQLoIUIUYJGIwkPm/YRgK3/NIanJ71qXVH6GqkkP43bdO5quvxVFDZDRReuCVt4WxIAfJJd1nQTq5j8iC+TKL+tcRhoATvBEVQvu2mcYzunKSQBRjHar8jHyqt7KPs+P0nxFi+zLZSAgO2cwzafgPEsTwY9kv8E5z4iq6HdDDXctLXBh5pCGl0YHuWONYoirfMngZ0PrxTQOjabPbn8aWFEtSaut+gxJy4PXKwOwXYlNC2idf1lnL/+nvoX1ahY8L8x3UxoP2T+I24UtgucU37XkBimytYRdLUtMlUOPiV+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhltz9kTcsgGhTlVX5M8hR0m0heTmi+4drVsBC/8924=;
 b=jOS6MrCHofguXkXQXBKSk/v0trdj7LxZjeDQnAqIMeXiKV2c1Yvyud1K9+gfSuQyIusE3hRnc/iXXPaYEeVtDgosD/0M7qNHslzHv6gJLppf91IaCu1M/IpN7NUQUm4Li27nFmv6W+s2HeDIsdFibhfkm0013YvUqv1Q9PfuvHpzH55zMoILVqwtk9ANwaogeMOEXCv2fB7UZwzsob+N0cYCiwDSR1sfmljhqsFQ7R3zcyRk5yamAmZw/zTK6jFPBOeSvmLt3zFFml+i9wxnAJfNtT7s6MpR97k7kgTzfckqDAI0UxhPPO40wTOYrs/jRXmNTlHp7Bh94TAf28GoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhltz9kTcsgGhTlVX5M8hR0m0heTmi+4drVsBC/8924=;
 b=GgDU8bKZRc8AFFW/m+y2waOQLqsRj2vxV4OVHqo2TZprpWZLnbLWVVoukvIDr60war7T2YpN9PmkslXC0uFRiAiazF7I0tWwWJX8tn6Tan5LMZs7b53W1ZIxB7Dw1YOswcqBSDjYpeN/Xo2whdwSiaEBSBYDdvubFRUzknmg5gY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 29/43] mm: Remove unnecessary write to vma iterator in
 __vma_adjust()
Thread-Topic: [PATCH 29/43] mm: Remove unnecessary write to vma iterator in
 __vma_adjust()
Thread-Index: AQHZBBHb+o3SiDFJbU+aPJDX4tvC5g==
Date:   Tue, 29 Nov 2022 16:44:33 +0000
Message-ID: <20221129164352.3374638-30-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: de2a8555-e114-424c-b762-08dad228ffc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +XKaJdd1TtMo7ljwURqsQWs+WRY60Hg/X1dWFuZTVqrBV5KxrDvoRVLh6uz2Or+QO4nfyBfXNoAuGlnbyKKj6pb6e4+saU2OdOKVCqkonSUJRtqhlUqqhpx7kkMcTYoNOEbH7jFXRAtXbG4aAAna/ImgLcawl+xztyM5sEww/aZQZDsF1osWzSSIC2QncNfBvD566Kjqq/S0XcfzMCRXZJnnCie+bBsBCdqskc3cJbj3qq8cy7bxxTrGD2IclQcjaFOm3+Tuxpxns2ZinsS2bzrwqz2e5ISRZ28poGYl6nuKPd9RwzWtjPnObGgeYs9Vj348pqajZxg+zKmsr/4w5+ZcvtPEP1Z0jJAIvqPEYZKg8DHgqX1BKDC2uJx/D5mxssa3cMA36IyCPXAW3tmQ7bidXO2n9aJ5tOGhAZdOMq46i39bR2wekAnh/KJtf0TSi7icvCISt36V7OIMx8EOB6ktP1wqPvumk3aSghPB4kL7De3dCG5y810QMoFspNl855LNjwNaH/ikDVyIoHOJtVmDHE2jxcSwr7OGO3IPlggTr7r54hUp5rIzfCF285Xkqu01ijUjzQhV1YHno9qqEXyvv5e7ciPvhkQubS/QCkambR1o4BpoYbdrPw0oF5otPNaLyl5BEl6Ee5WVrR0SrmMMwIAiQ4I7Jd49d4RkIGd9Dh77nb4g92x+UdsvGpenGR5kIYo+2ZYPnoTrnYuNxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(4744005)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QH2gc1aTVICVcxneq7Ss4UX9JOLaen01AMdC0cx8YRcaoPjOaqdU0WjcSY?=
 =?iso-8859-1?Q?8phe4IjXT6T0uwXNXkoUwCdxiDdkgX3G6qsCRzcMtQc6FPXe/Ojb6tSON4?=
 =?iso-8859-1?Q?d2ftFbcMCOhxM+QjrqrxPR0IyX+CfOeYccNU4HeGKySGLc1AMt0m8/nQdA?=
 =?iso-8859-1?Q?IUf2y+GwkourNgKRAky6yv8OigMgVn/UyVk4Vdpf/LhPYwiXw1IfajmwxA?=
 =?iso-8859-1?Q?Pdyltyzx7m/3z4Kmt7aQvzttwD8UVXC/86tfC62gGJtUASp6nYbNkFOAzS?=
 =?iso-8859-1?Q?+ErSHQQj6Sub2+gjo0cCl3wH8IBI/EymZ1spLO77TDjRCUVLfSlz7d0OmX?=
 =?iso-8859-1?Q?UzDSR9TU660o8AEoqutYaRW4ak4a5VNBaPL6ZKHYRh5+zcHd7g0nJhe5Ch?=
 =?iso-8859-1?Q?ve0Ddvg0KA//153FnTAbGJNTSWtsHDN9LZmC/MFcFaBZwJ/+uqe4ZQBSa1?=
 =?iso-8859-1?Q?WaLcprIImVdqwUQ9rqNDKOPkag9vxvxjjkuwS22L8+lkDkWU5vDHiI1aNT?=
 =?iso-8859-1?Q?z/XSBXyjuDUHgYi9k+E1m8lYDsjDG3x+8W25AKrkZAslYg9cDu3fHySd7C?=
 =?iso-8859-1?Q?cZvIIi4ZMoVelj3xhYfDizMwksXrDpjD9+Z7YHelJzu5GcOlCchOdI0oqu?=
 =?iso-8859-1?Q?xp6cs77EZnAjePfFaktgHwaQevZGLXYaUZ07W5+6BU7QNmIhcqw+bwTMWY?=
 =?iso-8859-1?Q?GfYZKJOOQl1pop85U51gn7Ar6+ICIgx0g7nCTI6e6kePD2Qq9fnhInbsoE?=
 =?iso-8859-1?Q?6E9w4mV3YszFQx+nCW68x8ikueVUCIU/V7XDV/LKcDOq6dDrOjh7am1eUl?=
 =?iso-8859-1?Q?Q/vUVA8byE6Ywv0OmltTN3H6Xo28yhg5MkrT+r6BJ6cXz/5jeUdjA0sImB?=
 =?iso-8859-1?Q?dvdsxAYLQeNcBe+3JuTnr4+8iWYNDWlZlAnlsAHq4HaHCfeNVSrKYhMx7h?=
 =?iso-8859-1?Q?Hpr4Sv5HoPQtHQr6ao3Y1/A63Tak9USq4Fjy2RtoLtLatYvrxbvFKPTqWF?=
 =?iso-8859-1?Q?IeoAjWVslApvbgpg78ot6PWvPVAHPLolj+O7cMXozNdFh5TUCxlPu6LeZD?=
 =?iso-8859-1?Q?8DmbDzOaqvEmU7n74qOQrxHbTE+BL2J/ezibfLda31ytgU5tkYKicJ/tG8?=
 =?iso-8859-1?Q?nmZO2BlHpxWMWaP4paFA0+lX1ind7QJ0OrE0/pdGeWlvPiRu2nlGTiPG3+?=
 =?iso-8859-1?Q?8+tjn+3CF09wd1zVU2Yz1jYyO9l9b7u6tFMdASmunaqdf1fo+VlyoVowFl?=
 =?iso-8859-1?Q?mZ7mKlGhK4WHnqpNUKwB4Bt6v0e9oDPKWxTqVfIyN+INY9AkT/MPeMhFc2?=
 =?iso-8859-1?Q?oebY1l5lB/c9JAW8PKCsE3jQWaOB700CCrq/r6dghNRFyR29tQhSfyDH+/?=
 =?iso-8859-1?Q?cejugYIagBwgBJhMbqXjZnGLM/QDJ+iHXbd+g000Hd2yTlnEY/Py9BzwBH?=
 =?iso-8859-1?Q?BrjCFp/I6bRpbnNFos+et379PqDaz6JJBjWWANMauM/5icmVT1ad+kSvwZ?=
 =?iso-8859-1?Q?A55K6ZhWxypga1y5w8315sMyH+qq1o984FA90yR9cCkkkFMS5UWJDJm3/X?=
 =?iso-8859-1?Q?aBq4Bcp63hELj6XYwYhgB9LhmD6oznEPqhFl40cW5uxU7cmSiqTFN4bPjO?=
 =?iso-8859-1?Q?932wojZGMMrWOXOCb47yuA9FC7kWOwHL2zFzxfL5jWl0a+Yn3MOuKtqA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B4m/uV8kqBfddYKnPwXP1rmtiTbIKTe1og7vghOaYr8TwNKB9r5/v6DKcoUBs7f6mQCrm8sdBbvP1m7QZnyTGpeuTA8LOsg8UYFe9V+jtA+NS2ubXJFT21YcBEHniieIueIamOSHH3cPTwMvdQY3LSRuPHxPfEVNRgFc9nKFXM9MC2kjTg5yN/OOl+f5NWL0Hz+ThY9m6J1WhT/qntQLLUlmQQ7i/fxGvvy6pqpScW6+1KP1Vx8Om5DP9W4/GECpAYPHKT7Vz3d3urXeygYSEO+x9cM5ooFaBKJ+FUGTLYtejBTL7rxlM1fPIkDN6JmI8pIbwJKrUnB/07mm5vfe6MjH6UWloQOWNt5QoQcvH9GxetHwIyZm0jR9sYww/mkc3zR5gNdwVWqSQwMRAuy8kdWGzw1vPPxtc9VKpENPpv5a64hxlmikQYrHbheREr+fl19ov7ysMbgfABy2OnrVvHjoWSJrTqIspBOcoey/DvwTSyB2hAJH/gerupiRGlkA7WzW4JT+bPHpx3yVBp6xIaIWjb9dpZp11q9fEknYi1IpxhZNLUo3WzXnP6KxUwXUBLVbRmjj3/dCjKjbHBnBFZKn9l6/JMIzST2SxSHvRCLsO09itow0HvO8280x0lhs3q/tvQ38NTo2SJFpRt80ZfR5woC4VOpbVr1sYPqKB5lg8AmwZ98+ZXhKfBd3wlksPMFsuNgHmt3eESlyduPtALkoWHLNkw86hj79XnBwYjNk8QqlXsOqxXx4oI7RJ99qtEkbc6I4lIqaqIhwYUCg5eDO02S3Y6L3g7Po4hb499lKU3xKVe4/pGF9WVDrJSDsxOpFXGgJXcQOqnjf2gmllKplnLRLjHfHlORURXK4vNsauQ5FITkTzEJVDFg4ok+aAAivWMQCnBNdE49tp1yJOQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2a8555-e114-424c-b762-08dad228ffc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:33.3317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QexvhctHGo00n3XbgYxxkZa0biERfsALcPXsZb7l3hz7nX6FooLOdYUu20tEavw3meP0e1XgojcBTlLxov3OHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: ouldFDfmyGmNOa9hh_v3IOiltlz00MPO
X-Proofpoint-GUID: ouldFDfmyGmNOa9hh_v3IOiltlz00MPO
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

If the vma start address is going to change due to an insert, then it is
safe to not write the vma to the tree.  The write of the insert vma will
alter the tree as necessary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8db711622d50..f37a6b5a40d6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -779,10 +779,12 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		if ((vma->vm_start < start) &&
-		    (!insert || (insert->vm_end !=3D start))) {
-			vma_iter_clear(vmi, vma->vm_start, start);
-			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+		if (vma->vm_start < start) {
+			if (!insert || (insert->vm_end !=3D start)) {
+				vma_iter_clear(vmi, vma->vm_start, start);
+				vma_iter_set(vmi, start);
+				VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+			}
 		} else {
 			vma_changed =3D true;
 		}
--=20
2.35.1
