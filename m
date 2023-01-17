Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C695F66D479
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbjAQCkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjAQCjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:39:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F744C3D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:36:00 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09eKY006596;
        Tue, 17 Jan 2023 02:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AAw+iDzEV/2NHEkM2iEuJcHfi3pWzGbIGQH4oV+cz28=;
 b=FkInLR47FSMr3ksxsD0fdik9siut2OYLVgdtXzoA12vBPAGz75XIvhxKmA0UwajrZENJ
 7v7lciJ3mE/XgHwU0Whq4A/prK1dUGLIJnN2F/sSiXmw7KQCxOVeTq8t+JFd1A0hGDXV
 vOfaCm8+m7wN7EfkpJXmA+jOIcBFttJqcyV41mt65ysNwt5lDFf4kC/hlNbzrXLoHdHJ
 t5RM0ADmEw9O32Ny/cIiQpWtoWt22AiSBkSiEd4dfxDRxsp24UiFNjraiJyx47EZ9BF/
 M1DlF9qFycF58dNilqMC20gPevWSKc+ZplDQH2hY4ke70/fyQIH21J8GE4JvUYn8un/v Mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaabrk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMXP48028373;
        Tue, 17 Jan 2023 02:35:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfy4x-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjC/Fx5Y5grGmtX1v4ceGkNoMhEO4Ef2vZazfLuF3xUi1viPPrup4Hkow2aXFZCOHZEiJlbHthDit0QqZeoYxl9HrBhV2Z5/9zH6ujKWm3MuP5Qiw3nq3XCP6oG96AnScweFJugwL5GSv2tgwoZV4a4K6+XBbVm5Z6jS2OwyMmuc7oo5wKCFPxiC0xmEtWBWxfML6Uhvluz4KcTR/0O+XW3TVg9XL46W1L+RzG+vgvI461VWt6nzK1MldWCfGcAfL76r4jy0aCMTiT2cPVHhZv+l8nQg8+gevBYlWbcxzljl3B62PkMTh+PekLqb+PbXqwcsDwbd6vVp+TNHg1SwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAw+iDzEV/2NHEkM2iEuJcHfi3pWzGbIGQH4oV+cz28=;
 b=lj2lDTFjRjZrJxyBA+68MEZr6Fisee/JXnHY4/c5mEVm679fOz3jEmIF4/rZ/jBMkeoGLcqepTr4kgbH0+8kVV6jIbrgVPr6x9VBpt+bjZ2mzR7AOk1/TDh4g7QwBzFBTMlUgv26eUJYoaSYvJton3SeampKd/r0l30K6EpK7oFe0yi+NK2ntR24Bs+tU7sEaccgVlCx9PrJthZzdFhomgdKxDyd5dlJR4Tw2T84YVsbYPf3Tuspu3FaiBYImnVG7p2fZrmbWpshDpYvlX5PqkLAi8VUfoFy2O4baiuiYu1KRARwNAVMDJttIkcYIXjK2rS6JMJf6r+daBWK2Qz8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAw+iDzEV/2NHEkM2iEuJcHfi3pWzGbIGQH4oV+cz28=;
 b=tsPk7LYA265+lFtAOPfXTcQcE6GDsZos/mgd5h9jOpGJLUN5bxB3uIXkW3TPjWyhwMwXvgVayF0ZNJBye9CXVQ+3X5c/AkXuyFIfzyBc3h9iBYLilu1CEgpVEaazLaFqa9bv4kEGvtp17/ZS7q7ZvVy6qiJiXVekY3wzJzqRaw8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:35:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:35:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 47/48] mm/mmap: Remove __vma_adjust()
