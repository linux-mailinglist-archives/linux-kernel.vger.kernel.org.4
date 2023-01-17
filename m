Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E2766D462
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbjAQCgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbjAQCfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:35:03 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E3E2B0A7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:30 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09X4n006400;
        Tue, 17 Jan 2023 02:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Rj+ExYqI98+tOrvVnQFf1t//d9d9F1VxS105W7RPcVA=;
 b=HutvgOQGDH/WW2+GbrDy/FZD86TJy4R/X+njBMbjKP8Rm3vMOZ6fgpvBIFEAzQaMFyJH
 /N80i5TQ1i6fguaeClTjEO7FLvk1xdJ8ndb690WVsaeWxlbEsXwFtp1zRz/EHKG5a+mc
 lJGaNm8rpjghxFGetqqig8qb02Ve1Fp6+Sj5HZOdxn+ySRy47edpM+8/zHwUa+pDjge8
 LCBsbFwld8bEp7Je5C83zQbLD+cUOvKbPEhQ5EIWsYR0fdVP7PO+7gcHvCe79y/91RIC
 mf4wbKVNKrimMdIsGLquPWZjvmtfiQn9A0ekMBbdAOZofBPFiuq2DlQvlnGgu3j+16DU 0Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaabrjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNXAUS020577;
        Tue, 17 Jan 2023 02:34:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq37hat-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlHLUE+WOMrxYh20BTgb3z1ma0nE56a7Zy0413TziIt1JF/J2bM6/frqAele7nQdpCGYqsD2S1Rd/pklsFMwsPWeNe1WW+dXIg/0bDEYAyxmMfJXgwgOjBJYQIL0NgZN9TFCxKdOPsSu1szjblFCebCaIvxzzH8ioFiFufge13oEgy/jiGVEec6P67az8txgqM8crnbYOHqBXTnv8OtQYiHGu8Gys+v1xlJSSeaTnXYCTHUyeZTZBht7f7RTBBZF+f7dgiCMMQrjBvlTGLdDHnw/LjhPPlh+/8zWKM1jM5Hcfi8T16W4WnkxAdBsOwv7cSwCJsqSe9MVh4kWwW1wKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj+ExYqI98+tOrvVnQFf1t//d9d9F1VxS105W7RPcVA=;
 b=f1eWyU8y95P55en1zHx4pZl53BHCimmz7iD7ljdP8xb53GOEbmRzFeLrNb/vOqB8L+HlN7taV9W5R765C1vEhF+Jo+zf7EUFqYyzS3KSmWLMidUYX2XF1aYDwXM3XClpLDWr+oMJKWf+9ieFCgJ2e4OU9XseBHJitMJmBbVSVnrfSNxWCkV1jkcaZD5DzGqV/Os6avHgPWdBkNBZTkXO5k1C4/GbFAlHR/UGHrFMP/41sjkgkSuXowFfiWn5biqUHT9LyK9u9ZF9qhhjXYRRWHZwFXgCbGQLmISRRlJ6AZsHA/BR+8NCMbbp1YaJaEDHLbs9WSA7ngyKnS66ZDqnrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj+ExYqI98+tOrvVnQFf1t//d9d9F1VxS105W7RPcVA=;
 b=L2cax3kG3a1A5HchyyRNff7zttJyEUVkTpFP2iqamK6O1/rkX/Hjzm7l4URDjv2HRE8d70CDkEhKfyHeUa3ggMmrs0EoX6ltp/GproickixRO9mtVOBplVV69L1GcbZsKs+a23i50eyoyVTPFYZrRsy+7u3c5MC7bqWzStnF+UM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 12/48] mmap: Change do_mas_munmap and
 do_mas_aligned_munmap() to use vma iterator
Thread-Topic: [PATCH v3 12/48] mmap: Change do_mas_munmap and
 do_mas_aligned_munmap() to use vma iterator
