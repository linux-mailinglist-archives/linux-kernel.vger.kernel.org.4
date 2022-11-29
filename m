Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA7F63C594
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbiK2QsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiK2QrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:47:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEC76C739
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:45:21 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGP3vI031406;
        Tue, 29 Nov 2022 16:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QJbNDToPPBGmnKbH0hoXaHKCrKKZJy8f2tBnF9/nnTc=;
 b=fYXSppRl7bG/BgE3BxV1zWcGMG6BAK2EErFnDHamJUgQGVafPgPg5R6XFJJhQsSGbX8Z
 L2ZIcs5781tmEf0PMZ5bvGwTuRulMmcCOjef5M8oeoTnux0coCLJxU/8LI9K3/5Sfhg0
 Olp4q5mNayhK+5xZsGYUYB4g4HBohPAjhb94tF2tqj2k33rgW8wpJXnWckRoSJ1ckUFA
 bSq/m3/MzgY8ICqTWcXe0kLvwStdo3nXB9BYAmpZMGyCmVTNJI7WomVGXgVvdsXfWivW
 1Mkzv7tOZwq4QzDfhF5iNFtxK5Eqj0mEYvGKk3Eg7hc6876WK9CKZiUPu6eADvOmpYNk hA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3xavd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFm8O7031000;
        Tue, 29 Nov 2022 16:45:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398773b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ft62VwvxdR44wbmqgLTR0fdgZ2pHWyu2h0YCVFfsMYXrg4uJ3dpBzRzx6YBZhaSkd81Zp9ilLvLqtyxLcjvg5wAY1ExZEa4jQpXm2vL7TwFZToiCL0HxGzZXj3wcYOdVkzYxdDoPy1VhQWkjS4HfNVOKP1hue0dWSjrTGbCJqY0y+OzmVXNFnxjooKk4C5lisHNp33ATsOf53pgPCIDecpl2eYdue+uiasHXB64rqNmE2iielSjGgtbRZLU4lTJ5SaXnl/kpSRNAO3W8MdmF4dM07Yr4jNPrI3JO92AL/pw8Cu0xQM7JZwZOX4visC150JdgYBGrkMLwrBCLLg6e+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJbNDToPPBGmnKbH0hoXaHKCrKKZJy8f2tBnF9/nnTc=;
 b=aIGuzbzWFUp+7xzhRCMC79nOwlFPMlElwlCL39La0n9exn4gBqOTE0ufDU6Q+/AkUrvbSu9Xju4794T8l5oMC8CiLr+yzhb0Zur3fPzHY+E+Zba3BOYycvXXPCenKD+mRwitsCcCv3+DoKftUVP3qGCmoQX9/PUkf2wrF+nonXYjX6WK/QyOFrsgB+Qq3+5zwNLwEqVMLakOudAOUIPVSEPbL69xhX3yLS5G7b+5ZSgvQQmAUL8mwx97vpRK0XKkA+KhNSYOdq/s6pJNPyS+OZXiknj8aPvkyLAUZcjf1qstAaUiw/rRVjybRdvJfWq6cljtWMZuzSg01GzgsBmmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJbNDToPPBGmnKbH0hoXaHKCrKKZJy8f2tBnF9/nnTc=;
 b=wHRBRj2RJ2KQ6nxpC9nSf6GCjiliZH1mnYA5yvsVJ4n72SLKBDZQtrsepQwmBWKK2kdB4A2UTC1FthPZ6fRuhkSn5gBAbF6mkk9KiGyR+78Ohycw+TgY479S2MoB4XEqmbJ+5zZB4xGARTei9I3L2odcJ5FU12yBy4QcGQlAnQ0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB5937.namprd10.prod.outlook.com (2603:10b6:930:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Tue, 29 Nov
 2022 16:45:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:45:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 37/43] mm/mmap: Introduce init_vma_prep() and
 init_multi_vma_prep()
Thread-Topic: [PATCH 37/43] mm/mmap: Introduce init_vma_prep() and
 init_multi_vma_prep()
