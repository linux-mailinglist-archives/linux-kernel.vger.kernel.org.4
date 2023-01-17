Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AC666D51D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjAQDpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjAQDpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:45:39 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98CB6A47
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 19:45:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09xT5012282;
        Tue, 17 Jan 2023 02:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=L7sr5iVHvKYFk62UwT4div4O+6ZS/l5NbPF7xnne2Zs=;
 b=zUAx6835+16afZ3+waUuGPMc3NTz5KjbjfeeWGapToBQPpL9j0vdF4hNH6LsWkHhSH9u
 U9DwLgbN81y/YWUWL3TpGu90pNFZfq+YU3HQ1BXDECEXM+39Ph3aQ9FJmIC26GuPn6qz
 Qs2Avo/FBB3CO43s/pHXQEmiJ5T5wxMpwxCYgCfltBsM/4IzIhQCm//mIADBiH6+7N5q
 5zOzPZdpESeSwf144sgbqSeQWNWTbh6gCE3VN58dufvJZOCYkz5rLqFuNaPtAu9MZcns
 DkS5i0Elbz3dz86vU1z80Ev8Gnxo/zxH9UREeYTlDtxWBe9CncRz8/ALDI6cPZvRw6Xo 8g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k00urd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMXP44028373;
        Tue, 17 Jan 2023 02:35:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfy4x-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZKkjrKs7Tb7LymOYgv8LLB6ayKsF/9IlGrO2Z8gNcYWuHdFGrlsbTvnG1GWDzXmMFkEF8CBZOG4KV7shVAD1F3zS+LjXYwA8/AksDwTIebJN3veHW7PEmuh2HTrifoymrdy4PMrjPsHnhPdNy/V4kR/E1McStKlVhlK2oTBztn+FTmQUH1WsXun82gV1vT1yGrFuJy5HTO+yOdy7Y3ecNhVaH5+DDDQ1SoOW0F0gAWH8nPTdBWCqwv7pDAH70v9akFXP0iQkWlYU4v5KGc9czUFcggqSOTpMd/lbAu8TIC/onS1U10SsXo3RkIbpu4HyOx1d3GNBQzZH5vwoih5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7sr5iVHvKYFk62UwT4div4O+6ZS/l5NbPF7xnne2Zs=;
 b=WX0UYjUNR+xeNucMQxKsB5AT6UNg1mXg/6px7qaq3kWW8ifhCNynFJJOuWya53y4uQVzyEYXfxMZqCU/pvBoWQr43pGvp+5lHUv/a+pnkDzT5e3K3Sh04VoNVB0avMNP+sBScr/rPnyScVS0hVHr834ePDtP9+Woc7EmvmOccgmHr47+9BxierYZ1uBeNnkkQiHBMIxxkpXXxDXmB3H7kmqjg6+g/sjvXOMw7bWQxx9x82+XrTbHTEOfhpaPOtyw0nCxMxWQpHDT3SEQH+ykYN/x1ewAJ37H96CI2ueyzMCURlPhN+apWLVw/UEht8jJUzN4gPMJLzw1j4LWTk/+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7sr5iVHvKYFk62UwT4div4O+6ZS/l5NbPF7xnne2Zs=;
 b=y5bk7MHaZTCdAFbhBpLC0qtXPL4yeI9u2J6mP2uU4QQeqbF2DjeW0kd1pOfCVEjvCFqmY4zpGunMKLmaCxnHcxj570kxSen7F1mAvoDBJ12GediCPr7zN91e042TpRDtGpVI5h/OLrbPqvkUT5D0L01nZlNojcuii5V2rHc1YMA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:35:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:35:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 43/48] mm: Don't use __vma_adjust() in __split_vma()
