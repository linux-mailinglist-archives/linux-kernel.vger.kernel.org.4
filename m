Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03496FC83D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjEINxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjEINxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:53:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A5F3C3C
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:53:29 -0700 (PDT)
X-UUID: de29c62eee7011edb20a276fd37b9834-20230509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ncSiN/PWtJO+VgvLdeHFaLq4HIVEF3PvKSzfzmRHths=;
        b=mHmzjCSslQaiCidMHiIRjD5c+Ogd9vC55lxitHXia1ZfzGntGRbruJb3fUh5Lrma+i+b5ummv+A0tjS9KX4BWt1tGxr63RcifwDBLsAJvUTM4fnsfkv4CvJ5/AZmENT2LY1Q7+TMt8LqCPH+hnlLAJIgrdJTxKjC3E4MPuSV8d8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:75e72837-2b02-4d5f-a72c-41606eca9002,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.24,REQID:75e72837-2b02-4d5f-a72c-41606eca9002,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:178d4d4,CLOUDID:fa4748c0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230509215326HXLCSGLA,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: de29c62eee7011edb20a276fd37b9834-20230509
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 70524463; Tue, 09 May 2023 21:53:24 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 May 2023 21:53:23 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 May 2023 21:53:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJiey3oM6viSDMpXS3GP4JeI8PvsHuwPX22rhcI44c6rciHJ5vpwIZF3FeWxairlQDcoytr+td91ezFrHARX9mnbeqXfBDvhBqSD83cbRtVBZvbk8IREOcQ3Z6/XDxrckfA0DLofxa2683EnPHbQO9zXiXTIgv9ReV2VOPvRjv6Y9j5irYnsk7dT0vhm8yrOOv2KdWGZF0oe682zwUkdjt+AYi/MtpUXnRA19l3AgJ4TeRNFeTt5gKJUnSzfdttgvcESGH9NiAPHMFE1Scmt45LGHOxyBrxiPb0SHqp6EUGupq4fd6/schWCSglOlBXwt9tRflu3zHOBN1y+REoK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncSiN/PWtJO+VgvLdeHFaLq4HIVEF3PvKSzfzmRHths=;
 b=EfcXN0tkJorCBTEhOfaYBjqjcBBE924D4C/J9MkZAKnljQ/U/A9iqWflko9XS8Ftf+Fa5T9GV83u3jWLhKkXfE7mrz1f1G6GLcHvhiXXh25mEMsXUPEZkUrXhNyF/FtlCjNi+BkrChmvaK+dNgooV7aFENd+YxGInOCoCXHqeNbgC+WxBGCLzch7cjXoaAHK1l/EbONT7pyOkUy4NatakKDcT4V9rOLat8UpU+R89babTyPhYdMSQsyy/5jF3MSErRSscNEe2CDey8PydqI0o/+j0HdIo7iYBgyhmuzfR1lfyFk8EjzMJlfnWDPDjEag7Us+d637m3C3jNH4BceqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncSiN/PWtJO+VgvLdeHFaLq4HIVEF3PvKSzfzmRHths=;
 b=tLwHsOWS6nPsIUktgwtBw9uZPgRC6Tovdcu9AixvFKAkE8uiR5YfB8bXEKOUlLBdF4ehVtdN2eUj/RySqNKPuS/es96lllrR3TONxj/1wCgvuq1V6fEoEn6k5F++ed6BUtohI1s9zcP9vH1YlQhCqIAnpEWELV9mEPiDTjtc83k=
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com (2603:1096:803:3b::21)
 by SEZPR03MB6809.apcprd03.prod.outlook.com (2603:1096:101:64::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 13:53:20 +0000
Received: from PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::66d9:2bd0:26ba:d9bb]) by PU1PR03MB3062.apcprd03.prod.outlook.com
 ([fe80::66d9:2bd0:26ba:d9bb%7]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 13:53:20 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH v2 1/2] drm/mediatek: Add ability to support dynamic
 connector selection
Thread-Topic: [PATCH v2 1/2] drm/mediatek: Add ability to support dynamic
 connector selection
Thread-Index: AQHZeOQGlyghKvmghEyoVOI8E8A4dK8/EqGAgBL2z4A=
Date:   Tue, 9 May 2023 13:53:20 +0000
Message-ID: <e182a3f8acba4e73c0f3e9e4c97f1a6dada656bd.camel@mediatek.com>
References: <20230427084040.3651-1-jason-jh.lin@mediatek.com>
         <20230427084040.3651-2-jason-jh.lin@mediatek.com>
         <68cc2867-fa22-075f-b1ec-a8042a1ac1a0@gmail.com>
