Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0E165F4D5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjAETw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbjAETwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:52:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870A414D29
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:52:42 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUIN1030165;
        Thu, 5 Jan 2023 19:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8IXoGrB/4nHPCLWJpRRF344NI7mcVHsDCsvcdLndT5s=;
 b=jLqdye538DY4VEPOyE4C9qC+cB36YOzuWMQD7xXIhLS+mgOsrk2ddzwpy7Z7/onJbZeu
 Il0LGU7sCIUiA8F4nPmu/i559/R1GzaKKs+H4cC4AA/iPWb9YTZujtvgHwFxyVTQdONQ
 nykCf+85mxPcqqmJyQdaGbcS4bNjN1qGhiWM08lwK9TtpRv/MHZTDg7GeGZq9e2js1En
 yrEhdxYJtbwj0huYtDZJwxnSY1UYra735MMAdJGrh2VTfrfvzQT+LAh960mYvh9niR8C
 Kt6O3OW5rycRByZUYKpmHeYdO7xiSqt2Iws3ajw3Jnqtdon+E/4daaewqEL6/E7Qu5UA dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya9ntv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:52:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305IAYX4040289;
        Thu, 5 Jan 2023 19:52:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwevjy9va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:52:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKyOPNIe2lJu7LMn5VXjSTAfWakxYX+GkH9TyDFa12r6XwEUx38GbC285Jy2sSUo1i2FHFDkjvJjgHX3451hmYqeESIMCBaPnZv+0OlWtQ0Icbxk+KTN1WISDaQRce76U4QAZ0vGn2jv+Ahdka9aC3zyPAzAJP0BsVs6qgYXX9pb9GNF8kJTD2jNwL+KRewLs2QXgdgemZVDVQoDblOy0t1wLOjU5YEOq46FWlb5EQewvWtda396doA8XUxm0q3HBCSHRqawD4akNlAcjajPLNovw0KaEDba6Bv7Ct7aA6n9cSofB2ztAjnvsmYrZ8/VHwtxBf92AHjJjWWBsdLANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IXoGrB/4nHPCLWJpRRF344NI7mcVHsDCsvcdLndT5s=;
 b=h/LqEWfqhWf4GG6NSIxLOItL9oVkaQbrCOY2ExkeOCDC09Mf45NqG+C0Z5LLPX93GySYeTFCBHUS/lZBrpWlAvu6lTP66JyhoGa9Lf7/bd4p+2Rdev/fKpAoNKuvRGliQCs77kA4P1ZD8K9e0Fx6XxddBsaez/2SiZMEYTLsGw6EfeceWJyGVnc5BOVa6APLjisBxZa9wM1VYTiB4Hi6fJGr9Bbkyl7Sx0Gs/nSVQu6TIP9BRBmyZhnO8B1AsruGVzYMvNLkVfKpzApZMJATaHk7+eytWJccafeC9gtzyM/VRn2wNCC5QooR8FSs9N7FENFA+7nWSzCaVfjDtkz6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IXoGrB/4nHPCLWJpRRF344NI7mcVHsDCsvcdLndT5s=;
 b=PmZB53YIDbTMvS7KqLRb6oHqZYNaTqploLotIhqH88/B7uJ9wnLETKUIg2NR9VIWvDQdvvr6NGYKsqdhcacZNfZ17duRXgLKq4DbS05ZIOrb5p1voLlDSsI/zh9HPQFK1Np5tZmGQBxm9E6ObwJftEk6t16tFnlVk8Z04YNDsw4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4643.namprd10.prod.outlook.com (2603:10b6:303:9c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:52:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:52:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     SeongJae Park <sj@kernel.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 26/44] mm/damon: Stop using vma_mas_store() for maple
 tree store
Thread-Topic: [PATCH v2 26/44] mm/damon: Stop using vma_mas_store() for maple
 tree store
Thread-Index: AQHZITolwyWRLkqcX0iP8U6GnafTZK6QNouAgAAFaYA=
Date:   Thu, 5 Jan 2023 19:52:21 +0000
Message-ID: <20230105195213.acthhrocx5vz33uy@revolver>
References: <20230105191517.3099082-27-Liam.Howlett@oracle.com>
 <20230105193251.112393-1-sj@kernel.org>
