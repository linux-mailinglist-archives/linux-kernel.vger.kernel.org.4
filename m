Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C10A69B0EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjBQQal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjBQQai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:30:38 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2053.outbound.protection.outlook.com [40.107.9.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C7E70958;
        Fri, 17 Feb 2023 08:29:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js7vuoNVcO9KSCJQXjn/M281pRnCDNo0t/JO9wTMqJpZ8VMTB2dWw/WU6LE3fk47nq2Omg2rNBGMfCP1Opj4mxThcDk3MMvX3KCKouWMJzY3plcIJcl5IPmJT9QmoUFoqH0XLiSURpmHd+ueDu4rKAPUiOlf/wpYg4txOppXf8+AMKlJPFSCB7mcpUGtaGxVd9H2PEyngOZEqxM3smG1AkBGQzzp/r86q4ZSi2KkO5OwkuOgKNOQvbIDLphiD03Ofp2gR8j5/sUjUs3TUhIVxc8+9Y8l+SqZmDptsC5QLsAYuzuLksOrQQv6M/SnO43D+kGte4u6Oh+noxkN9NFv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMNVTmgnD7AhLygtymXZ454XaMBgvJjaJuFjSXCJUJA=;
 b=hS/D1rRmkE2Nb4AmOFGHRd5wcK4J1yRic2z3OLCaFvZ2RNm0oMd7oygtxpakUn1tJCllTQcT0VwA07wYMKb3jdqXWD+bJdL8nCNMWI48OWMHuK9Kjfv6Ae7Jozi0kOuT4r6renL2Aktpe89kQpcvOaQybefX98eZ1dKIMuEc8lvGchCJywcpLzVpaaZgUz07QEA5hMxl9UNJL8c56w5TKmmQ53ZV8WNR56312tlUDzlepl1CMwNGkmvwXip7YhbNNJQSBScKsd+l7tsgm9J4+YTJ/9IHx+1P6Esp319RWW1QkofGtGws1h0zQzkG/v+D2VA/ayMH7gZbQCi35+jhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMNVTmgnD7AhLygtymXZ454XaMBgvJjaJuFjSXCJUJA=;
 b=66IpbKx2fPqRSR6WJwEYwPRlq0zj5f6/HjT/1NyfcDb6LIw5cLiyZC1gZ6+52ZnZWKZJ1LNUZB+PsaS8PmgczykX4+krEcpTQD1OlnP91zDA/TArCf+9suW/qOoUZTZwdms7hT1OKD/gwkvRX+/lXLMSthaCNGadOZSOHINTnWzn9qdo89Z+ig0WDa4EiOCXPPjUZVo9siCRbRntzFdVLN89oxCSlbG34XKdKYj7UwKj747mFsfzH054XNH6xFUwvvIW5jDPhWcXCKjev0johRh1QL9Epp14WSo/lU+2C7eLu9/M76/L2+cC4yqxyImjPlJM2zdsd1wTWNcwlyLjFw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3137.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 16:29:21 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 16:29:21 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Herve Codina <herve.codina@bootlin.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 08/10] dt-bindings: sound: Add support for QMC audio
Thread-Topic: [PATCH v6 08/10] dt-bindings: sound: Add support for QMC audio
Thread-Index: AQHZQuAi7QZI6BiaOEu6epzn+Y7Sfq7TVDmA
Date:   Fri, 17 Feb 2023 16:29:21 +0000
Message-ID: <8cfe6e5c-ecf6-679a-8c36-c5a25290cf14@csgroup.eu>
References: <20230217145645.1768659-1-herve.codina@bootlin.com>
 <20230217145645.1768659-9-herve.codina@bootlin.com>
