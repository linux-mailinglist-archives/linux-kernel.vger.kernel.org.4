Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9250571069A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbjEYHp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjEYHpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:45:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722EF1AC;
        Thu, 25 May 2023 00:45:34 -0700 (PDT)
X-UUID: 1d3edb22fad011edb20a276fd37b9834-20230525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=D7sXCHt4MjBlF/goDvRBZZpYGYsOBldl0JGzVFv0ZV4=;
        b=jT0aYAEw2XlIs0OIPC+sJMF/tz9M/iqHspL6iVP6SPuKXsAdju17/HRySv4PHg5pswRrawLCfIvVTwYDAW8LDfRkQd5kuojHhgoqnTOwdX/oDxTH0MQk34ClsVt2NT1y7K+Ai+ClBsLZvjReQycfmBof+bqUDSzYXOa/6giybtE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:b784f011-6d74-491a-ab98-1a4d83e446e8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.25,REQID:b784f011-6d74-491a-ab98-1a4d83e446e8,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:29de823c-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:2305251500281T8QVZBQ,BulkQuantity:6,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 1d3edb22fad011edb20a276fd37b9834-20230525
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1561976108; Thu, 25 May 2023 15:45:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with ShadowRedundancy id
 15.2.1118.7; Thu, 25 May 2023 07:45:18 +0000
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 15:00:25 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 15:00:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtDb83kjPTsaSLX6vD3MkTYHfToKZ4c1HztGOcgjIsj38LBR9i/MGjehUL3k+I09V+HlZdrygqkJwLRDBBZTwjYYxtPE+V5kPN0CYcQyYop/iRok+qsOflRZUjVGES9bFKHJNiNVSMyXk5CeimIfCqEksN0gUu9BhVNYEq7CS6TM33eAEX1A/2o6PKAW2SC8LUjnDQMvs1GogVM+N9e1u0P2qWaKzqPOYYPy/a3CnFAcDc92dc3Do5n06aOigKfT96bdGP7Hfu76ccwaSaPLAI03HVIB9Y5EDg13pq6jiZeQDWbKAET4650dW++qDNzo6fqMo9K+Gx6DSyjERwQKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7sXCHt4MjBlF/goDvRBZZpYGYsOBldl0JGzVFv0ZV4=;
 b=d4KgbH/G3Z0ij+WhFR4kgEZxfzY2gEirw0nZaSyxdmkDWGh7hmkgRcUTAGL8fBIHNVhd9ly7qd/vB4Y8tSAxVHPyJBfj9mzjsDERkiojBT+GIH4bJptkoyvk/9byvSZb3upfMNvCGHAN1DjaGiPBuE9MjiYA1zBoUscwKSwPGtEgLrP6Hrw4ON9bxh8LQxNMimzwvyNn2LDFDmULvIhRcUa9P6Mv3qBEVFO/1z74t3BQ31x1hMseLrEGXLbjg0939EM/0ZtsFZhp76aWaBn8eIj9q+PCTOjWMnyFEhCvowMX8oucmMSaYA7oWKG8Q/3hSQHeRedTRLq8OKliSgWwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7sXCHt4MjBlF/goDvRBZZpYGYsOBldl0JGzVFv0ZV4=;
 b=EjwwcNSe48J/YpvPyO1YDwnAZ/P4tgykFpU/uTCJxJ843XrOs7iNAWou5MPu80dBSBnGkKim9hsORqqRkBofHuaHVR4tOx031ctPTy+Q7LKeKKuk16Y2DIQ3BZiN56PpYAKIq+I57LnXGJgPVmzoih4X6yKfPuGDdpCMwhl8W7g=
