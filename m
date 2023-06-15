Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861A2730EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjFOFvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbjFOFvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:51:25 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1357270E;
        Wed, 14 Jun 2023 22:51:17 -0700 (PDT)
X-UUID: a32438560b4011eeb20a276fd37b9834-20230615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=F19zNWHP/LFmCkU9CfWOIYzAw9jBKV50J+E21kyLQ74=;
        b=DLqqLkIUbLzlNWPr9jd6a9AgDBNRMXsJfIw1+1x6tQXC+racVCHLvPqbdfN3FwlFdyiRPGCn5nhkUKEZbxr2FlfrjhbM/6v7c/LMZVG+XYeAp9edOGRhF8DRzEVOSXPXQKBGE1VjLU9hpL1+lFjha10o7Ss+SCUgLhZxB5P/g2U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:deb0d3f3-333f-4e2f-b340-664385a1f067,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:40
X-CID-INFO: VERSION:1.1.26,REQID:deb0d3f3-333f-4e2f-b340-664385a1f067,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:40
X-CID-META: VersionHash:cb9a4e1,CLOUDID:24b07e3e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230615135114GQF063XV,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_ULS
X-UUID: a32438560b4011eeb20a276fd37b9834-20230615
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1911929933; Thu, 15 Jun 2023 13:51:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Jun 2023 13:51:12 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Jun 2023 13:51:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2v4mqI0DrDmtEN0GEy1wQuL0WUIDgaywcESauGIs4TvIQyzoqmSy1/i5QJwlIzC2dToDyuvVdpj1Yjqdf1BU67HnzmlIkpNsd8W75eyu6aXxaMesCXY5jXkfBjRFQbW1pe5D7HZAofy2FdAykcDxN2jlSNdMt26QFi7MFrbwoAceXNwVelUy42XWUCWrobPSuj0hI82Vo6O/iiTy8IlJdPubv8a7bKUX5uM0/od/ucSHbdLFz5rbszjxUZTqJ5x0Mgwbo2kIGlRvF65L3VDnOmOQFVlvyEl7duwi0KlKtpQWcWD62I6sexTkXS2F24XJRueA2vBI9Isp3xo+UnQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F19zNWHP/LFmCkU9CfWOIYzAw9jBKV50J+E21kyLQ74=;
 b=KVWTXOLVLNZGXcJAf//zJrLfyWq/8z+qALjmBV78UQFP2pG9QMRwxDW02M+V2A1HHrgbgLeBtHzP9xBSc15YCScWi1gdJ91j9feXZ7aeolNo23erI/JaTKjq9nPp/QvWHIwfVbLuQp2u4iwLK6a2wiTNxgE1kUrsWA/oIGD94XbsaupHcAVnkRfdV0mTjD0Mhzk3eX0+HJEaeN9UbAv9Zv2/iZlMz0rzhsKmdUCGrOpNp+VlZOKmee5jmeqxaRXgv8F2MjsfdvYk4NPLllYmwOSnC2uqzFSmLynYTnG0SFHXBDEvAywM82t1O0qcQ1/lQj0kAfIoik4cTqu31TcCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F19zNWHP/LFmCkU9CfWOIYzAw9jBKV50J+E21kyLQ74=;
 b=hrWCE1dbJdPip/IakE1KiIYvJpw0L3YCMY1e9oIAWJAlnvCBiIN8b8o+b9DJS6jLEbEz2rTF0f/n2zn2yvEtFKuveiCVau8mepQJUp5pz3+YXKqdxZPKFsY8asNwOYNbLOGeN3izceUD+573KqmTz575axV2OMFoWpgas2NVeaU=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by TYZPR03MB8091.apcprd03.prod.outlook.com (2603:1096:400:45d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Thu, 15 Jun
 2023 05:51:10 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::dbf3:d56:46f:ec66%5]) with mapi id 15.20.6455.039; Thu, 15 Jun 2023
 05:51:09 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 01/15] dt-bindings: display: mediatek: ethdr: Add
 compatible for MT8188
