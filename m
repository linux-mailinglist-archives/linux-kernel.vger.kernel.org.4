Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A756DCA3C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjDJRvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjDJRvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:51:17 -0400
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ACD171C;
        Mon, 10 Apr 2023 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1021; q=dns/txt; s=iport;
  t=1681149076; x=1682358676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GKwqSaUhbr0nEy4eCxDsIJiHe/gLNM5H25yq5F9aV10=;
  b=UEGYbhc1vis8VO5+N6/+tTWKx5oMnLdoX55WZCO3Z92SQXDGpPVe/ref
   64tdH4W5KRbEcl+owAtnhnwVq8qTk13h+lxRkKusbZFwnOAp/HY/fIEGQ
   vhe3DNA1WukTu82qJZEVqIZSMwK1UHMtUKM7xjFH2gghP5QUm7+uQv5hh
   s=;
X-IPAS-Result: =?us-ascii?q?A0DoAQAcSzRkmIoNJK1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+BXFJzWztGiB4DhS6IM5IgihGCUQNWDwEBAQ0BAUQEAQGBUgGDMwKFPAIlO?=
 =?us-ascii?q?BMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBBwQUAQEBAQEBAQEeGQUOECeFa?=
 =?us-ascii?q?A2GBAEBAQMSKAYBATcBDwIBCBgeEDIlAgQOJ4Jcgl0DAZ9lAYE/AoogeIE0g?=
 =?us-ascii?q?QGCCAEBBgQEnyIJFoErkTonG4FJRIEVgTyBbj6CYgKBYIQUggwimiQKgTR0g?=
 =?us-ascii?q?SAOgTyBBAIJAhFrgRAIaoF5QAINYwsOb4FJgyoEAhQtNwNEHUADCzs6PzUUH?=
 =?us-ascii?q?wZYgRkkBQMLFSpHBAg4Bhw0EQIIDxIPBiZEDkI3MxMGXAEpCw4RA1CBRwQvg?=
 =?us-ascii?q?VgKBgEmJJ89xwsKg32gbU0TqS+Xc6d2AgQCBAUCDgEBBoF6I4FbcBWDIlIZD?=
 =?us-ascii?q?44gDA0Jg1CPeXU9AgcLAQEDCYtFAQE?=
IronPort-PHdr: A9a23:nuawzxAKcpAjlMWQBqgbUyQVaBdPi9zP1kY95pkmjudIdaKut9TnM
 VfE7PpgxFnOQc3A6v1ChuaX1sKoWWEJ7Zub9nxXdptKWkwJjMwMlFkmB8iIQUTwMP/taXk8G
 8JPHF9o9n22Kw5bAsH7MlbTuXa1qzUVH0aXCA==
