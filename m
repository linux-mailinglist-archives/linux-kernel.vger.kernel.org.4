Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4516DC9BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjDJRJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDJRJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:09:23 -0400
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E491FFB;
        Mon, 10 Apr 2023 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=877; q=dns/txt; s=iport;
  t=1681146562; x=1682356162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2at2MK3D2W77h4xETskMYhbylrnJZSwL9wMxfqcM6Kg=;
  b=C1e7y8HbCPI1MqzJfDKJiyzKkmJCz+5dDQH2mwXvhsb8BBO7aSpVhjVA
   DIYNajGHMdmlqxUT0iEA4ZqttL9+LAosb1DV/IJFP5Hm0n+/3j+1ULzpL
   2595nyVyUJzana1drH+6geVAFBHtiWqPd8OOfUETFI132fi/hp/LtBr0Y
   Y=;
X-IPAS-Result: =?us-ascii?q?A0BQAwDvQTRkmIcNJK1aHQEBAQEJARIBBQUBQIFPgVxSc?=
 =?us-ascii?q?1s7RogeA4UuiDOSIIoRglEDVg8BAQENAQFEBAEBgVIBgzMChTwCJTgTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQcEFAEBAQEBAQEBHhkFDhAnhWgNhgQBA?=
 =?us-ascii?q?QEDEigGAQE3AQ8CAQgYHhAyJQIEDieCXIJdAwGfWQGBPwKKIHiBNIEBgggBA?=
 =?us-ascii?q?QYEBJ8iCRaBK5E6JxuBSUSBFYE8gW4+gmICgWCEFIIMIpokCoE0dIEgDoE8g?=
 =?us-ascii?q?QQCCQIRa4EQCGqBeUACDWMLDm+BSYMqBAIULTcDRB1AAws7Oj81FB8GWIEZJ?=
 =?us-ascii?q?AUDCxUqRwQIOAYcNBECCA8SDwYmRA5CNzMTBlwBKQsOEQNQgUcEL4FYCgYBJ?=
 =?us-ascii?q?iSfPccLCoN9oG1NE6kvl3OndgIEAgQFAg4BAQaBeiOBW3AVgyJSGQ+OIAwNC?=
 =?us-ascii?q?YNQj3l1PQIHCwEBAwmLRQEB?=
IronPort-PHdr: A9a23:6sPbyx9ohbClaf9uWCXoyV9kXcBvk7n3PwtA7J0hhvoOd6m45J3tM
 QTZ4ukll17GW4jXqpcmw+rbuqztQyoMtJCGtn1RfJlFTRRQj8IQkkQpC9KEDkuuKvnsYmQ6E
 c1OWUUj8Wu8NB1eGd31YBvZpXjhhQM=
IronPort-Data: A9a23:tQmVQqkMeFCz/d6MjJ5WzW7o5gwMJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJKD2HTOKuJNGCkKYp0b9iyoUNX7cDSyNJkQQM6+So1RltH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaA4E/raNANlFEkvU2ybuKU5NXsZ2YgFWeIdA970Ug4w7Jg2tYy6TSEK1rlV
 e3a8pW31GCNg1aYAkpMg05UgEoy1BhakGpwUm0WPZinjneH/5UmJM53yZWKEpfNatI88thW6
 Ar05OrREmvxp3/BAz4++1rxWhVirrX6ZWBihpfKMkSvqkAqm8A87ko0HNsFKkRdhQzVpcgv7
 fRkjbGgUwIUDoSZzYzxUzEAe81/FaRC/LmCKn+lvInJiUbHaHDrhf5pCSnaP6VBpb0xWj8Ir
 KdecWtQBvyAr7reLLaTRuBqh8knM8DDN4IEsXYmxjbcZRojacyaE/ySv4IDtNs2ruxAAdLfZ
 PsZVR5iQ1PbXx9DI1JJM41ryY9EgVGmI2EH9zp5v5Ef52nV0Rw007X3NtfRUsKFSN8TnUuCo
 G/CuWPjDXkyONGByDGI7mihi8fRki7hHoEfDru18rhtmlL77m8JGgwNR0e8r7+6jVy6XM1EK
 E1X9jYGqak0/VasCN7nUHWQrGGNuh0RQfJeEuM9uVDLwa3Riy6DAWIEDTJdQN8rrsk7QXotz
 FDht9DzFy10oqGSRzSe8aWQqiypOik9KW4EbDUDCwwf7LHeTJobhxbLSJNoF7S4y4ezEjDry
 DfMpy8771kOsSIV/4SivlPNjQvwnICXay8c3ijHRGeY3iosMeZJeLeUwVTc6P9BKqOQQV+Ao
 GUIlqCiAAYmUMnleMulHb1lIV252xqWGGaG0QMzQ/HN4xzoqiD+LNEIiN1rDB0xWvvobwMFd
 6M6Vel5y5ZJOHKsYcebiKruVpx2lsAM+TkZP804g/JHZpx3MQSA5iwrPwib3nvmlw4nlqRX1
 XannSSEUC5y5UdPlWXeqwIhPVkDnHFWKYT7HsqT8vhf+eDCDEN5sJ9cWLd0Usg37bmfvCLe+
 MtFOs2Bxn13CbOuO3GJrNZJcw5SfRDX4KwaTeQKKIZvxSI7Rwkc5wP5mtvNhqQ8xf0Oz7eUl
 p1Dch4CkTITekEr2S3TOiw8N9sDrL50rGkwOmQ3LE201n04CbtDH49BH6bbiYIPrbQ5pdYtF
 qFtU5zZXpxnFG+dkxxDNsaVkWCXXEnx7e54F3D7MGFXkl8Jb1Ghx+IIiSO2qHNeVnDq7pJgy
 1BivyuCKac+q81ZJJ6+QJqSI5mZ5BDxRMoas5P0H+Ru
