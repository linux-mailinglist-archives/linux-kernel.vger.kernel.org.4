Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293CF74C93B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 02:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGJAW1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 Jul 2023 20:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGJAWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 20:22:24 -0400
Received: from mo-csw.securemx.jp (mo-csw1802.securemx.jp [210.130.202.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DEC11C;
        Sun,  9 Jul 2023 17:22:23 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 36A0Ljdv4147239; Mon, 10 Jul 2023 09:21:45 +0900
X-Iguazu-Qid: 2yAbM4uBQ6UkLREDuX
X-Iguazu-QSIG: v=2; s=0; t=1688948504; q=2yAbM4uBQ6UkLREDuX; m=GkUfndbugaAASDU/Fmfiz8uMqCr3mWZuso651d92Guc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1800) id 36A0LgDn4026213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Jul 2023 09:21:42 +0900
X-SA-MID: 4138425
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxMSud5ZC7nHwiMCPbtDJOIi5pNKoyiEt+hSBAnsuhGZc3ikrx6736gZ26q2a1uvpfhUbdEqmsMKEBdCVzOfCdOVoyAWIEZgSWzLOUMIOSfyKqdCtDDlbLTKpKiNGM8kD0+GUETFU313GBBAzBxXXtXfKswIjpTlPuf5aMs5LrP+D3gCb/VpAX9VygwjupkOaso4ivOA3YjW+8+LA/8apsMMvtMMmlo9TfA7lDI6NHFKZ5Fidz8jG/vuqJ+7L8ALvp4RfPnu4ZrfxCJczy1Cml2kpg9vMpYGJ6hyBfqzdBpWx0e4+SoptfDZ/xElpkUkqy1RdF3+sc7Lxn7BS2Ul1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+7fZVn+qbzPbO74jVBLgNJA2Mh218XUCosm4g6kezs=;
 b=JC339P13us1R/QUSL47h9HFY2bO9Aank7YqFSy4udTY5ZOIbeQzYE4ZMp/0Yh28nBAYMFnv4YzsDNPAv/RonLuyRGpbjtevaXPjiUedZqL7U8obfi+gqj1fcdZ+jVN0TTpO+KRi791qNnwYSVHjn4t9a+NjYE7pcxdo2v/9olRsl20CZd5A51gD5DT9E7Zu4vRvHQehgPn7b4+99l8Ryenr8IhpIDLemyHtYZueeoYoYrSnQnmQWCBy71pfJ1zQhhpblVSHVnPD03zUMj8fc/8mz6MYgG1ef5JvUANpb/MQuwrJ/Owr1r9j82tDDtI9BbSNrXuFC+GxUHM8xFdQf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <lkp@intel.com>, <hverkuil@xs4all.nl>, <sakari.ailus@iki.fi>,
        <laurent.pinchart@ideasonboard.com>, <mchehab@kernel.org>,
        <robh+dt@kernel.org>, <krzk@kernel.org>, <conor+dt@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>
CC:     <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Thread-Topic: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Thread-Index: AQHZoyT4WOl+YovnA0eMYN+ttqnJ/q+Tp1eAgB6ZWqA=
Date:   Mon, 10 Jul 2023 00:16:34 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB6201668A86ACD9794B2E3A5C9230A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230620031111.3776-3-yuji2.ishikawa@toshiba.co.jp>
 <202306202006.FUjZfd9O-lkp@intel.com>
In-Reply-To: <202306202006.FUjZfd9O-lkp@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|TY3PR01MB12119:EE_
x-ms-office365-filtering-correlation-id: 684cb3b4-ee85-4c75-dd62-08db80daeb69
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R4lmkbKaruL1FsOb6ISAHLhJeAovw43eVOZkTRNSTkodeVwiz2WywQQu16Xy8N6KQhJfaw2XdKSdMz7N+uVGBpApfJdB8/vxcN3EGGPfAg24Wk9CdfDc4GeQDZ1Ka7sSqY76xzWFdGtc3lhfLZarGtQIKmqOnI/F2G0pAbKCiGIFiZnNM4mEEF66L6EuuBux5rIhFBTepCTy4wjLsAT2dsTCBFbVpnTeuYkFpkT6MWNmxpaSOmxP47iyJ3T83zKC+87R6Gmd2ar2Hw9nhRCpCFb9gKwWsMHBtT86dq0Bi5lg1D4ey2pnVw35zEPFGvG7MTVqqpSJuN9nud1ZU4P1a94Ee549Q827rKouczQFJCE9vMfzR6J31ZSG55fVWaoDIsysTv++mynCgBr6g/IZUHN9JbkKu/sd7EZF7vTH6y/bNlf9X27/EkIXzmac+pdHKUVcdFc+ifA10cl32i8ECu0O2Yy4bp0O2mU6QkK5VLiytyz7JpswMhwp2bRlb5BsWB8f5wy2xI+laQIeEo43EoTvWt9y860+CzDJZtPDrtokCKclbNSnCiCBxXhuhe4nf/R1Nb7Ujio5Zct1Nsag0KUyqmOHAQ5THafk/nqribw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(186003)(26005)(6506007)(9686003)(53546011)(966005)(83380400001)(41300700001)(4326008)(6636002)(64756008)(66446008)(66476007)(316002)(2906002)(66556008)(52536014)(5660300002)(7416002)(8676002)(8936002)(66946007)(478600001)(7696005)(71200400001)(76116006)(110136005)(54906003)(55016003)(33656002)(122000001)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VENBK0VlUmJ0RCtNbGxaNGRkSG84TWk1TVZiVmthTks0RjJzU3l3elRZ?=
 =?iso-2022-jp?B?eVduQUpZcXpueGdSYXF3N2U0L09yV3hvRVZ4SkRZWWhjckM4a0NLU0dI?=
 =?iso-2022-jp?B?U05WRDVvQTViMHFlczhkSTA2cUFIOEZKTHdDYTBIYVo3WmNBRVFhUzNm?=
 =?iso-2022-jp?B?Uk5BekhXeUlaREorRXRTaFgvR2tDbjRqUWRMT2E0VWFpdEthczJ1Y0tC?=
 =?iso-2022-jp?B?Nk4vRU9MalJ1YlIwVENVcFNoY2NRcUVMd3NMbUszRE1OVWNCZEdYU0Jx?=
 =?iso-2022-jp?B?RFdMcFZFWFhyOWN3ZVBzNlhPdEJRUWoxZEROVGdiUy8rVDhjT3VLUXBW?=
 =?iso-2022-jp?B?bHQ3SjJzcWdSTlFNdjF3ckRPN2ZRNVJYRG5Sd0lkKy9lQWhBNEZvaEUw?=
 =?iso-2022-jp?B?c2Y5NlRGTGRJRlFQWDU2a2t2N2ZvbzloOEVoWEtWZ3Q1WE1maWVHTmxP?=
 =?iso-2022-jp?B?eGtlanN4MlpnM29QVzJnT1pGVEpjMFNlSnVpa2lrclVSdzEvd3pIbGNP?=
 =?iso-2022-jp?B?Q1I0My9pVEJ5V20vS3U2K2t3N2tqV2FSa3dQSm9nRE1idFo2YUJhcWZh?=
 =?iso-2022-jp?B?YkhkNjFJSHB2dTJaT2J2ekdUUHZtYmMxVHZ2WG9hOEcxSjN4THo4QmZO?=
 =?iso-2022-jp?B?dzF1dEVzN2hPU1R0YnpxSzk0LzlSazZNOFR1bXdmQ05uYWFoNFhlM3FM?=
 =?iso-2022-jp?B?VlJBNmc3QVhNZGVJcE1DVHVNRU83MVp6N3J0b2RFTzdQWFdmbUVqQlBo?=
 =?iso-2022-jp?B?UjZsZWdIMjA0SlZkK1JDaXhyenZpeUVQOFdneWhRMlZ5R21Fa1NMUUE5?=
 =?iso-2022-jp?B?cmxHSzVuQjBZL3BmOHVUaGJKaUtCaHpiQ1FFaDNiWFRBbjY3cU1vYnBS?=
 =?iso-2022-jp?B?QVVSOGVCNHcxclNQMDh3N3ZOVmx0bXVDeHFBeVF0eG1YSlV2cUNjS2RG?=
 =?iso-2022-jp?B?TWtrdDgvdmJQYVFsYS96b2puOHBLelUzTUZDVDFaNVNUR0VQMEJ6bVJZ?=
 =?iso-2022-jp?B?TFZoS01RRlprWjd3ZnlzYzYxeDVGYzRTdW0vSHVOVUx6ZURIaXBPRy95?=
 =?iso-2022-jp?B?ei9mcUo2WGNCbWp5VEUzQldnQ0dvT1FLQzAwa2JRVGNoVDhhL3VRTytZ?=
 =?iso-2022-jp?B?Ry9PY0dHYzBieXo1TGgrb0xJOE9PaUpDekV3Y2drR3BYb0pGbjNic0Ey?=
 =?iso-2022-jp?B?NjZlVmlUK21BSm5VM1V0TnovTFdzS0wyUkJpTEtOeHlxTWpZYkJsQ1lM?=
 =?iso-2022-jp?B?NWsyd0RDY01tQ1V0SGhXcldOUklEakthUFNOVkFXMDdGVWxGQklLYmdn?=
 =?iso-2022-jp?B?NzlVTm1aUFFPak1tQWhSQjV5c1loTVkzYk95b0QwKytvWUJ5ZndISmJo?=
 =?iso-2022-jp?B?akczRTlpQ3NpOE1KbU5kRVI0Ly8xa3pNWXpYeEVFSTVyRDVKT2tZcTBt?=
 =?iso-2022-jp?B?WTRqTm4rbTBjd3pzL2QzdDFNdE0xOEg5SWV0VlRHUU1YNmd3NSs4cHdp?=
 =?iso-2022-jp?B?c3M2NUpRSHJkTG10KzFiM2JXakFXQ05kT0FQc0E1ekJvUVdua01pQjhp?=
 =?iso-2022-jp?B?VDdtYk5qYW8xK3hFTDBtTVZIVEkyZWtQTEkwNlZNRklEMnRwVlZYNElH?=
 =?iso-2022-jp?B?VHJyT29TMS9tWXNVM2d3SUQ3WGlWczAxVXNqTERFem1QTVhkY1FlTEtC?=
 =?iso-2022-jp?B?Z25UYk14NkZzM1hrWGxXbHEyaDlEWGdpSHlBU0ZoLy9yN0ROLy9IdEdK?=
 =?iso-2022-jp?B?dEw0R1ZpUzc1QlBEcDNvanRNYUtMaDJYS3R5QXdib0pVT3lWWXAxbFZI?=
 =?iso-2022-jp?B?ejl2elN4enE0OVZhdE1tT1lWd1FrRTdyQVh1T1NOa28waDZCRWlwbjBt?=
 =?iso-2022-jp?B?S3FLQW5oSnhUOGtPNlMvL1lJeUViSEpneFk0K1lsczQ2ODR3cEJWSTNP?=
 =?iso-2022-jp?B?TVRWNDY5czRVYzRWUlphK0ZCMU5DZFRpZ3d6dVZvRldSRjllNW9PODJO?=
 =?iso-2022-jp?B?SnhyNy9xTjZHRTE1ODd5NHZIU0FmYlNUWVY1cVJGR2drdVd3ZEFXbjhH?=
 =?iso-2022-jp?B?TDFBU1EzZ00xL2RPeFdNY0JsSWp3VU5hSFpZdjdNQW43bXNxbUN4N2Fl?=
 =?iso-2022-jp?B?RkJoTWVZMkpEaitRdmpCK3NLdzdVWFBOZEZtSFl0eTJvUmFESkNNancy?=
 =?iso-2022-jp?B?RVRDNlFUdzhjTWtCaUR0bjY1eitKbGxjQTNaQm82NmVSR0ZvdHNKVkd2?=
 =?iso-2022-jp?B?Ly9EMTVkbnFwWUhiUWp3VFRJUnR4ZURrVEtpL2IwQlhVUmwwZXJsTGtU?=
 =?iso-2022-jp?B?dDNKRnl2K09ydVNUdWVNU2VwRkdHUmVtOFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?Q0JSRUNQajJ4ZDFiV1Y0NFZkQ3A4Ukd3QUhQTXFLNUR0RjhqODR4dHVx?=
 =?iso-2022-jp?B?OWVjQW0ydzNhQVF4NGZncXJNVjFPWGx2OWtUdGNuWmpOaDl2RFI0blZ2?=
 =?iso-2022-jp?B?dFZIc082cnJSbFlXTWFPQjJPM3FSNlZjU3I0SmtnR3FKSFZOUEdwdlAr?=
 =?iso-2022-jp?B?dFlIdU5rdWhKVVhaRjhHalhTL1BZNFhZanY1L2ZCVUVSbUtlMlZQbjRs?=
 =?iso-2022-jp?B?QlZXUjZuVG1DZUdvZkNRMWw1QzZhd0lRNzJmK2FpRGc4WnhIMGlwUHlt?=
 =?iso-2022-jp?B?clJ0MkplMHRYMTVDMFdWQlFSYXdmbjhnWEhCenRoaXFBT0dEWVIyN0s0?=
 =?iso-2022-jp?B?Qm0wYWtZN3JPaTM4cXBCSmtrY3BkeE5FeXdiYUo0Z2xqRFpuTXZhL0dS?=
 =?iso-2022-jp?B?SHBMNmRRZG1hdFlRVmNIclpxbXVNcHRrejA2aVNndkxTWFUzTHl5cWxC?=
 =?iso-2022-jp?B?QUNVc0oxa2paRno5YXR2VlR6UU1lUW9VTU5iR01xcnN5VG53QzZRWjRH?=
 =?iso-2022-jp?B?VFlHM2NtUDRNUEN4WDNqenNJVU5wdUlqaTZIYzNKVGs0cFdPdk1ybk1r?=
 =?iso-2022-jp?B?aFBpVVBUa1dleFVMWjB2Yk9uTGhRdFEvWGlYOUVuUkt3Yk9rTnptWkhn?=
 =?iso-2022-jp?B?UE1qa0taZm1RVkc5NU1KU25lUkJ2WllRREpDZm5QcFN4dWNCMG1YWlpO?=
 =?iso-2022-jp?B?a1htdFdpUFB5UEZ3enh5NHZNNnFZai9lSW9JRytFeHI1dkZTYmJEZjBa?=
 =?iso-2022-jp?B?UEN2ZTl5TStsbGJPMS9WcSt0UWVlbTc0QjhaZm5CTXJtNG9heDVBRTgz?=
 =?iso-2022-jp?B?NDZnNGsyOHlFd0pQdE5jcTUrd3hhazN1T2N6R0EwQlRwdTVpUkphUHJ5?=
 =?iso-2022-jp?B?VDE3elYydnIzdjd2NVplazNJTWdRWnE3TnE1cCt3OFVTSkpDUXpiOUUr?=
 =?iso-2022-jp?B?SHNIbXpXMGVpSTM2czl4NUxaWUp3ZkkrNkNSdnlneTJQVjFhQW9ZdFNo?=
 =?iso-2022-jp?B?WkFjZi9GY295TjBMVmhWMHFnK2dMeFNmTUdDRXdlUUFMYlNTZ2liTkoy?=
 =?iso-2022-jp?B?cGdXbTA5aDRtc20zVGRUS2Z0RW83Z0dKdVpFbHU5KzMyUG90NE1PUXRq?=
 =?iso-2022-jp?B?ckhSb2wvYldqUkFnVWpFN2hOd0t1bm90YkhWR2dsOWh3bzNQL21KR2xw?=
 =?iso-2022-jp?B?TWxGSTNsaGdYck5oN0hoNUpBR2h4SWlpaUxkUFBFU3UzTjB4Y3NmRVhs?=
 =?iso-2022-jp?B?RU9jRHJxRGg5dWIwcnYycUg0aTlPSnUzOTNQOUZKbGVKRE5BYmVSUW1r?=
 =?iso-2022-jp?B?TjJKSnIxTEpCNUhNdUk5WklmRFJudmhUQUxBcnk4Z2FySitXYzVVVVRN?=
 =?iso-2022-jp?B?VEpUcjg5NkgxYW1CeEhROHUvSFpnT2VyNFBtUCt6dTM0UXJoZ05kUG42?=
 =?iso-2022-jp?B?RWVHczRMMXc4UVFuOUdRbnZuTWd0UEZUb1pHUi9LNnNiRDVVUjVzY0Nl?=
 =?iso-2022-jp?B?bGJ3aTlZRzB0UXZ3UFdXVmc9?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684cb3b4-ee85-4c75-dd62-08db80daeb69
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 00:16:34.3419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRhQY+LqCBHNbGKLkqPML4pnUf8of6lw91jM1RXy8eQQHnNxABlmfs1FAv8/Kq/9ib8RAGDdziGTJVAhxKJephJ1lXObGqrhwfSAR6oq0Vc=
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
> Sent: Tuesday, June 20, 2023 9:58 PM
> To: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
> <yuji2.ishikawa@toshiba.co.jp>; Hans Verkuil <hverkuil@xs4all.nl>; Sakari
> Ailus <sakari.ailus@iki.fi>; Laurent Pinchart
> <laurent.pinchart@ideasonboard.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzk@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> iwamatsu nobuhiro(岩松 信洋 ○ＤＩＴＣ□ＤＩＴ○ＯＳＴ)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: llvm@lists.linux.dev; oe-kbuild-all@lists.linux.dev;
> linux-media@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
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
> config: x86_64-buildonly-randconfig-r001-20230620
> (https://download.01.org/0day-ci/archive/20230620/202306202006.FUjZfd9O-l
> kp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git
> 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce:
> (https://download.01.org/0day-ci/archive/20230620/202306202006.FUjZfd9O-l
> kp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of the
> same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-kbuild-all/202306202006.FUjZfd9O-lkp@intel.
> | com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from <built-in>:1:
>    In file included from ./usr/include/linux/visconti_viif.h:12:
> >> usr/include/linux/videodev2.h:2464:20: error: field has incomplete type
> 'struct timespec'
>            struct timespec                 timestamp;
>                                            ^
>    usr/include/linux/videodev2.h:2464:9: note: forward declaration of 'struct
> timespec'
>            struct timespec                 timestamp;
>                   ^
>    1 error generated.
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

I could not reproduce the error with the steps had been specified.

* archived config file didn't compile Visconti VIIF driver (at least, COMPILE_TEST is needed)
* the error message didn't appear even if I add some options to config file.
* Environment:
  * OS: Ubuntu 22.04
  * compiler: Ubuntu clang version 15.07

Regards,
Yuji Ishikawa

