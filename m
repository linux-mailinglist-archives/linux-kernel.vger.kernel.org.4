Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132C163C597
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiK2Qsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbiK2QrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:47:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE476CA1C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:45:26 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGNtE0022642;
        Tue, 29 Nov 2022 16:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JW6+9UwXWDgFrVRJ2ctqJ0TYYaXuE5oGeSURV6qoIDc=;
 b=hEVX0NuNJT2MTasPCWsYQCZ5SjQ6jZ0SpzuWgdlT84y6Wp92kTnrkksyY7AKzZT7+CNR
 d+MMJMbHszOmxwheev39P7F9jq1BcF8y2IqW58GJ/wMPLwsPX2rz20eUvVP0cFWutkHS
 N3lFmqoQ5q36OSjww3jTbX1uHgUwtrLCbaApGzK5F54UzUVGc5S6qF3vQd6KXcH9Okmv
 8OviGxdA5KHBcYzZM85GUPWPOYYXKlNpC523Ba8payiOzp7JJkcZVTaXlXcQ4HRQld4C
 9YU4mk3SlQNZDJJpVTLKy6HfF/b0W+NzKC5yYOlQDGOd196tMTzkWFhRGbtEhTXOO24m Fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m397ffc7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFn6v4028010;
        Tue, 29 Nov 2022 16:45:20 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f3xj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh2YaYyERgXtikjVOybGhmSEvPsgfHL7V3ivf+cXMa8WTTiuECjLSW5Y9GAMk9fmRvE0F28MUFjtidSd+/omWXgp7ysERgV9QgZKFB0s5d96cgXbPpQ5U+wDDwKmNXt22reNJE1DPgXCbfC/WCqUKu2E/eWYJ3//qniOkyI9r2UZct/lRDbGYKsXoPxcAo9iAfxH+y7cWrB8qVbkfiIkCRvzt3HpW/Tst+awnZZyHJGxrGuWeZsXzz8Y5uJXhNxgvf2WmXNtpi92oSl2Y+xl+LmDHrMqoIoK/nt0TYIQ9B1wkNjZHfFK0uLnAcDkojUfz9ArDVxV1Do7iWVzrvO6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JW6+9UwXWDgFrVRJ2ctqJ0TYYaXuE5oGeSURV6qoIDc=;
 b=BXquxgiYEbA5wL23+9V3NZmpmCupgN7aiej0xoLcclPg3vXTBPd3fuvuSl5EXKO49BkagUoFqzWJxnMTu7yLyq1dlDIn5QRDM9vjg9JkirFMNbWhQKKsWbc5zipBlJzU3kXlYy1C/mh+WJYJrfKYSlZqV6j9+jLWK+eO/rwuA+Bc3AT4vO9AW2SBz94wMjW0UDYi49g+6sIL1nU26PVvkDYedQ9sfl8iF5haueed4kyKekTZsV2jxxg2LLVHZeyaispN1OQEd6IIKtnHojm/j69qIwTbLHgVclCm63hE7NWtYhOIE5ueAKNSnZpzYmyoCg3Z8Uqm/SGtH6QMr70+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW6+9UwXWDgFrVRJ2ctqJ0TYYaXuE5oGeSURV6qoIDc=;
 b=VFmtwPYsRgBTS+IaH1OhRYqJb0tHJv6N49lZ127sxGFHWMGm2nt/12WVvMjjnSag2jj5gAj+Lg56vHzqXAfCZWvAmeqGguaNnSN2cXo43x3ANMHAadtmVsG9L2j2r6mYq3Z6E2E3kIm2+LM4iKURJlTka1/UYu4xkfgEDT3c+yI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB5937.namprd10.prod.outlook.com (2603:10b6:930:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Tue, 29 Nov
 2022 16:45:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:45:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 42/43] mm/mmap: Remove __vma_adjust()
