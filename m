Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA556D9FE7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbjDFSdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbjDFSdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:33:08 -0400
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BC586B0;
        Thu,  6 Apr 2023 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2778; q=dns/txt; s=iport;
  t=1680805979; x=1682015579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1WaN1hf0htWHYpk0rKJdym7EqCL/C7MxHb+mWwmq3ms=;
  b=C3WAmMb9qkqzgyUrsOTgQf0++s/ypVtHQ9rpQrWKgCGE139PRT/roas1
   FtWHGwygCUsXqHx1vALJELgyDf4iMxm0w/O7tYhMGzvl/WTexNUxHzsNd
   Gu6RNlpAjXgFRY4s13Gm3XBUToBT6rnbRZFx5JRsiAVanJApYx3uNK7wW
   c=;
X-IPAS-Result: =?us-ascii?q?A0AZAACbDy9kmJtdJa1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYFbUnNbO0aIHgOEUF+IMQOSH4oRgSyBJQNWDwEBAQ0BAUQEAQGBU?=
 =?us-ascii?q?gGDMwKFPAIlNAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQcEFAEBAQEBA?=
 =?us-ascii?q?QEBHhkFDhAnhWgNhgQBAQEDEigGAQE3AQ8CAQgYHhAyJQIEDgUiglyCXQMBo?=
 =?us-ascii?q?EkBgT8CiiB4gTSBAYIIAQEGBASfIgkWgSsBkTknG4FJRIQ/PoJiAoFghiAig?=
 =?us-ascii?q?QyZGwqBNHaBIA6BPYEEAgkCEWuBEAhqgXlAAg1kCw5vgUqDKgQCFBs3A0QdQ?=
 =?us-ascii?q?AMLOzo/NRQgBliBGSQFAwsVKkcECDgGHDQRAggPEg8GJkQOQjc0EwZcASkLD?=
 =?us-ascii?q?hEDT4FGBC+BXAYBJiSeHTQBYysBlXqwZAqDfaBtTRODaoxmhmuRdJdzomWFE?=
 =?us-ascii?q?QIEAgQFAg4BAQaBYzqBW3AVgyJSGQ+OIBmDWY95dT0CBwsBAQMJi0UBAQ?=
IronPort-PHdr: A9a23:bnusHxJhPTrYVyqwcNmcuWEyDhhOgF28FgIW659yjbVIf+zj+pn5J
 0XQ6L1ri0OBRoTU7f9Iyo+0+6DtUGAN+9CN5XYFdpEfWxoMk85DmQsmDYaMAlH6K/i/aSs8E
 YxCWVZp8mv9P1JSHZP1ZkbZpTu56jtBcig=
