Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FC162F5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbiKRNRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbiKRNRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:17:48 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B61A48774;
        Fri, 18 Nov 2022 05:17:47 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AID19AT026564;
        Fri, 18 Nov 2022 08:17:32 -0500
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kx0p7k6kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 08:17:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtUHoyWKaNjtvoX3RxhLWdEefVuewGJqMZu10Ih7dprBzjRNt656eJ5A6MTYQvBtPumCg9e1R8do5zIxF3HfDA7U0cjKx9a+ICbTcQD2peD14Re90TWq7j0VePdMrjbgvPHlMYtKtYsKh3jSJXHL2/wNjuk1x7kJsvYvxpKgSCmkUmorlABn84TAg8CCYuRrnKAx+9B05ALF1Pbz1jgaJcnajVjW/lHvHYBzCm3YVW408nNw6f9GGx8yHZiSOW7U5Wmgieo++WmqQmIgBbJhbmbzNLn0maSVbTjjDCClePcnVA0ksNpJVDZLMKwWTJrsUa1U+HvA3rpMexG0asNOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjlNDn8KvlEIxOk0lx2FwQceglCV6MMJLi1hz+SeDJ8=;
 b=guskqgDGiVA/fsFw9YN005rrNTKOwzXVd40L3tMlpgkV7UW834dh+HMs/2IW4cBXmNbGNBivk0grWGZrwM1S/3XXRjg8zTQjXM/K3M0wtjyiKJTMzexniALMGt5u9Hvor7A4+G7+W3gon0AxjrjgACzgVkfMxU8OJ8d8hmaKMUUJyFBtIg4zGgh5hPeTW3PA/evKJLwwtctSnjZEZ464Mc65LNlXdBSMlciUpXP6clltzAYSN8JcosWvIeeQMNIdGmkZLwVz7kvSYeMsF52D3q0U3Sv1BO/U0Um+iWda6Cbw79i0mmFfSLRsuWffUXnz/dTcN1p7ZWOwbAREaqUIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjlNDn8KvlEIxOk0lx2FwQceglCV6MMJLi1hz+SeDJ8=;
 b=hxnKHmcwKHpNXPGevewcVJI/XiVi9Zx5tQCrBasrgqBSScy3tFy/kllaIv1X+Rn3CeEp0uj+tkNBSxzUtOHY/pd8Dxp6ydApVnIZ+K6RyO8/UpWKGrm+VkzNQgqF7Vzrvc0tRq1oFAdbkRYCnGPd3Qm9duxHPViYiLFxHVFUQ2A=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by BY5PR03MB5201.namprd03.prod.outlook.com (2603:10b6:a03:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 13:17:29 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::a07b:a2c6:abe1:c35e]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::a07b:a2c6:abe1:c35e%7]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 13:17:29 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: addac: ad74413r: fix integer promotion bug in
 ad74413_get_input_current_offset()
Thread-Topic: [PATCH] iio: addac: ad74413r: fix integer promotion bug in
 ad74413_get_input_current_offset()
Thread-Index: AQHY+0nukLxESZ4Qd0qamFCmhurvmK5EqRgg
Date:   Fri, 18 Nov 2022 13:17:29 +0000
Message-ID: <SJ0PR03MB6778D6C0682294002296E54C99099@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221118123209.1658420-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20221118123209.1658420-1-linux@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNThhZWM3NTctNjc0My0xMWVkLWI2YmItYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XDU4YWVjNzU5LTY3NDMtMTFlZC1iNmJiLWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMTUyNCIgdD0iMTMzMTMyNTEwND?=
 =?iso-8859-1?Q?c2OTQzNDU4IiBoPSJuQW5hL2JaVDlaVklFeGplL1hZU2FodDZiRFE9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJpd0FnYlVQdllBWnlaV0tpd3FWdzNuSmxZcUxDcFhEY0RBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVg1bDJLd0FBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|BY5PR03MB5201:EE_
