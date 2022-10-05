Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6A65F5B0A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiJEUdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJEUdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:33:40 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A233FEED;
        Wed,  5 Oct 2022 13:33:38 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295H0NFO029781;
        Wed, 5 Oct 2022 20:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=IQ0T+/d4QYhY/gOZucqLAIDl/8OE+LVL1s85t7GbXCY=;
 b=EhkNfuSlkALi5UNfeXmqBMf8lptFmWJqRVRW8LCYZ5UsPIcmn+oJiNUUlZPmpWjTCDOq
 DqerLScUXUZod7DlDFWtjp1aoRAdkvfcrOBVKwHwIj2vSJY6RHzs1CHrFJpZA+1wKQ1Y
 VZADPgXUEQNEJJEcWsrrlmpJ0A2KbYGQkrNpsoltVq6Jg7WiSsv/Y5KodJC4eukQftGz
 +ekWx/q98Id4Mq/MMWf/rFGWzSl+J4oLv+yevxNV3E2aJ9PX5B/JJXTcmis/MVUXPTYy
 JnAf8uTzaW4qUmetY9B3l3wIxhzfzMBDZkka35rdR1O2bbNvHgjVX2V9rZtFCCaCg/Q6 Og== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k1dxq9jyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 20:33:07 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 9CE07801AD4;
        Wed,  5 Oct 2022 20:33:06 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 5 Oct 2022 08:33:06 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 5 Oct 2022 08:33:06 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 5 Oct 2022 08:33:06 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSTt2/dPtGwUG34j4LRJpBQS1omL/EIJfeJPzYOpy36CCYmSoAvfVolC83jwStvDBP5jQPMpt4irYnvyaPWTxG4wc6WLu2KidSfza9eaysWoncmAUtVEkE5t4ipV/D3Eq9vZ5g2PdBTwkGLQdWs/Kn9MBXUg+ikNM6K19T8aqKzRndXEuubzrE+GP4jJwiYhEt98/+S0eZ1xIcBXo/o4Vo6PTq2+LFEQgqk8Au7cMs7YTrQduAiDOyB0M1OfhxAOO7lcmviNggz/eKFIYcTeCzQuovjhf3vYd6qMkCeSCyCm/WKB16Qnrgy8XofX/dQGi5GZKCn0PCfER5nFIgvpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQ0T+/d4QYhY/gOZucqLAIDl/8OE+LVL1s85t7GbXCY=;
 b=TUlpml0/ZyOkv2T+6Iu2pOzib6ae/I2OM/KHk7ezQrZQzje5v8EXt0/4fZmV6RtsKOlE6RKulXnJ0zG+giwFEhfwGkRD3DDXcBRq0KnsNqTiZm1wp7ZdRc9+ngJrAdEF3/F9FeDz6GOmqX/OxU1scv87q+WE1jz8MyPesZ3qifObYFdWQHkmGPJxMQAIYNE+ssR2IaCyyXH2iVDQPMfCg+fnuoWQW2VvlH5MHc6zprckseqMxHByJJoyyxzW8SDm7Qo1v/R+ELbRZcocKcEYIWOWmTKBW7Tl7b4seQYp//q+0n72s3OGYgZiJPiCSF9bXJ8pxYRm9vGMTBknI/NBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH7PR84MB1766.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 20:33:05 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f4f4:4c43:9c7c:333c]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f4f4:4c43:9c7c:333c%8]) with mapi id 15.20.5676.024; Wed, 5 Oct 2022
 20:33:05 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v6 3/5] ARM: dts: hpe: Add spi driver node
Thread-Topic: [PATCH v6 3/5] ARM: dts: hpe: Add spi driver node
Thread-Index: AQHYop5JdjqhGItMzECDlzz3VYR3aK4ArTmg
Date:   Wed, 5 Oct 2022 20:33:05 +0000
Message-ID: <DM4PR84MB19274B41DEE65D882D4C8F27885D9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220728161459.7738-1-nick.hawkins@hpe.com>
 <20220728161459.7738-4-nick.hawkins@hpe.com>
