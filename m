Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDAF6FF29D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbjEKNXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbjEKNWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:22:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F8B100CF;
        Thu, 11 May 2023 06:21:12 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34BDJdYC024505;
        Thu, 11 May 2023 08:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683811179;
        bh=dvtDQ02cGc7qai0bvj3/3r2KD0eHYXuLvZlUe0kvyHw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=THmbf0tgqqkM1xRVXukDVWcjUNlgfBnIDLLWUUqKneCWk0iQH5uLlEnk0le7vnqc8
         huf9sNvgujgS2C05LOwQbdLsj2j2HWwdMj06LeUBrTc+IyyouXqpzG5lQHlvuoEGpG
         QduZP4fVaHXVELMIft612OzX0KxcoU+Qwo4JOLNQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34BDJd6q044702
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 May 2023 08:19:39 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 May 2023 08:19:39 -0500
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Thu, 11 May 2023 08:19:39 -0500
From:   "Ding, Shenghao" <shenghao-ding@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     Shenghao Ding <13916275206@139.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "gentuser@gmail.com" <gentuser@gmail.com>,
        "Ryan_Chu@wistron.com" <Ryan_Chu@wistron.com>,
        "Sam_Wu@wistron.com" <Sam_Wu@wistron.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 2/5] ASoC: dt-bindings: Add tas2781
 amplifier
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/5] ASoC: dt-bindings: Add tas2781
 amplifier
Thread-Index: AQHZgw2r46dnAmj+dEya5A38wB/fZK9U5kcAgAA/wgD//+cmsA==
Date:   Thu, 11 May 2023 13:19:39 +0000
Message-ID: <3c48d5e47aff478b8ce8998d7efe001b@ti.com>
References: <20230508054512.719-1-13916275206@139.com>
 <ca9d45cf-8a84-4fbc-e1dd-c96eef36fe25@linaro.org>
 <ZFyBzHWo3ORKAskX@finisterre.sirena.org.uk>
 <ca2ed8e9-850a-56c5-e395-72e5861b9c71@linaro.org>
In-Reply-To: <ca2ed8e9-850a-56c5-e395-72e5861b9c71@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.160.143]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMS8wNS8yMDIzIDA3OjQ5LCBNYXJrIEJyb3duIHdyb3RlOg0KPj4gTWlzc2luZyBtaW5J
dGVtcywgYnV0Li4uDQo+IA0KPj4+ICsgICAgaXRlbXM6DQo+Pj4gKyAgICAgIG1pbmltdW06IDB4
MzgNCj4+PiArICAgICAgbWF4aW11bTogMHgzZg0KPiANCj4+IC4uLiBTbyB0aGVzZSBhcmUgZml4
ZWQ/IE5vIG5lZWQgdG8gZW5jb2RlIHRoZW0gaW4gc3VjaCBjYXNlLi4uDQo+IA0KPiBJJ20gbm90
IHN1cmUgSSB1bmRlcnN0YW5kIHlvdXIgY29uY2VybiBoZXJlLCB0aGVyZSdzIHVwIHRvIDQgcG9z
c2libGUgDQo+IHZhbHVlcyBmcm9tIDB4MzgtMHgzZiB3aGljaCBoYXMgbW9yZSB0aGFuIDQgcG9z
c2libGUgdmFsdWVzLg0KDQpBcmVuJ3QgdGhlIGFkZHJlc3NlcyBnb2luZyB0byBiZSBpbmNyZW1l
bnRlZCBieSBvbmUgKHVwIHRvIDggb2YgZGV2aWNlcyBpbiB0b3RhbCk/DQoNCk5vLCB0aGUgaTJj
IGFkZHJlc3Mgb3JkZXIgaXMgbm90IGFsd2F5cyBtb25vdG9uaWMgaW5jcmVhc2Ugb3IgZGVjcmVh
c2UsIHNvbWV0aW1lIGl0IHdvdWxkIGJlIGRpc29yZGVyLCBhY2NvcmRpbmcgdG8gdGhlIGFwcGxp
Y2F0aW9uLg0KRWFjaCBkZXZpY2Ugd291bGQgaGF2ZSBlaWdodCBwb3NzaWJsZSBpMmMgYWRkcmVz
cywgdGhlIGZpbmFsIGFkZHJlc3MgZGVwZW5kcyBvbiB0aGUgaGFyZHdhcmUgY29ubmVjdGlvbnMu
DQoNCkJlc3QgcmVnYXJkcywNCktyenlzenRvZg0KDQo=
