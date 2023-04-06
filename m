Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A346DA0D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbjDFTPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjDFTPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:15:14 -0400
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4637CF2;
        Thu,  6 Apr 2023 12:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1155; q=dns/txt; s=iport;
  t=1680808513; x=1682018113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gfFWh3AhS3mHFbLMb54PNwpRLnhaMQXqXpGQpESDkgw=;
  b=QcsVvLkz1BM9vcfjhLkO8YgfkN1HeLTd8U67TNKQLHpqNWaK5FO+5jJb
   +KbBLI0mqkXWZfCrj0j3Sx3D+jh9nAgi6FDUxXaJoAeG7RgHU8rRmCL7x
   XEfnPriYt4ZR5zirLjv+buxYCGt7NJvfj8MMFaGuayMGoOrHOYz9gqBTk
   Q=;
X-IPAS-Result: =?us-ascii?q?A0AZAAC5GC9kmJxdJa1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYFbUnNbO0aIHgOEUF+INJIfihGBLIElA1YPAQEBDQEBRAQBAYFSA?=
 =?us-ascii?q?YMzAoU8AiU0CQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBBwQUAQEBAQEBA?=
 =?us-ascii?q?QEeGQUOECeFaA2GBAEBAQMSKAYBATcBDwIBCBgeEDIlAgQOJ4Jcgl0DAaBDA?=
 =?us-ascii?q?YE/AoogeIE0gQGCCAEBBgQEnyIJFoErAZE5JxuBSUSEPz6CYgKBYIYgIoEMm?=
 =?us-ascii?q?RsKgTR2gSAOgT2BBAIJAhFrgRAIaoF5QAINZAsOb4FKgyoEAhQbNwNEHUADC?=
 =?us-ascii?q?zs6PzUUIAZYgRkkBQMLFSpHBAg4Bhw0EQIIDxIPBiZEDkI3NBMGXAEpCw4RA?=
 =?us-ascii?q?0+BRgQvgVwGASYknzUrAZV6sGQKg32gbU0TqS+Xc6JlhRECBAIEBQIOAQEGg?=
 =?us-ascii?q?WM6gVtwFYMiUhkPjiAMDQmDUI95dT0CBwsBAQMJi0UBAQ?=
IronPort-PHdr: A9a23:CRuguRPrWOfnVtUGGVsl6ncDWUAX0o4cdiYZ6Zsi3rRJdKnrv5HvJ
 1fW6vgliljVFZ7a5PRJh6uz0ejgVGUM7IzHvCUEd5pBBBMAgN8dygonBsPNAEbnLfnsOio9G
 skKVFJs83yhd0ZPH8OrbFzJqXr05jkXSX3C
IronPort-Data: A9a23:c3HHoqlXiLYR4uOITDPh2Ffo5gx0JkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIeCG+PP/6JMWGhfIsjOdy+pBkEucOHndExT1dopSo2H1tH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaA4E/raNANlFEkvU2ybuKU5NXsZ2YgFWeIdA970Ug4w7Jh3NYy6TSEK1rlV
 e3a8pW31GCNg1aYAkpMg05UgEoy1BhakGpwUm0WPZinjneH/5UmJM53yZWKEpfNatI88thW6
 Ar05OrREmvxp3/BAz4++1rxWhVirrX6ZWBihpfKMkSvqkAqm8A87ko0HMEybRxNlw6Mo4hs5
 P8QnMOKT0AFIbKZzYzxUzEAe81/FbdN9LmCKn+lvInOiUbHaHDrhf5pCSnaP6VBpb0xWj4Ip
 KdecW1TBvyAr7reLLaTRuBqh8knM8DDN4IEsXYmxjbcZRojacybGfubvYMAtNs2rtJfQ+TvS
 eteVRtMfAXQXwRvI3s+LJ1ryY9EgVGmI2EH9zp5v5Ef52nV0Rw007X3NtfRUsKFSN8TnUuCo
 G/CuWPjDXkyONGByDGI7mihi8fRki7hHoEfDru18rhtmlL77m8JGgwNR0e8r7+6jVy6XM1EK
 E1X9jYGqak0/VasCN7nUHWQrGGNuh0RQfJeEuM9uVDLwa3Riy6DAWIEDTJdQN8rrsk7QXotz
 FDht9DzFy10oqGSRzSe8aWQqiypOik9KW4EbDUDCwwf7LHeTJoblBnDSJNoF7S4y4CzEjDry
 DfMpy8771kOsSIV/56V+QvdnwmpmsDUYiRoz1rtWCWJ8RwsMeZJeLeUwVTc6P9BKqOQQV+Ao
 GUIlqCiAAYmUMnleMulHb1lIV252xqWGGaD3gM3TvHN4xzoqiHzJ9kBiN1rDB4xap5sRNP/X
 KPEVepsCHJ7JnCma+p8ZJi8Tplsxqn7HtOjXffRBjavXnSTXFLdlM2NTRfAt4wIrKTKufpnU
 Xt8WZ31ZUv28Yw9kFKLqx41iNfHPBwWy2LJXozcxB+6y7eYb3P9Ye5bYAPRN7Flt/rY8Fy9H
 zNj2y2ilko3vArWP3e/zGLvBQtiwYUTXMqv8JUHKoZv3CI2ST9J5wDtLUMJItw5wPs9ehbg9
 XCmUUgQ00vkmXDCMm23hoNLNtvSsWJEhStjZ0QEZA/ws1B6ONrHxPlELfMfI+J4nNGPONYpF
 ZHpje3aXKQWItkGkhxABaTAQHtKKEXy1FzQYHb/CNX9FrY5LzH0FhbfVlOH3EEz4uCf7KPSf
 5XIOtvnfKc+