Thread-Topic: [PATCH v2 01/15] dt-bindings: display: mediatek: ethdr: Add
 compatible for MT8188
Thread-Index: AQHZnpJyRuTV4lK0V0utMt58FihBmK+KLSEAgAEwfoA=
Date:   Thu, 15 Jun 2023 05:51:09 +0000
Message-ID: <6c24ad522f42ce35bf387bae1b8a029f58bb0e01.camel@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
         <20230614073125.17958-2-shawn.sung@mediatek.com>
         <1f044902-0726-34ed-3eea-7224e5750e22@collabora.com>
In-Reply-To: <1f044902-0726-34ed-3eea-7224e5750e22@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|TYZPR03MB8091:EE_
x-ms-office365-filtering-correlation-id: ed4ed0bf-9dd4-4559-5b85-08db6d64850d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jR6b4vF4ZzHTut484qA9XgyPOo1FMuj1zgXpUmLMuqEFzb/Rg/tqwZc9y39odtqhYRhmqHygov/5tl+nI6dutTNcgfNYmqki1VfsZR6ZzfjySOIDBHFvBHuVMfZ+vZ9+8B42YkLpDOn/lha6ky3nQPoeVzlDWhDkEgHa3tU7woYqCfbtvKHD+VNttQ0QFF9Lsk/qEXZEOMDp1vkHFYqv5dM60zAzciwFGky7wgFnPCDCCCGFnsJDtv1TeZRl6bTfS9S9kkwJ5J4KIoZ8R6hymwTfomWMuR/ZUfzjxO6V3jQMlQr3dt4K2b1QGaWmkW8yLpryYcAzPNmtBt2owNJOHH9SXD0Vx/jUwh3hGFZVDda0q9P2161jKZJyAKRK94baG/SJvJlpxMTvKhzyAi/3QwVP72k9PNKBSQ0oubwOfUDmUWbGpgwzoYyIpWVRyCl7DhkVXgWkUnz5tQr6c4G1vtUVg79RoYGwn9KNZFIt5ZsToj121Szf5WP5fRhyoQSToKaGHVRPyZuOCnuZa9EmQ6LBaDgXCGAIfVKNTfNDb+wLlguiSDNRXxFD5JsDN9kYY7oT2yu8oYavoZUCU9nIGLkHHV5ljFqz61aWosuTrzDDHosCNzh24n1QYZSWzlzAKssCKTFHN9NlT7jinaJtbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(83380400001)(2906002)(38070700005)(2616005)(122000001)(38100700002)(85182001)(36756003)(5660300002)(86362001)(966005)(66556008)(41300700001)(76116006)(66946007)(316002)(66446008)(64756008)(6486002)(66476007)(4326008)(8936002)(8676002)(71200400001)(478600001)(6512007)(6506007)(186003)(7416002)(26005)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEoxRERuVDFqblFERit1dWMrLy8xZGZ4ZkVBZng4SVhiTStUbWM4dmtiRnpq?=
 =?utf-8?B?TUdkb3BtcGtnaWhRM3RMc2R6aXZTOTdjVXh2YWI4dzh3dkkxRmVENDN6VWw3?=
 =?utf-8?B?bWZqRzdoT0ZxUnNPa1VxWFRKbGk2NTRrZ2dqNW8vYkQvOEs3bUEzaFZ1S2Nk?=
 =?utf-8?B?UWhMS3QxUGxMSGgxbktDL3FMdGV3TDc5bk9oeEtlYkhxaTN3YmdOTEpPVmdW?=
 =?utf-8?B?ZWdCemU3SEdZV3V2cGgyMTNyQ3RSK3BaK1lYZmVudUJLbUZkT3psSmVkTk5C?=
 =?utf-8?B?ZkVuTHZEcGo1c2RyaXRGSG0zQ2pSbjhvaCtEcnE0VHNoM2RieU9vOVdqS3h5?=
 =?utf-8?B?cUVBVnFWclA1c2YwcS9EbVBLRmpXTnFhbGhDa0IyTHZVelc2RnFtTFFZeWJj?=
 =?utf-8?B?S2YvVWg1eVhvR2todzFmTG9xRm51MEo2WTJtQjFHdEdhRmdFT2x3aHIzQWRi?=
 =?utf-8?B?SjA2bnJVUEdFdjJBZk9zTGpKVXJtTFA3NXBNK25hWEpFbGNRdlEzcUgyM0Zm?=
 =?utf-8?B?VXFyQmpYMk54VS9DSWZjRmRoRXVybVc1ZE1VMWU1VUJyNWE5a091R0tEeVVs?=
 =?utf-8?B?bGZtRU41a0MrY1pMWWRBZWR1blNDM05QY2tQQnFoWitoSlFZdC9LWXNQWVBK?=
 =?utf-8?B?cHBMV09mNU1wTzFEbmtGNlo1ckQ2ZFFXVFc3RkFjMHNGSnFIZjRUb3dKMW9w?=
 =?utf-8?B?QjNZcmQzeVJ3ak5sZXpuOSt2M2JHTnJ3WHRiVzRzNDVoSm5vdUZpZWd6RjZS?=
 =?utf-8?B?L3ozaXY3RGlWRW9PZWRQTm40YXZyb1dXeHFqV0RDT01zVmcrdFl0RXhHNEh6?=
 =?utf-8?B?eHBqOU5NeHpnenRGbFdUUGxpa2hDdVBvN0UvbUlZS2ZUQ0lqcUswSCtRK3FB?=
 =?utf-8?B?eWFYb3pDRlp2WjF1c2NMcUNLQy9STHlFQ1Evcmtja1JLK3JadU02Nks4NlhX?=
 =?utf-8?B?QjhLTWJBQXNrR3pTMmdLUDRhOWtGMzVWeU9IUjZtTzFRNDVGVWJTaHhtTVdx?=
 =?utf-8?B?S29QQjIrNVhZZkNOaTVJZm5sWkFTcTBZOHA3WjlTaW1seFpjbmlqZW00UDk1?=
 =?utf-8?B?TWpmcUdJaUhKeFBiblBrcncxNE03dDRENm8vRzIvVUpYQ0lWWmtlaDJvUk1C?=
 =?utf-8?B?bW9YbjNLMkR1b0NndklvcWc5Y1hvVWh5TWNpRVg4eWcxMzdjR3hrWkhoQ01U?=
 =?utf-8?B?dFdNbjl6QktxS3NFbXI2SGEwbUorUG91eTN3Nkk5YThjQ1Y0S0YwL1VCbXlR?=
 =?utf-8?B?MVBqa09PZFBabmJydzRKUmpsdjNMRHY1RDRJaGVmbjFrYzFHV012dmRQaTlu?=
 =?utf-8?B?OHpwTGtpYVQ0ZGhMQjAyYVo5RjNvZ3NqdnNrLzhOcUxRMk0vUVhxTGdYa3hU?=
 =?utf-8?B?UVJDekNyQ1BESVp6dEVkbUFIcHhQbDgrcXVsSWJVMzZiTFlsOXRqMGlKdHZl?=
 =?utf-8?B?cDhZcjNGMzlDRzBNNVNEZHNUNUxTWk4zQzlZeVQ5cklXa1ppcDFsaUlNYm45?=
 =?utf-8?B?eEl5dzRFL3l3R2JGTjZCeHhCb1ZEWUZiVzkzMjYvQU1UNjd5VE56ai8zdGtj?=
 =?utf-8?B?NURjT0d0N2NLY1F0V1NXcFZvYVVXVmp2SjNlR1hDYVhWbmdjWFpRTm9JQm5H?=
 =?utf-8?B?QVVaZjJUVkorWlVuc0Y3TlZFbnZ0TjNIWWpSSk12RDViUXNJUm1SNDByMG51?=
 =?utf-8?B?ek5xM3ZxUy9tZGR6QWhZOHp0d0M5QkhHbW1iVGZKMnp6bThSMHJ6enowWW81?=
 =?utf-8?B?Tm9sRHZxWWNMczdleVY4Umt0emU1ME42bTdKVjBreGcxcFRBMDJNMXpGZi9a?=
 =?utf-8?B?MjJ5YTAwV0JycjVzRzBnV1VYblRGcnZxNi9uWW9CRFNXSWJBdXN1bnZUQ2dN?=
 =?utf-8?B?c3JaMXlMWjhMTnFTTXl4YnNnNWZXTjZ4MkxoYzBwZ1VVTHJodXQrcS95eFBr?=
 =?utf-8?B?SWwyU2lyRmNrMnAvcmxrOTYrVkZoY2Jjenh4cXB6RFhMMHhYMHRvd1FjbUpS?=
 =?utf-8?B?cUZ2YVpVUjJxaDZaV0dNenVSL09IWS9hQnVHdlZISjViUnQ5aTk5WjdzazFk?=
 =?utf-8?B?YkI1a3RCeVp6SEpzT2xPRUxiQThsNTE0aXVXc0JsSjVnTmhuYlBpODlkUW43?=
 =?utf-8?B?VmxNa2RZNFREZjRoeTdVWERMTGF3QjRIcmNLbFFMYTNla1lDcjlxVzMrTUFH?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DBDD24A0AAF3342AA660E2F19272B5A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4ed0bf-9dd4-4559-5b85-08db6d64850d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 05:51:09.9197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTqePFjBmqF1aZh+Kar17WUEefwmEhOXjP7ntHrf6NuvkSuXwsfuT93yxWpfy8p0KrFWhS1EKwfCE2MofkGbwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KIA0KWWVzLCBNVDgxODggRVRIRFIgaXMgZnVsbHkgY29tcGF0aWJsZSB3aXRo