Thread-Topic: [PATCH 42/43] mm/mmap: Remove __vma_adjust()
Thread-Index: AQHZBBHezj+OnykxmUqqUb+jwvJ8PQ==
Date:   Tue, 29 Nov 2022 16:44:37 +0000
Message-ID: <20221129164352.3374638-43-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CY5PR10MB5937:EE_
x-ms-office365-filtering-correlation-id: a9eedd6a-f0e7-4345-da82-08dad22915d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sf/h7U6IYxuPEKHZJKfMSg/NjbSxP7DZ1QitCNfZxS74JznTmP6jpSZ4ZVLsPve/e2fCgfOR22W36aRH+xVUVd0356Gk8Ip1eu6hGA3yKpL1ODMiD9rOveZa2bDybxLwhzI0QWBRTral6w/dPCzod496FsfCfhdn8BREMbyBxUWI//sDhA8ilB6aO1tvlJrgoClyMbsliYY2TY9A7OIG+7FDNKYp9Dnnm2W3P0J/bu+CLFe6DPp4SsWlLeVl6KQDe+yEYWsJZpBdTGS7ArFVr2b4CpWcXBiQW/IdNaGQPRQKU540S4XfPtzllrn+Qk2qoPC+wMZB00f+5Yyuhk5Rg6SyncxBTf1S4GhzpNoXpO+MFRQ5QIWubS/W2TTMFXVX4E1wWM1xt5cHtaxaBU4ik98AQVCkWVK5ukV+bbN+d2Zape7ceo1QjNSrG8UwMfwSvOEnKHBSQQ7RqL7rDHL/oJedTWkto/6lmGet1+oGL6bUwohSgJrRddVu4Tanb9L5WtCjL+x7aaxfjbmH1kcrbBE82wH9O0CJNQJtFGOcbHr7xyY6RMOFaYI+NLjwQTjIYhvRPEvFwHXGtS3bvNRmzYfEfmlTzvO8Ts+ittf3yxqUBY5rDZwK8Q++1WeYpdp6VpQtFDjiT4YXn+ZwHUeVV8ApZU8CZpayoPSvY4OXuV7rz2Hfom2O3tKLDAFt+zGt7G+re55x/NovEZTFxRW8EA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(8676002)(66446008)(66946007)(86362001)(66556008)(66476007)(4326008)(64756008)(91956017)(2906002)(76116006)(110136005)(54906003)(41300700001)(38100700002)(122000001)(6512007)(83380400001)(30864003)(186003)(8936002)(1076003)(36756003)(2616005)(316002)(5660300002)(107886003)(26005)(44832011)(6666004)(6486002)(71200400001)(478600001)(6506007)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FZpkfbhUBNcd1FYDjYJ1PTTSXfHnpn0CugpcP8wLkpaMdnVB0L85xxyaTP?=
 =?iso-8859-1?Q?5gz+7AMT6BeEQLCxN/Y/+ilMwpnI/R3XS3ld1kvHeMWi/xujkBOH+jfRUb?=
 =?iso-8859-1?Q?AVHl0nEnlWOV6ckj6HQSaH8wTe7R/rR+vFhec0JBqB5kVqsiy4T2oYIl2R?=
 =?iso-8859-1?Q?I8HdaSPD+0XphyNQgNRV8FGL3i1G3SN/S/Swa0hoGicA7YclSdu5pKArfW?=
 =?iso-8859-1?Q?7gwHJk4iPAUaUe50Psdylu+H/etNQU8A6IUiYObm/r8udABj78nBRtg1ar?=
 =?iso-8859-1?Q?KO9whAKh6Edz0ovXuj6UxB9gvc+OWzhEzhL8W+pSCZTIDcM4ew2rbqfPib?=
 =?iso-8859-1?Q?pARC5bOXxzJMr3Sdu57iCyrsJ4DBS6WcgYjaLO0mUInE2D6re1u1uh6EQp?=
 =?iso-8859-1?Q?6GVa1XK6aTsECGOohOoqlDAsT3K5+yZWNTdKLiC2J3QyTBbSeRjJTCSln2?=
 =?iso-8859-1?Q?SjguTiy6WnXK2LNzr9aoqZgyGHB1RUM6o/NAd2SnXLY/hoMvEFsLJG3r8R?=
 =?iso-8859-1?Q?RKnk9Qo1NE2AVT9Ec2RkSuVzOc1JcdMVWkhOB6PJhVTAo8YQ6J8elO0V0B?=
 =?iso-8859-1?Q?22zT43H1q7lrO+rGEkTeZv6d/vUi6t2wbVE+i7+dEgpopoibRoU26sqmuj?=
 =?iso-8859-1?Q?7JM3r4CLpqfQe9ldhrS8+KipBayWkDkR5iBbJEWIdYaBstj3oed+00nJzK?=
 =?iso-8859-1?Q?bk/5hQuER64KwlwxnCgzfEpF6L4Buv0LhnX70xLAz/rWtz5X0w76QKY7Cv?=
 =?iso-8859-1?Q?Lt/IAjiJ95hYe5vQiPjrl9b4Wkpe/McS7YST8bjP4NSfmzcf3PGQUHiMOp?=
 =?iso-8859-1?Q?xxjWc14OCW/NstjReKqPfB11SBNV69Tt/JPeSFztE7VID249YKORXWR97K?=
 =?iso-8859-1?Q?DIzs+BW64EJ75i30ENUFlK7zH445pwu/MGUeDu8r8xZk9htJ9qVzwkikN9?=
 =?iso-8859-1?Q?xmww6xrm+ovNTUHq2dsFkTI1bBnaUne/2n0IuuMW8VinI11RaBM8g6WLGF?=
 =?iso-8859-1?Q?pK+PKLzDTV1/0HePJf2VeIlvn9CvEjwQYKrCSRUP9voxg9ly+D/0ztghVN?=
 =?iso-8859-1?Q?cfbA/SYQ+QK/aCDnn1s8g6sK1Mx+UBtPM2GFMI7R/alwtzXyb3o2p7AqnW?=
 =?iso-8859-1?Q?HYX+8Gh9wdXzzjXF9Kt7W3NaUat1YNe62IFAKVZ/w+n67i7MLADSpiRcwQ?=
 =?iso-8859-1?Q?0/jMKtgkZqJuGxLog0HE2lRA458Qwsj9JKuV3eagWSFC2G8ISaZhgQ5S5X?=
 =?iso-8859-1?Q?GPnWDw7tQVBD6y00bYV4mZvJeidiqp5gBodUVR6UjrQyF/P9VFRy1ozHwT?=
 =?iso-8859-1?Q?BHw2I+f4rHg1F/v8y1IwZgVK9u22AC2DIcZVX7Nv8uvZu374Hzl7vJbZ/N?=
 =?iso-8859-1?Q?mDqkeSJywIpFc1Iq2HAZo+7cfjf4fGszIcHZfwKCFMyoQGHFQiFCnkM3nC?=
 =?iso-8859-1?Q?dyGwTHiPnt6dMaCdvtkeI/V2gDPvDoPjRVngHXIt1QGBbZ9Oc/VlNr5mQ7?=
 =?iso-8859-1?Q?GBdsNWVy9Dy1jLh+11iTol4+cYdatxfjcz300iWdxy1rtPLeyON06o3qmR?=
 =?iso-8859-1?Q?B3gj7j0JupTDVTQsxqsJ9DSJ8PMLFuHsltCLe0XELYctsbD0k13zKUHgwK?=
 =?iso-8859-1?Q?9AQLUyYXH3CI+J1K5x6rrHSPrzY8iOh/V4z8smEDKy/EHgwTIR3v7izA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4GA0TEz38UmreIP4VkX89p01OBIiU2N2hQxV1km3zOrEIfA3HH+rJB7BMZmhLGnzQ31exgz/ImEcjIgxGU8QvGRCfPACl7kmLDu1cu3w0EJGKMGhm2IJ4+izOdQTcQyI3kYEbTluTsunBy7Wz+pz2feh7+TzEEGxbfu4xr6zJv1lrvkfCodWu4Vg1DSIhI0fohqDhIryRngsFlCwSA8SNzkyezkuJcLhM+VyJa7va2Gd7l5uot0oJOgOKrsLhb5wo1ZQYbxukPN3FZp4oxxQsXpCYDF/ceyOpfW/aV/U2f/d6vovQ9/3SGSS4l0cd2scmwN0piwkFEewuJ9Vqb2NbQhljiD4067UXnVEdXUrJa/Yf6AAMWPo7JXVirDCba+9urDL8OtxoO2eDxmc8n8H7t/iFJVkUB0aklaGeG3hAECK64Lkh3omqj4izwawKxXEl7k1FgWH5k4ZuQ+xtgy96ACzHRgFLUfmywmfYhSROpSntTgV8BLAm1mZ5kRAfxQR7HRcB/f5zXgA9O2DZNiwyHzEOnAei4zXEXnmjbPtSMXOG+iBxye2L8lxjALQ6Zkz3A97UuzDCWuxqBmB7jpA4ZLwFLI2vnKERzj2Gtbl2MY7GhCzQ9qEk2dF+PVCRj7nY1ci/9zZfW0OU3I1S5qKU6FElswNkXCEiKsEj56oMaf2ZbeZKPNg7C7eny/xagUYcHizwn2qaovnDf+mXragvn4rq0abnmi3fYLrkf5zodlQLlULpDUyg5ryu4sNlU3MD7fAJwbBsfqbM6k4Ltc35IVUkSpH2S2p1P7E5XzmKl0fwMzzEROp0rzlsLMWtF6Q4kRIPl6b75fxaNCgKr73L07AhVR7F4rlO40WposHglIncaxty2PAtfXNyvRzqVnG2rJ+J4PPeHOh5Grl5ejaAw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9eedd6a-f0e7-4345-da82-08dad22915d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:37.8314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Veb6m7DiT+PSCx7TZ9nVmNTnm5cPZjREtp0bAb163ZxUqFTWT7ExJbUuQatAFXd7iNsPwVtZopSWJWNxltxx1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: 95AGOufnystP_fTVVyiQKyre-jYcUdi-
