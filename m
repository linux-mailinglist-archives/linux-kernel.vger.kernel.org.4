Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BC15ED613
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiI1H3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiI1H3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:29:11 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83874F6B1;
        Wed, 28 Sep 2022 00:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664350122; x=1695886122;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=CXIaMRc23qeD93JS3lnOFUCC2hGjC2+m33aVAxYQ4blHyZNjeZXWGJMV
   KRlhTZ0Ouu4/d931VIxgQ9M5YqYVnTz9vrDwyuUueQEFzzGZfKB3qiVtu
   hKOcdRcAjAdeF6vmulxbeQiEydJEX/abXfHVJj5IW/3jx70D1l4eb3qpu
   3DN8mZWpzta9kl4fx3yxnMwErBUY+utmqglgqsJCxvDIRZgeC6981M3aq
   ZmMVf2mJNXywlrlgs2xXzr23+19KUROiJ7vQRcEz4Ax/JP4eJY7z+kvnI
   Ru+5H/dpOiEbVQ7URM2KxiryY19kyfFq8FhdXugxSiBJ5Da+3plFy4MU3
   g==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654531200"; 
   d="scan'208";a="217644420"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 15:25:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTe5D0FI8+rbqVBeJHlMNZ0DyM9pxLD9LArXtJTXnvpPlbS2ymv0B8+/iSWSOEoA/+pnfaM5ntr9QdSFCST0b+BNoYqF0gibqPrTk/cndffv+3mTPh/EnDSeFKp5xhjUN6DbSBjzkICrAbXCsBs2a6ISaOzb9wpgQaiywrKnfX/2QVwvFN9LKVIeZV5TjVEBTXIxU5xzgf2HMKmA4niE0dc/zX8TFcq88EiTC5hdk29TO2Ge6LLIBacExxPJB1WfOUMB78mrou8zQ3HACPTFje0EMxhHCuGBw7O9gt+17efEuF58G1JlrJCOJIZ/K/XM5OBURXPts6jGlI6xX7pNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Wsorpja+bijJo9Havuwv0JrDjX/500Iegu6jrd77eLFBlTjV/m6VtEIonKgROzmQVq2ZdRf1RYbLUDClV9EKIud8mOAMo6hsnj9kdN45RIHdAKOdsbtKVEqh29xuArmyloYsbAkevOFHZS/C0FL6nATeBoKUO/uRfqK6HBtHCvlitDGpd/fUCLP4eYrO2n4GQhiYz7LjGa83WifdlS29b2leZ/deFEESVDlIg1SEB9M1xutFq+hjpTVapQwX4R3Ad4dP3B0UKA6+fj4K4pYROzUKXSOs2Sg5GR7qHVRqus4nqhkHeLuuSqRWfAjuPgtaYIrnIIe11zSCNfqNNNbDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QGqGr8In5AwLtEszV29563oTntZWMoLI2j0jnp/NeptTgK8x3KEIjuCnI76zEZhEr53jmgF5bQTEuasiF/P7ZzExd6K9UPgu3ot5PCWVGvFrUAzfhFXvlSNc1/feE1nzr/iyXETEenmYhge1arX9F6EBr9x/5ghtq5AivauqPA4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4487.namprd04.prod.outlook.com (2603:10b6:a03:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 07:25:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 07:25:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jason Yan <yanaijie@huawei.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v6 1/8] scsi: libsas: introduce sas address comparison
 helpers
Thread-Topic: [PATCH v6 1/8] scsi: libsas: introduce sas address comparison
 helpers
Thread-Index: AQHY0wUdCbAPYokfDUSc9Q0fslxNTQ==
Date:   Wed, 28 Sep 2022 07:25:27 +0000
Message-ID: <PH0PR04MB74168723BAFB3EC8315A60E59B549@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220928070130.3657183-1-yanaijie@huawei.com>
 <20220928070130.3657183-2-yanaijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB4487:EE_
