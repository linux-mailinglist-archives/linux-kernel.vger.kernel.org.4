Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2567064A125
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiLLNfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbiLLNfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:35:30 -0500
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D768513F16
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1670852128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Fw4pn4Vmxe/Jmd55iy0zRjWURCdaOD7uS/rGwpRXV4c=;
  b=hJONmekHAi6BrhmCLe+2q2bAt1qRSTBRMDOqgVgj4eFxezO9oMUOnK+F
   h2UJ7YiCff+a5KEYjtU9Ayb+8YJPg59TELNKuXlofI5HuRZapBNKjKAij
   sJ643Dy7rq4jgSmFb6CLHEfljubRjLM0T/FfSmbD1tN/TrTCUGcVD78x6
   U=;
X-IronPort-RemoteIP: 104.47.57.175
X-IronPort-MID: 87426699
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:aA2QGaz9/Dqb6blnjuJ6t+fbxyrEfRIJ4+MujC+fZmUNrF6WrkVUx
 zFLXm/VaP+OZWH9LY0nOdjl8EwEsZ7Xzd5hHAY6qyAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTbaeYUidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw//F+U0HUMja4mtC5AVkPKoT5TcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KTBM+
 cUSKAI/VBOa1+uI+O+WZtFHh/12eaEHPKtH0p1h5RfwKK9/BLzmHeDN79Ie2yosjMdTG/qYf
 9AedTdkcBXHZVtIJ0sTD5U92uyvgxETcRUB8A7T+fVxvjeVlVMsuFTuGIO9ltiifchP2GyZo
 nnL12/4HgsbJJqUzj/tHneE1rCTx32lCdN6+LuQx9A0hk+K+mMqEwQaEnr8sOjirF/hRIcKQ
 6AT0m90xUQoz2SpQcP6RAaQu2Ofs1gXXN84O+k77hydj6nZ+QCUAkAaQTNbLt8rrsk7QXotz
 FDht8jyGTVlvbmRSHSc3rSZtzW/PW4SN2BqTSgAQAge6t/vurYvnwnPRdZuFq2yptDtEDS2y
 DePxAAuirNWgcMV2qGT+VHcnynqtpXPVhQy5AjcQiSi9AwRWWK+T4mh6Fye4fMeKo+cFwCFp
 CJdxJXY6/0SB5aQkiDLWP8KALyi+/eCNnvbnEJrGJ4isT+q/hZPYLxt3d23H28xWu5sRNMjS
 Ba7Vd95jHOLAEaXUA==
IronPort-HdrOrdr: A9a23:7HHRJ6Eqpd3w0AQJpLqE4MeALOsnbusQ8zAXPhZKOHlom6uj5q
 KTdZUgpHzJYVMqMk3I9ursBEDtex/hHP1OgbX5X43NYOCOggLBR72KhrGC/9SPIULDHl8379
 YFT5RD
X-IronPort-AV: E=Sophos;i="5.96,238,1665460800"; 
   d="scan'208";a="87426699"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2022 08:35:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKT9qQcGDKN3mIeseOJIfcBNUzCt/d9YZIHXkvklbur1uaPuvU8/EekNHVB+Bej4c8DrIDUVL1tRdqWrn9uvqi/elsuw+TpGz9ACoQdvYLiMYzblQsWGt8w5PM49d0wLXmm+VKfxqL0tFEnptxJtvFWWWAjKp1z+HbcIkyclkBgfslvOxy+kLQdjM26tLDO6QurJOFqF0dCWoqlkH5l/CW2tp8RFon2LwE1BAqaptu8vZ17ECoK7vAe2N40Yby8+8kaHYVyG6JQtOiqgsvfY+15jV+773uA3eEM28fxo6xrNe3bACcdn8bBxBCpvcC7BYcouwwTH7m6usJOGl0uwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fw4pn4Vmxe/Jmd55iy0zRjWURCdaOD7uS/rGwpRXV4c=;
 b=ZjfBqdvjsCsFarvDOfOy7PL7wvBvGKcex660Hg4OF8nSCD10QoPluc83k92/TZX/6zxTp2CNN2gMs+WKJ8VQGVTWRIYzo7WVCdyM4Lt9bzqqvLFztbRXqqEKLjmTi5jbQH2MSrGQcmYPIBlHToUJM3HhSqPgUjVnY/85OjR7WzpqnkVH4dGVGAud74cjdPxATznggHysURREi8t8Ar4z4IGEOtbybxaZgKYqL+aSAgk0E8Rndc1utY3R+Dkv4rqUTaqh/cv5vwAx1AUl0njIaXhDftttEgcfknEdZvsnrsBgNZBVf21DSUsoOZzbpSU3W6jUVeWLAo77go8UI2MQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw4pn4Vmxe/Jmd55iy0zRjWURCdaOD7uS/rGwpRXV4c=;
 b=dozXPXLeccwZo2h+QicnyBjtuQ/MKTOqxRoHQpOAnNceg8bHO2mjH+N4Nn0LwuK1kkeW36bWOAABQFUZRFyIPgo6cj9fJmCKWnxqsCxla/rifUir3vRYFN0mXnnOJJKcN/3bO+8O42vF3KDbzox1EJ6mW+38xQ5Pbvo/JYhzVWw=