X-Proofpoint-GUID: 95AGOufnystP_fTVVyiQKyre-jYcUdi-
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 kernel/events/uprobes.c |   2 +-
 mm/filemap.c            |   2 +-
 mm/mmap.c               | 250 ++++++++++++++++------------------------
 mm/rmap.c               |   4 +-
 4 files changed, 101 insertions(+), 157 deletions(-)

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
index 08341616ae7a..e28fb229f6b4 100644
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
index 8ca40efb82f9..be01ffb96ecf 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -800,133 +800,6 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_ar=
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
@@ -1053,7 +926,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsign=
ed long vm_flags,
  * It is important for case 8 that the vma NNNN overlapping the
  * region AAAA is never going to extended over XXXX. Instead XXXX must
  * be extended in region AAAA and NNNN must be removed. This way in
- * all cases where vma_merge succeeds, the moment vma_adjust drops the
+ * all cases where vma_merge succeeds, the moment vma_merge drops the
  * rmap_locks, the properties of the merged vma will be already
  * correct for the whole merged range. Some of those properties like
  * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
@@ -1063,6 +936,12 @@ can_vma_merge_after(struct vm_area_struct *vma, unsig=
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
@@ -1073,11 +952,19 @@ struct vm_area_struct *vma_merge(struct vma_iterator=
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
@@ -1095,13 +982,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator=
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
@@ -1111,32 +1002,85 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
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
index 2ec925e5fa6a..3685390c36a7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1230,7 +1230,7 @@ void page_add_anon_rmap(struct page *page,
 	if (unlikely(PageKsm(page)))
 		unlock_page_memcg(page);
=20
-	/* address might be in next vma when migration races vma_adjust */
+	/* address might be in next vma when migration races vma_merge */
 	else if (first)
 		__page_set_anon_rmap(page, vma, address,
 				     !!(flags & RMAP_EXCLUSIVE));
@@ -2556,7 +2556,7 @@ void hugepage_add_anon_rmap(struct page *page, struct=
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