Thread-Topic: [PATCH v3 47/48] mm/mmap: Remove __vma_adjust()
Thread-Index: AQHZKhw2acE32W1gPEKtpIW/U0s8KA==
Date:   Tue, 17 Jan 2023 02:34:24 +0000
Message-ID: <20230117023335.1690727-48-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4814:EE_
x-ms-office365-filtering-correlation-id: 0de78323-a107-45d8-e176-08daf8336ff4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBucwQQCJCWrw1Ccs8NbDn6xTTzYkeRhgRAZZAk99AlOSrt3WlWYlb+4EZv4je9i3KwLRRXiAwm5rrFG12778XKnXwU33uu/DEMYmi7IttRvrnmkFEZy4Mb1lklnOExWP/QBwIsV43ZXcPMMYHDPC61gL7dOowVpo+nJ75rcjNZuVREP9ppVHEVjaFWHES1BKszT3wS3ScX0XtT1ezmWCtOeVMg62mbEwlPUgAKnabc+1fmbKom/ec5cggruGkXdc1yuNG8YVOaTFnLIK9bsieKRvTlmiJ8m+M7+uejjO/1pT5mCeNt2ZSzwOSPFKTUOuCHswrGBULtyYS+fMIT3DMrNo01RXGPEuBmpFMdnr7c6AkUjL6+T72Bi3qYfX0irodpcceFXOLpPun/ftloIvWe00xIWE+SBiyoYl1pCHC1MUh/SprGUkbUT2c1G2yT18zjwgih/zhBb0ofVz/mtXR4wrqAHPBPadY+ozKe4IaSMb/YOiUkWP639Q5cF2M/0moKeGUPUPejCQCmZ+/d6AUXWm8xhiq42jTZAUGYyBVwbjpJArghRgu5lQRd8hwWdHw7+I4EijXcTV7ylGpPiVhg0Ka2lMnsN7PH1QhfsRmvUPGk4Zb97E2jSvHi1swf91Jl+mmdjoD8pqTQgX1S3K3GzVQ775arrDZ2nvgKazCMaF/ysYPcZ7yvSRC1Ciw/Ei+Lin1urxLtnszjzlfRIzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(6486002)(6512007)(478600001)(186003)(26005)(6666004)(107886003)(71200400001)(6506007)(91956017)(66556008)(66946007)(2616005)(76116006)(66476007)(122000001)(110136005)(316002)(64756008)(8676002)(4326008)(54906003)(66446008)(36756003)(83380400001)(8936002)(41300700001)(1076003)(44832011)(2906002)(30864003)(38070700005)(38100700002)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yIwMKyohIKWiKOFV5eAWQtuJ1NQas8ZigIAj19vk+SZmRKKgIkgyPct1Ys?=
 =?iso-8859-1?Q?fNGabhCD8bRIY2I+nmR6BGnAM4UU9yCNV3+JCThQZqsr6mgPR3mQjaYaZK?=
 =?iso-8859-1?Q?OANXvj1uHzI+xysGqkL2eCLkuY6U5eKlC6xSOiX13zZgNUjhhkboK572/Q?=
 =?iso-8859-1?Q?5BWLWjjusonE8ssjYgY0S/1KP8NXjDkCKGyuyS54irnEYQmWIot/XMs+OS?=
 =?iso-8859-1?Q?CSOn1PAZXvoNts8RWbdoqwxWQ0KPQQ0EadOMY7xKfE5yxFlxOPwZfVTOQ0?=
 =?iso-8859-1?Q?z9l2IG2ZzpBkRsHsV9BCBlhF+NDY4ix9DoW4+ayCBqDGXelPxPCvFPQA37?=
 =?iso-8859-1?Q?W1ym2qvpgiIQyBPpuirwXET9cefWj7FHD6TAQgGZFTO8JTGqIunzhWE0xJ?=
 =?iso-8859-1?Q?a6IGQjB74OggAK1kjkVGy8Qm92Je1ghJe5x0gRnSEwoohFqnhDZpyl82+o?=
 =?iso-8859-1?Q?/0WXQ7HYl6GQ+jZoKneW3D9aqJnFZdUJotDDMn5B1coNPuVUZe9SP2Qa8b?=
 =?iso-8859-1?Q?zlUe+inlW0b3NpXVQFIj0a0h8mHq0JopJBXsCUXDxiDrZO1prAWC1JV5/e?=
 =?iso-8859-1?Q?1Cw1HBOd3xoJsl6gxxbhRAs0wJmMtAXPrszX7xxQzmy+hnTQyrAoogYHhs?=
 =?iso-8859-1?Q?fe4Dcr5M4kI2OfQfFhTX7og7Fh3ZXeklHkJslLRtQ3/TJgyX36Bl2bOS1Q?=
 =?iso-8859-1?Q?Q30DpGqyjcsSU3oT/eNaLN6ODapASbBtNeH94bLyHYkpW8YVRpCxr44E1S?=
 =?iso-8859-1?Q?UwIC3iKHbmiq518R/bw2zwrhzc1S1/7LVIQWFEWlbp8aRALiQz08JVunfe?=
 =?iso-8859-1?Q?9EAxFNFXqzeFiVCqxg7gXUSQfYoaXagODOSOWrBESSDyqi10E473ahY0rj?=
 =?iso-8859-1?Q?gs0ldbCqbQDM5IwE0uFKPdoaJap1TYzNk18TzQ81fmjOWCdQc9fRVih9VA?=
 =?iso-8859-1?Q?fut15oClJpYGYBbTdQfgnTVbUlRUgp8qS1uv93L+VpFFSwqXwaT16GL++B?=
 =?iso-8859-1?Q?UOmuAx1g3YCLkqtjZgXqkjij34lyYM4cGrHMGPgHMlQNDxY/K9oevuklmy?=
 =?iso-8859-1?Q?lQfB+mPRI4gJjdCzC9eeFucS+LwZausVbx2T+80WBhrIeeG5i1hN6B9zD8?=
 =?iso-8859-1?Q?+klKmmaSySyyOavwq6qD/HoAqGbKSl+zWnKvlr4Ft8HZRjz83L+r2bhfTJ?=
 =?iso-8859-1?Q?+jSGi9JkymiGkyLxJ9UQAlxdkGo2izDdEFTxsrVCT5SxCXLJgby9OeOzfX?=
 =?iso-8859-1?Q?yEhZ+aI5f+GNJaqRV0iz8bVh0fkVlHbvJJtqU/iU2gsoa+CCjGameFgeVB?=
 =?iso-8859-1?Q?RFKUOTlCvJvwDwoVC3N5WADACyqJIR1qfxWhEkawcNjDXOFMx5oTV3wLv6?=
 =?iso-8859-1?Q?ODkyhERdC/XrNE3PTxo+d+KlUeaykjFsu3anOsWHJJK9Ola8abtF9ebyu0?=
 =?iso-8859-1?Q?ax2Q0oHGuRHMdh+7eJCr8DxQvUMGnLGCq5Zok9HgoZtXieb/p8dI7/tCFu?=
 =?iso-8859-1?Q?UXGhaHkTXHZrxBCqcEFIGdphOZiVXe3ijuaEJPla/nNMwh/BcctH1n64e9?=
 =?iso-8859-1?Q?LlLJUNRXTRHosyNG+GCmxKk6Ql6yRbAH7oLBseOU5QTkUdd1HeZLEEr3cc?=
 =?iso-8859-1?Q?YsDv/xPTanX9hqyww0CLI3Y/CnATSp0XCFxXcZqQQhvQnYzT+KkBnByA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BhR+F7F+8h/7GEJiLe7NAdTibYNuyOet/ZGf91RyV+bgyN4ABQd6ZE1H3Nwqf5Obge3h4zmPLaoP7H4Zb+Fng16TCJYlh1pbHBksScY1nnTDvUCLZR+pKcUgttEfr5H21HGzlQFiLhmw7aNPim1t16aD3LDPYnA77oUofVHY35cTvDLtqvIgI3W+VLvCs94iEpuGUNrUPb65A/Ch3XNLI695c5UBbYSqkiPLwH/hOAeSRuGlMTVchitNvEEUtcNAOhphuHsngntrT3b8tyl6yFSVkXBLUj6wcAxObxfHfEmEGPh3oWcAkAd/7ZCRrZlpxHspuPFHNAi8xp0mtf9el4fIgNaRZ+n59/g9T8VFOvZDPxPjWI+xzI+qudmffBtylE6lrd+gJ2yaeGNl8F2ivO5k1F3asSNc735SB5zNu4wUxoSAZs8VzDmYL/RUDTv57f74MfO7zk+rNZuQhRO18UUTk4I2QQxUrbIfSM7ukAGJhPFaHK8l+W66oaU1A1uVGlfzOKJ9UtZPFCYFmLT1taZe8vc4Pf1i0di4e3sJ85lbEIf6nDz2hKQ+7qgFzMLz+rHrUBnWsb6Qu5LoxuLvLxKRFwogTHy8Pg+mb5JkYuTtyhGQOIXS/FUPHhyWIUGN+hfkRSc1SCkKEY448z8pGafDApclEm7D/1+BBvzaFRP5ZsrCEXG/T8qvtiumoz2j9hW7nXPX600JPsdBuVZepYedGDqNQEbk98zoSv6L+CvdVHnG54EtZYBiW/3zW7zyShmlT/dj9HWmV55PtyGL23QuK6KBSP+VumPtPkuf93ceESEyDcl/7iXlp/DG5w/TADqJdhWVqdsZ1B9mG/5E0MqHPQ4l5HIC5a71nrBfVcs8epN7QY2iJ+JWq3ZxytcK/Ljqfu3su5X8Hvpg2Zm1Nw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de78323-a107-45d8-e176-08daf8336ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:24.4681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bV3kIOGMulkcXEVj9ovXe7wWDtQoiOdmTWXIqKRVc84ht8HGuxhSERSlP528Fu0PNOUF5WVwvYbUm1tJXyeiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: CzFJInBFSnq-2eProsbue_9RXqnHkRtO