IronPort-Data: A9a23:C3698axn7bvsoKu0/X16t+fCxirEfRIJ4+MujC+fZmUNrF6WrkUHn
 TAXXjuGPvfZYGfxKoska96woE1Vu5fWn4A1SAs6rFhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJloCCea/H9BC5C5xZVG/fngqoHUVaiVakideSc+EH160U47xbZj6mJVqYHR7z2l6
 IuaT/L3YDdJ6xYsWo7Dw/vewP/HlK2aVAIw5jTSV9gS1LPtvyV94KYkGE2EByCQrr+4sQKNb
 72rILmRpgs19vq2Yz+vuu6TnkYiGtY+MeUS45Zbc/DKv/RMmsA9+rkQa6YOSl5NtzTTtM0t2
 eVxjMOBbi58a8UgmMxFO/VZOzt1MasD87jdLD3j98eS1EbBNXDrxp2CDmlvYtZeobkxUDoIr
 KFFQNwORkjra+aezLu9S+Romc0LJ8jwN4RZsXZlpd3cJap+H8+YHPibjTNe9A4AmcIRJsrTX
 OsybyB1NBTxMiQSI25CXfrSm8/x1iWgLFW0smm9oasx/niWzwFr1rXpGMTad8bMRshPmEuc4
 GXc8AzRDhwENdeS1SCI/1qyieLV2yD2QoQfEPu/7PECqF6J1H0IGgERWx24puu9jVGlWNMcJ
 1A8/isopLI1skuxQbHVUwKxpH2JpDYSWtRXQrx84waIooLO5AyZRWQYZj1MctorsIkxXzNC/
 lyTjcLyFyBovvuWTmCZ8aiPrjKaPSkTJHUFIygeQmM4D8LLuoo/iFfEScxuVfLzhdzuEja2y
 DePxMQju1kNpdEgiPmp3kndvzP2jYWVXz4J31rmeUvwu2uVe7WZT4Cv7FHa69NJI4CYUkSNs
 RA4dy62sbhm4XalyXTlfQkdIF26z63ab2CE0DaDC7Fkpmv9oSfyFWxFyGgmfB8BDyoSRdP+j
 KbuVe55/pRfOj6harV6Jt73AMUxxq+mHtPgPhw1UjasSsYpHONk1Hg+DaJ144wLuBJ8+U3YE
 czDGftA9V5AVcxaIMOeHo/xK4MDyCEk3n/0Tpvm1Rmh2rf2TCfLGe9aaQrSNbllvPrsTODpH
 zB3apTiJ/J3DbOWX8Ur2dV7wa0idCJiXsmm96S7iMbTc1QO9J4d5w/5mON9JNMNc1V9nebT9
 Xb1QV5D1Ff6nhX6xfaiNBhehEfUdc8n9xoTZHV0VX7xgiRLSdj0ts83KcBoFYTLAcQ+l5aYu
 dFfJZXZahmOIxyakwkggW7V8N07JUr12l7UV8dnCRBmF6Ndq8Xy0oeMVmPSGOMmV0JbaeNWT
 2Wc6z7m
IronPort-HdrOrdr: A9a23:/htKhaNYO/uyIcBcT2D155DYdb4zR+YMi2TDiHoedfUFSKOlfp
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
   d="scan'208";a="40673759"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 06 Apr 2023 18:32:57 +0000
