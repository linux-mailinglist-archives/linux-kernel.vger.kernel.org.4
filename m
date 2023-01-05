Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DDB65F453
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjAETVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjAETU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:20:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B846E424
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:17:55 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ISlMg001327;
        Thu, 5 Jan 2023 19:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KYM+JnnKnoZTopkYfjEHdPmQECZEXb+C9gXcn1YFP5g=;
 b=sWIkGv9wXTeYcR8jqAqmZjCre42GlIhrHuo5WyAPyuLrCC+Exefn5xepVRE1X1TtxT0n
 L+ZZTvgJXklobnTWD9xQd3xV6N8W8SmBVhzUmX8Vemh9TKhH/ujIcJHb+yYatGcrS7WM
 dzTBPYCeSoMRkh1E9nhhy/tvv/BmC6OwPk5tTSgk+K6sx6ii8LF0hF0+Z4UnE1g3xwyK
 W+qsNXahfte2RObDtNX1d/lob4erJ1DWvCh1vtBStwBafNrQUATlxV9NQ2H+pBKSrBJb
 IwewvUtMKdD7uq+6rogtmYEGF9nIWIfVfwt7kK0mi+PH84YAJBTDnja9DMqwCHS8ynxU aQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c9r18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I1EPo033688;
        Thu, 5 Jan 2023 19:16:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkf7u5p-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTi4WG8RYOjn5kGPXNBYqrmY4q4QuT525L/vTMflJp7KQqcwK5ZS24k340L3zEXmLTow6u6qdC9bltBqCyZuNvs7THAMvWeA0STpKxlEG5Qhs+APz6dZcPKFZ/ZqMzpbHZc1ZhEwTsH92wtpXGdBLm4zENR4xFj5pWA+2CL4ybEq759pdnmPhOUjgw4Ipewm5gkykWxpK5ubKIf7NLyDsekEJfA40yTQFs21iTg/wQdazT8JBvQd4HtX/fZpkWwvmhmhG+CFUbQmpq6/JSsso+WR+P18M39aYwIq23jT+mM5fQfxO5K+BNfQ9KvfZFFX9B0qLViX5YRnz8eVFXYqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYM+JnnKnoZTopkYfjEHdPmQECZEXb+C9gXcn1YFP5g=;
 b=daMRcdZ8yXRDw+8Xk3PiE54WLN6M8GptpJlAXcHQ/51qFTf3CdbCv6Wr+OcYV8WYgLdIvxCjRtzmKlCAX+xLsqnF7ELwBl5lSKDRlp/L2g3JgYfSKpGTlzsNHQIyZA8xaZ9ibOlYioCVqu1R8m3Mn8S+pLlDp6bFGOAf5LtIXsT81+JbSOB1Soj3McKSGuCKCQ5N4u+zTteSHnO1tas7HiSMwuezCVNBQvpFCCfX6dOZmC+ujgkbKytYlgFtpCPwKeyxKq3A3uXf1LnY4yhLO84ZIszQJ3hWGz6lAGarxPknsvGMerzFrqPX6hAGupwvN5g/REerWoq/b+fmlxdbbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYM+JnnKnoZTopkYfjEHdPmQECZEXb+C9gXcn1YFP5g=;
 b=JuhQdMZG0JSBulhtkqXul3OwEKO3WLrv34ZTKlNMqK1h64/pwWAdrfz2FsOQvCZaITpG1yIXbRFDD01HwSgTJD767Kr50jWjqyTAsfj+vWMrKyhMa7nDFISTBahtl+pCoAl7OCvACigCZDza80rPpfGZbDr9Xh8AVvejwQ6arww=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 38/44] mm/mmap: Introduce init_vma_prep() and
 init_multi_vma_prep()
Thread-Topic: [PATCH v2 38/44] mm/mmap: Introduce init_vma_prep() and
 init_multi_vma_prep()