Thread-Index: AQHZKhwwNBrUMvIX0ESUjoQ+CGcxaA==
Date:   Tue, 17 Jan 2023 02:34:13 +0000
Message-ID: <20230117023335.1690727-13-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: b70730b8-18d8-48d7-2a78-08daf833533a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mMqm+zY67XWTSO67Pn3Z3LTe3crnDgOyoHSaErxgY/kCWwzELHnEeZjltoMO+z3Lka1UnYnDqQCM5oSXdtZBB/o+kX4vY5u3pvyc9EcPl+GsBVgujsj9o4Iru9mIZbWGM+8np3PwrITt9P3PtU/GmxeNh7bNMIbZ/PG6PPYCYgcKmtSRCC6+gGQmydPk7qZLpPekOy7R4NludSs7E+HwbObsnwipeLBEBZntvpGtZG0IN5A7+8hWLzXTQKF6JxCT/QvX2nVwGvCbSa6hP6ozS8eM6IIy+SWpbKADwlXCVd7IUbDALXxb3OEacs4hd4rXwJANqdNIFw89gfWmqaqj6IZUuEpcgFQFaONoNu+w/3qmOQ8sk+hy7qDFZUjdvrn0QNlpH28LsXCuRxlQLErTNQTrdICD8EGHl1RrWSWGl3T1L2qYyCtQ4weuQINzpWm8nvIkRE3ns2ET2/G//miJP1HFKmtQpSWbGnbCPFFdE9wLR6DXoPH2vMUHojjXYuweoEALg8vCCQDGjl4AjaSKwdMOr0sM5mG07c9a3dPH+kRCGMjWZFeVPOLIyKXn81ujwlvhHAyf0W5KIG2//9K7l9X+94BEzSl76szlnKEYOFvth9OjET5JD3TDULhiz+hFn4F7o8oc9N0xDl/KDoSWPkscfzIlMjBBj77wwdsHkEav8HfLIe0Atje1cUulSlaWgi2IwJwdLC+Lqtor++QOSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(30864003)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(66899015)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iCqSXdS/vLfpYUembzvN7kCo1KrEzfCHsXjCaT4H1C58FoyLgSGHznqRK3?=
 =?iso-8859-1?Q?bZs7AKb21z7wNAr/uR3lqnLE5QZITSCVgiXA1C98NeNL4tynY85eBzV58P?=
 =?iso-8859-1?Q?TjwlaytRTMDJCFhVQCOFIogbw+KvoZF59RoHlvIO9HJsYTZU6gcUFazssS?=
 =?iso-8859-1?Q?Twa49RP7g7UNqMM3Go5Y5wSbR2mWfpDwhpA0no0aLJ+2LEuklESZREKk95?=
 =?iso-8859-1?Q?o99pfWwljBk8JWO1IlxbUoVzXejlrZod2MJL4IYrXCqQO4DDFVuyYrdx/r?=
 =?iso-8859-1?Q?k3wuuZo0t3GPm7wMVveioSlUPcD6B4QDRLhqbwzR4onLOxcsn0u3gIQx8X?=
 =?iso-8859-1?Q?loGMHq0T7KwIhTddjGqEvQlxeqPgFqYmsL9CJwSV6Zt1A32vzfAluX09IR?=
 =?iso-8859-1?Q?FMW41zfRXU+VFOUOmjwvNfFnr4fsUfzOdSZ7piWPl9Mq7jxiztDgu8DfnG?=
 =?iso-8859-1?Q?S5aODcA+yV9zbOzh38j7nvXZ95CUKrVguKdi7YJAwDgN7X19QKe88pqD9S?=
 =?iso-8859-1?Q?ldpQsVUl4hPmgDNCTtMTTha2ZaikC6Ig66RHVggCGtFwxzDBuWO8qDxqj9?=
 =?iso-8859-1?Q?Snf7fVZePB8cUQs2zBaHFMrbP00RR+e2dYHHYJwUC3NhLiYkjLfE3QU2nZ?=
 =?iso-8859-1?Q?KGxNFVkhYpbOix1HLYeNpJqBHREJgbXAdaes7Kk18veQZcMNakcJU6weU5?=
 =?iso-8859-1?Q?0SYqx5uX1R7r3DvIHxoRy0Vvgb/EXBlvnPDGd7Kkp4ltmik9b4+VDevMX5?=
 =?iso-8859-1?Q?5sPamLQvlOKeZdhX8JkjTHr3xi5lDXc1v06yoALvkIakjBMYaOL6mR1GAR?=
 =?iso-8859-1?Q?sC+BV4USLjdX46IaGGHHbtISCu6fG7C1B34NXCuo9bELIxgLSbIpxVqnUU?=
 =?iso-8859-1?Q?PFr6ZQucXLVerzzMa1ccXhpbd9tYP0AiUeC4RtZ7WLJxFy3Qyv0hcFGsjQ?=
 =?iso-8859-1?Q?PFt47WOoaRIJYYqejSbpaQ/KSevOiKKGzRWPui2CKxnpFJxi9pQ4Xnj3pT?=
 =?iso-8859-1?Q?kPq4kWT/GR7doUchFdBNvVaoynY00Ycg7V8KZkVHY1n8SDa0UoZNoPoGEo?=
 =?iso-8859-1?Q?bjqiArsNZ490tFaEWV54tVaFNUXW5QRzDajRLfeqGV+USyPU9erDoggnYB?=
 =?iso-8859-1?Q?z5viW5BTNOdkzpJ7TxeXzJrZEMHbBtl/UmSnTLzRxUlr8BbVY9+4loD6KZ?=
 =?iso-8859-1?Q?a9YGEPK2ioAwbntsVUWOePf6nK8lhHo86T83Wu5KZmoEe/AhjicVRdVvVW?=
 =?iso-8859-1?Q?BrB3A+cosXaCqngFjxDDxGcqJaGj1wgtVi1ZofdJfblAFOAALR7HQ2bkEH?=
 =?iso-8859-1?Q?5t86d2P+YJ3PooyJDh5PSYjb8Fj1W1KkbDIhVf9PA7vp6auMFWtNrQlnra?=
 =?iso-8859-1?Q?9XjEzFJsPlHINe1Njz0sA9SLVGRoi/r18ssv1QuXs9u8zgi+oCzpoHEEad?=
 =?iso-8859-1?Q?cf2SOW81kDpqW+X4s6wnt9sj9WCVZVPDhBxDgYiPQ6R/9TYm53NwZP/yTy?=
 =?iso-8859-1?Q?XxMfh+EFEHApzDfUPLqOEK+Mfjvq+PG6IbmY5IP5adck3C/wP94UbRy9wt?=
 =?iso-8859-1?Q?DffoGpmiiOtyqCv/gtb94NZj3HMoOrb3PsOHDZwLDU65N4cft1v6RihfiE?=
 =?iso-8859-1?Q?t+jRJTWO3ubHCCOrimaTEDg1iCArs11QQbUJa9i3u9TbaAusdMD0ZUZw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TGsQfAM4znuzKfwJjx1belYq6WL/a/ozFV5OnfdTPVOZilJUC5GYO0/es1O1UIZM251Ew6It9itjh2sN2RbiLXhptYG3R2W6U2VldUvr/WlO9O1y/PldNBiEJ+bcp4AjXWaoJT7NdHbV9tDw4gb67pkA9uoxV9tZQXOfD9Np9VtBjPcD7+gmlEkIy5fba+IDEHQBgfKuaxFipzRIk42weuQfdnpuMgkmOBDJbwN7V/p4xn0fyNetWuNh4ksvmzxJEg54i5Cx5Yy4pWwPUG41omGovahZP9Sd2iaMsLbENkQ/mx6/+5JWAkV8nobdmIr18Ug4GsniTvLri96PHK5Di8vzoN1F8DPTg7OYG2W689EG5MfEumjXrsC2TcSdhajcrU41WLYA3byV8lP7lxQYf8kuD8InqTzwXmu+QUZX819IdxbUxUsVazdY3uMu5EW6jleR0Rd9rlhK1aLT1iefSbzpXQSsMddfAwZ3XrtY/QbIGWUMyAFPfVgRqijShj9V4LAiG+ucXH99NR/fF5gCaJtS9uvtJC15Fasg7O7bI+Uuu6uEp/3fplqK+sszLjRSm48y5bZJrnxAt762prAJyjpgUBEdRhvjEI8CR8MxkUPBX0l4xciAfzzNNWFGN048t4eJDy7urq98K6lNaQJoSdovsuyByt9KvnW9Fs10pjVOdIRiaU/Y01bheqBf/5oOHVlME4/XGSmSyTKPwD/CnlO2IRArp4qCctrtdQ6eEVWBYHppM2JrAL4ODobWPOlqIgwpaBZJEgv/X8H47c+904fS/oRKXJXdywUG/44Fk2XVKbIdyxsDbObQ38x8yz2XxcTcVtTLoXsT90WnV0Oceoi9yUJuTQnl/PL/ECSfc4efR/poSJ4EH/Zx2EXi0tLku4dF1tEfjpLLoDQj5wkH0w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70730b8-18d8-48d7-2a78-08daf833533a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:13.9844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmHAeC380jxjAQXoFpd2wAXQlPQHjpHq+FiV1ftsS02Y3oFta1Hq34DNnR6DVPsWH52mEbcWRQxoQWsmy3nKnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: OwpfypoI7AoSeChJCIIQztmZbJfgaClM