IronPort-HdrOrdr: A9a23:ZCa6tqOl5I/7Z8BcT2D155DYdb4zR+YMi2TDiHoedfUFSKOlfp
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
X-IronPort-AV: E=Sophos;i="5.98,323,1673913600"; 
   d="scan'208";a="40269040"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 06 Apr 2023 19:15:12 +0000
Received: from mail.cisco.com (xfe-aln-003.cisco.com [173.37.135.123])
        by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 336JF4RH014601
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 6 Apr 2023 19:15:11 GMT
Received: from xfe-rcd-001.cisco.com (173.37.227.249) by xfe-aln-003.cisco.com
 (173.37.135.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 6 Apr
 2023 14:15:10 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (72.163.14.9) by
 xfe-rcd-001.cisco.com (173.37.227.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Thu, 6 Apr 2023 14:15:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIJzzmMDPlT8C89JACHaTSZc6LuxHUiU5Wb1bypVT6DMuT9R7oarD+VwstP1N1VKNc1ix+Z+2F9Z9YYF4pBQgH5hRDb2sgjGfdJ0XYgspZ6YafDgMbgI8/bpCB+kreTkKg7vAnLwtFf7D9qX79ZhDpLGOU05wDF2EapbQyCHyUitkda8UgxIzshKCGSA09MhFd3oD88dmBuIPp1Am0L0PxRz2KbMXrDZ0Vv+2OQbud7/VtqZUZImG8kcWDaNCCdCimoD/RDLb90nHAogRS8AYopb/mINtAFWn84EqKjjkentU8CWBH/BZxH4ki8b0+q+wEOu85BPvuMCySyQD8H1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfFWh3AhS3mHFbLMb54PNwpRLnhaMQXqXpGQpESDkgw=;
 b=Lju5ANOKt9xJwZE3INGlQOqNXcesuc97Wz9tjFR/Sqn8sJU0Ff4FbtwLDI05S4tknUjpOSzg6Tq546sZbHXkPEzHeYv+Gg06h7wElqubwHH/T+SLACIB9cL7iYkzRItZ+V8mAN/lUAGlcfRX89nqNzZXU8sUkH4tf6dh8X+VdqXCuW9eueROw9Z1czmO0mledQHrP3aRJxJaTX+oly5JxWjcriMsacn8Vc4p1LrHynOMEjfO3zhyAvUNjSD0xEIsw43gt/DkMDbg3YCaTy1t7HHbowpAALTH2Z1mt6+qYn2wjeg3CNCrWDPzUZi7uwO/zBaCuYO1gBbJqWBkik1YdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfFWh3AhS3mHFbLMb54PNwpRLnhaMQXqXpGQpESDkgw=;
 b=ieU4/IJJuK53WR6td7h1FCg9sZMrzicndLcZk2LLTYrM/dc4I/tfbabH+2l67yNeOJtRjSCuqFtwPeVM3pWIvUYUPODlTkVL3QWvQNyifiic1YArrAXjmCbuNdeOCc6M8C09Z9+jdHnvp8w5H+5rxNUjEc5FtZrUTY2R/bd608c=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by PH7PR11MB7662.namprd11.prod.outlook.com (2603:10b6:510:27d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 19:15:07 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 19:15:07 +0000
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
Date:   Thu, 6 Apr 2023 19:15:06 +0000
Message-ID: <20230406191506.GN40472@zorba>
References: <20230405223028.1268141-2-danielwa@cisco.com>
 <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
 <20230406151512.GL40472@zorba>
 <14634180-aca9-a3e9-d1af-dfaca77b42ee@linaro.org>
 <20230406183253.GM40472@zorba>
 <5e2e5b82-35ae-c3b5-becb-40d387226a7a@linaro.org>
In-Reply-To: <5e2e5b82-35ae-c3b5-becb-40d387226a7a@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|PH7PR11MB7662:EE_
x-ms-office365-filtering-correlation-id: 69bb0418-4d57-4bc0-7c3b-08db36d33b9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: STOnFiZCxSe9Cr8OfMmEE0yNWCqVPIdVwp6ejIMyRG9LFfSbO9NlGuOyv5/vJsmucBF/M7jOuo7gKcyPFbBcVYJnUFh1H/0a8BDurLUrl3Nux2xH0A0HG/6dyAdce6Tjo6dQup7573kaYEMxsL9eQOgX79CA7dhhr2BRdxpVsG31oOAwHDgqeTkYl2BShAzb1urs3hUzrJNiy2deJMyvZy5Qb9Hu969UN45quNCcs+Y5WqtLWhpDMpBeN+Z+hTnGBiusuOPwDtkphNWLZHAMtGh0FKhCfPLW+k5F5VmJO10WsUeH1A2NsVrvL9Nzte6inFff3U2sFl9wc6iPtdD/ClU4oRjai6dAwA89I5ou08ggtOXwt22hXZttJW4V3k6ev2bzERz/Yo7DVrNGLhANyGy7sSSjocfMBCJpujsXl0cYEKzbMAOENTiNH2XIEAfcTh7WVtj+EL3dIbvofU6trlb1IlEZmwtrOY/8OWtY9yLkQIh5wDaq5gJFihdJifURTwI4M71tiq9pvmx+rrjdjT7FP2HE7YzygOD9twciLdrvqwOJNTmtGbMQ/OkGvjdr532st8C9/YPLZaBUNZBWfQQEZbSdSX1l+GXFT5d2iZm2Vu8Rvy8cT2tmFFVUIxro
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(41300700001)(33716001)(33656002)(186003)(6512007)(86362001)(9686003)(53546011)(6506007)(26005)(5660300002)(1076003)(54906003)(8936002)(316002)(478600001)(6916009)(66446008)(66476007)(4326008)(64756008)(8676002)(66946007)(76116006)(71200400001)(66556008)(38100700002)(2906002)(122000001)(38070700005)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ayjpnPDQgn5Mi0gkw9Zur0iK5ze5/XUwj/lAPlESE9ZnxeJq3IGZZa1HpeS4?=
 =?us-ascii?Q?qjiHK6WGDPHre073saEv8ZRD7E4Jv2PmJM78FP90Qqdz21Yd5eAgd29biHX4?=
 =?us-ascii?Q?yNsXEX6HAB/63EKVcQ9pHLruAwQfl+lRLznzpE3J9P4ETclBR9lck8cbV0oR?=
 =?us-ascii?Q?iZvLrpM0Tv9nFm7i7/UGpnU+axwv8NLkyZGWJVj6qMV7O8HziRjBdbXoz+MC?=
 =?us-ascii?Q?Q/naBTRgtvMxE51KkLz2c+3j3xyZhVNj0/k3eM3uuyrcJmW5rsNfeoBPASQC?=
 =?us-ascii?Q?oMr3OzkZmb2fDCFfN7pJ+ppLEJrzU4QjID9dk4N7voDllC+UuIQIHyB1Rk2Z?=
 =?us-ascii?Q?TDYGDqYZlGKfaaeNRe7Jq9R5g46xWDOfTBma+IAajTeX1iESgmrDoEjvM70V?=
 =?us-ascii?Q?ZNtflYXFpDAsx9wY7p5fB4ydK4gEwuiS4iC1D1BLyUQU/jSS0I9iOuw5eBPn?=
 =?us-ascii?Q?drzXgLd+DDb16sc10N9EPyRFSBTS+LnRsnPju8Fy686QjM3Hdn7ZpNckCKQ6?=
 =?us-ascii?Q?DOJwcvA7PfoLgaBJGr/RrNVZv6fFAKdC11f60hZANr8rPJjBGwGSfKmsCW4F?=
 =?us-ascii?Q?h2dHTfREREBuEUZbDBvASuo00fyVyWCJ0avFuNSjTha4vI+MFJevbq2ESV6C?=
 =?us-ascii?Q?v+CHYMWD/nrfTXMQNyKT4+iDBmHB3f9W2ZVW6Qp8jguH0BcF0i1CrJqLrEVI?=
 =?us-ascii?Q?UtOD1J4ACxlyXFKiDlAPtqtve/e4ERdaZcuIn4r+c0LSfVOdVU2uBDOudNVt?=
 =?us-ascii?Q?8R204W15I/t7AWrUx3500bb95hQJzcCY0EC4jpzkvExGurLDK0K5UWrygqcG?=
 =?us-ascii?Q?zsgX1AWNGZb7KCmYque11NCUK/wlE92KMCY/TF1lAOAHCGLLZkJDotqOl1cu?=
 =?us-ascii?Q?YcEGnis0wd8nX+pr+pXA2rGfyGrZfK99IMgTohRaMzla5Gy5r0NsYZoQfBnk?=
 =?us-ascii?Q?7ocFSen+ITOR35/dcT6+GKO1AHVGjLEHJmno1BgI41hBIDWtIXJ7grvi81eH?=
 =?us-ascii?Q?KDRzKAVSVIIMAupCkjvrL+lHGnWbMWmRnRwgihv1pKH/lPqJzB/UBBF723cc?=
 =?us-ascii?Q?qPn1mgazaRKLsJJn342GHOrSC4VNl/QsC5D259Ct/bxK8qCCxKpG/XnzFwJO?=
 =?us-ascii?Q?EqFD8IOLqqC0rsce4E9ZRvFHyFCtlGJuB6S/dY8ord33klpYbWUNidl3Lj/O?=
 =?us-ascii?Q?NpI3bhtkH8t76d5mM/Gg90ICLj4g0jjMCS5/9KwCWe/5A1CxG/2rwBX8pdgz?=
 =?us-ascii?Q?M09SUzF+JBSXMrGCxEdRpKtJeresAEsqUOC9AjgostQJ0wGY5buHWIfwf/Z9?=
 =?us-ascii?Q?8HP8T5soqaCXMZtTIyN2EaYGHsofZT3o4Md0s5NHoML5UhsHo11RoX9x0et+?=
 =?us-ascii?Q?AeRmBbLw+kJQT6McNHhrUI/m10KcLBqV49XvkfADCtZ7aI9GEVutaQ1FW+Pj?=
 =?us-ascii?Q?jdiBbFeLBVGwR7sAPFxwTN0J0MF0Ozjjy2mrzYzY9zeksO390Wi5HCeK8E3F?=
 =?us-ascii?Q?q9qSisQ/DzuIF+MrqHN95t/dYupOxWpPIItjg8osxhXTAaznzihYgOAjFeAN?=
 =?us-ascii?Q?8H2OSuxHzNn7wDo3nq57VSkvYGGx1lJWx1ZmDjKZ+pUAx0fzUWpmEQ5/yuh5?=
 =?us-ascii?Q?wQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ACB70F62A4528D439731D6DA1A367BD7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bb0418-4d57-4bc0-7c3b-08db36d33b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 19:15:06.8736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9p1Yziy1UP/gQUvYq2T9sIZptnGac5uKQ6kTM5Y2fN7UL2gJhNrnH7fCkPigZNIikGzD1poI/cuOrhdocBApgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7662
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.135.123, xfe-aln-003.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com
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

On Thu, Apr 06, 2023 at 08:56:06PM +0200, Krzysztof Kozlowski wrote:
> On 06/04/2023 20:32, Daniel Walker (danielwa) wrote:
> >>>>> +++ b/Documentation/devicetree/bindings/arm/cisco/crayar.yaml
> >>>>
> >>>> How many (or not many) platforms do you expect from Cisco? We mostly
> >>>> have one file per SoC manufacturer.
> >>>
> >>> We have two SoC's one called CrayAR and another called Craw. I've sub=
mitted the
> >>> Craw dts file before , but I've not resubmitted it. Under Craw I thin=
k we have
> >>> at least two, but more likely five variations. CrayAR we have one var=
iation with
> >>> at least one more planned.
> >>>
> >>> So we would plan over time to add two dtsi files and three to four dt=
s files to
> >>> this directory. Then more over time.
> >>
> >> So just keep them in one file maybe.
> >=20
> > If/when I submit again with anther chip we can discuss it at that time.
>=20
> Or you can do it now.

What do you want to talk about exactly ? You said keep everything in one fi=
le, doesn't this
already fit your suggestion ? I'm only submitting one file.

What are you envisioning Cisco to do ?

Daniel=