X-Proofpoint-ORIG-GUID: CzFJInBFSnq-2eProsbue_9RXqnHkRtO
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

Inline the work of __vma_adjust() into vma_merge().  This reduces code
size and has the added benefits of the comments for the cases being
located with the code.

Change the comments referencing vma_adjust() accordingly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 kernel/events/uprobes.c |   2 +-
 mm/filemap.c            |   2 +-
 mm/mmap.c               | 250 ++++++++++++++++------------------------
 mm/rmap.c               |  15 +--
 4 files changed, 107 insertions(+), 162 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d9e357b7e17c..c5d5848e2c3e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1352,7 +1352,7 @@ static int delayed_ref_ctr_inc(struct vm_area_struct =
*vma)
 }
=20
 /*
- * Called from mmap_region/vma_adjust with mm->mmap_lock acquired.
+ * Called from mmap_region/vma_merge with mm->mmap_lock acquired.
  *
  * Currently we ignore all errors and always return 0, the callers
  * can't handle the failure anyway.
diff --git a/mm/filemap.c b/mm/filemap.c
index c4d4ace9cc70..fe5a4973718f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -97,7 +97,7 @@
  *    ->i_pages lock		(__sync_single_inode)
  *
  *  ->i_mmap_rwsem
- *    ->anon_vma.lock		(vma_adjust)
+ *    ->anon_vma.lock		(vma_merge)
  *
  *  ->anon_vma.lock
  *    ->page_table_lock or pte_lock	(anon_vma_prepare and various)
diff --git a/mm/mmap.c b/mm/mmap.c
index 4728b6d1db23..bf24c46c3c3f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -743,133 +743,6 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
 	return 0;
 }
=20
-/*
- * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
- * is already present in an i_mmap tree without adjusting the tree.
- * The following helper function should be used when such adjustments
- * are necessary.  The "insert" vma (if any) is to be inserted
- * before we drop the necessary locks.
- */
-int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	unsigned long start, unsigned long end, pgoff_t pgoff,
-	struct vm_area_struct *expand)
-{
-	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct *remove2 =3D NULL;
-	struct vm_area_struct *remove =3D NULL;
-	struct vm_area_struct *next =3D find_vma(mm, vma->vm_end);
-	struct vm_area_struct *orig_vma =3D vma;
-	struct file *file =3D vma->vm_file;
-	bool vma_changed =3D false;
-	long adjust_next =3D 0;
-	struct vma_prepare vma_prep;
-
-	if (next) {
-		int error =3D 0;
-
-		if (end >=3D next->vm_end) {
-			/*
-			 * vma expands, overlapping all the next, and
-			 * perhaps the one after too (mprotect case 6).
-			 * The only other cases that gets here are
-			 * case 1, case 7 and case 8.
-			 */
-			if (next =3D=3D expand) {
-				/*
-				 * The only case where we don't expand "vma"
-				 * and we expand "next" instead is case 8.
-				 */
-				VM_WARN_ON(end !=3D next->vm_end);
-				/*
-				 * we're removing "vma" and that to do so we
-				 * swapped "vma" and "next".
-				 */
-				VM_WARN_ON(file !=3D next->vm_file);
-				swap(vma, next);
-				remove =3D next;
-			} else {
-				VM_WARN_ON(expand !=3D vma);
-				/*
-				 * case 1, 6, 7, remove next.
-				 * case 6 also removes the one beyond next
-				 */
-				remove =3D next;
-				if (end > next->vm_end)
-					remove2 =3D find_vma(mm, next->vm_end);
-
-				VM_WARN_ON(remove2 !=3D NULL &&
-					   end !=3D remove2->vm_end);
-			}
-
-			/*
-			 * If next doesn't have anon_vma, import from vma after
-			 * next, if the vma overlaps with it.
-			 */
-			if (remove !=3D NULL && !next->anon_vma)
-				error =3D dup_anon_vma(vma, remove2);
-			else
-				error =3D dup_anon_vma(vma, remove);
-
-		} else if (end > next->vm_start) {
-			/*
-			 * vma expands, overlapping part of the next:
-			 * mprotect case 5 shifting the boundary up.
-			 */
-			adjust_next =3D (end - next->vm_start);
-			VM_WARN_ON(expand !=3D vma);
-			error =3D dup_anon_vma(vma, next);
-		} else if (end < vma->vm_end) {
-			/*
-			 * vma shrinks, and !insert tells it's not
-			 * split_vma inserting another: so it must be
-			 * mprotect case 4 shifting the boundary down.
-			 */
-			adjust_next =3D -(vma->vm_end - end);
-			VM_WARN_ON(expand !=3D next);
-			error =3D dup_anon_vma(next, vma);
-		}
-		if (error)
-			return error;
-	}
-
-	if (vma_iter_prealloc(vmi, vma))
-		return -ENOMEM;
-
-	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
-
-	init_multi_vma_prep(&vma_prep, vma, adjust_next ? next : NULL, remove,
-			    remove2);
-	VM_WARN_ON(vma_prep.anon_vma && adjust_next && next->anon_vma &&
-		   vma_prep.anon_vma !=3D next->anon_vma);
-
-	vma_prepare(&vma_prep);
-
-	if (start < vma->vm_start || end > vma->vm_end)
-		vma_changed =3D true;
-
-	vma->vm_start =3D start;
-	vma->vm_end =3D end;
-	vma->vm_pgoff =3D pgoff;
-
-	if (vma_changed)
-		vma_iter_store(vmi, vma);
-
-	if (adjust_next) {
-		next->vm_start +=3D adjust_next;
-		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
-		if (adjust_next < 0) {
-			WARN_ON_ONCE(vma_changed);
-			vma_iter_store(vmi, next);
-		}
-	}
-
-	vma_complete(&vma_prep, vmi, mm);
-	vma_iter_free(vmi);
-	validate_mm(mm);
-
-	return 0;
-}
-
 /*
  * If the vma has a ->close operation then the driver probably needs to re=
lease
  * per-vma resources, so we don't attempt to merge those.
@@ -996,7 +869,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigne=
d long vm_flags,
  * It is important for case 8 that the vma NNNN overlapping the
  * region AAAA is never going to extended over XXXX. Instead XXXX must
  * be extended in region AAAA and NNNN must be removed. This way in
- * all cases where vma_merge succeeds, the moment vma_adjust drops the
+ * all cases where vma_merge succeeds, the moment vma_merge drops the
  * rmap_locks, the properties of the merged vma will be already
  * correct for the whole merged range. Some of those properties like
  * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
@@ -1006,6 +879,12 @@ can_vma_merge_after(struct vm_area_struct *vma, unsig=
ned long vm_flags,
  * or other rmap walkers (if working on addresses beyond the "end"
  * parameter) may establish ptes with the wrong permissions of NNNN
  * instead of the right permissions of XXXX.
+ *
+ * In the code below:
+ * PPPP is represented by *prev
+ * NNNN is represented by *mid (and possibly equal to *next)
+ * XXXX is represented by *next or not represented at all.
+ * AAAA is not represented - it will be merged or the function will return=
 NULL
  */
 struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struc=