X-Proofpoint-ORIG-GUID: OwpfypoI7AoSeChJCIIQztmZbJfgaClM
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

Start passing the vma iterator through the mm code.  This will allow for
reuse of the state and cleaner invalidation if necessary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h |  2 +-
 mm/mmap.c          | 77 +++++++++++++++++++++-------------------------
 mm/mremap.c        |  6 ++--
 3 files changed, 39 insertions(+), 46 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f4b964f96db1..126f94b6f434 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2896,7 +2896,7 @@ extern unsigned long mmap_region(struct file *file, u=
nsigned long addr,
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
-extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
 			 bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
diff --git a/mm/mmap.c b/mm/mmap.c
index 1d18e8e219ff..364b1abd8ddf 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2301,8 +2301,8 @@ static inline int munmap_sidetree(struct vm_area_stru=
ct *vma,
 }
=20
 /*
- * do_mas_align_munmap() - munmap the aligned region from @start to @end.
- * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vmi: The vma iterator
  * @vma: The starting vm_area_struct
  * @mm: The mm_struct
  * @start: The aligned start address to munmap.
@@ -2313,7 +2313,7 @@ static inline int munmap_sidetree(struct vm_area_stru=
ct *vma,
  * If @downgrade is true, check return code for potential release of the l=
ock.
  */
 static int
-do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool downgrade)
 {
@@ -2325,7 +2325,6 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
=20
-	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2345,27 +2344,23 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
 			goto map_count_exceeded;
=20
-		/*
-		 * mas_pause() is not needed since mas->index needs to be set
-		 * differently than vma->vm_end anyways.
-		 */
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
 			goto start_split_failed;
=20
-		mas_set(mas, start);
-		vma =3D mas_walk(mas);
+		vma_iter_set(vmi, start);
+		vma =3D vma_find(vmi, end);
 	}
