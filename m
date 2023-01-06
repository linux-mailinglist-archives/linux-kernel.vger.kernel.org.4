Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F941660708
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjAFTVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjAFTVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:21:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B194567D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:21:12 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306H24h3007345;
        Fri, 6 Jan 2023 19:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6GZAgOo5Kzon1mfETNNBtnTmoix/U+Hz0EmFeH5ggyY=;
 b=OQoctTDKbfpuIXmvfScnGF/wkG7L+56nBZZ6/Hj4ILpqnhp57MRr7FRWSxB4hDqgFoP6
 XD77pV07Rnbe0079YVS6KvKBaxt+oKsp6U9yRVdbmktx++qzHlmdVPdTjD1QBNbm6GCu
 YpW/Nt8JLxcp+lRgX4wxy4gu5eN1KGfQtgLiOVusmpHBFehm+csRCnPdfQmlubKeQQWs
 X91M6VYrhpJFjVKMs8OQZ8ZH9jb9LgdnBeU+z3ISHMTF8kDPcxX2WO2M/uke1d/zrhkn
 312uV3MIfNn+SuUWncCR3hYBpu6sIXPs/iQ4IHqF7ecWtDIWsJoGNCZINTIdRf7CSZUe qQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbgqutkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 19:20:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 306IdODD023369;
        Fri, 6 Jan 2023 19:20:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkgjcr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 19:20:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORiEGpvQ9tW2OiYkg8yBw3k3SNfsV2vQaOKC9aJ4RxclLh1sIk62lIg/XKNsT4HKokV4Ov1lTuGyTHx1ROpMMZc30vrfUrUFM97bqeK2Z+0PK+KszecPDthtEH3DT6RLewuQyjAfgYx5DQL16GSy3JEwT4lldp82t7YDY/8tuNh0DPaH0TFk4FkWh4XTEefC+y3LWIIAo8nHBUZ2Rxfsmcemsm6oJdJB462Ekf67zUF/XP9HPkey05Ey/gNIgOYQKg1MXaV+tvxXvYFgaXl3PY7daMdNAhUiuygCVdf7FpnaGdXtf6Uu1XKgSUTxkZ0y4ipyEQflQXv24WG/0O49sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GZAgOo5Kzon1mfETNNBtnTmoix/U+Hz0EmFeH5ggyY=;
 b=jK6fWpSL85SoJHJqduxKtFTPKYgm+a+yQB6iZJ5JPhZQKqgXxL5V0Ka8h80jtI+aW51eJSFmpzln4W+lykjMldxWGAd7TG+0kVwlWabaqIgPZM33Eb8E4ALvlHQaKCjGW/fAlwLk+XKqZWAAUykELc1ks+reQ+0TSvlEtWCLL9L+TdY53rwjt8eoG90KldvA2ZusU2ilpQF7GsMJ3ic9X2gfmOeNOYRSGWmEmL6ZN6kIVaFwx7DB1k7fc7tW9oxqp6llM5GKbxCdETd44iFNotCVVUpBKyN7KCfl8h4IMPPUBu+rHD4pMWiEI3F8J57LSPJXfSS9ro1TtjXkNJV2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GZAgOo5Kzon1mfETNNBtnTmoix/U+Hz0EmFeH5ggyY=;
 b=Anr4ZWOvROZnmFEWylSq4eZNnHYKqUBHvIwl49WrpbFLDIzRzyc2osieUYk56NhQmK0vwyfBVff4zD8ZzpwwiRr9pcvjYtZ6hpQZ6W8W+5yXUu4AlUB5Njn1xWFR3mTS1EKX2hL+FiB08PS1lYgdHdpQ7XCxajrRiP0L43NyQ4w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5294.namprd10.prod.outlook.com (2603:10b6:5:3b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 19:20:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 19:20:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     SeongJae Park <sj@kernel.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 25/44] mm: Switch vma_merge(), split_vma(), and
 __split_vma to vma iterator
Thread-Topic: [PATCH v2 25/44] mm: Switch vma_merge(), split_vma(), and
 __split_vma to vma iterator
