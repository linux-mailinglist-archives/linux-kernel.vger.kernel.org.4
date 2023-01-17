Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB59670DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjAQXnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjAQXmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:42:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22212F7A1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:48:04 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HLwk6o030964;
        Tue, 17 Jan 2023 22:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=HEDQyOkZqdHOA+PKg2FmcZ3lkCsnCkyi/Mheiwvu3dk=;
 b=ENlaUrEyGDognWX5rfbIoh3TuHUIxo35xEHtoIzvydfgkr7T7bl7ASURH/sgZbz1Z1tq
 rT5is192GeDnpR9RYbRz6R9UuAzhBwoHs8+FN9Xm1yYuKtZdXsdQ8XiRmd6P/aCSCSDv
 A2PRnCM96NVEaZKbi3o9kzSIE/HYTb/uuyE0kiFiNFSmabqgCGL8GXWwp8trZTsWkgEh
 uD2wNeugz6vWioN7ABtzl0eCXotsu4JZpTQvLPSSHpgVmmupgzWToN4z1lUiPyJa0nRB
 doriMaVw/9HPISx9mIRPE80zT1adckiVIzuMKBbUZse7Hk9w9ezw1DAKv+rEQpo2KDzX oA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6c663e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 22:47:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HMSj5U022808;
        Tue, 17 Jan 2023 22:47:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n64gp0ktm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 22:47:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTCbFmakyeb/oXYjZQjZoFmeGZ0a5Sl8MNaYzx5FccxVVANq3RjlhtvFLVsILOOfqwolJSXr9YH6oS+fytxwVRs+FLHQNMYO9RKxJWujaueQSLxAXlYcC+i+uy3pAv57aitOQ5/MVao/2qRT6wBBv2bDBBKoqnE5xmtCV2DYyFILSiIWqjBbABxz+BWVezX0DEme+TA0j1XWPRSFlTS+vYa4IJkpBlCUeyF6rxTvi0ouCv3x4uOZDULJcHNG3qMQHVTGKyE6as4Jl6a0yCzfptPUp+/EXOxTSOUb/2CmiYV5PO16XTzD2+PegMwCihohUSvX4xMl/4jao1RCyiOyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEDQyOkZqdHOA+PKg2FmcZ3lkCsnCkyi/Mheiwvu3dk=;
 b=icaAlUIzKjEQ3ejnV2LGscd62zFfGOqsPraUs9puhBLMaD775mFw7wiBqVeNCQzYajubOtOtahaEbsZV78xZUJElnOItM1cUpgWE5HP2VAcc5evJFho21tqNi0J4bTMjCnROrhlL9fDRY2y5CVmteHQHELaKYVy2LupofHDb80ot/Vr5GxTo7a1GDg9vdRctGBm3r3KUa1Lhd4InKPM11tLJ9Z7miquqN2QH278tNcF5nYePpCiebkO2RtzwueFMC/nPXkvjtMk2/Ps1Z8w05b6BZLTbPRTrXr8xASroXnG0Semc5XUaZH6xdBLYZNtEX3FMYgi7bh+jOrGlySJpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEDQyOkZqdHOA+PKg2FmcZ3lkCsnCkyi/Mheiwvu3dk=;
 b=YWb1dzGs+IgTl36j3z7ui2b4G+v9ZcchiTFSxiy/gGhEy6vsWqfB/cib2F6wt3toJqmB7YszJAXLddFh6Rm8JA2TpZPu4b0R/0L63Fmaw7eTfpkUKBLOYmgylZdgqihBjrOdvBfZvmA8u5OSyTVgOUIePJn6zCB65fKZfrUbvfk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB7268.namprd10.prod.outlook.com (2603:10b6:930:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 22:47:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 22:47:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Daniel Latypov <dlatypov@google.com>
CC:     SeongJae Park <sj@kernel.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 30/48] mm/damon: Stop using vma_mas_store() for maple
 tree store
Thread-Topic: [PATCH v3 30/48] mm/damon: Stop using vma_mas_store() for maple
 tree store
Thread-Index: AQHZKhwz3Un6d8d2IEit8wQQlG94y66i+rGAgAA05wCAAAeQAA==
Date:   Tue, 17 Jan 2023 22:47:36 +0000
Message-ID: <20230117224734.c4lo4spezufwsims@revolver>
References: <20230117023335.1690727-31-Liam.Howlett@oracle.com>
 <20230117191109.116438-1-sj@kernel.org>
 <CAGS_qxru93E+=6nD31=8UGS=7ADnb3VG3hv=hfh-R1zVcqTJ3w@mail.gmail.com>
