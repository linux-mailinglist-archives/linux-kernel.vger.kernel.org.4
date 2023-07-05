Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF84747E9F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjGEHxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjGEHxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:53:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B94E6B;
        Wed,  5 Jul 2023 00:52:58 -0700 (PDT)
X-UUID: f2c1664a1b0811ee9cb5633481061a41-20230705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=Uasru7uQGWUas4H1562tAcUZknHOWVStTqIy/M8syCo=;
        b=FJXpWlvlJXJHt4KKUYRw45Xkbz/3WvLJ4VefZ1QsmdYYeaN84YCKRM28QP1eCHXE8iemD/hpdDDbtThxcwDYZ/sI/VTew13ah/PVXfXkq76pMbnwNvTuyOflP7ab7yCBws+6sfqWEeJvHLyhV3xLhhVudqK8W/MDFUZ5Anf+2sc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:ef1f7b27-266d-4d46-b219-c713d79eca18,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:73
X-CID-INFO: VERSION:1.1.27,REQID:ef1f7b27-266d-4d46-b219-c713d79eca18,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:73
X-CID-META: VersionHash:01c9525,CLOUDID:d453b882-5a99-42ae-a2dd-e4afb731b474,B
        ulkID:230704165329REDRFMN9,BulkQuantity:37,Recheck:0,SF:38|29|28|17|19|48|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,
        TF_CID_SPAM_FCD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM
X-UUID: f2c1664a1b0811ee9cb5633481061a41-20230705
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 551163678; Wed, 05 Jul 2023 15:52:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 5 Jul 2023 15:52:53 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 5 Jul 2023 15:52:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7kFLOQ6yy1eW1pycM866wLWEvF/V+/itHjADrFZNTKBYc72HqQW69lDj+rPHQ71+IZ1LLptkSLPONaPpW4qlnU410Xq/JxJgjq/yG7JZb9VD0c+T3VbctoosCy2+xpzBoUCdUV8H214WZygl/ny7TRpnGaXqnYjniZyO9C+9xV1RRAhGPEsNjHLMjKNUVkDdh1DU2lURjh99u/p8Ejjfv6Mm0b93cD4gcxWo4s2Bh64a/efBPN3ZoMS1Jwgz/K3f0WccfCLNUTrWIToW3aTO2aBlzKZvsCwvH7QHqULgBfznfjUWVZByKqh0wUMflwRhcvtx3pPMT/o1/z6tRVDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uasru7uQGWUas4H1562tAcUZknHOWVStTqIy/M8syCo=;
 b=JpTtrjXdpgwaHbgYua5ZlPUoHyE+44lCwGjcyTM93GJpEUGHRfEdh8LYI7DtbiCcEAMjK23rgKzn38WwDQzrRx5i4VbzFQnXr9J/YIs9ilVPF9iJRgoGY+miH+8VM8pKmZZdqbWPdbswgZKRD68GGD62y40UImhveHEPa2xbXmG4sRrOuxW0+eRJ/Am/Tc/it73o0xOcbB+holhXmuVQ+ALIesOrKxdhvQCM4AC0BwPAyc5SGBdBVbBxeSvU5PrPy8lpyJaZGrwUf+S61oEd2ilY/zRl63odQjJpZblLd+pqyobnwbiPPnFKZr88PnqX9+CWl7gDcdZ0oFs4a4Qu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uasru7uQGWUas4H1562tAcUZknHOWVStTqIy/M8syCo=;
 b=SrS2dZiUEmOmCjEks3xP9FWk5JcHrqMXd+dCibGry3TNaUXYJyGf75OpUM4VaNKOwvUyTW5e7gEiGpv4YAnuofzzttZmrE2uZkueIO6VLOZTvaknvHVSEnEragKRLPuBlPFslARlAwJNB9VujIzDdy3ZjumX6rcRCClje4FD+fk=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by JH0PR03MB8073.apcprd03.prod.outlook.com (2603:1096:990:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 07:52:51 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::d577:e8be:3ef3:6bd1]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::d577:e8be:3ef3:6bd1%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:52:51 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 2/7] ASoC: mediatek: mt7986: support audio clock
 control
