Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0B9678621
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjAWTUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjAWTT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:19:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B74D50A;
        Mon, 23 Jan 2023 11:19:54 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NIOVI1000391;
        Mon, 23 Jan 2023 19:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tQ4ShznV9YpOWJw28JoUCSZY0mKWBeBIRoNLVwnsnQU=;
 b=p+ZICXR8pXg6q7a+pZLLchmnszVifwCimm2qtpQ5VpyvYvFjzU6DfkKRiPWEheeerHUD
 tLivDOSRW6OSbuTPyb5Klf7GrDLs4sofFcmcaud6u4VROvOtQHlR8/UcAKgNejvwgJka
 XD2q9jdNHxbRXTZR+8K5ZgsNUEMh3FbBBA9tO2gI8StETsi3p6+9W6ODCm0bVpqO0E9l
 Hp3Nt4ljGKriW3upDtOMeWRNaslfBtydkWW9C+7aSzLPqi0ktMbO7yqKRqIZUCVhhDlW
 H94/GZt/9I81+ZYAe6Jx/k2GKEpiPqgUIVN+0bXmrv6Nl+XzlydZLZdo80sFaEmgJcNR HQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86ybbpmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 19:19:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NJDmnS039637;
        Mon, 23 Jan 2023 19:19:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gargrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 19:19:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNj6uRAWkqHA256iCfg6RZULC3lhwjDo9lPuw23IX/ZFvtZ+tx1hMmTIhxf1CmCMitBOQvEZzzJsIK6nbAB8lE0+ioTWi7V+xkemtQqXF3rUhAYXllkaVO/V/W1MPVACBmx6WxFjRK9BYZmJS2/hPlBreqvOIfF1ih9jKysDHnVnLlAvTlb48x0tRUtu9qj7Re8EbxfP0zAVFxHH9dtFlYD+y3IjpCQHN5jVjQ3KNPeOlwFkbs5jYY05VxjQPHrZE6WtVlDkk6gT1ruKMvXvX40UOBwf/BXXL73S8cKRAvtK3cFCw6xEwpzxTGxNW+NZRIsQBEaq50vqjQ+zQTtyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQ4ShznV9YpOWJw28JoUCSZY0mKWBeBIRoNLVwnsnQU=;
 b=H4DdUoBeoss34na7itIfTT0jzU1IdoIhs7ESAJD954fkNTha9+rmJ2wravkWJTOMo8t/gEU2rj2YlXOKkc1tJ7ycG9gPjks/kWterZiLtQdidfU8+BeqS1R+ubACJLTytck9ChNzWiGNv2XjZOIc0I+l0MhFyiC7UT9K72fBMhFVqn+Biw1OI6+1Ib8N1qyxxv+zKyf3pVF2ZRJg2l5OHR9Dmdxn08bVwe7568V+CLMQ+QR1ql864vCT0g1wx+L5ZpAoZ77aCvlaKiqyVLBKoKdLiFp/nxPFEuczbLKpZL+J4hrSLaXWM95noT6tWEzjj3gmJB3TVv107EM169QxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQ4ShznV9YpOWJw28JoUCSZY0mKWBeBIRoNLVwnsnQU=;
 b=zc9Ca/G29cXhOxOF7s8St7iD4EiRdZnpnauuCoAB4WuFJOVgWo9SKmr+b36JWdJ415xFXGPCEOUFqLaaSBCEouKXg67ZUXcKbJHtOVRUGnBWmWcUX0QA84cjMYEkDQNf8vXj0YaesVJu+QGh8emnZGGHZpzUxcvM5yQNFmA5lhw=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by MW4PR10MB6677.namprd10.prod.outlook.com (2603:10b6:303:22f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.14; Mon, 23 Jan
 2023 19:19:43 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::bc55:518f:9d06:9762]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::bc55:518f:9d06:9762%2]) with mapi id 15.20.6043.016; Mon, 23 Jan 2023
 19:19:43 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Deepak R Varma <drv@mailo.com>