In-Reply-To: <CAGS_qxru93E+=6nD31=8UGS=7ADnb3VG3hv=hfh-R1zVcqTJ3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CY8PR10MB7268:EE_
x-ms-office365-filtering-correlation-id: 4b78d82d-0928-4062-bdbc-08daf8dcd493
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V4iq8Bem1TEzYQNmH5BLhwvUC0cJ3D4H1GpCm/OFa+N4ghY2thyRiL68rCfaHRpmHXNLcZoK7g5Q9mmLaP1ljdg9HcPWFWCiFc04PalD4i4Dk/eV+LV6kayKQKXcN8ddCOyGtPvArFRq1OUmfI2un5IOaUydZqriSE7Y8ynb81BJJ/jLTngNh6hz74jJQti5imIwnBto9ZgTWBYmPFCjywpOzqfWYKXMxpjUeNkc3T5Rlv5GYil65usao2zcCgtL9WXGszB8dB3c+dRNeyXgIOe8W9fLvD9y2xES+0AiiaU+/3ZuqbPj6zI2n41OnNkDdc404JwgryyJatf1ObptFNUhjzBe40mjZeDzCsrWlIsCRxJm4RjVh4qEymtK/ZwtlZyLDZqHWKMJRrse1Ug8+PGY9XlRlnK7IJ/bw40oEEofs4rpEkJhJt0VJkTtWELX61rGqcost3xr+xuEbnBdsW8HdtvxUjdvBokwDVf1FFbQDkxKs91IHkGXJvcSZiDzsYXywErSrbpMyCw0N0gO3D2gIYbM5LJU+erinkRFW65uuC+Xw+7nMAXZWSQv9mgaD0qEQZkCKdnSxvAjlogit1OF7L6M8ECemAXnJ9CS+yrwttDlL1jR7IblWNgh1CEfBlez1xFkyDw69inUI3ZIG8Vyj1t7l0wJZMGFFfsznDMgTynUc2OOGEAJcCp+iesoHZ14zZsllv/RFebcRdxpWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(83380400001)(5660300002)(8936002)(41300700001)(44832011)(7416002)(6916009)(4326008)(8676002)(91956017)(66446008)(64756008)(66946007)(66556008)(66476007)(76116006)(33716001)(86362001)(122000001)(2906002)(38070700005)(38100700002)(6486002)(71200400001)(6506007)(9686003)(53546011)(186003)(478600001)(6512007)(26005)(316002)(1076003)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZzjlvUHTNeuI8GSzID5kaP6XDb/Ron6ejVaKZ7EhrWPDro/MGpyq0b+ch8ze?=
 =?us-ascii?Q?d42ldG3AsW3bk0fTYtJTnmtwOYvR/ZeVi3R4JubRhE2x6rM2eiGH3Y67mZmL?=
 =?us-ascii?Q?0TQoSahMcngkPbQGG0gdZT9obN/bMApqCC44IAaDvbL0mlZ+U5fjj+kMir4+?=
 =?us-ascii?Q?iQz/3YIgL/ElUUbZVVbFcwJ1DtxaWjFRdbWKsckHB1SalTchsvuopNaPb6wN?=
 =?us-ascii?Q?tJOf4yWESXexX75NGQkRrRbB6Y4c4nMLZjbIgcp7P4vWSHLWv8xvE/eZ0n3Q?=
 =?us-ascii?Q?GvjqTEipI05S3xkQlJ/GVsU/kLj1sPzLhAId6gftVtyQlKU9s2inRSgBmESU?=
 =?us-ascii?Q?iEkIY/duOwq9vl5oqpfyfJVxa244q+rrLfJtO+HGatqApOdImk/gxoZy3ZKk?=
 =?us-ascii?Q?kLEPT20bhwVXaPZsgzkn9vjqngNZ2iozHhkE1JUmE4EAcVtA9JBLwDJbPR+Z?=
 =?us-ascii?Q?Q3jJHTFZidZdfB4f2vjf/BAaFSUuYeZIcF3+EXdWxuHQNaGteZjcamTae/64?=
 =?us-ascii?Q?9wk4AL3pywHKbzLZO8lVSgdyr2RLJhgRmkF7x6mPqacLGyVXHEzsZg+Sd4Gv?=
 =?us-ascii?Q?nfiTtuIUkU/OG7LE7XaXGQANFYG9P+dYj1yBdz7lbrC+Mg08fU1dyfO1NM0R?=
 =?us-ascii?Q?xSCnSMzv5Jk9XEipbNgOfkdnJtf7wytHYQ5ag0II4EWzamN2JCG14n2eoJ3W?=
 =?us-ascii?Q?/VUCaz9No8PWiBak641nGHLdSFUW70jT44puRtz62uDFdjyLZoT/4AWAdoUs?=
 =?us-ascii?Q?GmRWvyIy0dv0B7UjmM9TUf64WSmsL63EHafbzLrn+RypwTwdpZqggyqS3XEY?=
 =?us-ascii?Q?AtPtAfM1DhninY2GGJArtMQ+0rHEfWVyiUo/NAXLFImyB8kBtWczx9x84Y9m?=
 =?us-ascii?Q?PvaFpbqkEBxRhLdxM/A0otXRJkTDtHEwXege40Uro9P44s0+RQBIRu6R9P5m?=
 =?us-ascii?Q?yWPb+nqWzau807g9Gy273UVBFIL8+/lBLgk7zXQb03T5kYE9XQMTC4NUWeiM?=
 =?us-ascii?Q?DwhoSoeckc2NTJskDUU+w0Q+D+1sR1SPO+w1ZRNTAkP/h5lXorv7S4b60z4N?=
 =?us-ascii?Q?mLZnTlibp0YEi4icoHZmQ5gBFeY9JJAgQ7dJ1LrNdu0uReWL9sGKKqO+eemP?=
 =?us-ascii?Q?T/H+Ug4CFMIeAR60WzlFeev5TXsf5GaP9E0p+gZMxTySYNnq3J23JdX+2JuS?=
 =?us-ascii?Q?0Iqocy2zATtMr0KEKNMjF/szHrqXVqblhjWm7APjw5nIvMA4TOkAB3ZXZRgc?=
 =?us-ascii?Q?WzPe8dj+XKTVbDveOiKpLhaYIqT4aqFLInIc4/PErTNAUNEIwA1+cR1e7ZEl?=
 =?us-ascii?Q?Fr2Ylgw6qNslQs3/PTxbl8U8Mu0UGD50ZbaDnhnJ11kZm7Lo4Oq00j/5TLdP?=
 =?us-ascii?Q?Prla2YkJ9Zip+TU7RhaOcrSWnOkFM36TONBzCSALWHyMviF1AfAkQPbrLx+H?=
 =?us-ascii?Q?+M2/sLI01dytbZ5JCytYhmvS19tn1o0AXfX0IxkJXCNHsbBR+HBxzxZ4OkTS?=
 =?us-ascii?Q?t2ENMXJP8VTW7CPHMavpBDflgVg3DZfvb4U10txmgRCRZXR7VgPMsJZL4Nid?=
 =?us-ascii?Q?LB+bp27znygYizIx8HtvNc9Wz+mRx/lDaaBXJD7fi4VWNih7DeDNZexSJ5HZ?=
 =?us-ascii?Q?Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B54EEAB33643BF48A0607275433C3B82@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EN9PNM0L2+mZd6AQAkrbVPuCSVa25PLgBSKcF0RCErYI92C0+KWslDnevryz?=
 =?us-ascii?Q?I9DJoOPaU5O34X0hcw8nJ44yoA5/xJXXQ6s1eBLi68eu0MrV6VzrFVquNAWv?=
 =?us-ascii?Q?t+O7BojhIDQV4vewK6jtQ9IK7vUjGbTALy9UhXwSL/H9XkyNZD5jX+r+xMpD?=
 =?us-ascii?Q?p7rFa4apz8YguBeXZFeiWYdCHUCSaHYdlPOjPKlopdldgUQkRvD7kSV/Pg8o?=
 =?us-ascii?Q?vGupPWLFke0DlYhxFHgwgTsjTPU/ALDyZG4JB7K8sZlUVAfwKXKnnGhJOJIa?=
 =?us-ascii?Q?vGFYM92SnqzDZIr627KawF/b7//Dp3RhdAAEIFjVm2k7qScybwUYmeOlt4II?=
 =?us-ascii?Q?u06MGtA66gHRtjVHpUGOn5iDyLEMW+S33tIMtDs4MlmU6dWR7pPXKAMI7eCx?=
 =?us-ascii?Q?aq5+TlC+nhc/6WLbFh8LeeMRCQ6mrosWpcoKRClj8aHGYC3F7tFM8u347dgx?=
 =?us-ascii?Q?gL93uBycPeYZuKZlXQJ17eN6wbRvwSaR4u2YNhB68fi31hZSr7r3WmFOeGzp?=
 =?us-ascii?Q?H2p3/oBUcY81JISyw6Yvftd1ovMitLiP7QJ3DG/ONF7imTMi+zOkYZQMWxSJ?=
 =?us-ascii?Q?Vw92bVwY/Oj2Tk2gCX5zA6EFYfMKjKgrN8ANVUcJMjt96Cob2E9/VrlKk5E8?=
 =?us-ascii?Q?V4VhiOfOzGkv1aKCxiDcVwi58wdLX2pB3sdXUSQTQsdJgdYNiqi/glso3GnY?=
 =?us-ascii?Q?oaWsopfo7ad+75M59wo5YCq8ZqZVLRf5Jpx3KAfiMZSlJIceUmUlDbceR6k5?=
 =?us-ascii?Q?dtuOhcoU70AO2hyc/syJdqxWwUMlV1tP4IZQSyIykicKEsaSpuVwes+whdrg?=
 =?us-ascii?Q?FM+HblScj6HHwvPdHrEIt6zp9uGJadSVTxM8ebYwH5rnqTIKLYgo7Qq+2+09?=
 =?us-ascii?Q?fUXUM94tidOP78YEam+y+U0iD9r5fqSI0BHA7pNnu0f+o+wFlHkh8P4mcoWm?=
 =?us-ascii?Q?iU5f9UVmF92271h5+6IJW9sTmh1nY/WiylIc8GcNOHgs+2xy92c9Qdn4kS6u?=
 =?us-ascii?Q?s6uGflNjocW5jZrA44eQs5DGkAcxATxHaHysLZ5Br2iTC+ZIhFvDyKKpR842?=
 =?us-ascii?Q?wyXpR8kN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b78d82d-0928-4062-bdbc-08daf8dcd493
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 22:47:36.8979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZmwzmVk84QtZ+BCv3ZRPJTLm/zDjV4hJ2yvizn2H4laVekW4/0ZMbaGd6B1ZkUFtA0JCXWIgeIkBQADylQ8iSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170182
X-Proofpoint-GUID: CvTB7N1rgOanU0YILr9s9iTXxHb9jPo4
X-Proofpoint-ORIG-GUID: CvTB7N1rgOanU0YILr9s9iTXxHb9jPo4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Latypov <dlatypov@google.com> [230117 17:20]:
> On Tue, Jan 17, 2023 at 11:11 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > Cc-ing kunit people.
> >
> > Hi Liam,
> >
> >
> > Could we put touching file name on the summary?
> > E.g., mm/damon/vaddr-test: Stop using ...
> >
> > On Tue, 17 Jan 2023 02:34:19 +0000 Liam Howlett <liam.howlett@oracle.co=
m> wrote:
> >
> > > From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > >
> > > Prepare for the removal of the vma_mas_store() function by open codin=
g
> > > the maple tree store in this test code.  Set the range of the maple
> > > state and call the store function directly.
> > >
> > > Cc: SeongJae Park <sj@kernel.org>
> > > Cc: damon@lists.linux.dev
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > ---
> > >  mm/damon/vaddr-test.h | 19 +++++++++++++------
> > >  1 file changed, 13 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> > > index bce37c487540..6098933d3272 100644
> > > --- a/mm/damon/vaddr-test.h
> > > +++ b/mm/damon/vaddr-test.h
> > > @@ -14,19 +14,26 @@
> > >
> > >  #include <kunit/test.h>
> > >
> > > -static void __link_vmas(struct maple_tree *mt, struct vm_area_struct=
 *vmas,
> > > +static int __link_vmas(struct maple_tree *mt, struct vm_area_struct =
*vmas,
> > >                       ssize_t nr_vmas)
> > >  {
> > > -     int i;
> > > +     int i, ret =3D -ENOMEM;
> > >       MA_STATE(mas, mt, 0, 0);
> > >
> > >       if (!nr_vmas)
> > > -             return;
> > > +             return -ENOENT;
>=20
> We could pass in the `test` object here and give more detailed info, e.g.
>   (if !nr_vmas)
>      kunit_skip(test, "...");
>=20
> And below could be
>=20
> bool stored_all =3D false; // instead of ret
> ...
> for (...) {
>=20
> }
> stored_all =3D true;
>=20
> failed:
>   mas_unlock(&mas);
>   if (!stored_all) kunit_skip(test, "failed to...");
>=20
> > >
> > >       mas_lock(&mas);
> > > -     for (i =3D 0; i < nr_vmas; i++)
> > > -             vma_mas_store(&vmas[i], &mas);
> > > +     for (i =3D 0; i < nr_vmas; i++) {
> > > +             mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - =
1);
> > > +             if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
> > > +                     goto failed;
> > > +     }
> > > +     ret =3D 0;
> > > +
> > > +failed:
> > >       mas_unlock(&mas);
> > > +     return ret;
> > >  }
> > >
> > >  /*
> > > @@ -71,7 +78,7 @@ static void damon_test_three_regions_in_vmas(struct=
 kunit *test)
> > >       };
> > >
> > >       mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
> > > -     __link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas));
> > > +     KUNIT_EXPECT_EQ(test, __link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(v=
mas)), 0);
> >
> > In case of the __link_vmas() failure, I think we should skip this test =
using
> > 'kunit_skip()', rather marking this test failed.
>=20
> As noted above, I'd suggest we also pass in the `test` object to
> __link_vmas() and call kunit_skip() from there.

My thoughts were if we are testing adding nothing to the list, then
there is probably a problem with the test and so that should be
highlighted with a failure.

I really don't mind either way.
