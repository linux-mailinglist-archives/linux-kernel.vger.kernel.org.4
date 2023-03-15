Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A4C6BB8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjCOP5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjCOP4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:56:55 -0400
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FD6848DD;
        Wed, 15 Mar 2023 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=517; q=dns/txt; s=iport;
  t=1678895782; x=1680105382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=anKKawrxXKJ8qZ/RJEXTu8XaqeUToAEtRNsWcOG+5LE=;
  b=gM/qgAsL5OUj80Hc3EiR0ARUSB/MedHlQLIj1Mp4kFkMiubXMevv83zi
   oHyI2t2IkHsYXdNVrqqzCVFO8Pgmlyede8xncTXV/B9KrkElrHOQiKdXR
   zjN+F0F+bFEZXLSORig26a94jHF+l9v2M9iiz2hYymik/07t5ga+a1LIR
   M=;
X-IPAS-Result: =?us-ascii?q?A0ADAADo6BFkmJpdJa1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYFbUnNbO0aIHgOEUF+GDIIokhWKDoEsgSUDV?=
 =?us-ascii?q?g8BAQENAQFEBAEBgVIBgzIChTICJTQJDgECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEHBBQBAQEBAQEBAR4ZBQ4QJ4U7CCUNhlUBAQEBAxIoBgEBNwEPAgEIF?=
 =?us-ascii?q?QMeEDIlAgQOBSKCXIJdAwGkJQGBPwKKH3iBNIEBgggBAQYEBJ8gCRaBKgGRM?=
 =?us-ascii?q?ycbgUlEhD8+gmICgWCGP5hoCoE0doEgDoE9gQYCCQIRa4ESCGuBfkECDWQLD?=
 =?us-ascii?q?naBTgKBVjcDRB1AAws7Oj81FCAGWIEaJAUDCxUqRwQIOQYcNBECCA8SDwYmQ?=
 =?us-ascii?q?w5CNzQTBlwBKQsOEQNPgUcEL4FeBgEoJLcHrVsKg3qga0wTg1elVYdSkBenc?=
 =?us-ascii?q?AIEAgQFAg4BAQaBYjqBW3AVgyJSGQ+BTIxUGYNZj3l1OwIHCwEBAwmLQwEB?=
IronPort-PHdr: A9a23:9R5V/BxYT1KezK7XCzPZngc9DxPP8534PQ8Qv5wgjb8GMqGu5I/rM
 0GX4/JxxETIUoPW57Mh6aLWvqnsVHZG7cOHt3YPI5BJXgUO3MMRmQFoCcWZCEr9efjtaSFyH
 MlLWFJ/uX+hNk0AE8flbFqUqXq3vlYv