In-Reply-To: <20230105193251.112393-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO1PR10MB4643:EE_
x-ms-office365-filtering-correlation-id: 1cc3d0bb-ae6f-45e4-f37b-08daef565c46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: appv5lQWeIQ/j4a+mxLUYCilF6GaRyBYoNXZYzm3PqHMt983Q4EL+30yMYsLl3qlzlKxT2WOfNz1ijTwyz85FCiKZZwPnlttUo+xwPVo91wRX4YeOxXT01KnLsFGM/BBizuOjEp8u1F/JCQ9mtfcBmAPLaD9TRxdKbbc7ovLSi14KmechUN6sjUOF4uujxSqIz6tJVXuk8FJM/f5mzsMQO/iwHGwsiTQ6LzlSvLnUTAoO0FQFqFIgJisALCiYTU2eufPWWYBxKuninTYKywl9WM29GiAqD/S8LHbShrBL759KqDI3ABKfJPziWBqIZ/b3xqcg01haTzNZdeXajiptnCjG1uEk5EN7GUP1g7zP+4HxQ+yyfdf7ATzCS+9dGRrqlTjcuBqsbF0oUiD1u7ht6j87qwtCGho60DvuqM4qjTtz9m7cOeazShp126u0a5zV9i6tHT6zV7orzaX7EX2kyWA52WVwPfGbOy5Y3B5yM7PDf2ZV7pvHEmzmGhmy0qX5ms8Nc02+fO2pnHmreO1MRDJcUS6xerlOP8H5RjhwZxxu6Oifk9n/b/Rf8Ye84yKNSGdiWEf1I4HMEvRQRltMTneXFZxCU1TR/VYDWBd1obZZeeDcmHPazMek4wSruVmx9C10sQ70wTHXUlWgSPn7T7nUdw30bWWcbRE0BK5kXVl84ZP6f8ly5RSvh6sqTg+9GBHHN1TqAVzDr2xRSB7NAD5eQIZ7DYiqpijKWMBbFo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(38100700002)(6486002)(2906002)(966005)(71200400001)(91956017)(54906003)(316002)(41300700001)(76116006)(66946007)(66556008)(5660300002)(26005)(66476007)(4326008)(8676002)(66446008)(83380400001)(9686003)(186003)(6512007)(6506007)(44832011)(8936002)(64756008)(478600001)(6916009)(122000001)(86362001)(38070700005)(1076003)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b4BE8qQg8+Rddk8T6Z8/tS/f4kBY6d0y8HqDEMnEW5ZnbevaX428AA4ayT/6?=
 =?us-ascii?Q?jOFHm6Xw/XbLbUzZSOX7uaZynlhf8C6daKb9zZN2JIDVWS+WicCyx56VkSe2?=
 =?us-ascii?Q?0Oz4iw1VyEbw9Mbe7B7rdQVMUFLppvWqV1K9t/pfjFltAst4+r0o51pQ18Gj?=
 =?us-ascii?Q?vI+fDY6j9JnBu2iewr+M9TG+5FeC690eOcQVJ0RbSCBrh7HLavhqxNdxORFq?=
 =?us-ascii?Q?5HBogZ8quWsmfqh/A39hCIMEKWPfeMcjRFhNjVcSYJrTEFC5SOEznjtpd72D?=
 =?us-ascii?Q?06PVN+10Wmhew6lAnZG14xDtBWfkcUmLDGz0OD7t71yUHWpHE2dt5+R6K74F?=
 =?us-ascii?Q?UVkfsRJNAL8iA8BfPm/wsCFphhcDZWj4gsHTiVqXdo3kfIA0NXxHAqPImWig?=
 =?us-ascii?Q?bzLF/+F6BlpOyU0h1F9ojXoDvx0x+AS4DysncwZXwCAW3PxhOXO6wRxdds1B?=
 =?us-ascii?Q?R2MlcL0MduiLVK3Bw1cNPLvQvZxxoemDHvoQeJ4gP/77fdzirCpGGP5L+dQ1?=
 =?us-ascii?Q?xJYfmuHX7mmgeLf4GBMoQOXZHS3C7nDRyJd3gP3JANETeijy4pyEvFxV9664?=
 =?us-ascii?Q?9Ia3d9l1WdUcZqCr1gCTHZeF8RQECYXvaH99rGhPpKorQ1IIKhVR37KVhiM+?=
 =?us-ascii?Q?c8IQfaqa7usOrEgLWEwxK0Jh7cMaEWZ8Mn8uV5yYgmzUd0tBL9rIq/pEVhgf?=
 =?us-ascii?Q?S2M1fgFFX6gj6wU1cjacQLyX6ICHhebDz88ujYv3B9RXawMu1b8JbjvhBQAp?=
 =?us-ascii?Q?3iVXgSjaPhXd8s+WJGh4INzcA8yfaEkY2oWVKxFyQwmu4joGjNyx5QttRSai?=
 =?us-ascii?Q?/pNbOPnpi9kQLaC0nyVkDw/AkK41V2m+Iqy2XswXSaNPwVgpB2O2q3oGOuUG?=
 =?us-ascii?Q?KePEuftaY1MFYzeAZlQl+8KNvBDZ7RcfbgQOJPK/+BRuqKd7PDrHPkaJEV6R?=
 =?us-ascii?Q?v3mLDMPDzGsiDmKPm82YiaOukjVljdCBD0YGmVZxCatdAeUO2Gv8nqai3zk5?=
 =?us-ascii?Q?gMfJnPGE4xplJsGb1DVyh1N7FT4N/VndTKvjBnqGfxRVl6XQ2T/DkUGSnRM6?=
 =?us-ascii?Q?PsdlA7RAaWcsSELkR9+yaCrkUQfq33l9zUyFo00tSd0aar/XbgdQM6L0wWYW?=
 =?us-ascii?Q?XYGrSfNDGU6o/b+dtU2tOAl5JjbBL9MFwps7SxndIR9LcC4ske4A7efhMhRt?=
 =?us-ascii?Q?LZs8Fu0t0LZNz2tw0xOYoxQGXx497cC0cJFvKkXF3EPuKbcFQ5NbVcqfKTsf?=
 =?us-ascii?Q?tHvfwLn4Rcu1/k1BBUmSkG/HFo3gf/aRRsLq+9/GuxtbohIIM6M89ct6dRPO?=
 =?us-ascii?Q?N4Cimt1jlL2r6c6xQzekMTqraN+hiP1J5LSWf/uqZmnsOaV9O357qeCZy6zK?=
 =?us-ascii?Q?lqfIAsD5m/ffV+PxWLi6Y7/8dzKS7TdfLiQVUZ3nn5njYVQ+FX+nx445zJuc?=
 =?us-ascii?Q?sQHdtMq8DMN6sdcPq4YIotLeduQI9HvCAbLD6WeKosJB5DwTkEUAgcY+B9Rs?=
 =?us-ascii?Q?OU2a7qZeXvE20xlTbhMkYyXQSkpuee7p6pvYi+DlCMvYwfP3anTttFR/d9s/?=
 =?us-ascii?Q?wjBDEkZqiLrZqrNxy5dwKgy7UDpSFrShMGZCmr6yaRujAR1dyDC8HoezxnSH?=
 =?us-ascii?Q?Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE24A05674B0E247B2E6E6D8AE3F235C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tgmephzW3CRtG/kktPizyvE6HSsWCOEvP47Zwji2MMLuCTifGcj7Pu3rigEp?=
 =?us-ascii?Q?KbYmd0lj8yeak3G1duuVpEWGD/uw5Tgt6XZopZ5F6wHT5G3HKpIATgw6d5Da?=
 =?us-ascii?Q?qsASEWJNhFEyfdSMUuc27cTSkTAh51x4aytdeejsHCVFzhG6MFnhU0UCYWYU?=
 =?us-ascii?Q?6eLlogT1JAXqv5CTr6oFqWK4VXVUlcmAIesXfSAtLC/GNlHI1uiP58H9v4c1?=
 =?us-ascii?Q?vf6SI4H+1D1VSBZwn96OQSy0is1W6B3haNxZ8LqNFaUwj7s6+JRP+xSSp9SS?=
 =?us-ascii?Q?Yzf4gZsFhFJDZYsoI+LCtzNB7aTGB2v+JwY5dFyMoH9zcNlxQ82jSY2dhQES?=
 =?us-ascii?Q?ZUuM+FRdzzQN8yDAtZS2y8YRXTvzzmZ5c76ptGuc/Khf48XgaVQnkRsh1t0U?=
 =?us-ascii?Q?pIhbI7WH5Q7hMSddDOMkFcTobTUKEm24nLOEVGPJ1bMGoIF6j3UsjK9nV7rr?=
 =?us-ascii?Q?tvUTIUi+bJSsZJqSp+EsY4zPyjEHTz7RhUeaiOuuMWEpZ7dJK2LrXZ/LMn+5?=
 =?us-ascii?Q?4++77itrk7Lrx1fuAsmWod0TLANlkA7TM5te4nU2afBrKpcHpG+ORcobnPh7?=
 =?us-ascii?Q?QLdPZPK0FrR0mnofbUTXgX88zn/EzBs0j8RlTkr2rovBs+6Py/Sbpz8219km?=
 =?us-ascii?Q?bUUBNfHY1OkSX223sEgjpdn0A3kt748ma6LUO8GWA6qTi2bz9Q4JIcAFgrc/?=
 =?us-ascii?Q?RrPnBr0/X084p+DvVTBLxHpaIEtaA3n3CizKchvlDfvG6Ak/6vOzA691ybJ6?=
 =?us-ascii?Q?mLZvnnWWYQnrckdetjtvfwFQnajUUSsredIeT28IgYid/7NToyDcd/EdcZwF?=
 =?us-ascii?Q?pzXPI3UPwkU2F7divDPseK3BuiBHP7ClNEk1nVWwP6BC6qAUAiJWGI3+DKQZ?=
 =?us-ascii?Q?wYSPrtNoLGDqaqrbCRX8W95hRKUYnFNTCtsE/j/ydNGD9cgpy7U3gVI9ppHH?=
 =?us-ascii?Q?Jy9ABUN9VWLAlv89wqQzyey+b0Tz/vWfcqPjH4H9h5I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc3d0bb-ae6f-45e4-f37b-08daef565c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:52:22.0257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmjOn8KmOe9HbfXO2+1/m7hhOJbq/4hRebIddepQ2S91vbKzJE2jqC9CapUw2Ftl2+7pmRttk2oohI86DRRJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050156
