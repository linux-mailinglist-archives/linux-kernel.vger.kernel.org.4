Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4732F6BB66E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjCOOrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjCOOrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:47:01 -0400
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52741911DD;
        Wed, 15 Mar 2023 07:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=537; q=dns/txt; s=iport;
  t=1678891621; x=1680101221;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dtjQHYEFwmnmPkvvDYC5HG/qilJ5M850D9TwJsBylY4=;
  b=h/POIDo407GJ1lRdH91Qn45j9OtY/lwRnrzi4csIkRb0mFdGXg7XvdjH
   9aS5SLNckE7ma2f8uVW8rVBFesN1Tym5UV2heTpc61zGES18N+UwihrvO
   rxMpMb1xuKgx0jL+o5ebUl2BqrPEg/D+aXuqPFdrSxj2pGs9URmstG8g4
   o=;
X-IPAS-Result: =?us-ascii?q?A0ADAACU1xFkmJpdJa1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYFbUnMCWTtGA4gbA4RQX4YMgiiSFYoOgSyBJ?=
 =?us-ascii?q?QNWDwEBAQ0BATsJBAEBgVIBgm1FAoUyAiU0CQ4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBBwQUAQEBAQEBAQEeGQUOECeFOwglDYZVAQEBAQMSKAYBATcBD?=
 =?us-ascii?q?wIBCBUDHhAyJQIEDgUiglwBglwDAQ8GpAgBgT8Cih94gTSBAYIIAQEGBASfI?=
 =?us-ascii?q?AMGFoEqAZEzJxuBSUSEPz6CYgICgV6GP5hmCoE0doEgDoE9gQYCCQIRa4ESC?=
 =?us-ascii?q?GuBfkECDWQLDnaBTgKBUjcDRB1AAws7Oj81FCAGWIEaJAUDCxUqRwQIOQYcN?=
 =?us-ascii?q?BECCA8SDwYmQw5CNzQTBlwBKQsOEQNPgUcEL4FeBgEoJJ4TLIFNlnmtWwqDe?=
 =?us-ascii?q?otwlHtME4NXpVWHUpAXjVKaHgIEAgQFAg4BAQaBYjqBW3AVgyJSGQ+BTIxUG?=
 =?us-ascii?q?YNZj3l1AgEBCywCBwsBAQMJi0MBAQ?=
IronPort-PHdr: A9a23:XSLxexChleM3DJzO1jYRUyQVaBdPi9zP1kY95pkmjudIdaKut9TnM
 VfE7PpgxFnOQc3A6v1ChuaX1sKoWWEJ7Zub9nxXdptKWkwJjMwMlFkmB8iIQUTwMP/taXk8G
 8JPHF9o9n22Kw5bAsH7MlbTuXa1qzUVH0aXCA==
