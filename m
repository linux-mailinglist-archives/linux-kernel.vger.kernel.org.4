Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29F0611DBB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiJ1WzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJ1WzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:55:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0243051431
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:55:14 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SKxPSC013278;
        Fri, 28 Oct 2022 22:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DA084mNFA1PUdhcj9SEyp2d/+yoMfjECSLLLVWqefX8=;
 b=a5N2hoL3WNKVs2LqquuZYAoC3oWYExrRxVutONRI40jCgXfDnSIXAzdTsVIyfj4/828t
 fJRfJDfOlhO7mWcDMPNQqsi+Ld72hgQo5CmzoNEz1aJb60bniQ1xuhwix9HeuUHmfLMB
 6exj44/dySubgcdcdIgYWiHXZJaarT+dV3J851DtB4ltoFqNyKIm3VLXz8dkn6A3OCbJ
 qhMSyhbHCzAtQ1ZIKcHcZzA3xDNnK52cZl5ML+r29Bi9AavhxHetAvR9YYQY7y9huoP7
 YsSNicAze5pGtlElbUGLa61f8F9nyvA2PK7xvKsYkqkvp9gNg437mbMLd9Qh+MmRSZGT hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgmsd8fnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 22:55:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SJFxjA017495;
        Fri, 28 Oct 2022 22:55:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagj0u25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 22:55:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K19VLoqxJXbhWqXrdGFzV1nckZWHsjN24oLyNSV6dArI83E2CY2DKljhDBgHdUm7wwceyBL/P9ysH2cvuG2tuepLu2XKwqWj+SjgX1Wbcxfmlt/gruNN1AeOclZkA9jiqjtDOmrcHp8yZqC9J+JM6+75Dvrw7j2udxMXxcKlsf7YDbtaxV7mPun6j5LE6A/TvMUGe9oJPtfucaaeg+d06dUCF7LThrN+96T5r/NTBc8DwXaNZk3CxomNHP0smYDP+ay1k1O5tcBc/rjsxugsHsD52Abo591FKqbEIAAtdZS/qoWXiMktjIZQlolTyLxOdSnqsphckFgcNkJt87aqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DA084mNFA1PUdhcj9SEyp2d/+yoMfjECSLLLVWqefX8=;
 b=JLvO7SFlWDT2JsoOpQtv26bGlkWy7S1uRHRmXT58B3ruS596obBr7G3kFRcrXwirgSaQppxENSMzMNp3RwUu0AIfk4TezXrp+KIK2O+3wVufOtYCi2/QKfqvahMn01YgEXi7FiQq+ZLKspeMNOYznlFzM/KE0M7ovqleLbqpqdY6e9xKBV22RnfLiPbOBaWzOZipIPnweiYgEHVheiTthzUV8yUaotW40zjAG17q4M4/GD/TBo0zrrYzPa0O8kwJ7Y5I2JsrK8Ks0/YD0SU8BXYbJyKzL9g6Svba3xw9GpWgrAFXQI+D8C1+3m791Arrnnzo8JYVs0PAocZGQwbIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DA084mNFA1PUdhcj9SEyp2d/+yoMfjECSLLLVWqefX8=;
 b=PCwnTOxADjqePEyGedB5Nbl4rcFM1A+tQobjiUVAZ391TBBJz+oA3lWnhXXf5p450+yizOpW2EKuEfauBM5qzo1BmqafWVNxYGTsaZHAd/ayW0WZXteKrCISXxJsbLoNxsfXtXhpMr/1xA6GBBP/26dO+ZqMOWdNWVIDTVCBf9I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6339.namprd10.prod.outlook.com (2603:10b6:510:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 22:55:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 22:55:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] maple_tree: Reorganize testing to restore module
 testing
Thread-Topic: [PATCH v2] maple_tree: Reorganize testing to restore module
 testing
Thread-Index: AQHY6ve6jfsBZBFYnUiA2MS4cFCD5q4kWvGAgAAPtIA=
Date:   Fri, 28 Oct 2022 22:55:00 +0000
Message-ID: <20221028225453.m5vgj7tkpxt6or7c@revolver>
References: <20221028180415.3074673-1-Liam.Howlett@oracle.com>
 <20221028145841.4b0eaa422cbc775c3c074962@linux-foundation.org>