IronPort-Data: A9a23:b/PSb6OOHUsBGVvvrR38kMFynXyQoLVcMsEvi/4bfWQNrUoi1DYEm
 jEaUDqOaK6LYGr1fNp2OY639UwF7JfRndIySHM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCcaphyFBcwnz/1WlTbhSEUOZqgG/ytWIYoBggrHVU/EHx41Eo58wIEqtcAbeaRUlvlV
 eza+6UzCHf9s9KjGjtJg04rgEoHUMXa4Fv0jHRnDRx4lAO2e00uMX4qDfrZw00U7WVjNrXSq
 +7rlNlV945ClvsnIovNfr3TKiXmTlNOVOSDoiI+ZkSsvvRNjiAr6aMFDd49VX8N1wnYju5Rl
 tJVjIPlHG/FPoWU8AgcewNTHyc7Nqpc9fqcZ3O+qseUiUbBdhMAwd03UxpwZtJeq70xWDwSn
 RAbAGhlghSri+uwwb+/VeBEjcU4J86tN4Qa0p1l5WqCU6Z8HcucK0nMzdhK1zEWpOVLJsffY
 vskd31pNgXuQhIabz/7D7pnzLv32RETaQZwrFOTuLpy6nLWiQ98yr7gNPLRe8eWXoNUmEiCr
 27L9mi/BQsVXPSbyDyY4jevi/XJkCfTRo0fDvu7++RsjVnVwXYcYDUaWEW6qvSlkEOzc8xQJ
 lZS+Sc0q6U2skuxQbHVXAeqsWWWohkSHdlXAek99xqOy+nY/y6dB24NVDkHb8Yp3OcsQjYql
 VOVt9DkHzpitPuSU3313qyTphuxNDITIGtEYjULJSMC597tiIUynhXKCNBuDMadh8fzFRn52
 TaGpm4yit07ks8P04248ErBjjbqoYLGJiY+7xneWmOjqAZwfo+jbpeA4ELeq/1HKe6xTUOTr
 WMWh8+QquMJH5WKizeOQc0JHbeg/fHDNyfT6WODBLE7/DirvnWkZ40Vu3d1JVxiNYAPfjqBj
 FLvVR156IZoOUWTSY5LW9jtN5U784i+EszcSaWBBjZRWaRZeAiC9SBoQEef2WHxjUQh+Z3T3
 7/GKq5A6l5HVcxaICqKq/Q1iuB0m3hvrY/HbdWqkET9iOv2iGu9EO9daDOzgvYFALRoSTg5H
 v5FPMeMjh5YSuC7OW/c8JUYKhYBKn1T6XHKRy5/KrDrzulOQTFJ5xrtLVUJINENc0N9zb+gw
 51FchUEoGcTfFWeQelwVlhtaan0QbF0pm8hMConMD6AgiZ8Mdb2vPlELcRqItHLEdCPK9YpE
 ZHpnO3dXJxypsjvoFzxkLGk9tU5LUT37e5wF3X1OlDTgKKMtySQqoO7IWMDBQEFDzG8soMls
 qa82wbAKafvtCw8ZPs6nMmHlgvr1VBEwboadxKRfrF7Jh62mKA0cHOZsxPCC5xWQfk17mHEh
 1/+7NZxjbSlnrLZB/GQ3/HV9tj5T7EidqeYdkGChYuL2eDh1jLL6ed9vCygJFgxiEucFH2eW
 Nho
IronPort-HdrOrdr: A9a23:rtbfbagDhSlPS8GQctGopT5sgXBQX3t13DAbv31ZSRFFG/FwyP
 rBoB1L73DJYWgqNE3IwerwRJVpQRvnhPpICRF4B8bsYOCUghrWEGgE1/qt/9SAIVyzygc578
 ZdmsdFeaXN5DRB/KTHCUyDYqsdKbq8geGVbIXlvgxQpGhRAskKhWoYe2Wm+w9NNXN77PECZf
 2hD7981kOdkAMsH6KG7xc+Lo3+TvTw5ePbSC9DIyRixBiFjDuu5rK/OQOfxA0iXzRGxqpn2X
 TZkiTij5/T882T+1v57Sv+/p5WkNzuxp9oH8qXkPUYLT3ql0KBeJlhYbufpzo4ydvfq2rC0e
 O84SvIDf4Dr085TVvF5icFHDOQlgrG3kWSjGNwR0GT+PARCghKU/apzrgpDCcxo3BQzO2Ulp
 g7hF5wc/FsfE79dOOX3amTa/girDvGnVMy1eEUlHBRSo0YdftYqpEe5lpcFNMaEDv9851PKp
 gkMCjw3oceTbqhVQGQgkB/hNi3GngjFBaPRUYP/sSTzjhNhXh8i08V3tYWkHsM/I80D8As3Z
 WIDo140LVVCsMGZ6N0A+kMBcOxF2zWWBrJdGafO07uGq0LM2/E75T3/LI27ue3f4Fg9up5pL
 3RFFdD8WIicUPnDsODmJVN7xDWWW24GS/gz8lPjqIJzIEUhICbRhFrZGpe5/dI+c9vcPEzc8
 zDTa5rPw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,262,1673913600"; 
   d="scan'208";a="33682437"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 15 Mar 2023 15:53:48 +0000