X-Proofpoint-ORIG-GUID: qrJKr-L1FLMxWjODvONJLTkE5c5O_QcQ
X-Proofpoint-GUID: qrJKr-L1FLMxWjODvONJLTkE5c5O_QcQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* SeongJae Park <sj@kernel.org> [230105 14:33]:
> Hi Liam,
>=20
> On Thu, 5 Jan 2023 19:16:00 +0000 Liam Howlett <liam.howlett@oracle.com> =
wrote:
>=20
> > From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> >=20
> > Prepare for the removal of the vma_mas_store() function by open coding
> > the maple tree store in this test code.
>=20
> But seems this series is not really removing 'vma_mas_store()'.  Wouldn't=
 it
> better to do the preparation and removal together in a same patch series?

It does from the all code but the nommu side.  The definition is dropped
from the header and c file in "mmap: Convert __vma_adjust() to use vma
iterator" [1].

>=20
> > Set the range of the maple
> > state and call the store function directly.
> >=20
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: damon@lists.linux.dev
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/damon/vaddr-test.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> > index bce37c487540..41532f7355d0 100644
> > --- a/mm/damon/vaddr-test.h
> > +++ b/mm/damon/vaddr-test.h
> > @@ -24,8 +24,10 @@ static void __link_vmas(struct maple_tree *mt, struc=
t vm_area_struct *vmas,
> >  		return;
> > =20
> >  	mas_lock(&mas);
> > -	for (i =3D 0; i < nr_vmas; i++)
> > -		vma_mas_store(&vmas[i], &mas);
> > +	for (i =3D 0; i < nr_vmas; i++) {
> > +		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
> > +		mas_store_gfp(&mas, &vmas[i], GFP_KERNEL);
> > +	}
>=20
> On the latest mm-unstable, vma_mas_store() uses mas_store_prealloc() inst=
ead of
> mas_store_gfp().  Seems the difference would make no problem to this test=
 code
> in most cases, but could I ask the reason for this change?

mas_store_prealloc() expects the maple state to have the necessary
memory to store the value.  Using this function is the right way of
storing the range.  In fact, we would only need a single node since
these values will be append operations anyways.

>=20
> Also, should we check the return value of mas_store_gfp()?

I can add this.  The only reason we would return an error is on ENOMEM
which seems unlikely here.  Again, it is a single node that will be
used.  The size is 256B, but it's safer to add the check.

[1] https://lore.kernel.org/linux-mm/20230105191517.3099082-28-Liam.Howlett=
@oracle.com/


Thanks,
Liam=
