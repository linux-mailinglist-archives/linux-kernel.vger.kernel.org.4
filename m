Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D2E740FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjF1LOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:14:07 -0400
Received: from smtp-fw-80006.amazon.com ([99.78.197.217]:62630 "EHLO
        smtp-fw-80006.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjF1LOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1687950841; x=1719486841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=swPdx64xw/EH+kxvFodSbLyAXdrefblh5CxrQ3vbxpI=;
  b=Ul8UyyfxWLcIy92HDnNxga8qrxyUSfuh5HaYwzECCtaKBREJy6XH8F/o
   SQSki8LA0jbECQjlWgtJIf3AGpo3WXpy8tY+twfeUtgx0YiCpGNY3StB+
   7M+JC6PBpHi2wXHllgrBj9yS4qQ3685mDPfQheQNGjd+BzQwSV+4jLP31
   M=;
X-IronPort-AV: E=Sophos;i="6.01,165,1684800000"; 
   d="scan'208";a="223327740"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 11:13:57 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com (Postfix) with ESMTPS id EB92380657;
        Wed, 28 Jun 2023 11:13:55 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 11:13:45 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 28 Jun
 2023 11:13:43 +0000
Message-ID: <6ccec434-42f0-0ae8-8c7b-bea4646c5e7d@amazon.de>
Date:   Wed, 28 Jun 2023 13:13:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 0/1] User space notifications about VM cloning
Content-Language: en-US
To:     Babis Chalios <bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        <linux-kernel@vger.kernel.org>
CC:     <mzxreary@0pointer.de>, <xmarcalx@amazon.co.uk>,
        Amit Shah <amit@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20230531095119.11202-1-bchalios@amazon.es>
 <20f65557-766d-d954-f3ef-c26ad2b661dc@amazon.es>
From:   Alexander Graf <graf@amazon.de>
In-Reply-To: <20f65557-766d-d954-f3ef-c26ad2b661dc@amazon.es>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgZm9sa3MsCgpPbiAxNi4wNi4yMyAxNzowNywgQmFiaXMgQ2hhbGlvcyB3cm90ZToKPiBIZWxs
byBhbGwsCj4KPiBTb21lIHRpbWUgaGFzIHBhc3NlZCBzaW5jZSBJIHNlbnQgdGhpcy4gQW55IGNv
bW1lbnRzL3Rob3VnaHRzPwoKCkNhbiB3ZSBwbGVhc2UgZ2V0IHRoaXMgbWVyZ2VkIHNvbWVob3c/
IEdyZWcsIGFueSBhZHZpc2U/CgpUaGlzIGlzIHB1cmVseSBhIGRldmljZSBub3RpZmljYXRpb24g
ZXZlbnQgdG8gdXNlciBzcGFjZSwgc2ltaWxhciB0byAKbmV0d29yayBsaW5rIGNoYW5nZSBldmVu
dHMgYW5kIHRoZSBsaWtlcyBhbmQgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCAKSmFzb24ncyBlbnZp
c2lvbmVkIHJhbmRvbSByZXNlZWQgZXZlbnQgZXhwb3N1cmUuIFdlIGNhbiBoYXBwaWx5IHNlbmQg
UkZDIApwYXRjaGVzIGZvciB0aGUgbGF0dGVyIGFmdGVyIHRoaXMgaXMgbWVyZ2VkIHRvby4KCgpB
bGV4CgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3Ry
LiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2Vy
LCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVy
ZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkK
Cgo=