IronPort-HdrOrdr: A9a23:WMgr5KijfHzv3l1nM75R8TYrHHBQX3t13DAbv31ZSRFFG/FwyP
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
X-IronPort-AV: E=Sophos;i="5.98,333,1673913600"; 
   d="scan'208";a="41810253"
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 10 Apr 2023 17:09:21 +0000
Received: from mail.cisco.com (xfe-rcd-001.cisco.com [173.37.227.249])
        by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id 33AH9Lif024777
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 10 Apr 2023 17:09:21 GMT
Received: from xfe-rtp-001.cisco.com (64.101.210.231) by xfe-rcd-001.cisco.com
 (173.37.227.249) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 10 Apr
 2023 12:09:20 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (64.101.32.56) by
 xfe-rtp-001.cisco.com (64.101.210.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Mon, 10 Apr 2023 13:09:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US1PeQlSfVL5T/37f6h1IJYmXoALogtHkXoSem0R5FXFXiMUEJr7omnWpz3Lr1861MgKAzscCRjk+ARMjj4IfwgJWNe8hiImQqgS/hkOiwfwz+hIy/erTSlrJUU9WgzNKYErC+y7exix58FrQapHU9fI1MiGzgWT7adb9yjMMebjWvWEp1IM29brrcuZmwVVF9u0ZUTfc1Sl2QVBljP5xITLVw3y+6QVkoMxhpIquObDWuo+zaR6y/IVtj+RUkd5wD/1iyw5hNcv3UZe/gdSGrMm4hW0+SwxtanArRxP2qmy7SED9ouvnWwB0a3i8IqwWO+D6RI0F4x9dMZti1KLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2at2MK3D2W77h4xETskMYhbylrnJZSwL9wMxfqcM6Kg=;
 b=ZRTPT3ijB4E3un+a1ukzcHwpZVaSlFxNMsjyigm1QWHmlLmGVLx5G88BqzV6NgtTW9njoC71oPagmuBD84esua/hHkeK+qIngglXcBBUGSckTLoeYkhmko137ZkyVYmXvyJj8rQofoAZ2a0jAwj9rjldnttpS6LachTP6cijN+tMXirEITMVzvHZQ+T4gsr7eBS8IMtnzgpYSyaVo2JKFXgZk9NPMQPM9LN6A1hjtR0DcnCEYcvHGTNsooGUMhz/c4b6g4DhN/rKUEphJsmdTXx88htTIps2CZnBFIb/LnqKd7uGv6dUo4DznmCITpuj8rKd9xCLbOnrcUj8JsSR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2at2MK3D2W77h4xETskMYhbylrnJZSwL9wMxfqcM6Kg=;
 b=HxFd0JFtmwzXId2NTwW3nOOe+qJBBMXWQ3IzhGCKCXRinUFWfTbImlrb47Pp/u41Y2eYvBRoFRkn/slqJaxlrLtaDDpxGm2iSrpfS1JhnRpRyCzuc4DD2+B5/U7IV3109AFXKivE4OFCFVjaz2xREWAR7gvF9eXfoMWX0+5Qrh8=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by DS0PR11MB7577.namprd11.prod.outlook.com (2603:10b6:8:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 17:09:16 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97%6]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 17:09:16 +0000
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
Date:   Mon, 10 Apr 2023 17:09:15 +0000
Message-ID: <20230410170915.GE1391488@zorba>
References: <20230405223028.1268141-2-danielwa@cisco.com>
 <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
 <20230407160413.GD1391488@zorba>
 <6af9effe-89c0-7630-9a72-a5a6351e0a95@linaro.org>
In-Reply-To: <6af9effe-89c0-7630-9a72-a5a6351e0a95@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|DS0PR11MB7577:EE_
x-ms-office365-filtering-correlation-id: 22025431-c494-4f9b-982f-08db39e65090
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eWLDNZUDyIm7/08BdPUtslt6BWaMJxS5vleZx0m4nnecXZYM96ST0EERbza79uaq9rh73+gqHVClY51E5iywriB+r3u1Z89s1hZnvRI0hRs/Ys+8kwI7vgtaA2l7cL3swKd7PQO8nur2XgX3w4jLJ0NuMhi2jU7D+jI6HCCvhM8mTvFfmJ+VK9pBxJyzwJQtxGnXIIIiAHRntiPx78yP6EaY5PiqwXpFGoIZtgsPRaKRQcRPPSWgSP3rpSqupR8YkJwg2BuphF3gTUIPIHXNDo3/DlBaT+X3V0meJOsJcnMfKVKVdXE5ZyRbeAwcbWBibn4c25SWxi/7esnDt2f39r4YaQ04PaeL6D1G+2Pl+dIMOPwt+nYKmizT07Wv6go/nrcCF/qucvqnOrBajklg3lxSEo9mxHg4dNG2v7bxAC8wtPAmh1ermA5JLp7FvD+igt6gjhErE1rL8CmA4TA30JLY8NRQoHhWeMpJdu9GMIl7q2UQReH6sYiqw5vwVTs0TR7QwO12XAYAaTDabRrJUwoS3O9oaxmDzi7mcVnQ/2ZXmM4FwamDNGkPLT4RZonmepoCD8t9ze1oghBAEOifhWTXOdVoACHiRauWHa/rxxLlHd/N6c05DCD6+PiPJzEe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(6486002)(64756008)(66556008)(6916009)(4326008)(478600001)(71200400001)(54906003)(66946007)(66446008)(66476007)(8676002)(316002)(41300700001)(76116006)(86362001)(33656002)(1076003)(26005)(9686003)(6512007)(6506007)(53546011)(2906002)(8936002)(5660300002)(4744005)(33716001)(38100700002)(38070700005)(186003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lW9C9rFteArvIBdShLKsoNs1t/gjoU6Pd6L4BAhB/xq7Dbv8G3BKcdQXLpFu?=
 =?us-ascii?Q?1YFDNAm0cb6PpFDj59RzGeFyAj1qIlpUIobsBzwg8IoX++RiT9+S0IkyWxps?=
 =?us-ascii?Q?lRK9tr4llvEhsds0jEHTU4rMphtr5q4jknRZ9hKxz/koQUluSkxxC0G0jK94?=
 =?us-ascii?Q?SE53BAAxPf5kmvZ8KoE6E99WbwG4hxRsl6WTwcM4tuisTWRi+OgHCLqUvB1I?=
 =?us-ascii?Q?YJT5bDHdNohxTbaYRXq/+c30yZdLCvY/6onApfFeJ6S5ePt0xP3Xg4aHMriS?=
 =?us-ascii?Q?EsSW8WjNyTvhc680jlp8nekBoa5BI5SmcDeMipam6RlOVyfDOSaK2GaFhMWh?=
 =?us-ascii?Q?yLr7McILlDxnQgQPZoXc+uRE2RGYDyDJFCnxmT+NuJqxS0Fqquq1zWDdLm3+?=
 =?us-ascii?Q?updLAm6CvjeVemMMFNb6dgDjsCUL2VX5tWS0M9axT/pWtDa4RDqLBWSkk1dH?=
 =?us-ascii?Q?ecN1G+cPBdOa0Z4jVUWmLRaAnuQ6lEd2SMrq4ICy1vmfpTfrpEL0omSU/Khw?=
 =?us-ascii?Q?3NTuITnKF1f3TQrvk7bUDiZgQeJvucafNrfcs4NBVp8lLVVnsAjq+0KnRjd/?=
 =?us-ascii?Q?frw/LdgJcGMnrSQsmQ/WiabQNwLu7ARey3N7aotGfwV3C80b7fvQRQcKODFt?=
 =?us-ascii?Q?LQXYscf0TXPWMNckb9gZaknE76F7rOdgBC5aZq6V9cOKATIguFnwaWfTZZm3?=
 =?us-ascii?Q?3hUmVBanIquZ+d7En9attRI294gZbXcBNFj9tUlQn3UqfaVRyWB3V6Plfrkw?=
 =?us-ascii?Q?TTPh6HBEsC0Immj0TMQR5qQoZCorRXjSjeFWlbdXRu0NbOYuLf8yzlxavwDI?=
 =?us-ascii?Q?ZXdrJTLI8HPYzSjq328Ij8FUq4E84oImbvHEBLfpU1Y7EdFHeILN2rC0gNc4?=
 =?us-ascii?Q?W9XVp8cK0BLMQcghd8U7uqxwPTdRlpAh/mFMoqvdM0E0NLBe4hOWwRruc3Kw?=
 =?us-ascii?Q?zRzShyrxDv0Jk2uEjCvxaumGinNG6V4Vxw3qbEsjjqOiUCTS2rD4sarxuYJE?=
 =?us-ascii?Q?cCfOWYr2vKGGWl4Fex13mNvzbkTZKQJuB6UaVWeFkaP6WcyR3QrKlPpF2q09?=
 =?us-ascii?Q?JCoM+/rkdMUh4h5YbBTriQw2O2v/cy7qeGiqTHqA4EX3ItCE9Kahp6rWX2nS?=
 =?us-ascii?Q?j6AZZIVHPRlWSZ7ruxsTm0nZapE9DvReO31qDk0qaUpgTxT9XG2LG1R98HkG?=
 =?us-ascii?Q?D9lzyvSNzPwj59ajgqb8UgMQ5ffrunNn8t9ojeAW9C/g2+f3yGvOsJhbA4lZ?=
 =?us-ascii?Q?6BO+F3FlEtukxoaem41KVP1UCksOsnWiF8rCZzwnzF+5BIV/L/58ZSV/cTjn?=
 =?us-ascii?Q?5YHuP3+2OJKJgZOGM6Tmgq6gnaVZFuZYrzqGgb2FmwJkTpvJwExU/EqZFTyU?=
 =?us-ascii?Q?WMhuI2aXMivNrDcbaQfXcp5xmV3TTAtqh2bPDnvI2DEslgrf0/eNmDyK2MGh?=
 =?us-ascii?Q?yQbS7BPO/ZIEPaADr8nTKUQogvJhqDN8PyGasZ5VWbxkNwssvADVlN4BDVRT?=
 =?us-ascii?Q?szFhfQpWM2V3vZP2aDcKgVXRDhVdRtxMuWpoJs1ot9KK4FuJp5CHNAQ90hZu?=
 =?us-ascii?Q?qKMPdXLHqFPq0pwu0V4/h7MRICJ22B/2JXUQWoL1?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <97DBFB20AE2FA04CB72A7C2204FF6456@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22025431-c494-4f9b-982f-08db39e65090
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 17:09:15.9689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V5lG+icz+fM+prEqZvj+u7Odr0/kzzZ7WUMr0G9HJd7W6s519ke04HZwYXY/b4pQTA89xw9UqRs9IdrWwOjv/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7577
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.227.249, xfe-rcd-001.cisco.com
X-Outbound-Node: alln-core-2.cisco.com
X-Spam-Status: No, score=-10.0 required=5.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 05:28:03PM +0200, Krzysztof Kozlowski wrote:
> On 07/04/2023 18:04, Daniel Walker (danielwa) wrote:
> > On Thu, Apr 06, 2023 at 09:12:34AM +0200, Krzysztof Kozlowski wrote:
> >>> @@ -0,0 +1,27 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only
> >>
> >> Dual license.
> >>
> >=20
> > What are my choices here? I see this,
> >=20
> > # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>=20
> Yes, the one suggested by the checkpatch. Did you run it?
=20
 I don't recall if I did or not.

> >=20
> > Which appears to be what your suggesting. I also see this,
> >=20
> > # SPDX-License-Identifier: GPL-2.0
> >=20
> > I'd rather use the later.
>=20
> Why? Bindings should be licensed under BSD, so what is the reason to
> make here exception?

I'm sure I can re-license my submissions. I'd have to look into it.

Dainel=
