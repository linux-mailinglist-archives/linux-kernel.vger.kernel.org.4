Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A707365F0CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjAEQGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbjAEQGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:06:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6251D1BE90
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 08:06:08 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E3krZ015836;
        Thu, 5 Jan 2023 16:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=jf2uzyQ1jJ2FkS8pnNO0zC2YrHsdKmkV9ZY4OKhMHnY=;
 b=hrSwSuJLpbL4psuiG5VCjqnlVG6N3VyZA+p9zYxO2vien/prYDHjdSG7i0DmI3NchmDi
 DxmnKKj0vFXYUvFxw/f1mN4CfI4mdYIcgzZSsbWYL2kR9bKb6Bf9Tbo/iTk1CqZgHsqf
 DQa+0xX2I593kaUN7wRXNhT4Rs3eS6MnZnhS8rK3n/UZReDRbWz98Oq+nMuXznNRnvSA
 A44kf3adU42XoAl2BaiClImNBcro9kdXMXtocTK5y65hhzExEZVyVCxEEUkrSu+i+HoA
 8BKGValSuriAnc8Mgqy7wjmr5W1+WnPP8v/BmfAg+0zD07cR/5Dk0Gota5UJBmrhpJGv 5g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbgqs6nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 16:05:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305EPLAe040358;
        Thu, 5 Jan 2023 16:05:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwevjpra7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 16:05:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+uX0RdHJV12Ejf8mm9+AYgb8cUKzaCV36xEtTApeeECctr53tR15uN+Njn0o79lQY/8GOXqqlXkExcoPTIouXTfB1X7tyR3vFIbCG0sDvwCeNxXHN3ejmoJNr9V6IKwc/kDfx56rqtbrNMNV6vjhd3EODuFZC9o3+NQNjf+olEMS3EgLzSidM1s8kq7b0b4xB7jW9MTSersfe07MJpIIbmlQTqoufrJrOW2wM9bJP613XeniJyo+T4TDP1C1D9TWYsSThgF9mXsVhkzP8EH79Wz9WM7Ta0hH7Hf0rSd4/3wRX/4UZXWTDdzkUHFoIM3FfdxLGeLkJqvrNkBUAgePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf2uzyQ1jJ2FkS8pnNO0zC2YrHsdKmkV9ZY4OKhMHnY=;
 b=Uu3BZiG5jUaoG+lLQ7BYD4vhWVVFZop0/0xKvqwJuahqlJcHk4151yD4EIISfWfqXpB1zDQvk6yvwyqL8CdUKGax5K1FE9ZXioidsCGCRWoFLRNPYqsp+/AajYiw1keEv93hYst2u3OcE2d5vblUVj3HQyentae1zFMnqbtXFsNWxx9jueftZy1waOAqnbdpbkRqVxkRfn5nUj5fQmVwEzKtOc2r9iieyfdlrAIgPEtvJ4kNXbhPF4t9F3KyS26OWifLPfSHAiNFTNvyd7Fc2fs9o5CNMDicgjvA5NRBw71LXaRXFtUXWmuFGzANbVSFyH5PQ4Ks2TI8O3+35LxskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf2uzyQ1jJ2FkS8pnNO0zC2YrHsdKmkV9ZY4OKhMHnY=;
 b=jzhii8yulm5fc4oDU/hHFDpAcJ24BFqIxY4fabjRR3zr0F4AOh0O0hK+ry+6nV5AjFVT50XCN6VFPKV/jBes/0NwG72H84110NyxufX6unyZ/P6WMuPfYNxxREgAu8a9oNVzd81NYefPWBlaUvHj4LM7/tr3rOrRMrb6xC96v6E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB6566.namprd10.prod.outlook.com (2603:10b6:806:2bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 16:05:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 16:05:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Jirka Hladky <jhladky@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] maple_tree: Remove GFP_ZERO from kmem_cache_alloc() and
 kmem_cache_alloc_bulk()
Thread-Topic: [PATCH] maple_tree: Remove GFP_ZERO from kmem_cache_alloc() and
 kmem_cache_alloc_bulk()