=20
-	prev =3D mas_prev(mas, 0);
+	prev =3D vma_prev(vmi);
 	if (unlikely((!prev)))
-		mas_set(mas, start);
+		vma_iter_set(vmi, start);
=20
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	mas_for_each(mas, next, end - 1) {
+	for_each_vma_range(*vmi, next, end) {
 		/* Does it split the end? */
 		if (next->vm_end > end) {
 			struct vm_area_struct *split;
@@ -2374,8 +2369,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 			if (error)
 				goto end_split_failed;
=20
-			mas_set(mas, end);
-			split =3D mas_prev(mas, 0);
+			vma_iter_set(vmi, end);
+			split =3D vma_prev(vmi);
 			error =3D munmap_sidetree(split, &mas_detach);
 			if (error)
 				goto munmap_sidetree_failed;
@@ -2397,7 +2392,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	}
=20
 	if (!next)
-		next =3D mas_next(mas, ULONG_MAX);
+		next =3D vma_next(vmi);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2422,10 +2417,10 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count =3D 0;
=20
-		mas_set_range(mas, start, end - 1);
+		vma_iter_set(vmi, start);
 		rcu_read_lock();
 		vma_test =3D mas_find(&test, end - 1);
-		mas_for_each(mas, vma_mas, end - 1) {
+		for_each_vma_range(*vmi, vma_mas, end) {
 			BUG_ON(vma_mas !=3D vma_test);
 			test_count++;
 			vma_test =3D mas_next(&test, end - 1);
@@ -2435,8 +2430,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	}
 #endif
 	/* Point of no return */
-	mas_set_range(mas, start, end - 1);
-	if (mas_store_gfp(mas, NULL, GFP_KERNEL))
+	vma_iter_set(vmi, start);
+	if (vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL))
 		return -ENOMEM;
=20
 	mm->map_count -=3D count;
@@ -2474,8 +2469,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 }
=20
 /*
- * do_mas_munmap() - munmap a given range.
- * @mas: The maple state
+ * do_vmi_munmap() - munmap a given range.
+ * @vmi: The vma iterator
  * @mm: The mm_struct
  * @start: The start address to munmap
  * @len: The length of the range to munmap
@@ -2489,7 +2484,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
  *
  * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
  */
-int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool downgrade)
 {
@@ -2507,11 +2502,11 @@ int do_mas_munmap(struct ma_state *mas, struct mm_s=
truct *mm,
 	arch_unmap(mm, start, end);
=20
 	/* Find the first overlapping VMA */
-	vma =3D mas_find(mas, end - 1);
+	vma =3D vma_find(vmi, end);
 	if (!vma)
 		return 0;
=20
-	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
+	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, downgrade);
 }