IronPort-Data: A9a23:kbtlh63yihCfCGazh/bD5Yp2kn2cJEfYwER7XKvMYLTBsI5bpzwPy
 zNOWWCAOK6IYGf2c4txPIvg/U4C7MeDndFkTQI/3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZxyFjmGzvuUGuCJQUNUjclkfZKhTr+UUsxNbVU8Enx50ks+w7dRbrNA2LBVPSvc4
 bsenOWHULOV82Yc3rU8sv/rRLtH5ZweiRtA1rAMTakjUGz2yxH5OKkiyZSZdBMUdGX78tmSH
 I4vxJnhlo/QEoxE5tmNyt4XeWVSKlLe0JTnZnd+A8CfbhZ+SiMa0qo9FNUcVRht1B6XgMFXm
 dZh5ZWuRlJ8VkHMsLx1vxhwCSpyO+hN/6XKZCP5us2IxEqAeHzpqxlsJBhpZstDpaAmWicXq
 KBwxDMlNnhvg8q6ybS6R+1zj+woLdLgO8UUvXQIITTxV6p/GcmYG/yiCdlw7Aoy3e5BOfPlX
 cclbjtqTBXqUwJSEwJCYH45tL742iagG9FCk3qRpKwq8y3a1gk007X3NtfRUtiLXtlO2Eeeq
 HjP82nwDlcdLtP34T6E9G+8w+zChyX2XKoMG7CisP1nmluewioUEhJ+fVe2v/iyh1KkVt93N
 UMZ4GwtoLI0+UjtScPyNzW7umyVpQwAXNQWEOoo7AaS0anVoAqFLmwFSDdbb5ohrsBebSYt3
 F/Kk8/BBjF1trCRD3WH+d+8tjS5ESsYN2kPYWkDVwRty97np48bihPfSdMlFqOp5vX8Azf86
 zmQqiQ0wbke5eYU1qG/1VPKmTShot7OVAFdzg7eQmuh7wU/YYe/Zoqh8nDS9/MGJ4GcJnGCp
 moVgNqC6+5IDpafkCuSW+YMNLWo4f+fN3vbm1EHInU63y6m93jmdodK7XQlYkxoKc0DPzTuZ
 Sc/pD+9+rdTMH2KQq9LPLjuINo13I6xFvi1X+7bO48mjodKSCeL+yRnZEi11m/rkVQxnaxXB
 Xt9WZv3ZZr9Ifk7pAdaV9vxwpdwmX9jnTK7qYTTikX4geDHNRZ5XJ9caAPWBt3V+p9ot+k8z
 jqyH9GBxxMaW+rkb2yMt4USNlsNa3M8APgaSvC7lMbffGKK+0l4W5c9JI/NnaQ+wsy5cc+Tp
 hmAtrdwkgaXuJE+AVzihopfQL3uR41jinkwIDYhO12ls1B6P9n/vP5PKcBtIuR4nACG8RKSZ
 6RbEylnKqkRIgkrBxxGBXUAhNU4LU/y1V7m09SNP2hlF3Kfe+A50oa0IlSwnMX/JiG2rsA56
 6axzR/WRIFreuiRJJi+VR5b9Hvo5SJ1sLsrByPge4APEG2yq9ICA3Kq0ZcKzzQkdE+rKs2yj
 VjGWH/1ZIDl/ucIzTU+rfne/tbwTLsiRBYy8quyxe/eCBQ2N1GLmedoONtktxiEPI8o0M1Ov
 dlo8sw=
IronPort-HdrOrdr: A9a23:tapg5aFIjD00mtvFpLqFSZHXdLJyesId70hD6qkvc3Jom52j+P
 xGws526fatskdsZJkh8erwXJVp2RvnhNFICPoqTMiftW7dySWVxeBZnMffKljbehEWmdQtrZ
 uIH5IOauEYSGIK8PoSgzPIUurIouP3i5xA7N22pxwGIGEaCJ2IrT0JcDpzeXcGIzWucKBJba
 Z0kfA3wQZIF05nC/hTL0N1LtTrlpnurtbLcBQGDxko5E2lljWz8oP3FBCew1M3Ty5P6a1Kyx
 mEryXJooGY992rwB7V0GHeq75MnsH699dFDMuQzuAINzTXjBqybogJYczAgNl1mpDs1L8Zqq
 iJn/4SBbU115oXRBDynfLZ4Xik7N/p0Q669bbXuwq6nSWzfkNFNyMIv/MoTvKe0Tt6gDm5u5
 g7gl5wcPFsfEn9dW3Glqv1fgAvmUyurXU4l+kPy3RZTIsFcbdU6ZcS5UVPDf47bWnHAa0cYa
 BT5fvnlb5rWELfa2qcsnhkwdSqUHh2FhCaQlIassjQ1zRNhnh2w0YR2cRaxx47hd8AYogB4/
 6BPrVjlblIQMNTZaVhBP0ZSc/yDmDWWxrDPG+bPFyiHqAaPHDGrYLx/dwOlauXUY1NyIF3lI
 XKUVteu2J3c0XyCdeW1JkO6RzJSHXVZ0Wa9iif3ekPhlTRfsueDcTYciFdryKJmYRrPvHm
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,262,1673913600"; 
   d="scan'208";a="24101301"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 15 Mar 2023 14:47:00 +0000