Thread-Topic: [PATCH v3 43/48] mm: Don't use __vma_adjust() in __split_vma()
Thread-Index: AQHZKhw1lelKLQnJrE+ABWDHhZ1aww==
Date:   Tue, 17 Jan 2023 02:34:23 +0000
Message-ID: <20230117023335.1690727-44-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4814:EE_
x-ms-office365-filtering-correlation-id: 6432fd92-de44-4a51-410e-08daf8336eec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EQun1kJHLKvVfJrpj0a8X6SN8t4YsmdndkMdyw6s7LSur6/82JbzRHgneYTvejXarHE/73qCrHCEGy92O+bfVcuxZXoOdmGuT7AujSWkZy1uU8J+AZG6pKfY07wJJmknlV0hP+2jRUJnlU1+fHW7jna/wS4ZXdqdNCJPaZZ9ovKrshCU3Um/hkhP/2oBK85+tsI+a7NT6/YaipCpAo3W/qL/YkR1TLMW4LBr2zDq1NE8mKeF0mnFp8/VrsGhocSnFjNLMUJYgFLHURCgY9vYNjvgVDJhVhvg7MSXayiMryQJrC5Uz61euSXsL46FU2cDw022bX1TuVzhRhT9oip32CI1yeR0cClWuNoEWbvltwtVsKZILqUog0AA9gSwfA+D2m4dgzdr66JRcp/WwZNXhGA49RoWyqMG7dhhVaJtM4u2dvkAt6Jy4tK/woLRec+JzskzJZQY7/wYD7muetFhdg9C7BiLlVaOJGp1vZlk6lQn30scM3JCje9bz1puk7raYnuOpQw3TDqjkrgc3WfUc2DUexNGZcQR9rY3f99CuIjPsfYfxOr1uCtMQO35OI+m0efPx6v2EvCYpGn1DU4kDy7GuEz0cXew1VoYNs8ac+OtjRR/80hy1CKWV1i7H1IMxM/Gyba+cPLfxrmrkoFuEVLlqVJufH44pk2/RAbXKZO4AZ/9BFxjXpS2gcff6IPLYjzWl2PpRaL5nsrII3C/ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(6486002)(6512007)(478600001)(186003)(26005)(6666004)(107886003)(71200400001)(6506007)(91956017)(66556008)(66946007)(2616005)(76116006)(66476007)(122000001)(110136005)(316002)(64756008)(8676002)(4326008)(54906003)(66446008)(36756003)(83380400001)(8936002)(41300700001)(1076003)(44832011)(2906002)(38070700005)(38100700002)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tlm4Kcv0r1Lc6SweG9lywdTJzQqYLDZi3rvHmSOHXZhbCMeJQj41HMVzPO?=
 =?iso-8859-1?Q?i9KgrkylVV4n90IPJ1Pdc8/9bGgOHp4QIoqRMXhGWGnmK8zb1vVBFhv/dI?=
 =?iso-8859-1?Q?KVwARmbt/lfmxEwWWR1BHb/aizbB+/I0I1nrDCe2r5teb7w0LcPdSp5JAO?=
 =?iso-8859-1?Q?YkYOEbZXVvklUCH6pYhAT8BBJSYJ+wDOCVnjsJ14X0pVZ/xVB9uHaV365Y?=
 =?iso-8859-1?Q?VqCyF2GkDFhqfA5a6SqlX7NoHT92iu33eEqY9afX66wAh3TsjBApsPvYtA?=
 =?iso-8859-1?Q?EGOAYNrfawahfFSJlOZYGVq22H7ce0wzIh6bf1Y/HVfKS03GVWYAcb4Juv?=
 =?iso-8859-1?Q?u2SLzJzJud9aFIMjEv79x8qhnS1DnfspQ0jOM8V379iNi29200EyDd8KUC?=
 =?iso-8859-1?Q?SpIfg0OfS7aaTztbSiSugk27UHhTyvMDgHQ4CNZKMKubqNiqzxV36mLrlD?=
 =?iso-8859-1?Q?4AunSU9FcZx/q88acS6y3HLUC1W8LKchfQqf7+TVgtqpKb60P5s88YmUf2?=
 =?iso-8859-1?Q?9/dnqPkTGDLedbgiFlsqUBNwpe4cbjRlvY8PgAwSELv8BIYh1C7AHrP3B5?=
 =?iso-8859-1?Q?xzG/CA9J9ZHmZDqE4nzG7odBb0Bnudk5CBCD3BwL8MJ5ZogArZdIf0oz23?=
 =?iso-8859-1?Q?LNvuWI5RkElRlp1Lj413MtEVbY4PUTRnKX+Es3SsaOL86vUf0YBdcCFATe?=
 =?iso-8859-1?Q?1vdzymiOGC7DYaJEckMoDZ0ohpuI7s9zIsm0amcWKilBsxMOb+s6GsvuwI?=
 =?iso-8859-1?Q?WwIxt/flTsBRqxT82NneCcWzV5LvbmtzcT7tVyZVl2L/WQnONZPrP7611i?=
 =?iso-8859-1?Q?dcwLYtBY0Qhk2JckN4gqHdHSB62afb090w2FaM4FuuPo+998pwJWxg94DW?=
 =?iso-8859-1?Q?3Uav78W1bSWDuCH8dXSREDrW2keMRQBlS1QoxJthex9GYVgc95nU+rhRXf?=
 =?iso-8859-1?Q?LacZTCC1Gps+M2p/aPLB+oDmMHY16oxxoWSUy5LdawydiyTkNE7qYKXnBy?=
 =?iso-8859-1?Q?yVQWKBNUTkPljOF8zXD8b7Dt2N31ts1F59XJBfYzZJiVvS99vAkomVEqR7?=
 =?iso-8859-1?Q?4CSbPXHFm3MroYvRhPVVyoF6eSQBorx3mMrco+Rr2G/R9QlpCxs4ya6MOe?=
 =?iso-8859-1?Q?fPO7ggpwyfJwUGHxVbQANV0TxFwCPobOs5DHPceOKfGtMs64F6KUP9aH3o?=
 =?iso-8859-1?Q?bdMUcLrp1gOcHpmWtp7z33fcOLF07xrb6Yeq46hZHZdBelZEv63Q+00t+0?=
 =?iso-8859-1?Q?9i5U7uNaZ8i3GwPlKNecbFe4w5eSmIUuSo8547lxa0MxhtoQYA4Q4wjbRK?=
 =?iso-8859-1?Q?eD/CnjCNy4Ujj4qGUWv5JssVf8YjZlF3ghP+Qt7bhsaNHDpdzWzBVBKu4m?=
 =?iso-8859-1?Q?Tn6k3/bhUD87GvBhIHDAQLt9CDSS0/dJ6SOHxvVfICXHJ/hRijJXhcL2yh?=
 =?iso-8859-1?Q?KYM5B4v7SnisnE7Y9vM36NXDM+jSJU5tOa+Aje6NF7GVKt6xQA9GY8cIKq?=
 =?iso-8859-1?Q?Sbj9I6jAtpWla+re97Ew3G3326FcusLig2c1KBHihV5ajO+eeeXEziUA3l?=
 =?iso-8859-1?Q?ezn947cUp0uIqhLX1IzXL+3J8vCtoyZKyoTzEFZMZOj96x7Qg+9vBqCSwn?=
 =?iso-8859-1?Q?fPYRk95x2D7KCfQvx74jCpK3I2fTpJRxPusl987yyFSHE/4MSbxn07XQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NzSkDZQ0JH44qL4vhsSJytwMRPIZI3UQ/Zah7mmutvoN0b+QYe18yOazic3CDYDz4jFfR2fXiNuJCmmqbnArehyNpwIsqoOsBYAMt7bNN0zbsXGvKQkO0iTI6NgtwdwawGsHz0IUex7GD26PhhWnuPFD6XyxlT8akx7gBHT8VcKaMgIoM0QSu0yiqLoG+JQ5YQMD0V97qGPAwPpLPoyW9t6aIzJ7FatU09WslxRV+fL6Ihy7SvoO1e3rhAkUtbJYpeqiSxbjHWbSn1iaNoUs0Biqli6A3ypwXANhmYo1j3JdEI5kzFLcKlTj0HTRCfqjjMC9laE4CSRSsSCV/KmA1rf0JXL7IhMAP5yTFgRSsogRJzW1NGtOlQpQ0lVHzvEdEERfHwy1UICwMyWLwQN1cI+NWq6XbVraypySUutqlS8SWFNrY5NN6GRBMlVyMTvoEHC26nLkHpdO8ebRyZY8P9eiUt2X5+YwiE+te8VUQWkHIme6ar8wrrEQ+T58M/9nJNL4de+tYSQVm/9MMCya9C6aEA3wGJ3nrk6FFX8Z669nECVjMpqrwTwKyy5MZZzRbrFhK24d5zSLr/XLJ7kvlFcAvVraqzKvvJlpygHudaCnth7FkhDFY38ZMd6rBANYp2SZrgGIvXUe1Jv2+Yn/29Sxc6fpGxjS3UDOMaD22qzrKbFP3pTcGkDJo58htPnxx1kY6p2W1HTq+pTpwOklQrdLWOuIWyqtuy6hMrnEWv/2tKb2LcBP8mdPYUy/rhX8Ql79SmMSfMpvaZ+8qjpWTMsxkOGo4jcq6YdEmg3ZfKUTTKlruV5uosskcveFTb08fTUKaLDAZTt1Ic15Frc7m/lkNeQGnjxjRG5dkasDyaXe3/IunUxBM6JGrzNS3B94ZWzxbx6tBw+T5HXLDwe4uQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6432fd92-de44-4a51-410e-08daf8336eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:23.2807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TLanOlU6LzVhPfsnr6EZ3MLAO3Gyzi1KGhNfptDmw2WijGSpNMwhn4ouMjFzUBsf4MHlGcrogMcjdooy8ok0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: 3XqVJOyntCXhegs5hRvCD31zP9ja2_bF