=20
 /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() cal=
ls.
@@ -2523,9 +2518,9 @@ int do_mas_munmap(struct ma_state *mas, struct mm_str=
uct *mm,
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	MA_STATE(mas, &mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, mm, start);
=20
-	return do_mas_munmap(&mas, mm, start, len, uf, false);
+	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2541,7 +2536,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	unsigned long merge_start =3D addr, merge_end =3D end;
 	pgoff_t vm_pgoff;
 	int error;
-	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -2559,7 +2554,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
+	if (do_vmi_munmap(&vmi, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2572,8 +2567,8 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		vm_flags |=3D VM_ACCOUNT;
 	}
=20
-	next =3D mas_next(&mas, ULONG_MAX);
-	prev =3D mas_prev(&mas, 0);
+	next =3D vma_next(&vmi);
+	prev =3D vma_prev(&vmi);
 	if (vm_flags & VM_SPECIAL)
 		goto cannot_expand;
=20
@@ -2601,13 +2596,11 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
=20
 	/* Actually expand, if possible */
 	if (vma &&
-	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+	    !vma_expand(&vmi.mas, vma, merge_start, merge_end, vm_pgoff, next)) {
 		khugepaged_enter_vma(vma, vm_flags);
 		goto expanded;
 	}
=20
-	mas.index =3D addr;
-	mas.last =3D end - 1;
 cannot_expand:
 	/*
 	 * Determine the object being mapped and call the appropriate
@@ -2646,7 +2639,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			error =3D -EINVAL;
 			goto close_and_free_vma;
 		}
-		mas_reset(&mas);
+		vma_iter_set(&vmi, addr);
=20
 		/*
 		 * If vm_flags changed after call_mmap(), we should try merge
@@ -2692,7 +2685,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+	if (vma_iter_prealloc(&vmi, vma)) {
 		error =3D -ENOMEM;
 		if (file)
 			goto close_and_free_vma;
@@ -2705,7 +2698,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
=20
-	vma_mas_store(vma, &mas);
+	vma_iter_store(&vmi, vma);
 	mm->map_count++;
 	if (vma->vm_file) {
 		if (vma->vm_flags & VM_SHARED)
@@ -2766,7 +2759,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	vma->vm_file =3D NULL;
=20
 	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
+	unmap_region(mm, &mm->mm_mt, vma, prev, next, vma->vm_start, vma->vm_end)=
;
 	if (file && (vm_flags & VM_SHARED))
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
@@ -2783,12 +2776,12 @@ static int __vm_munmap(unsigned long start, size_t =
len, bool downgrade)
 	int ret;
 	struct mm_struct *mm =3D current->mm;
 	LIST_HEAD(uf);
-	MA_STATE(mas, &mm->mm_mt, start, start);
+	VMA_ITERATOR(vmi, mm, start);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
+	ret =3D do_vmi_munmap(&vmi, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -2920,7 +2913,7 @@ static int do_brk_munmap(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
 	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
-	ret =3D do_mas_align_munmap(&vmi->mas, vma, mm, newbrk, oldbrk, uf, true)=
;
+	ret =3D do_vmi_align_munmap(vmi, vma, mm, newbrk, oldbrk, uf, true);
 	validate_mm_mt(mm);
 	return ret;
 }
@@ -3043,7 +3036,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	if (ret)
 		goto limits_failed;
=20
-	ret =3D do_mas_munmap(&vmi.mas, mm, addr, len, &uf, 0);
+	ret =3D do_vmi_munmap(&vmi, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
=20
diff --git a/mm/mremap.c b/mm/mremap.c
index fe587c5d6591..94d2590f0871 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -978,14 +978,14 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * do_mas_munmap does all the needed commit accounting, and
+	 * do_vmi_munmap does all the needed commit accounting, and
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >=3D new_len) {
 		int retval;
-		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
+		VMA_ITERATOR(vmi, mm, addr + new_len);
=20
-		retval =3D do_mas_munmap(&mas, mm, addr + new_len,
+		retval =3D do_vmi_munmap(&vmi, mm, addr + new_len,
 				       old_len - new_len, &uf_unmap, true);
 		/* Returning 1 indicates mmap_lock is downgraded to read. */
 		if (retval =3D=3D 1) {
--=20
2.35.1