In-Reply-To: <20220728161459.7738-4-nick.hawkins@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|PH7PR84MB1766:EE_
x-ms-office365-filtering-correlation-id: b3836acd-ef16-47dd-15f5-08daa710ce6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: itPwG0KL37q5cQIg+X5YRPRe0MY8m8zCA3vhDlsFSu78N74Sxay8+EP166/sSDqWfLmwPhJKeRcAhl/t2kzCxUFLVDDfz5vQIW1tEC91kfiERlZP2xOOA2KHGEBPTLtibWrRXq8VKk9gwP0i3x1ifK7iyvwP7Ma1zhDS/PRfrE7v1Cjs4PPMAt+j/5MVPbrG4QNqE9iygNveMIIVg9b+KIm/iu9fQOBU2Y3tA2x2JOO0nL6LZQgDRWCwYjz6///x8v3WukN3PLTv+pKtrCh2lW+fKeHKmxcgTcfcEzClrVZmLP4FSG0r9yyW+Cr9BsW93XTLKzUVvV47nGAMsodCqdo3J3Ns7ER9YKl4x7S+zN77H8vKvNvpRhGTqpsFuTo6tYOEuAF4EXakBJrnXXlxN/ETBCouahyUIcUNFXtQiUt/Pbeu/5Dzavt9zxn/wqSzXvYAWx9wKVpweEHqnq8H3QUc6QbhncDxumwbI+8PZxHUxsv3/Fum8FNiqqkN1E1b6Kncw0zuWWg3G1EnUlTnskvNNcjebH+dr6cCTxhC/CJx7aDTTNgBlBRc/qFADPPWeyjaNl8antfLKpN8menmtQUog4QEsh7XrXDRoef8SgkgAFNuV9euPgxB1t6zJ0H3g6cJmDJdUEZejmmGBRtpuyk9gaf9avaYTCgLRUkV7T8b7udOxtDtpvy2ZO8CEabJo0rmEFAVSBnY/ym9kvQCRhb0E8WZ679QdVNrfuXb4CEsQ3NOUJCnTa0EYY9m9m17
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199015)(66476007)(2906002)(66946007)(6916009)(38070700005)(54906003)(55016003)(8936002)(64756008)(52536014)(82960400001)(8676002)(33656002)(41300700001)(316002)(5660300002)(86362001)(66556008)(76116006)(66446008)(558084003)(186003)(71200400001)(6506007)(26005)(7696005)(55236004)(4326008)(38100700002)(478600001)(9686003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l/HQVJXDGkSA/CHqUqmaV0cpgPTSbF0iYlgJHzsU/e8JxZt9ZCEY5/F2+Thb?=
 =?us-ascii?Q?BCt3poOEOw80LeFC5xzsShiC/qMlmJTczenMPR87sEf1PwG2ts6DlwmZApj0?=
 =?us-ascii?Q?1oh2h3Kvhv2nFtsy2+R0QKE+qesYEiUlNTil8qG6I9Ss39052Addf0N3d+AW?=
 =?us-ascii?Q?2cMXmBU8OOjahIHH30IWR/fP2czoQwCOc2Nj7zc1IuTNXTEJvTgP/Xo9KT3G?=
 =?us-ascii?Q?CZ8DCCpmwq4S9ieZurr9I9Z/3JkT9Mh341vyMAOT50bLIMeks6yBln/4t0Dt?=
 =?us-ascii?Q?tt1O2zPqeDsLn95IQjiutcOAg+IJ01glM6d+wGroK4cFR/f6TIY5k4w7i5/R?=
 =?us-ascii?Q?mQudknV4dnxiBMktqJ9GOO0ozGfpKBEQBq7wE2Qy9ryhj7Gfj7kwiZBItk4H?=
 =?us-ascii?Q?wP6y3N0cF8a0ncMmefoy3a/TUp9oMsA4mSuMztoCC1SG+fZA0NaXXZvJ/r4V?=
 =?us-ascii?Q?s2b+LA1a2VLOqIlK2Wi3vzOJYqAGI4owrMWXfbmJDSzRHBqaKw6jbeilrdID?=
 =?us-ascii?Q?t5K1SoCYISzQOESV4+KhNdcSQVNeyK7FJ1lonT88Z583gCllBT1YaYvUNUcI?=
 =?us-ascii?Q?KHItEiXvnrSuNTwrEO7Hn0zoityRyv6HOO59S6d8bvD2Jfc5ykjK7CjejdYC?=
 =?us-ascii?Q?GIrk39oIKWVvESVKso46PI36618+V+mAKVEOj/HzaYWdKQCDsFWanTMlnbgE?=
 =?us-ascii?Q?qdutN4WC0SYJi1Uu3qTVSCi1bZHVgEQFxO66eVJP2QqS6lLYiL9micV7nn1Q?=
 =?us-ascii?Q?pwOdbcUyYVXx3JmDUxBo2bl6ELBUirLvFxYzy9eurlcpSOOtdUlvE3S/fLRY?=
 =?us-ascii?Q?iOuNzJX/qd18gg9oWZdW0benw5yZh8beR4BJbc6Dycq3owosGEsvCgbzjTlz?=
 =?us-ascii?Q?xqDz/LOEKEsY7KkHmV6afAiH0T1OXGf+M9umXeRSjjCHxDCWkXIbX5N4cc/H?=
 =?us-ascii?Q?dV7rkz1KkGpN4JEknsEw1EPoHuvrsmbyhVXjCtpYC9wgFGj7PFUTmtlcAcKU?=
 =?us-ascii?Q?Rp4+GmkuJF0OzubX+xWme9f30fqTEbvDo3PNgRfr6kfx1iHoJ3b1328ti2hd?=
 =?us-ascii?Q?aNaOXFxqJUZHvtVm5mklknIN8L1jPTWBoMpiUaBdFIKcjIphbq1iuyDUeqGN?=
 =?us-ascii?Q?OFemgEX1aTE+5EPcZ/+pwqCouWjFvpxqfKl3UvOWFZYsa87bX5i1kqupHYBH?=
 =?us-ascii?Q?HXuRYb8xrOYoqzYsLrwyKl6htqU3XL77lZoQFFuwS+mn3X+YTmUd5NFu9/iK?=
 =?us-ascii?Q?3Eg3ZNv4NQjExPwatr0gtyNK87tEC4607uRYylqOOUEO84pUsNZ0B1LQ1EPR?=
 =?us-ascii?Q?vPiHhuJ6xyCm8eH/NnjwCZ27GdZ8ibtROwcT0uHAaJRov11H8TeO6TAXKWVI?=
 =?us-ascii?Q?qPvqMpMb4DaZhY6Mh1OJqR9NUELFE2Pa6qSdchv6+PN4NvyCpnjb2U7HWWoZ?=
 =?us-ascii?Q?ZFM+QgkX8qghK8rRbXQNw4+2IJ0Y6dKKXpaO7nqDW1Otzs2vHXLobFp/ugz5?=
 =?us-ascii?Q?xWhLQJ5kfQw7tC5HbeGHS7dnO1/FwHhKNTA0fztFD0vM59HrS11MbCinw9L6?=
 =?us-ascii?Q?Tx2jNcjpNViBD3LAxOJptEObFmenwqD57UetbcXr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b3836acd-ef16-47dd-15f5-08daa710ce6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 20:33:05.0630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: miaImvQQlnQrxpwzPOxxUjY1kBaYUAR4wX7Tk93MvXD8bqHthsyGOslRkfp8l+LmRzQteI3Is9mdJTy7K2dHOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1766
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: Im-CltAK7wpFIcl73EOrsQk_eY24RhJR
X-Proofpoint-ORIG-GUID: Im-CltAK7wpFIcl73EOrsQk_eY24RhJR
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=538
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210050126
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings all,

Was there a particular issue with this patch? I just realized that patches =
1,2, and 5 were accepted but not 3 or 4.

Thanks,

-Nick Hawkins

