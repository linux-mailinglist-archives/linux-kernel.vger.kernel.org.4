Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246386DAF90
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDGPQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbjDGPQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:16:41 -0400
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2B74ED6;
        Fri,  7 Apr 2023 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1434; q=dns/txt; s=iport;
  t=1680880571; x=1682090171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4qtkxbO4YtW5r1YaMvp7RIQeT5HBocMDIOZihyeeUFE=;
  b=SMo4yw5Cr4J6Fs3m61LzEW0e5pbxR4m+0ae4SId0tQ94IHDCWT+xfE7D
   YopLzvAjZY7CqSR8K8iMGZLwhXJfCc2KQzj3CM0FKDu5IybiCRCz8b66k
   m8fPxdG91h1DOCJ7F7ZaSNPRoGjfV/TpndrT9ybQsmVN5awY86zJHqpbC
   M=;
X-IPAS-Result: =?us-ascii?q?A0BEAAALMzBkmJpdJa1aHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YFbUnNbO0aIHgOFLogzkiCKEYEsgSUDVg8BAQENAQFEBAEBgVIBgzMChTwCJ?=
 =?us-ascii?q?TUIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEHBBQBAQEBAQEBAR4ZBQ4QJ?=
 =?us-ascii?q?4VoDYYEAQEBAxIoBgEBNwEPAgEIDgoeEDIlAgQOJ4Jcgl0DAZ86AYE/Aooge?=
 =?us-ascii?q?IE0gQGCCAEBBgQEnyIJFoErAZE5JxuBSUSEPz6CYgKBYIQUggwigQyZJgqBN?=
 =?us-ascii?q?HaBIA6BPYEEAgkCEWuBEAhqgXlAAg1kCw5vgUqDKgQCFCc3A0QdQAMLOzo/N?=
 =?us-ascii?q?RQgBliBGSQFAwsVKkcECDgGHDQRAggPEg8GJkQOQjc0EwZcASkLDhEDT4FGB?=
 =?us-ascii?q?C+BXAYBJiSfQCsBlXqwZQqDfaBtTROpL5dzomWFEQIEAgQFAg4BAQaBZAE4g?=
 =?us-ascii?q?VtwFYMiUhkPhnOHLQwNCYNQj3l1PQIHCwEBAwmLRQEB?=
IronPort-PHdr: A9a23:Om9YmxOvxE88TJJuVlYl6ncDWUAX0o4cdiYZ6Zsi3rRJdKnrv5HvJ
 1fW6vgliljVFZ7a5PRJh6uz0ejgVGUM7IzHvCUEd5pBBBMAgN8dygonBsPNAEbnLfnsOio9G
 skKVFJs83yhd0ZPH8OrbFzJqXr05jkXSX3C
