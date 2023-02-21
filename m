Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E341969DA31
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 05:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjBUEqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 23:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjBUEq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 23:46:29 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E5E241C0;
        Mon, 20 Feb 2023 20:46:24 -0800 (PST)
X-UUID: ae949e58b1a211eda06fc9ecc4dadd91-20230221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DRRFEiStQCPGei+XMpeH/bUGDvC8jfi7Uokj7abukas=;
        b=oP4WiO1Z33SLPKvTukxiHFB0jGOpq65VRE+VwwGARyohF+P4n4sNw+ZHc174/XAq5PTxtyuVC0UQO1YDCWSkMatj3jjPvOIJftceMi5nSJprpLQPLk595jMIjw3jPi36xmMpAT/Q7e/dvW8yGFYZyAtrntzV53RVAb0r36xT2q4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:d19dfa5a-ea3f-4547-a6ea-3b8b5fb1785e,IP:0,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:885ddb2,CLOUDID:d7b13126-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,UR
        L:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: ae949e58b1a211eda06fc9ecc4dadd91-20230221
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 567679165; Tue, 21 Feb 2023 12:46:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 21 Feb 2023 12:46:17 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 21 Feb 2023 12:46:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyTKzBI3S06ftrX/kYqGs9RrHx8pk8ag+ej8vWU6VqhNuxwOLg1s7I2qdy0Ghw5PO2uXXlPFv2f0yn0nTa298FmqFatJZNQR23FiGSU/kzCLCki2yj5o1Gh5PvKgHNVg/8hvUctn2xwa7IN+HCxkPEpkQzp5cwH2Jx9cjjAEJDGsW5DSJNcuezx9qBR/AFULuWw5RKgpcb0Ui6QOL80UXV5es5eA5V8naHmXSDGaB5qDsuDy/HYuxLx/dxdmPvbSYGeg2LCrK0q38Qu127ZzrcR0ErZcqE/he66TWyBODs9oJRkewn2paeuSGbTR2/9vSbsLvpzfrVfBo877xSSYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRRFEiStQCPGei+XMpeH/bUGDvC8jfi7Uokj7abukas=;
 b=FWLYGZGp0KTHBf9FgSMfPgYdZgorpBKo2j5lgYeLMQ+GgH2/DuseWVTusCLpinre8NPvGENu4N/XrgTlCKsgfD8g6ZQBB+KNzb+aHsUSWjQ772hrZVeGMrRgIWSSV1a/2OnzC7TfTNQ+8xV6uTyfd9szqYzkrut9fna8bUBhy6Y/YB0jQ59Is3rt+Y4WDLPtUCxsGgiAEQyNHX5dxe1wbQr8MkZNpVrWqNTMsjCN6GVBpIiM632s5z9ZKr3LErhJII0c0g8tshHwwxMsgB5A+dKYudSSMHU/kZSwvtyvtsDH7UEJwHgDA8yK58Btrb/wDbGT35CFkWEhnIqlQ+mOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRRFEiStQCPGei+XMpeH/bUGDvC8jfi7Uokj7abukas=;
 b=tffbvSbkyKOVUpUgY7E8uStPwNBproLzvkemtA/lA38jk7zoSJtfNjz6QFRboJOOJ2XYxVpIRZlbJ35PetvysalfwkZzye9xx6l+nmv3soYtVWb6KQBneYq/61Ebefot3iSRYAIY1RAa0tKv8+hCER1rSrYtsFbWMWbNu8C75n4=
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com (2603:1096:400:120::13)
 by PSAPR03MB5240.apcprd03.prod.outlook.com (2603:1096:301:4d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 04:46:15 +0000
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::c85b:1180:16d0:a852]) by TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::c85b:1180:16d0:a852%3]) with mapi id 15.20.6111.020; Tue, 21 Feb 2023
 04:46:14 +0000
From:   =?gb2312?B?UG93ZW4gS2FvICi437KuzsQp?= <Powen.Kao@mediatek.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     =?gb2312?B?UGV0ZXIgV2FuZyAozfXQxdPRKQ==?= <peter.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?SmlhamllIEhhbyAousK8073aKQ==?= <jiajie.hao@mediatek.com>,
        =?gb2312?B?Q0MgQ2hvdSAo1tzWvr3cKQ==?= <cc.chou@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?gb2312?B?QWxpY2UgQ2hhbyAo2nermL75KQ==?= <Alice.Chao@mediatek.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        =?gb2312?B?Q2h1bi1IdW5nIFd1ICjO1/JFuuop?= 
        <Chun-hung.Wu@mediatek.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        =?gb2312?B?Q2hhb3RpYW4gSmluZyAovq6zr8zsKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?gb2312?B?U3RhbmxleSBDaHUgKNbs1K3qhSk=?= 
        <stanley.chu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?gb2312?B?TWFzb24gWmhhbmcgKNXCu9Qp?= <Mason.Zhang@mediatek.com>
Subject: Re: [PATCH 2/2] scsi: ufs: core: Export symbol ufshcd_mcq_read_cqis()
Thread-Topic: [PATCH 2/2] scsi: ufs: core: Export symbol
 ufshcd_mcq_read_cqis()