Received: from mail.cisco.com (xfe-rtp-001.cisco.com [64.101.210.231])
        by rcdn-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 32FFrgaB027802
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 15 Mar 2023 15:53:48 GMT
Received: from xfe-rcd-004.cisco.com (173.37.227.252) by xfe-rtp-001.cisco.com
 (64.101.210.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 15 Mar
 2023 11:53:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (72.163.14.9) by
 xfe-rcd-004.cisco.com (173.37.227.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Wed, 15 Mar 2023 10:53:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO2pzMWXf0c7CRvD+689Q3n6J1s/FZwy2W6eY/veG4cXonDAYNnGk7sRzxSX3rgb2teliqxe+ilBkO+3dZzfGWjhd3AtLYqhu5IUlDpgPhEmhb/gRc9pFhBW+XdCq2ScgqCFbpI6FQE9ya67jruYC57bv2HRMoIuc50hHg6o0JDwBbvLvAQbkEtEuc0j4a6yTPF70j2YbG2e7z9Uut7ccORDGS3GzdMNUfY2U2XWr22szc2s6Qg+nqHUWV04b7LbEF69DCEeO/ltCbywm/s8faJuYZAwsLyhYOjakzw8aT3ZtSC/9Gm56uPKGx5o2eElUQOlFrZNmT2ABunt8p9vFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anKKawrxXKJ8qZ/RJEXTu8XaqeUToAEtRNsWcOG+5LE=;
 b=aEF1yOSBXfHLZmopSe0R/EMDDzyh7aDmvWj1xyx8ArTfGTkvlRVq715nKmw8PEDFCmOil1QKeaVkJv1kXf3V6GF4C133kKc2DK8bXdzRMfTkLAw7JT7VO7G84ogKypzMnxaSSXWDyFK6MhAkw6duwWN/m0Wi86smzbDK+pj5IrtRftYlqedepdB56wahXllh4cA+g1Wkk0hWBMgMy+6kvO9yG32t3y3aC97Z/F0/hzuW65yVZF5GAG96tQL6iSLRUhZoYXsAfWgZm2YxI49uZFhZM+NcDswwUQ6oiHgv6On+gC3kES83JoY3iWXeHRKwoxsJvszrFnvvSWz19xqDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anKKawrxXKJ8qZ/RJEXTu8XaqeUToAEtRNsWcOG+5LE=;
 b=Z7Ho6ovLkOCGlihkSChFzZFz4Nux0anPFhHV0oh9s6kczf12RoQCd2NxgAemaOAWNvOpYP5Qh8pQ7MHCxOXHI+c7hreG/rUv2XmvgfKL/trLMsHX3FlnXaUxrTT8tU1VOMQEqhp3n6N2cMwh9wbzT4kaD0eZ/H8u4k/OfknIvew=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by CY5PR11MB6367.namprd11.prod.outlook.com (2603:10b6:930:39::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 15:53:23 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::f2dd:c914:3f88:e95b]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::f2dd:c914:3f88:e95b%9]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 15:53:23 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Marcin Wierzbicki -X (mawierzb - GLOBALLOGIC INC at Cisco)" 
        <mawierzb@cisco.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: cisco: add device tree for Cisco CrayAr
 Argos.
Thread-Topic: [PATCH] arm64: dts: cisco: add device tree for Cisco CrayAr
 Argos.
Thread-Index: AQHZV0z9dny/ake7nkGNX/xUV1YobQ==
Date:   Wed, 15 Mar 2023 15:53:23 +0000
Message-ID: <20230315155322.GZ15751@zorba>
References: <20230315010920.2473206-1-danielwa@cisco.com>
 <d6f7a967-a0ea-c5d0-93f5-683e02673ed1@linaro.org>
 <20230315144654.GY15751@zorba>
 <f852216a-51ec-4c9c-19b5-7de7c9ce321f@linaro.org>
In-Reply-To: <f852216a-51ec-4c9c-19b5-7de7c9ce321f@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|CY5PR11MB6367:EE_
x-ms-office365-filtering-correlation-id: 730cb9fe-b8c6-4f2f-49b3-08db256d6821
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DnrEeK0GDcCHsGAKZ+mB5mV6ibONfPyQpBxj/LcnkpxoX7mc56a9iu2gNe7FlqG+w91HzqBUW1B0UhIIehXde6hF11EiJC8NQrpAP6aIvS+1qdzJn82W8S1DIrZLDrDtFypmYGOmPTxXtb4hLmFDTA0oKdaTlKtXC7e2T8NJr3yaDJovXRJaiBWQx8ZC0BF4SAh4PjDtbKt2SJ1QPtCd4bCcc0rsuf6sy7DKW9VqPs9HRaOKKcioOBVtluMK3znksaZrusx8Ps0KBd+ckwzwBO/qXHWxD9qxJ+onmoYDKeB37dyPtFnANuZhCTqK6TZ95ng16m71fA9+XVJujSMNrIdzp4YPpNUXOGDnT6U0qWJtWs0skbYZkTppMzfAa+p4sj5iubWK7dwBjzaX7kEAb0g9rlvJn69A3BdKsYsZ0YFcFMjKgc6SsERQDV+/G7VWEPSaztm84RJthVfN6304kIGogvMMfnShB9gc/kibJ3n60NL7/o8UO11KID7GAQ7Klb4e///buQFZ2OF9sJUlzglooWSHl4WY2jVvjhGbXuO6BRKk/tEp2RkPiJ4h+0cuTC1yN7wJm6U9VCVzrZ25iL/tXUmTfmUKDXVLFS4y31DcItTh0tBebm2mgKTMO3x39L/f5AuvDLxJv/sCvoyxG8YGOl8gZRVWT6wuX+R0jInHm2cuKmLncrkfLLFMxqe0rfMVeEvHzf1WhtVqhHruSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199018)(8936002)(7416002)(38100700002)(122000001)(33656002)(54906003)(316002)(86362001)(4326008)(38070700005)(6916009)(41300700001)(8676002)(66476007)(66446008)(66946007)(64756008)(76116006)(66556008)(4744005)(33716001)(5660300002)(478600001)(71200400001)(2906002)(6486002)(9686003)(26005)(1076003)(6506007)(6512007)(186003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hLKVHXedi41hs7oVZ5gXISlFhuBXsdsIUFNSs8pUi9YTEVk3FaA+f5K9vVma?=
 =?us-ascii?Q?bfiurQHWcrIvcxl/m7qAHaMi1wyo/PEKK6EiaMQ5AYWosYffF8fHXBAMI7r2?=
 =?us-ascii?Q?L4jP7DDjpTB4CfYoyikoAGBJUHOXNrAiKJV/K6RUch0VgzhNVzTVOrvMXW1U?=
 =?us-ascii?Q?P6eK/gPSPuT0teaz86cauvT4B2ZmfkYs7H62pjNbgCx6fhO59ZiJ3cnD0Rda?=
 =?us-ascii?Q?RdWuCLOOxAPUFUFTyNjr/eFmrkVtkmbVs3F9ONhI6Y2QnSoyioYStl6SmfJr?=
 =?us-ascii?Q?zKEwyouRaRJeigr/CtVYRtIwmxBuaXK5jj2aAKN09ek7tgsNiRc06OUyrYP5?=
 =?us-ascii?Q?pwHUHrBU4kG0NwvGprhQU5+J1UdBLrxRFNHhPJSM2PXKPqNWXVXkSojsz6/C?=
 =?us-ascii?Q?etT4v4CBJg+DXNSzCnstIsEAbY8kYVx1Zy0NsHXU8vfDwM9AWgEMi8CFQKk5?=
 =?us-ascii?Q?SxIiyn4Kv2EgG04mcvhqlswbAVyJp2p7bF9oU/OZRUJXwbQM9CfIWPkNp0yK?=
 =?us-ascii?Q?c63mrVD7WtCUWt6ZoufOnLVdjd8yxDL1heC94TG+U9Y/CfokhfF6inRLoG7R?=
 =?us-ascii?Q?I4PMwUXhxM0OIuKd0SBkK3bVQbnR2daOvAxtb2hTQjlm+NNU4eYv+pjkM/GR?=
 =?us-ascii?Q?1ujfp+RLN1mYe2LWQBUjOV46j11Dcd0jOAJ4/CQ1m+Hqs4lPe8CF5B0sdhsL?=
 =?us-ascii?Q?+cPSA/DDzQhv3+0h9+geblhUCJQc3ztaXJiWIc7RCM7dAed3vKiaIrlLnKqz?=
 =?us-ascii?Q?Iht0uWszy3F/CV1zYV2INdjAvB+ZfmJdoc3G/Zbwe2DagaZHEOoaS0ea/qP3?=
 =?us-ascii?Q?HGNamOl2na6X7C2F9vZd9SvQuzF4Xl8uONLsBWjBeI6yrG+KMZS6bn3x8jeO?=
 =?us-ascii?Q?eu1c4l1UZ1a4hdqMFxIIi22LrpSVAU4rQPH+1G0YMB35s1GlxH6SMLwzzLor?=
 =?us-ascii?Q?TP2Jp/17lPMQCRfSuwYndcIJKNc3jggZDzEWIdltFI8d6ShxXdJ4zloY5HxQ?=
 =?us-ascii?Q?jX0EZYv0itCri45AZMCrIrwvV2VYi07+7tObfRn+WvRC/5EkjpqbmTpWYvBG?=
 =?us-ascii?Q?gEcZKtD83m2czkfUNUIlW7XmNiQZaFAkXil7c+aLpgen/WNBGu1nZO1Q1X50?=
 =?us-ascii?Q?ZASBZJJ85iNVtW3ilVNf4f4mv1r0qEcbf4kR6FRC9xBISu5Fy2o8Om1Uv5/i?=
 =?us-ascii?Q?wvemJSKLAf2dETEzhQdkan7bnkrl/7R/BvA1+uaDAukh6j6y+GnFtW2+Z1oV?=
 =?us-ascii?Q?AUpEdv0ey9t4GSphc363tVvGQEb59NTBq37ZuHQWw71m1uQY8nAu3Wi4zSiH?=
 =?us-ascii?Q?53sTYF6FdWhnXWgkyTPB54Mur7nSw2E2OatfbXlTOy4iAWcZUhDtyxEnGYnj?=
 =?us-ascii?Q?7lphdJEBa0MFYWpG/1/LvXQj39C8yAEfoJz1vBXnePxpBBF8Q4SQ0PcJsmQc?=
 =?us-ascii?Q?gJOilc4z6QFd1afoDJ5agvqpBlwWzc4jN6fQil2TxCslce967/mA7uFM+yD+?=
 =?us-ascii?Q?MqV4nLNQt3dgm5EHZxbS8or60m+f+B5Z+kla2AfhS67k+X6r3i93lNPLRs89?=
 =?us-ascii?Q?Oyl/lZkFsWVMvbpgIAg5vQ8JtNVSMuh34fZLmPDxcd5Ypr/Wv46C1w7wM5fy?=
 =?us-ascii?Q?dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEF0DC9549F6C2419A74C3F34E4F33DC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730cb9fe-b8c6-4f2f-49b3-08db256d6821
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 15:53:23.1406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOPJzIvE4ayPk4TwS+np6TDhtFrE/oh0lPitJitx4vFzJjYiwNLlPQG0Yj4R5lZCaVgI0tOOIcQDiLgP3kSlFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6367
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 64.101.210.231, xfe-rtp-001.cisco.com
X-Outbound-Node: rcdn-core-3.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 04:30:51PM +0100, Krzysztof Kozlowski wrote:
> On 15/03/2023 15:46, Daniel Walker (danielwa) wrote:
> > On Wed, Mar 15, 2023 at 07:38:52AM +0100, Krzysztof Kozlowski wrote:
> >> On 15/03/2023 02:09, Daniel Walker wrote:
> >>> From: Marcin Wierzbicki <mawierzb@cisco.com>
> >>
> >> Also few nits: subject: drop full stop.
> > =20
> > I don't know what your asking here.
>=20
> I am asking to drop full stop from Subject.

Do you mean the period at the end of the line ?

Daniel=
