Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A911B6D9BF2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbjDFPPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbjDFPPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:15:50 -0400
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3737C93C5;
        Thu,  6 Apr 2023 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2042; q=dns/txt; s=iport;
  t=1680794141; x=1682003741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0gRtkeKVR0xtrW+R5qSnsKc89h+UrkA49v3EHEw+GOo=;
  b=kLbxKqbpJ973WAl+EoMXHwlndesE2KRA5uHBCY+WNoRGxqeP4Z11bW+A
   XBeb/6uV7MYJvv0OfLX0epSLMvLi+m/3234fFec13xVFgp6NGGy5bRd9S
   a/S5ib7S5fLSdWFnWDyGiM7np4QrfC49KUtmTz2muyoSHI6uaEWyzJCe1
   M=;
X-IPAS-Result: =?us-ascii?q?A0AcAACQ4C5kmIQNJK1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYFbUnNbO0aIHgOEUF+INJIfihCBLIElA1YPAQEBDQEBRAQBAYFSA?=
 =?us-ascii?q?YMzAoU8AiU0CQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBBwQUAQEBAQEBA?=
 =?us-ascii?q?QEeGQUOECeFaA2GAwEBAQECARIoBgEBNwEPAgEIGB4QMiUCBA4FIoJcgjojA?=
 =?us-ascii?q?wGgUQGBPwKKIHiBNIEBgggBAQYEBJ8iCRaBKwGROScbgUlEhD8+gmICgWCGI?=
 =?us-ascii?q?CKBDJkbCoE0doEgDoE9gQQCCQIRa4EQCGqBeUACDWQLDm+BSoMqBAIUGzcDR?=
 =?us-ascii?q?B1AAws7Oj81FCAGWIEZJAUDCxUqRwQIOAYcNBECCA8SDwYmRA5CNzQTBlwBK?=
 =?us-ascii?q?QsOEQNPgUYEL4FcBgEmJJ4dNWMrAZV6sF8Kg3ygbUwTg2qMZphfl3KiZIURA?=
 =?us-ascii?q?gQCBAUCDgEBBoFjOoFbcBWDIlIZD44gGYNZj3l1PQIHCwEBAwmLRAEB?=
IronPort-PHdr: A9a23:ZnuRhBMcOtpxloSBg/Yl6ncDWUAX0o4cdiYZ6Zsi3rRJdKnrv5HvJ
 1fW6vgliljVFZ7a5PRJh6uz0ejgVGUM7IzHvCUEd5pBBBMAgN8dygonBsPNAEbnLfnsOio9G
 skKVFJs83yhd0ZPH8OrbFzJqXr05jkXSX3C