In-Reply-To: <20221028145841.4b0eaa422cbc775c3c074962@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH8PR10MB6339:EE_
x-ms-office365-filtering-correlation-id: 30c900d4-3f33-46ca-f00b-08dab93771e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +nMpCj8oKC4tlaJzLAHwVDWD2Ro/rnRcPWhkagsyLK6K2Xr8k4CpoL9RNTTczkbYprYUizqq5aJtLzWR9ljhHEtQzYgu4qUZVVP6Ok6yHF0uabxc6hm74fTeujHYAA6NYhclYodHMpFREwMeHO/mu7b5LB/GI6v7r5CRwXtvvxCIX13Qx/Wj+OBsDAtoGEGlPT4NgeFc5b6UO333p5ae/muZjbdH6RUcw3kRai8il7Ps6vYAKP5Qb9WEMhN55iAxof3SIlF2RlSLsHFamQDIs2WdosoQIXWfzdOitHV9j/kozHYFdiyXj9K8p2mWUZqY3gSbZvBcFvX4RotIEIYxk9xVvsP8eSeTXtgYaZn/42b1o76A6F/Lbb3DDEDgQHX9Y2gcK5DDQBUZp6mdxOGmwwE4+N9sMSeGKYAi1wggYO2mO7sdrsBM6I6cKsqIx5RlF8W6c8wh9AZb+lec2I3BdRg2jkF8i5caFg5KBKG+MON9BAY2eC3Kz7HbbbaRihoZ+jooF2f836KS7ucBaaj4dzRZDxDoFVp1YlcNJFSpXWXub9CJjqy9QadGr5Cyzn1s8mVJcBBS4MBLvzMqCT6iXiEQZQQvasEFZD92K54PWfWfoiQy+hspiIoIehPmSbYx9af7V6cs67GQrKy9TsIFQeFYnwD11XBafsNl8csIv87wRsrp5vMlFMrbnAqTE0Y3uGBLKVyseNiBQPsflS0AqY8cAv9E65LMQgJ19VjVlJmhK3Dz/c3OrEzdtm6GnYjXYWmaQVdbBPkbR8vMRVR8Yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199015)(38100700002)(122000001)(86362001)(38070700005)(6916009)(54906003)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(91956017)(76116006)(4326008)(71200400001)(33716001)(2906002)(44832011)(41300700001)(5660300002)(8936002)(6486002)(186003)(1076003)(83380400001)(478600001)(9686003)(6512007)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kaQPaFCSfN7UWTMu2JVmhhyJfqQEYP7u2M0W7kd7C2e7WHh9qn+iWHXwcdRq?=
 =?us-ascii?Q?OTUDM2xNn9gvmSFNN8xa33LFkXFxFnMD94eOMpcV2/vUZsPY5CFQsoiRal1v?=
 =?us-ascii?Q?njmJHlXda6hnKdkUVw8KZ6VLYTrBJf4GPYdILAaEKQvA3GuaQGs40Ra6Ld++?=
 =?us-ascii?Q?UwH2ODJTTijrw6RWoTEoj8feuQ/hkpXpCcCEbRAlExcHaH2sM2B1uEB0Zzyx?=
 =?us-ascii?Q?5aeD7QylxhbYL5uW/XgLIsCbMgp/pxWKUj+8DHXYx6u0m1z/QX8RTdOajkSi?=
 =?us-ascii?Q?7WVtFzB/WrzltlSz3MMVpwhvXoAoq4Zc/igdw9j+plsy9aLny8krD+tEA4RE?=
 =?us-ascii?Q?pYOOv0w9Q7mR48Gn5Kp5Fmm+l6n/KtOOBNvihNhDFSvmEaWQkOWcFmtaqh7/?=
 =?us-ascii?Q?Nlr3pn7qyqicJbicknrqi2VHaaobi1GkcK+Xz74XMWrkZ2e0lBQi3hTi0NBH?=
 =?us-ascii?Q?C8yKOsPS6Xla+xnbYUhxspvda3NkliOS+M1Fc2lpX/o4olXyp/oLY115Ye+k?=
 =?us-ascii?Q?D6JBUqkEWohXBgmvLjFHwAK1ygPjq42RxUcR/On6+DiLM7dqfHzRPmqlttXe?=
 =?us-ascii?Q?4at/ui83ESRRswK7GTIuZ12NCEGed1GEC6H732Taf6cItb65XaRV56mVBG08?=
 =?us-ascii?Q?sE5Av1SWLQan0eivHXGnCAZ7s1MFRqWZ0ftrdcyJYcWY18Y97bdncFIOSK+X?=
 =?us-ascii?Q?vYw12pHks5Q68Z7bEZISDtveDpFHVcQ+IeR7aTRrNC/ngvmD5ifRICrTBwqk?=
 =?us-ascii?Q?FtzxbPTNBMRrmX2IKLmmkIRa9S/ACb2p2S2bIQvuAaWOQdDzCUokKw3vFhG0?=
 =?us-ascii?Q?OcaXCfQjTldwJrZprXPv2H/hWwsYeguFDo8uP2TPPgAxiC/Y6Af3WWDZrteq?=
 =?us-ascii?Q?qqTPgFvdNmphyohcmtcSrx5631IgWTZ+Cu5NdICgEWWa9kM1utjdXkmb/A2v?=
 =?us-ascii?Q?iW3WtSrQdzIi2kDPoEjFi/7SE5GtbncI6xccBksj+hd0g4wXnpQQRgNWWhLV?=
 =?us-ascii?Q?BB4cbhT1kpUsvMl91F/D4Zc8yFv/tkWs6K5Da6YUouB0qZREZVSBKaesfxLD?=
 =?us-ascii?Q?MRXQGp3Ew0qQdkh8514Ay32zMk7tBr+yZ4BIoz0w73JMUKPyZTEU6A5r1Lz/?=
 =?us-ascii?Q?0uoqkO5g93qkW/9AtXPNKZ96ZTzzRkU6PinAQFvbfYnMtmcWeK/vQ0c5XBuF?=
 =?us-ascii?Q?GLQCwOQ85yV2uZ06zjuD+Uh5vn+xEoPSbJJh7KYPgCqyqxcj38xXh19cQ5e+?=
 =?us-ascii?Q?P3iSfb+PCimU248eOWvVXKmDj4o1Tnl+cOlOiM45auGP8CC2QpsGCVFa0pRK?=
 =?us-ascii?Q?k2L3JYbC84h5lVY6+mWaly1Gvqn6RwfLjJQ4ZZ5MeUNNnK9VzykLZdcpy1eP?=
 =?us-ascii?Q?a2IPK0Sf83phfbikh24o7JCBX3U7by1GAY7Qegc/m4qs1jQdPik5wVDAgBRq?=
 =?us-ascii?Q?KirhBPwXj7x2tvUXARs1fr4aPZvKarlqFv70pZavyuQMy1cgw9fHfUQnlfTa?=
 =?us-ascii?Q?31JVpuyLhSLn7VLAKj/BQCafshB+096A3jzDXeAeaV7u8OW2t6r0dPnC/RYF?=
 =?us-ascii?Q?pxYNldjq9//Z3UXLr38jyFkNjkxMjGz/KEiy8whgsW+L98c7L+SP974kqcB/?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65F044190CE1E545A5CBB0A9A3F1A093@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c900d4-3f33-46ca-f00b-08dab93771e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 22:55:01.1424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3UnkXafI+rRrEmatmzCb56b4Rsud9dEn61ADCTAD6nzhgz7WbAnFN/MR9XutSOsMtCqzvTvOSglI80/NYO9/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280145