IronPort-Data: A9a23:UzrmnKA1YZZSHhVW/4bjw5YqxClBgxIJ4kV8jS/XYbTApGgh0jZSn
 zQdW2/QaPzfYWuhKdFwborjphsPu5+Gy9IyOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4WGdoZtJpPljk/FGqD7qnVh3r2/SLP5CerVUgh8XgYMpB0J0XqPoMZkxN846TSFK1nV4
 4iq/5SHYAXNNwNcawr41YrS8HuDg9yq0N8olgRWTexGulbYi04UAPo3TU1mByKlKmX8NrfSq
 9frlNlVzEuAl/seIo/NfoLAT6E/auW60T5iJZZhc/PKbhBq/kTe20ugXRYWQR8/Zz6hx7idx
 DjR3HC9YV9BA0HCpAgSewhqKh9RIZQYwZnWM1m8tcOR/3CaKWS5lp2CDGluVWEZ0u9zBWcL/
 vsCJXVQKBuCnOmxhrm8T4GAhOx6c5KtZ91Z4yomlGqJZRolacirr6Hi6dZe3To0mclmFvfFb
 M1fYj1qBPjFS0wQaglJVs9v9AuurnT/SQJXlVO3mbM++lfVzQlIwuXXCeOAL7RmQu0MzhrH+
 Qoq5V/RBhAcKczayjef9H+orvHAkDm9W48IErC8sPlwjzW7ymENCRYbSUG2rNGnhUOkHdFSM
 UoZ/mwpt6da3E+xXMjmTQG/rjiHuQwYXMVLEOx55B2lzqvS6hyeQG8eQVZpZMMvsMw7XxQk1
 1GOzoKvDjtq2JWPTnidtbuIhTC/Iy4YKSkFfyBsZQgf8cj4sp00gFTMScRnF7GujdzdHTD2y
 iqN6i8kiN0uYdUj3qG/+xXMhCih48WPRQ8u7QKRVWWghu9kWGK7T52a0Gb08c8eFaCIXHiCu
 HcGq/XCtv9bWPlhixexaOkKGbio4dOMPzvdnUNjEvEdG9KFpibLkWd4vWkWGat5DioXUWSzM
 BKP5Wu98LcWbSX3PP4vC26kI55ypZUMA+gJQRw9gjBmTZFrcAaB8EmCjmbPgjixyyDAfUzDU
 Kp3nO6lCXIcTK9g1jfzGqEW0KQgwWY1wma7qXHHI/aPj+H2iJ29EOht3L6yggYRtvLsTOL9q
 Is3Cidy408DONASmwGOmWLpEXgELGIgGbf9oNFNe+iIL2JOQT9xUqePnOt7JdI9z8y5c9skG
 FngBCe0L3Ki2hX6xfmiMRiPlZu2B88k9CJnVcDSFQfyghDPnrpDHI9GJ8doItHLBcRozOV/S
 LEeat6cD/FUIgkrCBxDBaQRWLdKLUzx7SrXZnLNSGFmI/ZIGVeTkve6JVSHycX7Jnft3SfIi
 +f+hlqzrFtqb1kKMfs6n9r2kwnh5SJAw7ssN6YKS/EKEHjRHEFRA3SZppcKzwskc30vGhPyO
 96qPCol