IE1UODE5NSwgc28gd2UgZGlkbid0IGFkZCBpdHMNCmNvbXBhdGlibGUgbmFtZSB0byB0aGUgZHJp
dmVyIGJ1dCBqdXN0IGxpc3RlZCBpdCBpbiBkdC1iaW5kaW5ncy4NCiANCk1heSBJIGRvdWJsZSBj
aGVjayB3aXRoIHlvdSB0aGF0DQpJIHNlZSB0aGVyZSBpcyBhIHNob3J0IGRlc2NyaXB0aW9uIHJl
Z2FyZGluZyAiaXRlbXMiIG9iamVjdDoNCj4gIyBpdGVtcyBpcyBhIGxpc3Qgb2YgcG9zc2libGUg
dmFsdWVzIGZvciB0aGUgcHJvcGVydHkuIFRoZSBudW1iZXIgb2YNCj4gIyB2YWx1ZXMgaXMgZGV0
ZXJtaW5lZCBieSB0aGUgbnVtYmVyIG9mIGVsZW1lbnRzIGluIHRoZSBsaXN0Lg0KPiAjIE9yZGVy
IGluIGxpc3RzIGlzIHNpZ25pZmljYW50LCBvcmRlciBpbiBkaWN0cyBpcyBub3QNCmluIGh0dHBz
Oi8vZG9jcy5rZXJuZWwub3JnL2RldmljZXRyZWUvYmluZGluZ3Mvd3JpdGluZy1zY2hlbWEuaHRt
bA0KIA0KU28gZG9lcyB0aGUgY29tcGF0aWJsZSBoYXMgdG8gYmU6DQoibWVkaWF0ZWssbXQ4MTg4
LWRpc3AtZXRoZHIiLCAibWVkaWF0ZWssbXQ4MTk1LWRpc3AtDQpldGhkciIgcmF0aGVyIHRoYW4g
aW4gcmV2ZXJzZWQgb3JkZXI/DQogDQpIb3dldmVyLCBJIGNvdWxkbid0IGZpbmQgYW55IGRlc2Ny
aXB0aW9uIG1lbnRpb25zIHRoZSBvcmRlciBpbg0KRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3dyaXRpbmctc2NoZW1hLnJzdA0KTm90IHN1cmUgaWYgdGhlIG9yZGVyIGluICJpdGVt
cyIgb2JqZWN0IGRvZXMgbm90IG1hdHRlciBhZnRlciB0aGVuLg0KIA0KVGhhbmtzLA0KSHNpYW8g
Q2hpZW4gU3VuZw0KDQoNCk9uIFdlZCwgMjAyMy0wNi0xNCBhdCAxMzo0MSArMDIwMCwgQW5nZWxv
R2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBs
ZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3Ug
aGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgSWwgMTQvMDYvMjMg
MDk6MzEsIEhzaWFvIENoaWVuIFN1bmcgaGEgc2NyaXR0bzoNCj4gPiBBZGQgY29tcGF0aWJsZSBu
YW1lIGZvciBNZWRpYVRlayBNVDgxODggRVRIRFIuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
SHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
ICAuLi4vYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxldGhkci55YW1sICAgICAg
ICAgICB8IDYNCj4gKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGV0aGRyLnkNCj4g
YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWssZXRoZHIueQ0KPiBhbWwNCj4gPiBpbmRleCA4MDFmYTY2YWU2MTUuLjY3Nzg4
MjM0OGVkZSAxMDA2NDQNCj4gPiAtLS0NCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxldGhkci55DQo+IGFtbA0KPiA+ICsrKw0K
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21l
ZGlhdGVrLGV0aGRyLnkNCj4gYW1sDQo+ID4gQEAgLTIzLDcgKzIzLDExIEBAIGRlc2NyaXB0aW9u
Og0KPiA+IA0KPiA+ICAgcHJvcGVydGllczoNCj4gPiAgICAgY29tcGF0aWJsZToNCj4gPiAtICAg
IGNvbnN0OiBtZWRpYXRlayxtdDgxOTUtZGlzcC1ldGhkcg0KPiA+ICsgICAgb25lT2Y6DQo+ID4g
KyAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10ODE5NS1kaXNwLWV0aGRyDQo+ID4gKyAgICAgIC0g
aXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxODgtZGlzcC1ldGhk
cg0KPiA+ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTk1LWRpc3AtZXRoZHINCj4g
PiANCj4gDQo+IElzIE1UODE4OCdzIEVUSERSIGZ1bGx5IGNvbXBhdGlibGUgd2l0aCBNVDgxOTUn
cyBFVEhEUj8NCj4gDQo+IElmIGl0IGlzLCB5b3UncmUgbm90IGFkZGluZyBhIG10ODE4OCBzcGVj
aWZpYyBjb21wYXRpYmxlIHN0cmluZyBpbg0KPiB0aGUgZHJpdmVyIGFuZA0KPiB0aGlzIG1lYW5z
IHRoYXQgdGhlIGRldmljZXRyZWUgd2lsbCBsb29rIGxpa2U6DQo+IA0KPiBjb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE5NS1kaXNwLWV0aGRyIiwgIm1lZGlhdGVrLG10ODE4OC1kaXNwLQ0KPiBl
dGhkciINCj4gDQo+IC4uLnNvIHRoZSBwcm9wb3NlZCBkb2MgY2hhbmdlIHdvcmtzLg0KPiANCj4g
UmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNj
aGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiANCj4gPiAgICAgcmVnOg0KPiA+ICAgICAg
IG1heEl0ZW1zOiA3DQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPiANCj4gDQo+IA0K