X-Proofpoint-ORIG-GUID: mSSwFxajRsbbKo7HQW447XQg1XPGKpo0
X-Proofpoint-GUID: mSSwFxajRsbbKo7HQW447XQg1XPGKpo0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [221028 17:58]:
> On Fri, 28 Oct 2022 18:04:30 +0000 Liam Howlett <liam.howlett@oracle.com>=
 wrote:
>=20
> > Along the development cycle, the testing code support for
> > module/in-kernel compiles was removed.  Restore this functionality by
> > moving any internal API tests to the userspace side, as well as
> > threading tests.  Fix the lockdep issues and add a way to reduce memory
> > usage so the tests can complete with KASAN + memleak detection.  Make
> > the tests work on 32 bit hosts where possible and detect 32 bit hosts i=
n
> > the radix test suite.
>=20
> My x86_64 allmodconfig failed with
>=20
> ERROR: modpost: "mas_find_rev" [lib/test_maple_tree.ko] undefined!
>=20
> so I did this:
>=20
> --- a/lib/maple_tree.c~maple_tree-reorganize-testing-to-restore-module-te=
sting-fix
> +++ a/lib/maple_tree.c
> @@ -6059,7 +6059,7 @@ void *mas_find_rev(struct ma_state *mas,
>  	/* Retries on dead nodes handled by mas_next_entry */
>  	return mas_prev_entry(mas, min);
>  }
> -EXPORT_SYMBOL_GPL(mas_find);
> +EXPORT_SYMBOL_GPL(mas_find_rev);
> =20
>  /**
>   * mas_erase() - Find the range in which index resides and erase the ent=
ire
> _
>=20

Thanks.  It looks like I missed this in my squashing of commits.

Sorry about that.
Liam
