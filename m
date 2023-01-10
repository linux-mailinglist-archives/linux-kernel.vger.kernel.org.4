Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7524D664B93
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjAJSut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjAJSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:50:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503AE7F8C4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:43:30 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AIIFw5006638;
        Tue, 10 Jan 2023 18:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=AZOyKgQPCBaWMP3kkAq+kuDMgEDEMIYsiCgA8gK2ApY=;
 b=p9ZLNS8M4d/4afRuxonggX0eVLZFSz60Z0NtkiiMDcP4sk1K41qVOPJDCylmSyYGine5
 ofkFhE0mpg038CsJweosOjTOKEc/8mBK5P05c4pT/UjCiwK4tOpIm/Ahx4m50+FFr3ee
 a/jBSKifHcNIvGGDtrYIFGiP4SCa443u9LChDV89TOVEEveVGUiGT3SgAIhPtGLYrHZd
 luTIpTzOhIz2cJkkNYufVQMqHXp976EcJNe8A6nQpNZXI4hi7nsqUo5qNklnddoMUgDb
 y3ftZR7W9mZRK7NpzbRFMfI5cwBrSi0bBIosj0gpLlgKVT1y8+tTv2pchLQQ6tWD6fGR pA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1cbq869c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 18:43:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AIISF5015328;
        Tue, 10 Jan 2023 18:43:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1d6ch1vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 18:43:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJgtxBIHAshRbOsT8KEsQpCoDriPaokpKs20IjX4aa0TOfrzBUMBUN+nNOzI5124mQP+rXSUVElnHToIFVZLBuOox0BCxMz1uUHJHvUnzu1kmD59qaCAOMDiRu6DcIokBgZgzJ2OXJjF3rQXf//NMQLs2EJj4A/ykQvHTQwPtNsTGBkseVn0JLM7/jepvHdIKGUW+uYCaWfzTuNIgscR4B5EHobDp3+VOPLXd1nSBwsXADj0WJDe3+2kffQA2uies2Iu/6433HIxRDCukzp3CsCWaVysDc6MjTyCXNFaokhTNaVN5SfV4erCihDVtLRxGTXtFN7ydXtbYJxo7GokUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZOyKgQPCBaWMP3kkAq+kuDMgEDEMIYsiCgA8gK2ApY=;
 b=jy2bWo/aBms9Ay8i+VdZ+pYPUINDhExCf1ngTDMrJaxtWTPDBdMSZxC8uuCvWGKw3bZBsE0Kl3ZbW1Uq2LzJs6N3h2gFTm9XUUcrjgOSpRi9wYNjc4fwDhhQ8ui22euLy1O91O0y7HGj8UR3jij0s7ks3wlRhJjP44GXXCn8lZYdVJLYRqJaKQtrTmuXHvDObNvOOjS5M7wIQYf0n2v5CO/fF1zMhIMQtqYjD2VXUwcAbY7UJOsDf9FEh+ibtgYW1dVTdkO190WQI1qTIxVC7gSwd/pGp6UxQFplwslZ6X1giltFBNLaa2M0y0QDpRe9lXJ1OHD+cihFsohtA9z28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZOyKgQPCBaWMP3kkAq+kuDMgEDEMIYsiCgA8gK2ApY=;
 b=oXdc/RO+MPUh9esgTRy0gxDjvCDb44vhOwWb2Pxqlv/WGrLprbsTqlzGmj9Uddpj8D61k+EQDQ+UrVwMqjimE7lvTAU9klh4G2MuFi8I6+tvSw1pf+IK9G52+hadzw1v/97SJa8IsZQhmqXrPdCgZYtng9tFEULbItbUpkZFiRk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5297.namprd10.prod.outlook.com (2603:10b6:208:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Tue, 10 Jan
 2023 18:43:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 10 Jan 2023
 18:43:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH] userfaultfd: Fix vma iterator conversion.