IronPort-Data: A9a23:vUVqY6pGYNwbTWNh0SvaSDFK5WReBmKUZRIvgKrLsJaIsI4StFCzt
 garIBmOMvaMZmTxKYx1Oom09RwGsZSAn4ViSlc/+CxjRiwW8uPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7xdOCn9xGQ7InQLlbGILas1htZGEk1GE/NtTo5w7Ri2tIw34Dja++wk
 YqaT/P3aQfNNwFcagr424rbwP+4lK2v0N+wlgVWicFj5DcypVFMZH4sDf3Zw0/Df2VhNrXSq
 9AvY12O1jixEx8FUrtJm1tgG6EAaua60QOm0hK6V0U+6/RPjnRa70o1CBYTQUhsiC3Wr/5V8
 ZIO77bsGStzEqCWkftIBnG0EwkmVUFH0LbDJX76usuJwgifKz3nwu5lCwc9OohwFuRfWD4Vs
 6dGbmlWKEnY3Ypaw5rjIgVorsgqKsjmOJwWknph1jreS/0hRPgvRo2bv4EDg2lt3KiiG97lQ
 sUkMjFWTyjqWBhvJAtHLZgyjuan0yyXnzpw8QLJ+vVfD3Lo5Ahw1qX9ddnYYNqHQe1LkUuC4
 GHL5WL0BlcdLtP34TaI7HOni/PVkC7TRo0fDvu7++RsjVnVwXYcYDUVT0mquuuljUD4WNVNL
 0sL4Skv7qQu3EiqSNDnWFu/unHslhIDUt5THvcS5gCDzfuFpQ2eAwAsVDlLaJ8qqOc1SCYs2
 1vPmMnmbRRsqq+EUmCB8bnSrjSgPS8KNmwDTSsFSwIf5J/kuo5bs/7UZt9nFKjwhdrvFHSpm
 3aBrTM1gPMYistjO7iHEU7vjAmvvsf5YCoMoUaNdD71wllVadSseNn9gbTE1spoIIGcR1iHm
 XELncmC8ewDZa1hcgTQGI3h+5n0v5643C3gbU1HRMNxqmjxk5K3VcUBvmwvdR8B3tMsJGeBX
 aPFhe9GCHa/1lOFZLVzaoS9YyjB5fe9TYi+Phw4gyYnX3ScXAaD+CcrbkmK0iW0yA4nkLo0P
 tGQdsPE4Zcm5UZPkWbeqwQ1iOBDKsUCKYX7HsuTI/OPiuf2WZJtYe1ZWGZil8hghE9+nC3b8
 sxEK+yBwAhFXev1b0H/qNBDdQ9TfCRgXMym8qS7k9JvxCI7RwnN7NeMn9scl3BNxMy5a8+Rp
 CjmAx8EoLYBrS2Wd21mlUyPmJu2Dcog8hrXzAQnPE2j3DA4cJ2z4aIEH6bbjpF5nNGPOcVcF
 qFfE+3ZW6wnYm2ep1w1M8KnxKQ8L0vDuO57F3f/CNTJV8Q+F1WhFx6NVlaHyRTi+QLn6Ztv/
 +z/j2s2g/MrHmxfMSofU9r3p3vZgJTXsLgas5fgSjWLRHjRzQ==
IronPort-HdrOrdr: A9a23:2E16MalCXqwjD4ddxh2CrwOJNN3pDfONimdD5ihNYBxZY6Wkfp
 +V8sjzhCWatN9OYh0dcIi7SdW9qXO1z+8Q3WGIVY3SEzUOy1HYU72KirGSjQEIeheOutK1sJ
 0AT0EQMqyJMbEXt7eZ3OD8Kadc/DDlytHouQ699QYXcegCUcgJhG0Vanf5LqQ1fng9OXNTLu
 v62iMznUvYRZ1hVLXcOpBqZZmnmzTjruOWXTc2QzocrCWehzKh77D3VzKC2A0Fbj9JybA+tU
 DYjg3Q/MyYwrGG4y6Z81WWw4VdmdPnxNcGLteLkNIpJjLljRvtTJh9WoeFoCs+rIiUmRUXeZ
 j30lUd1vZImjfsl1KO0FzQMs7boXATAkrZuBqlaL3Y0JXErXwBepJ8bMliA2XkAgIbzaFBOe
 RwrjmkX149N2KcoMw7jOK4DS2C33DE0kYKgKodiWdSXpAZb6IUpYsD/FlNGJNFBy7i7ps7ed
 MeR/00ycwmOG9yVUqp9lVH0ZipRDA+Dx2GSk8Ntoic1CVXhmlwyw8dyNYElnkN+ZohQ90cjt
 60f5hAhfVLVIsbfKh9DOAOTY++DXHMWwvFNCaXLU78HK8KNnrRo9r84akz5uutZJsUpaFC0q
 jpQRddryo/akjuAcqB0NlC9Q3MWny0WXD3xsRX9/FCy8vBrXrQQFq+oXwV4r+dSq8kc7/mst
 6ISedrP8M=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,323,1673913600"; 
   d="scan'208";a="92637652"
Received: from alln-core-10.cisco.com ([173.36.13.132])
  by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 06 Apr 2023 15:15:40 +0000