Received: from SG2PR03MB5070.apcprd03.prod.outlook.com (2603:1096:4:d0::19) by
 TYZPR03MB7747.apcprd03.prod.outlook.com (2603:1096:400:423::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.16; Thu, 25 May 2023 07:00:22 +0000
Received: from SG2PR03MB5070.apcprd03.prod.outlook.com
 ([fe80::da23:cc83:c195:77cd]) by SG2PR03MB5070.apcprd03.prod.outlook.com
 ([fe80::da23:cc83:c195:77cd%4]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 07:00:22 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "fabrice.gasnier@st.com" <fabrice.gasnier@st.com>,
        "stable@kernel.org" <stable@kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "xiujianfeng@huawei.com" <xiujianfeng@huawei.com>,
        =?utf-8?B?S2V3dSBDaGVuICjpmYjnp5HkvI0p?= <Kewu.Chen@mediatek.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer check in
 gserial_suspend
Thread-Topic: [PATCH] usb: gadget: u_serial: Add null pointer check in
 gserial_suspend
Thread-Index: AQHZjFQPyoBpcCp80UeqhXEfnGmix69lyZGAgATK64A=
Date:   Thu, 25 May 2023 07:00:22 +0000
Message-ID: <16b5ad34bc3791223a2754cec8557fa5bd24c314.camel@mediatek.com>
References: <20230522022101.32163-1-chunfeng.yun@mediatek.com>
         <bf3b5f0a-0a04-2410-9106-1e2957a2ce05@quicinc.com>
In-Reply-To: <bf3b5f0a-0a04-2410-9106-1e2957a2ce05@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB5070:EE_|TYZPR03MB7747:EE_
x-ms-office365-filtering-correlation-id: 7f043202-d885-4cd3-f790-08db5cedb55b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TJPo4mbi1SvFWg24tJXCN/FJpKpCNKGZQ/hRh/rGlBZLGs7fvj7qyBmYb7XnYqg2Wwwzd8jatNQTLcEFBwOKOlBc0vggDQgqnP/ODNVV+yFydheO18KiFQDSCgMU7m11yAgI1IMmTYn8GP2aQFbdIW2sso4MocE+p+qjTiC58NpKx5GkYeYnoayn8pCwnvpZbVfkEKigIJzePNh9MukcTlbA0rOtmyZdPYtsLnUrn9/q3M8gqs5nHAuqMu2TY8Tk2RNP2axTfTuwUnnKOlkGet73NEGa2m3A9oLJney9bLBpQ/qrXEvVk6lrZdrsVxoCw1wjoplIUpKHkXx5nAEh0+FS9685PjAQS5Bi8JSP0oBkIVzduT61UN4/QRLIiQbxVDrpUobe5P6ECHVrjGiKEGaT0tnawdTyk58mIcFkIzXYGb/5DQmPO4bPWs2mayTnSx6merwmMPNOWPC8LswA/NYfoqgTJFq/ZzMvI7ZzDtI2ECYpIX66c46kVtnOsWXDqTkoAuKN/pWK36xffkJsfwgH7fXNzG/lWLCuOZ2KThHrVyvutuIlZKbvxe1P6CsMHZK9rIV/KZhEVnCxTzEAZ7jFK32OemmH6F/Cj2xM5YJQsAIQxCAw3PoPeuCKyKHb5R4Yn5OU1raWL18r2uj+9TZ5TrbbupL+p/FVuQmpqNI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB5070.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199021)(2906002)(83380400001)(186003)(2616005)(36756003)(38100700002)(85182001)(86362001)(38070700005)(122000001)(966005)(71200400001)(316002)(6486002)(41300700001)(8936002)(7416002)(5660300002)(8676002)(478600001)(54906003)(110136005)(66476007)(66556008)(64756008)(4326008)(66946007)(76116006)(91956017)(66446008)(26005)(53546011)(6512007)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckF5N043RVF5NnBseVEvYmpxL3VQMEY0S1pDOGtzZkNIdU4rS1UvTlZDQWZQ?=
 =?utf-8?B?bm9ZRENjY29zMHZrL2hOa3dLdkJaTFRTNVJNWGc5S2xKQ1oyeUtPdUlWd29y?=
 =?utf-8?B?VGNUa3ZsQ2Q4dm9UbXNqWk1kMjNuSUN6WXhjcXFCZ3N4SDQrWW5IYmppMitj?=
 =?utf-8?B?QmdBbHd5bnN3T1FwbE5CVmg3UGRObUM4MjNrV3FFSk9SU2Z0Q0NLTjR0Y2Nn?=
 =?utf-8?B?OG14N2E5bm9MSnJpYnl4dTFwVzRmK2UycDRHdHQ2TFNUSk15elptUncvcFU0?=
 =?utf-8?B?WkRpUkdMSDA4SDVBZTZ0cnlVWTF6ZkVyQjZrUkNDckE3bzdYbXYvN0ZpaHFi?=
 =?utf-8?B?MnJUS0thSFJmUnlvZUw5S09hVHNQNnhDM0Q2WnRCd3FDb1l5YWo1MWNmcVYz?=
 =?utf-8?B?YlZhRmNTd1d3WEhNcDM5WmVSZktKazZ4Z3B0cG5mOGxPVUt1YmlzVzhEcW00?=
 =?utf-8?B?OXhRcE9tSXhZMEZlV255cDBhTTlXamZQK2dpWHRBVnBwV3o5YTY5c09jR2o5?=
 =?utf-8?B?T1g4UG42ZDRlMFBUSHp4RWRXVVNQWG9LMmNaK3UrdWozdGdaaTAvYUlBbDk2?=
 =?utf-8?B?SFU2djFKZUFZa2hRMlFiLzkzaVBaMHdXNkJ1ZUZCYlUxdE9OYWdNdHk1d0kv?=
 =?utf-8?B?RXhjb2tDVndIWTZNMTM4SERhT3cwSjdkVk1Ya3VVUDJWTi9ObGVQTW1PNGov?=
 =?utf-8?B?eGtQNWpVTUE4RTVVSVMxREh6WmsxRVNRZjlvVjcxVXNvaklkT3drQm55QVNR?=
 =?utf-8?B?dUk1TEsyY1J3eHFBYklCVVNzUzQ2WFo5WC9qRmNRcEhJRmM5MnVDQUhqVEZu?=
 =?utf-8?B?T2VEVERzcEtGMVZ6Qk0rdUhFcEZhRjFvcGw2SGZBMVFwUi9YN0lHL2Q0SXh4?=
 =?utf-8?B?V2Q1UFFPVDRVaS9ITWRzcjIzZXpCdzZHa2NiWHZYYlRjOHVQUlBuWmJFN20x?=
 =?utf-8?B?a1dpTDhiMGZ1dWRtMHRqZzZTQ2dKRU4xVmJxdVJMeW9jNlVoM1k4eCt2WFpO?=
 =?utf-8?B?ZmVVcFpicFIzUENWbjJwdTUvZkY5YVNOeEs4RnlIZ2RQY0xEVk9JUE5lMG9I?=
 =?utf-8?B?b1hwakJFQTI4SXpQWEN2MlpJbWRSV1JGNUpnK3RKTGFueHJTMkwrclZsL2Yw?=
 =?utf-8?B?enBSeHVid09iYkZ4bUd3SHJ3U1oyNHdtbGZ0TDMrVjhIWGdSbk4rYlVBMVZK?=
 =?utf-8?B?dVJSN1hhU3Nzb2J6NkdlK1JjVGh5WkZUUkxIMWoxK3Z1NW9aaHpycy9sanJu?=
 =?utf-8?B?UkxtcmNFVDhNOGh0TUhZbVlJT20wZ3lKNUdhK2lodHpLZkZGMEhadU83RWJ6?=
 =?utf-8?B?RUNUUGFNM1Qwbm93bm1zSWpwSHJScmdyc2hMVWxmR3k4WklWWTMrSHpzVzgv?=
 =?utf-8?B?NXh3U3ZJbXJBZHplS3E1OHdnZ3Vyam9udnYvSHVGeXdqeFB2VVg2cWd4RTI1?=
 =?utf-8?B?NXlDOGNBRjVKMDNkMSt6M0xQc3dFV241N3hSYUNOV1Mvang5dnJ0L2s0MElt?=
 =?utf-8?B?d2pBNXI1eGZjdUhmNXVuWmNVdHlmUmhzbWFmWDRqaDZKaVcwWFpDSjRMQnFV?=
 =?utf-8?B?cVQ2clZzdFhsV3BxTXlRZFkrYmZoTG02RzR6a1RhVXNFRWkrQnFabkVLc1hN?=
 =?utf-8?B?QUYxZkVPWFNTeW9qaHhFdCtYa1NEN0krY0J6Y0pERURKM3FLTEVXdzlocXB3?=
 =?utf-8?B?ckV5UmdZY3B4S0xPMktqeVptaEJTRmhFSzAvbjhmb015WGpPQ1g1bGxBNjlL?=
 =?utf-8?B?RldvT21lOEVFcXd3TzRaNHVXYUNrZWloWGJScTRrTjVwajg3aHJRb2dNMUxR?=
 =?utf-8?B?c2RjNlp4TDd2VDNkUDlCMXdWTExnNDJmbmxQdHBka3BPOU01ZEJYSTRIZmRn?=
 =?utf-8?B?TDNBbHg3eVVBM3ZPWmtjS2h3ZStob0MxeXdranhwMFRKWmZ5dTJGTHJZS0Jp?=
 =?utf-8?B?RFI3VmFuSjV3WmZYc2lDK0ZHelllVnN1eE9Ud090U1pRWXZ4RGtWVXlNTmZ0?=
 =?utf-8?B?bGdQMVdpcGgzY29Na1VHeGJCSDlTK3BHYzZicXloOTJ1RnVaN3c5MnlWMUJX?=
 =?utf-8?B?Rjk2S2VDeTNKSGQ4TlVqam1QRy94cWhTOGlxWVd4WjhLc1dLRzdralZyUU5n?=
 =?utf-8?B?U213UllZYnJ1VDRiL1A3UVpCdUp0dFlYay9QUEhhN2JVU3BWRCtTdndQWkxY?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27C1EE10DE6F05488BF4FC043E83B667@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB5070.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f043202-d885-4cd3-f790-08db5cedb55b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 07:00:22.2177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZi9gcc/aWE38EZV/XgDsLSwBR5SuRfQ9zwCVdrmql2jHoAeSFbk7DtN+aooQut1onw8Fmh1ZCwW25H2u5gyHdG5D+xy21YtWvBc5gW/vg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7747
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA1LTIyIGF0IDExOjE5ICswNTMwLCBQcmFzaGFudGggSyB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiAyMi0wNS0yMyAwNzo1MSBhbSwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0K
PiA+IFdoZW4gZ3NlcmlhbF9kaXNjb25uZWN0IGhhcyBhbHJlYWR5IGNsZWFyZWQgZ3Nlci0+aW9w
b3J0LCBhbmQgdGhlDQo+ID4gc3VzcGVuZCB0cmlnZ2VycyBhZnRlcndhcmRzLCBnc2VyaWFsX3N1
c3BlbmQgZ2V0cyBjYWxsZWQsIHdoaWNoDQo+ID4gd2lsbA0KPiA+IGxlYWQgdG8gYWNjZXNzaW5n
IG9mIGdzZXItPmlvcG9ydCBhbmQgdGh1cyBjYXVzaW5nIG51bGwgcG9pbnRlcg0KPiA+IGRlcmVm
ZXJlbmNlLiBBZGQgYSBudWxsIHBvaW50ZXIgY2hlY2sgdG8gcHJldmVudCBpdCBhcyB0aGUgYmVs
bG93DQo+ID4gcGF0Y2ggZG9lczoNCj4gPiA1ZWM2M2ZkYmNhNjAgKCJ1c2I6IGdhZGdldDogdV9z
ZXJpYWw6IEFkZCBudWxsIHBvaW50ZXIgY2hlY2sgaW4NCj4gPiBnc2VyaWFsX3Jlc3VtZSIpDQo+
ID4gDQo+ID4gRml4ZXM6IGFiYTNhOGQwMWQ2MiAoInVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogYWRk
IHN1c3BlbmQgcmVzdW1lDQo+ID4gY2FsbGJhY2tzIikNCj4gPiBDYzogc3RhYmxlIDxzdGFibGVA
a2VybmVsLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1
bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rp
b24vdV9zZXJpYWwuYyB8IDEyICsrKysrKysrKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQo+ID4gYi9kcml2ZXJzL3VzYi9n
YWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KPiA+IGluZGV4IGEwY2E0N2ZiZmYwZi4uNDBiYTIy
MGNmNmQyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3Nl
cmlhbC5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMN
Cj4gPiBAQCAtMTQyMCwxMCArMTQyMCwxOCBAQCBFWFBPUlRfU1lNQk9MX0dQTChnc2VyaWFsX2Rp
c2Nvbm5lY3QpOw0KPiA+IA0KPiA+ICAgdm9pZCBnc2VyaWFsX3N1c3BlbmQoc3RydWN0IGdzZXJp
YWwgKmdzZXIpDQo+ID4gICB7DQo+ID4gLSAgICAgc3RydWN0IGdzX3BvcnQgICpwb3J0ID0gZ3Nl
ci0+aW9wb3J0Ow0KPiA+ICsgICAgIHN0cnVjdCBnc19wb3J0ICAqcG9ydDsNCj4gPiAgICAgICB1
bnNpZ25lZCBsb25nICAgZmxhZ3M7DQo+ID4gDQo+ID4gLSAgICAgc3Bpbl9sb2NrX2lycXNhdmUo
JnBvcnQtPnBvcnRfbG9jaywgZmxhZ3MpOw0KPiA+ICsgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZz
ZXJpYWxfcG9ydF9sb2NrLCBmbGFncyk7DQo+ID4gKyAgICAgcG9ydCA9IGdzZXItPmlvcG9ydDsN
Cj4gPiArICAgICBpZiAoIXBvcnQpIHsNCj4gPiArICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJnNlcmlhbF9wb3J0X2xvY2ssIGZsYWdzKTsNCj4gPiArICAgICAgICAgICAgIHJl
dHVybjsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIHNwaW5fbG9jaygmcG9ydC0+cG9y
dF9sb2NrKTsNCj4gPiArICAgICBzcGluX3VubG9jaygmc2VyaWFsX3BvcnRfbG9jayk7DQo+ID4g
ICAgICAgcG9ydC0+c3VzcGVuZGVkID0gdHJ1ZTsNCj4gPiAgICAgICBzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZwb3J0LT5wb3J0X2xvY2ssIGZsYWdzKTsNCj4gPiAgIH0NCj4gDQo+IEhpIENodW5m
ZW5nLA0KPiANCj4gVGhpcyBsb29rcyBzYW1lIGFzIHRoZSBmb2xsb3dpbmcgcGF0Y2guDQo+IA0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzE2ODMyNzgzMTctMTE3NzQtMS1naXQt
c2VuZC1lbWFpbC1xdWljX3ByYXNoa0BxdWljaW5jLmNvbS8NCg0KWWVzLCBpdCBpcywgcGxlYXNl
IGlnbm9yZSB0aGlzIG9uZSwgdGhhbmtzIGEgbG90DQoNCj4gDQo+IA0KPiBSZWdhcmRzDQo=