IronPort-Data: A9a23:hNt8i6lW0aEGIuMLL/Y4lIvo5gwAJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIfUW+FPK6KMWegeItyaIng/EtV75XQytdjHQJt/Hg3H1tH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaA4E3ra9ANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXkXc6
 bsen+WFYAX+g2IsbTpOg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauG4ycbjG
 o4vZJnglo/o109F5uGNy94XQWVWKlLmBjViv1INM0SUbreukQRpukozHKJ0hU66EFxllfgpo
 DlGncTYpQvEosQglcxFOyS0HR2SMoV34pjiCGaQk/XI7Gr4VEvp08pJBlk5aNhwFuZfWQmi9
 NQCIzwLKxuEne/zm/SwS/JngYIoK8yD0IE34y47i2qGS6d9B8meH80m5vcAtNs0rsxHG/fTY
 9UQQTFudx/HJRZIPz/7Dbpvwrbx2CemIlW0rnqHpasNz1nS0zVfyei0auXFWeymZtVsyxPwS
 mXupjSlXU5y2Mak4T6E9G+8w+zChyX2XKoMG7CisP1nmluewioUEhJ+fVe2v/iyh1KkVt93N
 UMZ4GwtoLI0+UjtScPyNzW7umyVpQwAXNQWEOoo7AaS0anVoAqFLmwFSDdbb5ohrsBebTA13
 1uKksnBCz1ht+zED3ma89+8tzS4OWsZMUcBaDUCQA9D5MPsyKkwlADMZtVuCqi4ipvyAz6Y/
 tyRhDI1i7NWhskR2uDgu1vGmDmr4JPOS2bZ+zk7QEqU9CRcTZCKRbXzyn/lysZFPLm+REGO6
 S1sd9el0MgCCpSElSqoSeoLHa206/vtDNE6qQM3d3XG32n1k0NPbby88xklexg0apdslSvBJ
 R6M6VkItfe/KVPzNfcvC79dHfjG2kQJKDgIfurfYtwLaZ9reUrcuipvfkWXmWvqlSDAcJ3T2
 7/HIK5A7l5DWcyLKQZaoc9GidfHIQhlnwvuqWjTlUjP7FZnTCf9pU05GFWPdPsly6iPvR/Y9
 d1SX+PTlUUHALWjMnKNq9RPRbzvEZTdLc2pwyCwXrPdSjeK5El6YxMs6ep7Itc8z/g9ehngr
 yjhMqOn9LYPrSSXdVrVApySQLjuRp145WkqJjAhOE3A5pTQSdjH0UvrTLNuJeNP3LU6lZZcF
 qBZE+3eWa4nYmqcpFwggWzV8dYKmOKD31zeZkJIoVEXIvZdeuA+0oa1IVOwqnlSV3PfWAlXi
 +TI6z43iKErH2xKZPs6otr/p79tlRDxQN5PYnY=
IronPort-HdrOrdr: A9a23:FqvGJqCyceUDTZrlHegNsceALOsnbusQ8zAXPh9KJyC9I/b2qy
 nxppgmPEfP+UossHFJo6HlBEEZKUmsuqKdkrNhQotKOzOW9ldATbsSobcKpgeAJ8SQzJ8k6U
 4NSdkdNDS0NykGsS+Y2nj4Lz9D+qj9zEnAv463pB0BLXAIV0gj1XYCNu/xKDwQeOAyP+tBKH
 Pq3Lsgm9PPQwVzUi2TPAh1Y8Hz4/nw0L72ax8PABAqrCOUiymz1bL8Gx+Emj8DTjJm294ZgC
 j4uj28wp/mn+Cwyxfa2WOWxY9RgsHdxtxKA9HJotQJKw/rlh2jaO1aKv6/VXEO0aOSAWQR4Z
 3xSiQbToNOArTqDyeISC7WqkzdOfAVmibfIBGj8CPeSIfCNUwH4oJ69PJkm13imhEdVBUW6t
 MX44pf3KAnVy8o1R6NlOTgRlVkkFG5rmEllvNWh3tDUZEGYLsUtoAH+lhJea1wVx4SxbpXWd
 WGNvusrMp+YBefdTTUr2NvyNujUjA6GQqHWFELvoiQ3yJNlH50wkMEzIhH901wua4VWt1B/a
 DJI65onLZBQosfar98Hv4IRY+yBnbWSRzBPWqOKRDsFb0BOXjKt5nriY9Frt2CadgN1t8/iZ
 7BWFRXuSo7fF/vE9SH2NlR/hXEUAyGLELQIwFllu9EU5HHNc7W2He4OSITeuOb0oAiPvE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,327,1673913600"; 
   d="scan'208";a="96916619"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by alln-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 07 Apr 2023 15:15:59 +0000