x-ms-office365-filtering-correlation-id: accce21b-5453-453e-bfba-08daa1229dfe
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hzFB5y4SdRXR9U8PiVZXec45wvpMX7kvRHvJcDSAUPy5/sRtoVDk2q4FZ8+6TZMjNooHEdr2mOKpvfbeLxjAfHRkX9ulOA5ouuEt7WSTqumxLlFY3PggQ0rCgI6dP1mLkAmArVBdWvEOQqFUmLfzOcBBpZP6YHwWCQm6mMk5jwghUAXtK4UIe2rJV6Tq5rmFR5ZV6iiPGJgI+XSCY8Ng/dxucQRjb52DydQZ5S1zq0Ihx8BJfvGQT/VruyNowa6Lvbdigm71m1KG3zl/N9UPtmU4aM8+Zn+S0ttz7QbWrHQsfJf+RtSsNdvh9E7qpm5c+GIC8LicsTaj/DSSalIGb+AL+AiI+U1215iFzcI9xaOb9WRi784XzsrOJ583eGjG8q53v35dAGzOXha2Xv28oRCKNX9MZdffKJwLT1IPFbI7un0bM4U1OuLJ9TPuuceosr40j14YiDkcZUFjQLiZePrrunGMXjA1QyfkYrRQjScCp6xgv0bMNEd7kz4YZDInYPedGDTaJVLcbAYapNJ9LXfcMdWTGRvgxuGB96wZgK1L4odcivt+vzqXPue488mpjH+tscZuUzG8Dz8+ZEH9TRt31FxaRw2o/7zCxG866bGTMMYuhHvJwulFFnNGA9SRek01ZCGzyThksiqcL0APLZZ9kr8L+srFnjf1/CiwTs374NSbd7E3Ayx/wwaOU24RXJpcWniCXgEE/I+gg/3+frP3YEKya7MpkXsHPFqR6qpuivpMCP4X1gF2P6IN92HhNBG1TLKA1gMpQ9itshCcDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(71200400001)(55016003)(86362001)(110136005)(316002)(54906003)(66946007)(7696005)(9686003)(82960400001)(8936002)(52536014)(2906002)(19618925003)(33656002)(8676002)(66446008)(64756008)(4326008)(6506007)(91956017)(38070700005)(478600001)(66556008)(66476007)(76116006)(186003)(41300700001)(5660300002)(38100700002)(122000001)(4270600006)(7416002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ryjxbrd/yYhM1WWq0M2TxR/bRB76V3ejAQhHA2/JfUxw2fHwU1SlU1rg0x6y?=
 =?us-ascii?Q?Os8jx04AXxCEpdiFIXeE2+CTUVXgPkmenVOr6zbzaYZ7kZxzYGWPP7D6DC6a?=
 =?us-ascii?Q?AWgGCsOUt2mQtsPDACMJwGl+dtSI4QzrAgLcFvU81JVe6r+mYcIy8nmN0Sok?=
 =?us-ascii?Q?GR9AXnxZGrTWd79PqgUjuef2zrac79hWOvwB8StZxAhCPw+BmiVCklc+G+5N?=
 =?us-ascii?Q?V9l22JkCrw9SlpvuiGmp8qFqc889xNtr/9uzN74XqJDlf91LW0I+6hH8U6cw?=
 =?us-ascii?Q?nBToUyVhpr5kSffdfayXRhcYk7KEdradooC0Efk5CshKIJZtCncjfbfHVv2f?=
 =?us-ascii?Q?Hw6Swb0DyVDr1SXlietryZgK32u2LYoif5Ya7/CDHSAopu82CwFzcZiRmXP9?=
 =?us-ascii?Q?mlygwDGHBs0zd4SATS5Aypcf4k+WYumNhRRiGryplfeprogaZnm9fNJtx1aO?=
 =?us-ascii?Q?7u7rh1Qkox0JtW4PvWMFjqVVcEYAbSNJtIdR6/fIifowkl4rw6CV0hKubRD2?=
 =?us-ascii?Q?RrFMedAYNLOn0wg1vRviZOnn4BQhkjLvwgee82KymwElOHD6llAtsum4nbPB?=
 =?us-ascii?Q?HtcexA5k5fneuv7NhsA/EOdRPuxQ0nZFS5omL55nqkTGRQrcwYfJUa8zQ3iN?=
 =?us-ascii?Q?HrNRfXnR4ZHkysUO+G7PGbBtIFiSwt+JhptPMz9MU8+n0t5bBN4xLyDNW2NP?=
 =?us-ascii?Q?A3Mg2fWd5TPbjm2ay5q2xi8MJiZxv+MVWwADUc4pUmXyklRQ2/Keoj6fV4Et?=
 =?us-ascii?Q?7h3fJWzznT2A8n8rAFrBaVQhFR9bb+R50dJv0vthbpLjWPetXVEVQgmvy5ab?=
 =?us-ascii?Q?czgnDnniGZqKyBAU7VaelxVGiYsvghSupr5dFjfYamkHxJl5jOuZWAT9wzbQ?=
 =?us-ascii?Q?MawsxvXWxQEWZCIBPeGsQ2PyXryXQdpq8gb4qGJnQilmruZXLmEPdFI0HU1l?=
 =?us-ascii?Q?RUqdA+fFKag7pGuh8MoYmDFUNyC3yo9PHqGnvIXhCXjUtO7gwkBm5jeO9CMl?=
 =?us-ascii?Q?p2iF2mpA/LIMbiYHamUoZcuoCgM90Vxf0Vr67ZngRq3c2hmSR/PdQVpaFlIh?=
 =?us-ascii?Q?prG65WWQcOi7w6X0vK8cYXsIXx2bQLMEBm0200itXnM7FWMKUejgEqu5N0Ns?=
 =?us-ascii?Q?G6/vLAqx892euSvvVnXVo9rz27dMeK+SohBmnwspOghDYyZsF8vJfp4JaTff?=
 =?us-ascii?Q?xTOND8AqgWFNPOp1s8F5ia46pFg6MP5kDWoJR+e5D4U3l+Mx0xFi3jqDMmdM?=
 =?us-ascii?Q?qixZkXOHYdW/DTrLUmHKkL2EOGYoXfJtPNTWKuYgSX5AMaphyzsG/4bf9yF4?=
 =?us-ascii?Q?pQuz5/MFlhmYeZ/i7xC2fq5mip8FsjmK+RjiJUo9v3w2MRpwSa9+LoJm9I23?=
 =?us-ascii?Q?n+dHTMN9A8gXjq98gA4uXJTQD2nOOiwS0GcHtwE12w7RTupWGUeLKhVaqeYx?=
 =?us-ascii?Q?zGgERIhwuQ2EdHJPGWsW4FcEcSeTSd/5WbMr/2ajyG6+T42mDGyURj7VZODy?=
 =?us-ascii?Q?gXxwvDpOwZA8DhkqRqRxwrNUucLe0t90t3WLjPjO2Qu750SGQnKs2SdgYcsu?=
 =?us-ascii?Q?PIsoji6zU9nbcD+dzBB4/4jmQ7JzQJQ4bZpedD3izVWqUzrr9Uq1QIG+dIzA?=
 =?us-ascii?Q?mUeQxOlDP5ofrS4iYsVESSad1wpsmVu3GiIL8fKH1QAANlkXyAVpTHP9u1kh?=
 =?us-ascii?Q?NPn6mYZeqrdqC35+O1T3O01V1Xg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: accce21b-5453-453e-bfba-08daa1229dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 07:25:27.7712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vl/qOXw0At7IITfQJGTx/wQCUHKHtuiRVuG+fNBIoyJXD/4Ke1U3cYqTzsEBY50tBvXvGkEe1nq9i5UP/oaj56vnt/huN9wVKoDTQ+YwnWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4487
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
