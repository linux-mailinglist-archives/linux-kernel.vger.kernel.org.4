Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EEB6DF957
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjDLPGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjDLPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:06:11 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Apr 2023 08:06:05 PDT
Received: from aer-iport-8.cisco.com (aer-iport-8.cisco.com [173.38.203.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5C21BC0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4128; q=dns/txt; s=iport;
  t=1681311965; x=1682521565;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zk7qvVh8ZalSxAJ+ZHDBz6Au7iNujPqobhXXpigS29o=;
  b=h781uc68lkTO8wkjjxNS7jjlq6lISdgKeN0WrAH2wnYKoVULWLSe3xzZ
   blvF1XtfqUCxxrVpfa4e+MhDseaeeBgTefIWn0hcSAa14QOEL1lPLomAk
   lsMmBYlzLo8R+fOcaogHwOIbINDBimvI2ljvAL6o9id5PODBX9HA5IZPQ
   I=;
X-IPAS-Result: =?us-ascii?q?A0ABAgDmxzZklxbLJq1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEqgVxSc1spEkaIHgOFLogwA5Igi1CBEQNWDwEBAQ0BAUQEAQGFBgKFPSY4E?=
 =?us-ascii?q?wECAgIBAQEBAwIDAQEBAQEBAwEBBQEBAQIBBwQUAQEBAQEBAQE3BRA1hWgNh?=
 =?us-ascii?q?gQBAQEDEigGAQE3AQ8CAQgYHhAyJQIEDieCXIJdAwGffQGBPwKKIHiBNIEBg?=
 =?us-ascii?q?ggBAQYEBZ8hCRaBK5E6QoFJRIEVgTyBbz6CYgKBIz2GICKBDJk5CoE0doEgD?=
 =?us-ascii?q?oE8gQQCCQIRa4EQCGqBeUACDWQLDm+BSYMqBAIURzcDRB1AAwtwPzUUIAZYg?=
 =?us-ascii?q?RkkBQMLFSpHBAg4Bhs0EQIIDxIPBiZEDkI3MxMGXAEpCw4RA1CBRwQvgV0GA?=
 =?us-ascii?q?SYknnM4MisBJYEXCDQ3cwOSE7EnCoN+nWeDBk0TqS+Xc6d2AgQCBAUCDgEBB?=
 =?us-ascii?q?oF6I4FbcBWDIlIZD44gDA0Jg1CPeXU9AgcLAQEDCYtFAQE?=
IronPort-PHdr: A9a23:weHmGBaCeunlOhPg4GGtEo7/LTDihN3EVzX9orIuhqgLdbys4NG/e
 kfe/v5qylTOWNaT5/FFjr/Ourv7ESwb4JmHuWwfapEESRIfiMsXkgBhSM6IAEH2NrjrOgQxH
 d9JUxlu+HToeVNNFpPGbkbJ6ma38SZUHxz+MQRvIeGgFofUjsmzyOma8JzIaAIOjz24Mvt+K
 RysplDJv9INyct6f78swwHApGdJfekeyWJzcFSUmRu9rsvl9594+CMWsPUkn/M=
IronPort-Data: A9a23:ROY9XKO04Y2tRTnvrR2yl8FynXyQoLVcMsEvi/4bfWQNrUojhGADx
 jNLXWyHP/eJZWagett+b962p0wD7JfdzoNhS3M5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCcaphyFBcwnz/1WlTbhSEUOZqgG/ytWIYoBggrHVU/EHt400o58wIEqtcAbeaRUlvlV
 eza+6UzCHf9s9KjGjtJg04rgEoHUMXa4Fv0jHRnDRx4lAO2e00uMX4qDfrZw00U7WVjNrXSq
 +7rlNlV945ClvsnIovNfr3TKiXmTlNOVOSDoiI+ZkSsvvRNjicR85sSFscmUnhWhG+sp/otk
 Nl/lpPlHG/FPoWU8AgcexBVCWR1OrdLveKBKnmkusvVxErDG5fu66wxVwdtbctCor0xWzsmG
 f8wcFjhajiPjuS3zbakQ8Fnh98oK4/gO4Z3VnRIkWuGUad5HPgvRY3S1ftx2hABlPkJOs3EZ
 OoecDdNdTnfNkgn1lA/UcJiw7jAamPEWzlZrk+F4Kk6+W7eyCRv37X3dtnYYNqHQYNShEnwj
 m7L4WXyDw0AOdG31zWI6DSvi/XJkCe9X5gdfIBU7dZjjUfWx3QUEgFTU1Kn5/K4kUW5HdlYL
 iT45xbCs4A5122WZ/vAZSaHoXHemyY2B4JcIc41vVTlJrXv3y6VAW0NTzhkYdMgtdMrSTFC6
 rNvt462bdCImODNIU9x5ot4vhvvYXBIfTNqiTssFFpUuIW5yG0mpkuXFo4LLUKjsjHiMQnUq
 9xghAskjrYUkqbnPI3gpBWf22LESnThagMu/QjNFlqi6gp/aOaYi22UBbrzsK8owGWxFwfpU
 J04dy62t7Fm4XalznXlfQn1NOv1j8tpyRWF6bKVI7Ev9i6251modp1K7Td1KS9Ba5hUIGWyP
 x+I5FgPvPe/2UdGi4cpO+pd7Ox3ksDd+SjNDZg4k/IXOMEqLV/blM2QTR/MhggBb3TAYYlma
 cvELq5A/F4RCL9sy3KtVvwB3Lowrh3SNkuNLa0XOy+PiOLEDFbMEO9tGALXPogEAFas/Vy9H
 yB3bJDRlX2ykYTWP0HqzGLkBQ1TfShhXcuo96S6tIere2JbJY3oMNeIqZsJcI1+lKMTneDNl
 kxRkGcCoLYjrRUr8Tm3V00=
IronPort-HdrOrdr: A9a23:H/mMea0mY/X5wXDHUBVBvwqjBetxeYIsimQD101hICG9Lfbo9P
 xGzc566farslcssSkb6KG90cm7Lk819fZOkPAs1S/LZnimhILaFvAT0WKE+UyhJ8SezJ8S6U
 4ESdkdNDSeNykGsS+X2njeLz9k+qj4zEnKv5ac854Od3AXV0gI1W4QYWz3fjwSNW177NgCZe
 WhD6F81kKdkAEsH76G7w4+LpP+TrPw5fTbiDc9dmwaAQ+14w+A2frfKVy1zx0eWzRAzfMJ6m
 7eiTH04a2lrrWS1gLc/3W71eUSpPLRjv94QOCcgMkcLTvhziyyYp56ZrGEtDcp5Mmy9VcRls
 XWqRtIBbU215qRRBDznfLe4Xi47N8c0Q679bZeuwq5nSXNfkN9NyOGv/MCTvKW0Tt8gDg26t
 M544vQjesjMfqHplW+2zANPCsayXZdZhEZ4LIupm0aXo0EZLBLq4sDuEtTDZcbBSr/rJsqCe
 90EajnlbtrmH6hHjvkV1NUsZaRd2V2Gg3DTlkJu8ST3TQTlHdlz1EAzMhamnsb7poyR5RN+u
 yBa81T5f5zZ95Tabg4CPYKQMOxBGCISRXQMHiKKVCiEK0cIXrCp5P+/b1w7uC3f54Dyoc0hf
 36IR9lnH93f1irBdyF3ZVN/ByISGKhXS71wsUb/JR9sq2UfsuiDcRCciFmryKNmYRoPiSAYY
 fGBHt/OY6VEVfT
X-Talos-CUID: 9a23:yeMgVW1hwYmw2Ud9pv/i4LxfEeMET1T/8U3rHE63U0NRYuHNRW2z9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3Afy0dswxIcplTIvZV9U6/wDm1biaaqLyeLGkLtqQ?=
 =?us-ascii?q?Ugo6jDjZzGzCEgRaub5Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from aer-iport-nat.cisco.com (HELO aer-core-5.cisco.com) ([173.38.203.22])
  by aer-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 12 Apr 2023 15:04:58 +0000
Received: from aer-opgw-5.cisco.com (aer-opgw-5.cisco.com [173.38.212.137])
        by aer-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 33CF4wui110795
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 15:04:58 GMT
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by aer-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 15:04:58 +0000
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by aer-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 15:04:58 +0000
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by aer-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 15:04:58 +0000
Authentication-Results: aer-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=danielwa@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="5.98,339,1673913600"; 
   d="scan'";a="70539"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US1nd2Yh+S1TEJg9omqOpzRehTztkOKoWE0TDmyPz7vMfLK37VkMfkB6Y66TUGI1yucO+8LzCQEcfBGb3wyjHMzcGsspEl+yWQ0Sm9F7CsS0BhZoP2GCyBNgYJLxHbuJjIo2vW5VdElk/SOC6u44FyIY3kCJjPL4jCJZG7K5KFYMe3/oh7rgVs+GketZyVS/HYJBEa1OWSMbKJ/qMLC72bs+dK06DJyxKqgwWJLEbSRosMnZDiws8KJfS5U/cwkdpyKaRiVmX3falygrN4OZ2vPnH38LjzcmSe1xIUTlQ4fr4l/pVYe+Mt+nlz6NFQRvNNGwSr68R8KFn7aCAjsT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6F3dJ8K/B4t7CVDG45tQtGzyXK8zX/5SGvKyFRqFDo=;
 b=HiLU/FrJ4SASBvYWhTOHjOMfHSZOoD7LkBVHAlR5ApnaKdiACJ7hK0hEvxEuoPnpdd5xh3CyN27b1Zm9Myp+6ipAQJBbL1fWiAOwlgi5OnjAX4kWTIU7eHUfsSBSus0WiNc5S6UWWt/+u23NxvD6Fgmg6Q895uHtbnzmZLFifq17hWmMiXvRmmVDnMgsCma8eA97vALWyXjEaYYThOGhpxGqN9saY1GEwzqPyIOaiY90Eq5Lafv9NidBIIQVFznnbJNx+WCzAtGRX7H0wYXZZPcwlHYmoZdArwO7oSS8wpWvFYijruPJLugr6eL22HtfkNN0pgMOwyzhot5Zm4SufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6F3dJ8K/B4t7CVDG45tQtGzyXK8zX/5SGvKyFRqFDo=;
 b=S/XQ+FYBhQnvl5mF+qNRmRMhJ7sT3eOHOhQ1IKIHcq4eprFq4ssBgRPyU9ZygpgXlstIyZYk/pagP4InknCgW1yYxeOhclcejSt74d+ZOYOQRMbv853+zbwdR0ZMdnJ4yZPuGYAhfXb6HC5H78FsBupEegx7vWO9w3n3WYOg1AM=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Wed, 12 Apr
 2023 15:04:53 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 15:04:53 +0000
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
Thread-Index: AQHZaWqYW/PiGCKJbkGjA/VaWrFw5w==
Date:   Wed, 12 Apr 2023 15:04:53 +0000
Message-ID: <20230412150452.GQ1391488@zorba>
References: <20230405223028.1268141-2-danielwa@cisco.com>
 <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
 <20230407160413.GD1391488@zorba>
 <6af9effe-89c0-7630-9a72-a5a6351e0a95@linaro.org>
 <20230410170915.GE1391488@zorba> <20230410175054.GF1391488@zorba>
 <c1319685-49cc-9326-f4f9-1190ff633450@linaro.org>
In-Reply-To: <c1319685-49cc-9326-f4f9-1190ff633450@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|DS0PR11MB7457:EE_
x-ms-office365-filtering-correlation-id: 71e06bea-b7a4-4065-b998-08db3b674559
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +P630RrYK59E+K+7Op+R7bycwM9hDgrrQau7Dhe9OD/mNXVPCgUrG3wHTJccb2MEvfhgzbMi6tmV42rwcuaryueJ+ArMT+idZ+9FoGJ7Iix4DqfMr9ucEFSBJZADVgqtystn+i5U6NzyUG3zK3ADboY2jef0uV/ja3OjIvMTDZEGTiA3+sQgTyVZfLgTDJ7Ez2yySymkH8dS6TropDMuX8Nv3t46EcIvByPaz/3oCHvSjHvq2r0Pdn9cyN5B4lwbBCSXbDCR5OaghunRRQazj3DVLajkIL0C+DMhBEcTTRxRwQgHK2tTfCvQLrjqLOp6ZxsgFCwIR1RYAJj81lERiuqjrN4vtCFgztRRGbjVRU9zO6NfkdRNJ47SDrKtRzw+u9Ghns9SgT9/dcsNlDPSaXQeJmT0gvD+AruxFf4+CaCMwJ0ako0QD1f65FAYyB2R+kI4eoWpG4ZShYWG/OoEfdhaMrg9f/ghTQnNpR08/lmL8asA67ALLpM4U1UYJqgdgWWYh8Cl/oVWavxJqGqs//VVD5jesMgLeg1peGeSlhBR18zVKAbIOPoV8Lj2IxBNxueTAzIABn4EkX4+AFdi4gEL+qeh2Z7l5TYA8ZQfPP7fzNSE9Ll69wJuN1nZ6THu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(4326008)(6916009)(54906003)(316002)(64756008)(66476007)(76116006)(66556008)(66946007)(6486002)(66446008)(6506007)(186003)(9686003)(1076003)(26005)(6512007)(38100700002)(53546011)(5660300002)(41300700001)(8936002)(8676002)(33716001)(478600001)(71200400001)(86362001)(33656002)(38070700005)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0gexl3V00fW6UIZkITVlouPsPvLGD5lR/UkLj1fM1OJHsFsEnHFpvMLomtus?=
 =?us-ascii?Q?iQG5ufuvABKo1jDWh759fdCiHIyBoERLEYnP9W3Xi/kF1Frfb5g6W6MED/kB?=
 =?us-ascii?Q?CuNiSmnkG3RUztft1KimG4R4lc392OisxwhXIykRKNlTjHG9UV/J4cSnT7mG?=
 =?us-ascii?Q?E5q5CrZ+QMQuuLg9vfAmfurV6qiGwD2AMSaWjZyXSqupQtsQqfNbLIaWNCuU?=
 =?us-ascii?Q?Rt/Y/66nUwImzKMPaAb0Z1liO86BrVIynOrcxo7PwIvnIDFqHLUpwW/RI06R?=
 =?us-ascii?Q?LHB0dkE23oqRYxgXXirgfp+4WPKOpdPcrsraHXMRoji4U9W5ViwXRq8luNnG?=
 =?us-ascii?Q?I6hVS0VhSiIYJoQkHtoAXFSoIp8ru2oRNZ1v56E0cz8W6obAnpqLQmE+I7j8?=
 =?us-ascii?Q?oDgUcbyMT4JDKdFNua+uFb46jN2tr8WARg+mRn4qI55u29+uk22XnzW0CXPs?=
 =?us-ascii?Q?MxKj3XDx9mO4rxWAtrE4KTqAheR5hcKdijpa2RAUnyVa13bfzy2x6jvYRdMa?=
 =?us-ascii?Q?f1ftrZ71Tv04oTUHBsr2ICBobXTk/+5KmNM2Evbd2ZrSDyaAu1QFNYHEtVDB?=
 =?us-ascii?Q?wownVnfYJxV4ahL1ekMVhQLSJ5Znb5jEF2VB9/mGCSqgnrCk2FKRDbMY6mEx?=
 =?us-ascii?Q?M0eqHmKKgr1bXGKiOcGpjYc+lqZVKC6DG+bluJm60JBbFHvvCF8YVy6wXOXc?=
 =?us-ascii?Q?pZT5CDvg4yyJjn5nIgpEuiS5s3dITWNIH/cotJ7vsDeFETPkNK/sCHnPFU/s?=
 =?us-ascii?Q?tWi5IuzH2skrPhuXryvz1hdTTG3lbNbhCwnwUytDCB23i2YFM0qUzBQ2H6S9?=
 =?us-ascii?Q?mbcSdmrQXFR2eGHlkO7FznpRgm0zsc741O8HK2ZWn9mo9gq0iTpKE1zsjYfb?=
 =?us-ascii?Q?5luGD5BlQh5xolcul2DOgY/ynk2INf88Ahx5aXGDAXxcfL4d8fbNHhg4Febg?=
 =?us-ascii?Q?Sx8Cz8CLaIZ2l64DIAlkKi4A0Sb5Euvsg6QcGEy31S96JWu+H6E2ABmXnsgl?=
 =?us-ascii?Q?OiW+oLgtklNtNb2mGo6NNxQdOwprf09QiWMWbxoteH4mgnU7sRuuF8+dVvKE?=
 =?us-ascii?Q?2lnH0ZrMREtOoUhftImbIf9GNXfKBymU6fI67jJCAiKnAxaX7/S+DiAJRuZZ?=
 =?us-ascii?Q?3h0XMxGTxWU0VN1EZ8APQ+3WCjuquS4zgcQ020z9j+yCVEu6v1WT/FCMUjAd?=
 =?us-ascii?Q?NJE2fvUfTbvDxjMA6ikRl0Mmpyy5IZAKuxPENOai4uH1XI46kY6pY8D7kSUx?=
 =?us-ascii?Q?ciq25/R4N0vJiSoj0m5fY05CX6q9tVdiWccQUjd6ewh+kftHVDxNQSGr+qRB?=
 =?us-ascii?Q?QzsVPFnPe6ldOhQJLDQ8x3SHgrh2kIuTBBt5vRzgNL/ZY1OobIxRqQJVxbBf?=
 =?us-ascii?Q?revzxjA/fSIIX9akn06Sibnj9Vg/RpcfGlQeTrz2hLys2kUXUrkspTfL6wib?=
 =?us-ascii?Q?t6W12sb1eM3UsN/b3SsCS272KiunyqblDrSCCR9B1cTIGQTSaufChJw8bLRu?=
 =?us-ascii?Q?O82cRnjDniAfxwsKWiatfotb+WvRsIpHYQN123TzOOe/9F37ZWPD3jE1oIGg?=
 =?us-ascii?Q?bx52TWJb5+qu1Hb4uC4Ei3jlsvcXlR27U70On5twrv94Syl/V4SHADC9c36O?=
 =?us-ascii?Q?Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC6F0F94C0DC104DB56FF2453FDFE0DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e06bea-b7a4-4065-b998-08db3b674559
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 15:04:53.3736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rV6YUKpfnPr7l2yyWPJn6D0+log+EmQSG7JrduIK9d1hEJQT4s0DxDr10OqiORuY1JLV8m8HaR7jsrb5lbYdeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7457
X-Outbound-SMTP-Client: 173.38.212.137, aer-opgw-5.cisco.com
X-Outbound-Node: aer-core-5.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 09:24:48AM +0200, Krzysztof Kozlowski wrote:
> On 10/04/2023 19:51, Daniel Walker (danielwa) wrote:
> > On Mon, Apr 10, 2023 at 05:09:15PM +0000, Daniel Walker (danielwa) wrot=
e:
> >> On Mon, Apr 10, 2023 at 05:28:03PM +0200, Krzysztof Kozlowski wrote:
> >>> On 07/04/2023 18:04, Daniel Walker (danielwa) wrote:
> >>>> On Thu, Apr 06, 2023 at 09:12:34AM +0200, Krzysztof Kozlowski wrote:
> >>>>>> @@ -0,0 +1,27 @@
> >>>>>> +# SPDX-License-Identifier: GPL-2.0-only
> >>>>>
> >>>>> Dual license.
> >>>>>
> >>>>
> >>>> What are my choices here? I see this,
> >>>>
> >>>> # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>
> >>> Yes, the one suggested by the checkpatch. Did you run it?
> >> =20
> >>  I don't recall if I did or not.
> >>
> >>>>
> >>>> Which appears to be what your suggesting. I also see this,
> >>>>
> >>>> # SPDX-License-Identifier: GPL-2.0
> >>>>
> >>>> I'd rather use the later.
> >>>
> >>> Why? Bindings should be licensed under BSD, so what is the reason to
> >>> make here exception?
> >>
> >> I'm sure I can re-license my submissions. I'd have to look into it.
> >=20
> > I'm _not_ sure.
>=20
>=20
> This is a new file - it did not exist in v1 - thus you had to write it.
> If you wrote it, you (or your employer) hold all copyrights, so yes, you
> (or your employer) can relicense it.
>=20
> I cannot imagine the case why employer would not like to have dual
> license here (it's beneficial to him, so employer would be acting
> against himself), but if you need to convince him, you can just say,
> that contributing to Open Source project means accepting the licenses in
> that project. The license for new bindings in this project is (GPL-2.0
> or BSD-2), like pointed by checkpatch.


Yes, my employer holds the copyright. However, corporations don't work in t=
he way
you imagine. There is no one "owner" to speak to about re-licensing. The pe=
ople
who determine the license is an army of lawyers, with an extensive approval
process.

What benefit does a BSD license hold for my employer over GPL v2 ?

Here the licenses currently used by the bindings,

      1 # SPDX-License-Identifier: BSD-2-Clause
      1 # SPDX-License-Identifier: (GPL-2.0-only)
      1 # SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
      1 # SPDX-License-Identifier: (GPL-2.0-or-later)
      3 # SPDX-License-Identifier: (GPL-2.0+ OR X11)
      4 # SPDX-License-Identifier: GPL-2.0-or-later
      4 # SPDX-License-Identifier: (GPL-2.0 OR MIT)
      6 # SPDX-License-Identifier: (GPL-2.0)
      7 # SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
      7 # SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
     11 # SPDX-License-Identifier: GPL-2.0+
     12 # SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
     12 # SPDX-License-Identifier: (GPL-2.0+ OR MIT)
     33 # SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
     47 # SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
     56 # SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
    102 # SPDX-License-Identifier: GPL-2.0-only
    350 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
    511 # SPDX-License-Identifier: GPL-2.0
    610 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
   1570 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

Can you explain why so many are allowed to use GPL v2 , but my company is n=
ot
allowed? Shouldn't these all be dual licensed if the project only allows du=
al
license?

It's very likely that new bindings will be made by making a copy of other
bindings, then make modifications. If my company copied bindings which are =
GPL
v2, then we are required to honor the license of the prior binding
and that means we legally aren't allowed to relicense under BSD AFAIK.

Also the documentation for the bindings here Documentation/devicetree/

changesets.rst
dynamic-resolution-notes.rst
index.rst
kernel-api.rst
of_unittest.rst
overlay-notes.rst
usage-model.rst

all the rst files are GPL v2 and not dual license.

Daniel=