Received: from mail.cisco.com (xfe-aln-005.cisco.com [173.37.135.125])
        by rcdn-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 337FFxel028815
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Apr 2023 15:15:59 GMT
Received: from xfe-aln-004.cisco.com (173.37.135.124) by xfe-aln-005.cisco.com
 (173.37.135.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 7 Apr
 2023 10:15:58 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (173.37.151.57)
 by xfe-aln-004.cisco.com (173.37.135.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Fri, 7 Apr 2023 10:15:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0FD2C25xzbS1t/Y3lwtngtNp8zf14aU9Z8Pr4wVtYZeTmiZ553mdgrEI3w0Fi46w9s7RtkF/odTQuuR6dCMAtXz5cPz/CfWkG3QaBAzyc0TEQYTR53yubyowx8QROaoxhqbgD7W13T/qIjTd+uOZHZF/nj7/GNgcZ0uypvqXS/UwPbh9qRxhBT5ybOEwsmp8AqipBqYzq+FZwkY92S7tkrA44Rg0vqvTAXTdB1issfSZlk90Q/M9v3tFdBdYYodjKdVXEIvfmXiIzkBDVigtByov5vyGItM6VGkYr3MzYw9CJ7Q8wWQ1+LBuhJYtmQoOuadI65Aww/ZqkQwSGBKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qtkxbO4YtW5r1YaMvp7RIQeT5HBocMDIOZihyeeUFE=;
 b=WudBfivDxtp5yLIMQn/q79kxiScE3asqFn52wJg8zYGwP9KLXYU7DkJzDCUb8yoyU8so7O+OR19ug0p+Z+2VS0FH1LnImw+aHoXse3Bh+s/PrMU7dJsC2jPRFzOIxlF44F8cYHD0eKJH09kkBD30h4e7ekjY+llcBCuwT3QBIpTQy4BHiFnLiG10JCAqOyU/zLM6ufdvb90JS+7ZsP92hG/i+jEOPdA5H6c60VJ3y9DPXIdCLbdcnBd8jX+cKPX6R/fMuzT0cw1t3BfVNiy5hpeO6p48gQ+7TkAFXmLuvr7hN3Oe/z/eIZJ6B2n6ovSfSm9WybIJ0OjtogsCAPdMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qtkxbO4YtW5r1YaMvp7RIQeT5HBocMDIOZihyeeUFE=;
 b=LCpEiR1pQxJDWEMkU6cYVYGzj+G/Dp+GVIFwfNXPKqojPDmvalx6wn8EqefZqNT4kvxCFDfaDAFS/+UqqAztkTMJL29NJcQv9+oeemMx3acCKmq2/16qgZgdLYzHJBccEmCd5hgDkUPCPRWNPvpSOrZ3uh8S2eT+NvZjUwyPLR8=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by SA1PR11MB6870.namprd11.prod.outlook.com (2603:10b6:806:2b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Fri, 7 Apr
 2023 15:15:55 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97%6]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 15:15:55 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
Date:   Fri, 7 Apr 2023 15:15:54 +0000
Message-ID: <20230407151554.GB1391488@zorba>
References: <20230405223028.1268141-2-danielwa@cisco.com>
 <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
 <20230406151512.GL40472@zorba>
 <14634180-aca9-a3e9-d1af-dfaca77b42ee@linaro.org>
 <20230406183253.GM40472@zorba>
 <5e2e5b82-35ae-c3b5-becb-40d387226a7a@linaro.org>
 <20230406191506.GN40472@zorba>
 <4555d5e8-0403-99bc-9cc2-26b72ea5be3b@kernel.org>
In-Reply-To: <4555d5e8-0403-99bc-9cc2-26b72ea5be3b@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|SA1PR11MB6870:EE_
x-ms-office365-filtering-correlation-id: 8639233b-3fe9-4746-40ee-08db377afb8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: STbPIgihcsz+L/yMe0N1gVZvdxKcV/ZbtzvYvSGRgYUry249t/WyAUE+s5wOB5Imp69QHldF1hZRF5FY0/gWksdATjTn8VPuoC2UfzBtKJ3CvGTeOvc+ZxBaUurEuIvyhCEVwukqISsE4QUbCxgvhmbKbke76Rjh3t073RkHkshguJfVQFepc5DfcZbbEo0hI5XSUakaF9gdfmAZ0jXL4tFKFW+LF7Fa0aiLOVHarCCr4Ft7KOwkzZFzVa1/xdEgGveHf5egTHptfpSzQvJefaysjU55RnSvkVIZ1d41gdfqIYXXBmmzRXITTdCNICaXyTH/E2sCMLcEmchUhoxNqbbzZ8hJ5jOK09nxyr2D45B5LYFDVFdd6AFwB+QhsdyGoCuL5IN3G74oh6EouWkAeaWgtpFnwxcCSOurK/SwVMJUR951SnDEVrJdeHA5SaINRl5ED0cpUPEVqboKlymQzyam35Z23NQ6TXF1Kfv7jAxHO1DP8XTWPoJyuFUWIn50CasY+iqwGavi0+wWg1FiHbhqlG10alNsjybDHxu0mrjiU277PNXvxkyvAjGcJixXway5vyvqEEw144lsPqSrfGvkeuAXJuel6HSxIdqlHwIalB7uq9e1KaY1d7+jqUPl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(122000001)(38070700005)(2906002)(38100700002)(86362001)(33716001)(66446008)(8676002)(6512007)(64756008)(66476007)(76116006)(66946007)(66556008)(1076003)(9686003)(26005)(6506007)(316002)(53546011)(54906003)(6916009)(41300700001)(478600001)(4326008)(6486002)(71200400001)(5660300002)(186003)(33656002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EW1WRCjYzDdIWIn5Go6bVMxqlAzsAWxJr+5q9b+QuzSkHYEFUz0xNuEGcEl8?=
 =?us-ascii?Q?fFrsl3znDtLEv5o8FtN1aoUmEl2O/KyHHq8CyhxluBYq3By+y5pLJfgXh5sw?=
 =?us-ascii?Q?bA7qZ2DXATB11M2mlDBSaPLl6xSgS54ni16Qjq21C1bvm68e606cqYi13bBv?=
 =?us-ascii?Q?WK42bf0AuYlRb672tboYPJvQat1o0d/BRbaQw4pjoFC6gT7PK4JPv0L88QiU?=
 =?us-ascii?Q?OMhodo9hKq5KtqF0/+VqIpyfB+SPaTNWOxPMS3ZS5ZtAIGlgbSxPBzbrMstI?=
 =?us-ascii?Q?zHnTEnnU/esQn3oYhXBnJ1n91gOS92vBkpPDHpGEges6PxHdAX/NJAc0dHtu?=
 =?us-ascii?Q?Qm+1Q5LHasp6d1RNlCcjzyO36DWvAJbzKeNcDzPM69I3LD79MygTLlswxwMC?=
 =?us-ascii?Q?7dh39dMiAJaIv4zlP/i3IsXizcyemGgsnZ7P2pVoJJVsfHd4EJDI2u29bSTb?=
 =?us-ascii?Q?tSytxor4y7H75lCLpbtUwvNrrK84MX8Pd0nnHqx/9jkOOAHKDu3VBo4p3hPf?=
 =?us-ascii?Q?pYnUe4me1rYEXXeIks/D0ifwHElecdUUJq/mn8OJ+9JPB0i5FIYY7WDkETP6?=
 =?us-ascii?Q?CUgmf1s0bdCy9QAMxYjA4amdeCzEfWxnzTcvA/Z5m64EkGoGZ63toA25/Vcm?=
 =?us-ascii?Q?u86psXx7spWo++FxM1N01O0KmBhulH+As+/4vYAh3woAsJKh4GAsA+xQftSs?=
 =?us-ascii?Q?7GKkUxJHZk9g4z0Czb/7dqfcpUr3dTuU/img2iaMrq1Iq+nH9KEPsM5J+ssO?=
 =?us-ascii?Q?1BfnLT32CVumiPCOpnBV4cn/6rYahzp215gxZYdDwgy04BPfprsIb3i6bnDI?=
 =?us-ascii?Q?A2vksGRa64UqgpL5w+HKQOj4dpTPmIkYaMVGSGuwETaMgEpHU5CPZGfSKJt8?=
 =?us-ascii?Q?8Clgjfc6kOKjryxau5ph8SKDxQ87emvNcFcgJ/f5Fq/GtvQe/HH+M9qs8pxP?=
 =?us-ascii?Q?2TNslnOcMZaLCsJMtAS7/QvNshY6pWITCCMFTlrRtM13r7I+UbLG9EN3Sd2S?=
 =?us-ascii?Q?AGqzoP7x22/NzUDOHgCrv4FYS3IhRJNoUDSbvpiHi0dc2E06BRWj1B/HbVYd?=
 =?us-ascii?Q?iyFIEDNtM5iLykAK2aqXYCNOKIeGYTni5WD5xqthoRKEw7RNCx2difvkIUoQ?=
 =?us-ascii?Q?6cWlaBtbn4AUIFzlBdlSAy/VY6ymyoyk+vtWVVi9CG8rnOksijrh6YL5GPCB?=
 =?us-ascii?Q?j6GnlN+6svDeEZaDTmC3rmlNXv3KUHlWsMH6EvGszo5lvVAVRNfGAiSr/+Uu?=
 =?us-ascii?Q?vbEoYY8sAyxPdYEyMlQGRvT1yvchdm5qoSDIHrvrqnDH25hvkBVYricHrng5?=
 =?us-ascii?Q?eXU0+uawxdQkjid0XjFfXQJn3welui/O29nYuNAUVwEjmaSb95WrU9exuu53?=
 =?us-ascii?Q?uAb5bpNQOyodbH63UU3rICCGPfItDR2RWwHeijbkay2PcBkrXSJDOwOvCzTZ?=
 =?us-ascii?Q?1aBTYK03ko0cgcIf7nBcIsJTNltlTfskan644UUtrcD1WjfcwmT3eJh6XuYO?=
 =?us-ascii?Q?YI/kf5db7AUPpsX+0dAx7EFGqdvDzsq7fXa0oJBYimuqNw+1YarEaC+Nrsmh?=
 =?us-ascii?Q?3V3lGhtuFqU3yzei6CgK61kJO+Lrbay/Ikj5eXMPrchNSPsvJopVKAksV5vL?=
 =?us-ascii?Q?dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <391771BB01286546B682F058A1427B77@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8639233b-3fe9-4746-40ee-08db377afb8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 15:15:54.8743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYNDzAMAhzhMySs2zy1QH+22qKAlkIYN9wzBDOM5gWCn8+waATM1ACyZxHknhnAhwY9tZewhKu/F5PtqYIPcIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6870
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.135.125, xfe-aln-005.cisco.com
X-Outbound-Node: rcdn-core-3.cisco.com
X-Spam-Status: No, score=-10.0 required=5.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 08:51:12AM +0200, Krzysztof Kozlowski wrote:
> On 06/04/2023 21:15, Daniel Walker (danielwa) wrote:
> > On Thu, Apr 06, 2023 at 08:56:06PM +0200, Krzysztof Kozlowski wrote:
> >> On 06/04/2023 20:32, Daniel Walker (danielwa) wrote:
> >>>>>>> +++ b/Documentation/devicetree/bindings/arm/cisco/crayar.yaml
> >>>>>>
> >>>>>> How many (or not many) platforms do you expect from Cisco? We most=
ly
> >>>>>> have one file per SoC manufacturer.
> >>>>>
> >>>>> We have two SoC's one called CrayAR and another called Craw. I've s=
ubmitted the
> >>>>> Craw dts file before , but I've not resubmitted it. Under Craw I th=
ink we have
> >>>>> at least two, but more likely five variations. CrayAR we have one v=
ariation with
> >>>>> at least one more planned.
> >>>>>
> >>>>> So we would plan over time to add two dtsi files and three to four =
dts files to
> >>>>> this directory. Then more over time.
> >>>>
> >>>> So just keep them in one file maybe.
> >>>
> >>> If/when I submit again with anther chip we can discuss it at that tim=
e.
> >>
> >> Or you can do it now.
> >=20
> > What do you want to talk about exactly ? You said keep everything in on=
e file, doesn't this
> > already fit your suggestion ? I'm only submitting one file.
>=20
> That is supposed to be one file named like: cisco.yaml
> If you ever need to have separate maintainers, then split it.

Ok.

Daniel=
