Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6943874D194
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjGJJds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjGJJdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:33:19 -0400
Received: from mo-csw.securemx.jp (mo-csw1800.securemx.jp [210.130.202.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A2613D;
        Mon, 10 Jul 2023 02:31:42 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 36A9Ub7P2458262; Mon, 10 Jul 2023 18:30:38 +0900
X-Iguazu-Qid: 2yAbeDFf7wBXgMNGq2
X-Iguazu-QSIG: v=2; s=0; t=1688981437; q=2yAbeDFf7wBXgMNGq2; m=dL8vASbghvKefhAMjoh6zEvztNx4zV9DEmJyfaNdshk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1802) id 36A9UZn8752641
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Jul 2023 18:30:35 +0900
X-SA-MID: 3386341
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgCCZ9O9bmiGaacrfJLjcxgDK8K9UP79de8LKTpQ4tMctY/QKgEtlWknEMF/lUpvL6/VrE6c0njUSH7/tYT+hcRtpcZHx5nQtMJJQYUTLheLy8RPOcPpOO6G5JkhUnziYG/V6VFcxInAS5Vpt85x6hnkZyD8Sc/WMn1ftGVUHPicqtxPQCJr9/heiaTGlBi0Vq03HuSHmW+w6fFwyLQwd82z91NHZi9Xo/smQCUhyg+KoNSfkHrRAaGVYsqzWbGkBihaC0WFFRygRcaBxlKjoj9vQHLYBnGr4IxFNJmyx9ahfUtdoifatDhYE6X+sxgrLTzz5fnVLIUoCLH7ZMkfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjSCufANc1PJV52h4NhYYhr/qy9YuAEaG7QD6EAD+PU=;
 b=Q9Q4UHbK9C44eNh7QjWm7FLekwLAffQR9M70XbIES6vQGt7cHWDfaw3wcK6hMgclQsX4CMjTdzUzffpe0rCLXYsSPkxyNfEjGfUobTH1TbS4zlKx0DLsTsku+7YYlqSAAags/G2JYF+sq4Gh7rWxmWQDJQ/KQCILpxOvRQhos2Tivl2HsAZso28eVfUGXXuYlKG763kbEuRaVm/716SzmbMtNwlF1tckfLuE05gnLu1wA7limwQLdJRU8oOB+HbkUHZvtLvVGb/OpqBU7HzbAIWZVbGoD1+2OCRT3S/CyWH/SWeQ4fVF18L4LRtthfAw3pNO5LD2Bdd5VLmfCS530w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <krzysztof.kozlowski@linaro.org>, <lkp@intel.com>,
        <hverkuil@xs4all.nl>, <sakari.ailus@iki.fi>,
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
Thread-Index: AQHZoyT4WOl+YovnA0eMYN+ttqnJ/q+Tp1eAgB6ZWqCAAGIOgIAAM8Tg
Date:   Mon, 10 Jul 2023 09:25:30 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB62012AEB166A7D05AF3207F69230A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <20230620031111.3776-3-yuji2.ishikawa@toshiba.co.jp>
 <202306202006.FUjZfd9O-lkp@intel.com>
 <TYAPR01MB6201668A86ACD9794B2E3A5C9230A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <6251cf1b-6428-81e5-50b2-d65cd514063a@linaro.org>
In-Reply-To: <6251cf1b-6428-81e5-50b2-d65cd514063a@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6201:EE_|OSZPR01MB8219:EE_
x-ms-office365-filtering-correlation-id: 2f8425a8-f808-47dc-0d38-08db81279afb
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fGtXgw7Y1VWbJkUBSZAdlUFo3J8CNNSefRK/KuvEZAt53yAonGoydChIQhIE9zhHtB04FQygND578X/1kkrTQ2M39ihdXlb7Gjg5XUxNzQh5JYCQQGghLe0fcDo21zmgrNHcD7/a99mlMY7igLX4ZT+RG2TF7cDObTsVOKdwEdU0MS9YA+9D2fBZ+qH8Rp0SeZEAz3nPIcU4uL2XNXIWrupfzzymTUaYK3BFU9ojFaqo5AMQ4fwCQ0wfdD2Qh+QdbA08AwCOx25KgSxqnqMZSDr6I9sWyYkooshykLs0gkGX/TaUBRt8aTqK/KaA6wUZ67FS/+U8XFirxG8YZ0q1aYlOnRpyiNDZw2JcUVadG35ri14T1ddtiuJSsmyQT4G9QZJfqTDP7FcmmdCzO7czG9VVfhJpLZ9YapSBlDeqXNqSkXrWiZgFhmVuG1Mr/ISxECf1uXO2r1jF+VDVPt1aktuKM8nGdqqzoGuSOocdI9uUULd1U7oDkr/t+YpCJYnfQ9SbEHToGMwHhBqTY6X2re8MZsktc5jYxwKPJk3i9kbSQ3kFxT/daeOPE5p/AOw0lVf4PyyoyhTR9CFSXHBHIK+yVOzRp2/SSYIkeZuLYx/Nhf2ZkhB0KsMOd8TlNDPU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(7696005)(478600001)(76116006)(110136005)(54906003)(71200400001)(83380400001)(38070700005)(33656002)(86362001)(55016003)(2906002)(66946007)(26005)(53546011)(6506007)(186003)(9686003)(966005)(38100700002)(122000001)(921005)(8676002)(64756008)(6636002)(4326008)(66446008)(5660300002)(316002)(66556008)(66476007)(41300700001)(8936002)(52536014)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RklFRms3M0FUOGFlZXpudU95WlpscnlmTGJGRWRnbnp5YU55aXpvM3gvWnBJ?=
 =?utf-8?B?NVI1MXo0Nm5VMXZna1c1MkdEQmlNV2pQWC9NamVTRmcwRDFWOTduZFRvaXRV?=
 =?utf-8?B?QnBtWm9QV3dXeHMyNm5qL0FDa1FCWk1uNnJJVWNhSE5KT3B0YTltZnpQcUYz?=
 =?utf-8?B?RHQybnRQTjRscmV2K1NSc1FYVEg5bzRpMDZrNWJXSFkyaVI3UEIwU3UxNmFn?=
 =?utf-8?B?S3M2U2o4MUpMZndvVVQxVGRMOXQ2bVhDYlA0OUxGeXpvcVlIT2JPdHMxN01Z?=
 =?utf-8?B?bDNzUFZPRlorMmh4QmluTkpFU29lSDdCSmZFbUl6U3ZKM3J6NkdKV3dMbVNJ?=
 =?utf-8?B?UVRiTzJmQndJNnBSYWZIbEt0Q2dqZEVYYlFhMXNNU0NPbW9SZFA3UXJMNWpF?=
 =?utf-8?B?MGVSS3U5OU85djUrL2paSUJuWlkxM2JibjVKYWYvRjB6QWNBRDdrOG9yMFlW?=
 =?utf-8?B?SlN5NHVxRHhEaUxDVllTUHhSUEs4Rko0N05hT3dGS2ZDT2ZKL3VUR3Q1M211?=
 =?utf-8?B?UHhOSGtORGxSYyswOE9CS1ZxYkNDck9NbGk5ZVZDNEFpT1lrbXVJOWNQRnls?=
 =?utf-8?B?eW1WTisrYWE2elJOM2l2czlJLzhOQ29WM0hqcEhPNlE5dHJNWFJSelc4M0dO?=
 =?utf-8?B?bElFb25SZ0lNdHdwTTAyb2M0MWlWU3JGVDlYMGNDcjF1c0hFa3FiWnFtZUhZ?=
 =?utf-8?B?cFVwNVAwS2JnTmk0Y1kreVdzNEtiSXJXRDZsaUpqMGpxNFBwNGlHWUtCbzhK?=
 =?utf-8?B?OTBiSTJFZDZxWisxN2t3NjlvRktBZmErRXlXRXNTbEZFRFJYVVV4QWtQcWVG?=
 =?utf-8?B?Zk51K2x6WlVxUXZtQzYvY0VWa3lDZzROU09YRmVPTEVMUFFQcTBWaWxWNDVr?=
 =?utf-8?B?MVJoQlYwNWxmblNUcnAyaUdwdVFRbXEyekliQ2RPa004R1BQcjVBVzN2VHRw?=
 =?utf-8?B?bDZnSU1Na1pWUjI0UmZpblVwaEFXMGdtRE5pNHJvU1NhVFl4UCtzZHBoUXBt?=
 =?utf-8?B?d1p2QUxmak1mb2lnczNVT05ldCtlbTZUeHJjaWVWTXMyZitqbzA4WkpEL3ps?=
 =?utf-8?B?dzMvcGdpUHdiMjNZTVJhTm5MYzd4YmJJQi9HSVZvdzVJcUE1RGQrN1FXZ1Np?=
 =?utf-8?B?RTZUTklLeFlZVlZibGhFMTJrNjFSSFNyT3lZVWxDcW1XYjhqV29URzFoeFRC?=
 =?utf-8?B?T2Z4eTVLcHU4Y2tMUEVSSU1vMDdyZzVOdG5KZVRqajlhRnVGa0s2RjlwR05G?=
 =?utf-8?B?d2Z4cGhMNUFQY2tscTdzcGFqQ01yYnYxemIzbm5ZOWZRZG53Q2RwZkFWdE45?=
 =?utf-8?B?dlJTbHJhVE1xNmFMTXBLUVpIeTltNkNsZVJYbTU4UTlnWXpTR3pZemFXbVVl?=
 =?utf-8?B?MEVEOUZpNWhPdmNxdGtoYk9TaWlDbnFlTFZ1NjZxM2NkWlNZSW1hKzhsOXlB?=
 =?utf-8?B?NXVsS1BLMjJxdzBKVnF2K1E0TkZzOElxQkNIbHB1T0JTNDh0YnNpSFhUaTRx?=
 =?utf-8?B?UjJldDRwcnhPT2NCRUU4NkQ1NzIva2ZmaHBVYStXNHRYSHk0V2FFQm1XZHU0?=
 =?utf-8?B?RldRZVh2QW4zNFljalJwQ1RnTzM5Qmh0ajk1ZlBLODFpWHNPUUMxblNoQ0R4?=
 =?utf-8?B?YVpUK29rK3RGM0k1ZkxldWlPUlBJK3Y3OHZXUnBLK24wTndlMmczQkd0N2w3?=
 =?utf-8?B?cEpTK2JBVEIxS3lxVCtPYTNLcW8zQVZIOElhQUNpRk9kcHRaMC9TdS9nQVA3?=
 =?utf-8?B?QVF3K2FRUGZub1lBYjJGVnUvbm96TjFxM0gzWTA3R3c2WkV0R3VGWmlNblIv?=
 =?utf-8?B?b2wveXpxT1hmRmRpWlFhbVBUTzJ2UDJXdmFPSGFhUTNyaE1MdVB0aEZ4OFU1?=
 =?utf-8?B?ZHdXeFZuelJtQzZ2d0tzY3NGMzh1bFVZTHkyZ1JlV0dzN2NQM0RaTkpDeU84?=
 =?utf-8?B?SmFGSmtjSk1vS0VmOFhDY1VjWFpXckM5Ykc5dmZWcWJOY01abHRDM2pCSXI4?=
 =?utf-8?B?RnJDNjdUME9qaW9tVXN6Tnd4QkpUbDJmZStWZWRjMEJlL1A4ZzhTRzJCNXlo?=
 =?utf-8?B?TG5HeXg2cVJBazBRTGxyVzNCWnMwVmF1ZjhaTVp2TU1xakpjRU9zc3prZTNp?=
 =?utf-8?B?L2Zwc25TOGFSQWkySmI2ZitSWkllRno3Y2dKamhFY1AvMkZqcHY1enBmbTFp?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cFJrSkR4TW1WSWRVWSsrNno4MkNRUk84QTRlYjBTcnVNQTBidDlIYy96MGZo?=
 =?utf-8?B?WHNXUGJVQ1hsQVRXYXdkKzhxanNhME5ieGVGM09qa0VLd0UrV0lmVk9OYWFa?=
 =?utf-8?B?Vk1DQ21yV1JkdGRkdTlCRkxIcldKWk1wenNDV2tYdjcvbmFHRzhmMFVNbysr?=
 =?utf-8?B?SEEwaUd0aEJ1MzdyZlJGZFJ6aDdKYVRocndaNFd5L0dkUzZ5WHVnUnRoRnc2?=
 =?utf-8?B?RHZjaFFzN3BlL3lGdGphdDhZeUtTbXlKdHNJRlVyMzhzN1BLUFA0U3pUQkk2?=
 =?utf-8?B?VnNLQ3dQSkc3SGpqdkljSzBWNWx4MWQvZ1RKQUg2cXlkbDhtNlFjNGpabVYx?=
 =?utf-8?B?cGQwbkdPMTRFS29vU21CS2Q2NEZrYVBvcHE3b0N5cm1QVUNrd2loRm9YTXRD?=
 =?utf-8?B?TlMralprb3NSeTE0UzhrNGhMam92RmhYT2dMN3Y5bXBDUE5IWVJPKzFPNm5H?=
 =?utf-8?B?YTJQU2hma0hMQWM5ODdZMGk0WExFME80cDZYSzFWNDMzTkxsM2NPUVRCV1cw?=
 =?utf-8?B?WVRrSGpwbzlVakJlc1hiQWZnWHpmY3VLTUZVWUhkU0Ixb0t4NVJLbkZjUUcx?=
 =?utf-8?B?UXlpeHBqRmVKYmVqU1dkYUhvaVpZWnNYbkxPVFJWNlM3UklqeW1KRjRmR1Z2?=
 =?utf-8?B?Si9MbFEzOUFYTmJjRXltWG5rM1E4TWFON1p3NGdtaE5QN2FmQktsZFdkSXFx?=
 =?utf-8?B?UExjbzIyMUdPcFlQWGhnL0V5MWxscG9OQlMySmEzZ0lDNmRCbXR0RnF0RFpm?=
 =?utf-8?B?QTk4TXBTUFY1S2R6cWxmS2dSTmFkYUFmL3VCWUpIYVFVVEtCUURnZW1PQldU?=
 =?utf-8?B?SnI0VE4vVVc1WUdyeEl4YnROc1BnME5GVXRYbnNsQWpqcHFCd1N0elc4MW1K?=
 =?utf-8?B?N1FKRUl3NGxZTmhCNGxaaWVvbTFwd1RMUFlrd2IxSmJmQkhNKzJCSGU1ZHQ3?=
 =?utf-8?B?VWVDeDhaU2FCYStYTVNobmtwQ1VFV1lpWmNLamQ3YW4zYzZhWGtVVU5zb0d0?=
 =?utf-8?B?T2V0emJ3WnFMbzJQM1d4SHV2Z01ocnZOK2FQLzBGWHRObmhENTFiM3B6YzZu?=
 =?utf-8?B?c3NUditRa1dqVUtmVVVieElLRXFCREdYN1ozZnVuYmtjZXowaDhtWkVELzY4?=
 =?utf-8?B?bzQ5WUk4K1FKU2ovck9VZzhMUXc1ZmYyOGgxMTJYMUJhZ2JJTitveER5THda?=
 =?utf-8?B?c2J3SlFRalFhSm5YN2xBOXpyL0EzaGxBRjl5WktWNTFUNm95ZHVpWURnRURN?=
 =?utf-8?B?QnlsZCtXWWtHN0xKWVU3UzMzbTB1MnRNanBFUkJLYk91c0Q5dEIwUmdUdmpB?=
 =?utf-8?B?WlRkd0VNb1FRdFdZT3lHM25nVkFmNDBlT0xNNTNjM1ZoaFdGQ3dobXNEdy9s?=
 =?utf-8?B?NndwMks1b2c2SFJQZnR1SnZYYzlJaGszZ1B0ZEVPZithUGNhTk1MR1o1ZHlx?=
 =?utf-8?Q?itpbON7W?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8425a8-f808-47dc-0d38-08db81279afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 09:25:30.6462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55WgWbic8/YnlpRumgG71y344dOC48/DppK11Td2d5+T70R0tN5O3rA8xxE3azZ72HwVXUJkeg17CqYh69dy9IPO6g2tWc0REf9aQ6WenQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8219
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSAx
MCwgMjAyMyAzOjA1IFBNDQo+IFRvOiBpc2hpa2F3YSB5dWppKOefs+W3nSDmgqDlj7gg4peL77yy
77yk77yj4pah77yh77yp77y077yj4peL77yl77yh6ZaLKQ0KPiA8eXVqaTIuaXNoaWthd2FAdG9z
aGliYS5jby5qcD47IGxrcEBpbnRlbC5jb207IGh2ZXJrdWlsQHhzNGFsbC5ubDsNCj4gc2FrYXJp
LmFpbHVzQGlraS5maTsgbGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tOyBtY2hlaGFi
QGtlcm5lbC5vcmc7DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6a0BrZXJuZWwub3JnOyBjb25v
citkdEBrZXJuZWwub3JnOyBpd2FtYXRzdQ0KPiBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKXi++8
pO+8qe+8tO+8o+KWoe+8pO+8qe+8tOKXi++8r++8s++8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRz
dUB0b3NoaWJhLmNvLmpwPg0KPiBDYzogbGx2bUBsaXN0cy5saW51eC5kZXY7IG9lLWtidWlsZC1h
bGxAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NiAyLzVdIG1lZGlhOiBwbGF0Zm9ybTogdmlzY29udGk6IEFkZCBUb3NoaWJhIFZpc2NvbnRp
DQo+IFZpZGVvIElucHV0IEludGVyZmFjZSBkcml2ZXINCj4gDQo+IE9uIDEwLzA3LzIwMjMgMDI6
MTYsIHl1amkyLmlzaGlrYXdhQHRvc2hpYmEuY28uanAgd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwu
Y29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBKdW5lIDIwLCAyMDIzIDk6NTggUE0NCj4gPj4gVG86
IGlzaGlrYXdhIHl1amko55+z5bedIOaCoOWPuCDil4vvvLLvvKTvvKPilqHvvKHvvKnvvLTvvKPi
l4vvvKXvvKHplospDQo+ID4+IDx5dWppMi5pc2hpa2F3YUB0b3NoaWJhLmNvLmpwPjsgSGFucyBW
ZXJrdWlsIDxodmVya3VpbEB4czRhbGwubmw+Ow0KPiA+PiBTYWthcmkgQWlsdXMgPHNha2FyaS5h
aWx1c0Bpa2kuZmk+OyBMYXVyZW50IFBpbmNoYXJ0DQo+ID4+IDxsYXVyZW50LnBpbmNoYXJ0QGlk
ZWFzb25ib2FyZC5jb20+OyBNYXVybyBDYXJ2YWxobyBDaGVoYWINCj4gPj4gPG1jaGVoYWJAa2Vy
bmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4g
Pj4gS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtl
cm5lbC5vcmc+Ow0KPiA+PiBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKXi++8pO+8
qe+8tO+8o+KWoe+8pO+8qe+8tOKXi++8r++8s++8tCkNCj4gPj4gPG5vYnVoaXJvMS5pd2FtYXRz
dUB0b3NoaWJhLmNvLmpwPg0KPiA+PiBDYzogbGx2bUBsaXN0cy5saW51eC5kZXY7IG9lLWtidWls
ZC1hbGxAbGlzdHMubGludXguZGV2Ow0KPiA+PiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NiAyLzVdIG1lZGlhOiBwbGF0Zm9ybTogdmlzY29udGk6IEFkZCBUb3No
aWJhDQo+ID4+IFZpc2NvbnRpIFZpZGVvIElucHV0IEludGVyZmFjZSBkcml2ZXINCj4gPj4NCj4g
Pj4gSGkgWXVqaSwNCj4gPj4NCj4gPj4ga2VybmVsIHRlc3Qgcm9ib3Qgbm90aWNlZCB0aGUgZm9s
bG93aW5nIGJ1aWxkIGVycm9yczoNCj4gPj4NCj4gPj4gW2F1dG8gYnVpbGQgdGVzdCBFUlJPUiBv
biBtZWRpYS10cmVlL21hc3Rlcl0gW2Fsc28gYnVpbGQgdGVzdCBFUlJPUg0KPiA+PiBvbiBsaW51
cy9tYXN0ZXIgc2FpbHVzLW1lZGlhLXRyZWUvc3RyZWFtcyB2Ni40LXJjNyBuZXh0LTIwMjMwNjIw
XSBbSWYNCj4gPj4geW91ciBwYXRjaCBpcyBhcHBsaWVkIHRvIHRoZSB3cm9uZyBnaXQgdHJlZSwg
a2luZGx5IGRyb3AgdXMgYSBub3RlLg0KPiA+PiBBbmQgd2hlbiBzdWJtaXR0aW5nIHBhdGNoLCB3
ZSBzdWdnZXN0IHRvIHVzZSAnLS1iYXNlJyBhcyBkb2N1bWVudGVkDQo+ID4+IGluIGh0dHBzOi8v
Z2l0LXNjbS5jb20vZG9jcy9naXQtZm9ybWF0LXBhdGNoI19iYXNlX3RyZWVfaW5mb3JtYXRpb25d
DQo+ID4+DQo+ID4+IHVybDoNCj4gPj4gaHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxhYi1sa3Av
bGludXgvY29tbWl0cy9ZdWppLUlzaGlrYXdhL2R0LWJpbmRpDQo+ID4+IG5ncy1tZQ0KPiA+PiBk
aWEtcGxhdGZvcm0tdmlzY29udGktQWRkLVRvc2hpYmEtVmlzY29udGktVmlkZW8tSW5wdXQtSW50
ZXJmYWNlLWJpbmQNCj4gPj4gaW5ncy8yMA0KPiA+PiAyMzA2MjAtMTIwODM5DQo+ID4+IGJhc2U6
ICAgZ2l0Oi8vbGludXh0di5vcmcvbWVkaWFfdHJlZS5naXQgbWFzdGVyDQo+ID4+IHBhdGNoIGxp
bms6DQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMzA2MjAwMzExMTEuMzc3Ni0z
LXl1amkyLmlzaGlrYXdhJTQwdG9zaA0KPiA+PiBpYmEuY28uag0KPiA+PiBwDQo+ID4+IHBhdGNo
IHN1YmplY3Q6IFtQQVRDSCB2NiAyLzVdIG1lZGlhOiBwbGF0Zm9ybTogdmlzY29udGk6IEFkZCBU
b3NoaWJhDQo+ID4+IFZpc2NvbnRpIFZpZGVvIElucHV0IEludGVyZmFjZSBkcml2ZXINCj4gPj4g
Y29uZmlnOiB4ODZfNjQtYnVpbGRvbmx5LXJhbmRjb25maWctcjAwMS0yMDIzMDYyMA0KPiA+PiAo
aHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjMwNjIwLzIwMjMwNjIw
MjAwNi5GVWpaZmQNCj4gPj4gOU8tbA0KPiA+PiBrcEBpbnRlbC5jb20vY29uZmlnKQ0KPiA+PiBj
b21waWxlcjogY2xhbmcgdmVyc2lvbiAxNS4wLjcNCj4gPj4gKGh0dHBzOi8vZ2l0aHViLmNvbS9s
bHZtL2xsdm0tcHJvamVjdC5naXQNCj4gPj4gOGRmZGNjN2I3YmY2NjgzNGE3NjFiZDhkZTQ0NTg0
MGVmNjhlNGQxYSkNCj4gPj4gcmVwcm9kdWNlOg0KPiA+PiAoaHR0cHM6Ly9kb3dubG9hZC4wMS5v
cmcvMGRheS1jaS9hcmNoaXZlLzIwMjMwNjIwLzIwMjMwNjIwMjAwNi5GVWpaZmQNCj4gPj4gOU8t
bA0KPiA+PiBrcEBpbnRlbC5jb20vcmVwcm9kdWNlKQ0KPiA+Pg0KPiA+PiBJZiB5b3UgZml4IHRo
ZSBpc3N1ZSBpbiBhIHNlcGFyYXRlIHBhdGNoL2NvbW1pdCAoaS5lLiBub3QganVzdCBhIG5ldw0K
PiA+PiB2ZXJzaW9uIG9mIHRoZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93
aW5nIHRhZ3MNCj4gPj4gfCBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRl
bC5jb20+DQo+ID4+IHwgQ2xvc2VzOg0KPiA+PiB8IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29l
LWtidWlsZC1hbGwvMjAyMzA2MjAyMDA2LkZValpmZDlPLWxrcEBpbnRlbC4NCj4gPj4gfCBjb20v
DQo+ID4+DQo+ID4+IEFsbCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4gPj4N
Cj4gPj4gICAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIDxidWlsdC1pbj46MToNCj4gPj4gICAgSW4g
ZmlsZSBpbmNsdWRlZCBmcm9tIC4vdXNyL2luY2x1ZGUvbGludXgvdmlzY29udGlfdmlpZi5oOjEy
Og0KPiA+Pj4+IHVzci9pbmNsdWRlL2xpbnV4L3ZpZGVvZGV2Mi5oOjI0NjQ6MjA6IGVycm9yOiBm
aWVsZCBoYXMgaW5jb21wbGV0ZQ0KPiA+Pj4+IHR5cGUNCj4gPj4gJ3N0cnVjdCB0aW1lc3BlYycN
Cj4gPj4gICAgICAgICAgICBzdHJ1Y3QgdGltZXNwZWMgICAgICAgICAgICAgICAgIHRpbWVzdGFt
cDsNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4g
Pj4gICAgdXNyL2luY2x1ZGUvbGludXgvdmlkZW9kZXYyLmg6MjQ2NDo5OiBub3RlOiBmb3J3YXJk
IGRlY2xhcmF0aW9uIG9mDQo+ID4+ICdzdHJ1Y3QgdGltZXNwZWMnDQo+ID4+ICAgICAgICAgICAg
c3RydWN0IHRpbWVzcGVjICAgICAgICAgICAgICAgICB0aW1lc3RhbXA7DQo+ID4+ICAgICAgICAg
ICAgICAgICAgIF4NCj4gPj4gICAgMSBlcnJvciBnZW5lcmF0ZWQuDQo+ID4+DQo+ID4+IC0tDQo+
ID4+IDAtREFZIENJIEtlcm5lbCBUZXN0IFNlcnZpY2UNCj4gPj4gaHR0cHM6Ly9naXRodWIuY29t
L2ludGVsL2xrcC10ZXN0cy93aWtpDQo+ID4NCj4gPiBJIGNvdWxkIG5vdCByZXByb2R1Y2UgdGhl
IGVycm9yIHdpdGggdGhlIHN0ZXBzIGhhZCBiZWVuIHNwZWNpZmllZC4NCj4gPg0KPiA+ICogYXJj
aGl2ZWQgY29uZmlnIGZpbGUgZGlkbid0IGNvbXBpbGUgVmlzY29udGkgVklJRiBkcml2ZXIgKGF0
IGxlYXN0LA0KPiA+IENPTVBJTEVfVEVTVCBpcyBuZWVkZWQpDQo+IA0KPiBUaGF0J3Mgbm90IHRy
dWUuIFRoZSBjb25maWcgaGFzIGVuYWJsZWQgQ09ORklHX1ZJREVPX1ZJU0NPTlRJX1ZJSUYsIHNv
IHlvdXINCj4gcmVwcm9kdWN0aW9uIHN0ZXBzIHdlcmUgbm90IGNvcnJlY3QgKGUuZy4gd3Jvbmcg
YXJjaCwgY29tcGlsZXIgZXRjKS4NCj4gDQo+ID4gKiB0aGUgZXJyb3IgbWVzc2FnZSBkaWRuJ3Qg
YXBwZWFyIGV2ZW4gaWYgSSBhZGQgc29tZSBvcHRpb25zIHRvIGNvbmZpZyBmaWxlLg0KPiA+ICog
RW52aXJvbm1lbnQ6DQo+ID4gICAqIE9TOiBVYnVudHUgMjIuMDQNCj4gPiAgICogY29tcGlsZXI6
IFVidW50dSBjbGFuZyB2ZXJzaW9uIDE1LjA3DQo+IA0KPiBEaWZmZXJlbnQgY29tcGlsZXJzIGNh
biBoYXZlIGhhdmUgb3Igbm90IGhhdmUgd2FybmluZ3MsIGJ1dCBpdCBkb2VzIG5vdCBhbGxvdyB0
bw0KPiBpZ25vcmUgdGhpcyB3YXJuaW5nLiBZb3UgY2FuIGFuYWx5emUgdGhlIGNvZGUgZXZlbiB3
aXRob3V0IHJlcHJvZHVjaW5nIGl0LCBpZiB0aGUNCj4gcmVwcm9kdWN0aW9uIGlzIGEgcHJvYmxl
bS4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNClRoYW5rIHlvdSBmb3IgeW91
ciBhZHZpY2UsIEkgZmluYWxseSByZXByb2R1Y2VkIHRoZSBlcnJvciBtZXNzYWdlLg0KVGhlIG1l
c3NhZ2UgaXMgaXNzdWVkIGJ5IEhEUlRFU1QgcHJvY2VzcyAobm90IGJ5IENDIG9yIEFSKSwgdGhl
cmVmb3JlLCB3ZSBkb24ndCBuZWVkIHRvIHNldCBWaXNjb250aSByZWxhdGVkIG9wdGlvbnMgdG8g
Y29uZmlnLg0KVGhlIGZpeCB3aWxsIGJlIGluY2x1ZGVkIGluIHY3IHBhdGNoLg0KDQpCZXN0IHJl
Z2FyZHMsDQpZdWppIElzaGlrYXdhDQo=