Thread-Index: AQHZITon6JBWV6nhzUOpwIF1L6DkuQ==
Date:   Thu, 5 Jan 2023 19:16:04 +0000
Message-ID: <20230105191517.3099082-39-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: 278457f1-d8ca-49c0-b605-08daef515fd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iG/fcdz5RhHkV13tTU7ktJTdyYywf5QLgk0WCB3kZ7mO5PxQiUUlQsv0PVpMOa20Y6vBxFJ7WSXJ2rG92zHTV/0L16fLJlb8i+/6XY59bKJfqXiJU1200x5fRV3y1Zg+XnEzp8vKlLWT+Mw2jZEAr8fAhGgn7MSAvPnwajAkPnh3N/d3C5NTaBilb+nNDKIafn7qB2pELX4KiYKyTfN11FUeSUGip7BLW1i4iUZBq3GB1RyI0XAS2CF3Yxvj5xbIZDH943PiwQ6Upmeu/x+AYhm7HYjJiQlvj/sjPZBSJOpxZlOXF7NdYxYKZSLHhzaMOeWJRyVq1q5UFUjx02NG7bkuynoEs3K5pHePZ2atPzViPfnfasQfQV7x4rJ/LunfpifDyDsX8rqliZNFRhfGuSzyP4RwnM0/jcFq5iytrsIWfVIA2yQGEAK6WmA/PH58iYzOUkn/6UlEcuzaBZm877S5L1MOpGBFhs4awXEXXjSFruh7NrjWREqRLFJukpNqVQ6ghJPIbl9oIf65eY3rLoIqIUz+FgMNaoJVfsDJ2iJyNOaCC4Oz3WZ8VPzNG1owr7+9u6baC0iJEqCSU76UDiR006eFso8vy0wo6uh7cfUDe8nYEcGcXF0M8bvGm+41lga/Jck5U7W+me8FHSXLfKotp8GpGA8OTWtQW56CS7t/g1VZygEmEhRwywy3R+2aaJe22L7KalK4z02AIl/47Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?x3xtsLWq1CFYqihizsZMoXNlOiR/eZIkL9vL81cE6JjuOj526T07yADKH0?=
 =?iso-8859-1?Q?YoC5EouuJT+/I8WdaqGirDaxNt6OGUFv0lnFjS2WsfcskZaTlfm/unV9SA?=
 =?iso-8859-1?Q?3vS/EGFgMSvgH4izrXst1i0kULNNDBx486SCers0VV6liu5+EF5cos8Gvp?=
 =?iso-8859-1?Q?Q8UauCROHSKBSmnJIh5V9ftbwyVYbtEvynH+TXL+Po7uqqgA2o0d3DjJGM?=
 =?iso-8859-1?Q?BwtDHZbN62fsa4A7ygFbdo2bt3CDvItv4KLQqdgcfkoGrIP8JH/M4DLOo+?=
 =?iso-8859-1?Q?1hjHCw8QrrxrFh18+g0vUFL4FPFZfZIJc+8ajuS/hIGDU/olx7XsPRCovI?=
 =?iso-8859-1?Q?bXNyWOKUp52PDTPWDVMGAKCOxYX/PcGeP0RCQEJvU8Wqo/xVnC4E0Ri6uq?=
 =?iso-8859-1?Q?30pUd38gppPbzROrBbsT/NcV9w6a9Ep0XuT8fbrO1A0ghfvrrpK9C/5lcx?=
 =?iso-8859-1?Q?fq5eEmzhq6MsuMRtt4VSnhMEj9e/N/IUee2pxoMur+4GcnH0jo/NMVoN3N?=
 =?iso-8859-1?Q?dkRvTTP1ROYsyO9yU8O0VY4uy27PatNCB//ItA4LqlTzSI4CfTBbsOi/u0?=
 =?iso-8859-1?Q?/nTtwXaZgeqodXBgsXzQWrErTqmZkBMTq593CccluADQqJc7FzZn+8lV5X?=
 =?iso-8859-1?Q?PRTxVfwSbI5h39WTMxL3ZDTNsDO1sNm5py90+UXKr7E7c/Eg74Lo59zqom?=
 =?iso-8859-1?Q?c75dUUQFGirrpUAHAXEqEk33XOG9g1RuCx9QmuZxm4cueObzxrA5QbFDlm?=
 =?iso-8859-1?Q?b22AMnsKMwyFyGxDkA8IBx1NRyWMAPxTgA6qiJ6AiRj6IjdguI+B+jA7WK?=
 =?iso-8859-1?Q?4KLugO1VAIpjf0OCKC23rsZ2i7o5Nx7zrIHUiNP+GYBZYoum+sxNrqnpp7?=
 =?iso-8859-1?Q?CpFfdfc78b7WTi6fcBZBGgVDNL1eGo+pFcdzQEggAAOy8QncSSszwpDsbb?=
 =?iso-8859-1?Q?hiWM0TK4DNmp0l3s1R76mQhJYShYFgTtWOLRKuLkil8AjvnE+sWyWlk0hs?=
 =?iso-8859-1?Q?jtUHFXCRL1+sztJ1plJ1bBqDbvj5KpsdkunLcb24cJA3wZAixs8gN+AN58?=
 =?iso-8859-1?Q?stT/OCU7ascJsvhsAn7kMR3Gu7+paN+Hc2nU3mO/YUGX0y+HmRiayc6viO?=
 =?iso-8859-1?Q?Lrf8dnw63a/A76QncE7V8Q/AVBiDLsB0shKlULY0RBOZqkSdmXQXB+GFQh?=
 =?iso-8859-1?Q?mlV4MdbqNe3LdF6UWilXEne0BE7IFTsbP9CiQt4p5PbUUMoQ+4h01NPFgL?=
 =?iso-8859-1?Q?bJU8Ul1DUt+BfWnlfzA1p8IpPoJ8o5cD5B8mWiucAAZIcK4NOavxDKJg5z?=
 =?iso-8859-1?Q?u5itAj8VnU6zU0zxYBi+i9G+C5TjnVHCl9zzW25GXbV/YelQx2hIWWzsvU?=
 =?iso-8859-1?Q?7yNriFTGkWQaHgM9A7xntGDHyEWUL+g9eUg8dD3fixOhlrPielYDyqYC4z?=
 =?iso-8859-1?Q?ZL+nCd+JXM+HsJeO89hPRvJACXlhMw7WdLs36kw9W0JgcNTyuhVf1L4T2y?=
 =?iso-8859-1?Q?yqSwrdFMmonC4bNZi7sJ+7FSi+1mYnUwHY3dSekGc/6fjmcVk42DYY0Gt4?=
 =?iso-8859-1?Q?9TXG86sqJzgoIDXmK5JbiqnLA5foLfPNK+Tdw4VKaHoJd94WgMZY25IKXL?=
 =?iso-8859-1?Q?4HV3i2tP0F5NKIhk0drnZrN/+EsulOsW9yYLj3RHKMc4kOr4RV7mUsXw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BRWG51rrYDFUzTkM1E4V6No6urpKqFuahRhIKraW4RvcLiE4bsppJIiUoog1kpTLJSccb5TCrPt6QPexyybtXnUav3r1/oaBQpkizl15jKN/9k69Gl3heCC6WSS62GNYIBzD8IubauUxuYs6gtppELT1YQwArLtH97zbbfRFNzG6igO9vqiaf/rCluaXF22G/tFuPWXaAsYJMW2nApRl+orjk8oNwj3Vx+WUy5EQg8GA3kIzr1xQG2gT4Kt+pjCZKEGHohjTUmPstSvsgS2opk6uo5wMtWKYoCguMYfOJaNHAA/OnpBmVuE9rChyiJxdB/VLckeNow38EydGjc3p6lbs9OuBF8GKeg/gF+kU2yo68da4Q15vzRjWjhcG4eRpf6PVZItpOXvNi3ucFz9VNjP/EtRGZN+9iIIUnn0bvv918F55jFLcFm7RYmUhsmYlWFPJRw1Yk/c2nHmmbzs+UGaCwa7BgXCzAem5Tl7nVoSncqsGjbW7q8aOXwhAzo5AzWbZ3yt3JCb0SnC7x/MAycTV8M35bVt9GHzPgJ4VIiM1oHkhONIxZmuAqRUrGsib4z1PYwJC/f6pT5JZeRirCY/fZhLUn1xueM7HegnSZQM3G1GfB4q6VSIwJPLQx1LgyYBR+gtxORGPii631e+70u7eXkZm3m7/B7A3DnDaPh2awgmw3+BlktiBA50TzO9UrPp1zlOEd14p/uH7z0KNwhbftXIkIfY6S4cnNo6JuhB/nc6bivh2Koy1xFNZTBNWOuy8l+8bz/q+WH9CKX2kxRGiS0FFiU+eAX8bkEmVQPJpyWPDd+cvWNS8tW7X/l4sbY5/z0i1j9gqPcxCOqaud6b2ZRYbbRMybhCeAe0MgWwBrwwGnSeQFP9oRmcLaRnOc4Y9FCJlnvejGLC6nWhj0w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278457f1-d8ca-49c0-b605-08daef515fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:04.3126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mU38JVnflZHPNbHVnKB2ZV2+jb6WPOnaXYh7KkQLDzd8lssKfVZm9zy+jPYjq6YrVRwAupvRaWtl/N1fu4qgPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: hmszyapcXyOFRyxNEon7qViFqgqtSRu9