Thread-Index: AQHZIR+LoHdY1LXO4kqyIytgW9FJPw==
Date:   Thu, 5 Jan 2023 16:05:34 +0000
Message-ID: <20230105160427.2988454-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SA1PR10MB6566:EE_
x-ms-office365-filtering-correlation-id: c1497f28-271a-4395-f2ac-08daef36ade6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 09sBCPO67BBbPeUMusWzKAllq2WlT6BDfJx/9JYAqSF4140ErM2xFjmiMvCye0s5t4A8gYiViajzeh8IJfZ/AvYhPYrLK0RRVend70FVuX06nXHTupIDdAZJnVDv6EKQhG+ZY3CEqKra3r5Ms7uWtHg6YHQ79yldkssf3NDlK9EgZXMv+dURrm2zefr0hEn2R6kePLN7rJbPbAUU5IaGaENvk82J3cCHdcTrHnwEUR+VACunWURlgHpz+Qvpi2q6Z20AMh514K+afT07YQleImEbK4GgqatAdrhUoEKlUj13AYTHs6YD5ctq2nGqaBjMZL2kcg82JKmZU6WB7OXRWir7E25rQSrGyopB2xYiapZ3h6W24hmE91DKFGevzfN3YEoT5sRy6O7A6IbTLxJbAN+nKAZaCIbH/QfLrKbKwj2xlfC6pvKtucYrb2TMSEgawnUCDGkxDmx4rXbuQst+ffwMvhRwoFDuRDytMoITdS7dWXN5qbmFK0PkMlfziI75zT5+GLwlcA5PdfawvbT8VpLAdhheW75+bJmWCtLXzJ8jsNKarp4MRXjoXaCIfIcbgYUyu+cHTJqQeUCA0tH5T0EKPHmgxbWgCoJ18gwU2A6duPqzvRWv9mARtCutso4XYByI4W3vFYCGHnGUvDnFdETdiEDJo7Gv8JWHjkkMtYYQ09LD/QrhQ/S5T1liRL6uXQiiSUI6MiykTuCCSkxGUA7iYLrOogYQbbQq20b7h6Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(6512007)(54906003)(122000001)(316002)(71200400001)(186003)(110136005)(26005)(478600001)(66556008)(66476007)(66446008)(76116006)(64756008)(66946007)(1076003)(4326008)(8676002)(966005)(2616005)(6486002)(6506007)(91956017)(41300700001)(5660300002)(8936002)(83380400001)(44832011)(2906002)(38100700002)(36756003)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cRfCGy1H+JwM8lWgqyZRdh54kul0GIIQVXRU63DHeY46xon+LEzrf7icZ3?=
 =?iso-8859-1?Q?c63mig07+LwYLF/0ixG0LsozcFfVOTxTk4anXgMLa4pguQBsL87JPtKp6x?=
 =?iso-8859-1?Q?zPumaB0UcDr6RuwpnyG4ruUWucBgxtc+PBm006awJC+NxT6wUhFnAiG2//?=
 =?iso-8859-1?Q?xefOKdnBWpJj+rWaITZPCQbU2L528hgfRO6uwVJtV+EZCXRwhaqwhtBHbN?=
 =?iso-8859-1?Q?LZ7SMnVz7YZ+E01k9ZFevNB/1jYejzQd792KCc6JMBRNbH4gc+dcg6AOuN?=
 =?iso-8859-1?Q?N6yifxOFYFfUBXNvVAu7nrPCptbRHi6DwUp9p6S2eqSGvxGzPaC+3iOzRy?=
 =?iso-8859-1?Q?113JAYiUfO4VuiymxA4KGRA/df9rlLRiX30unK8h0eBuXi3Md58sU+q/JW?=
 =?iso-8859-1?Q?L/AEJrjKaxUT5DJ4upDg5RaJn8UcHSO7DDP595v9tDH0OPazy1mk/JDhHM?=
 =?iso-8859-1?Q?X3v5AZAcD27v9oQUEeFeY1KZkzmEZ9g/BGVU0VNSCbY9CcGykixgeqxVbD?=
 =?iso-8859-1?Q?+jSYR6sYrT05IvXOOpWPqeyNaf7Bcwfh16GoZzNPlfM0E1QHgJPtgoPiBN?=
 =?iso-8859-1?Q?XSm7AvM8Ouk3N8eke2t8SaJ7CxBMCfW07ZkzdWBLrx7DkszD8zmTOjIEF7?=
 =?iso-8859-1?Q?NO6pNiN24+Os4IOK37hJ7XT/AjdzDfgZ5dZNF6SOXtTLGm3kbOl1Wwurfv?=
 =?iso-8859-1?Q?I6lMggda0KrYjmT61PYHreYmyDUC0EP2TDT401UmaQViLhTGVvfNpqmxqF?=
 =?iso-8859-1?Q?V6Lkx/CDQupG/JcwsosCFvpL/hN/VdOyZt1AgCz1iOvGHjizHnll+zcKqw?=
 =?iso-8859-1?Q?jAlthWChwaPrCuopZuHbxn/uDS1TICrgRKMZqYDhYcgSc07czt0mb8K5vZ?=
 =?iso-8859-1?Q?apPeVIH7Xbsh2IFauZ+LcwwDl9NS7S7kGb6btr4fXeOLomtzrboC8UFt4f?=
 =?iso-8859-1?Q?XerF2HHGX+dGjcaOYKTk/4OmgAL3cxYiHG7srICt09iRQghchJz7IvQzn5?=
 =?iso-8859-1?Q?8yAH0J02nyitxquxNoLKSgoehLHvE4uw7ryiP3o7ku80YhEjaeNKeUotig?=
 =?iso-8859-1?Q?ZWT2/2yVQ/uVN3meMW+0A2InSR5ravIwyZm5c95jsA2nG68ofZhubGaRnI?=
 =?iso-8859-1?Q?AjCyNs5ONVp/Nbhv3QjQKTphlu1UrytTyBXwOJWnOg29HgOtfJ/Vp1LOni?=
 =?iso-8859-1?Q?7T8KKcTYQO1aKn/Jh0d5U+fZcuoJSeU/jRz7SQ9BTDNVUn4CvDgeiY/wNC?=
 =?iso-8859-1?Q?d3aj2xs3N0C1ve3DtsbECK0CkTI9lEVf/cinylS3zX+DvZOyCh9bxk5gze?=
 =?iso-8859-1?Q?YQnLTgA5J+15DGYDHFbn8AOhZ+3LKLMp129OqU6PcIpbaitrtC3o6OgvXd?=
 =?iso-8859-1?Q?Tv55jyyZjBjDg4lN64OZPy4m2G69WXRozwqhSwqG+9V7Wfkzp/gzl6CUZn?=
 =?iso-8859-1?Q?xs6kmaVinpsEiuWrta8U9Z4wLBNHYZnFJ/vDP2kkLr8XhJoc/nRyQjWKMu?=
 =?iso-8859-1?Q?Ntf2iK/22splZ7CtWsFPzvIzlvmiUDch8qj87eYuHVg4s+lSisJEJkswK6?=
 =?iso-8859-1?Q?9h+acwFnV5rdIDMD1aqD/383h2sMPajWzv6+4MchoK9XVi7oZo4WlNXhup?=
 =?iso-8859-1?Q?auDqGjtoQ9HTv7OqAEX7onlm45Dkwt3V1XRojU3mdaKmjXjegwDmbuvw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?/tp87pGjT4L5ZYUV0U4+bowGnLSaBJ2x9e+1dGxRH5f/81hJ8adYGDon8O?=
 =?iso-8859-1?Q?JRiy8AYGG5dOFvuPxCim4gyu0dqCuCyh3kaSR2ecIUQJ+dUo0MYfjH0uW6?=
 =?iso-8859-1?Q?ChuQL8UKDpVRbMzETA9Jm+3Evyb6izM2EUyerKbV8smjNFxZIOJu+lASMa?=
 =?iso-8859-1?Q?dKtv7eVw/igxSe4SMbmQUQL0Igy7EgXry1dveGSOTEdZ7rTaFBqmkejKHz?=
 =?iso-8859-1?Q?G27QOkrzZOzM96aue/ET8K7hzCadWlO4xUnXRQOPYPFE+CJo+6fDyuMxto?=
 =?iso-8859-1?Q?Wx4aWmAQ+351Ll4OghjTlqup4RCOztWAbGKgchLcXRxnRd7zCrROAV/DYR?=
 =?iso-8859-1?Q?1YjDCXB6YBQYb29lPMK6WA/RTdyvnb3WD8ouJ+0Da+yhRiMf/OMKa4xZVf?=
 =?iso-8859-1?Q?N1lW2DUwBfmKJZXZElfYQ2LYNUhlLuO+8/caNYaxFw8GZGUKk2tl46Oj66?=
 =?iso-8859-1?Q?AgiTOysxsxtgWZJ9YZISQaWBKlLxg+gn889bqBcsjug8kAvgV5nkurFCot?=
 =?iso-8859-1?Q?rqxFV43sDuVqZRn3dbRX1gtXiO9g4hH91CfqGzjuclQ9lS73P3Y3aX0mGi?=
 =?iso-8859-1?Q?Ltj2qhZYT1AGyz/ID7Unn4hwbVWIY0SRys8asOpopDcJKz4StYK4Nwglyi?=
 =?iso-8859-1?Q?mYpVgysQyCnAnjqsUXRSJ1aJ7F+ftlb+4fnpBLMKj2zzfezIqcL7s16vzx?=
 =?iso-8859-1?Q?NORc1adTCfz8keUNxC5/Wh0BJ9PpEjuNxiXhko/68QcKpe4kPJVTZhINpt?=
 =?iso-8859-1?Q?UaPQzGAZha0ie0eGtOsGQdMdq+DkTFTd0nHTVWzDZr301KEwyfuvFZ1xmP?=
 =?iso-8859-1?Q?oVcyt65e+tjGHmXiF+USSuD1LqCFTg2+MBrt/krocF6dcD2hzPE7/mq2gh?=
 =?iso-8859-1?Q?m4LjkW1VRB41CmJej74ALavrwxUpWVowF4U2+w2p5p46GMYwQBQcIJuEIS?=
 =?iso-8859-1?Q?aEZ4CWSjBun8b88j91rz45CQAt9qF7YjaHSu0HWMb1L0llBftrffQg=3D?=
 =?iso-8859-1?Q?=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1497f28-271a-4395-f2ac-08daef36ade6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 16:05:35.0744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E8PBumO96Golfyng0DRUUzJgNNwej76IF3pkcPI6BbKlW7t88yzDynt65tTPyfZ6LHQdpXD9hbZB6zXCne0Mgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_06,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050126