X-Proofpoint-ORIG-GUID: 3XqVJOyntCXhegs5hRvCD31zP9ja2_bF
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

Use the abstracted locking and maple tree operations.  Since
__split_vma() is the only user of the __vma_adjust() function to use the
insert argument, drop that argument.  Remove the NULL passed through
from fs/exec's shift_arg_pages() at the same time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c          |   4 +-
 include/linux/mm.h |   7 ++-
 mm/mmap.c          | 118 +++++++++++++++++++++------------------------
 3 files changed, 60 insertions(+), 69 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 76ee62e1d3f1..d52fca2dd30b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -699,7 +699,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
+	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff))
 		return -ENOMEM;
=20
 	/*
@@ -733,7 +733,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
=20
 	vma_prev(&vmi);
 	/* Shrink the vma to just the new range */
-	return vma_adjust(&vmi, vma, new_start, new_end, vma->vm_pgoff, NULL);
+	return vma_adjust(&vmi, vma, new_start, new_end, vma->vm_pgoff);
 }
=20
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index aabfd4183091..a00871cc63cc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2823,13 +2823,12 @@ void anon_vma_interval_tree_verify(struct anon_vma_=
chain *node);
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sy=
s_admin);
 extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *v=
ma, unsigned long start,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
-	struct vm_area_struct *expand);
+	unsigned long end, pgoff_t pgoff, struct vm_area_struct *expand);
 static inline int vma_adjust(struct vma_iterator *vmi,
 	struct vm_area_struct *vma, unsigned long start, unsigned long end,
-	pgoff_t pgoff, struct vm_area_struct *insert)
+	pgoff_t pgoff)
 {
-	return __vma_adjust(vmi, vma, start, end, pgoff, insert, NULL);
+	return __vma_adjust(vmi, vma, start, end, pgoff, NULL);
 }
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
diff --git a/mm/mmap.c b/mm/mmap.c
index b28f3416b60a..a8c941e3be84 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -695,7 +695,7 @@ inline int vma_expand(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
  */
 int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	unsigned long start, unsigned long end, pgoff_t pgoff,
-	struct vm_area_struct *insert, struct vm_area_struct *expand)
+	struct vm_area_struct *expand)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *remove2 =3D NULL;
@@ -708,7 +708,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
 	struct vma_prepare vma_prep;