X-Proofpoint-ORIG-GUID: hmszyapcXyOFRyxNEon7qViFqgqtSRu9
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

Add init_vma_prep() and init_multi_vma_prep() to set up the struct
vma_prepare.  This is to abstract the locking when adjusting the VMAs.

Also change __vma_adjust() variable remove_next int in favour of a
pointer to the VMA to remove.  Rename next_next to remove2 since this
better reflects its use.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 108 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 61 insertions(+), 47 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9546d5811ca9..431c5ee9ce00 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -519,6 +519,45 @@ static int vma_link(struct mm_struct *mm, struct vm_ar=
ea_struct *vma)
 	return 0;
 }
=20
+/*
+ * init_multi_vma_prep() - Initializer for struct vma_prepare
+ * @vp: The vma_prepare struct
+ * @vma: The vma that will be altered once locked
+ * @next: The next vma if it is to be adjusted
+ * @remove: The first vma to be removed
+ * @remove2: The second vma to be removed
+ */
+static inline void init_multi_vma_prep(struct vma_prepare *vp,
+		struct vm_area_struct *vma, struct vm_area_struct *next,
+		struct vm_area_struct *remove, struct vm_area_struct *remove2)
+{
+	memset(vp, 0, sizeof(struct vma_prepare));
+	vp->vma =3D vma;
+	vp->anon_vma =3D vma->anon_vma;
+	vp->remove =3D remove;
+	vp->remove2 =3D remove2;
+	vp->adj_next =3D next;
+	if (!vp->anon_vma && next)
+		vp->anon_vma =3D next->anon_vma;
+
+	vp->file =3D vma->vm_file;
+	if (vp->file)
+		vp->mapping =3D vma->vm_file->f_mapping;
+
+}
+
+/*
+ * init_vma_prep() - Initializer wrapper for vma_prepare struct
+ * @vp: The vma_prepare struct
+ * @vma: The vma that will be altered once locked
+ */
+static inline void init_vma_prep(struct vma_prepare *vp,
+				 struct vm_area_struct *vma)
+{
+	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
+}
+
+
 /*
  * vma_prepare() - Helper function for handling locking VMAs prior to alte=
ring
  * @vp: The initialized vma_prepare struct
@@ -628,7 +667,7 @@ static inline void vma_complete(struct vma_prepare *vp,
=20
 		/*
 		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we must remove next_next too.
+		 * we must remove the one after next as well.
 		 */
 		if (vp->remove2) {
 			vp->remove =3D vp->remove2;
@@ -662,17 +701,14 @@ inline int vma_expand(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
 		      struct vm_area_struct *next)
=20
 {
+	bool remove_next =3D false;
 	struct vma_prepare vp;
=20
-	memset(&vp, 0, sizeof(vp));
-	vp.vma =3D vma;
-	vp.anon_vma =3D vma->anon_vma;
 	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
-		vp.remove =3D next;
+		remove_next =3D true;
 		if (next->anon_vma && !vma->anon_vma) {
 			int error;
=20
-			vp.anon_vma =3D next->anon_vma;
 			vma->anon_vma =3D next->anon_vma;
 			error =3D anon_vma_clone(vma, next);
 			if (error)
@@ -680,6 +716,7 @@ inline int vma_expand(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		}
 	}
=20
+	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
 	/* Not merging but overwriting any part of next is not handled. */
 	VM_WARN_ON(next && !vp.remove &&
 		  next !=3D vma && end > next->vm_start);
@@ -690,11 +727,6 @@ inline int vma_expand(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 		goto nomem;
=20
 	vma_adjust_trans_huge(vma, start, end, 0);
-
-	vp.file =3D vma->vm_file;
-	if (vp.file)
-		vp.mapping =3D vp.file->f_mapping;
-
 	/* VMA iterator points to previous, so set to start if necessary */
 	if (vma_iter_addr(vmi) !=3D start)
 		vma_iter_set(vmi, start);
@@ -725,14 +757,13 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	struct vm_area_struct *insert, struct vm_area_struct *expand)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct *next_next =3D NULL;	/* uninit var warning */
+	struct vm_area_struct *remove2 =3D NULL;
+	struct vm_area_struct *remove =3D NULL;
 	struct vm_area_struct *next =3D find_vma(mm, vma->vm_end);
 	struct vm_area_struct *orig_vma =3D vma;
-	struct anon_vma *anon_vma =3D NULL;
 	struct file *file =3D vma->vm_file;
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
-	int remove_next =3D 0;
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
 	struct vma_prepare vma_prep;
=20
@@ -751,25 +782,24 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 				 */
 				VM_WARN_ON(end !=3D next->vm_end);
 				/*
-				 * remove_next =3D=3D 3 means we're
-				 * removing "vma" and that to do so we
+				 * we're removing "vma" and that to do so we
 				 * swapped "vma" and "next".
 				 */
-				remove_next =3D 3;
 				VM_WARN_ON(file !=3D next->vm_file);
 				swap(vma, next);
+				remove =3D next;
 			} else {
 				VM_WARN_ON(expand !=3D vma);
 				/*
-				 * case 1, 6, 7, remove_next =3D=3D 2 is case 6,
-				 * remove_next =3D=3D 1 is case 1 or 7.
+				 * case 1, 6, 7, remove next.
+				 * case 6 also removes the one beyond next
 				 */
-				remove_next =3D 1 + (end > next->vm_end);
-				if (remove_next =3D=3D 2)
-					next_next =3D find_vma(mm, next->vm_end);
+				remove =3D next;
+				if (end > next->vm_end)
+					remove2 =3D find_vma(mm, next->vm_end);
=20
-				VM_WARN_ON(remove_next =3D=3D 2 &&
-					   end !=3D next_next->vm_end);
+				VM_WARN_ON(remove2 !=3D NULL &&
+					   end !=3D remove2->vm_end);
 			}
=20
 			exporter =3D next;
@@ -779,8 +809,8 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
 			 * If next doesn't have anon_vma, import from vma after
 			 * next, if the vma overlaps with it.
 			 */
-			if (remove_next =3D=3D 2 && !next->anon_vma)
-				exporter =3D next_next;
+			if (remove2 !=3D NULL && !next->anon_vma)
+				exporter =3D remove2;
=20
 		} else if (end > next->vm_start) {
 			/*
@@ -821,30 +851,14 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	if (vma_iter_prealloc(vmi, vma))
 		return -ENOMEM;
=20
-	anon_vma =3D vma->anon_vma;
-	if (!anon_vma && adjust_next)
-		anon_vma =3D next->anon_vma;
-
-	if (anon_vma)
-		VM_WARN_ON(adjust_next && next->anon_vma &&
-			   anon_vma !=3D next->anon_vma);
-
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
=20
-	memset(&vma_prep, 0, sizeof(vma_prep));
-	vma_prep.vma =3D vma;
-	vma_prep.anon_vma =3D anon_vma;
-	vma_prep.file =3D file;
-	if (adjust_next)
-		vma_prep.adj_next =3D next;
-	if (file)
-		vma_prep.mapping =3D file->f_mapping;
-	vma_prep.insert =3D insert;
-	if (remove_next) {
-		vma_prep.remove =3D next;
-		vma_prep.remove2 =3D next_next;
-	}
+	init_multi_vma_prep(&vma_prep, vma, adjust_next ? next : NULL, remove,
+			    remove2);
+	VM_WARN_ON(vma_prep.anon_vma && adjust_next && next->anon_vma &&
+		   vma_prep.anon_vma !=3D next->anon_vma);
=20
+	vma_prep.insert =3D insert;
 	vma_prepare(&vma_prep);
=20
 	if (start !=3D vma->vm_start) {
--=20
2.35.1
