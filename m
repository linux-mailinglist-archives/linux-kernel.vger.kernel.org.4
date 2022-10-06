Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02625F69F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiJFOqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiJFOps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:45:48 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E8E98CAB;
        Thu,  6 Oct 2022 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665067546; x=1696603546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6A7EDG0J+1WPgmB2Pvye2iQ1XbEIKFCTWjCiI2OgF+g=;
  b=RklOY9VEh/yjcYbcE0qgKpktyRYPB4AokjPIXQeSsYoo4QZNXul2nRO6
   gNY3KWQDr3EqvwnrDRBFchpNN2H0SUcXDIJrjHPeTcijyT74Zde5f2f1o
   VqPFMtF5DOPLGnu2xd0YVBCrYQ69XNrGldW/JDRrU0o4xWEa3KcB20165
   O9G4lQtbw1jxQj1K6IBTy6/3GNpWPdxQxBXnQ8rMTaxC37ZNZ8hvoWE2n
   MLIrcxmX7dJNOwYOdahqhFfkx0VqaBICononI8kEZbVie1D+dYUB8gSyU
   4keAhkauJVov//UbSEwm3QR8k/l89B1WEw38m0OnCwElG6XiEm8F4jcgQ
   w==;
X-IronPort-AV: E=Sophos;i="5.95,164,1661788800"; 
   d="scan'208";a="325250413"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2022 22:45:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXnJLFacC1RghpH4G0hqikLiiNQT/5tBlLk7gzt+DBp87yBvm8gG/0S6FhS5tW5l1XTJPHPM57NcgywPE7D7QxRgzAqsI+B5XGchuptx9CdbQBLPQtli6ZV8tge5tBphudRrdWgB7l8kD3ORuQIENCCoBkBV3XyIBmGfnveGfLJ1TL4mhNhn8Ol85SRDt3wQ6cPYTnHUmzGBoXDKY0lVhFZHNdTesCbYHKKTBQo1SrzxYe1fYjmp8piUewixHs2Fn+mmdAeNAiRgcCjlkvuKviPHoORO1LaWHDt+AuIT+TivzDgCmgd7LFS1VJEDE46v3OHV8OCrtCLOv8lesGgF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9uKJ5gq0GQc54OaUmPcm9NTaTILdGXEC0tZwXAdXzg=;
 b=fvX7LIz78leOvlyTyUlYAIIFGkWxayHQtkxd9mu/w+b5mMjuoYraygVTdwsMyBk48ka7eue2romYzNXBbFMuKre4BXbfH1PKvTPIuXnQ+pnOXApnuwBs5pUJfzzFXSeFWF9FkfD1w5OMAfeCtbU2Hk5IyCe5KQWSJ9QlmmZULfmH6I9/ZeBCjhyokn7/q+kxoekogO34TjWcNMKB/EqURyPmjQlXPVfE1GgIlAmdZ2DYFPdfOd8QPRbphnAQkS5pXCD2DlFxsgcpcmFyM/rXDpzMPyp5saHWsFie1weMw48t44imxqn2p7y2FVQiLnIy2/vgoNnkTk6jD0bZrasaeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9uKJ5gq0GQc54OaUmPcm9NTaTILdGXEC0tZwXAdXzg=;
 b=ZOi3XrYLOvtesi2ro9Xh0GOHXUOGdziAQ4eXE99c+TPuAekBDJ2UaRNfBxomV63JgP4kv21aW8MAL0D2oeJBCPIiTea/3NmsrXqcU9vRPCWG4XPXKCF1AX2IWD5P+V7Un1sW9i0wrXTK3jXf+usq0i82rWH5RvmONAVecBvWqlI=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by PH0PR04MB7653.namprd04.prod.outlook.com (2603:10b6:510:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 14:45:37 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425%6]) with mapi id 15.20.5676.028; Thu, 6 Oct 2022
 14:45:37 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     John Garry <john.garry@huawei.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        yangxingui <yangxingui@huawei.com>,
        yanaijie <yanaijie@huawei.com>