=20
-	if (next && !insert) {
+	if (next) {
 		if (end >=3D next->vm_end) {
 			/*
 			 * vma expands, overlapping all the next, and
@@ -799,39 +799,25 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	VM_WARN_ON(vma_prep.anon_vma && adjust_next && next->anon_vma &&
 		   vma_prep.anon_vma !=3D next->anon_vma);
=20
-	vma_prep.insert =3D insert;
 	vma_prepare(&vma_prep);
=20
-	if (start !=3D vma->vm_start) {
-		if (vma->vm_start < start) {
-			if (!insert || (insert->vm_end !=3D start)) {
-				vma_iter_clear(vmi, vma->vm_start, start);
-				vma_iter_set(vmi, start);
-				VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
-			}
-		} else {
-			vma_changed =3D true;
-		}
-		vma->vm_start =3D start;
-	}
-	if (end !=3D vma->vm_end) {
-		if (vma->vm_end > end) {
-			if (!insert || (insert->vm_start !=3D end)) {
-				vma_iter_clear(vmi, end, vma->vm_end);
-				vma_iter_set(vmi, vma->vm_end);
-				VM_WARN_ON(insert &&
-					   insert->vm_end < vma->vm_end);
-			}
-		} else {
-			vma_changed =3D true;
-		}
-		vma->vm_end =3D end;
-	}
+	if (vma->vm_start < start)
+		vma_iter_clear(vmi, vma->vm_start, start);
+	else if (start !=3D vma->vm_start)
+		vma_changed =3D true;
+
+	if (vma->vm_end > end)
+		vma_iter_clear(vmi, end, vma->vm_end);
+	else if (end !=3D vma->vm_end)
+		vma_changed =3D true;
+
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
=20
 	if (vma_changed)
 		vma_iter_store(vmi, vma);
=20
-	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
@@ -850,9 +836,9 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
  * per-vma resources, so we don't attempt to merge those.
  */
 static inline int is_mergeable_vma(struct vm_area_struct *vma,
-				struct file *file, unsigned long vm_flags,
-				struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-				struct anon_vma_name *anon_name)
+				   struct file *file, unsigned long vm_flags,
+				   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+				   struct anon_vma_name *anon_name)
 {
 	/*
 	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
@@ -1034,20 +1020,19 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
 			is_mergeable_anon_vma(prev->anon_vma,
 				next->anon_vma, NULL)) {	 /* cases 1, 6 */
 		err =3D __vma_adjust(vmi, prev, prev->vm_start,
-					next->vm_end, prev->vm_pgoff, NULL,
-					prev);
+					next->vm_end, prev->vm_pgoff, prev);
 		res =3D prev;
 	} else if (merge_prev) {			/* cases 2, 5, 7 */
 		err =3D __vma_adjust(vmi, prev, prev->vm_start,
-					end, prev->vm_pgoff, NULL, prev);
+					end, prev->vm_pgoff, prev);
 		res =3D prev;
 	} else if (merge_next) {
 		if (prev && addr < prev->vm_end)	/* case 4 */
 			err =3D __vma_adjust(vmi, prev, prev->vm_start,
-					addr, prev->vm_pgoff, NULL, next);
+					addr, prev->vm_pgoff, next);
 		else					/* cases 3, 8 */
 			err =3D __vma_adjust(vmi, mid, addr, next->vm_end,
-					next->vm_pgoff - pglen, NULL, next);
+					next->vm_pgoff - pglen, next);
 		res =3D next;
 	}