x-ms-office365-filtering-correlation-id: 642d0062-10b2-48a1-9d7d-08dac9673e8d
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Wccj6tkplo2rCB0EVpgPzXfWxjU1jkgQ4A10Uzoddw/BNIyZ8CPHe9PNq3LoFD7yZaYASLeLr/FzNAp9HnsCeRT1djBnhC3YKe7xvUDBLJl6k0J3o8xrceEykSHbc1loM88oI6LuF9HJ/ngWCLb1s5aY8SjWBwIF+nqtVGLvTVLogiCgJ8Ei/5QS4QRlhwUN4GcJ37GlaoFNKZbn7VPlpWo7bVWXBXbcDSWz5f3PBQB6jN83UySeFIKZRT8jTQq09ifnnvrHQt+97O6XDRahBUOSMe9PlvMaUkvW/SMQTyVQu6ToSIUYUMw7kR/SKAQZx/Omx4iLAJxhS3AgWCYqKA2I3ieCTzPQL4i/sNwJfnuO7hp1ELVjkl3ueFQZ8R/gsEnR3B5MH/zi0Cz/RRExjdWXWEHvRG8GKnB/nX+H/n9iAd590hVpd4G3yTRGA/keRC5M/YdTIyj1X/cMMZxrYf+NMjM46RL6jzcWix1fDPdXqsHVo6jBenJ47ohslVMSPi+A5hGkhWqKtqJyChS/TQfH8cB9UZaUSPgPYior9bcZW8o1x4CMiAEx8BTbCcIsosLxmNkWjz+xx7SSINCLPmxcruMifyzJDJtxMf8igeyN1qYYkFx7mTbJFUO6aZU4M3ay7GpTONz3m7S78y12pyMKsU0rdBMk0gV8i5bsZbloxALdtZPW5+v5rC83Zpva+GT7vX69zmdLWpov4OiyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(366004)(396003)(376002)(346002)(136003)(451199015)(71200400001)(478600001)(8936002)(8676002)(64756008)(4326008)(26005)(66476007)(66556008)(76116006)(66946007)(66446008)(52536014)(9686003)(5660300002)(33656002)(53546011)(186003)(41300700001)(7696005)(6506007)(54906003)(316002)(110136005)(86362001)(55016003)(2906002)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k5ZJ6XcBztvihLD5eQ3UKbjLz5gM9fQMhYxI1/df66gch6AUdYSIpyDrO+?=
 =?iso-8859-1?Q?GGMgCNTbwRjDzPrK5Ivu65G04rp08GJ7vJ/BtO1imJVQBPMZ6DvlGbguRs?=
 =?iso-8859-1?Q?fI98irlsY5/Qj2JX5h151dew0qOP1tt974a5PZvdnLoMx9qL/LPzVC1QwP?=
 =?iso-8859-1?Q?SCSzKldsCD2g41qi7RLKba+ND7kQ+ZQ8QAHwd0KSshfeYBruaWn/p27HA8?=
 =?iso-8859-1?Q?9/LvBjrjMcRzlMwtuFej2rznLsjR+Q4YdFnoltsgwjQfr8D5nTB+UqIQHM?=
 =?iso-8859-1?Q?WVbNRF6u3qKnR68d12D5+9USXD/D03uPiPjyNUj+0yhXch6foKcxL3mDzL?=
 =?iso-8859-1?Q?mTI9Y9JvJ0aPwslTXznophZK9FmASAVuKBw3WTa+6stE5SbtqS8f/vj6jB?=
 =?iso-8859-1?Q?25tBa17FSzv2twGklKJffiCPouFzKOf9mPyNVJOdTvSM4pWgPydPtoD8AQ?=
 =?iso-8859-1?Q?ViZq9yfbzNSroMIm70FfJmt67nCDjBILCptucStWBNs3hl11ZLO3T8peNe?=
 =?iso-8859-1?Q?S5wNUGyA9The15fAiQh2cNDvBqFpT0trO53ft+gifYSMMEkXTXCKpVS71J?=
 =?iso-8859-1?Q?g38ytBPKp1zEtTZAdw6vYw9NXlF8d6Y1wYBodlQPf7d5s2j9tSqPPtnR/f?=
 =?iso-8859-1?Q?DJjDU5kNq+0Oh6RJTBoTm8LtKACqRppHfyb5czayauhwpzmhUBS4lwfxQf?=
 =?iso-8859-1?Q?TguUlMFHuK3aqVlAjZC5ANGKLSQg1X3RIhFvIu8Fvp2tCuYzoBJ1WaOhz8?=
 =?iso-8859-1?Q?WWChlTTUBUd67n4i+LLe9NlLKEsYEVEGC8jspryi8APY9yGsOx0DjO/EKK?=
 =?iso-8859-1?Q?37li484/wd6Xvt4z780iM5iW2If/JUW+Ps3/b7Wu4jCpo8+QGaKqj5NaFT?=
 =?iso-8859-1?Q?buD+Adh6AQcB46Gcsp2rzaN3TxFMQvhiF574s3v9+RXMmEfhSpZ86KYh78?=
 =?iso-8859-1?Q?GlWSRIO6jKbFiXe8qgaoQh+BfhAaiHALAcq4htRtSzpxri1/iP/rM7lyQT?=
 =?iso-8859-1?Q?Le4B0dbJ2EcZuYKHXVvLPWAu7oldEGNcxhzMN6dKkGswF9BXLeEGRQlkKT?=
 =?iso-8859-1?Q?yd/5YwtG5wR3fWB9rWxhKy5XSBNFeOODsWfaBGlhgM3LWTn+ZmtozOS8Fz?=
 =?iso-8859-1?Q?gGZr6sriniH/RmgZ8haH545iz54IX86aDhVgkCM70LYDcJVzk7AcazAx86?=
 =?iso-8859-1?Q?WUWMThc+dM7TmzyuRARYKI0RJS840oqXTYi9TbqnJneomepJvT4IUuaxX/?=
 =?iso-8859-1?Q?BbQSq4ByXMR1JPG/SxcnGTJSiixszLBAlso1+C5Fd6iUkpj84pYUCupK0s?=
 =?iso-8859-1?Q?n8SkeDRe2i63iK14VWU99w77xAm0lqvXAtiJRMAzGGPJfniRjc1M0XTmPE?=
 =?iso-8859-1?Q?WC20l5BvBjx1gGZl7uEUaamqLNeLBVMWXYnmHJQTdWcyxHVkPCWOLZikhI?=
 =?iso-8859-1?Q?/lkgucTjuPk7DVE33860YGq0j8ThwdIBM0xOXZVeKOtwhf+azHr8Paf8Rl?=
 =?iso-8859-1?Q?sqv6a6Tz8pExlJ+KllZ2o3ofCriFpHnCHlPfsACvsT919cH0yxb+G29mER?=
 =?iso-8859-1?Q?dC8ITQo5mihO0tVuX44ZOTKFlnPdSplyHUzsMvh8J+okXss0VK63arnY/h?=
 =?iso-8859-1?Q?vE0KyGvfnLky4kHTfpItG8BWiF7iLQf9rY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642d0062-10b2-48a1-9d7d-08dac9673e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 13:17:29.4160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i31G4WzPaQUtITSgssiLgE2+QlvJcOFPomhQWvUTeSoa1YRsq/DoYpOvxUX+8kB2HU+AfDi+WsxyTL3zDRlVPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5201