Subject: Re: [PATCH v5 0/7] libsas and drivers: NCQ error handling
Thread-Topic: [PATCH v5 0/7] libsas and drivers: NCQ error handling
Thread-Index: AQHY1/ID0O3xyFitDU+9c+6EHqQqRa3+RKaAgAE7cQCAANLyAIAAAgSAgAAKBoCAAAiJAIAApReAgABn/oA=
Date:   Thu, 6 Oct 2022 14:45:37 +0000
Message-ID: <Yz7qD+gpmI1bdw16@x1-carbon>
References: <1664262298-239952-1-git-send-email-john.garry@huawei.com>
 <YzwvpUUftX6Ziurt@x1-carbon>
 <cfa52b91-db81-a179-76c2-8a61266c099d@huawei.com>
 <27148ec5-d1ae-d9a2-1b00-a4c34d2da198@huawei.com>
 <Yz33FGwd3YvQUAqT@x1-carbon>
 <5db6a7bc-dfeb-76e1-6899-7041daa934cf@opensource.wdc.com>
 <Yz4BLTPkXqyjW4a4@x1-carbon>
 <64ab35a7-f1ff-92ee-890e-89a5aee935a4@opensource.wdc.com>
 <f190f19e-34b2-611c-1cf4-f8f34d12fe74@huawei.com>