In-Reply-To: <68cc2867-fa22-075f-b1ec-a8042a1ac1a0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PU1PR03MB3062:EE_|SEZPR03MB6809:EE_
x-ms-office365-filtering-correlation-id: d7fa899f-3932-40bc-5ecc-08db5094bf76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kB1MobQI5/VbK+CWpjj4nrE806snTKvvai9otkqVnHD0bFGeUx2Cw9xwsQp0GwvBUW32tsiLK0fliYUeGEiIgRgMsYQd+y7C+ygQ4rhcZSCSwncdEQqAOz7kfO8e+ycGrbXMsT9+D+xyJF7pQQYy0nArpjzvF/+uIkbetn9XvmXbUBqUb7Gvh1cqLk4bhL1iCHpPjiQvM8U/6BoVY4ge077vxg2kPgUsN8zGmS7ItKb5NlaKeilUcNNYKjXH64FNp28ut1hsZ3JVa7W6zxNWygSLcYeVNu8+xd5ogWLSUqoTTC7d6rKyrMfkAs3nDMRIVmkdNK5WaRd9Dw0uV+z3uIv2ItJ/te8izYP4GTF1YhvfWaFaFNMbTmcSCYgYY5JXl3WTsTYWl4Xuh44SCZKQ+dwzshT5QjpKUe0J3LwAGBbL7bw6t51c+iWfeLysUh1icKLx1rwWQ2ifocmUfjUNoHsHs3RbW0o6L18TW1MHJ9tdJznnGnGnJi2XT49mqcsXiDK7THRwfHRMfUW5P31Sq5QhHDyK9Lx2snrRZbii6UlMgraLSX656dfzwT14YmS9qxqLYHxsrCiWuz6ayF1ANnWFqSG1DAREXf5On3tp16b2bQ145iry1CcEG1nu1/mN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU1PR03MB3062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199021)(86362001)(85182001)(36756003)(316002)(110136005)(54906003)(91956017)(66476007)(4326008)(478600001)(76116006)(66946007)(64756008)(66556008)(71200400001)(66446008)(6486002)(8676002)(8936002)(5660300002)(2906002)(41300700001)(38100700002)(38070700005)(122000001)(186003)(2616005)(26005)(6506007)(6512007)(53546011)(107886003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGxySjF6cDhsSEJqVHE3bmE5dzkrTk9vZnozUkp4VTljS1d2MXVNN0k1TWxu?=
 =?utf-8?B?YUdyZUY0ODcya25qY3V1QmNJSjVpYmhUSkVtNGVBMTMwYU4vTTA1eFJRSEY1?=
 =?utf-8?B?WTNVb3hZNjlRZUN2MjlTRERmNnBWSVRJcEhBVGlMYzlKNGZ1ZWNoU3ZJRXM1?=
 =?utf-8?B?bmJUTzcyWWh5THZGYk5ZTGl1dUlvZVNYcVZ1K1BKN3gwVTIrMVM4YnRhZWlK?=
 =?utf-8?B?ZVpCSm81MTZDNU1GS0ZBaGd0ays4QVhoR1dpZEZrNVEzQ2FNdm1QZlA5QW95?=
 =?utf-8?B?RjdyTmU5VFhHQi8yVS9FLzN2TDQ5L25pOHJOeFBOUHhHZVR3c1lob01Ldkdn?=
 =?utf-8?B?aDRJRUVEeUx4VFZ3L3hJVjBZOVVJdldWNEFpd2wrVXN4WnYwNXFldXB1QkVl?=
 =?utf-8?B?OUtqUnpYUlBIUTdoOFlib3Y2Tkp4eWM5UkUyMjJqK1VPdVRabmZObXZrYXNB?=
 =?utf-8?B?Y3g3cEJQd2g0Vjd0K0JqQ1JiQUpTRjYyUFl0VXRqRmhNamVRWGgwL1RBS1I3?=
 =?utf-8?B?WllzNUZDbGc2M21QUDBSQWNEYlpkckFUcyt0VXNlcUtGTWlaNlB2Z2JISXh2?=
 =?utf-8?B?Mjh0MFkvZGQ5aWt5Zk10UEM3UHhGcnA4Mm0yeEpVTVBLUzJMWXB6R2dxN2Mw?=
 =?utf-8?B?T0VRZW9Rb2xSU0FJTkxIUUl4VCtmYmY0OGU4ZDd4M2dNenh2djZjSVUrRnZ1?=
 =?utf-8?B?WFZqWmNadG45Z0gzYUoyOVRhc3NmT2twT1R2WGx0WEM4UFFsM1ErYzNPOE9x?=
 =?utf-8?B?TFhDdGZZbGZXcUFtTk5BajZaZmtvZkhSa0JEd0dLSjdhUzVPblBuaDJCRE9Z?=
 =?utf-8?B?SURJVnpwZm5uZUtIdEM2WTVjcklib2ZUWXV1TTlxRXFwQkpibGZpMVpmTFdp?=
 =?utf-8?B?ekI0STY5cWgrQjdqakFJdW4vdGxqSTZEQVE5Tzh2UUV1SXBVczl2SDVQTmow?=
 =?utf-8?B?aFhwMXBaNks3N05RNnBmTFFqVDBGUW4wN2Y1azlXcUd5SmgxU3UwRm5WRjF2?=
 =?utf-8?B?Z3ZHaWkwTGViY2ZzWXcxVnE3RTVPNHJDNHB2QWg5Q1hVa2VTUUZiMHNnVTB3?=
 =?utf-8?B?clAvVjk5dmFIbk9kVWNTMGtlb3JUT2J6emljeHRyZlZhTmRLWmR2U25USExv?=
 =?utf-8?B?VWJYckpMUmlZSHQxbE4xblQrUWlVZENKY1l4TC85MVd2TU9LeVdMUFJBbEdm?=
 =?utf-8?B?Z3M1cXRJR2RrR1hXVTBsVTRXbkp1SDdrcWd6YjVvVHhoRFRSQzJ3czE2NDNj?=
 =?utf-8?B?ZG56eFBSZSsvNE51UFpwbEZqN0F1Sk5LamNIc3BwTjRYUE9IWjVadTk3d3BM?=
 =?utf-8?B?aTYzV1MzWUdsOHdWQVdtUXJtanlmQmRFYXliUWVXYUsydlEyTkNuU2x0amdT?=
 =?utf-8?B?T1crS2pLTFlxblRERHpSd2ZYZFFzMjg5anpEQjdjdFlhbmI0WEphOXdqdENV?=
 =?utf-8?B?aVZpbFRuaWpkeitIR1lwTEtpT2Uza0xhUnVFQnJLUVQzNDRFQzhQVmd3amhZ?=
 =?utf-8?B?ODNFOVBCRHEwaXBNdUVCdFJTd21qN1FPL1ppRTNkVGh6blJlamEzOEc3RGlW?=
 =?utf-8?B?Y0ZXNlVrYTVhZnlMclV5RVhTQWROR2pEa2NUWjdmMGw1bWpPM1FlTlRQbXBG?=
 =?utf-8?B?clNjeGRPLzBhMzQ1cWlhZksvc1M1ZEJkdmthSDhWWVlNdXdsY1poSnBSdisw?=
 =?utf-8?B?N0Rkcmg5TzltWGREWlppbkxBL0hoLzdPS0RjL2F4a3N2dTR6eVBsSTdzaG4w?=
 =?utf-8?B?Z05wK21LOXI5SDFqdDc5QTBySXM1NWZYSHQzVG1YcW04T1hQWHNIc1M0cVV2?=
 =?utf-8?B?OUxHUERNSU5OUFlYa001Ky9XQlBjWlQ4bWVlUW5tZjd4bUVPdGlOczJ0Rnla?=
 =?utf-8?B?NWtoRVR3enhac1l1d3lvdURKSFg2TWRObjRtYXFpdys4OStZc3lWS29Rc2t4?=
 =?utf-8?B?bisybyt5SEZucis3VVJOSnpOUmlHSG5iOXFPeFp0TmVjNy9qNVd1dlpzcTFI?=
 =?utf-8?B?UkRSZXlYN2tLYTdrSWZCcFBaanBLUndURmVQRHprVjNudG00YStzbkQ5L3hw?=
 =?utf-8?B?ZFAzOFl4ZEx6UGFtZ1VIZmtRaFJaaEkrZFJFTjExeVBVT29pK1JwOFhWbURh?=
 =?utf-8?B?UW5HZWk5Sm5ldnpNQlVudTVwSHFJSXdDOVR5YzN1Y1ZZZERsdWI0aVVjei9n?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF6902C6A75FFC42A6E3329ABBC990C5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU1PR03MB3062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fa899f-3932-40bc-5ecc-08db5094bf76
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 13:53:20.0606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bOq10a/mzptgUbr10AxVKlpwAqSiQ75SsmvnPQlJBqS5T48B2xLQ3mZK31n7+psXGHNIbw/LmH5DWxHTIfUmW8bzMifnmLmDDGsukhWosX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFRodSwgMjAyMy0w
NC0yNyBhdCAxNDoxNyArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4gRXh0ZXJuYWwg
ZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50
aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+
IA0KPiBPbiAyNy8wNC8yMDIzIDEwOjQwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gMS4gTW92
ZSBvdXRwdXQgZHJtIGNvbm5lY3RvciBmcm9tIGVhY2ggZGRwX3BhdGggYXJyYXkgdG8gY29ubmVj
dG9yDQo+ID4gYXJyYXkuDQo+ID4gMi4gQWRkIGR5bmFtaWMgc2VsZWN0IGF2YWlsYWJsZSBjb25u
ZWN0b3IgZmxvdyBpbiBjcnRjIGNyZWF0ZSBhbmQNCj4gPiBlbmFibGUuDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogTmFuY3kgTGluIDxuYW5jeS5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE5hdGhhbiBMdSA8bmF0aGFuLmx1QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0t
DQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgIHwgICAx
ICsNCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgICAgICAgICAgfCAg
IDkgKysNCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgICAg
fCAxMTINCj4gPiArKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fY3J0Yy5oICAgICB8ICAgNSArLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyB8ICAyNyArKysrKw0KPiA+ICAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaCB8ICAgOCArKw0KPiA+ICAgZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgICAgICB8ICA0NCArKysrKystLQ0KPiA+
ICAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmggICAgICB8ICAgOCArKw0K
PiA+ICAgOCBmaWxlcyBjaGFuZ2VkLCAyMDMgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0p
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9kcnYuaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+
ID4gaW5kZXggMjI1NDAzODUxOWUxLi43MmM1NzQ0MmY5NjUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ID4gQEAgLTQ0LDYgKzQ0LDcgQEAgdm9p
ZCBtdGtfZGl0aGVyX3NldF9jb21tb24odm9pZCBfX2lvbWVtICpyZWdzLA0KPiA+IHN0cnVjdCBj
bWRxX2NsaWVudF9yZWcgKmNtZHFfcmVnLA0KPiA+IA0KPiA+ICAgdm9pZCBtdGtfZHBpX3N0YXJ0
KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gICB2b2lkIG10a19kcGlfc3RvcChzdHJ1Y3QgZGV2
aWNlICpkZXYpOw0KPiA+ICtpbnQgbXRrX2RwaV9lbmNvZGVyX2luZGV4KHN0cnVjdCBkZXZpY2Ug
KmRldik7DQo+ID4gDQo+ID4gICB2b2lkIG10a19kc2lfZGRwX3N0YXJ0KHN0cnVjdCBkZXZpY2Ug
KmRldik7DQo+ID4gICB2b2lkIG10a19kc2lfZGRwX3N0b3Aoc3RydWN0IGRldmljZSAqZGV2KTsN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiA+
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiA+IGluZGV4IDk0OGE1M2Yx
ZjRiMy4uNzY1ZmM5NzZlNDFmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHBpLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rw
aS5jDQo+ID4gQEAgLTc4Miw2ICs3ODIsMTUgQEAgdm9pZCBtdGtfZHBpX3N0b3Aoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiA+ICAgICAgIG10a19kcGlfcG93ZXJfb2ZmKGRwaSk7DQo+ID4gICB9DQo+
ID4gDQo+ID4gK2ludCBtdGtfZHBpX2VuY29kZXJfaW5kZXgoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiA+ICt7DQo+ID4gKyAgICAgc3RydWN0IG10a19kcGkgKmRwaSA9IGRldl9nZXRfZHJ2ZGF0YShk
ZXYpOw0KPiA+ICsgICAgIGludCBlbmNvZGVyX2luZGV4ID0gZHJtX2VuY29kZXJfaW5kZXgoJmRw
aS0+ZW5jb2Rlcik7DQo+ID4gKw0KPiA+ICsgICAgIGRldl9kYmcoZGV2LCAiZW5jb2RlciBpbmRl
eDolZCIsIGVuY29kZXJfaW5kZXgpOw0KPiA+ICsgICAgIHJldHVybiBlbmNvZGVyX2luZGV4Ow0K
PiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIGludCBtdGtfZHBpX2JpbmQoc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlDQo+ID4gKm1hc3Rlciwgdm9pZCAqZGF0YSkNCj4gPiAgIHsN
Cj4gPiAgICAgICBzdHJ1Y3QgbXRrX2RwaSAqZHBpID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0K
PiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gaW5kZXgg
ZDQwMTQyODQyZjg1Li4yYmFmZDM3N2RjZjQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gQEAgLTYwLDggKzYwLDEyIEBAIHN0cnVjdCBtdGtf
ZHJtX2NydGMgew0KPiA+ICAgICAgIHN0cnVjdCBkZXZpY2UgICAgICAgICAgICAgICAgICAgKm1t
c3lzX2RldjsNCj4gPiAgICAgICBzdHJ1Y3QgZGV2aWNlICAgICAgICAgICAgICAgICAgICpkbWFf
ZGV2Ow0KPiA+ICAgICAgIHN0cnVjdCBtdGtfbXV0ZXggICAgICAgICAgICAgICAgKm11dGV4Ow0K
PiA+ICsgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgICAgICAgICAgZGRwX2NvbXBfbnJfb3Jp
Ow0KPiA+ICsgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgICAgICAgICAgbWF4X2RkcF9jb21w
X25yOw0KPiA+ICAgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgICAgICAgICAgZGRwX2NvbXBf
bnI7DQo+ID4gICAgICAgc3RydWN0IG10a19kZHBfY29tcCAgICAgICAgICAgICAqKmRkcF9jb21w
Ow0KPiA+ICsgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgICAgICAgICAgY29ubl9yb3V0ZV9u
cjsNCj4gPiArICAgICBjb25zdCBzdHJ1Y3QgbXRrX2RybV9yb3V0ZSAgICAgICpjb25uX3JvdXRl
czsNCj4gPiANCj4gPiAgICAgICAvKiBsb2NrIGZvciBkaXNwbGF5IGhhcmR3YXJlIGFjY2VzcyAq
Lw0KPiA+ICAgICAgIHN0cnVjdCBtdXRleCAgICAgICAgICAgICAgICAgICAgaHdfbG9jazsNCj4g
PiBAQCAtNjQ5LDYgKzY1Myw4NSBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2NydGNfZGlzYWJsZV92
Ymxhbmsoc3RydWN0DQo+ID4gZHJtX2NydGMgKmNydGMpDQo+ID4gICAgICAgbXRrX2RkcF9jb21w
X2Rpc2FibGVfdmJsYW5rKGNvbXApOw0KPiA+ICAgfQ0KPiA+IA0KPiA+ICtzdGF0aWMgdW5zaWdu
ZWQgaW50IG10a19kcm1fY3J0Y19tYXhfbnVtX3JvdXRlX2NvbXAoc3RydWN0DQo+ID4gbXRrX2Ry
bV9jcnRjICptdGtfY3J0YykNCj4gPiArew0KPiA+ICsgICAgIHVuc2lnbmVkIGludCBtYXhfbnVt
ID0gMDsNCj4gPiArICAgICB1bnNpZ25lZCBpbnQgaTsNCj4gPiArDQo+ID4gKyAgICAgaWYgKCFt
dGtfY3J0Yy0+Y29ubl9yb3V0ZV9ucikNCj4gPiArICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+
ICsNCj4gPiArICAgICBmb3IgKGkgPSAwOyBpIDwgbXRrX2NydGMtPmNvbm5fcm91dGVfbnI7IGkr
KykNCj4gPiArICAgICAgICAgICAgIGlmIChtYXhfbnVtIDwgbXRrX2NydGMtPmNvbm5fcm91dGVz
W2ldLnJvdXRlX2xlbikNCj4gPiArICAgICAgICAgICAgICAgICAgICAgbWF4X251bSA9IG10a19j
cnRjLT5jb25uX3JvdXRlc1tpXS5yb3V0ZV9sZW47DQo+IA0KPiBtYXhfbnVtID0gbWF4KG10a19j
cnRjLT5jb25uX3JvdXRlc1tpXS5yb3V0ZV9sZW4sIG1heF9udW0pOw0KPiANCj4gUmVnYXJkcywN
Cj4gTWF0dGhpYXMNCj4gDQoNCk9LIEknbGwgbW9kaWZ5IGl0Lg0KDQpSZWdhcmQsDQpKYXNvbi1K
SC5MaW4NCg==