=20
@@ -2187,11 +2172,15 @@ static void unmap_region(struct mm_struct *mm, stru=
ct maple_tree *mt,
 int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, int new_below)
 {
+	struct vma_prepare vp;
 	struct vm_area_struct *new;
 	int err;
=20
 	validate_mm_mt(vma->vm_mm);
=20
+	WARN_ON(vma->vm_start >=3D addr);
+	WARN_ON(vma->vm_end <=3D addr);
+
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err =3D vma->vm_ops->may_split(vma, addr);
 		if (err)
@@ -2202,16 +2191,20 @@ int __split_vma(struct vma_iterator *vmi, struct vm=
_area_struct *vma,
 	if (!new)
 		return -ENOMEM;
=20
-	if (new_below)
+	err =3D -ENOMEM;
+	if (vma_iter_prealloc(vmi, vma))
+		goto out_free_vma;
+
+	if (new_below) {
 		new->vm_end =3D addr;
-	else {
+	} else {
 		new->vm_start =3D addr;
 		new->vm_pgoff +=3D ((addr - vma->vm_start) >> PAGE_SHIFT);
 	}
=20
 	err =3D vma_dup_policy(vma, new);
 	if (err)
-		goto out_free_vma;
+		goto out_free_vmi;
=20
 	err =3D anon_vma_clone(new, vma);
 	if (err)
@@ -2223,33 +2216,32 @@ int __split_vma(struct vma_iterator *vmi, struct vm=
_area_struct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
=20
-	if (new_below)
-		err =3D vma_adjust(vmi, vma, addr, vma->vm_end,
-			vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT),
-			new);
-	else
-		err =3D vma_adjust(vmi, vma, vma->vm_start, addr, vma->vm_pgoff,
-				 new);
+	vma_adjust_trans_huge(vma, vma->vm_start, addr, 0);
+	init_vma_prep(&vp, vma);
+	vp.insert =3D new;
+	vma_prepare(&vp);
=20
-	/* Success. */
-	if (!err) {
-		if (new_below)
-			vma_next(vmi);
-		return 0;
+	if (new_below) {
+		vma->vm_start =3D addr;
+		vma->vm_pgoff +=3D (addr - new->vm_start) >> PAGE_SHIFT;
+	} else {
+		vma->vm_end =3D addr;
 	}
=20
-	/* Avoid vm accounting in close() operation */
-	new->vm_start =3D new->vm_end;
-	new->vm_pgoff =3D 0;
-	/* Clean everything up if vma_adjust failed. */
-	if (new->vm_ops && new->vm_ops->close)
-		new->vm_ops->close(new);
-	if (new->vm_file)
-		fput(new->vm_file);
-	unlink_anon_vmas(new);
- out_free_mpol:
+	/* vma_complete stores the new vma */
+	vma_complete(&vp, vmi, vma->vm_mm);
+
+	/* Success. */
+	if (new_below)
+		vma_next(vmi);
+	validate_mm_mt(vma->vm_mm);
+	return 0;
+
+out_free_mpol:
 	mpol_put(vma_policy(new));
- out_free_vma:
+out_free_vmi:
+	vma_iter_free(vmi);
+out_free_vma:
 	vm_area_free(new);
 	validate_mm_mt(vma->vm_mm);
 	return err;
--=20
2.35.1