In-Reply-To: <f190f19e-34b2-611c-1cf4-f8f34d12fe74@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|PH0PR04MB7653:EE_
x-ms-office365-filtering-correlation-id: babdb9f3-2a4d-47f0-ba35-08daa7a96ea0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mx9PMgjd5EqwMSN67k1eUH7PXYQy8LgfvIu9mY8m72/6imsbwnlw8E15QWFUGn6vJhu7qMpVB+Qioyn9+ycGGQxnMrBdVeT0mJWUE2bM0M37whIx/UQ/qTgBGtwirfq3MMbm3Wk6l10V1wocTpfjGZcW5bWa14oCAbW4zMTNPDjFnqwhz+/zyUbvhPva43lWj1gLATMqD73uvu8L7YbL9KoqdWnGJnVL9btgWGTMpBkRqhSV/FMcV+TSrKtknuZHCKCiaa5rswDtkJpjqRsvPlWJeZl9N1CCG8wUEITpxWCM89g2VvRAkGY23fsdE8eaouP1Pqmu/S7Rt5h3K4ETcotiQnw1INDnaXf8o0pgDhYViwagI3GkSiiV4D5AdDvCOGR/PbSNnfpWHq/Ib9VZxUPMgrqCGIEk5IuqcCnIaUQeWcU/9iad8OLbfK1i4QmRPP/MktfUkOluCt8n+vkDOFYtJPyDYqlweztXMSgI5LZnTldydvlyn/eWXJ/HRY2gN1JNFKk2K2rJG1O7xmukTtLb2CE/HbEa2CSLczyoyWwpfCVa91wYs4v6W5u/PwwmRJ0hUhNT7PrB/y2gaI22drgC9TYNoHXLwaoALnKfXjZKTiSlpJXm1/uhSoc82l23amMz97yYJShgjSAkmFVjAkNQH7mvCAzDOZf8KN2ICA3Ode4gS+HV+w+lG7fw1YmNuIXt92+bPrMrL3Atv0jA9w3cJ/CUvhBfUJDlrJ/5NRxql7pNONxy6zJwmqjCviuJlb3R07wnlKr0rzInNe5w8mbMXHnQiUJLN44j4gr/5HHo+ECvHBOXxIvQEd2xCVE5HsXt02N1xmdm9p/SCKyHZPm+WrNCuLbxmM2IBcLj988=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(83380400001)(186003)(82960400001)(38070700005)(33716001)(122000001)(38100700002)(41300700001)(2906002)(5660300002)(8936002)(71200400001)(966005)(6506007)(478600001)(6486002)(53546011)(26005)(6512007)(9686003)(66556008)(91956017)(76116006)(4326008)(8676002)(66446008)(66476007)(316002)(64756008)(54906003)(66946007)(6916009)(86362001)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QCbtuf/EEewjDtebciQiMtEtNonPx6UTE7PPI8unUzCk72H7drzWXQ4q5VtU?=
 =?us-ascii?Q?/zPD4K2aubeHIhm/ZM8AH7LGTJYPqHtAGoX8Oe650fltYBAwKpMXzHvUYkew?=
 =?us-ascii?Q?njSBcut3D0/MhtXZigscq3yF/0CWvDI2oNq3WSD+o2Y1IB4xXh1OwjYZVUJu?=
 =?us-ascii?Q?Briz0YrdW54BRSKogHnlNxWm2CZrdcmgBvvFK0M/igsf5xX427j0a2Qyc6rn?=
 =?us-ascii?Q?FA49BwqUg+A/QgMVV+InVZwBfpxKDlog9o9AaP7Wz/kWTopao+nyY6MPE4mJ?=
 =?us-ascii?Q?02KLP/608AbctbFx7ZU87ZMxACo+4wDrlutZLz082PX40blwYaYIb85ZhHkb?=
 =?us-ascii?Q?L8TL7CwZuvp/1CC4DS0kclDEId9D3hHTQXJguTlN4NKZmid2QTHESKAKGF1Z?=
 =?us-ascii?Q?gycKniqVZ9KZo2AXv+wGG+w0JEO5iQpprpQ8JfZjas/cdmjUxsc+rYS5/1rY?=
 =?us-ascii?Q?23gFlYfPzhCA54OiXuMryl0FbWcohFPm1hyvN3XJGte+xk4l0MmTRsw24yVL?=
 =?us-ascii?Q?utT7sz/iKMhJ5KgQJ+luXd7PzDHb+q0f4lBffhq7OO/DIuHrpu1G2vqB6CPp?=
 =?us-ascii?Q?QsZeBtKEhYDLstzEwgxX1UbpNqd9CrWKiXafh7J+K8u7xW2JXq6uyXJEBW/N?=
 =?us-ascii?Q?Hwhy4Yh54KPgMyP1QFBnBtFLV6MqQiTl2ktvY92DSRQz4RjFzbeO5eyFirdB?=
 =?us-ascii?Q?NfTm9r75BoNbNp3XO3SLk6Cg0CfqoxpvzTzkofZVt0RTNnJMG+oNqDFW65KM?=
 =?us-ascii?Q?UFi7Eu/BFxLd0Rm+XyLY+Rachxxq8qwJ/0pMYFMrDQuYhofx6SrCBnu5e/Er?=
 =?us-ascii?Q?YXWqtHKZjkZq7KdNaver4XPFEghuS2zhjrv1gXYCVx0jmWjybOZ7DSthurPr?=
 =?us-ascii?Q?xIS7FaMBTYKGRVGuA7xU6OR9gYUSUM+knOTIA2/KfGvmt1xQUg/XCcq7Iebr?=
 =?us-ascii?Q?c1U/IHIIDoHtK0Ts7Uc59F596nMdGiMvqbbBl39qOXWoGviFv84DDf0es5bU?=
 =?us-ascii?Q?40nSQBgOwORnP9Sdd+/iYol0ifPEXAgBAa86cxI11945CI+U+2X7EFMHFJX9?=
 =?us-ascii?Q?uYYUCLBGeTSS7kX3PimX/2XJsxlh/uWb1ajNK0a938u5B9zLowRlYi3rP2RX?=
 =?us-ascii?Q?VBxImoUCJdaI6pLGC6/PTKCEyd64oJKGsaaZN9XqxPNEKEzdbgIKEBo0/47N?=
 =?us-ascii?Q?RdSvGxAPesnHCxYheYpi0fmfVlyHrks1Vi9mfoL4Jjnm8/p9Ar2QNnOLBK27?=
 =?us-ascii?Q?B3NRfBw5Nnuko09j7AkZj65LcOsm9AqO2w990yLAd7mePoumVca2H39+HmqD?=
 =?us-ascii?Q?t3IfAshWTRRgtAO1SBJVXfIcTfJp9f3fiT1ZLcxoekhVGPVBopv1tUvk1wJC?=
 =?us-ascii?Q?YfZw8ECLmz+JsHVZqQtjal2YibjkkvB0zaFsVEzx91cZ5XzaXHM4YpnA2dUx?=
 =?us-ascii?Q?fWSJrj9L8FJvJBmvqTj6KlxW/xbXMipdtDTahY4fxX6msfwDVOvapYiT6ITu?=
 =?us-ascii?Q?COQGLc9kPD31SHHfRk44kR73r9Dvpq9vdICw//qvDWuvdZ9Wfw2lVWOgD4nt?=
 =?us-ascii?Q?42luzjuDlZw0o446aeaPS2GlCULR9+wssnAx/4dw0j5idDtJBy3LwavYTEyn?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADFAF821884CA64FAF8B9E089D97BA55@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/rHeFRcpwi9HR4JcSHAmayCqgTmx9zlX/aTyXLwKnQ4VA8VOQ64+RiffgSDf?=
 =?us-ascii?Q?PVF3SKWjM24MSj4heu0MZVjUcgyJl5karjQ0BmMte5aKS2KJieCopH9kyJpo?=
 =?us-ascii?Q?aoh0tVIAs4p6yr7eA065orJpe3p9aaOjU77eYt46omtbWLsfjXvapk6VcDlj?=
 =?us-ascii?Q?kKKJaKRxjvVSt1q8sQQ5TWzd1YUBmo70g3KPgyjhvhs/x3pJ1X7Ahb5QAADE?=
 =?us-ascii?Q?/MBgrH+8AA1celYd4gk4sBdCLHwahh7j7Y06GvPsvDCe8oTYU1okWIY6dTpR?=
 =?us-ascii?Q?/F5ZvFmJdwWReyqtlsSFgiHXeunSaIHpzXMfqjo23XlYarUfgBItp7qgBd4X?=
 =?us-ascii?Q?gJoADt3q+4/JBjaDm1IKVjePH7kIF9O0y7meehdZziasrUfHzt7oMY7jy1Nu?=
 =?us-ascii?Q?sV4gOvHa2Pr/mNKWmQHG6ig/sP6IzzkUlhwWv+169YqIRtGk5FAdqbFj4miU?=
 =?us-ascii?Q?Xsmk1/EEEKpQniiEOsZ4IIXjYCNueaBGCarQ64OIxoYnGdtkTL6noctKyW/l?=
 =?us-ascii?Q?+EmNLrGKdhrEyLq22kkYbEN5mIHO/maoV5LwPt8iJDSUqizFOhSB/GO5KESp?=
 =?us-ascii?Q?rC8I+L0ozj7yA44IUAiDyVwGYJpzIe5jMtE85GRnEzdUUpF3UF0FRAdMGeOR?=
 =?us-ascii?Q?v7X15sH7dIW+4KC2GLRscQ5zthxMSNdPZpmwugoiOGWgpEBDcNf0F4t6dnd1?=
 =?us-ascii?Q?KsV/HbHi480qa46hphySaNDVKnbG3blPO7FWdg/sbZBHGoES4kSuOuy4+Cg8?=
 =?us-ascii?Q?lR7AMsDo3JBs1gXbIZC/AfNAA5lEw4UvUJ5gT0lgu4k1bhhxJp4hV4+diCpf?=
 =?us-ascii?Q?4v8qghryyktxjzWt4z8Qny9tzy1w5G4JEWTd/VdsnF69U1LyLD48Y0sLPgy9?=
 =?us-ascii?Q?liu2WyBewSA3GHPpbSY+7Fa/uLCxvaR2a3dknncml7lI+Z1GuKMCh4cZtM8w?=
 =?us-ascii?Q?ks5gzOFj+fsBZNMrUjWCoW59f68yJXl9x0CmZCOeETEYUbzN6HWae/2vk/5I?=
 =?us-ascii?Q?6m2h/eZhlfBr4/NrdoVrdDdH3dgFPxkyIo1rsdYlcF8FajA=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babdb9f3-2a4d-47f0-ba35-08daa7a96ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 14:45:37.3372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdutMTtSqUhWoGrnrHqk4qDOvFdPbprezwh3XApz0BYqKBixhE0xz6KeXociEe+Qfvse4Mcn0g3T5wA0SM4jvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7653
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 09:33:23AM +0100, John Garry wrote:
> On 05/10/2022 23:42, Damien Le Moal wrote:
> > > Hello Damien,
> > >=20
> > > John explained that he got a timeout from EH when reading the log:
> > > [  350.281581] ata1: failed to read log page 10h (errno=3D-5)
> > > [  350.577181] ata1.00: exception Emask 0x1 SAct 0xffffffff SErr 0x0 =
action 0x6 frozen
> > >=20
> > > ata_eh_read_log_10h() uses ata_read_log_page(), which will first try =
to read
> > > the log using READ LOG DMA EXT. If that fails, it will retry using RE=
AD LOG EXT.
> > >=20
> > > Therefore, to see if this is a driver specific bug, I suggested to tr=
y to read
> > > the NCQ Command Error log using ATA16 passthrough commands:
> > >=20
> > > $ sudo sg_sat_read_gplog -d --log=3D0x10 /dev/sdc
> > > will read the log using READ LOG DMA EXT.
> > >=20
> > > $ sudo sg_sat_read_gplog --log=3D0x10 /dev/sdc
> > > will read the log using READ LOG EXT.
>=20
> Note that I can't get a distro to boot on this system from the HDD for th=
e
> same timeout problem (so no tools easily available).
>=20
> > >=20
> > > Neither of these two suggested commands are NCQ commands.
> > > (Neither command is encapsulated in a RECEIVE FPDMA QUEUED,
> > > so I'm not sure what you mean.)
> > >=20
> > >=20
> > > Garry, I now see that:
> > > [  350.577181] ata1.00: exception Emask 0x1 SAct 0xffffffff SErr 0x0 =
action 0x6 frozen
> > > Your port is frozen.
> > >=20
> > > ata_read_log_page() calls ata_exec_internal() which calls ata_exec_in=
ternal_sg(),
> > > which will simply return an error without sending down the command to=
 the drive,
> > > if the port is frozen.
> > >=20
> > > Not sure why your port is frozen, mine is obviously not.
>=20
> I think that it gets frozen when the internal command for read log ext ti=
mes
> out. More below about that timeout.

ata_read_log_page() will first try to read using READ LOG DMA EXT.
If that fails it will retry with READ LOG EXT.

Your log has this:
[  350.257870] ata1.00: qc timeout (cmd 0x47)

So it is definitely ATA_CMD_READ_LOG_DMA_EXT that times out.

On timeout, ata_exec_internal_sg() will freeze the port:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/ata/libata-core.c?h=3Dv6.0#n1577

When ata_read_log_page() retries with the port frozen,
READ LOG EXT will obviously fail (since the port is frozen).

Not sure why READ LOG DMA EXT would timeout for you...
Perhaps your drive does not implement this command,
and incorrectly reports supporting this command via
ata_id_has_read_log_dma_ext().

Perhaps you could try boot your kernel with libata.force=3Dnodmalog
on the kernel command line, so that ata_read_log_page() will use
READ LOG EXT on the first try.


Damien, it seems that there is no use in retrying if the port
is frozen/we got a timeout, so perhaps:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e74ab6c0f1a0..1aa628332c8e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2035,7 +2035,8 @@ unsigned int ata_read_log_page(struct ata_device *dev=
, u8 log,
        if (err_mask) {
                if (dma) {
                        dev->horkage |=3D ATA_HORKAGE_NO_DMA_LOG;
-                       goto retry;
+                       if (err_mask !=3D AC_ERR_TIMEOUT)
+                               goto retry;
                }

or:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e74ab6c0f1a0..2fa03b7573ac 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2035,7 +2035,8 @@ unsigned int ata_read_log_page(struct ata_device *dev=
, u8 log,
        if (err_mask) {
                if (dma) {
                        dev->horkage |=3D ATA_HORKAGE_NO_DMA_LOG;
-                       goto retry;
+                       if (!(dev->link->ap->pflags & ATA_PFLAG_FROZEN))
+                               goto retry;
                }

would be in order, so that we actually print the real error, instead of a b=
ogus
AC_ERR_SYSTEM (returned by ata_exec_internal_sg()) when the port is frozen.

>=20
> > >=20
> > > ata_do_link_abort() calls ata_eh_set_pending() without activating fas=
t drain:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/ata/libata-eh.c?h=3Dv6.0#n989
> > >=20
> > > So I'm not sure why your port is frozen.
> > > (The fast drain timer does freeze the port, but it shouldn't be enabl=
ed.)
> > > It might be worthwhile to see who freezes the port in your case.
> > Might come from the command timeout. John has had many problems with th=
e
> > pm80xx HBA in his Arm machine from a while back. Likely not a driver is=
sue
> > but a hw one... No-one seems to be able to recreate the same problem.
> >=20
> > We need to try the HBA on our Arm board to see what happens.
> >=20
>=20
> Yeah, it just looks to be the longstanding issue of using this card on my
> arm64 machine - that is that I get IO timeouts quite regularly. I should
> have mentioned that yesterday. This just seems to be a driver issue.

Out of curiosity, which arm64 SoC is this?

While it is very unlikely that this is your problem, but I've encountered
an issue on an ARM board before, where the PCIe controller was incorrectly
configured in device tree, causing the controller to miss interrrupts,
which presented itself to the user as timeouts in the WiFi driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D97131f85c08e024df49480ed499aae8fb754067f


Kind regards,
Niklas=