IronPort-HdrOrdr: A9a23:quuTNaO6L0azVMBcT2D155DYdb4zR+YMi2TDiHoedfUFSKOlfp
 6V8MjzjSWE9Ar4WBkb6LS90DHpewKSyXcH2/hvAV7EZniphILIFvAv0WKG+Vzd8kLFh5ZgPM
 tbAspD4ZjLfCVHZKXBkUiF+rQbsaK6GcmT7I+0pRoMPGJXguNbnn1E422gYypLrXx9dOME/e
 2nl6x6TlSbCBEqh+2Adwg4dtmGg+eOuIPtYBYACRJiwhKJlymU5LnzFAXd9gsCUhtUqI1SsV
 Ttokjc3OGOovu7whjT2yv49JJNgubszdNFGYilltUVEDPxkQylDb4RGIFq/QpF4t1H2mxa1O
 UkkC1QePibLEmhOF1dlCGdnjUIFgxeskMKh2Xo2UcL6vaJOg7SQ/Ax9b6xNCGpsHbJeLpHof
 92N6XzjesMMfqIplWP2/HYEx5tjUa6unwkjKoaiGFeS5IXbPtLoZUY5149KuZKIMvW0vFvLA
 BVNrCV2N9GNVeBK3zJtGhmx9KhGnw1AxedW0AH/siYySJfknx1x1YRgJV3pAZMyLstD51fo+
 jUOKVhk79DCscQcKJmHe8EBc+6EHbETx7AOH+bZV7nCKYEMXTQrIOf2sR+2Mi6PJgTiJcikp
 XIV11V8WY0ZkL1EMWLmIZG9xjcKV/NKwgFCvsukKSRloeMMIYDaxfzOmzGu/HQ1skiPg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,333,1673913600"; 
   d="scan'208";a="97866659"
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by alln-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 10 Apr 2023 17:51:14 +0000
Received: from mail.cisco.com (xfe-rtp-003.cisco.com [64.101.210.233])
        by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 33AHpEil005711
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 10 Apr 2023 17:51:14 GMT
Received: from xfe-rcd-001.cisco.com (173.37.227.249) by xfe-rtp-003.cisco.com
 (64.101.210.233) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 10 Apr
 2023 13:51:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (72.163.14.9) by
 xfe-rcd-001.cisco.com (173.37.227.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Mon, 10 Apr 2023 12:51:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL0dm+itAL4G0D3ywwJkYTXeVW6GIa5FrtIh+u3ZF6DTIaBpr0qHeQgl39G6IH/U3oGsHBWR+0NIK/6G9dNuPR+hQEergimF/xD0YzA1JbEA8cam60Zb4qqbbuOQwvTLYLgq1JPDMcbLvh2WpivjD+duW7iITz1zQN3r95/nCF4iYLMxLehRiM6lmRlZiWvjrJTeiCgQA837fXhH9C0xwfcmaK0wxO9lUafjtm37/kAPOG87i0AR6cuKCMmWrJNmbNCLFPZd4BqjmB1eozjvTeFFQazd6nDh0ya5iONCxmieGF2bxLbzwXJHWsEV1sPc8Btb+OF3SyBGH1KKNk26Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbF34OEnmBbm7T+QFUrSta5oFt/ahzFYNpvlmD/b8cE=;
 b=WcZrTQcsttsXvgusSvh5IAmg09cki2em6hjyzl7soz2MMyOWnNK0Zf0ZErR6Mnm+W2NYfsTxznq9KW0IhlqfLBuhGMnI25FqX4VZyh5YAneoJSA8/spDzuAQ7aE04tD5OY2xnf1UYbtBSHHnTzO+jwPya9NB1FSDmYwgIVZRmjVySw/0pJ7T8icXwHnT6AfJIOqBaX5eg4we30POpbC6ocE4rmr6ehoJ+BpkYfy1mTZQOQOd99N5KTyQnBpmYc0o6Y77oN3k+BNy8amnsg5x8/k84jNu92s/YiXOPo6THCT6nYEgp3y099wniDYFQKvbNlCcDgOpWmQ1A39DfCwm2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbF34OEnmBbm7T+QFUrSta5oFt/ahzFYNpvlmD/b8cE=;
 b=ey2jxIC1miqwfFLHrrGjwV4M012agNMK+M9Cf8LKKTB9ZrOYTCwxCBUHAFXCBx+MybnSjRdQlz5xl78OeMSql2s351OO/egT66Ui8vWJ+wqhuDAunz7skeVMu4dcCldysP5NoAVSxAC7t++MHoZRCAzTK4UrpYxcjAakUjUnZXw=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by BL1PR11MB5319.namprd11.prod.outlook.com (2603:10b6:208:31b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 17:51:10 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97%6]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 17:51:10 +0000
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
Thread-Index: AQHZaWqYW/PiGCKJbkGjA/VaWrFw568k1ygA
Date:   Mon, 10 Apr 2023 17:51:10 +0000
Message-ID: <20230410175054.GF1391488@zorba>
References: <20230405223028.1268141-2-danielwa@cisco.com>
 <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
 <20230407160413.GD1391488@zorba>
 <6af9effe-89c0-7630-9a72-a5a6351e0a95@linaro.org>
 <20230410170915.GE1391488@zorba>
In-Reply-To: <20230410170915.GE1391488@zorba>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|BL1PR11MB5319:EE_
x-ms-office365-filtering-correlation-id: 4215d4cd-273c-4c31-caf2-08db39ec2b4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ccwj4rDTHpAMzZ4sNPSyFK66cRk2s2dz4ZFN+98OQcgUSqDJAYoSIoAsyOETcK23Jm8TbgF8maqEqTzQfIc2gBZ4aFrBhdjJ0G8EyANMOtN6EGI1rPqEGHF8/af1X+C1R7Wcz63uuxIwafzDlulhMDkOyIoVVIg6r/cjNAyeyeHtNFhUQ0VE6k4p+1ScIrbapB4b0pcB5uda7J/onkgKFkKypHFA9SnOds1zlxrrNA2yCsP9FQ92pVwPGg/XjTdgVXKezTsjR/YFfT9RVxCLx4BNeL6aLJGinagVlAH9OimPq6Feu+KcIO8ddFLEpZTnxWIgXri5hqqOHv9oQ5u72X/sFG4FLY4U7dfx8O2EXFlLqKgQVfz/kI8aOkHZL2IDP/g5tzODc/f4n0+tLs/J8seSnPKAniQNS/QgIssiuipUqI3r2Ir0Vb+CN6iYk2/9HkROgPrWP7A0t5RULHkStbnz4gz35VcTZhUctXguRMOt5kdL0UWIkarMFTLg+ERzeipkr9EEQQd+WEyEl0X+GCtNeLdoek52TCsIgBKgmkhjN5v2epWZCV+q7iyBsOdfYE2vZx43mdleJS/isXHpP9tUXS6GxYezz9wGjdCHGefphYUrPkKZOku6NHxp+Qh1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199021)(478600001)(71200400001)(316002)(54906003)(6512007)(6506007)(1076003)(53546011)(9686003)(26005)(186003)(6486002)(2906002)(4744005)(33716001)(4326008)(76116006)(66946007)(64756008)(8936002)(8676002)(66476007)(66556008)(6916009)(66446008)(41300700001)(5660300002)(38070700005)(38100700002)(122000001)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uva0ve7rAz35GV2sK9j7Gk8C7qj6N7YFAJ3YiPonMcop590vV0UyPED9jSlf?=
 =?us-ascii?Q?e2HVa7F15J6ADN88vb8wf0OPH/dz8LiWFKCnVrv9SuB9ZwDzbLDmd2J9B4LN?=
 =?us-ascii?Q?Ug3aBWzCO1foxcnZG4UDDnMDLW/VVl+c8zlpHBobCDj/MNRC3x4dfznYhqOS?=
 =?us-ascii?Q?S0bTKYgPByQcnoyD3UGfvmpsCRYV12K0ZfsL1M2QBZkWVfGUaeCpDOdgxQz4?=
 =?us-ascii?Q?UjeWO0rE4WDRZS3aAWXDIDnBm2zhsJ7S/E1EeEpEa7TOTbmMJEJN2vNHvwES?=
 =?us-ascii?Q?T4Oj0LOl3FULsUuwszoj+6PzpozjuPe/wCWb4oKBcY5WAhNTDui37hSEEf6Q?=
 =?us-ascii?Q?BYYa0EXz6jiXRfIRUoBd1Hd5DdTPd29eUoAJ2EszRf544aokfskk7uM0SHcx?=
 =?us-ascii?Q?8SOkII897WLGPKy2D/tgL/mvC0SsQPs/abINteRd907ppAKk7vB/q9dCIZu2?=
 =?us-ascii?Q?Nrie97Qyk1zcisJcMUMh5dxYpPCk1tXhmCsV+M0qHFZ0RGZdwFtUX9wq8jhc?=
 =?us-ascii?Q?Sl6IKsauyYFoXgs0dcG7Qvi141y4E9BMQMk5JvoWfX2JpcQMBzP3pjEK1OhP?=
 =?us-ascii?Q?/AlLGhoERWwVYSQMx6s+8mjeHyDuZ+swMJQ6mZp2kdpkXQhrzjKS6NCLVvI+?=
 =?us-ascii?Q?s5+zVUCuiMCTJ2Y41SiTtrux4ZUSQRxU7yTwA5n/hDyT8Em7hDRnfFDTgW4O?=
 =?us-ascii?Q?LZyPK5yYDXv34SfUdWMnd+7ih0CNsJJmt5nPogc9PFWw/kDkbdCnDg49Be6r?=
 =?us-ascii?Q?CgWGQotoap/mqDKsE+D8SDGb/SOL8jeIZrxDzEhqxiSkPwgifWH0K+9ALKSI?=
 =?us-ascii?Q?yBfAA9tG6xL0xe/ASXXNeae/6TSAyFxm5t4rW1RhDmNHXmd6MMjk8XAsfZ3l?=
 =?us-ascii?Q?9l2CraCjhSb876WIPsCkyVmK6sjbc/XS5hGg9JR0irTJ3GbHJbnZBF47SoZ7?=
 =?us-ascii?Q?OWbS6XrRaAw7V+EAHgLwEYC+7zw1PdFOC5ToLs3N1fWuy+zCIs9COgA+vltN?=
 =?us-ascii?Q?5+dOnGwK3cDYfXkl/xBKqKH4E9YHbKsNOeCmcqHq38ocWIadiMQhYyVOqDev?=
 =?us-ascii?Q?z2AAPrnNgRTPD/OyJ5sxDywP/FiXJ6AaP4CGHT7CZkIeB8AXtgWG/Oq+NXJv?=
 =?us-ascii?Q?JD/rBSt57Rq6lM70JBfL+ZR8ZBXKDZzDAXHnuClkYOuG8lhZfzkE/vuAODr4?=
 =?us-ascii?Q?WmVDtT4EBXO/BcL4gqdN6F+cX/H+0DhWOoR5Nikxi6Lijyknpo+WfMgXzRRl?=
 =?us-ascii?Q?n0OrjubPZoaeygjKLn+LWJzd4XL+B0Y1/KurLkw3FjGbtWVfmTSCVcdBx1mh?=
 =?us-ascii?Q?7CKQykku0MZPbkFzft3KDo+XnkevCb32OY02qcBoGDIs/Jd3GotQjxrpOJlb?=
 =?us-ascii?Q?AW/8Z0bBwJz/ShkqXt/LjEQ22IkE1UuNYOhw8Me/ddHUujlRmG8VdjkaQsvt?=
 =?us-ascii?Q?Er8K37Gtz2hR27FS3+fA+Kx6N1wTfVah3UoVMHfvTNXa0BUiMNlyvK+/e0fR?=
 =?us-ascii?Q?AM/7eoQiJfVURMojKROo0G/Vv9YZDTd+OMdsOEcNImWyA6Px7UJQB8L1sbPK?=
 =?us-ascii?Q?qNk1yLv9YxBBrR4lbrTcAyFncosIgEB3q1rBRt2S?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <243E43182402A54F90F5C71F7C97145A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4215d4cd-273c-4c31-caf2-08db39ec2b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 17:51:10.4153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcErw6Qo+DuHKlLXDsx5Ov2NsQxLlOL12BwqzvLsqcftaQBbVaOkppYxidtV04rxIOM7ZidHsBmQqwSPKS6uuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5319
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 64.101.210.233, xfe-rtp-003.cisco.com
X-Outbound-Node: alln-core-5.cisco.com
X-Spam-Status: No, score=-10.0 required=5.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 05:09:15PM +0000, Daniel Walker (danielwa) wrote:
> On Mon, Apr 10, 2023 at 05:28:03PM +0200, Krzysztof Kozlowski wrote:
> > On 07/04/2023 18:04, Daniel Walker (danielwa) wrote:
> > > On Thu, Apr 06, 2023 at 09:12:34AM +0200, Krzysztof Kozlowski wrote:
> > >>> @@ -0,0 +1,27 @@
> > >>> +# SPDX-License-Identifier: GPL-2.0-only
> > >>
> > >> Dual license.
> > >>
> > >=20
> > > What are my choices here? I see this,
> > >=20
> > > # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >=20
> > Yes, the one suggested by the checkpatch. Did you run it?
> =20
>  I don't recall if I did or not.
>=20
> > >=20
> > > Which appears to be what your suggesting. I also see this,
> > >=20
> > > # SPDX-License-Identifier: GPL-2.0
> > >=20
> > > I'd rather use the later.
> >=20
> > Why? Bindings should be licensed under BSD, so what is the reason to
> > make here exception?
>=20
> I'm sure I can re-license my submissions. I'd have to look into it.

I'm _not_ sure.=