In-Reply-To: <20230217145645.1768659-9-herve.codina@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3137:EE_
x-ms-office365-filtering-correlation-id: 16c4c179-a617-4ca2-6e8f-08db11041ffa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tSxL2TaVtbgwW8fMvPURRJeAaFQy2ybFPHc2Wiyna+03+U7PKfPQlV6w4GYOfBeXyRd935EfJFmoRr0Ab31r5igDl4TY6nJ24MCR9NKwhQy1OMPnjnffCqAY1VyXYopFNLpbfylwULVniB28M32Fpst77AEWrRLwrP3BE7Mi74s9we4od9mYunfG+tXveQoONlG//NFYexf/QCRLmEQmV61GipoKU9ljti25LGSPzOgOMwUM1Obaf6+X6QAgNpjnQAiz8QBrHZ4ie3uuHGjvdDE/BTYMYAAKrAvJf33mFZeTk2Azuwyhc8r9q2Gw9KXuZB7FZPfpgYgQ8R1BEJlbv64FmoiyiZLy45gmWs0dn9IN/Waz3iMnuhCqFCnNoe8p1X+IkW8WN1cBiWXG0SJFlnkHT9i7+SVYYnkrljHqwkqGSy4H27fDzpNtMNVCowisMbJ84NlF3iJ9LNb/uTUny487V3EaityQHNMdzZUPxk+ZEM2AOZZLOwkiIiyPWBmDIqtUGV820vUcL7zD8hdI5L/YA5tWq2G5A5jUCcA6qc3mD4VWy3WbtyFQnwptYeeDqLYRXZ1oozWku6JP273bFv3XOlVgUzFuBpcVOD4CbGPh2oxPn8J0T8nFeldY0BqHKZn8rAZg9LkDq+Hm8ye4AnJcClWZYRNfYRH3SjNGCP6aiL2xoDAPJI8xHvXxTBU9CYJ1Ohf2M6K3xqh5pWYb79+D6+UJXycxNxZA/ezR+eVAxfKEgJS42rwFRzSp2oh7MJPqjFRV+5yb9BFgbIya3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(136003)(346002)(396003)(376002)(366004)(451199018)(2906002)(44832011)(31696002)(86362001)(36756003)(2616005)(38070700005)(122000001)(921005)(66556008)(91956017)(76116006)(64756008)(66446008)(8676002)(66476007)(54906003)(316002)(110136005)(7416002)(41300700001)(8936002)(5660300002)(4326008)(66946007)(38100700002)(26005)(6512007)(186003)(71200400001)(478600001)(6506007)(6486002)(966005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amtzVnRydGJscHNTVnJTaC95MU1meUF3amJaUmNrYldJZ0VIc2NqQlZ0WXRQ?=
 =?utf-8?B?YncrMUhxOFNoWXp1dHRGZXU5NlJpZHdBYTgwY0dSdXhPK1VHbWV0dUZtK2Rq?=
 =?utf-8?B?aVpsVitvbW9TYmVMTDc5WGVoRFRVRFVpbnQrZ1ZKSzJqUk9WY05nSGtHY0Rn?=
 =?utf-8?B?VkhMVFVmZ2xXT3NCQVVZbFlKWTlPZGhXZUtvN0FzalFnZUlYNE5XMTRhdEFB?=
 =?utf-8?B?Z1EwVjZTNXNlY3YwNm1WbHFnY1RsNmhkb3pxeWViWEtyYzRKUE9mdHZNTnly?=
 =?utf-8?B?NE16Q1YyUFlRRW1Ia2JFRFptR0NoS0Q1OWVIemdoeFJCc2E0d2ZqMlRFVTBB?=
 =?utf-8?B?dVpmNmNMRXdiTlUvSytaWnhTZkkySS91YkRCNzJ3SnZLL2hWaDRlczZsdjN2?=
 =?utf-8?B?ZE9WaXovdWhSVENycE5EeEdqREZ4VkRFQmVpVkhPdlNvTXp5dC81VTdVMVlO?=
 =?utf-8?B?NDdSZmZIcytDaklaKzZ4Q2lkazh5SWJHc3RCVEhIaXhMbTRtMXVMNE5BcGVM?=
 =?utf-8?B?UzhhU0gxN2Z1dHBtalZHNFRhaTVDYWVsdUQ4ZjU3SVlkbllXQXBGNlBraUdk?=
 =?utf-8?B?d3RBSkc4T1ozME1wQlRHdDMxNFdGY0N5UWdIL1FTSllCZE9GT0JHMjh3RmZL?=
 =?utf-8?B?K3pGZ0VHc2NlMDhKdmpNczJGc243OFdTR2Zock5hdHo1TXljdlh2OXlSaTZm?=
 =?utf-8?B?WnJNd2hlYmlVdGhKR0NDNEtFM3oraDJKRm9CT0Z4R21ERGN0bDVZenE3ZG5Q?=
 =?utf-8?B?RE1mZmpIQ2IzTGFGaXNUZS9FY29nZzNXRXZNQ2pPc2MvQXRXN1Y1VFZhalAw?=
 =?utf-8?B?ZFhqdDBHd2pEUzl1YS9XQjFLbUJCUGlnZ3hlWDRRRFBIMkZUR09HRzNzbDFK?=
 =?utf-8?B?WEliTHRoV2UzYUxKNjRNcVRFbFVndUxjWTB0eUdPa3ppYnlVYTV3WHR1MGdU?=
 =?utf-8?B?czJTWWtQaG5uK1lzUUNFL2dpS0RjQ2RFUXR3NmoxdXJWM21mKzF6RHNtVnVr?=
 =?utf-8?B?Vm4rVko2T3hyMFkyTzBBdGdoa25RRkdrQjhWenhMbUxGYmFQV3JWd0FhRHEw?=
 =?utf-8?B?V0NLT1B6NGRyTXppRFM5Ym5saW9yQVFaWnpFVlF3SnZ3aUhaSkFrR2JjUzJZ?=
 =?utf-8?B?dGlxbHRTZndvZ2ZHKzREdUwzQVZFMGowaDBGb2d6WjcxM2tQdml6Y2Z4MmEy?=
 =?utf-8?B?Q2dwZCt3ZHRJN2pNcGVSRExxWGFRU3YxZS9LVFdSWGkzNlUya2swRWhUaXJC?=
 =?utf-8?B?TlZodjk3SkdHZ25zQ2kxMTR3ZUlRNEdVZ2JzaTJSK1daMDBVaUMxUENHL1lv?=
 =?utf-8?B?clV0UFF3eHRDQnF4dGNJdWdORk4yQ1ZqcGRzR1FXSG52bDlVWlAxMUZQQkdQ?=
 =?utf-8?B?TkxIbE5BTm1Gd3VWK1M5Vm1VQlVKeEpYVnhSS29qRmRxOUdXdm9pUWIzaEJv?=
 =?utf-8?B?TkFvL2FPeU14Wmcyemh6WGlBVmlaVjJlZ05KRUdrY2RoSmlWcjRPNXhyMXZU?=
 =?utf-8?B?dUtqOHVWNXBpWlZtSVN3c2RBTjFjMnBzbHpwdHNQdWVPdW1QYm16aUVBeGFM?=
 =?utf-8?B?bVR2OW5lK3NKUS9GQklrem0zTXR3M2JkekszL211YnJUQWFmUzB3QmtEUFRs?=
 =?utf-8?B?cklWOWt0QlVuU3pTdXU1bzNodXJCY3QyYVExVlo4a3gvdzFDNWJxbHBycHVZ?=
 =?utf-8?B?NTIwYUVJOUpBb1BIZ1ZBbHdvODFFdzBucktac0xJWXpXdlJhWFhDSURaaVBq?=
 =?utf-8?B?Q0cwWWVkdTdPMkU5UDJScmtUTUdhWUJvcUNtYnQ3TmdjeitlM00zNlJzSEtP?=
 =?utf-8?B?TUIzL3ExTk92TzYzc0MyenNJY2NYNDdqSDYvMWNvMXhaRmEzZTg3NUV6R1J3?=
 =?utf-8?B?bUI1QnBFckJGV3ZpMTV6T3F1Nmk2LzBQbDlTRjkvRlpweE1uOGQxdXlkSkdZ?=
 =?utf-8?B?dmlCdUdadUllbmRZMVZ2SG5kdU1YVVVpSHcxMVc5emdKd2Y2ME1RR2MwcW5t?=
 =?utf-8?B?dFZFVkxpNU00a25OelZyN2RJM0Z6SGo1SGk4c1NrcVhoZ0NQR202OGpYRVhu?=
 =?utf-8?B?V3hBQmUyOGdnaHlsZC9rQmVPSnBDVG9BY0xGeWh4cXcvaEJ0c0xvSlhydWx3?=
 =?utf-8?B?VmxRdnBZUHAyY05vRlh4NlRhWjQwWHh3UjVHa0hjbXdtV09la2JsalJXYkpV?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B8F3386372C9143B9ABE4DBB0FF6A34@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c4c179-a617-4ca2-6e8f-08db11041ffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 16:29:21.6479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWkwFUoQOApJxbMzxuBSJC2R+Tv5U3znfi3ZwbdjCl5Tr8tcYDbJwWEaA9uXRwk2m1+WxTmz6TYZarOy+j7S6F3mveWl4OOY6qKX8KwOts4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3137
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE3LzAyLzIwMjMgw6AgMTU6NTYsIEhlcnZlIENvZGluYSBhIMOpY3JpdMKgOg0KPiBU
aGUgUU1DIChRVUlDQyBtdXRpY2hhbm5lbCBjb250cm9sbGVyKSBpcyBhIGNvbnRyb2xsZXINCj4g
cHJlc2VudCBpbiBzb21lIFBvd2VyUVVJQ0MgU29DIHN1Y2ggYXMgTVBDODg1Lg0KPiBUaGUgUU1D
IGF1ZGlvIGlzIGFuIEFTb0MgY29tcG9uZW50IHRoYXQgdXNlcyB0aGUgUU1DDQo+IGNvbnRyb2xs
ZXIgdG8gdHJhbnNmZXIgdGhlIGF1ZGlvIGRhdGEuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIZXJ2
ZSBDb2RpbmEgPGhlcnZlLmNvZGluYUBib290bGluLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCg0KUmV2aWV3
ZWQtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4NCg0K
PiAtLS0NCj4gICAuLi4vYmluZGluZ3Mvc291bmQvZnNsLHFtYy1hdWRpby55YW1sICAgICAgICAg
fCAxMTcgKysrKysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDExNyBpbnNlcnRp
b25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb3VuZC9mc2wscW1jLWF1ZGlvLnlhbWwNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvZnNsLHFtYy1hdWRpby55YW1sIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2ZzbCxxbWMtYXVkaW8ueWFt
bA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmZmNWNkOTI0
MTk0MQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb3VuZC9mc2wscW1jLWF1ZGlvLnlhbWwNCj4gQEAgLTAsMCArMSwxMTcgQEANCj4g
KyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNl
KQ0KPiArJVlBTUwgMS4yDQo+ICstLS0NCj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3Nj
aGVtYXMvc291bmQvZnNsLHFtYy1hdWRpby55YW1sIw0KPiArJHNjaGVtYTogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ICsNCj4gK3RpdGxlOiBRTUMgYXVk
aW8NCj4gKw0KPiArbWFpbnRhaW5lcnM6DQo+ICsgIC0gSGVydmUgQ29kaW5hIDxoZXJ2ZS5jb2Rp
bmFAYm9vdGxpbi5jb20+DQo+ICsNCj4gK2Rlc2NyaXB0aW9uOiB8DQo+ICsgIFRoZSBRTUMgYXVk
aW8gaXMgYW4gQVNvQyBjb21wb25lbnQgd2hpY2ggdXNlcyBRTUMgKFFVSUNDIE11bHRpY2hhbm5l
bA0KPiArICBDb250cm9sbGVyKSBjaGFubmVscyB0byB0cmFuc2ZlciB0aGUgYXVkaW8gZGF0YS4N
Cj4gKyAgSXQgcHJvdmlkZXMgYXMgbWFueSBEQUkgYXMgdGhlIG51bWJlciBvZiBRTUMgY2hhbm5l
bCB1c2VkLg0KPiArDQo+ICthbGxPZjoNCj4gKyAgLSAkcmVmOiBkYWktY29tbW9uLnlhbWwjDQo+
ICsNCj4gK3Byb3BlcnRpZXM6DQo+ICsgIGNvbXBhdGlibGU6DQo+ICsgICAgY29uc3Q6IGZzbCxx
bWMtYXVkaW8NCj4gKw0KPiArICAnI2FkZHJlc3MtY2VsbHMnOg0KPiArICAgIGNvbnN0OiAxDQo+
ICsgICcjc2l6ZS1jZWxscyc6DQo+ICsgICAgY29uc3Q6IDANCj4gKyAgJyNzb3VuZC1kYWktY2Vs
bHMnOg0KPiArICAgIGNvbnN0OiAxDQo+ICsNCj4gK3BhdHRlcm5Qcm9wZXJ0aWVzOg0KPiArICAn
XmRhaUAoWzAtOV18WzEtNV1bMC05XXw2WzAtM10pJCc6DQo+ICsgICAgZGVzY3JpcHRpb246DQo+
ICsgICAgICBBIERBSSBtYW5hZ2VkIGJ5IHRoaXMgY29udHJvbGxlcg0KPiArICAgIHR5cGU6IG9i
amVjdA0KPiArDQo+ICsgICAgcHJvcGVydGllczoNCj4gKyAgICAgIHJlZzoNCj4gKyAgICAgICAg
bWluaW11bTogMA0KPiArICAgICAgICBtYXhpbXVtOiA2Mw0KPiArICAgICAgICBkZXNjcmlwdGlv
bjoNCj4gKyAgICAgICAgICBUaGUgREFJIG51bWJlcg0KPiArDQo+ICsgICAgICBmc2wscW1jLWNo
YW46DQo+ICsgICAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3Bo
YW5kbGUtYXJyYXkNCj4gKyAgICAgICAgaXRlbXM6DQo+ICsgICAgICAgICAgLSBpdGVtczoNCj4g
KyAgICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogcGhhbmRsZSB0byBRTUMgbm9kZQ0KPiArICAg
ICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBDaGFubmVsIG51bWJlcg0KPiArICAgICAgICBkZXNj
cmlwdGlvbjoNCj4gKyAgICAgICAgICBTaG91bGQgYmUgYSBwaGFuZGxlL251bWJlciBwYWlyLiBU
aGUgcGhhbmRsZSB0byBRTUMgbm9kZSBhbmQgdGhlIFFNQw0KPiArICAgICAgICAgIGNoYW5uZWwg
dG8gdXNlIGZvciB0aGlzIERBSS4NCj4gKw0KPiArICAgIHJlcXVpcmVkOg0KPiArICAgICAgLSBy
ZWcNCj4gKyAgICAgIC0gZnNsLHFtYy1jaGFuDQo+ICsNCj4gK3JlcXVpcmVkOg0KPiArICAtIGNv
bXBhdGlibGUNCj4gKyAgLSAnI2FkZHJlc3MtY2VsbHMnDQo+ICsgIC0gJyNzaXplLWNlbGxzJw0K
PiArICAtICcjc291bmQtZGFpLWNlbGxzJw0KPiArDQo+ICthZGRpdGlvbmFsUHJvcGVydGllczog
ZmFsc2UNCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAgIGF1ZGlvX2NvbnRyb2xs
ZXI6IGF1ZGlvLWNvbnRyb2xsZXIgew0KPiArICAgICAgICBjb21wYXRpYmxlID0gImZzbCxxbWMt
YXVkaW8iOw0KPiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKyAgICAgICAgI3Np
emUtY2VsbHMgPSA8MD47DQo+ICsgICAgICAgICNzb3VuZC1kYWktY2VsbHMgPSA8MT47DQo+ICsg
ICAgICAgIGRhaUAxNiB7DQo+ICsgICAgICAgICAgICByZWcgPSA8MTY+Ow0KPiArICAgICAgICAg
ICAgZnNsLHFtYy1jaGFuID0gPCZxbWMgMTY+Ow0KPiArICAgICAgICB9Ow0KPiArICAgICAgICBk
YWlAMTcgew0KPiArICAgICAgICAgICAgcmVnID0gPDE3PjsNCj4gKyAgICAgICAgICAgIGZzbCxx
bWMtY2hhbiA9IDwmcW1jIDE3PjsNCj4gKyAgICAgICAgfTsNCj4gKyAgICB9Ow0KPiArDQo+ICsg
ICAgc291bmQgew0KPiArICAgICAgICBjb21wYXRpYmxlID0gInNpbXBsZS1hdWRpby1jYXJkIjsN
Cj4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsgICAgICAgICNzaXplLWNlbGxz
ID0gPDA+Ow0KPiArICAgICAgICBzaW1wbGUtYXVkaW8tY2FyZCxkYWktbGlua0AwIHsNCj4gKyAg
ICAgICAgICAgIHJlZyA9IDwwPjsNCj4gKyAgICAgICAgICAgIGZvcm1hdCA9ICJkc3BfYiI7DQo+
ICsgICAgICAgICAgICBjcHUgew0KPiArICAgICAgICAgICAgICAgIHNvdW5kLWRhaSA9IDwmYXVk
aW9fY29udHJvbGxlciAxNj47DQo+ICsgICAgICAgICAgICB9Ow0KPiArICAgICAgICAgICAgY29k
ZWMgew0KPiArICAgICAgICAgICAgICAgIHNvdW5kLWRhaSA9IDwmY29kZWMxPjsNCj4gKyAgICAg
ICAgICAgICAgICBkYWktdGRtLXNsb3QtbnVtID0gPDQ+Ow0KPiArICAgICAgICAgICAgICAgIGRh
aS10ZG0tc2xvdC13aWR0aCA9IDw4PjsNCj4gKyAgICAgICAgICAgICAgICAvKiBUUyAzLCA1LCA3
LCA5ICovDQo+ICsgICAgICAgICAgICAgICAgZGFpLXRkbS1zbG90LXR4LW1hc2sgPSA8MCAwIDAg
MSAwIDEgMCAxIDAgMT47DQo+ICsgICAgICAgICAgICAgICAgZGFpLXRkbS1zbG90LXJ4LW1hc2sg
PSA8MCAwIDAgMSAwIDEgMCAxIDAgMT47DQo+ICsgICAgICAgICAgICB9Ow0KPiArICAgICAgICB9
Ow0KPiArICAgICAgICBzaW1wbGUtYXVkaW8tY2FyZCxkYWktbGlua0AxIHsNCj4gKyAgICAgICAg
ICAgIHJlZyA9IDwxPjsNCj4gKyAgICAgICAgICAgIGZvcm1hdCA9ICJkc3BfYiI7DQo+ICsgICAg
ICAgICAgICBjcHUgew0KPiArICAgICAgICAgICAgICAgIHNvdW5kLWRhaSA9IDwmYXVkaW9fY29u
dHJvbGxlciAxNz47DQo+ICsgICAgICAgICAgICB9Ow0KPiArICAgICAgICAgICAgY29kZWMgew0K
PiArICAgICAgICAgICAgICAgIHNvdW5kLWRhaSA9IDwmY29kZWMyPjsNCj4gKyAgICAgICAgICAg
ICAgICBkYWktdGRtLXNsb3QtbnVtID0gPDQ+Ow0KPiArICAgICAgICAgICAgICAgIGRhaS10ZG0t
c2xvdC13aWR0aCA9IDw4PjsNCj4gKyAgICAgICAgICAgICAgICAvKiBUUyAyLCA0LCA2LCA4ICov
DQo+ICsgICAgICAgICAgICAgICAgZGFpLXRkbS1zbG90LXR4LW1hc2sgPSA8MCAwIDEgMCAxIDAg
MSAwIDE+Ow0KPiArICAgICAgICAgICAgICAgIGRhaS10ZG0tc2xvdC1yeC1tYXNrID0gPDAgMCAx
IDAgMSAwIDEgMCAxPjsNCj4gKyAgICAgICAgICAgIH07DQo+ICsgICAgICAgIH07DQo+ICsgICAg
fTsNCg==