X-Proofpoint-ORIG-GUID: oP2IAAr14q5242JTnScMJrdmp7XWp3g2
X-Proofpoint-GUID: oP2IAAr14q5242JTnScMJrdmp7XWp3g2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_02,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=846
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180080
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Sent: Friday, November 18, 2022 1:32 PM
> To: Tanislav, Cosmin <Cosmin.Tanislav@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Jonathan Cameron <jic23@kernel.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] iio: addac: ad74413r: fix integer promotion bug in
> ad74413_get_input_current_offset()
>=20
> [External]
>=20
> The constant AD74413R_ADC_RESULT_MAX is defined via GENMASK, so its
> type is "unsigned long".
>=20
> Hence in the expression voltage_offset * AD74413R_ADC_RESULT_MAX,
> voltage_offset is first promoted to unsigned long, and since it may be
> negative, that results in a garbage value. For example, when range is
> AD74413R_ADC_RANGE_5V_BI_DIR, voltage_offset is -2500 and
> voltage_range is 5000, so the RHS of this assignment is, depending on
> sizeof(long), either 826225UL or 3689348814709142UL, which after
> truncation to int then results in either 826225 or 1972216214 being
> the output from in_currentX_offset.
>=20
> Casting to int avoids that promotion and results in the correct -32767
> output.
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---

After adding proper Fixes: tag,

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