Thread-Index: AQHZBBHdzOqYp4THJkycaA0LAPe/qQ==
Date:   Tue, 29 Nov 2022 16:44:36 +0000
Message-ID: <20221129164352.3374638-38-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CY5PR10MB5937:EE_
x-ms-office365-filtering-correlation-id: bececc11-5593-4af7-7d59-08dad2291449
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M4vCxOA2DNX/zNiQuWQlMzKiwhTZhn3OAXf03GicBijy3SmILadHLXmF03cu7SnFEvOi5Hrf/ODOKV4rMT/Q5C4OyrtxCr3JaNkberv74w9Cr36pvdJTeuBLeHVISjXkZd8d1vsylUj0qhGconJSWEJcYK2axYeZ5z8KLXk6JifWhY3q+heJhy9EfTZo7vA1VflJfN5SywNDPHRJ/PhzHud8bqyfJfnDe7HVGhDoICz8Kkq0GK13HPJsmYIWUdPOoKFcZnTRKEf1hDUFtBHIkglYsbJB3ipO9zvkWS417cGcd5WdZq9RI+tWFV71okGsfEZSH22bJZESJPYa+VtC0N3DOQIlp9DqDwedDxRYByRkGQy45phCP/MrMvhI58BRIwZjkVXNsMBdMnFgYjWTWnyxH0zIognukkR/6l26oLBIFwca7pxGLeSFRUCiy7XOAl4Sk8LrvDr+8fJ3FRAi+zh2tApxaBeNibaPYY4xyYlCL0XIcjfGnU9+5Lhof25FoVq1KiSxnx9ivlbDZg2YKtnNgxwqHSX+V75ueWQAA6/xVKUnA1LyJKFt5f8OLVALPHbOv0e59zkH7FV5ZGrb7M6nMOXwW8Jkudpp0sATNp2uNLTBZLh/XDBTD26Xz0xKoWeGO1IF3In6Hih0wbbJbfltCPQTxeNO3+6MNx/rJDocvb+fWeOjKvJ/0PuvIaASpmj3wXeAuFWJMKZ9t1MzAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(8676002)(66446008)(66946007)(86362001)(66556008)(66476007)(4326008)(64756008)(91956017)(2906002)(76116006)(110136005)(54906003)(41300700001)(38100700002)(122000001)(6512007)(83380400001)(186003)(8936002)(1076003)(36756003)(2616005)(316002)(5660300002)(107886003)(26005)(44832011)(6666004)(6486002)(71200400001)(478600001)(6506007)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WZlKoGGJdfcdelhwfGlEd+RHHJC7JVBXBfTo2uiTex7lBA6O2qGFBcQesH?=
 =?iso-8859-1?Q?c/mcJTTmWMr72gvvLv7odvc39gq/gZ0EHCHjX9/7nRZvgXNrEA/kfyoy7C?=
 =?iso-8859-1?Q?2K81Z5CVVqQwZ5CaM+ITAWkMWy/A8Q+BO/RRKAwia2sCdOQGES0QyqMW9E?=
 =?iso-8859-1?Q?aDOQQFwRoccWufLrZvKCqROWe+aTsGnaM3Gvy7ugbT2vMfl1XNLrWnCAp8?=
 =?iso-8859-1?Q?3ai82gdUHJR45L5BXX/w2CJlN86ftIxBu5p7Pxlf1KA8ZTAuw3hCZ1/pcZ?=
 =?iso-8859-1?Q?upqjF1rRvYXaPVckwJDybEO90yb3lbnfXkcS9HmSyJiKSvlrhpeuKffz8n?=
 =?iso-8859-1?Q?f/wM6QkhjknQLYAO5tKwERM9C1ynZjUejhxhBnu5OxCZhyE029o1Cp2BT5?=
 =?iso-8859-1?Q?j7GhDnUtRFIq0T68EcP9iUeyiE2O8G4YywljZmwSb/hcG+WMV0oaBC3tpw?=
 =?iso-8859-1?Q?ltkIugF7lVmmWYbu4iKoZtP5x52XcyZhWCpX84gu8nyJOnCSrVJlcFTFIo?=
 =?iso-8859-1?Q?ftOIvObOqIDOQeT2m45KgqIQhP5Uqi7kk5VK3IHY4YkYupw8xLs2/l2+yM?=
 =?iso-8859-1?Q?qEdOMNCccbw/mzy0pEigFU+V/Kr7cNQrbI4XXeKC2Z7ywcuAhjxyaDhz2P?=
 =?iso-8859-1?Q?kdmhpFK14a9At4rQSgw2vzMrraoPqSfqL+Mjgqm6cMuPfgkdTnLNVZ+XSr?=
 =?iso-8859-1?Q?yMYpMTsnr/7fWbHqVYW29q/IA6G0Ue7JhQiu+ZvvCdkR0dsl5q40cDDHa7?=
 =?iso-8859-1?Q?KwqoQeaiWB4pjsrOw1dors7l0+q2cbtCrXQjvWDL3V0PMtoP4KQaJzij53?=
 =?iso-8859-1?Q?g32bQ/vmaEU1f4jUiUc5XyZDfJ+YsOD1M6d3jqcmXbIsBxPgxeYG11aNTL?=
 =?iso-8859-1?Q?wHmNK71BGM2G1tUHhpc7ANypBskopJGDn+PYhV+I5LGtoavpuq8XI/Qj6j?=
 =?iso-8859-1?Q?J1Ox+1HwWRqp47qnDik5jo01hIApio4NpK9ZbhfVQ6oB8br4gKDKWbg4DA?=
 =?iso-8859-1?Q?ax6wk30YxmRG9d/aitQvwHdm8PHfEkYHfHBzam3BcOsHxU56cUz62VqT3V?=
 =?iso-8859-1?Q?HeKhj11i5CtWD+mX56oPkdtXEli+d02sVuiRmj+jvYxI6MoBVCs7iS2yNV?=
 =?iso-8859-1?Q?HVRYzXvssZPDQQrH2/O2Kp+jJu5MGGgs9aVU/tz6ySyGi84IN4PVu8f27+?=
 =?iso-8859-1?Q?2ni5f3dG2Ldfjw/64A93Xrq75JMBmt35kLnxrllT8Ws8IYLHgpsKvCCtvw?=
 =?iso-8859-1?Q?sAA796R2YHr7hXsUAfBvlWGqPP/5mQjiG0l+2N018AFeAISMJk2csgdCcm?=
 =?iso-8859-1?Q?XYPGsnMukOLFR8Ag3KPtT0pQgAKTa7hFwKEWx6caqkEkMDYjYceTpLl8tK?=
 =?iso-8859-1?Q?QyaJ2Khtvh5Kctrx6UkjHnuItTEhv0+1pgqiCoyJ5X5ipRXEn7S+kLz1F1?=
 =?iso-8859-1?Q?LARA3vTVTqvF4SYY9P7pg0wiPECMiCCSbfY2wmcGtMejNU0cDSP7AoPJhE?=
 =?iso-8859-1?Q?DIeoFK3+jYwcNHUqsk8di3UtpUzK7q5dASuPh3f7Q/Lcty4dpWmN5o31qA?=
 =?iso-8859-1?Q?ysXhCLWBYlxKgrmCiuzhCNSToSn5ML5/vhNN/HAEruL9XWbKGN4sRgMj9d?=
 =?iso-8859-1?Q?u87UXLIM7tJnYhgwT3VXlwzRcxvob08Z498393t/wbbyIXsEBdgZlxig?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rcAlTzmD3J3eObcKNiBwG0ul+hSQotCjrhQ+lMFgnxELGQrWQqypZ9BXNsaLjFFl0HMklMZX3TxYxYP7sC4G2zY3s4wsHlU+oBuq7qtSi0xo6POwdsgTG/Hjga248wnO8hY+yVgkLCPCh5j69BbyhKjtMJJ4Ql5mZBScdZdGLtrFUWo634n5NCfIdZuhWS2ARSaZC+RKgCpdounIphjJnGHlhXqJry2Dx55vHzfBG1LstytutSR8NTi/VGQOYcIhfMHR4WYR+K4U3Zk/STwgjfYHEaVKWFx88OjwwJ3dBiYGI6/CR9UssjPLYNOxTSWtEzKcZaYwUHSy1bjCSSJcSyU0Oon0tcIEJwc/doeVQwac1tZEzGwC9PwG9wnjOkAbHuSEz+blOrzAB8+2CXHp2CJTTIIQ+d7L+rkGTll246ktnKCqQPWhT9TihFgdomo4oJlq8ebyqiZCBcEMraaNt3jZZR6Fo5NFJSpUrxaESzXUH3lTTuZIIPCDoa5CpPfE1ZwUkFvm5YL0Rn+YEcGavBZlJqZ1KFugIs2eAJGua1zeu3kslL0j9grt6CgmBeBkb4pz4NK+afwLj+Ww0BQMOC/POd5fQi/nmRg4vSmiu7h4u7y63BGq2rAHmCicTctNjSkkhIfnMRfAR9/M0ZvqaLXnAw86HQbxRhmy/1NyFASvf23D4IgL2wgpX6KTI69ytQH/yjKMKdNdoAM2cziemb7sdy7hVLigx07qVlkPEPy9nSszGAGbJYKJphUBwdfehzY62OuY6cMe0KDnPheb73iK31yX45JyDWsA3vNl3uPbuiWUwtTpFwfxjGKyp23Hs2FgC45khnebBI+v+exxYH6NbsBDnsMaME1SO8pgQXi04Qa7OTcjb3DH8PaiXs98kOhEoqRZKWsr7EucLNhVIA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bececc11-5593-4af7-7d59-08dad2291449
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:36.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGvYTMJ8OQpHj6bNNZs/3icboNIw85qbWCtlOL9ONMAXmqcC6gB7wQHTHVamwRtharQ4Gr/SGBKjUwWSp929Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290093
X-Proofpoint-GUID: uryKGuMcLhkgRhDbUHGYqoSKn7fzIDg2
X-Proofpoint-ORIG-GUID: uryKGuMcLhkgRhDbUHGYqoSKn7fzIDg2
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
index 39555335f145..258113e13a88 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -517,6 +517,45 @@ static int vma_link(struct mm_struct *mm, struct vm_ar=
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
@@ -626,7 +665,7 @@ static inline void vma_complete(struct vma_prepare *vp,
=20
 		/*
 		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we must remove next_next too.
+		 * we must remove the one after next as well.
 		 */
 		if (vp->remove2) {
 			vp->remove =3D vp->remove2;
@@ -660,17 +699,14 @@ inline int vma_expand(struct vma_iterator *vmi, struc=
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
@@ -678,6 +714,7 @@ inline int vma_expand(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		}
 	}
=20
+	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
 	/* Not merging but overwriting any part of next is not handled. */
 	VM_WARN_ON(next && !vp.remove &&
 		  next !=3D vma && end > next->vm_start);
@@ -688,11 +725,6 @@ inline int vma_expand(struct vma_iterator *vmi, struct=
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
@@ -723,14 +755,13 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
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
@@ -749,25 +780,24 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
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
@@ -777,8 +807,8 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_ar=
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
@@ -819,30 +849,14 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
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