Received: from mail.cisco.com (xfe-rcd-005.cisco.com [173.37.227.253])
        by rcdn-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 32FEkwcS025095
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 15 Mar 2023 14:46:59 GMT
Received: from xfe-rcd-004.cisco.com (173.37.227.252) by xfe-rcd-005.cisco.com
 (173.37.227.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 15 Mar
 2023 09:46:57 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (72.163.14.9) by
 xfe-rcd-004.cisco.com (173.37.227.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Wed, 15 Mar 2023 09:46:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atLMwtl2LhbNDLH2SwvOrO0u6SZ38qRjTSB0D4hgf2KXJPf4c7HHcLTFnK5TOvIRg79ZByzlQ/5PtkEj9tgdKFHww3CmfxgVyCBMnxYNuAB2XJ8bmX5x7cMP08Z0DB8g79GGrF+d+8rvKXB011IphGQTpzCOuKV9NLrgy0qKyyDFP+GI3uqmdaZjyXvysXP0idt31LUoVuMvBj1qp3RnruNqNuV0ot5x26I+hGxGJ+SOuRsbar8AMcH5ZcsZOKRPAxRY6/vajJHbznIDeWDecU15ofkNAV/jO52+OZRObWBm2cuV7VhJlxx/F/7Ne2EZV3uYSms3BRpzNrd7LyK9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtjQHYEFwmnmPkvvDYC5HG/qilJ5M850D9TwJsBylY4=;
 b=cuiCOeuUdaUQ12vlfz7Se5/Av/wYaIp+NDa+8sBh0bMJ0c/9B2lp6+5doxYbALPiVXOe6vhWyXgN/g/DwI0a5c8RjAdoW8gETDOnkVYC572JjzFcKKbxLaz07PxsyAbs8kx5TPJG5w6ixBsEKIAjLMgbTrtQo187n8xmujDUd4f6PRPwkqk8zjcOggP7HE2VYd1vHNHUYwtwHTSd0qsSwRG7nmh7ixPGjzCOuUhCT6C4wRs2CGxnhp/h1y5mD1/9PVsZybQCofQBT+KkmK+ursiIt5BcKY7Pqs1TvoZXp+jaUL0Unj+kl/o45Bdit8psKn3wvus9qxwVZjw98YOHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtjQHYEFwmnmPkvvDYC5HG/qilJ5M850D9TwJsBylY4=;
 b=VfAxeBFSkjNj8BjoFRkgtDzZT7G9KOjvBWATiqcU4yx22pmwXpF0MOHUGpXkbHxcJbbC3fH11un9eLzF+WxBDnRW4mP+VxteCt+5pGh93KKGEqmUK0Bpq0r12SQ8RWb1Tk/w1HjsC6l6i4aiYBlFKIgo/G6BWsSYYueiDBGiOr8=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 14:46:56 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::f2dd:c914:3f88:e95b]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::f2dd:c914:3f88:e95b%9]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 14:46:56 +0000
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
Date:   Wed, 15 Mar 2023 14:46:56 +0000
Message-ID: <20230315144654.GY15751@zorba>
References: <20230315010920.2473206-1-danielwa@cisco.com>
 <d6f7a967-a0ea-c5d0-93f5-683e02673ed1@linaro.org>