X-Proofpoint-GUID: yD9OR7Y8ftRPQdh5Q86f4LJ4TGnnMiBT
X-Proofpoint-ORIG-GUID: yD9OR7Y8ftRPQdh5Q86f4LJ4TGnnMiBT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preallocations are common in the VMA code to avoid allocating under
certain locking conditions.  The preallocations must also cover the
worst-case scenario.  Removing the GFP_ZERO flag from the
kmem_cache_alloc() (and bulk variant) calls will reduce the amount of
time spent zeroing memory that may not be used.  Only zero out the
necessary area to keep track of the allocations in the maple state.
Zero the entire node prior to using it in the tree.

This required internal changes to node counting on allocation, so the
test code is also updated.

This restores some micro-benchmark performance:
up to +9% in mmtests mmap1 by my testing
+10% to +20% in mmap, mmapaddr, mmapmany tests reported by Red Hat

Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2149636
Reported-by: Jirka Hladky <jhladky@redhat.com>
Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c                 | 80 +++++++++++++++++---------------
 tools/testing/radix-tree/maple.c | 18 +++----
 2 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 26e2045d3cda..82a8121fe49b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -149,13 +149,12 @@ struct maple_subtree_state {
 /* Functions */
 static inline struct maple_node *mt_alloc_one(gfp_t gfp)
 {
-	return kmem_cache_alloc(maple_node_cache, gfp | __GFP_ZERO);
+	return kmem_cache_alloc(maple_node_cache, gfp);
 }
=20
 static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
 {
-	return kmem_cache_alloc_bulk(maple_node_cache, gfp | __GFP_ZERO, size,
-				     nodes);
+	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
 }
=20
 static inline void mt_free_bulk(size_t size, void __rcu **nodes)
@@ -1127,9 +1126,10 @@ static inline struct maple_node *mas_pop_node(struct=
 ma_state *mas)
 {
 	struct maple_alloc *ret, *node =3D mas->alloc;
 	unsigned long total =3D mas_allocated(mas);
+	unsigned int req =3D mas_alloc_req(mas);
=20
 	/* nothing or a request pending. */
-	if (unlikely(!total))
+	if (WARN_ON(!total))
 		return NULL;
=20
 	if (total =3D=3D 1) {
@@ -1139,27 +1139,25 @@ static inline struct maple_node *mas_pop_node(struc=
t ma_state *mas)
 		goto single_node;
 	}
=20
-	if (!node->node_count) {
+	if (node->node_count =3D=3D 1) {
 		/* Single allocation in this node. */
 		mas->alloc =3D node->slot[0];
-		node->slot[0] =3D NULL;
 		mas->alloc->total =3D node->total - 1;
 		ret =3D node;
 		goto new_head;
 	}
-
 	node->total--;
-	ret =3D node->slot[node->node_count];
-	node->slot[node->node_count--] =3D NULL;
+	ret =3D node->slot[--node->node_count];
+	node->slot[node->node_count] =3D NULL;
=20
 single_node:
 new_head:
-	ret->total =3D 0;
-	ret->node_count =3D 0;
-	if (ret->request_count) {
-		mas_set_alloc_req(mas, ret->request_count + 1);
-		ret->request_count =3D 0;
+	if (req) {
+		req++;
+		mas_set_alloc_req(mas, req);
 	}
+
+	memset(ret, 0, sizeof(*ret));
 	return (struct maple_node *)ret;
 }
=20
@@ -1178,21 +1176,20 @@ static inline void mas_push_node(struct ma_state *m=
as, struct maple_node *used)
 	unsigned long count;
 	unsigned int requested =3D mas_alloc_req(mas);
=20
-	memset(reuse, 0, sizeof(*reuse));
 	count =3D mas_allocated(mas);
=20
-	if (count && (head->node_count < MAPLE_ALLOC_SLOTS - 1)) {
-		if (head->slot[0])
-			head->node_count++;
-		head->slot[head->node_count] =3D reuse;
+	reuse->request_count =3D 0;
+	reuse->node_count =3D 0;
+	if (count && (head->node_count < MAPLE_ALLOC_SLOTS)) {
+		head->slot[head->node_count++] =3D reuse;
 		head->total++;
 		goto done;
 	}
=20
 	reuse->total =3D 1;
 	if ((head) && !((unsigned long)head & 0x1)) {
-		head->request_count =3D 0;
 		reuse->slot[0] =3D head;
+		reuse->node_count =3D 1;
 		reuse->total +=3D head->total;
 	}
=20
@@ -1211,7 +1208,6 @@ static inline void mas_alloc_nodes(struct ma_state *m=
as, gfp_t gfp)
 {
 	struct maple_alloc *node;
 	unsigned long allocated =3D mas_allocated(mas);
-	unsigned long success =3D allocated;
 	unsigned int requested =3D mas_alloc_req(mas);
 	unsigned int count;
 	void **slots =3D NULL;
@@ -1227,24 +1223,29 @@ static inline void mas_alloc_nodes(struct ma_state =
*mas, gfp_t gfp)
 		WARN_ON(!allocated);
 	}
=20
-	if (!allocated || mas->alloc->node_count =3D=3D MAPLE_ALLOC_SLOTS - 1) {
+	if (!allocated || mas->alloc->node_count =3D=3D MAPLE_ALLOC_SLOTS) {
 		node =3D (struct maple_alloc *)mt_alloc_one(gfp);
 		if (!node)
 			goto nomem_one;
=20
-		if (allocated)
+		if (allocated) {
 			node->slot[0] =3D mas->alloc;
+			node->node_count =3D 1;
+		} else {
+			node->node_count =3D 0;
+		}
=20
-		success++;
 		mas->alloc =3D node;
+		node->total =3D ++allocated;
 		requested--;
 	}
=20
 	node =3D mas->alloc;
+	node->request_count =3D 0;
 	while (requested) {
 		max_req =3D MAPLE_ALLOC_SLOTS;
-		if (node->slot[0]) {
-			unsigned int offset =3D node->node_count + 1;
+		if (node->node_count) {
+			unsigned int offset =3D node->node_count;
=20
 			slots =3D (void **)&node->slot[offset];
 			max_req -=3D offset;
@@ -1258,15 +1259,13 @@ static inline void mas_alloc_nodes(struct ma_state =
*mas, gfp_t gfp)
 			goto nomem_bulk;
=20
 		node->node_count +=3D count;
-		/* zero indexed. */
-		if (slots =3D=3D (void **)&node->slot)
-			node->node_count--;
-
-		success +=3D count;
+		allocated +=3D count;
 		node =3D node->slot[0];
+		node->node_count =3D 0;
+		node->request_count =3D 0;
 		requested -=3D count;
 	}
-	mas->alloc->total =3D success;
+	mas->alloc->total =3D allocated;
 	return;
=20
 nomem_bulk:
@@ -1275,7 +1274,7 @@ static inline void mas_alloc_nodes(struct ma_state *m=
as, gfp_t gfp)
 nomem_one:
 	mas_set_alloc_req(mas, requested);
 	if (mas->alloc && !(((unsigned long)mas->alloc & 0x1)))
-		mas->alloc->total =3D success;
+		mas->alloc->total =3D allocated;
 	mas_set_err(mas, -ENOMEM);
 	return;
=20
@@ -5745,6 +5744,7 @@ int mas_preallocate(struct ma_state *mas, void *entry=
, gfp_t gfp)
 void mas_destroy(struct ma_state *mas)
 {
 	struct maple_alloc *node;
+	unsigned long total;
=20
 	/*
 	 * When using mas_for_each() to insert an expected number of elements,
@@ -5767,14 +5767,20 @@ void mas_destroy(struct ma_state *mas)
 	}
 	mas->mas_flags &=3D ~(MA_STATE_BULK|MA_STATE_PREALLOC);
=20
-	while (mas->alloc && !((unsigned long)mas->alloc & 0x1)) {
+	total =3D mas_allocated(mas);
+	while (total) {
 		node =3D mas->alloc;
 		mas->alloc =3D node->slot[0];
-		if (node->node_count > 0)
-			mt_free_bulk(node->node_count,
-				     (void __rcu **)&node->slot[1]);
+		if (node->node_count > 1) {
+			size_t count =3D node->node_count - 1;
+
+			mt_free_bulk(count, (void __rcu **)&node->slot[1]);
+			total -=3D count;
+		}
 		kmem_cache_free(maple_node_cache, node);
+		total--;
 	}
+
 	mas->alloc =3D NULL;
 }
 EXPORT_SYMBOL_GPL(mas_destroy);
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/ma=
ple.c
index 81fa7ec2e66a..1f36bc1c5d36 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -173,11 +173,11 @@ static noinline void check_new_node(struct maple_tree=
 *mt)
=20
 		if (!MAPLE_32BIT) {
 			if (i >=3D 35)
-				e =3D i - 35;
+				e =3D i - 34;
 			else if (i >=3D 5)
-				e =3D i - 5;
+				e =3D i - 4;
 			else if (i >=3D 2)
-				e =3D i - 2;
+				e =3D i - 1;
 		} else {
 			if (i >=3D 4)
 				e =3D i - 4;
@@ -305,17 +305,17 @@ static noinline void check_new_node(struct maple_tree=
 *mt)
 	MT_BUG_ON(mt, mas.node !=3D MA_ERROR(-ENOMEM));
 	MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
 	MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 1);
-	MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS - 1);
+	MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS);
=20
 	mn =3D mas_pop_node(&mas); /* get the next node. */
 	MT_BUG_ON(mt, mn =3D=3D NULL);
 	MT_BUG_ON(mt, not_empty(mn));
 	MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS);
-	MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS - 2);
+	MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS - 1);
=20
 	mas_push_node(&mas, mn);
 	MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 1);
-	MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS - 1);
+	MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS);
=20
 	/* Check the limit of pop/push/pop */
 	mas_node_count(&mas, MAPLE_ALLOC_SLOTS + 2); /* Request */
@@ -323,14 +323,14 @@ static noinline void check_new_node(struct maple_tree=
 *mt)
 	MT_BUG_ON(mt, mas.node !=3D MA_ERROR(-ENOMEM));
 	MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
 	MT_BUG_ON(mt, mas_alloc_req(&mas));
-	MT_BUG_ON(mt, mas.alloc->node_count);
+	MT_BUG_ON(mt, mas.alloc->node_count !=3D 1);
 	MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 2);
 	mn =3D mas_pop_node(&mas);
 	MT_BUG_ON(mt, not_empty(mn));
 	MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 1);
-	MT_BUG_ON(mt, mas.alloc->node_count  !=3D MAPLE_ALLOC_SLOTS - 1);
+	MT_BUG_ON(mt, mas.alloc->node_count  !=3D MAPLE_ALLOC_SLOTS);
 	mas_push_node(&mas, mn);
-	MT_BUG_ON(mt, mas.alloc->node_count);
+	MT_BUG_ON(mt, mas.alloc->node_count !=3D 1);
 	MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 2);
 	mn =3D mas_pop_node(&mas);
 	MT_BUG_ON(mt, not_empty(mn));
--=20
2.35.1
