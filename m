Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F0674C934
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 02:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjGJAUS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Jul 2023 20:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGJAUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 20:20:16 -0400
Received: from mo-csw.securemx.jp (mo-csw1801.securemx.jp [210.130.202.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA8711C;
        Sun,  9 Jul 2023 17:20:13 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 36A0JFoB4144188; Mon, 10 Jul 2023 09:19:15 +0900
X-Iguazu-Qid: 2yAbM4uBQ6UZ0DRSiv
X-Iguazu-QSIG: v=2; s=0; t=1688948354; q=2yAbM4uBQ6UZ0DRSiv; m=g9N/lX2cDnrSXJ6UhgXx7Li1+9qBCIhrefpT1OMTzGA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1803) id 36A0JC1B3532129
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Jul 2023 09:19:12 +0900
X-SA-MID: 4138121
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0ir0N1F1MddV2IoV5Rx0H71kX5TXL1/A9frOn1bOU+X7qE5NxcKiQ7XgIL0ntzT/xFm5L+8DE0Boko7YsD8GJ+l4RVFduh+LXiMXx2ShDXkVgL7Kd4+KdyjY/L+KSv+6ueQfMqDXhgG4l3nzs3OZxCCTDrWGO8m5fWdhZJQNy1OQSMzX9BNpDx2lpEh6oauhBkmENkJvMOroHFPT6hsLutx+Tr7iTQODlrM+WHzTzVp5p8Lz9R73qDfBYQ1dnRV0/Hq5Lmmt10qITKGl/Hj8SX7OyCEED/OT8VvM3preytZ2phsD+2m3S9ZgH/+pcPWKpJDn3oVHAsc2dByymHSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6id8rvtNQBl8HYbqgdLgJlnj/kS1Fs7uf1mhDFDlwJo=;
 b=PJ2ERNAztNFnJD913D2zxgXoTKIcg2uY0XIHFwG2ykJAHQAHroVn79f8A8NQz5MvZV23Ns/ehQOGuS7zr8f/dGYIPmY1rOUf1AB92FASTkKgGxs2jJwrGCABEt6kYx8BUWeLS1px37WzIKuDC0HJkrm+Ybdt2dOGk2aU0AbYY72nMM/sh4YBX5eqvmP07mL+bqCKzysWziZ7pqdQ2szLqKX2j1se2LnkX8ZkiBUTnB6F2yt1XV+dIebAZQyH+kg7kUB0pWpljc64+h3fUz8Pnatiz6jdY1nq3XTKsNassqIxPDl33ecI/w5knCS2Anaox5gFI0NjaMgjx1MgODPsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <lkp@intel.com>, <hverkuil@xs4all.nl>, <sakari.ailus@iki.fi>,
        <laurent.pinchart@ideasonboard.com>, <mchehab@kernel.org>,
        <robh+dt@kernel.org>, <krzk@kernel.org>, <conor+dt@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Thread-Topic: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Thread-Index: AQHZoyT4WOl+YovnA0eMYN+ttqnJ/q+T1cYAgB5pBWA=
Date:   Mon, 10 Jul 2023 00:14:04 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB6201ABF2E5409340B617A6BC9230A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230620031111.3776-3-yuji2.ishikawa@toshiba.co.jp>
 <202306202308.y7ERKbSP-lkp@intel.com>
In-Reply-To: <202306202308.y7ERKbSP-lkp@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|TY3PR01MB12119:EE_
x-ms-office365-filtering-correlation-id: e5feb973-e290-4438-d489-08db80da9237
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qtG1yUrhhtm5cHpwYK8p/dsxaOpGE1g9sJ0HKTihXX0aBQijtIY0mMQTptadE+qGss02a87F6rLhtEW+QPJc85YZrBLNh30lhYtSBFzSBG++P5W96+sdaJ1rjF9jlymZztNy66UJLSYXA+OSbHIJ/6JvONIGwQwcDlnOG6NpFaAiK1unbiHFRIwRk8G6bZ7adoDFmaoq6PhNiN7i7U56fcMb2ffC75zqwXK+jm3jK20LzlC8SiiIru36ifVTEbys+zN6xNoy+KnEYJHk9lNNawrC9zXELQQhYACTqDhvpPtyoVfvGcomZKc4IQx1DpjvfP6Rj2U9QUvDrUo6SZILm0/iUIkkLQkaBTKf/cN2ZQx2hL4aGGgLaE6G/iTCP8J1UFObiYbpV0vNwB7U452pc7/HT5vUweHzAtD5ojTdMOFitPq4vLwQXmKIAWrPaf2jNBShH1TQuNR9b0B8/Ss5geMmsrCJi1ic06A9qXPSBxfBLXnY187feW1t8geTAGmhkg5awx1HvGCDTJ4B/40XCDv0kjHRkfw6W4PtJ16Z/2cuiPa7wtVD4mJWjdFAWqfG5wsh/Sd4a5Pv8rYzHia2bnB3TwAFUaZxzH35OMHVRUk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(186003)(26005)(6506007)(9686003)(53546011)(966005)(83380400001)(41300700001)(4326008)(6636002)(64756008)(66446008)(66476007)(316002)(2906002)(66556008)(52536014)(5660300002)(7416002)(8676002)(8936002)(66946007)(478600001)(7696005)(71200400001)(76116006)(110136005)(54906003)(55016003)(33656002)(122000001)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Q1Q2eEFoUUxSM1NRcXpxc1Vwcm9RalVoOG1paU03YkVoT1ZHMnJ4YXdN?=
 =?iso-2022-jp?B?VG1ydHVNSU1zaGVGcWE2L1ZVR2VKc3RIV0IwUk5WbU5wOFFIa0VFWXVh?=
 =?iso-2022-jp?B?ZlN4K2p5Sk0wQ3ZPajRLaisxbGdSczYyeTR6eVdwZ3JOWGJCQlhaanJD?=
 =?iso-2022-jp?B?eThoRVRJSm1Pc1BSU2xwN3YwV3hWSzBIVGtLcXdJSzR4eVhRUU8rU1Vu?=
 =?iso-2022-jp?B?TUhPR3J0a2lvbmtFVGh3M3VJN21WazJuNnorNlNnOVdaM3ljS1R1MlNs?=
 =?iso-2022-jp?B?eU5nNlp5bFVtZ1dhYjBKYzg0MVhLSno0bUI4Z2RMVFZJSlFyREkvSjdv?=
 =?iso-2022-jp?B?Sm1JZTM1aTA1aXpJM0ZtTTNEN2RWUTY2bVdMWXBCSlhraDdIRDh3UktV?=
 =?iso-2022-jp?B?YXdubHdiRitablpmTzRBWHFHR1JWMlhKSVZ1TUpvVVlQa3E4QkQ1K1ow?=
 =?iso-2022-jp?B?TnFYcFdJNzZqUUl4N25vK3dsUGVHelo2LzkvT1MydEpXQlB3N0xTdXh4?=
 =?iso-2022-jp?B?R3cwK3QycEROVm5WNHBwWUhCNlRNeXdabmUrdG04WU5kaUFJeGNYSity?=
 =?iso-2022-jp?B?QTJUVDNVdUZqUWpzYVRUWnBLU0Z5d0FIME5EWjdOandsUk5SKzc5K1RZ?=
 =?iso-2022-jp?B?bDFpY2xlZFBLblpqd2pRS3hkYlBKZC9wcTlyM0pqajdzdUxUblR4SmEz?=
 =?iso-2022-jp?B?QkIyVk5BMkR5QTRDeHB1SWh5eDdrbGduZG8wNHBGcmJBYzFuNXdLR3Jt?=
 =?iso-2022-jp?B?Y21nOVAwK1dVNDErdjN6K3VWNDR0U2JmaUdsQXZ2ZlJJQWZ2MHhIMlc4?=
 =?iso-2022-jp?B?Q1Rjc3M3YVNwNlpXOGw4clh0Skp0cnpVd0tJYTJ6L2FZdTd0eGR4SnVW?=
 =?iso-2022-jp?B?ZDBybkVsdVlBbi9TTFIxbjk1bVRHckpjNFlQQ0Y2eU9KUTlHUzFwNGh0?=
 =?iso-2022-jp?B?UHJLQ3JHVTJHekdZMGZBUEdnY25vRDRpMGNwSEJXL0VrZU8yaEJwTTVt?=
 =?iso-2022-jp?B?a2E3WEkxeVl5Y0xVRjhHK2FSVEtPS2Z1dWFSZytmOGdlWmgzQUFGOXg0?=
 =?iso-2022-jp?B?VEFUckljVVVJT2kydCtpSXhVSThiMFhCR2o2VHlZdXNwalFiU0NKR0hu?=
 =?iso-2022-jp?B?Y1NzTEV4MHJ4NVNOaUQ2cFhZcWJSUDlZL0RvdEhROGEwMXMvSThCMElm?=
 =?iso-2022-jp?B?YWZ2ZTkxa0RXVzlSOFdSY2IxVWovelVBYmx4YkdxK0U0U3hFbzdkRnpP?=
 =?iso-2022-jp?B?UFpTSTU4ZjEvazMxazJvOTM1aGI2TUJVLzVpUGhoZFREbzF5eTVTWWgv?=
 =?iso-2022-jp?B?a0p2WGpvbWNKUWFCc2JNZmkzQkVLcjZzSkI4ekZnZFE1YklLdldJazBR?=
 =?iso-2022-jp?B?WDFycy83aURPSFhwUXd5TW8zcjRwb042TndlT1N3ZjNpY3hScWN2eERz?=
 =?iso-2022-jp?B?NkxQbnQvSisyZWhiTUFxNGlDTUxNR2w1ZFJUQlRjN2puc3V1OXRVWFI4?=
 =?iso-2022-jp?B?WjdmaTZYT1ZGMTY2QzZkdisrK0dXbGtZakFqanBpdnJSMnFVampxRWU3?=
 =?iso-2022-jp?B?eUNlR0J6SUZzSkhrVGlPNC9hSnY4anduVzdJVjIzMDIzQzNiMXlJb00y?=
 =?iso-2022-jp?B?R1Zhd1JLNmRodFpKd0lMbU9PbU1oY29PbG5xNTBQaWN0aFNNY0daQXJ0?=
 =?iso-2022-jp?B?dnNvc1kzM3JVR2ltSVhtZ0EvZXI5VGRBMHk0RzZpNS9YQktqaS9OSFRB?=
 =?iso-2022-jp?B?QUxTN29jZWVLV1BXbkxET3R1RkVPTVpMSWx2TDhHYVJGMkkwcU9SVE55?=
 =?iso-2022-jp?B?MWd6c2tRbDNPNitWUWx4Umg2SjUyOTU0eFlSeW1FTVVta0tTbVlzUHNl?=
 =?iso-2022-jp?B?SE5JS2t2V1VYWENSRVdSbHU1RHJ5Z2tGNUJuWm82SXVzM3Bha1VRUnhh?=
 =?iso-2022-jp?B?OUlpZVFNbFBJQkxYTXQ5cmlkK3ZIaWZSY2xQaUI2NWNncUFlcVZEUkNs?=
 =?iso-2022-jp?B?MGFvMmFHRWQ0WTdkMTlPNGVUQnhmcU1ZYVA1QmR1bWRwZGJVTXp1MVRk?=
 =?iso-2022-jp?B?NUQrKzVIelVUR3VnZ01QWm9OQWFEZERkU1FkQ2drY3oyVXc0a2N2bUJ5?=
 =?iso-2022-jp?B?MzhYYVRtTWZtNE9WeDVJWHlIY01wNlh5dTFNUUJVYjJuREJiSkVkckdx?=
 =?iso-2022-jp?B?TnlWYm5pRjR6cjVCQmdzQ3cvQlg3UHBYRWx3S1cxSlhKVHN1RmUzWVJV?=
 =?iso-2022-jp?B?WGNrenJtR1hCMFRtNUc2NkxVNDk1YkkyT1hKMUlYUVc0NmR6cmhQRmFy?=
 =?iso-2022-jp?B?V1lNdE5sSytRVU1ZaTJmeVBCRWlQWERkYWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?WEtyTkhTVjhZWmIrU2VCZ05zYllCTlp6dWh3c01TQ1h5SnZMMkNSYmFw?=
 =?iso-2022-jp?B?Ymd6L25aaVAwL29Qb1pVdlllL3V0WEpLZXNkZDNRSFJWQkFmOHc5S1Vt?=
 =?iso-2022-jp?B?WU83eXUrUGdFbFB0eVI2Tm5nTnVmeTBva1YvNFZsNXpUNDNVL0NySzRI?=
 =?iso-2022-jp?B?YjMxaDIyQkdiY0k0YXZ1YnJ1UUZGMDNzTXNBVnljTWFqWmg5OXlJcVlZ?=
 =?iso-2022-jp?B?TmlTYTRHK1plSE5YNm5Ldm16N3dweWljb3NEUUxDMlhaa2Nra05BTGtN?=
 =?iso-2022-jp?B?MzhJU2t1YVhadzRCdFpqWnJwdFVsZXBiMWRBcG5DM0NpTjRodkZUS3RT?=
 =?iso-2022-jp?B?dEZNNHR5MHJQcnUwVklsUFNFS3kxNnpPRVpkM1U1RThEU1Q0aXZxK1l0?=
 =?iso-2022-jp?B?YjhHU0RqUE82NGhxODdDZDR5eWZaMWlyM2hOay9NRjVFRVpEN1dOV1ZR?=
 =?iso-2022-jp?B?NjdnM0NRSlZhMkUrTjM1R1NKT0xQeHJ3eG9DOEQra00vOG9JZkVXM0tm?=
 =?iso-2022-jp?B?NEc5RmtGSTRjT21wR3J2UFllSnA3VXFVaFdrOGpMK1FQdVFUbFFTRjFW?=
 =?iso-2022-jp?B?cVhzbjhhRG9qNUppL1NUSWpNakRxa25tZzhDVjF4N1dsVEw0KzVCbThq?=
 =?iso-2022-jp?B?TENaRFd5Q0lNRjcralIzc1lUcUF5ek5yYys0bHoxZ283Si8zVmVlcEty?=
 =?iso-2022-jp?B?WHdobkN3Ulp4a1pubmtaaFJraStZaXVaSDRvbmJwRUhKcHFkL0trSjB5?=
 =?iso-2022-jp?B?NWFyY25YaUtHa21sSGxOMG1uZGNucm9yVjdOWkYwM0x6cTJ6OWRpTStk?=
 =?iso-2022-jp?B?VDZHS2tNM3ozUWR0UXZsUFhEZkR1SEZGRlFJRnF5RStBUG5sbDFHUm8v?=
 =?iso-2022-jp?B?MzhFN0FLaWZLMlhjZlY3QUNTUWo3MWdlOE5ZeWlJdWhrSEszTCtaZU1p?=
 =?iso-2022-jp?B?eUl1OW1XTlhMbng1M1dPeWFiZWNjMk1Rb3JORkJjTHRYVGd4NzdNbkU1?=
 =?iso-2022-jp?B?S3dVUWlITUNLbE1KTWozR3NOekdxMytGQUZVcEhSVjVlVjVER0IrcDFJ?=
 =?iso-2022-jp?B?VGZDaGFqRXAyOC9LMmhJTENIRWtSWWR2YUFBTXloR1NZNzZPWUUyVFp0?=
 =?iso-2022-jp?B?Sk1QWjZIYlVDaFB1VEdsQitJWHA1c1YzaTZqT05IOGFCQU83LzZsZDR4?=
 =?iso-2022-jp?B?dCtKYTZibDd4bXUvYXVZL0dWbkhDUStuMnpLYWRZWVEwbHlrTFlYRXFZ?=
 =?iso-2022-jp?B?aEg3cTdBWEFPNmNMc2lCMSthRDhzSi96VE5HcWprRjhJallMSHZ6bFk2?=
 =?iso-2022-jp?B?c3BGd2oydERiTFIzZGN0MFFVV3ltbWY4QjNhMG5STitnRmQzdktBSHVu?=
 =?iso-2022-jp?B?WXRxOGxNY09OTzIwT0wyQlU2OExsc3pmRWcxMDA1aWRtbGVXUHdBUWk4?=
 =?iso-2022-jp?B?UGt6bEpGSkRiUmRpN09DSWF3a1JPS0pGa0NMamFuZjkvWVVYMjVUcTdn?=
 =?iso-2022-jp?B?ZkNhdXAvV2FERjZ6M093MW89?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5feb973-e290-4438-d489-08db80da9237
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 00:14:04.7163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owOxT2m0WJ/hpLH9e05eMfHapsvoVoYPLbmq9rQ7xv88hM7W9c1vKC0gdXogjUSsmAmbENIryXeG4k++bYNxJkuTeIjm0eeT/YlMUXNpoSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12119
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Wednesday, June 21, 2023 12:44 AM
> To: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
> <yuji2.ishikawa@toshiba.co.jp>; Hans Verkuil <hverkuil@xs4all.nl>; Sakari
> Ailus <sakari.ailus@iki.fi>; Laurent Pinchart
> <laurent.pinchart@ideasonboard.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzk@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> iwamatsu nobuhiro(岩松 信洋 ○ＤＩＴＣ□ＤＩＴ○ＯＳＴ)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: oe-kbuild-all@lists.linux.dev; linux-media@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti
> Video Input Interface driver
> 
> Hi Yuji,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on media-tree/master] [also build test ERROR on
> linus/master sailus-media-tree/streams v6.4-rc7 next-20230620] [If your patch
> is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:
> https://github.com/intel-lab-lkp/linux/commits/Yuji-Ishikawa/dt-bindings-me
> dia-platform-visconti-Add-Toshiba-Visconti-Video-Input-Interface-bindings/20
> 230620-120839
> base:   git://linuxtv.org/media_tree.git master
> patch link:
> https://lore.kernel.org/r/20230620031111.3776-3-yuji2.ishikawa%40toshiba.co.j
> p
> patch subject: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti
> Video Input Interface driver
> config: i386-allyesconfig
> (https://download.01.org/0day-ci/archive/20230620/202306202308.y7ERKbSP
> -lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce:
> (https://download.01.org/0day-ci/archive/20230620/202306202308.y7ERKbSP
> -lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of the
> same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-kbuild-all/202306202308.y7ERKbSP-lkp@intel.
> | com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from ./usr/include/linux/visconti_viif.h:12,
>                     from <command-line>:
> >> usr/include/linux/videodev2.h:2464:41: error: field 'timestamp' has
> >> incomplete type
>     2464 |         struct timespec                 timestamp;
>          |                                         ^~~~~~~~~
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

I could not reproduce the error with the steps had been specified.

* archived config file didn't compile Visconti VIIF driver (at least, COMPILE_TEST is needed)
* the error message didn't appear even if I add some options to config file.
* Environment:
  * OS: Ubuntu 22.04
  * compiler: 12.1.0 (Ubuntu 12.1.0-2ubuntu1~22.04)

Regards,
Yuji Ishikawa

