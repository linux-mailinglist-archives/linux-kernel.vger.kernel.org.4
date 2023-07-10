Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8D374DFDE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjGJU5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjGJU5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:57:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4063F99;
        Mon, 10 Jul 2023 13:57:15 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AHY66T014675;
        Mon, 10 Jul 2023 20:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SpivS/g/jG7iwTiqItMwB/HWMNiUHnk8qeYaljay3qk=;
 b=NWN1GHXP92XykhJShQw8f4w0NoFUz38ZMOZGAgiIhH0Mf92YC3v+18322EQEe7WrOyoR
 NbF+wv1eG+/s9ZTNphhF85I60hdiW0CDi/B/o9YXWhUHZIMXW+wtX+L6mvT05vqZ7DaW
 Is+VQBENBrTvP5uyjnd8bpBD/690DR695Iq0PcZXbUo+XqoWCmsTmroeYaQJ2hd+gaU7
 IKPT0gYfaaoAQoj/kBHtlJvZMtmU988lfCnoQi+QT9gzn8f+1fNNcFacpLE2u7ySv5CI
 BI0D2PkFbDbfKamfhYUoLJn2+GnFDhWUdmevnTeLR8Ei81BlXtenVwA3ihTLvojNnSoo SQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrea2sh8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 20:56:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36AJDsPr035481;
        Mon, 10 Jul 2023 20:56:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx84034s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 20:56:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUqYYadkLGa7JLIT5/mGL0JyTwyU2mQey5kSO1cLxyl0braRsCLUnhDXe5z1EzXZUh/uqgtuDAPMyTAATWxM7CbPD6LugMJdbYOBhHmHiWJawEHo9y7+NqyhdtG0gOXQ6j2JOlWV0Z8Eq34nAZRy7yLcQgUdib/63BQXltjo0CH/w2gBAvkrewTHZxGNbSEL/MQJnbx3Yw/BFklAthvrPVfn8hVhWW2cqg16bITwuQEGAriunDjGyj4S9lC6DmBnftG+ZDiWW2tMmSpOd7pKY/uYvLzpZX2eKWiJGXJuaLa6Qy1ae9bEtMsvDUEp3hXRDtTMYAwW4eD25SuZYwtiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpivS/g/jG7iwTiqItMwB/HWMNiUHnk8qeYaljay3qk=;
 b=LySe2XG3CIngCZrNyUf6WZWmuDM75weMALA3L9CUGwnQEYkOM9tF6Q9x0TDaNEtih6sGX5GpOTWE7DxlulsNrJzQ+gVpgJBqd7DmYBg1w/6oyxz9vMyNvVQyO5Q4wjE33KIGmgdsUys6TzHZ2WVAIOSFc/hKOPjGuK09khaW7kCR61s/gHk1SESUnS0UNDzsxbA87/PPRnIr8BZfG1zefde4LS28yd8mJwIWnAb915kqdy+yxXFD94YIKI1SpC+5s4i0ijpWdEyjcp96hmWB5oerocivUy7Qkve+gyvVy/FNNNa/YXOY4GY6GqUc3r35t1JZgw5KintMW093070gRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpivS/g/jG7iwTiqItMwB/HWMNiUHnk8qeYaljay3qk=;
 b=Sj7Lis6JOxBSwABbrgSO2CBw4aw+LtFYbhlHoNJrPDzNN10J4BpBw+59bpaj+JvEwNpbHyhy2xvb7iobZuJp2+vdb147cO/BT8YOp81BpHyHICn8V0JttzoOgxDAG6g2v9elvwLHHdSSav5cjDI75xoo5tbPwHuiH6aA4t5cNgU=