Thread-Index: AQHZQTppLj5oukRBNUuSA3MR1mJX2K7QSjKAgAiSMQA=
Date:   Tue, 21 Feb 2023 04:46:14 +0000
Message-ID: <d35218bd0ebd7a08c21401b879fc3541cd155ba8.camel@mediatek.com>
References: <20230215123750.15785-1-powen.kao@mediatek.com>
         <20230215123750.15785-2-powen.kao@mediatek.com>
         <Y+0b9d+InjhKi7+H@infradead.org>
In-Reply-To: <Y+0b9d+InjhKi7+H@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5825:EE_|PSAPR03MB5240:EE_
x-ms-office365-filtering-correlation-id: f52610a5-1b7f-4d34-a2ab-08db13c6900f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QvKqaWsjEPM39eMU+bJfqZJn1WrSFS+nN4cc68IlvwywJoM3B2qADgGPPouwCmLMkJp/oZ5LgmfFrbr/Md6y4EUkC9iu35Bli9VmGycWRjx5+8WGifO76tlpf4aNh5mVm1t0opynUUBUyK5JkSWGANO0goPwCg7jg1vI3G2AapWrSsF0EdfyaB4cTEBPre6wkUsgOScd8oVMJftdszd70b/+p+K2gp6/pKhG3jQ9bAouATIN1dxGILAqG1p95vy/L4wVKHPE21XtYiwzSvc2FXlfTB0b/Ylxh3dcyCYXSPHWqUwdpZC4O2UvrF/Mq/AICxBrDiWhG3clUhUo2wm3K0XM3GaVpZ5r7w5cPCS/IyzwuNhuW+ZWfTbgbhqrHGTeBed6lHE9azRZcYb7qm/eFaIvaH2qIiUWhFb+A50gIVp0cd0ncAlmr9RNHo2RMl6OhpcedhaDZCAyZMnzcQUjDUYEkJLK38EyiuNIJrWoagonVvzYhUC/wXYWPvQ8XlytT4nzpd2/wNLErTvqUowUjQajHfARKwjXEqn/fWIz07YncN5YCqX++hhJc8PhxZP82msrjxTKx4FzmyyFDaU7LgcbKIVCDVDao/kTWGBdPoyHizpBksjXFNApgrTaPezjl55HGREOuJJJtGiyIDYkC2qCf+m4L4qS4ZlCv3M55bWi2c5z1VZ+xVxvjZORodWr/ntB3jRe3vzydXzcZqtR3jrI0s1bHwyCmNJYq4edrrs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5825.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199018)(5660300002)(8936002)(122000001)(86362001)(38070700005)(6486002)(38100700002)(558084003)(316002)(85182001)(66946007)(54906003)(41300700001)(6916009)(66446008)(8676002)(4326008)(76116006)(66556008)(478600001)(64756008)(2616005)(4270600006)(6506007)(6512007)(107886003)(36756003)(71200400001)(66476007)(26005)(186003)(2906002)(19618925003)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SmYzM0VQVy93YW5QMXdzbXh3OWc0cTN1ZWdxSmVNTVU3QmdMeXE1dGlvTldB?=
 =?gb2312?B?NEJmZFFMUzA2QnB2R0EzRUtLQzd3YWtyTTZyazEwK29UVnBQYmlDdzFNVUFV?=
 =?gb2312?B?VDNULzN3YUpqMEhPKzJPNEtGMVJub21XaitmQVp0d0NDTDBoYUFvcm1rWU9o?=
 =?gb2312?B?VXd2MlNhUzcyUmtmdnV0VWVlTlRjek5PZkVOdG96SU0wY0FZaUl0TlpDSWZq?=
 =?gb2312?B?QmVTTlI2YlZPcHdPOXV1SjBhZ2Q4N1B1ZTBkNUs0b2FmSmJyVzZUM1ZCcjhS?=
 =?gb2312?B?RGk3UFdKSk42czZFTVVlOWlkNWk3Sk5ndjRIYjNVR3F2TUx2RW1ZeVI1ekFj?=
 =?gb2312?B?OEVaSi9xNWppdFhOeTJ0NGEwTVk2U1g2M28rYmQ4SnMxWkRKV2lUbmlQaTZH?=
 =?gb2312?B?QTJnZjVyYVNMZ2JvQ2E5SDNaRHNSYjgxa3JneVRiWlhZbUdBK1NaTldwVjNH?=
 =?gb2312?B?dHBuWXFUeFNRN0l0MXd6cndZcThqTFRFVWYxYVV4dnd6aFZPSzYvemcrQ09G?=
 =?gb2312?B?cExyOVFBaFVjS3dJaTViSkJYM3pIQTgySkRMYWNNcVFqMWhQR0NQQ0RocWhF?=
 =?gb2312?B?SDZETVE0STdnVkwycVFXK2ZHV0RGWldIREVsdjNkVm01NFdHTDZ1VVVDSlFs?=
 =?gb2312?B?TGJ4SGJJZVIwVy9wM0dieCtQWkQvWGg3Ui9JNHVOQ0twS05SOGF4a29RcUVK?=
 =?gb2312?B?MmlJZVhkMVBOKzV6VlVRMVoraTJmM2lzNFlCYXNYYklmVjhTVjc4a3IzUFRi?=
 =?gb2312?B?M1NQUFdzY3kwellzTFcyWkNoQlJPcXZTeG1Ua3ZyeDQ4MkNjdWYvZXBXM3kw?=
 =?gb2312?B?NTdYUWU3bjNaUkxsVkc4NFhLdG5Yd2RQclRKRmszQmI1cFhzRFlZMlk4RFhQ?=
 =?gb2312?B?RnBkRnJoSXJDdlNWS2VJb3NVSENkbTJYallNdEdPMk1WeSsxQzM4VDcrRFVK?=
 =?gb2312?B?ZlZJQTk3bTIvYkhFcmhrd01ML21qQlhGdlNhTnNYQjg3cFhPaDNiWU4rNlRN?=
 =?gb2312?B?UjJCM0JwdFBrdEJrUFRHbzVSNnIxdjRjanB3bXEwelBtdFZVYVZNRVdCbndw?=
 =?gb2312?B?cnlIeEpmWG0zWlRlSmREaVdkamZUaEZWeEFwNTludlNqTElVV1FwREkwU2xU?=
 =?gb2312?B?Sk9rRThkaEYrOWR6SHE1bDlvVUE5ZWhEWFRsdUV6YlNEaWNUQ2NyMzhvMHZw?=
 =?gb2312?B?R1ZLVUhTcFFYSkQ0ckRJNXR0ano0VEYycW1GQktEY0ZreVpNYTJpSkVEYytO?=
 =?gb2312?B?OGM4WEhHVmdsMDN6b0l3NmpYdjdoejVKVVRVaHVUbkxDVndKTVVxQlR5MTVY?=
 =?gb2312?B?ZEw1MEpSYmJMbHpEZUJ3YVBreVVQN1ZIdHFxa2VUMWtOOHZYM1FMdmFkMEUw?=
 =?gb2312?B?V24ySkNBMHJPdk1MY0ZlUGIwVVJKS0hYVFg3amhYaWVrVHd4ZUVwU01Cd05n?=
 =?gb2312?B?eHBnK0prN08xTUNabGhWZmF0TVUzTnczbGJZdnF3L1R2Snk1dWtCdUxna0lu?=
 =?gb2312?B?aCs4SW1wRFRGR3VYNzlJUmN5RHh3b1d5ZVZCN0hvTkRMb3h0QUlaZWJ3RnUw?=
 =?gb2312?B?bVk5QWdnMDRNeGoxeVdDZWRuektwMTVhR0JIZ3doZHg5S1NpK05mVzUwaFY3?=
 =?gb2312?B?bVVKV3dyTjlpbStxdXg0UmNBaUYrOXE5UU1jTUpmZXhjMzFGZGF1QU5HTDlo?=
 =?gb2312?B?MWJ1VjNSSU9wYXdRdVVXWHdJZVVhNmQ1dVoyVjNOUVZ5dWttUzdmaERERzJL?=
 =?gb2312?B?R3B6dHhFVis4RS9QRGE5NWpndU85cE9nRWhJamp3OUdiYVN4a1k1dFBDK0hQ?=
 =?gb2312?B?eXltUXZOUXp2TnZXWGV6Mm1yWWtDUkQ5ckYvOHdOeDNuTkVPNC9Wc25UY2xw?=
 =?gb2312?B?Zm5Zb2c0TUFpMXVzRnh6TTBrY0s2Z2JkTGgxTWxFbkNreldEdnMzN0lqRDdy?=
 =?gb2312?B?ZExRWEExZkN0dWs5TmZZUU5YQlU4SlRZK3E4c25NeHh4QTREbkQyVDZrUFlm?=
 =?gb2312?B?dVAyOHRxdWEwNmxxQUVaeVQ3Z1pYdlNxc1U5VDFWWmM0TGQ1aXJVRitxb3My?=
 =?gb2312?B?Sm84T21YZ0VHUDgrc3Arb2RtWDB6N3ZaODF3bGR0N3JMaEtKb2pPM3dwNGEw?=
 =?gb2312?B?U01tWS9Dd29ldHB0WVNuM1BhVjZLU01CQVlrN3dOTXpnY0NSbUQyNU43Mks4?=
 =?gb2312?B?MlE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5825.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52610a5-1b7f-4d34-a2ab-08db13c6900f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 04:46:14.4140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AnU2jg0otZPC+7MtYBJRMiaCsJDQcSlwO3ManHwh/3/eY83xiXlEMrU/EHE4yI6HA6KxR0J+UkZ63N7MDKtTpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5240
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlbiBJIHdpbGwgdXBzdHJlYW0gdG9nZXRoZXIgd2l0aCBvdXIgZHJpdmVyIGNoYW5nZSBsYXRl
ci4NCg==