Received: from BN6PR03MB3378.namprd03.prod.outlook.com (2603:10b6:405:42::30)
 by PH0PR03MB6915.namprd03.prod.outlook.com (2603:10b6:510:169::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 13:35:23 +0000
Received: from BN6PR03MB3378.namprd03.prod.outlook.com
 ([fe80::b47b:e121:d2c1:1e4a]) by BN6PR03MB3378.namprd03.prod.outlook.com
 ([fe80::b47b:e121:d2c1:1e4a%5]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 13:35:23 +0000
From:   Per Bilse <Per.Bilse@citrix.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] drivers/xen/hypervisor: Expose Xen SIF flags to userspace
Thread-Topic: [PATCH] drivers/xen/hypervisor: Expose Xen SIF flags to
 userspace
Thread-Index: AQHZDh1gTv+e/HYXHUu042upYlMPeq5lPlCAgAUCnwA=
Date:   Mon, 12 Dec 2022 13:35:22 +0000
Message-ID: <0c3471d6-1a27-2e45-7093-b6d3898dcc6a@citrix.com>
References: <20221202182254.784808-1-per.bilse@citrix.com>
 <15fff7b8-b030-edf9-5bff-073b9757cb2e@suse.com>
In-Reply-To: <15fff7b8-b030-edf9-5bff-073b9757cb2e@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR03MB3378:EE_|PH0PR03MB6915:EE_
x-ms-office365-filtering-correlation-id: 2f2f37b4-4f9d-4cb3-3eb4-08dadc45b855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qhKCyvLkYphjwjvHDA9kxjzYPrntt+/M3ovww/+2M89vbt6TTuSRZooU9VVT8FPvDmU3s4P+TreT4FAJ5vEylTRpqUVs3IQwXoLHqRxj0uMmSXl68bG9sBlu/DwTjKdyWIwCe9gvWg6URDu+q779XY0qUZbVwnh7y/zn1JmnfrCVmwu39fCOc2qQn0yC4M7j9u2wM4dq8uQn8+Tqrx1tu6C6ETGwxd85x1TQLApiPZEwK742C11BMLh24SnyDkezWfhTqaOTG1q3uKFoznDxi/LPmrEzBtYt4oEcFYOf/wUL8D8bPaPVZjIqOiVyLXTn1KquCxWNa+CelR0T6r3WpgVKIq9UA7xrZqgKax3Ru8PMnwICdLt3GeB6eWVspXRvBP2PHPxAPVoMUHV2T5bX2fDFRcEbsOdQPQXV39vmaLcw1bWSxBCWXAqGzVipgKe+Taro0I6xbirwROXjwds2XLmGcxUZCp5IEoe3tMjX0ZNuyIE8Zm5ptk7XydOu2hU50MU+CkdVYWqC6MT9QPFhegDSWJD5Evdi6qMqSYRAdcbB5gEb6xI5qucMh17Yej0HdZ/Yn9Z/7rEV6dUm+7o5OhWymnqkgONQql0zKJqtnZK03W2C98x8qp1KD20M4xhhkVXYJ+itM6QRPQb5/LbrQUyZ557ommVFETW49Uskjsbe9KpZ6jFT0PpEhsixrerb7YgCzbsSPLq0FGUaFKCsiSMFRgfFlUl2yvFz0L8k5Q4qGx7glf5bYXdUl3ze/+9EMXHAMVgC4Iruk/7v1Vb3Cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3378.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(478600001)(31686004)(5660300002)(41300700001)(8676002)(64756008)(4326008)(6486002)(316002)(2906002)(110136005)(54906003)(2616005)(36756003)(66446008)(8936002)(66476007)(66946007)(66556008)(91956017)(76116006)(86362001)(71200400001)(6512007)(38100700002)(122000001)(6506007)(38070700005)(53546011)(31696002)(82960400001)(26005)(186003)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGxaUkRXWWJQbEU5bFlsOER0em1wWWg2SGRGU25XbVhLQjErcldURE5wOG0z?=
 =?utf-8?B?ZlRqNXk3YmtIZ0Rac0N0MWZWSUhoYzRBOXJoVlhualJNUXM0R2x0dU1GWk1D?=
 =?utf-8?B?TXNGazhlcDhMRVhnMEc4K3ZONXR4VERzdGY4T3g5aERpYmhGU1ExbTNqZXpX?=
 =?utf-8?B?MG5BL3NBUmF3Zk53cmRoMUJEeHBmT1I3N0RsWnJmUlZzbm9YL2EzZWY2N3RH?=
 =?utf-8?B?VTVOQ1liVjNkQ29WbnNzRHdMOEVYRXoxc2h4WS9sNXFEd2MzMXU2Ym0ybHNS?=
 =?utf-8?B?STVmeStQOVVKZGZDT1BIdGJJbVRFanI2djZIY0ZScTc5aW1EcDhBT211OGRr?=
 =?utf-8?B?cUt5RXRkdEZZZnhsbkR6Vy96dXRyRFY2VUpBME8zRkd2N1RvTWJzaUpYZ0pB?=
 =?utf-8?B?aDVnV1JsNlZpQ2lqZ2ZDdnlHMXpoSUl6V3lPMWRMZVhtdU1yY2Y3U3ZxLzJR?=
 =?utf-8?B?NzdHcStsUjJteGltU2JRYWxtaUJCWlF2aS9kYXBlNUh2RVBFUUl0VmdaTkpO?=
 =?utf-8?B?ODBnZHZFb3FybTdDL0ZHK08zTklEUWkyVU9XdlkwNGZtSHBOb1lyT2N0bEgv?=
 =?utf-8?B?TW5MOGxmdEE0cEcrWXFDeXdQZ2RkbjBSbm1ST1Q0clNOTFEwNm9mZEEzNkRa?=
 =?utf-8?B?TDFJUnBBZ1M2aU85d3ZkZDVzZklQODBoeFA4RU1LbG1MS3ZrTmo1QjlFU2t1?=
 =?utf-8?B?RnNKdGcrWFRaZi9MQ2Y0U3dYcGpaZ2hFTGMyaUZqYldaVXZudzBvTENDV0JF?=
 =?utf-8?B?aW1pTUV0TC9wWElvQThmdTE2d3hMbS9rTWFwbCtsSlMvWnNnVlB4VGl0SzBV?=
 =?utf-8?B?S3VJYjVPcXpqSkRPVFN2dEROS3FMNVpaUDJhazlTb1BlQ0EvUm9PREs3N0Vo?=
 =?utf-8?B?K1RTN09mQU1ldENueXhJL3gxWEp2VC9tMkgzc2tPMTladmpmWk9adFMyWlp1?=
 =?utf-8?B?NHBOdk9HVWJXcWtUZ0pqaVlQZ1VkWnRFQk5KOTFzSjRWczBhc000bVNJYk1K?=
 =?utf-8?B?L3BNQ0JtY2pyVjB6RXhpV2NhcDdkaExReDRPZ2NmbjZGbUFDc3d4d0YzUldH?=
 =?utf-8?B?UzI4dXRLeVhBUXEwOVVCVWdjUHJITkRNU3Yva2xBTHZ2b2FvMkgvUFlDcktw?=
 =?utf-8?B?QmE1NmJDM0VZdDZKVEk4dS9iWWRPbElnU1RNNE0zR1RGSlo5NzZRS2dWUEFq?=
 =?utf-8?B?UmJORHNTdlpvNzBiQkhVTGFRbU5ibkU1dzRLcmY3eVNFc3NLWExIbkdGZUhJ?=
 =?utf-8?B?YmtKc3FkL3VFTC9qREJzbFBuK05WR3pRTmI2OUc3cWVRdDE5dlBlZlhnelZR?=
 =?utf-8?B?c2lsTGw2OENVY2FJWXAvWnozcmRzTUtyRHBFQ1FoT0FjOVlNU3FFNUswS0RY?=
 =?utf-8?B?VnkxQjl5Ujd1UU1UUG9xVXMybGlYMnM0YW1XczNFVmx5dnVXNExNNmZkOWlZ?=
 =?utf-8?B?bWdIeUVoSjNTV1pPWjM4UnNSNjU1cW9BTURRd0VraDQ3WjdHeVc2c2x2YWU0?=
 =?utf-8?B?NE5ybzRMQk1BZVVQUG13aWFhM0xqcklKWXF3Z3JBcXhBaEFWdzg0UUx2TVdB?=
 =?utf-8?B?ZDdHNDkwY3RnRTNjLzRvSW5tOU1jVXljYmdUNi93aThuVGFsREU3SGo2L2E3?=
 =?utf-8?B?ekxnQnJMZjR5VVhrT2RqanFNK0o2RHYrQVMxNzBrU3V4MFFRU0x0MXhvaCtX?=
 =?utf-8?B?dmJYSFdmVi9tOFoxNUtyTmZZbWRJblRWekdjSEdCTFJHaWNuVFRHcnhscEV0?=
 =?utf-8?B?dzh4NUhBWUxnNndqNkhlbXR0K1JYK245b01xQVJUeG41bEthOEp5TnZvbHNw?=
 =?utf-8?B?MG5tWXVQMkdQNXN0T2dRaElXSjczUjdFVlBmR3QxREFFRzdjcjJlZEFPWG0z?=
 =?utf-8?B?Um5EQ2VPelFkUlFnZm1wQlovRjhNTGd6bmpwS1lyTXZYbEJvMDNNWHlDejVu?=
 =?utf-8?B?Y1lzY1dZUlcvYjhiZURTT1BIMzh0Um5udUdxNzB1d1dzWGQvbWIvUWtzQnVa?=
 =?utf-8?B?Y3lxWE9KQitsNDZMMzl2djVwSE5kUWNQVkdCZlRNeFBaeVp6QVNTdWR4SFFi?=
 =?utf-8?B?QXo2cXZNMWhpb09QMDBhTHFZbnRiSk14TURtOHFBVGdxSG5BNVIwTkkweXkr?=
 =?utf-8?Q?pNzKe5AHSBMHlYfEbAeg0ANAV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFC6F725FAE0A048941452A4AF515F89@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR03MB3378.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2f37b4-4f9d-4cb3-3eb4-08dadc45b855
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 13:35:22.9326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVc8d2/Y2TkMUUmUfoODYCGQ7zjN102Ow+7yfj/E/KNmbPk+mfBu3FcfqNo0i5ttmDHclWRMamkbxWqHC48qtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6915
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMTIvMjAyMiAwOTowNCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4gT24gMDIuMTIuMjIg
MTk6MjIsIFBlciBCaWxzZSB3cm90ZToNCj4+ICtEZXNjcmlwdGlvbjrCoMKgwqAgSWYgcnVubmlu
ZyB1bmRlciBYZW46DQo+PiArwqDCoMKgwqDCoMKgwqAgQWxsIGJpdHMgaW4gWGVuJ3Mgc3RhcnQt
ZmxhZ3MgYXJlIHJlcHJlc2VudGVkIGFzDQo+PiArwqDCoMKgwqDCoMKgwqAgYm9vbGVhbiBmaWxl
cywgcmV0dXJuaW5nICcxJyBpZiBzZXQsICcwJyBvdGhlcndpc2UuDQo+IA0KPiBJIHRoaW5rIGF0
IGxlYXN0IHRoZSBmaWxlcyB3aGljaCB3YW50IHRvIGJlIHVzZWQgYnkgZS5nLiBzeXN0ZW1kDQo+
ICgiaW5pdGRvbWFpbiIgYXMgcmVwbGFjZW1lbnQgZm9yIHRoZSAiY29udHJvbF9kIiBzdHJpbmcg
aW4gY2FwYWJpbGl0aWVzLA0KPiBidXQgSSB0aGluayAicHJpdmlsZWdlZCIgYXMgd2VsbCkgc2hv
dWxkIGJlIGV4cGxpY2l0bHkgYWRkZWQgdG8gdGhpcw0KPiBkZXNjcmlwdGlvbiwgYXMgdGhvc2Ug
YXJlIG1lYW50IHRvIGJlIHVzZWQgYXMgYSBzdGFibGUgQUJJLg0KDQpPSywgeWVzLCBpdCdzIGEg
Yml0IHZhZ3VlIGFzIGlzLg0KDQo+PiArc3RhdGljIHN0cnVjdCBoeXBfc3lzZnNfYXR0ciBmbGFn
X2F0dHJzW0ZMQUdfQ09VTlRdID0gew0KPj4gK8KgwqDCoCBbaWxvZzIoU0lGX1BSSVZJTEVHRUQp
XSA9IHsNCj4+ICvCoMKgwqDCoMKgwqDCoCAuYXR0ciA9IHsgLm5hbWUgPSAicHJpdmlsZWdlZCIs
IC5tb2RlID0gMDQ0NCB9LA0KPj4gK8KgwqDCoMKgwqDCoMKgIC5zaG93ID0gZmxhZ19zaG93LA0K
Pj4gK8KgwqDCoMKgwqDCoMKgIC5oeXBfYXR0cl92YWx1ZSA9IFNJRl9QUklWSUxFR0VEDQo+PiAr
wqDCoMKgIH0sDQo+IA0KPiBXaGF0IGFib3V0Og0KPiANCj4gI2RlZmluZSBGTEFHX05PREUoYml0
LCBub2RlKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4gIMKgwqDC
oMKgW2lsb2cyKGJpdCldID0ge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFwNCj4gIMKgwqDCoMKgwqDCoMKgIC5hdHRyID0geyAubmFtZSA9ICNub2RlLCAubW9kZSA9IDA0
NDQgfSzCoMKgwqAgXA0KPiAgwqDCoMKgwqDCoMKgwqAgLnNob3cgPSBmbGFnX3Nob3cswqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4gIMKgwqDCoMKgwqDCoMKgIC5oeXBfYXR0cl92
YWx1ZSA9IGJpdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcDQo+ICDCoMKgwqDCoH0N
Cg0KWWVzIC4uLiBJIHdhcyB0aGlua2luZyB0aGF0IG1heWJlIGZsYWdzIHdvdWxkbid0IG5vcm1h
bGx5IHNoYXJlIG1vc3QgDQpjaGFyYWN0ZXJpc3RpY3MsIGJ1dCB0aGV5IHByb2JhYmx5IGRvLg0K
DQo+IEluIG9yZGVyIHRvIGF2b2lkIGEgY29uc3VtZXIgaGF2aW5nIHRvIGxvb2sgaW50byB0aGUg
c291cmNlcyBmb3IgYW55IG90aGVyDQo+IHNldCBmbGFnLCBtYXliZSBhZGQgbmFtZXMgZm9yIGN1
cnJlbnRseSBkZWZpbmVkIGZsYWdzLCB0b28/IE9yIGp1c3Qgc2tpcCA+IHRoZSBvdGhlciBmbGFn
cyBhbmQgYWRkIGEgc2luZ2xlIGFkZGl0aW9uYWwgbm9kZSAoImZsYWdzIj8pIHdpdGggdGhlIA0K
d2hvbGUNCj4gdmFsdWUgb2YgeGVuX3N0YXJ0X2ZsYWdzIGVpdGhlciBpbiBoZXggb3IgYmluYXJ5
IGZvcm0/DQoNClRoZSBjdXJyZW50IGZvcm1hdCBpcyBhcyBzdWdnZXN0ZWQgYnkgQW5kcmV3IENv
b3BlciBpbiBlbWFpbCBhYm91dCBhIA0KcHJldmlvdXMgaW5jYXJuYXRpb24gDQooaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC85MjMwMGE4MS1iOTdiLWY1ZDYtZTNlOC0zNjNkOGE3ZDM3NDJA
Y2l0cml4LmNvbS8pOyANCnNwZWNpZmljYWxseSwgdGhhdCBvZiB0aGUga25vd24gZmxhZ3Mgb25s
eSBpbml0ZG9tYWluIGFuZCBwcml2aWxlZ2VkIGFyZSANCnJlbGV2YW50IG91dHNpZGUgYSBrZXJu
ZWwgY29udGV4dCwgYW5kIHRoYXQgYWxsIG90aGVyIGZsYWdzIGJlIGV4cG9zZWQgDQppbmRpdmlk
dWFsbHkuDQoNCj4gUGxlYXNlIG5vdGUgdGhhdCB0aGlzIGlzIGEgc3VnZ2VzdGlvbiBvbmx5LCBJ
J20gbm90IGluc2lzdGluZyBvbiBpdC4NCg0KUGxlYXNlLCBtYW55IHRoYW5rcyBmb3IgdGhlIGZl
ZWRiYWNrLCBpdCdzIGFsd2F5cyBnb29kIHRvIGhlYXIgb3RoZXIgDQpwZW9wbGUncyB0aG91Z2h0
cy4NCg0KQmVzdCwNCg0KICAgLS0gUGVyDQoNCg==