Received: from mail.cisco.com (xfe-rcd-001.cisco.com [173.37.227.249])
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 336IWviP004128
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 6 Apr 2023 18:32:57 GMT
Received: from xfe-rcd-001.cisco.com (173.37.227.249) by xfe-rcd-001.cisco.com
 (173.37.227.249) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 6 Apr
 2023 13:32:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (72.163.14.9) by
 xfe-rcd-001.cisco.com (173.37.227.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Thu, 6 Apr 2023 13:32:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCLHJBDdeAFlapEQAwjLgYOTw2AxgxZR5H5RZLvpaF1FqFMJjaMxkzNHJUGxAAaT13hSIVJrPgKqVHW74E3ndPPlmXR7UxDIKV+SofQU63x7uy+h6QpH8BXiPahCO6QH7O1rJVBQYJwZGrOFjd+ep9wihbJ65DJzLszSKaSeGP2OAss6pV2JQpQTRCBZ7xSN0nmn5LfTL7MAUMzwJf3OAYYt+2zqJuHPEeFk5zc2vfQ4vOaPUInA/F2b2tHddUuj+sA6kdgXbVYokhHbIbrHze1sXMuG4/xL6K/ppiCAjArQKzHaQIi5Gz3tcEo8zP41v5e1pSARqCFLoESGe9i4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtKi9ujeeSsCQXDwKAtzKM2tUWEMSYqOuS/3ctZ4dt0=;
 b=YWdapFI9uAjy50EXxXXhkbteIeaazWXgJ1GiwA1F/ATydXiRVDjW8MlFRYbxP1iXLk+bBhf9vGQbMTVuEBZ5kzHwX4YkedNsbdF6wKorMDg2SxBbluPsfJpTvdP14MjbDUWsmaMvx7kaiI6f6kOIo4A2DbuLQ0yytEnsFl5JO7jXK0a4KwxObLCGjgd2IWeduOIasNNFIjv5RQc8EEjcMjnY2vEqf1EKVSw0T6m/1IurPEiUEvW9jK/Vse1xWOTc5zKlZ8Zc9cxm7ps+tXYI+UVbbyFRgysCf7BjBf/FuJ6J0DFE7gYLmENVefwoSI64O1PbiThDuSDzdNsyegxqYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtKi9ujeeSsCQXDwKAtzKM2tUWEMSYqOuS/3ctZ4dt0=;
 b=GBunQNRppLw7bZfr/jE/k5DDIRbwTXFlzXg4oWFHOB/Zv+1pAh1BMvqv35DBDjiA0PviuPJ8mTA/XOx9Vr6O8fnuPISVNxYWQbU4XVeBrqLS/MPXCdA0ixi2jX8wyrF7lZqLY0UHpgm8osNAwBaJbB5YPPf4UDm/kC8eq32LSsQ=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by IA0PR11MB8355.namprd11.prod.outlook.com (2603:10b6:208:480::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 18:32:54 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 18:32:54 +0000
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
Date:   Thu, 6 Apr 2023 18:32:54 +0000
Message-ID: <20230406183253.GM40472@zorba>
References: <20230405223028.1268141-2-danielwa@cisco.com>
 <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
 <20230406151512.GL40472@zorba>
 <14634180-aca9-a3e9-d1af-dfaca77b42ee@linaro.org>
In-Reply-To: <14634180-aca9-a3e9-d1af-dfaca77b42ee@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|IA0PR11MB8355:EE_
x-ms-office365-filtering-correlation-id: 41c0a87f-1797-4748-7d52-08db36cd5637
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HIyO3UQ4UG6YWT9OH/G6PIQWNGMKRV/CKVsRUfZmSnt+wOPPBkxE1saZmZS0PKgxr7k/UoGCulUtxbIu42ZRLoKsfAHw5gEyJ8u21z+xLRWRQaEzbGKOY3S8hsdmlTZ7U2tiaNdZn1WZQOhYIvA1J/o2VusLAWmYYufxLdmExcRP2U3AGSY9ujqCfZdhO73M0rFT5/Yfru8kNkjdf7tx7IOCJJ5hPIkixUFofG/pYzaf7mMcbeTN8nBtSLEyTAjX37Yy23k8zGUNZM1M5FjtUwPrXwmLrBYNz8tc/Qi9VXAnxwVKz/jOk7FFVFSYxoRoZkROvHm6pNbkhhX9p8FRm4t+ObMHo2CPcgP7Bx7w/aR9eijzuAswv7E3YXqP8nURjKXCdGmWwQq2sLDu8lFDhjB6gPVcGgpmSu1tKT1pEwp/U5Vqfr1IGIATPvsdoprqAVjQeyarzZQFhNURjTN/Cfr1mDlUsGSlFe1X8go0RzY12jSIfFW32A03MilVdj3Y+wX7DjdZ5x10QcoG/qi2OmaJdoo9gnf6TFv45l87kCRO7EauPdqxajDWBVlkqiESo3Y+Odf3UdMty3ghExwSXPRDdOpV8Jcje9O0VYobR6ZtQXui1+fS8RcGV8dgD62/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(8936002)(83380400001)(6486002)(71200400001)(478600001)(316002)(1076003)(6506007)(26005)(54906003)(186003)(9686003)(53546011)(33716001)(6512007)(2906002)(4326008)(5660300002)(33656002)(38100700002)(64756008)(6916009)(66476007)(66446008)(122000001)(8676002)(66946007)(66556008)(86362001)(76116006)(41300700001)(38070700005)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7mWv0X8kdOqcWPVGfPEsfMakTDzHAVe3APjrW4kbintIyAow8N0t/kU6C4Or?=
 =?us-ascii?Q?cCayh/O547iZtPlIkhskefx407y+CB2YNmwGn4iLC5GfhSwbIYnRtN+0+/zU?=
 =?us-ascii?Q?ITIdXaXYmzD5ij06QgRrL0/D+v69mHNWwGhYm9I8V7kTRNLMGCtp88+kVRMe?=
 =?us-ascii?Q?cst9NELWrOgpHxPrw4v+lSL9byRRmJYvsofZh0ha+UMjDU1KPi61EMcOo7Nf?=
 =?us-ascii?Q?u9uWhybUn5cEsre3SIdvpwBpAV0eX7t3Ccvwb5BDcV2RkSnv/TpARyjhkl2K?=
 =?us-ascii?Q?5XXjqqTU0b0VFvuiueJDa5YLm4sN0Ql25OaPPQw8RegZ8dCt0h/bqpepkVSw?=
 =?us-ascii?Q?ZWw4/xmQwIwPWKFtfIdCsEduC9/vhUNAYu0A1yUU1LC1wsJIEBcfkIMg4TFy?=
 =?us-ascii?Q?/n3kYu1Rd1ARysa8hC+AujSfKe/I02q/Odq3ClWOHe+dPlW8cdmoNVzUmcfr?=
 =?us-ascii?Q?jxQYpws75OkF5LhlmUL4Si++bOi4Humpe6gTnUD8Z2wZxYLUsAvQP4IEktVv?=
 =?us-ascii?Q?i1a++OuzbMMX0EPKQ+HV5oBM6TIe5ACD/UDfkXrWfl60a9mULT7NfIHDduB1?=
 =?us-ascii?Q?qzcob/6OZR1AOM02d/U3sNcQjBnOmSLmj4YgHfMxgjXqz4Yv2uNJibbluqdy?=
 =?us-ascii?Q?upaw7jBWACbsSDy9iBVb8gDvMv9bQyKmCCWgdDj0nAX1n6cuOd9Mo1PRzG6a?=
 =?us-ascii?Q?VWeH8g3faaBDcs2+1Stl/l88/wqJ1nzguEH5zsTX3ekdX4CYpx+KZnqmGCaq?=
 =?us-ascii?Q?ye1wOSL6OINBi/qXZgYAcFrpC8RlnLUwjsqOWOnQlltxH2yAfw/R/BSmrhcF?=
 =?us-ascii?Q?DUJMPjU3M6Y3YBcIUZXpYo113Lt1H7F3PJAT5DC27EQ4HAkhcm+g1D5U9E/5?=
 =?us-ascii?Q?HsO47a5+non4WtYwHyD0B/rGumofZt/FL6wyrAymGDqgFvOEIEVsEERFBa4t?=
 =?us-ascii?Q?gmz+wh1CyLVO6T2v+mRy3fu+4tZPo+7x07P5dj8KtcG1ntlKXM5XSCqRehh/?=
 =?us-ascii?Q?D8m31jFBExD7GQTqixxiCGkdjAk9VVIC8o5S6wMTcluAbzoGR1SKQQiwmVrn?=
 =?us-ascii?Q?/UygxTETH+gaRPGRn8Ne5oe2O0N13ruCC9kzAnwGSNR+IWKdLT70TBw2B97c?=
 =?us-ascii?Q?VUHil77ppaAIqkMWCpsRFOpuWk2XdQveXeZ4OpPNPLqBxaN9gJpBLidyyNAJ?=
 =?us-ascii?Q?E5a63r7k0H0dMgeHtcphJRCBTTSjT3hepoNgmdSLq8Q5erhlXRz3AJGuPPj8?=
 =?us-ascii?Q?fkPAgCSyJqnRoYCG7367bDWUnk+PCLcaSa0+BIm1vtnwuUrNGwFuFFwXAlGB?=
 =?us-ascii?Q?fQ2eWvQVG85iB83VIYnPspcntz81rYurbQAsnruLVvc+cMWTsIs4DoTsLcu4?=
 =?us-ascii?Q?iKjih9W5km1TeC2Qc63igtKsWNKK9iReh8TuQDzDjkNAQjomB03GBkBxNxiL?=
 =?us-ascii?Q?kMaEi7fC/u9ywnCA0V/r4zZ0psmFjv4lltS1Ujqm1b9ICd+rrfszRKu7PnHD?=
 =?us-ascii?Q?r7wmT+fy2PcSJSieKv0HYVFMWmcBMh+o52TDlXKSf27iJbE0GQbBud7sfWO2?=
 =?us-ascii?Q?nq5bOwtVUmKB9fSc87FFqxInlNjABtf9xKUowuHtXo9VRrTv+BH6wQhqmi+W?=
 =?us-ascii?Q?+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8E094BCCE0B064E8D650BF9FCAA81B7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c0a87f-1797-4748-7d52-08db36cd5637
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 18:32:54.5645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whYxzbLXbye62Jz9EmkKmd6OMFkAqRvZDFW886tPURYJU5AwuxB4plZpcezIggKsTlsl4YvNFsDjq9BCjAQkbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8355
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.227.249, xfe-rcd-001.cisco.com
X-Outbound-Node: rcdn-core-4.cisco.com
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

On Thu, Apr 06, 2023 at 06:50:53PM +0200, Krzysztof Kozlowski wrote:
> On 06/04/2023 17:15, Daniel Walker (danielwa) wrote:
> > On Thu, Apr 06, 2023 at 09:12:34AM +0200, Krzysztof Kozlowski wrote:
> >> On 06/04/2023 00:30, Daniel Walker wrote:
> >>> Describe the compatible properties for the Cisco CrayAR SoC.
> >>>
> >>> Cc: xe-linux-external@cisco.com
> >>> Cc: Marcin Wierzbicki <mawierzb@cisco.com>
> >>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> Cc: Rob Herring <robh+dt@kernel.org>
> >>
> >> Please drop the autogenerated scripts/get_maintainer.pl CC-entries fro=
m
> >> commit msg. There is no single need to store automated output of
> >> get_maintainers.pl in the git log. It can be easily re-created at any
> >> given time, thus its presence in the git history is redundant and
> >> obfuscates the log.
> >>
> >> If you need it for your own patch management purposes, keep it under t=
he
> >> --- separator.
> > =20
> > I added these, so it's not script output. I can move them under the sep=
arator.
> > The reason for that was to make sure people who commented get Cc'd.
>=20
> So read my message again. There is no reason to add these entries for
> people who are listed as maintainers, because you are supposed to CC
> maintainers always.
=20
Maintainers change over time.. I'd rather not have to keep track of who the
maintainers are at any given time.

I won't delete this, but I offered to move it under the separator.

> >=20
> >>> Signed-off-by: Daniel Walker <dwalker@fifo99.com>
> >>> ---
> >>>  .../devicetree/bindings/arm/cisco/crayar.yaml | 27 +++++++++++++++++=
++
> >>>  1 file changed, 27 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/arm/cisco/craya=
r.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/arm/cisco/crayar.yaml =
b/Documentation/devicetree/bindings/arm/cisco/crayar.yaml
> >>> new file mode 100644
> >>> index 000000000000..0ee4e6313ab0
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/arm/cisco/crayar.yaml
> >>
> >> How many (or not many) platforms do you expect from Cisco? We mostly
> >> have one file per SoC manufacturer.
> >=20
> > We have two SoC's one called CrayAR and another called Craw. I've submi=
tted the
> > Craw dts file before , but I've not resubmitted it. Under Craw I think =
we have
> > at least two, but more likely five variations. CrayAR we have one varia=
tion with
> > at least one more planned.
> >=20
> > So we would plan over time to add two dtsi files and three to four dts =
files to
> > this directory. Then more over time.
>=20
> So just keep them in one file maybe.

If/when I submit again with anther chip we can discuss it at that time.

Daniel=