Received: from mail.cisco.com (xfe-rtp-005.cisco.com [64.101.210.235])
        by alln-core-10.cisco.com (8.15.2/8.15.2) with ESMTPS id 336FFVwF018096
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 6 Apr 2023 15:15:39 GMT
Received: from xfe-rtp-001.cisco.com (64.101.210.231) by xfe-rtp-005.cisco.com
 (64.101.210.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 6 Apr
 2023 11:15:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (64.101.32.56) by
 xfe-rtp-001.cisco.com (64.101.210.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Thu, 6 Apr 2023 11:15:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5ReiL2Zu4ZroMS5KQ5itBlIrSxBbsGgnUrTbklnwp/V3xd0owAcjkBkvMc7uZ59p160emP1qOQV/BgujevMJQUDgebRlH0tf9yJGV2mydULfm6PY1C2aCL1Z73UMOsJEj4J5qDPXAaoqhQtSX6SCvDuoglzerXcCOvLcSEpyuSYmWxYoQd/s+l78ZTYSa6WqbaKAqmnd8JZ9bHS8aoDZNd3kKKoyo9ZVbvVRaH9/FQi4EoIakIufzlf/Qiz6KKrLhmYKUoxm50cWnPdeXOj83hJZE+MVELIyQhV9DQ8LK4v2BICvJqxI6EAKTNwj1H4YODQdDhzdFprwjQxp9oWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhTQ3oLu9QJ5sZQ4R0QMgRb+96NAvk7Wna2zhPHqq9k=;
 b=clYkNJ2uYo5kZmN+7lIMjxFCn0QKzG+JPPNY3syX5O8Ysekh1+NSM3abmOmvM6unTzW9vYaT+Qvk5A++6Dm7nkpAltszjHZ+cBikQf7u+PEHVynDz+gkje5/N1P1pMu8bAu4/Jy8xpAnbMoauOYDG7l81G7qcBx2wupW3r+V8Af18atU9cAS2bLcR3z2YbTmClX8+59Y2fk5/nyYFI85dwT4oGcBaAApVlAQdu0144mugkVdqzUpw3gHbdfshYhIz2QU6BybcLOcl/1myFpGxIZhWmF6dAocwx8i786y4RqZQwEDMznASWB/7N+sd0w/tKWOmmELNopOQ9WZiNrSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhTQ3oLu9QJ5sZQ4R0QMgRb+96NAvk7Wna2zhPHqq9k=;
 b=ed2Cm4YdFbZOvGeWZKjdPXmtir5SUfN9dXe72EXL/Dx7I4XTxQV2Hrd8DHmwiBkvX5QusFNO1oASABI+o5+r9v2VSHjJz8uKvqfH0F06Y4uKDKGWI4PIUdkQ36XgJPhzlNqEWvwNS6DAMhWVYankthAwB4ojo9Nq5bkWehAzW+A=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by CH3PR11MB7762.namprd11.prod.outlook.com (2603:10b6:610:151::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 15:15:29 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 15:15:29 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Marcin Wierzbicki -X (mawierzb - GLOBALLOGIC INC at Cisco)" 
        <mawierzb@cisco.com>, Rob Herring <robh+dt@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR
 compatibles
Thread-Topic: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR
 compatibles
Thread-Index: AQHZaJqfW/PiGCKJbkGjA/VaWrFw5w==
Date:   Thu, 6 Apr 2023 15:15:29 +0000
Message-ID: <20230406151512.GL40472@zorba>
References: <20230405223028.1268141-2-danielwa@cisco.com>
 <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
In-Reply-To: <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|CH3PR11MB7762:EE_
x-ms-office365-filtering-correlation-id: 28dfe4aa-38e2-4c8f-beb7-08db36b1c1e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ay15TL3JluQGpg1zL6vWDeS/usLt6iw7err1YfZLJsEMGxV1qAdfzH8Ec9QuRtspA4Bm3ZSMggM5XXmPla0RywKvY42R+RMlqF9ML8az7bDLtIZEFqmXCtQ/c1eDlkn5cJeZ7qK4d2ypzyfbxuGz1dGSRuhiTahXujzEh/watWUAxdHVNIuNNX4GIjWfcDbbe0YyltvUpU8CooQieY4HK5MmOoV/FYYDhp04wM8NoKYuHOl705VFwlOzH6mw68rxau6FSx20g+FjIeIinm8834TGkGwjERi8KcWvKe56Xn1T0wiBWZNhvWgwwVBCMLnSJ16FAn0Hn21YkGtvXh96kFNmmFFC226exP+6rlhU1Lv7lcpGRazN5ajaX4+O2xNKLYkQCyfrWLFl/ZQau5Q8vpycau/womqR57MqkOZu4J94xBEq1OFo+t2/xa4/IuKa6BuPM2/5GoVFopUjuCZHL3NXblsakReq97cqOnSiMNfQFGllP1Z6Y2w6vWIY/nS16c8LuC/mSKDuOIhVXmQASSkA8TkCLPEySGghOt1+1mpXnGaE0+xddZpNX5jSW05hvxso/fRQwaEa4Cx4zuXFBH/1b4VFPymDsxX9M6g1OcQY9l/Yz4qfnSVN+nEdxmnZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199021)(38100700002)(33716001)(66476007)(66556008)(9686003)(66946007)(66446008)(64756008)(316002)(122000001)(41300700001)(33656002)(6486002)(5660300002)(54906003)(8936002)(478600001)(86362001)(38070700005)(1076003)(4326008)(6512007)(6506007)(8676002)(6916009)(76116006)(26005)(53546011)(186003)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cNiLIeT+Kn3r2v8l6HN4oTOmmgifB0P8FBp+FtQL5JKTXup2gWllXgn6N9Ic?=
 =?us-ascii?Q?pkAaigRYDosrivlKhUrkoj0SNefT8ACFduZkwkr8Ms6ZPDZr2nt+uQr+eKyb?=
 =?us-ascii?Q?nCXz+1hLdodf1GyiYu4baN2HDBvyTczoyMXq+RKuFajUUmHiFewXLkt295Z2?=
 =?us-ascii?Q?8X/SirmLUhcwxPtVlJxJ5NnX+P2VHQ//fXk8U4HKLazdhLjqwu/9cUkUmuVG?=
 =?us-ascii?Q?jwgwnUdC1QmZQ6WYUykfeBDWK4GPHzjbqJdUoXW3Tq9c5xsFEnUnQj/Ho8oJ?=
 =?us-ascii?Q?tMqpxHAhjCWIqmuwei9VkpqXkBVwoh8F/ApHXNp90Ba8oX4HoXMR2eEqNq6k?=
 =?us-ascii?Q?UI6W1T/8HuJrm6aqAyO6RImvcbyzi4bIGTaUvm92rHq0sdAhjwFhS0n7Y7bq?=
 =?us-ascii?Q?XSLtjRkKqiiIVDG0yZYo+Z3AT4iOVPinp+4w8D8/5Jh7iMX6o60q+lGH7iDS?=
 =?us-ascii?Q?G8I+6JzklCQ4CkOP0U7dnEs6JJe8lpV2wvjYesNanvZUNeKmDBrjM23NqR+5?=
 =?us-ascii?Q?F4MBEq6+Y61YuXTVJRucVnnckReJ6NaGLgNMQwUHyIt5uDzDdQboo3cBTOo7?=
 =?us-ascii?Q?iLbQ01ziKK4SaOnE6dI56aYaKErc7487eScZuQJEvbBWGG2R+bYzH2gO46Na?=
 =?us-ascii?Q?+IT7IohOQNVit1XtHqa/qXnOM52HQ32clzX16nIIiS0U+P8N+oh0dyP8YAih?=
 =?us-ascii?Q?cQvSkIvYLrYV9VwxZQk5no4sXy3UmgOlsBmN1pkhhZZnO9EtMyJQoch9NbRl?=
 =?us-ascii?Q?qpF2Jj1aWZxzUSk2MmsJow+qsQ3gowL1gwzsPoVFme5fq/aIAUL68Zl9Z7Sm?=
 =?us-ascii?Q?PahQSy1VFOhtCM37uAl2CCqvVK9f5/6wOe6v5J9GuAIA4KcrWD8tQAlZhXfE?=
 =?us-ascii?Q?S7bbJqH6PQ/ZLuEZWPo+bdzXWUV9QdOZyBVBVEyUJFWKMilKxmHryD4L7b04?=
 =?us-ascii?Q?zJTwUFcZKcLzoWHyZUfVLYx6NI5kR8HXgoDzhQzXpTHvvMMy/jCGuooTR6RX?=
 =?us-ascii?Q?SCbTgqQZjsYURWQChAChbYDwRTIlg/U4DNylZiAfPZpoZ6uh/ceviSEl5CKU?=
 =?us-ascii?Q?Rr+A2zhKHhPfRJQhF9wCM0zJ13+FESl0Uc+uFICbzbPwDQOl9+/itSbQneTW?=
 =?us-ascii?Q?+6jeEMRhcTBNxgzscGv+DVJRnfFBR1IU+16c/ZM1PdgVCaEhWWwkYAwF/YVZ?=
 =?us-ascii?Q?d49YnozdwxaJlQ3kyaZAgFgc/DrkCbKZF38ikUYq2kY4m+S+uzZBlupjkfZu?=
 =?us-ascii?Q?I7HDC/QySoNBfWB34m6XuBAq4W8gU66yqoAINXDSUslcffA/ylYsp7VUi28R?=
 =?us-ascii?Q?piuCpA/iTDQmdav7RQJWV3UEmTk9Mo2wkOAYwmFmu6+Bgy+YLL3syqtxEpLF?=
 =?us-ascii?Q?//fsVpAi/I46Evg1HpIK3DA2xkZo16JuWfjoGjYZASLQVT16fu8U4J5V1LzC?=
 =?us-ascii?Q?zA0uKhGXtIwv2YR706HLaQUhkZs2McbA7Irlq0iwnXBXk/d7HJlPIn9LxWjo?=
 =?us-ascii?Q?VeX7UL6DCbj0L800CAGhbstaEgKVWWuH95n1QGpfhzP+HYP6/pCx2GvqpsO5?=
 =?us-ascii?Q?fZOdY0oaut+IFMlLlTG3P4zEpPY9Ygr61oUneeZY?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1D6D1AB17AB0549BB4E2476F51AD80B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dfe4aa-38e2-4c8f-beb7-08db36b1c1e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 15:15:29.2994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1zXRYnogAMG5h72bCP9Z3vevDg/TWAKThv0sQg/1FkbhFivOUjDhtw/6Fl9WCPp9dvni3DggZF2V7aBIN56Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7762
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 64.101.210.235, xfe-rtp-005.cisco.com
X-Outbound-Node: alln-core-10.cisco.com
X-Spam-Status: No, score=-10.0 required=5.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 09:12:34AM +0200, Krzysztof Kozlowski wrote:
> On 06/04/2023 00:30, Daniel Walker wrote:
> > Describe the compatible properties for the Cisco CrayAR SoC.
> >=20
> > Cc: xe-linux-external@cisco.com
> > Cc: Marcin Wierzbicki <mawierzb@cisco.com>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
>=20
> Please drop the autogenerated scripts/get_maintainer.pl CC-entries from
> commit msg. There is no single need to store automated output of
> get_maintainers.pl in the git log. It can be easily re-created at any
> given time, thus its presence in the git history is redundant and
> obfuscates the log.
>=20
> If you need it for your own patch management purposes, keep it under the
> --- separator.
=20
I added these, so it's not script output. I can move them under the separat=
or.
The reason for that was to make sure people who commented get Cc'd.

> > Signed-off-by: Daniel Walker <dwalker@fifo99.com>
> > ---
> >  .../devicetree/bindings/arm/cisco/crayar.yaml | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/cisco/crayar.=
yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/cisco/crayar.yaml b/=
Documentation/devicetree/bindings/arm/cisco/crayar.yaml
> > new file mode 100644
> > index 000000000000..0ee4e6313ab0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/cisco/crayar.yaml
>=20
> How many (or not many) platforms do you expect from Cisco? We mostly
> have one file per SoC manufacturer.

We have two SoC's one called CrayAR and another called Craw. I've submitted=
 the
Craw dts file before , but I've not resubmitted it. Under Craw I think we h=
ave
at least two, but more likely five variations. CrayAR we have one variation=
 with
at least one more planned.

So we would plan over time to add two dtsi files and three to four dts file=
s to
this directory. Then more over time.

Daniel=