Thread-Topic: [PATCH] userfaultfd: Fix vma iterator conversion.
Thread-Index: AQHZJSNfPVijqOTwG02AmHpqei9IHg==
Date:   Tue, 10 Jan 2023 18:43:03 +0000
Message-ID: <20230110184247.1268710-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|BLAPR10MB5297:EE_
x-ms-office365-filtering-correlation-id: f797348a-893a-4d3c-b585-08daf33a81b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: in4blpwejbZPWfrSyfkXm4i5a9eU9FP62pGxKMtkJVFXq3IkegrB/wJpnLKmYM6gXvznP5lSvZaiforZHffp1yZvUqFtjJ82jLX4PZlcCTHkpnTjsHuitybJBXvN6BKkcwa3GBgTRpURt8+8/KqFSBuA3ls7y4ZiwFxutFmiVgOBiGRqd3xKw5344ArlbEMVH3FU8jsydezYm3GyXx8jnUzj8gZq8w2EksiTVq9JNiI0d16Ceh1UGfBlhsobz7AYeYgOO7tEzJ2oXC9RutOt4mAsKCUkSzm4Vah9SGX8hCwSkS9Av7IHoa4ad+HcpSKIMbP3K5LyvMkk8A55mU+FV/XkEJizjfH1sEtscxv+njf9jnHiYEt3AKESy0p1jgrTTSjqNp4t0aKpwQm+yBTKEaYxxngoMPbRi9qYsft7RPzM+u+BmQPACPruA3dFseplafIFqt3qS1ji7PjS7IIJhi9eIH/SUR89gxD7TIMzjgTBHaOf//uo2EZlTECPYaW6/6r13OAgJWVGJVhYyHsolZux9c95RPtFVi3tuL7+1CzEfyvqdQbqOZYpI/Y51TML85JEB5dryrItaURbEUUDDPyE2mTMUm/+Wv3VIGt1aoblK8DihV/BRIh0/j37D2Ya230fzEDvWgvBuprZl+5Ixqpa1vEjy8b03aeKkbtgh1dR0ZcAWhFFnNMYTpGdfNQqZtz27oyF7AwleTW7YV4x6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(36756003)(38070700005)(86362001)(83380400001)(110136005)(107886003)(76116006)(8676002)(66446008)(91956017)(41300700001)(66946007)(4326008)(66556008)(64756008)(66476007)(122000001)(38100700002)(478600001)(6486002)(186003)(6506007)(71200400001)(26005)(2906002)(8936002)(5660300002)(316002)(44832011)(2616005)(4744005)(6512007)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UxZcKbytHDl6lrd8Am4hlY5WgFSdr9yxQO7ccwSsYQ6bcG4z5hcYfS2mt3?=
 =?iso-8859-1?Q?W3dEwc2bWLpfNnSSFYYhrhpB3I0haxxTUZia2Hus+xfFSa5iYBvK7luxlg?=
 =?iso-8859-1?Q?gkS5o7n3tVCqM35Z5TZATEkY2+cn8oJ8XBZMVRYGxvaDs0GNdsRjv9B6HB?=
 =?iso-8859-1?Q?JaxBdX+b8lT3UVtSv0co7Uv2cl7Q0LoR8h/Op68Qfo+b2UyQL5J62fl/0c?=
 =?iso-8859-1?Q?69ty6oMoreEMHOTJMpAA0grxMN5oAIppGCh66ESZzDLlduSMGIVhwVEu5V?=
 =?iso-8859-1?Q?rmX69ov89ESytmX83CJZIQMzdkS1L2ZSEmNOVFDIKkw4JZhnDSuSX4QG5n?=
 =?iso-8859-1?Q?+Pp+wF3U1Wykcd3MEdQrZ8LbsOMQwfJpTN+3FZxQ/p28XOAy8LXLozL0U8?=
 =?iso-8859-1?Q?5RS2a7xiE4oeKfmQoQx0ddvWdCkL329/Wx37RXQZGjdM6DNuvDPEYxuTKc?=
 =?iso-8859-1?Q?V5Nm0Je5t8YLR/wSjd9ZVeiVSFmktzTi+nhvdhxubZzInOMsGOE9eqayXn?=
 =?iso-8859-1?Q?efW7YLJW+YMbfaTlLCXYV5d3mI/RJ3fyhlSHocEka7tv9lWPu4hNZ36WUU?=
 =?iso-8859-1?Q?CudIMfmhGhqS+eKAzM836v3xjQybKN0G0QWQy/01IiM+38EaK7BjDx3dTo?=
 =?iso-8859-1?Q?BQfD5BsJfW9i30QBBPa2NnZLETeRNOA/pJ4s8XYfy6SV9fbj1dotxcG5On?=
 =?iso-8859-1?Q?FlXMUwhhBNOh2vvzGQc20Ud55oOJ3q+8CTW/zITLHHpCvnCawbQMRxUGQP?=
 =?iso-8859-1?Q?eabU2NY9bsXKI3Xneweo/qCTAhVBPniFbmTD7o6KX8xqG1r8iOXBkoVfzz?=
 =?iso-8859-1?Q?lazUeVZrK07PN5uqG3FVsF3PSK+t05VrYrXtepficKYanR1Zgald7fBz+9?=
 =?iso-8859-1?Q?NkGou6tZCwzTsoojsNPXYiGq6p3fctLy1k9chlkCr5uEuLhCGgvZmi12Yg?=
 =?iso-8859-1?Q?Bv2RL/WZgCKPbTTkA2BMTDBVpCKtaiUkkNg5Mn/sR9fOM/RgDkjEOKQOuX?=
 =?iso-8859-1?Q?oTHCnKSn9bKYV51kvRb+6BHOrM+sVYqDe2v5shi6CjIYjeUwEn8NYkjBIH?=
 =?iso-8859-1?Q?QazjzCqgP2GFgH/60MkSONgQl5RnunvXcNDPNDyx7z1XHufNoauaPnuWnp?=
 =?iso-8859-1?Q?1whtkjnKisXHmp9XYHvDpqbgxM+RsKZjpNnVRfr61OlKhrF2XYbaxROS9+?=
 =?iso-8859-1?Q?AmD0rAaWjpQb8gYqWgM/558+NIe+vVCmrV0f8PJER1s7bPJafliE3xExCk?=
 =?iso-8859-1?Q?IzHS6dghi1lZ1qodPhiRCAWncm6F6kzkZegWCoq4utqxTqhYig31VI/GyF?=
 =?iso-8859-1?Q?LFQR0qg/DKe1NXwlflLyR/Vi2wyXGV3xYeZQQCKzfcvdSioxgDIPEllbJA?=
 =?iso-8859-1?Q?JBOYNlp53ex74YAodhVg7qd+tBHAzhSCtsxWwQpYfK1SGHLpZ9y3dvS2gd?=
 =?iso-8859-1?Q?vei90vTtim9paiTHKJR9Xc36t5V9YN/fF5p/rVIOP9Ucmnv+/+iK4lUKq0?=
 =?iso-8859-1?Q?Hd3HuH6JCXWcocFyaAfv48BAkEV5P02DMuNCqHEXbTW6ikl/RbUwjLUSmd?=
 =?iso-8859-1?Q?PfY7ai0V8R38DyVTJ3Ov9I5nmrFpphdOQdd0NBRJtzxHfdNgqfktn3DBYM?=
 =?iso-8859-1?Q?b2lSsDF5oGBSndDWG3FeVp9VZx1PfcZtdlRfgvljNT/oEWglDYjwLW8g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ABV5Cx8Jzn2ox84R2aCVx0WYQgqssp9W0w+ius94gqpC7C1ITQXXR09tlKbU2VU2geWWTxOAnznz23P7VlTSLQOODaqvgDG6wYUek/2EP5xp21vBMU8DpFtJZRkpr9oXStQFY8e3M/tN6fALzW0bj6tZG5725ImwBEMqx4weShXcAnr6NsjnTy9GgCj7tviOeMrYZK1yTCoysQPI3fBXdaWtwtqBQ6Kufa1Pm7znwhNHd9eamanULSeQZXQa9QjFMWW/vpEdI4AsS7xW3oZbBr7C8fzEiwZQ/vbtGc9iWkoZaz7KtXktNV4b9LO/q9Pol/7HCLUjg2fbg3STX0qXCcaIlkqlIwvcCZZj3l5Ru1zYWfJYvMTM/RtthuNhsNsnHyMCQbr75RHVyMbLQlDKpPeZaj+2PjgJa8/huvr0fzGda0hCv7lig1F+fO8ELVOH+Nj4X7F1M796Ri1fXmanYJcHhq394oRXY0Gh6PR7o6hUzlf/6dxyiWz8ZUQACzEtMS7aG/0k1Z4Opc7jnuvC9X/T45UYgqkB2x19h1RtSc+XgxBIDGU4gbHOhLdz2CXLexq6XZC025zAbNYu1oImWJ8aXsxinWRI+Km1a8Weabe/8ZeYOERh53vMRcho8yxBXRG02yptONlVsb7RTO4bpD2h7aK+5wAlNbmmg5NRoH0hpX4INZpKrQiW8xXxz7ONvsakhpyUOrl0iFdXm7XaY84bFdEfTSQ2rc8HUGfAcqWB4z9K2VwwRITdebYAew4hMsMr+xKsvq9is3M2BrGCfD5siu0zXMgsVtppyUqZa8hrVzZWRm4m4h/pj368lilFMQTV4FrSpYQVIKD64+kFDT/WtcrV0MMroWrvz4rDPnw6vy9UnWGf273c8YN+Z6QL/T9G/i5eq4Lvio3GFvGj3g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f797348a-893a-4d3c-b585-08daf33a81b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 18:43:03.5896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RRb3YSBO4b59rexE/ae7FAiREuEZ1NrRvEvaDg9Hec6Wgf/KhMFTHJD8tFazmXoLIt9rxM/ZdEmGXH3lEOkF5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_07,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=912
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100122
X-Proofpoint-ORIG-GUID: xpO1hjkUOM9rcRKjO-yUNj7lQV2bu3BD
X-Proofpoint-GUID: xpO1hjkUOM9rcRKjO-yUNj7lQV2bu3BD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An extra vma_iter_set() was added to one of the loops over the VMAs.
Remove this set as it is suboptimal and unnecessary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---

This is an mm-unstable hash
Fixes: c6fc05242a09 ("userfaultfd: use vma iterator")

Please squash this patch.


 fs/userfaultfd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e60f86d6b91c..55f3af6689b8 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1620,7 +1620,6 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 				break;
 		}
 		if (vma->vm_end > end) {
-			vma_iter_set(&vmi, vma->vm_end);
 			ret =3D split_vma(&vmi, vma, end, 0);
 			if (ret)
 				break;
--=20
2.35.1
