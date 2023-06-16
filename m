Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD04733268
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbjFPNoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFPNoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:44:10 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA39189
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1686923049; x=1718459049;
  h=from:to:cc:subject:date:message-id:content-id:
   mime-version:content-transfer-encoding;
  bh=KdIdoo7uQlZPTCnStzw05pk0oLk6LJ2S9Hb5yTnotOg=;
  b=KRhT/aHL2oUImTNCQ9A0Q4XdUf3oE2a9HAkc3nz9qXatwd/pxBJlmleJ
   bf6Ld+ziw+FPM8OPiBqaahDANNnJ2NPZ32aCHKdhi0UB3kKNC9MuYFC3q
   6GeRFBvpLoOMFjMEndPaw+NXjMzSxujZXnQO1tK5zHF+vUIeiyUXn74/I
   s=;
X-IronPort-AV: E=Sophos;i="6.00,247,1681171200"; 
   d="scan'208";a="1137949321"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 13:44:03 +0000
Received: from EX19D010EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 436DE80680;
        Fri, 16 Jun 2023 13:44:03 +0000 (UTC)
Received: from EX19D041EUA001.ant.amazon.com (10.252.50.169) by
 EX19D010EUA001.ant.amazon.com (10.252.50.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 13:44:02 +0000
Received: from EX19D002EUC004.ant.amazon.com (10.252.51.230) by
 EX19D041EUA001.ant.amazon.com (10.252.50.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 13:44:01 +0000
Received: from EX19D002EUC004.ant.amazon.com ([fe80::fa57:3c1:c670:f520]) by
 EX19D002EUC004.ant.amazon.com ([fe80::fa57:3c1:c670:f520%3]) with mapi id
 15.02.1118.026; Fri, 16 Jun 2023 13:44:01 +0000
From:   "Manthey, Norbert" <nmanthey@amazon.de>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Stieger, Andreas" <astieger@amazon.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Linux kernel Coverity model file
Thread-Topic: Linux kernel Coverity model file
Thread-Index: AQHZoFibzqo0BF01BE6byHjjEo/FFQ==
Date:   Fri, 16 Jun 2023 13:44:01 +0000
Message-ID: <ccca1437bf0885924619271a3f3ddd17af018149.camel@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.212.5]
Content-Type: text/plain; charset="utf-8"
Content-ID: <75096B68E8F1C54C8AB2F1732497D759@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBLZWVzLA0KDQpzb21lIHRpbWUgYWdvIHlvdSBwb2ludGVkIG1lIGF0IHRoZSBnaXRodWIg
Y29weSBvZiB0aGUgQ292ZXJpdHkgbW9kZWwNCnRoYXQgaXMgdXNlZCBmb3IgdGhlIExpbnV4IGtl
cm5lbCBhbmFseXNpcyBbMV0uDQoNCkkgaW52ZXN0aWdhdGVkIHRoZSBlZmZlY3Qgb2YgdXNpbmcg
dGhpcyBtb2RlbCwgYW5kIGNvbXBhcmVkIGRlZmVjdHMNCnJlcG9ydGVkIHdpdGggYW5kIHdpdGhv
dXQgdGhlIG1vZGVsLiBCZWZvcmUgSSBkZWVwIGRpdmUgaW50bw0KbW9kaWZpY2F0aW9ucywgSSB3
YW50ZWQgdG8gdW5kZXJzdGFuZCB3aGV0aGVyIHRoZXJlIGlzIGEgbW9yZSByZWNlbnQNCnZlcnNp
b24gKHRoZSBjdXJyZW50IG9uZSBpcyBhYm91dCA0IHllYXJzIG9sZCkuIEkgY3VycmVudGx5IGhh
dmUgbm8NCmFjY2VzcyB0byB0aGUgcHVibGljIGxpbnV4IGRhc2hib2FyZCB0byBkaXJlY3RseSBj
aGVjayB0aGUgZWZmZWN0DQp0aGVyZS4NCg0KSW4gY2FzZSB0aGVyZSBpcyBhIG1vcmUgcmVjZW50
IG1vZGVsIGZpbGUsIGNhbiB5b3UgcGxlYXNlIHVwZGF0ZSB0aGUNCmdpdGh1YiByZXBvc2l0b3J5
Pw0KDQpJbiBjYXNlIEkgZmluZCBhZGRpdGlvbnMsIGlzIHRoZSBmb2xsb3dpbmcgYSBnb29kIHBy
b2NlZHVyZSB0byBzaGFyZQ0KbW9kZWwgdXBkYXRlcz8gSSB3b3VsZCBydW4gYW4gYW5hbHlzaXMg
b24gYSBkZWZpbmVkIExpbnV4IGNvbW1pdCB3aXRoDQp0aGUgY3VycmVudCBtb2RlbCBhbmQgdGhl
IHByb3Bvc2VkIGFkZGl0aW9ucywgYW5kIHdvdWxkIHJlcG9ydCB0aGUNCmVmZmVjdCBvbiB0aGUg
cmVwb3J0ZWQgZGVmZWN0cy4gSXMgdGhlcmUgYW55dGhpbmcgZWxzZSBJIGFtIG1pc3Npbmc/DQoN
CkJlc3QsDQpOb3JiZXJ0DQoNCg0KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9rZWVzL2NvdmVyaXR5
LWxpbnV4DQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vu
c3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFl
Z2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVu
YnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4
NzkKCgo=