CC:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH v2] scsi: qla2xxx: Simplify if condition evaluation
Thread-Topic: [PATCH v2] scsi: qla2xxx: Simplify if condition evaluation
Thread-Index: AQHZJk7oCAW9VyVo6EOC2oSgMeJ6Oa6scqAA
Date:   Mon, 23 Jan 2023 19:19:43 +0000
Message-ID: <520ACDB9-9DB3-4189-93B4-D1B0B0E76457@oracle.com>
References: <Y7+oJuah0MgEW0PQ@ubun2204.myguest.virtualbox.org>
In-Reply-To: <Y7+oJuah0MgEW0PQ@ubun2204.myguest.virtualbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|MW4PR10MB6677:EE_
x-ms-office365-filtering-correlation-id: b6b1ccb2-1b59-4da4-145b-08dafd76c82e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTdQi2urdAETp6XNfMfR+ZHPoU/Sp3pPzRJP/rgrSio3Z+HI8gJQvani+YQ2sOfnxiKlXGMrs5Rn19Y76BJctaaM+QNFfEeRQoQxW5rVWZ0rMRhUpRwkpmRJe20VV/Zc/U7YZl+1plpsZzfEru3L2ABw51tnkPBagn4gUroZaEv2qOpiLRy/kZcl8hcvzDojj8Lkk4ClLGBTFjjQ3FRPQaPjgBbByS8jtkyHJSWg7+feZS4SssuXjl/pJ6VbQY+7j0OgER34bCnXjiLoPinC8J8DlSyC/J51jpzYH1MPEBGyzJayRHKv42RTl82em0doAhPjFbKLNkLTR+NIO/ss1YQvmRGOfsjKrC4owMJdnoj4W/UBlp+xWW97bErnnNp9rpNU5urEuNVlKDjZl7SC1q8J6SpbP9RdRTTdDwQ+aM4Y1cs3QVntL1Uy0nY3yehKzTJdUYeVH8gyuLGw7D3Gy46Odwx6fs26UhfpY9hiXNLl5t/Wk/GURJ6yVwq6Tu3zWA2cXGlZlUQQ0Kf8ZArvMA6mX40Ikb4a2zqOpyB0BqYUa/9UL3hEkkhvBhD6SG5FWgCnqyDCN+DhqpA/iCosdQnurvcfU1OMTBgTpx2CPZ2XXvGSZHfpZTV3Cf97XKfLq8cEyRkTIgmRZ6/r+lS2RF/uR4djj6FJ2SjIJBkerGWDwplKosEsCAGH3Nro5D8W8Q1dHjG0Pe0N3ylMNqhaDQEWxVeZiL6L/1nMDoEoTI8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199015)(71200400001)(53546011)(6512007)(66946007)(76116006)(6916009)(66476007)(64756008)(4326008)(8676002)(66556008)(66446008)(6486002)(2616005)(83380400001)(44832011)(8936002)(5660300002)(186003)(41300700001)(2906002)(6506007)(38100700002)(33656002)(38070700005)(54906003)(316002)(86362001)(478600001)(122000001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KT3Y55Rbbr4UDyvqh50c6UmdmuKsO/HTvd/e2/Ie0Tb55AR3Y1z1RUKAhZZP?=
 =?us-ascii?Q?doezTm3zy496h5gw3V13no8H1JMXDL/aduiBwUhFaeZP06abSSFGMkvBdX7d?=
 =?us-ascii?Q?Sjg4MGIr3CzD94MLDLzC3718mOpvpYKGJJ4aHV1kfmyLJsBv4YhLrEEsnPX2?=
 =?us-ascii?Q?idlioEsE18ktRnyIX5bSGTvutL4ip5vfE30MyN6wsrpu1Bhk+LJe9Lcc6DXX?=
 =?us-ascii?Q?FtcaQ82SGguAePo2gerySF6221QqoQ2QWKQel/ovfAh2KLhkZRogaRu9AIDF?=
 =?us-ascii?Q?XTR1VCr7bOVZ/CaW1CQQhcfFa7lMc2+N8g9Ki7xkmwytKbABIVRrQ8lPKG+U?=
 =?us-ascii?Q?0/MGKVZBbZJz4Qs4wV/Oa+Am6UTseegxMXPc93gO1P0m186/BhJDwMc4AxzX?=
 =?us-ascii?Q?cdreCSYgjyJpRb/UIvvJe84B4/GPUt9c0oA4Q2Sn5gcVxbbfebOiBJ5i80Er?=
 =?us-ascii?Q?Y/otWWBQmyA3kVQUU004QgfTpZu8GDdr4detawgInSONVQF6tK6ACMTaazrv?=
 =?us-ascii?Q?gNX7DFJM/kYt/1Zq9qBVulvmKQ2gUZpy71szqwXFi8MuP1pJsF9VwA/sULiA?=
 =?us-ascii?Q?J4aJPgYRc7JI3wnHntL/Y8vUqR5vlvoYfvHfsSL5axtuqCh2f4mH+zDfw26t?=
 =?us-ascii?Q?esy0dawNi7Z+2824ZqpEm4NuC7ITPhVZ+GQfEufl31/DTTqdlIWwchay5LqZ?=
 =?us-ascii?Q?uuDVW52D2IEs7acxbu+h/kNZjnWj7h6p1N2xDWNXfkzN7sRG3xdAlZ08chym?=
 =?us-ascii?Q?NzmCrfnmdQ5pw1LnjHrUiHNXaCBHkTQkZdPatUE5kH4/Z+nDytkpNZVdcx5/?=
 =?us-ascii?Q?SkzF/5K0NJDP5xh/j417mpKaxYx/+Ppt5jxHIHU5nrRbmIm88LspaVavHhcY?=
 =?us-ascii?Q?yXyOKsb91+GazyuXJsBj0erlaD5ePV9rMfacATy1h3I/sGW/OjTeuWIvGI0E?=
 =?us-ascii?Q?P/IzQPIWdXXhZCnEpnkSL8Y38eeXYVQAeKlD/O9JyLp4yugafIEY3+iM5y4Z?=
 =?us-ascii?Q?8xZR4c0ZI8jcF2FrHXMG+sF9EYbkbGtmSdKk62xmxa2NDan/8vWnW9mdVWem?=
 =?us-ascii?Q?bA3I+T7fZfiYW+6IPJQ8Pxd4azpNeszqGOKCXFEGM4jnZ7cLP/5nOZCT3nVD?=
 =?us-ascii?Q?PAWovxuJtgHNj6qGjBvSROrgxslZ4IWkrPaJqLRu/7Svj0gVwYofZi8y7cd4?=
 =?us-ascii?Q?0K+rdtm+SRDQPLwTLsBvjGB9Ty+JFFzZGUnNYCeWzc4eUK3KtJ+5LTCRjoCU?=
 =?us-ascii?Q?O63vfPnnFP2SaEs23isiGOjNBEsXS4v2shoKIy5lrm2IujJCReVUL4oc/yf1?=
 =?us-ascii?Q?a7xqhjOzhpKT33DUIkDWnylzFSP0H8JKpvQ+cX+UTkrUBU5D4CmPSlxNqVCd?=
 =?us-ascii?Q?4yXfcClz+yjPTLgij7xILTklz/3prv8x54z7o9nG5FrIe/P7di8ZwjeYrdaa?=
 =?us-ascii?Q?67l1oLyJlDUnB+gf0HVK9cPQtAiWwYm6aMBdvJxsXNC5i81uVCWlPi4yv7Oo?=
 =?us-ascii?Q?J+ppvR491snkLHIiNcWZrMmFhNdxgjlJMF5iH5qZLC7NJ735B4EiZfPnCAtg?=
 =?us-ascii?Q?NcLbZYDeEHQGVADpg8Ozebk/Z+X2wdZZfJ9UD776xkOayAaq5ORWrWBcki8t?=
 =?us-ascii?Q?Jhs02+2vnbP7bx229VBOzuNFzoZVrb85O5CdHcYlZkJg?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C110DD92DA1604D986C1E9A7E5FA593@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?7Co0iD+KSTKXN06VO5TBqddMzT6V5bnuuu+MkBWuQ2irJgFuevLdlYnbIBZJ?=
 =?us-ascii?Q?M98vA8GsV7eonuoaGz6paAOC1lg1QlAIGyKA0m7wrqKYBFSBJJtOlU54j5k1?=
 =?us-ascii?Q?FmaOb6SzskNxtgFIZKpfHic5ckmJsxo71w607STltjrnQBbSaqY9442ARWn0?=
 =?us-ascii?Q?hlakgUDiJz0Mc94Q8yiqhqgkl/ePO4NuqJrGe1IHKdGxvVuUImfG55kUOcXS?=
 =?us-ascii?Q?hhtcC9+2TRQD1AfCI0Jf+JU4q7J9AxGQve8QXnvNU0kUV90Ah1JFxFmYxoV5?=
 =?us-ascii?Q?hqGZnivlv4tZYC5jKfolL+XdeGznX5QGQ6Xi1VFJlG+yJ6ql3VRWB9Ra8DrL?=
 =?us-ascii?Q?KNkgPXTQGxu5hDbBwiNYLulmPly4D8EgAQWmHUgWWqcHj6IOqYlT1wBODqCw?=
 =?us-ascii?Q?NrlcwGX2GNz23MeKMD2K6KuZoOBIXE3DP4zgMV/UJ6nNTGoZa97fmXfrNaSc?=
 =?us-ascii?Q?8dJQWnAJv+UE7IaNxj9R7nDKFt7+TIQc66z3VWBFaiH9Zo+1WtZDyt7FpVAA?=
 =?us-ascii?Q?lAlm9/9pBZdTo4wagFI/76TvQPEIXH2qV+KYkyk+IDKUC/pSgTssEHPJBIhD?=
 =?us-ascii?Q?BVldMD3pA8AsnAd+Z6PN1sA/4Rz/Kjo63uu3VtXjKeQJDC99usW4UHPP6vvA?=
 =?us-ascii?Q?9MbkwihsNwxyUQwquK6LcUCZ8ZlDabjdbNoxGx3yMpq75OT/2+SQdOYFaJDe?=
 =?us-ascii?Q?rUf3HQSBIsID9Xjl6VDUE87miP9DyjQ56+mL00T0fYxSnxCKUD5E/V01m3a6?=
 =?us-ascii?Q?HqEha5FuK94JDRnGiHDKOtTnoNNRgiZfJM/ntEecj+xxn+1Ccuj6MOS/L2/+?=
 =?us-ascii?Q?uEQfoq0iGmnL1bdNopbRKQWS15RVpyrgAcUjQHmTJgGG8FJN7vfNNDZ9Vmz+?=
 =?us-ascii?Q?KNv9cT5Ln87ZsXdmdEk7gcQAZLJL+ZlB/ZZ/P2Taw9UPUSrDWem5t/ojTGRN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b1ccb2-1b59-4da4-145b-08dafd76c82e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 19:19:43.2621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFGyz+6EucLHWe6CBY3Z9IoP5mUPmrU9B8z5IjaiwKwL+zUxbZRG0TQVSURu/8Uxtcw+/hMCCiWoyCMl3u0TVCFXi5rFhIIYAUVM/2fUfV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301230186
X-Proofpoint-GUID: woZv8OG5YEsq7VYSsBup5u4Mdshdpzkn
X-Proofpoint-ORIG-GUID: woZv8OG5YEsq7VYSsBup5u4Mdshdpzkn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 11, 2023, at 10:26 PM, Deepak R Varma <drv@mailo.com> wrote:
>=20
> A logical evaluation of type (!A || A && B) can be simplified as
> (!A || B).
> Improvement by suggested by excluded_middle.cocci Coccinelel semantic
> patch.
>=20
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Please note: Change is compile tested only.
>=20
> Changes in v2:
>   - Correct the if evaluation from (A && B) to (!A || B). Feedback
>     from Lee Duncan <lduncan@suse.com>
>=20
> drivers/scsi/qla2xxx/qla_target.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla=
_target.c
> index 548f22705ddc..4f104fbfe55d 100644
> --- a/drivers/scsi/qla2xxx/qla_target.c
> +++ b/drivers/scsi/qla2xxx/qla_target.c
> @@ -1028,8 +1028,7 @@ void qlt_free_session_done(struct work_struct *work=
)
> }
>=20
> if (ha->flags.edif_enabled &&
> -    (!own || (own &&
> -      own->iocb.u.isp24.status_subcode =3D=3D ELS_PLOGI))) {
> + (!own || own->iocb.u.isp24.status_subcode =3D=3D ELS_PLOGI)) {
> sess->edif.authok =3D 0;
> if (!ha->flags.host_shutting_down) {
> ql_dbg(ql_dbg_edif, vha, 0x911e,
> --=20
> 2.34.1
>=20
>=20
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com <mailto:himanshu=
.madhani@oracle.com>>

--=20
Himanshu Madhani Oracle Linux Engineering