Thread-Index: AQHZITolqDVQ6iqu60KRVDrk/+ixaq6RpM6AgAAgt4A=
Date:   Fri, 6 Jan 2023 19:20:54 +0000
Message-ID: <20230106192051.2dwszdsitguzxlxh@revolver>
References: <20230105191517.3099082-26-Liam.Howlett@oracle.com>
 <20230106172345.149991-1-sj@kernel.org>
In-Reply-To: <20230106172345.149991-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS7PR10MB5294:EE_
x-ms-office365-filtering-correlation-id: 7cc0239e-7090-4e49-08d1-08daf01b218e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPeHUHDlRmzbzyAW7kh7KVbn6UffCrrvEcQ4jtQDn6muLiyloVY2rQvEX0l7QVzjfy4OgkLPwegFM/yIAif7sDV3j+IALppVvL4m70d8roZo77KUV9akAz/Ukkfda58lSkG6N3CwPnGE2nOypZ1iqh2A4EzqTRUPs1fwQ0Y5QGFXvPBkXZNdbQO3Oa8bp5JAlCj1q3LiCAkt0B32BoOb+i0ufVIhDvO67u4XLYsOVfWKeVDPTI728ExIkB6RfucASq2Y72AqO5+rS67OVPvAdmKyivTShkYU5LdMXD3Oc+t/Kkwhj8xg9+d0aDcuQ1dCXHPndeiwQpg97WZtkEWr1N0Nn16RDLPg7lJzf4QF34HNvJLAJ64v6zzB3QE9P4lame1fazVywT+XYv1iNDCq6/wqlNE83MorTaYh+e7etZci6snxTwelUPcvVGXcPZ5BJOSkxHwbB0muY7fmLlp6lAJXVmoR9ycGrWdlhpvrDIPPGTozQqfRFuWqe1zz4J7+1QhSLP+45MofvaYgTOjJASvDxM8FDZDxSYaGN7Xi7uGUyOKaaKPMOy1vzH4nSQ44RoT2qGgJXjBn3MBFBPmIcHhDZ/id6FWETEnC4UAlMSPobf7AZyMQB5WV5kHlhW7fHXyir7byRYmtlVAUxu7vBnbjzK6Vr4oA/vEoHKP4LXtE5SC/z2PQUZW67X3FiIF06E/fg7juJew8XTbBmzM594kLGjo5yd+neKDW7y3f1JI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(26005)(9686003)(6512007)(478600001)(71200400001)(2906002)(6506007)(6486002)(186003)(966005)(66446008)(44832011)(66556008)(33716001)(91956017)(76116006)(66946007)(66476007)(64756008)(41300700001)(8676002)(1076003)(316002)(5660300002)(83380400001)(38100700002)(8936002)(6916009)(122000001)(54906003)(4326008)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?be7u3/7C7EvbCBuX56tPPa7fXtD590bn4rpmvcgi5FCcDxG3ne9H2YsUiqNA?=
 =?us-ascii?Q?iEkmQcUsTbklYnr4uvX9xKjAHROfWYnpUGp6QyR4ugG2Fp9TOwqlstz4PTEM?=
 =?us-ascii?Q?WjnQpt/ngs5UwfDF7d0NeQHEGGy6m9BPYhHDU3xPkQV70vYpUX5DggqR9Xqf?=
 =?us-ascii?Q?qJ6AziEeEICAhtpylFoZsjtD/7AujDnLtVBScdC0IRTSeIU+ZbCyBxtVT4Eh?=
 =?us-ascii?Q?W+Yi4PuYyxOif1de3CUOV+e7C2qzixIcYiAsUdokWQsEqpoOL+J3YQN5Axn9?=
 =?us-ascii?Q?7/8yAAash7jeELR6Vq7LHXuHPXogOZShcT/faONnoo7l11oTrOb3EJfCdD4M?=
 =?us-ascii?Q?EaSl3Q8+fpPMygyjvT9fkRi26qGlrTwJ2UOUJXUM6CrSs6aOltbI2Gwi9g1I?=
 =?us-ascii?Q?gHdFpTRWJPtwtZgINF0e5XTeinUXqY6HVVjbcrMNCs4sYNDWKe4pvZBWLc+V?=
 =?us-ascii?Q?dk2yYko093pAEj7dqmaquafgz6+1zgKP050SMxMNBhAHFYey89Qgo3N65fHN?=
 =?us-ascii?Q?MuADxot9bTYXKwZDLLLREYuEa7PFMoqBRv2amW0sWQNyPHV0hwYDhQGtIQ/s?=
 =?us-ascii?Q?1WxK5AC1/74OS5RR8J1UtZ9G30el1zx/ovQH8J38fONJOFYnXPXjORabMNPB?=
 =?us-ascii?Q?SSQVwNzlnzzrZ8wKYklfJrhHXcgg7UMKyVpuL2i6um80QQ1ZMMMAY/83lAJU?=
 =?us-ascii?Q?nmXnb6By3Yi56p9nrb81TT+Cz6XwUVS73ttHFGETyZqUUauXo5Vm1JDLU2Dn?=
 =?us-ascii?Q?+6wSFL15cc5C198svLX/j47dw0PM2FOoarj4In/WGfXgO8nkpNqQ4izX6OVg?=
 =?us-ascii?Q?Ns56cf9kw+SZIKrzWkPH01r2M/2E+QaDsPm7dJ+T42vGoEuC6JCfrWMJ0mjf?=
 =?us-ascii?Q?aOqWuDDTgWlOJMmnYrR48HLDbUA8Wlum2EzBJjm5KwUbhH3rawhEJGKP4hcV?=
 =?us-ascii?Q?vLT4VR0Xzeokrwawz6F4a4yfr9Agl0BGzZg1wE4LKzpFYww+dwTSuSvqPmC/?=
 =?us-ascii?Q?sqj0hM7s2gWrlCeGulrGL+TNlOYH5b6WWV5/xJbeRHABsHpwdpO0mOFTbqBu?=
 =?us-ascii?Q?igL+vT/xVQFt2cPnvwrzh2exUI55YZbgZm0P4oVOmr5hGrncXGihDCVNZnU0?=
 =?us-ascii?Q?UeDflv5v5D7ton9IhQlR3ALtZeKpisQBAiu4sPLA6xjQntns2ry4KskxWq0T?=
 =?us-ascii?Q?y+EBiLzgpIPR2k570PlftlZ4Id8gznDKGNckLaY71EECGx7Bb2Teur2O1EGB?=
 =?us-ascii?Q?gcAW92i5Icak+4YtTvPFvd+NUwP2T9Expuk9uRxKvT/gPygU8Bd+CHG5Dv4j?=
 =?us-ascii?Q?Y951DXazDDRBeE2k1+ZW35z9eCz2P5+h9uRt7ndQ1O6JBFLInXyM9IwRcKcr?=
 =?us-ascii?Q?DXFNI5mf65UxybPEukm2LpiKwrus08bLA6r14M/ASt8/AJlu0l6eBfIfT2cJ?=
 =?us-ascii?Q?x4f2hW3CTZuDIfDzybiSiLrO1LZul5v6FHIgMBavGmZZHNBhdSHdqmkUmvMI?=
 =?us-ascii?Q?kRVu1e8MXxhZuElo408tuetXM/l6ueWU3Qopz1bUOG+7VCOhfkssvLNM3gEq?=
 =?us-ascii?Q?dbpMKx78iZC+YH+wxLpBDT3ID6USw2p6M75HxGwpl21nq9kj1wwP+YuidlLK?=
 =?us-ascii?Q?VQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9962353C4793F14087FCAB477A58A58D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kHnSelPQJ0VcmWmsf+fnFxmq08Y1mpnbQ8zJ+/F4iIV+a3SCBeqywjm5Mv467H7xpfza2FHrsn3afFoHGq3+Yy0C8yoDUoh9h4wXG8PfEVCIjX31Gh1HtZenj9EzhwexwYQUOrCeVY103q9vRYGluUMw8/+ubPoho1UrOOursXW8OGVFcBvfR1Ut63sILJwvcA4rSocCDPU3OaHmSSJxET+xf0pwvav+Cffa6dpOGwwYcTsaOBrcO3xW3YE+e54lrP9Act38NkUfcQQQxQvhCX9+uMlTsP/xzLXicea1ODxWwdwAI2WipNliVOe6avOR+6X+ksuEuvIbXwmJJf1sclTiSqJYAcjLwVjPRi/D9hk1uGNRX64sT3u/Akld2OWvCmWwxYKhMP3XZYP+Rs3Gf5L0CEt7hIeS3A7J0IUmoIIghUJahuXHLtCxiyu4qJc8RnGwQ7dB4Mmy/ME5Gg+MYu81yWzafNG5iZoTc/LQ68tLADAhZZdIX2Q7xPHk8YlWh1s4UVvN1PQ/Qy2OdNqevhRyikWAOgdWz18Aev2BdfSCWvGQ+eWgiDrZ/XtDAoVdbaDvkwdtp30iU2NrHbRxslsiFqYX9m7Zt9MOo/l7LydIZ0a0pRUB96HbuerDhybeS86t1+0AmKe6MG134OAzvfmRBpU4oEgOaTiG2gEnjJkENL/DN7xYtzq205xh7/x89rQe0TLM3g4SezOXwLHNtWX77J0MAfsvhfhtDr4X4jJUIpaGJTuicMaDNWyGPVtuArWrEB12ppyNULsYjMKlUfRG984czIkHoQckr1hRLFTdk08sGGSvUqJJ7Y2M8EoZRmHQCZdyRvBe0NHJm8SgZt/XvzMtZikz17Pr5+xnsTaehmGeNyQVN/BJwjpi3YqGBmcH2SewqkzKsHQ0CnYkS6l37TJp68rCNmVS+VxsN/M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc0239e-7090-4e49-08d1-08daf01b218e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 19:20:54.3929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+99Wfz/CggCfhjtm5zjy27CWM+XVMRWtG1LYZpJJLfe6i078Kgi1ACnTmM1MBV49IRABN+SUuE3gYaBfGKdUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_13,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301060149