In-Reply-To: <d6f7a967-a0ea-c5d0-93f5-683e02673ed1@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|DS0PR11MB8019:EE_
x-ms-office365-filtering-correlation-id: c227ebf5-d45c-4ca0-7161-08db25641fa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uUAOIgZUejx0CbqDj8fLPVrXWMR5CwDHCyzGi1p0TtXmcJKUApfhTpLhdPYPrzxfhWINixqXYiEYKQ3DrLBM8bjMNdkvM6rDlmAF3g6t9B2fRpKNlOni/QFQ1An3ur/dIdtLlPiWRp0nQVL+DG6/tFJOCAACpWtvoqLGoiUfin9Egmdy/hLNGm+Bbm/SCtK+MIVRacKK/g1SuUBeEfhlodbGmdnvuMWjy45/1ur75WrVFUTqJ0I3KTb5q46LzE8D4zfcD4g3+7cpOA8xr7T/H9Z4bJSV3djqaAzUsU6RcuhLELNGVsnuLsvBC5BdecITGqG/PGsuzS13aPIXoeERDspeqjUOKRPeKePMAjPmwsQchKY+yd6aThfAr+dbjvTZtMkx9bZSZZU2BAYK/ifT7uzZK7zHscwnZ74B1pAhPZRh21QQXRjFMFAGQ02giHqFhr6MNuJZOu3gY/fevAPJiGvSIo2dnSxPmBkcbDWWTndqiUqLyGnmcrnk0P507UFX2u5GManEwJvr74KcUeD5r+hmZcDf/6j5jpmytsbSTuvhjEQ4/mqjJY6QbK8RwPbUCQ3iKjQQ3CF+TJPcLUFwcyboLPv9d68TIvTy/P/hCSQclegeSgiIZKJ9NbUrDpW/GQ/ta3oXkQ7lEdUMivRkAOBCNfxn8hbLbBXreNhQcAcgwD89vIKrJG+QjvtkSga2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199018)(86362001)(33656002)(38070700005)(38100700002)(4744005)(122000001)(2906002)(7416002)(41300700001)(5660300002)(8936002)(33716001)(4326008)(6506007)(6916009)(6512007)(1076003)(53546011)(26005)(186003)(9686003)(54906003)(316002)(8676002)(66556008)(64756008)(76116006)(66446008)(66476007)(966005)(6486002)(71200400001)(478600001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hJ0fuxIga0TGy3+ucDNtyd7DTtP3p+56huxAfeKd3env163MP40euuBjAod7?=
 =?us-ascii?Q?9CAW2gy8r7omzApSq3R0jfzIDobJab4WOh4BNPkA37aweCmA3BsUTAk2hwhi?=
 =?us-ascii?Q?VsyBoEZRh8o43T+JHs5cKX6Lcdmkm6yanpfDHcs3GTa9aYiKEEHscSsBfWL3?=
 =?us-ascii?Q?8QgBwnLpuyMYhR5tuu9up0o22xUUXxYImfP0HtlEH6HhRqqY096b2DqUirxZ?=
 =?us-ascii?Q?Eb/LLvYJR0h5urb7ryer0/t1ws5R4tfV3gPh2h2hsIf0IBXvenopzHBu/LvL?=
 =?us-ascii?Q?aYgAv1LIu8n6KsPM2mKDvZHCFNbyTGkshK+aJ2SfdTQESjicQhDH/f4SaT2h?=
 =?us-ascii?Q?3mScEe5TJ/LrwkA6SFustR2kOjArbyc10n0WkkoRYmv4LmtyRQ7zRsnlmqbz?=
 =?us-ascii?Q?wYvFbmhNwSUjUDbl6GWKdlGvYlR+KT8nVN0cSBr4qv9zeY23gwtgZEpkTKLy?=
 =?us-ascii?Q?6Fh9y2SnO4ZezXBfoiK+jFOuMXsns7o047P7ZBOOgEcJFDC1rM6C8OggliYc?=
 =?us-ascii?Q?sQvAWx3ckSSDm7/OX4O6OUiQhaO7VrrJ3bA2xw8LkSuGDCpUnQ+kgyJ/Haeu?=
 =?us-ascii?Q?xqCN2DidiL2KYBIivSlR9lgrpG/opq4H3INUH/jl0HRN53aGmhDVS1jawLtL?=
 =?us-ascii?Q?aE3HoEr84b8zBOD/63fOvxadmBDW6i0o+pp0xjC29wtbvudFY1h2ihkdRMdc?=
 =?us-ascii?Q?o+nv52juRAboLNUL4TrM/8H8KK4jInH6eij9I/uoisR6YYE+iQ+BpbsYD3UB?=
 =?us-ascii?Q?1149PrbAUmRWfBqSW8+6GtA0sqfD6nBNwZyXekwuFOME/CPTCMN4jHBl1cK6?=
 =?us-ascii?Q?o4yt7R+sMqMpwmGd65bMoVk5KpRvmexmRWGMQDthnr7WDNqk8FCvcKJ1OYoP?=
 =?us-ascii?Q?wQtJpyx79Ba4qH8iM+HPI6ia1v9D4B12wbTSFsb6846YfIw+qi30QQd242Er?=
 =?us-ascii?Q?3qszSOkZeWKsOm+xIg5BP42LWGkzuLXspeoCBJKOLww5Ee4hi2SQ3mdx3fcF?=
 =?us-ascii?Q?0xXrUPicyKIPdNyfoXvy+ZOD8uFs7JNNtp4k+XvR2aaHSgVQeWTO495XwsIa?=
 =?us-ascii?Q?EBwOHUfiqJ8y5Mq7E0dQAm6eNwEejFAdU9GN3cZdNfEnwCHUhJOcHxTrY+HK?=
 =?us-ascii?Q?DklHj95IU+Br3ZI7xqwLLlnjoE1rUA8RMVhKQ0eax0guJMv4sc3c3C90CfP3?=
 =?us-ascii?Q?94jp3OQe8KmdWwe9ILYb9RIkSR99s53rHmklhdNRjONSw18pLFS1hMlVWA0s?=
 =?us-ascii?Q?vsSBV6aRvieU9hVtVDHCQbi0/DExFrWP1GeU9Vi+068qVB49R051xbxTUnEA?=
 =?us-ascii?Q?vBQR1wB/ftf3izvRfkOQHh0PukKbp0MM7y/bzmov7dkPBhb3aOrnJf+/gOWE?=
 =?us-ascii?Q?pqdIgof40sbkHR7A7NKu9aQqS4Ue2FAjAkC4zSTMyoAJAK6bf9DFbbgcV1TU?=
 =?us-ascii?Q?RTBZvGLR6j8y4seOftmORbxMPKqlC76ZH03aIcYldU+mhDBikQ+KJIPGksL4?=
 =?us-ascii?Q?/jmQ78jAYfr7p7cwHFAalerAo/2QeHtImROgbotFO5+87aftKjqOvxsnXabP?=
 =?us-ascii?Q?usxPM486myQVbdW66nbccDU4Cdg7FBsAzjwKZAhEsqfWhmvCmPJSR1ZCVmqt?=
 =?us-ascii?Q?Rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8548EE23E82D0846AFABBDE19124BC89@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c227ebf5-d45c-4ca0-7161-08db25641fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 14:46:56.0597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPlZCVonDnnVdeFH6AraKyRdi1yrMrKj0fJalBeWRHvjNwTlODoH4IOaxaZOW3iv86iPHraWtJN4U/LqKqlqgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8019
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.227.253, xfe-rcd-005.cisco.com
X-Outbound-Node: rcdn-core-3.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 07:38:52AM +0100, Krzysztof Kozlowski wrote:
> On 15/03/2023 02:09, Daniel Walker wrote:
> > From: Marcin Wierzbicki <mawierzb@cisco.com>
>=20
> Also few nits: subject: drop full stop.
=20
I don't know what your asking here.

> >=20
> > This adds device tree include file for Cisco CrayAR SoC and
>=20
> Do not use "This commit/patch", but imperative mood. See:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/sub=
mitting-patches.rst#L95

Ok, I'll consider it.

Daniel=