Received: from MN2PR10MB4144.namprd10.prod.outlook.com (2603:10b6:208:1d6::11)
 by PH8PR10MB6573.namprd10.prod.outlook.com (2603:10b6:510:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 10 Jul
 2023 20:56:52 +0000
Received: from MN2PR10MB4144.namprd10.prod.outlook.com
 ([fe80::5e74:f04d:3563:e333]) by MN2PR10MB4144.namprd10.prod.outlook.com
 ([fe80::5e74:f04d:3563:e333%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 20:56:52 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "david@fries.net" <david@fries.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "zbr@ioremap.net" <zbr@ioremap.net>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        "petrm@nvidia.com" <petrm@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v9 0/6] Process connector bug fixes & enhancements
Thread-Topic: [PATCH v9 0/6] Process connector bug fixes & enhancements
Thread-Index: AQHZsUS1lL0prmJue0aG2u5DEdOvsa+zV18AgAAoMgA=
Date:   Mon, 10 Jul 2023 20:56:52 +0000
Message-ID: <3614913D-1985-4C3D-AAD2-164E6B4AD2AD@oracle.com>
References: <20230708023420.3931239-1-anjali.k.kulkarni@oracle.com>
 <20230710113300.10cba1b3@kernel.org>
In-Reply-To: <20230710113300.10cba1b3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR10MB4144:EE_|PH8PR10MB6573:EE_
x-ms-office365-filtering-correlation-id: 6d7c81df-a867-419a-4244-08db81883040
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZCaB8GmPWaPKadlTtTvXhXxU1WUahACAvm5qpnnBeisoQZdmdFHyeRCU4qDV355F82xfKDgFpkGAhhzc8f18wPuLWbUJw3ku8aksD8zBT3c2lTHbcjdFjwv6CWJbF8E/X+h/IpYoJFjhaln9fX8P0KHf3UeBNLTh0gEJY9P2ysPelCYCdLIRQBIhmgBRDUw1haWXiO63on9kmvBfAtl+pTwGsVMCcomd8vTmHbb/qiQ4ku0wPUhzzUgxSipUuL432fenMzB4W4C1vq9jPipHXIQpzYC6fuWBzT8UukRxt667jwCfClbPBmU0+N9IK9MKzQ+58g2DfdvQPVoqaN8vms/6ewMW+/3I90VEyvay07PGLNbIAhVt68k1qYksOevTdfgsZIC6vNrL8r7YorHv/Sxw8V4d4qByKDw8e/+BwFwmcTJPEAuLdIFA50yFGgQjgRZxskKKDOMUANaZrHG4ui+Oz1HAZZrh7luiOHXYkNjv0jmTBwwtzs3v4oZMkhIynqBl2SHJlXKCwqzfTujDAK7BJbjfo7qa/e+qetG4RM719es+M/a9ihdK65PVosoFtvmuEQjjtB9FIORauz2p/jTeOEwuIyaIWzQ3Nkp7qbN/R22gDhr3S1CsbIZcFVLyuG0Z4Zhj0FcUtah000Z7jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4144.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(91956017)(186003)(7416002)(66946007)(66446008)(66556008)(66476007)(478600001)(4326008)(36756003)(6916009)(8676002)(64756008)(8936002)(76116006)(33656002)(2906002)(5660300002)(316002)(86362001)(41300700001)(6486002)(966005)(6512007)(38070700005)(54906003)(4744005)(38100700002)(6506007)(53546011)(2616005)(122000001)(71200400001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tMLGpH0W6q0NjngsjW4985NZQPjPuDX0067m1oCEBlieSd0eD+QweCcKrH8a?=
 =?us-ascii?Q?MiHheghCc9Iz8i4DHnzmprkfZZCkSmoz3pH7hKVcrRpSCBauv5h2ki8To/DA?=
 =?us-ascii?Q?18nj5XK9r/eLZNZhVkSQeZzABow4iCgUYbJqH38bZ7Zj/IJHgID0sNF85koy?=
 =?us-ascii?Q?tbjupe3SL4bih4JUxETIujYdqdddW81j0832v5oVKtl/tjWORJMfMkR1pc7A?=
 =?us-ascii?Q?gc9P4uFsY2Bn8xPbprVyar8ZPYaSC2P9keeAYISHCHtG1b+t5/v8gdCe6pWU?=
 =?us-ascii?Q?pBbXMmuQSIOQk6bR0sDNJ/1Ll/YkiC6nMbDklS3/mLxO7RwQ0k6lFkb/jw4Y?=
 =?us-ascii?Q?TJSoEpnpwXv4OkkrzX8Mzj+CjqOMYNYeIFxHxriC/I2bysv59eGMhGiiSq+o?=
 =?us-ascii?Q?U4IXVHKU77Iroh6LdXFehVXlyu0f59jQquQiyCRGHH1+wpZdtJT2yQffeBRy?=
 =?us-ascii?Q?DP1Y08n1z2sTEOqIwzv4v/SuFBLHyFpL/80Q1XhWzM69CkaVyAStMSpFjVlu?=
 =?us-ascii?Q?bP41oVuYMYg4aaNCnRl88L2EZRktWxNuOhV3yA9xYNcdiiKFvn6TbWQIlIFq?=
 =?us-ascii?Q?FTuyYU1fZLe+KGskwP9hLhOnEjoi9NrKzkpIfUtA99jJg8taostT1+7wJl9e?=
 =?us-ascii?Q?rFH8Uc2qmA8CatS5uoXQ7EHq/mlhhaKE0iBcOegnVXJF3idLRXPFu/jqF4sI?=
 =?us-ascii?Q?q9i/QuclG1yJDqoSTYY/yBO+0KW5KC3axdc8GPHAc1qHSSctlEMOsin1ZVhF?=
 =?us-ascii?Q?sUFiGdJ+x/nHtjaENGFs+goY1hQa/b10tI62wB+LJkEgEmR6N8d5mUC8m2Pr?=
 =?us-ascii?Q?sFuHkb2jN9aiYAdYbSiKja7Xi+7juLsVknRWM4vc5cfdxGlqu7tWqa3Wl/30?=
 =?us-ascii?Q?DsQqvcoWIUpgR7y0LNSMr1oMq8MzRwNW+ZyGPd/04HQXZC0fZ5iOkX24V7x/?=
 =?us-ascii?Q?ePSqiDfbXGJBLYVjwX5bkHo3B2QC1q7FhdJwCzzwutCzvo2hN8/q/jjH4RSe?=
 =?us-ascii?Q?azDDaUGxSXh8A4PnfKhg65X31Gkx/x0HocTtizcIn/SgRyrL/s29DiKPuj+B?=
 =?us-ascii?Q?JUfaiz3LDSs5NH2pfDWcAXtYaKyNuYk4sGCfShJxyUuWNQwv/vAHiZBRovKX?=
 =?us-ascii?Q?Wfc/SNDsTWcEaZIfd3KLAsFP8JFhxo7R1dR9UtMnvc8XWSBU6E7D1OH4HU0J?=
 =?us-ascii?Q?Mc73gk1SuDx2CFY+BRchJ2krkBInjzONelAGxyQIVQjr80bzTcoLv9izSefq?=
 =?us-ascii?Q?lnGtSjNV5wmgnELwMPNgRg9JTs4gnJszZazDzgpysimJrvDFrhIZBYHH7sPB?=
 =?us-ascii?Q?TvzNxZlvyG8Gen05+7Gq5EdyrX+e1FpK+CeWoW7GnKJhRfPZvCUtJt9J9nYF?=
 =?us-ascii?Q?bzh+ApobVCH7ghl3ok377s84ckaS/MgHawcL3Pouv0d5gBO8jf4IJjy65Mjv?=
 =?us-ascii?Q?V2006ETBM9+ixNTN8mla4PSiOvTXpQyp3e/GBj/8Ef9M9a2DYCaqf3Spzrfw?=
 =?us-ascii?Q?SYjXFgWxx+KbzTi0d7+6pg7qUYhHx2wtU21JRCJ8liriLPQg9nD+VpWHIGWt?=
 =?us-ascii?Q?zP+3oS1iFuZeAersinXzUdof1wUMDYeN5tSUzqA+BAEOMUkXR6fgaUqc+MRJ?=
 =?us-ascii?Q?v9Lo/qlBIjPU57mghHKmO1RfZMEh/IYTaOUyIXIHfmS3/QAry7egk6grtTnh?=
 =?us-ascii?Q?Le+VhnJzs+3QpND8KrR0I79au8E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <03848C809E4123409B16574F2D9571EF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zkhsVq+fXcjUDm+VpdLdF5sDSOltbqnbivWjubJ1Q+lG/IUh4hFT0lq2o0KZ?=
 =?us-ascii?Q?L1R49+IkqCdaAs5NzoaECahRk1fqyWL3Vapa3UhZqovyRQiQZmYAsfuzxp9Z?=
 =?us-ascii?Q?fnLTbzfYH0rOc5TQxdF/0PNLuWGbsO5zg14mq2jCN/mDOzGRhkt6zd7CbdEH?=
 =?us-ascii?Q?xqrtEJ8LcwesgTV6Mmt2is62CiQKqsKPgI2r1JD7qc+ukgKYVj+H40eA+qYf?=
 =?us-ascii?Q?DYlZaD5hGbicUL8REGMQ4zFAvhQL8DJzzED5tgJOIaIGrm1ASvpqflwXlMJ4?=
 =?us-ascii?Q?QVrQC6uu2QbvP90Y+1JOIOiP0oR/yptI8iI4u/+GgHD2u5gP2uCObr04vXcu?=
 =?us-ascii?Q?xYwBRSsFXo9z4ay99NdulYy39d3bVqMepyGFS1j44qVmbP5jzj5RAQaXy8uK?=
 =?us-ascii?Q?rfszjmpyXEc8mj8t7OOvGofHb7kAUqusFsHyNAO2wX/8HyswMaCDx7lMovsZ?=
 =?us-ascii?Q?wxwoOLc09WQQXH1yGM8gyYT0HKkSX7HWRsPBjxVIrKlNM0mOh/PXDlRsgKCt?=
 =?us-ascii?Q?ytZZkX3GiDxBfDkCdp8YsGxbV+1+/VqbB+XMKfuDBDf4mK3yHauebGPdoLyW?=
 =?us-ascii?Q?aWOWJqlkqJjcVfQ6n40wssJOtyvIO5q/b9Z6vSjKDpXOeliewU274g0UQEoI?=
 =?us-ascii?Q?tbFQ0wJztOFkRlLgelZmA1112C4CJv595Jdb8sTITjHV+mtVaj8GGnWWHkrB?=
 =?us-ascii?Q?WtHQALCY6+iPEKl6GVIIoEJy/r3Wvi4lc5sUjT8OKB6SOUfVuJtMm7ZOLRqa?=
 =?us-ascii?Q?3zlX3X+R9UsEUzj33ixKQ4Txplyzkx4jFqmOPIw8Brn6TCqblBqytFwsENsI?=
 =?us-ascii?Q?4YLCF+hRJqyEHaTxRp6iNxg5hlmOnnavpBzD/abn4pPEoad5sNwyJimktaZQ?=
 =?us-ascii?Q?u9NJRE7GHF7OKR7SMqepeWXSXmr+6DWRO6oErzmNhAi/Eud4GKnFK/RLaSQ5?=
 =?us-ascii?Q?zQJY2VrQzcxAOQ2R/VIF6cKsN6uCoEYT5ORx0jTsz6+ETWRwMgVOmLul15FV?=
 =?us-ascii?Q?kjoct1sJ1zz/aolWLF6EqapqrWcw57nbtUTdulERHyf+D7SBdqJvtWXt28UO?=
 =?us-ascii?Q?xhuCE3ekNKUeHO7y6sdKEPLcBPYuNqlTljqoCsKlqN211J6nMSOqI+q5ydjO?=
 =?us-ascii?Q?bI0FENMgNln0A4SgW1gVhMKBQ4INUqJrQ2eUZXvH0VtcO8Ud8LNtqMo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4144.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7c81df-a867-419a-4244-08db81883040
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 20:56:52.7692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJjQb+GtTUB60j6LQqjZV6uyzVRR9OMyKfUQ8xkR36Ftiqw/NA7jZUVaGyseJqo+bBk3sxo10F83+deDMVhEFvkX5MNlFyyhnf2fWdzcoFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=650 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100190
X-Proofpoint-GUID: 2DYmeiO8ZLxYbCYdyQYLYf_s7N0-rPOl
X-Proofpoint-ORIG-GUID: 2DYmeiO8ZLxYbCYdyQYLYf_s7N0-rPOl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 10, 2023, at 11:33 AM, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Fri,  7 Jul 2023 19:34:14 -0700 Anjali Kulkarni wrote:
>> Oracle DB is trying to solve a performance overhead problem it has been
>> facing for the past 10 years and using this patch series, we can fix thi=
s
>> issue.
>=20
> You sent this when net-next was still closed, please read the first
> few sections of:=20
>=20
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>=20
> To be fair towards folks who follow the rules I need to discard this
> from patchwork, please repost later this week.

Thanks will do.
Anjali

> --=20
> pw-bot: defer