t *mm,
 			struct vm_area_struct *prev, unsigned long addr,
@@ -1016,11 +895,19 @@ struct vm_area_struct *vma_merge(struct vma_iterator=
 *vmi, struct mm_struct *mm,
 			struct anon_vma_name *anon_name)
 {
 	pgoff_t pglen =3D (end - addr) >> PAGE_SHIFT;
+	pgoff_t vma_pgoff;
 	struct vm_area_struct *mid, *next, *res =3D NULL;
+	struct vm_area_struct *vma, *adjust, *remove, *remove2;
 	int err =3D -1;
 	bool merge_prev =3D false;
 	bool merge_next =3D false;
+	bool vma_expanded =3D false;
+	struct vma_prepare vp;
+	unsigned long vma_end =3D end;
+	long adj_next =3D 0;
+	unsigned long vma_start =3D addr;
=20
+	validate_mm(mm);
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1038,13 +925,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator=
 *vmi, struct mm_struct *mm,
 	VM_WARN_ON(mid && end > mid->vm_end);
 	VM_WARN_ON(addr >=3D end);
=20
-	/* Can we merge the predecessor? */
-	if (prev && prev->vm_end =3D=3D addr &&
-			mpol_equal(vma_policy(prev), policy) &&
-			can_vma_merge_after(prev, vm_flags,
-					    anon_vma, file, pgoff,
-					    vm_userfaultfd_ctx, anon_name)) {
-		merge_prev =3D true;
+	if (prev) {
+		res =3D prev;
+		vma =3D prev;
+		vma_start =3D prev->vm_start;
+		vma_pgoff =3D prev->vm_pgoff;
+		/* Can we merge the predecessor? */
+		if (prev->vm_end =3D=3D addr && mpol_equal(vma_policy(prev), policy)
+		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
+				   pgoff, vm_userfaultfd_ctx, anon_name)) {
+			merge_prev =3D true;
+		}
 	}
 	/* Can we merge the successor? */
 	if (next && end =3D=3D next->vm_start &&
@@ -1054,32 +945,85 @@ struct vm_area_struct *vma_merge(struct vma_iterator=
 *vmi, struct mm_struct *mm,
 					     vm_userfaultfd_ctx, anon_name)) {
 		merge_next =3D true;
 	}
+
+	remove =3D remove2 =3D adjust =3D NULL;
 	/* Can we merge both the predecessor and the successor? */
 	if (merge_prev && merge_next &&
-			is_mergeable_anon_vma(prev->anon_vma,
-				next->anon_vma, NULL)) {	 /* cases 1, 6 */
-		err =3D __vma_adjust(vmi, prev, prev->vm_start,
-					next->vm_end, prev->vm_pgoff, prev);
-		res =3D prev;
-	} else if (merge_prev) {			/* cases 2, 5, 7 */
-		err =3D __vma_adjust(vmi, prev, prev->vm_start,
-					end, prev->vm_pgoff, prev);
-		res =3D prev;
+	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
+		remove =3D mid;				/* case 1 */
+		vma_end =3D next->vm_end;
+		err =3D dup_anon_vma(res, remove);
+		if (mid !=3D next) {			/* case 6 */
+			remove2 =3D next;
+			if (!remove->anon_vma)
+				err =3D dup_anon_vma(res, remove2);
+		}
+	} else if (merge_prev) {
+		err =3D 0;				/* case 2 */
+		if (mid && end > mid->vm_start) {
+			err =3D dup_anon_vma(res, mid);
+			if (end =3D=3D mid->vm_end) {	/* case 7 */
+				remove =3D mid;
+			} else {			/* case 5 */
+				adjust =3D mid;
+				adj_next =3D (end - mid->vm_start);
+			}
+		}
 	} else if (merge_next) {
-		if (prev && addr < prev->vm_end)	/* case 4 */
-			err =3D __vma_adjust(vmi, prev, prev->vm_start,
-					addr, prev->vm_pgoff, next);
-		else					/* cases 3, 8 */
-			err =3D __vma_adjust(vmi, mid, addr, next->vm_end,
-					next->vm_pgoff - pglen, next);
 		res =3D next;
+		if (prev && addr < prev->vm_end) {	/* case 4 */
+			vma_end =3D addr;
+			adjust =3D mid;
+			adj_next =3D -(vma->vm_end - addr);
+			err =3D dup_anon_vma(res, adjust);
+		} else {
+			vma =3D next;			/* case 3 */
+			vma_start =3D addr;
+			vma_end =3D next->vm_end;
+			vma_pgoff =3D next->vm_pgoff;
+			err =3D 0;
+			if (mid !=3D next) {		/* case 8 */
+				remove =3D mid;
+				err =3D dup_anon_vma(res, remove);
+			}
+		}
 	}
=20
-	/*
-	 * Cannot merge with predecessor or successor or error in __vma_adjust?
-	 */
+	/* Cannot merge or error in anon_vma clone */
 	if (err)
 		return NULL;
+
+	if (vma_iter_prealloc(vmi, vma))
+		return NULL;
+
+	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_next);
+	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
+	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
+		   vp.anon_vma !=3D adjust->anon_vma);
+
+	vma_prepare(&vp);
+	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
+		vma_expanded =3D true;
+
+	vma->vm_start =3D vma_start;
+	vma->vm_end =3D vma_end;
+	vma->vm_pgoff =3D vma_pgoff;
+
+	if (vma_expanded)
+		vma_iter_store(vmi, vma);
+
+	if (adj_next) {
+		adjust->vm_start +=3D adj_next;
+		adjust->vm_pgoff +=3D adj_next >> PAGE_SHIFT;
+		if (adj_next < 0) {
+			WARN_ON(vma_expanded);
+			vma_iter_store(vmi, next);
+		}
+	}
+
+	vma_complete(&vp, vmi, mm);
+	vma_iter_free(vmi);
+	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
=20
 	if (res)