Thread-Topic: [PATCH v2 2/7] ASoC: mediatek: mt7986: support audio clock
 control
Thread-Index: AQHZp9bh3xMt3XTebEyzTlDOwRGQFq+pWkgAgAGBbgA=
Date:   Wed, 5 Jul 2023 07:52:51 +0000
Message-ID: <eb01e347e3d7d2c07619c75ecb8d817a94009657.camel@mediatek.com>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
         <20230626023501.11120-3-maso.huang@mediatek.com>
         <ef7b62ab-b1f3-b687-7561-1ab65282ba23@collabora.com>
In-Reply-To: <ef7b62ab-b1f3-b687-7561-1ab65282ba23@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|JH0PR03MB8073:EE_
x-ms-office365-filtering-correlation-id: 0f6fd8c3-3445-4ed2-0272-08db7d2cd55a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUeUIQTBh8pjDBpbzPc/bNvNvHmuzJZp9WaA1oc9iCMg4iGI70z/DkV/5oKZ/LwzTtd4qzON3g/W/EH3O/qzmArU1KIrDnXUlkJYOZB3db1IlFkah1Wv+fRnLORXj13tfJfXCXHnJW9o3spC6CqlUVG3m560pXSY3dENcAITcjDEFQzF066GQOi/ttvNY9QDbfoqIbeFY14hcf4XFH9IIXyrRgY7zKJvZTUHdIQ9V2pkZYyVc+0Nb0zZYqqAEG+7MPV5dpHHelquNp6LjbJI85HdENhxY8s6Awty6R6sSuTqBD7z3YbZJYTIUbGb25mcPgfL4V56vAZCsnj/DzSkarU5i8gi9qMTP884X2w+FjrsfhHmONH3LXpTJ/SRnViJyHSHPn6sLn5fZ282prAQDnQf0u16n9PKFxoeF7ZQXAU4eKdz70foTS1OT5uSiAa2HPAthRkfei6ck3O8YKco4/p7hqB+B1awLNHFmtoY++dYLe9m6FswREE6qzw7MITUAL66GFgvvdIT+w6HR6jLXWEp5jsXCFEIZueFUstktJ1OpwnXq7CPuflbLD3iLmlPIzUE/1qkdKYgz+MT8fX+lTX8CzEcCLBldEd8/VoACIoSMpqv4x06VpYjEX2Y8I20xl+5IoKqKRo4/v3GJzeCZf/SgglwCYbx+hYrrQOho0i49n9Qt4mIqplJhq1oxynl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(38100700002)(91956017)(76116006)(66476007)(66446008)(66556008)(64756008)(66946007)(921005)(2616005)(122000001)(186003)(86362001)(85182001)(71200400001)(6486002)(6512007)(38070700005)(36756003)(26005)(478600001)(110136005)(6506007)(8936002)(8676002)(5660300002)(7416002)(2906002)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVBhemVBNTFWOXcwRk9jWGsxU09sNStuQUJKUEE4YnlaVlNETkNRc2w1MTVi?=
 =?utf-8?B?SHNReXZTRFoyTkkwQUpHMmNpYkExcTZCeGNBSkZKUVVTOS85M25oSmNjR2Nh?=
 =?utf-8?B?RDRtVDJGalp1T08wTEd1azhuNW5mcUl6K3I3TzZYdHo1ZlBLc1dHbWh6aFdK?=
 =?utf-8?B?ZlBlTXVmWG1VYTRrYmRaOTM2aHFnbUZabS9jQXZodFI0aU1vSk1CYUw2NHhT?=
 =?utf-8?B?YXBnblV3bVUxZlhTY04vVXdPZkxmbS9MK2dIa1h3ZFhkbHd3ckd1VnkyeDgy?=
 =?utf-8?B?MmhMVE1qQVRtWExQV0RkMURNZEw3UDNQbXdJMUMvZmtKL3ZNSTVRYkpOamlY?=
 =?utf-8?B?Y1VJbFpCNHZSQ1k4Um1hQTB2cHRVTWlWZGtEMnBIT1JtMHZ4d3hNaUhHUnE5?=
 =?utf-8?B?RnY2WWh2dDZuVGlac0xJVHYvZThnV0FtUFdlczc5WGExM0drOUI2YUlQQjlU?=
 =?utf-8?B?VFRFSnA5QS82d2h4NUNGbUJORmZlSnRnbXdiY25BeVEwdFAwRG05R2NQQ0Nk?=
 =?utf-8?B?K1BNTzlGTDN0SGE1SEJsOXdNd3J1cWRDUXMvRHJZSmhwdGkrUCt1NjEyZ0RO?=
 =?utf-8?B?U3V5Z1cwZHdvcTR4WWpjVkhrZ3pnM2w5OGthb29JQkZ3anZHNEw1ajVJbHlk?=
 =?utf-8?B?L3V3Mk5EYzlHNm80YVB5TEJ5MFVUc3ZLUWRkNThQS0FDRFA5Nk43d29vT3o4?=
 =?utf-8?B?L2xBWjAvell0L3pIUHBwRTNJWjhaQkQ4b0x5WGY2MGs4cnFXZzZWRkdMeW8v?=
 =?utf-8?B?VFFsSjlEZVdreEJsUU53K1k2bHdFaFhkamE0R2IybFZNOVp4dC9mTUxNUElw?=
 =?utf-8?B?YkVvKytRUUsrTFNJWUdQblZSUGsxSTY0RUE4eUE5ZjhmRXBTYlUxN1RMQSti?=
 =?utf-8?B?UHlPU01TWnZYaTJCRU9XQzNiYXJpaGl0WG5nTDdxNmlINUVWbFJZRk8weHFi?=
 =?utf-8?B?SzhKckpXMWR1ZCsyU2VMVDRmNWxUYUVSSnRYN2dCaVA4aUZ4VFBZcUFIN01w?=
 =?utf-8?B?MWVGVzhoa2d1Sk1adkNPNy9zb05pZ3Bzc0hZQ0Z5cHdJQllGWnByY2xCdmJi?=
 =?utf-8?B?RXZyeUE4RHVDa0wxQWxqR0o4UGErMkRvbGNLaXkzdzR5ZVdvM2gzdDJFYlMy?=
 =?utf-8?B?MC84b2V5eEZjeDBld0FncVcrKzJYSzVvaytobEQ1dDlDVTZ2Vkxid2RVRCt3?=
 =?utf-8?B?YWFoTXRtdTdBY3JSQzRZWVdqbTFSWHRzK01DN1hJSzMxcVZ5NEgzM29UNTh2?=
 =?utf-8?B?Mm5BN3NIRlhPTDJOeUkxclU3VU41amlqcDFGTzNPSEZJQjRNWCtIUkM2WkZX?=
 =?utf-8?B?YVFSM3BTam9vYTA2MjFjWnRoaWtPUnVKTEdUSEttcDQzdXhQR2dpT3BEOCty?=
 =?utf-8?B?K3ZBRm5DNkdFZERhbXd3YVJIUVNVNFdnbjRvdUpRNUZzb1hodmxsRjZPbk95?=
 =?utf-8?B?VDJWNEt6emRSLy9DbXZwT2lmSEFNVFN6ejBtNmt3R2J5am83Si9GYVUyVE9r?=
 =?utf-8?B?ZWc4NTV4ZmlJSDVkWHJvRlpHd01Qazg4enI1VTY4MFBMM0RSU2JCMlg5M1dW?=
 =?utf-8?B?WkVXUVhFZDRUQWlCZmVWNnluVExpVm5tWUozdXlQeUVuVUd6NjlkSzdVb3lI?=
 =?utf-8?B?QVphZ2RjcysxaFVjeGV2WUNWYkxBZVZzNXVzek9JYUVkTitCK2N5N3pUWEVw?=
 =?utf-8?B?M3RiUnNvei94Ni94RDRwRTJWS0YxbnYwemhla1dMaSsrZEM1ZUpaeHFHYVpF?=
 =?utf-8?B?ajFJZzhPeUJXV3BOR2sxckFqaFFkVnZyUEh4eFU2YTRYcDhZUGRIdWpIVFNn?=
 =?utf-8?B?bEF2M3VZbVZ0NmtrRjgrc0FpMmV3ekxyUnFTWGVwaUFSdGpPMXRHR0V4ZlFm?=
 =?utf-8?B?aytNVzd0eG9YQm1IQ2g4YnkzRVNnbXpGLzdlWC9Ld2lRUGFPRkdOMytEcHlH?=
 =?utf-8?B?elovUFlBbS9vUjhQZ05YTmkyaU5EWXdESmFDTEQ2bzdtR2IxMzE5T1BucEMy?=
 =?utf-8?B?dUlTUnpEWm1TdCtJYWcwUGFvcDh5Qm1YaEM3S2FzVFRCRlhjTWYzK003WDBU?=
 =?utf-8?B?OVBoeUhGL1dEbGNUeHpMNGtGQnBzcm54OUxuWUZQcnU3aEVKUit6K2J1R1Bt?=
 =?utf-8?B?QUo4YThJdDA3bzZIYyttb3pKaUFpZFNFSkRsTXEvb2pVMVR2RmVSam9CYkd6?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38EC30CCC0541445939A4CF5C8391698@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6fd8c3-3445-4ed2-0272-08db7d2cd55a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 07:52:51.4246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQkYPk33jdzUSGM3wrIks2vZUm7WBdhGaTw0NjniSBtu5ovVQjMDSMUM2D0QKG4/Nb34trufVo+0eVVFUZQObw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8073
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTA0IGF0IDEwOjUzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAyNi8wNi8yMyAwNDozNCwgTWFzbyBIdWFu
ZyBoYSBzY3JpdHRvOg0KPiA+IEFkZCBhdWRpbyBjbG9jayB3cmFwcGVyIGFuZCBhdWRpbyB0dW5l
ciBjb250cm9sLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hc28gSHVhbmcgPG1hc28uaHVh
bmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgc291bmQvc29jL21lZGlhdGVrL210Nzk4
Ni9tdDc5ODYtYWZlLWNsay5jIHwgNzUNCj4gKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAg
c291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9tdDc5ODYtYWZlLWNsay5oIHwgMTggKysrKysrDQo+
ID4gICAyIGZpbGVzIGNoYW5nZWQsIDkzIGluc2VydGlvbnMoKykNCj4gPiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1hZmUtY2xrLmMNCj4gPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1hZmUt
Y2xrLmgNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9t
dDc5ODYtYWZlLWNsay5jDQo+IGIvc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9tdDc5ODYtYWZl
LWNsay5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAu
LmE4YjVmYWUwNTY3Mw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9zb3VuZC9zb2MvbWVk
aWF0ZWsvbXQ3OTg2L210Nzk4Ni1hZmUtY2xrLmMNCj4gPiBAQCAtMCwwICsxLDc1IEBADQo+ID4g
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gKy8qDQo+ID4gKyAqIG10
Nzk4Ni1hZmUtY2xrLmMgIC0tICBNZWRpYVRlayA3OTg2IGFmZSBjbG9jayBjdHJsDQo+ID4gKyAq
DQo+ID4gKyAqIENvcHlyaWdodCAoYykgMjAyMSBNZWRpYVRlayBJbmMuDQo+ID4gKyAqIEF1dGhv
cjogVmljIFd1IDx2aWMud3VAbWVkaWF0ZWsuY29tPg0KPiA+ICsgKiAgICAgICAgIE1hc28gSHVh
bmcgPG1hc28uaHVhbmdAbWVkaWF0ZWsuY29tPg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpbmNs
dWRlIDxsaW51eC9jbGsuaD4NCj4gPiArDQo+ID4gKyNpbmNsdWRlICJtdDc5ODYtYWZlLWNvbW1v
bi5oIg0KPiA+ICsjaW5jbHVkZSAibXQ3OTg2LWFmZS1jbGsuaCINCj4gPiArI2luY2x1ZGUgIm10
Nzk4Ni1yZWcuaCINCj4gPiArDQo+ID4gK2VudW0gew0KPiA+ICtDS19JTkZSQV9BVURfQlVTX0NL
ID0gMCwNCj4gPiArQ0tfSU5GUkFfQVVEXzI2TV9DSywNCj4gPiArQ0tfSU5GUkFfQVVEX0xfQ0ss
DQo+ID4gK0NLX0lORlJBX0FVRF9BVURfQ0ssDQo+ID4gK0NLX0lORlJBX0FVRF9FRzJfQ0ssDQo+
ID4gK0NMS19OVU0NCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBjaGFyICphdWRf
Y2xrc1tDTEtfTlVNXSA9IHsNCj4gPiArW0NLX0lORlJBX0FVRF9CVVNfQ0tdID0gImF1ZF9idXNf
Y2siLA0KPiA+ICtbQ0tfSU5GUkFfQVVEXzI2TV9DS10gPSAiYXVkXzI2bV9jayIsDQo+ID4gK1tD
S19JTkZSQV9BVURfTF9DS10gPSAiYXVkX2xfY2siLA0KPiA+ICtbQ0tfSU5GUkFfQVVEX0FVRF9D
S10gPSAiYXVkX2F1ZF9jayIsDQo+ID4gK1tDS19JTkZSQV9BVURfRUcyX0NLXSA9ICJhdWRfZWcy
X2NrIiwNCj4gPiArfTsNCj4gPiArDQo+ID4gK2ludCBtdDc5ODZfaW5pdF9jbG9jayhzdHJ1Y3Qg
bXRrX2Jhc2VfYWZlICphZmUpDQo+ID4gK3sNCj4gPiArc3RydWN0IG10Nzk4Nl9hZmVfcHJpdmF0
ZSAqYWZlX3ByaXYgPSBhZmUtPnBsYXRmb3JtX3ByaXY7DQo+ID4gK2ludCByZXQsIGk7DQo+ID4g
Kw0KPiA+ICthZmVfcHJpdi0+Y2xrcyA9IGRldm1fa2NhbGxvYyhhZmUtPmRldiwgQ0xLX05VTSwN
Cj4gPiArc2l6ZW9mKCphZmVfcHJpdi0+Y2xrcyksIEdGUF9LRVJORUwpOw0KPiA+ICtpZiAoIWFm
ZV9wcml2LT5jbGtzKQ0KPiA+ICtyZXR1cm4gLUVOT01FTTsNCj4gPiArYWZlX3ByaXYtPm51bV9j
bGtzID0gQ0xLX05VTTsNCj4gPiArDQo+ID4gK2ZvciAoaSA9IDA7IGkgPCBhZmVfcHJpdi0+bnVt
X2Nsa3M7IGkrKykNCj4gPiArYWZlX3ByaXYtPmNsa3NbaV0uaWQgPSBhdWRfY2xrc1tpXTsNCj4g
PiArDQo+ID4gK3JldCA9IGRldm1fY2xrX2J1bGtfZ2V0KGFmZS0+ZGV2LCBhZmVfcHJpdi0+bnVt
X2Nsa3MsIGFmZV9wcml2LQ0KPiA+Y2xrcyk7DQo+ID4gK2lmIChyZXQpDQo+ID4gK3JldHVybiBk
ZXZfZXJyX3Byb2JlKGFmZS0+ZGV2LCByZXQsICJGYWlsZWQgdG8gZ2V0IGNsb2Nrc1xuIik7DQo+
ID4gKw0KPiA+ICtyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAraW50IG10Nzk4Nl9hZmVf
ZW5hYmxlX2Nsb2NrKHN0cnVjdCBtdGtfYmFzZV9hZmUgKmFmZSkNCj4gPiArew0KPiA+ICtzdHJ1
Y3QgbXQ3OTg2X2FmZV9wcml2YXRlICphZmVfcHJpdiA9IGFmZS0+cGxhdGZvcm1fcHJpdjsNCj4g
PiAraW50IHJldDsNCj4gPiArDQo+ID4gK3JldCA9IGNsa19idWxrX3ByZXBhcmVfZW5hYmxlKGFm
ZV9wcml2LT5udW1fY2xrcywgYWZlX3ByaXYtPmNsa3MpOw0KPiANCj4gWW91IGRvbid0IG5lZWQg
YSB3cmFwcGVyIGZ1bmN0aW9uIGZvciBqdXN0IGEgc2luZ2xlDQo+IGNsa19idWxrX3ByZXBhcmVf
ZW5hYmxlKCkgY2FsbC4NCj4gDQoNCk9LLCBJJ2xsIHVzZSBjbGtfYnVsa19wcmVwYXJlX2VuYWJs
ZSBkaXJlY3RseS4NCg0KPiA+ICtpZiAocmV0KQ0KPiA+ICtyZXR1cm4gZGV2X2Vycl9wcm9iZShh
ZmUtPmRldiwgcmV0LCAiRmFpbGVkIHRvIGVuYWJsZSBjbG9ja3NcbiIpOw0KPiA+ICsNCj4gPiAr
cmV0dXJuIDA7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwobXQ3OTg2X2FmZV9lbmFi
bGVfY2xvY2spOw0KPiA+ICsNCj4gPiAraW50IG10Nzk4Nl9hZmVfZGlzYWJsZV9jbG9jayhzdHJ1
Y3QgbXRrX2Jhc2VfYWZlICphZmUpDQo+ID4gK3sNCj4gPiArc3RydWN0IG10Nzk4Nl9hZmVfcHJp
dmF0ZSAqYWZlX3ByaXYgPSBhZmUtPnBsYXRmb3JtX3ByaXY7DQo+ID4gKw0KPiA+ICtjbGtfYnVs
a19kaXNhYmxlX3VucHJlcGFyZShhZmVfcHJpdi0+bnVtX2Nsa3MsIGFmZV9wcml2LT5jbGtzKTsN
Cj4gDQo+IFNhbWUgZm9yIHRoaXMgb25lLi4uLg0KPiANCg0KT0suDQoNCj4gLi4uIHdoaWNoIG1l
YW5zIHRoYXQgdGhpcyBmaWxlIHdpbGwgaGF2ZSBvbmx5IG10Nzk4Nl9pbml0X2Nsb2NrKCkgc28s
DQo+IHVsdGltYXRlbHksDQo+IHlvdSBkb24ndCBuZWVkIGEgbXQ3OTg2LWFmZS1jbGsuYyBmaWxl
IGF0IGFsbC4NCj4gUGxlYXNlIG1lcmdlIHRoaXMgbG9naWMgaW50byBtdDc5ODYtYWZlLXBjbS5j
LCB3aGljaCBpcyBhbHNvIHRoZSBvbmx5DQo+IHVzZXIgb2YgaXQuDQo+IA0KPiBUaGFua3MsDQo+
IEFuZ2Vsbw0KPiANCg0KSGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KSSds
bCByZW1vdmUgbXQ3OTg2LWFmZS1jbGsuYyBhbmQgbWVyZ2UgcmVsYXRlZCBjbG9jayBhcGkgdG8g
bXQ3OTg2LWFmZS0NCnBjbS5jIGluIHYzIHBhdGNoLg0KDQpCZXN0IHJlZ2FyZHMsDQpNYXNvDQoN
Cg==
