Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B7A642AB8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiLEOuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiLEOui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:50:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3381CFD5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:50:33 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5DYIR8010624;
        Mon, 5 Dec 2022 14:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fGvIWwxV6fJHoRW3RP9B1I6H0frTBboPCpcoaJ9bmVI=;
 b=QuhhdIN8yb2prd0DwnJvJR0uaXnJ60YRMszAOjFp+SlXySYPI82eOx6pLiZz2Kfxj9tA
 b7UNvkzDRpt8K4oPgWg/JnZrkTiYu2BHOvXlv5625TAcv2eKAHkmAm2UCKN/pcY3HK+G
 FiIzwyNta9GqKjQf9IUyHbSsGeClM9zWDy5Yoy427CD0ZTSLWJCNFoFC6FjgwRMHImbX
 8VzxX3pngoAVvazLhCZB/4O6BroiK9C08XPbl7BsYJkU4JJ+GntdVvtmISWZpeUWgpY9
 rgViARMDfGryaLG/N8nhOX/ja17yr3IioeHNnmPt9oq3D2Zg9irZ13OCobgUdptXjSe9 OQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ydjc4m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 14:50:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5Dl8ug024338;
        Mon, 5 Dec 2022 14:50:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m8u9xypv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 14:50:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFp4vPHDsH27jA928o1Ss3WfI81noL1Pf6e4geN1DL9j2oLyMXLRaC0HpSjEcE2pY4fWc/RZg7ERSs/hf8cAyFCIESBCEv3dCVN0xyWUCzdBFSoy/z/pPAXnOj7zZb8NVTR3oDyRVcJDivsFJjNrkKonbawWlPxDW++BVVzHuTBU9AqWiQfQX452INGOihsLYY6dBN+GAklfEFOqNfB1Lc6xn8VLK85rGFbllbiphB0ROyCmqoTR2OQVF4y8mY0KddKCPf5qBhOYtfZMuLoA1FlGIOPwQiEFaM/esXX1gADrgUh4e/MFkYSqeCL8VpWsw2/EeRfTSBOfyuwQ2vJzfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGvIWwxV6fJHoRW3RP9B1I6H0frTBboPCpcoaJ9bmVI=;
 b=X6wTP6QZVJjgtnHXROb+lJMqxv1Ls2Mq47G2GHd3RZH50Khtu9NNJtp2x63RRA8TL0mJIIeO0AnCmpbuCD1Xi/Uq6LIOeZh1QnA7oKY7z5l/PtYw3zJbaSYvoTPztWdY8h9cqHThkr5vy5kueBPaJwxAhALxHEzX9HkOmRh9naLig23n2sTLHGYX1O8MeZBpVEHYW+PyPQiJojoHumP66UBfTsVB2jJbcjRdYBW8NhsmTkUXylaH4GysJDo2eJudSG0it8YbowlK2Qltnzwj9QyeQ1DcHMjtpEX7MTghj3XJvYQpiN0D6iMt49GGosCX0n86QDcuTVC4ZMJssgMkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGvIWwxV6fJHoRW3RP9B1I6H0frTBboPCpcoaJ9bmVI=;
 b=QnnyjZHxhPWcb5QnTEwlUGB8MCZi7dj58RJ4+d95zKraG1fRwecNbQJy+XJAHP2/Emfb3XvW+FIbgTN8zlt1+wK+xWf9u4D3hpJu/tnlP9A5dTTdXUk4AdteIDGhWA8xwCIuBgqU4IwFj2yWVUGehtA/U6RT1j+uUO42fP9qY8Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB6811.namprd10.prod.outlook.com (2603:10b6:610:14c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Mon, 5 Dec
 2022 14:50:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 14:50:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Jann Horn <jannh@google.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Jason Donenfeld <Jason@zx2c4.com>, Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: brk() in v6.1-rc1 can expand file mappings, seemingly without
 taking file locks
Thread-Topic: brk() in v6.1-rc1 can expand file mappings, seemingly without
 taking file locks
Thread-Index: AQHZBn9x0KFZBKEIUUmTP5jKLrp83a5fZLqA
Date:   Mon, 5 Dec 2022 14:50:12 +0000
Message-ID: <20221205145005.ku75npr3dsz3fqgo@revolver>
References: <CAG48ez1tJZTOjS_FjRZhvtDA-STFmdw8PEizPDwMGFd_ui0Nrw@mail.gmail.com>
In-Reply-To: <CAG48ez1tJZTOjS_FjRZhvtDA-STFmdw8PEizPDwMGFd_ui0Nrw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH3PR10MB6811:EE_
x-ms-office365-filtering-correlation-id: d4e06efc-8944-4cc4-fa4c-08dad6d003a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J2iaHW9e7DsXPYqXSMPXA+gFENpXQreuGNwmbYnyjckmCxE+2jT6FQuypgEOImhPYg4leCHGAIwnxLkuVhhtiFyfpCK5L1rLfJm3idCHH4raz67vwQ+6fiM2r0qSNGHef/qKhAQFlOvELMq+iZxy6bqpecPbbnqFX33jzuFxnzqUielJmmarblzBAR/nfVp/TZpiw5J2hkvlEaP+9nBOmpVciw4aIGv367nCWUYhimGiN/3xzmUFsu1zkoqF6Ed80JD+gfyA+OKo5Oc0Xwdl3lm8GVePjDotWSTN/CyGtacw3pVoPqy9e/Sul/HiI8mlOP88pdI3Ei8DmcDkH7JfRZYKN+rIDbu6mTS4MvVpd/8yaFKu2uv5V67V4GX7XTiQx1y1X0TKASZdz5Usard9GtUTdfHu6cIqsPtBIivGOBQBJXOEdOyPgqx+S1olLJQbsySl3z6nhqTLcIQRGtIsq8EN+HhDzWEyUKWv2nLA3HD7zqsRJnQCO+TFt2LFBaB3KvcslZqrZ/bVpclQ4CvW7JMSSQ0e56V5bexs2cZfHUJ6WM7nFdL2yyG5eCuM3aRsjMWd2sEa9C9vG65QCDFf8UKNvB0iOdWAgTu9lel0YVoMnWjd+SCaW95mr3J+ii6Uc5gIHQnqpCUu1xHl5QUtnwNva2Aev+1OqqdD/MOsrvhrdP4mVpqtR+e7qEbRyYjO5dKm+PO0FTaWxF7YN4jzIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(33716001)(71200400001)(316002)(6512007)(83380400001)(186003)(6486002)(6916009)(1076003)(26005)(54906003)(9686003)(6506007)(86362001)(2906002)(66556008)(122000001)(8676002)(66476007)(64756008)(38100700002)(4326008)(66946007)(76116006)(66446008)(91956017)(478600001)(38070700005)(44832011)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6WRZGpqd5JjDsQ131dGy/4d200bJ0TPIEi9FY7H9vq9LBN9WZ6vgYPLCzkQu?=
 =?us-ascii?Q?mAziBS0K4E7xovZHyPh2aSLpeMFzthW/M9l9ltqnnSZaw8VYUiC5WTfN6JZB?=
 =?us-ascii?Q?N/QiE5KHFuN5NNrG20WYlt4yFO9b5ZvPtVsjlH+le8NToGtiHX/TpnagCeE+?=
 =?us-ascii?Q?F7noRBLgOSsRErTb2zAf+XbgytbMv5s5LOEizPtiJYfhYIwkwERq/gAIGQ7L?=
 =?us-ascii?Q?pkIYm7yqQXMsEUqdRH9BbjX3df7Pew5A/KZMW9hqj0g6igdQ0EBn7wPzGUIO?=
 =?us-ascii?Q?1xZRJUv40s/UeTpjmn0wqO5QqsTmNlwPuaHpDjVEbySz5u8mZbos4UPq/LEd?=
 =?us-ascii?Q?V9xBrDn48Ocp5ZEuMxA9G+W4Jo0Kt7qA1QVW6JqVi0DwdJR+cSjwHp/CFGsN?=
 =?us-ascii?Q?WsedYXmr+ZkUiwohU6Wk1m2eobUU1oju9yfQKvFmmeJaZsy5xYGwtHEc4tHQ?=
 =?us-ascii?Q?s+6wkvandss/dgergYW7ZIsAyGTFwMlVti+Sr5Bla9eznCH+BcfXxGEpjLhO?=
 =?us-ascii?Q?cjDwUJHL4PO2qM3f9e4P5JVd2btECH+rFqPU+4cW+ESu+MDYCzFMfr6z/Ml+?=
 =?us-ascii?Q?Kqsqh1lceSF9ID2XmFYMoJhDVaEZ6qGTDcfDGaxH83IdZqZ49T0wNQh3r8Te?=
 =?us-ascii?Q?vKBanPTpsCAwm8Fj4ant6U7LHq6QgE3JIHeViupGuz4fny7cWdmkwlVpxKGb?=
 =?us-ascii?Q?+U1fQYUDfgajnOz6rWqo+TahtqBb7utHZwefye8mrUk7yS87Y5wtF1z0rhNN?=
 =?us-ascii?Q?b4zm1Is2D2HLM33ue2nKSH8UTUeld8Njx0Bf2YxT0sNn7z50lwGc+8S81wFt?=
 =?us-ascii?Q?7TAIgKA7zuqcqnlBa9XjYtm8ktrL5AEdj5iEq3AKw3sQQmWUXV9e0uNuztLR?=
 =?us-ascii?Q?3NKpqW6TjwkJM/Jg61AbDvKeV++BWwnCJwcTThHXJ6AMP+3lWBUDuv9HtnVc?=
 =?us-ascii?Q?2WPDnKb5dUTui17VLH7PW0KDGqkVx1ftUX5UZy71jWFhF6mrAV2Q0g2zi3r+?=
 =?us-ascii?Q?BdLP5gbyFrbQF52wpFqt8RG2963fWYAoGAyvSewtkYRbbiHAf8I2aZuL+F3Z?=
 =?us-ascii?Q?RbEyaw+hMID9NXYpxgC2V64bIUw/Oge01H2nlMIwQdsGWbQGY6OVW1WrBPfJ?=
 =?us-ascii?Q?+dY8oCd3gbPJHLnffPCzUC8Hj52RP6tC5ypZohv9SavsK1QOfIcBvJqYRE8g?=
 =?us-ascii?Q?CsxpaWr3w3GZpoVZauR9j1T5KNy0OFG6J7P/dPY6PpyMt2F121pJCuEj8IJE?=
 =?us-ascii?Q?0Shoj8SUjPvrSM3IFt6rs6d+HyievWxkCvzNYBmtzQw6Z4HUJahnvacVbX8f?=
 =?us-ascii?Q?bP9yQkdtx7nAPH+elEQhzzjp+zu60GU4pA8UGnaK00l2LErT8FCzky2ybBbl?=
 =?us-ascii?Q?goxrIfGBHqx+yrn70k26UC8zIumBme9wlt+oNBsCBUT4wDGKsP3udmOwBzSs?=
 =?us-ascii?Q?PSY1BJ33OcYStKhi8T3jSi1KpS1qIu70Y21+AhwxktFGhZaxKrKRCVloornU?=
 =?us-ascii?Q?VdXrqdhBwavvvFn8CK8cZxjS/gN9G1gL+dowgaGgEEQwvSbwwvtm4h9CMlgB?=
 =?us-ascii?Q?AYkQVdtzdPADkVWiykFB+82yIIDi0EvhN74R+cQAtTvYDZtnfB34073pGATI?=
 =?us-ascii?Q?vA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E89E81611233F44922C56FCF93F265A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NO45M1X5yndr1wGXiJkg3rDC3xCh0tzMfEFPz+uOn26m7WHB1HLSW+rxBil/?=
 =?us-ascii?Q?wNcTH3KreFXv50Mp/YcOmtxjNQjtgW2/yhuQCX+klPE+iWHmaYRDcS1pm+Gn?=
 =?us-ascii?Q?bMquYUgVSgSTR80iOnjJPU6C7fkv6j9wFn9L5g2Mk7vXKk24G6ibpewjyDkV?=
 =?us-ascii?Q?QrDWzFDw8gX9Wm91VMVtaFzQ7ZZCbM4dkQuhqd40lTpH67lqRGFkuZ5zZO9p?=
 =?us-ascii?Q?+MFBBdum3GcItjNaEMET+kskwstOoqhuSdJ//QXSp++QVaB0RdcMXkD7+uHj?=
 =?us-ascii?Q?h0khjnQwyR5fLk3ytxSZyPKtFI9GmBRw3m4xhnhh0C/faPGTYNvSfD+L7LYF?=
 =?us-ascii?Q?ghGr8RX+VbIRmmCPGSecRHQJWVbqIMg9LbqpSM7PFI24OORj05ncSZlKI77k?=
 =?us-ascii?Q?S4wk8uA4dzzZvVmnoPQMjEP0EhcOajeP6livHvpapvHiBpll/GPgRqHpLKO8?=
 =?us-ascii?Q?YlrqJQEWKkB1LpsXvn9a2UWPjX5MEiEDjm6IabNnXfSFnpqj0aEJENKIT+ae?=
 =?us-ascii?Q?7I82uOmVJO+pgHcsZHjse2jHQ8XAAPE+oXAOCuzGvXAVtf02kV13WMJ9JjbE?=
 =?us-ascii?Q?huFk1pHjAuN+DgdrOVP2vgtutImiIOkNE5D2qKeVnI71Q5MOyzGUtlypw7vE?=
 =?us-ascii?Q?sUuw1XV3n4WXhlHMx/zkQnv83XIiokcPfizE6+uccAYDY7Un74MKUNySJe3U?=
 =?us-ascii?Q?UHGOx3rrOTXVeJAyGl7t9JB7n8/rRsCv7SzQY62MDW4sR9g38RBERo4l+wYj?=
 =?us-ascii?Q?kxxf5VEaZw3Tez3NeCFPAQ0SN+BSum54THZTnJXIgH+6F1V0MK7w9N+ZHZc+?=
 =?us-ascii?Q?LNH4tElBKQjAbDAo+wRDsRXeZ38XVceeoUHFTJKtmpdSd6ALYU6LgfBYkJvw?=
 =?us-ascii?Q?4MwMdvtjyF/XXl2CMCFb5jIAwWOXsP1pTp/NPRjUi3mITdl/JePFfdjdB6+5?=
 =?us-ascii?Q?eL/CWVRN8Dvlay3ZD3iUBHV0crLr1oxzbgU00Ew32Xocpu3EjQbS6EXb9QHR?=
 =?us-ascii?Q?Snrx3W4/jPqlu+9xXxV0y5Z/UA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e06efc-8944-4cc4-fa4c-08dad6d003a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 14:50:12.9359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVbi4+fEmnSLI03E+jOHQeJOTsJyGuD4dn6m7hK1seT4TgkGi7bO3+gQhg2rxUAXgBl9fHGcYyL1rcmk286W+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6811
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=442 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050122
X-Proofpoint-ORIG-GUID: mpzoJl5r2KWjMAjpAB0jF_wc_Vx-eBBc
X-Proofpoint-GUID: mpzoJl5r2KWjMAjpAB0jF_wc_Vx-eBBc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jann Horn <jannh@google.com> [221202 13:54]:
> As of commit ca57f02295f, brk() can expand ordinary file mappings (but
> not file mappings with weird flags), and I think it does it with
> insufficient locks. I think brk() probably needs some extra checks to
> make sure it's operating on a brk-like VMA (which means it should at
> least be anonymous, and perhaps pass the full can_vma_merge_after()
> check so that we're not creating unnecessary special cases?).


Thanks.  This is probably caused by commit 2e7ce7d354f2: "mm/mmap:
change do_brk_flags() to expand existing VMA and add do_brk_munmap()"

Specifically the checks around expanding the VMA.=20

> user@vm:~/brk_stretch$ cat brk_file.c

Thanks for the testcase.  I have a fix that I'm testing, but it's worth
noting that the brk call will succeed - except a new VMA will be
created.  Is this what you expect?

...
>=20
> The codepaths that are intended to expand file VMAs do stuff like
> i_mmap_lock_write() and vma_interval_tree_remove(), which
> do_brk_flags() doesn't seem to do (because it was never intended to
> operate on file VMAs?).

I don't think the locks were there before and I think you are correct
that it wasn't intended to operate on file VMAs.  I made sure all the
ltp tests around brk pass with my changes but this seems insufficient.