diff --git a/mm/rmap.c b/mm/rmap.c
index b616870a09be..4ee90f06b05b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -262,11 +262,12 @@ static inline void unlock_anon_vma_root(struct anon_v=
ma *root)
  * Attach the anon_vmas from src to dst.
  * Returns 0 on success, -ENOMEM on failure.
  *
- * anon_vma_clone() is called by __vma_adjust(), __split_vma(), copy_vma()=
 and
- * anon_vma_fork(). The first three want an exact copy of src, while the l=
ast
- * one, anon_vma_fork(), may try to reuse an existing anon_vma to prevent
- * endless growth of anon_vma. Since dst->anon_vma is set to NULL before c=
all,
- * we can identify this case by checking (!dst->anon_vma && src->anon_vma)=
.
+ * anon_vma_clone() is called by vma_expand(), vma_merge(), __split_vma(),
+ * copy_vma() and anon_vma_fork(). The first four want an exact copy of sr=
c,
+ * while the last one, anon_vma_fork(), may try to reuse an existing anon_=
vma to
+ * prevent endless growth of anon_vma. Since dst->anon_vma is set to NULL =
before
+ * call, we can identify this case by checking (!dst->anon_vma &&
+ * src->anon_vma).
  *
  * If (!dst->anon_vma && src->anon_vma) is true, this function tries to fi=
nd
  * and reuse existing anon_vma which has no vmas and only one child anon_v=
ma.
@@ -1265,7 +1266,7 @@ void page_add_anon_rmap(struct page *page,
 	if (unlikely(PageKsm(page)))
 		unlock_page_memcg(page);
=20
-	/* address might be in next vma when migration races vma_adjust */
+	/* address might be in next vma when migration races vma_merge */
 	else if (first)
 		__page_set_anon_rmap(page, vma, address,
 				     !!(flags & RMAP_EXCLUSIVE));
@@ -2548,7 +2549,7 @@ void hugepage_add_anon_rmap(struct page *page, struct=
 vm_area_struct *vma,
=20
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!anon_vma);
-	/* address might be in next vma when migration races vma_adjust */
+	/* address might be in next vma when migration races vma_merge */
 	first =3D atomic_inc_and_test(compound_mapcount_ptr(page));
 	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
 	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
--=20
2.35.1