X-Proofpoint-GUID: _w2uzOgkAOJPnubFEaxsq7fLDyBMU2ro
X-Proofpoint-ORIG-GUID: _w2uzOgkAOJPnubFEaxsq7fLDyBMU2ro
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* SeongJae Park <sj@kernel.org> [230106 12:23]:
> Hello Liam,
>=20
> On Thu, 5 Jan 2023 19:15:59 +0000 Liam Howlett <liam.howlett@oracle.com> =
wrote:
>=20
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Drop the vmi_* functions and transition all users to use the vma
> > iterator directly.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  fs/userfaultfd.c   | 14 ++++----
> >  include/linux/mm.h | 16 +++-------
> >  mm/madvise.c       |  6 ++--
> >  mm/mempolicy.c     |  6 ++--
> >  mm/mlock.c         |  6 ++--
> >  mm/mmap.c          | 79 +++++++++++++---------------------------------
> >  mm/mprotect.c      |  6 ++--
> >  mm/mremap.c        |  2 +-
> >  8 files changed, 47 insertions(+), 88 deletions(-)
> [...]
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2830,22 +2830,16 @@ static inline int vma_adjust(struct vm_area_str=
uct *vma, unsigned long start,
> [...]
> > -extern int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *=
,
> > -	struct vm_area_struct *, unsigned long addr, int new_below);
> > -extern int split_vma(struct mm_struct *, struct vm_area_struct *,
> > -	unsigned long addr, int new_below);
> > -extern int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *,
> > -		struct vm_area_struct *, unsigned long addr, int new_below);
> > +extern int __split_vma(struct vma_iterator *vmi, struct vm_area_struct=
 *,
> > +		       unsigned long addr, int new_below);
> > +extern int split_vma(struct vma_iterator *vmi, struct vm_area_struct *=
,
> > +			 unsigned long addr, int new_below);
>=20
> I just found this change for split_vma() is applied to !CONFIG_MMU, which=
 the
> definition of split_vma() is not changed, so cause a build error.  I post=
ed a
> simple fix for that:
> https://lore.kernel.org/linux-mm/20230106171857.149918-1-sj@kernel.org/
>=20

Thanks.  I think I need revisit the nommu side of things with this
change as well.  I was hoping to avoid that, but it seems to be more
necessary than I had thought.
