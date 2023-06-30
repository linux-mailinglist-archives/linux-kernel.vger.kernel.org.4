Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE135744569
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjF3Xyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjF3Xyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:54:36 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888C03C01
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 16:54:34 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4FA405C0174;
        Fri, 30 Jun 2023 19:54:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 30 Jun 2023 19:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1688169271; x=1688255671; bh=AHmNQxLTObikLsLoMkkqz0zd4EdIDYpno+e
        i3/HGNhQ=; b=KVVhPg1O3wIGUi7WOG6U9EyeWNw9DKGNQgJDa6dJ3Lg09PvwRcs
        VSNb+c2TeTyNNX+I6Ql6PFV7rQtwHun1oR0PsNyctztiy4wG8Hc0ipYTlG66srlO
        LKURgP/+mxUoa7aiwf8zSbiUA0aPF7A8SbcLF0Q8HWFf2H9UtPWxge2PQ+sZaPyx
        GA4z5gd24NCrWiRxZqQ+qRpTFyq3qa1TWMoPEnePXEsv7G6f6bgE17/ElIPww5cr
        7F42Jap5KYcbyuVwy6lRq2ZZfU7sGc0lD3WL2jIXrb4HjlAzPDa0D2YuuoiXqCbe
        phvoaOw+ZvFtaJunDOiYgH4bzozV0vQgGUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688169271; x=1688255671; bh=AHmNQxLTObikLsLoMkkqz0zd4EdIDYpno+e
        i3/HGNhQ=; b=CegcoqFhf2tioYAhBNbyXXINn3oSlW0vYnLqriV97eRuQRgZNKl
        YN1kL5NFJmUjOawF7JvtT5wx8VqgAnhIPAyZ5Iu/ISbKOg7B4U/+vbmebqPbCHGw
        pftaMPsCObmCSp97/CIUV8WU6Kg21FrGYUowzS62Vj43yUgZy8TR0snuYbGEmPZG
        BElneYVgaee06hBMMYM7pzz9obrrAz+lWMn7GA++kCR67knMFeo2HzFBAZaGzH/o
        H6yilZ1gUf2W/g+HDGB2qRt4ZTQ3BNCRH0vUE5+IrP3ojfKUi8XFxdlXC/iWdsGI
        SVOH2LcULjxHFjgjcZqpwLNJWq374iZ7JVg==
X-ME-Sender: <xms:NmufZKKCn6mIqJ5bQ_59vakg8g7Jdo15iBUE8Hv5s3ibVKc_o0pPsQ>
    <xme:NmufZCJHlrn4qt68z05fj4LJAbzzKcm6PYVmtUFO8KnDtJ_nWzsMeFPFfNGHP4q91
    -saGdTQFgHfOvfVTLg>
X-ME-Received: <xmr:NmufZKstnQ-_1gwCcru0762T9sYcBFjqvcAFqMBCmPN2qUQdh9WhpqAWEHoFZgqW7eBTrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdejgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfevffgjfhgtgfgfggesthgsredttderjeenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epfffgfeeiudeutdeftdevudeflefhffdukedttdevtddvveegfeevleeutdetgfeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:NmufZPZ_e4V1BdTKTRyf-62xG3xBTRTi_6DkC5yPOpaRjLH3vr6n6A>
    <xmx:NmufZBZEmFHlgtyR1WSdO2BmwR9tDwuKaPD__VYqy8kfVJuxu-LjCg>
    <xmx:NmufZLBdL-StYn1KTb6rQOKykPGbuP9PMRLTkKBMltEu8mIuWwJqOQ>
    <xmx:N2ufZEzPAqxkRO-Vu1ZjtgEULLGwpEZTMkMvUk24MszWSaDNXzFyxw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 19:54:27 -0400 (EDT)
Message-ID: <edee8624d54d92fdf8de1ae98bb6f2c2c5c08506.camel@ljones.dev>
Subject: Re: [PATCH 1/2] ALSA: hda/realtek: Add quirk for ASUS ROG GX650P
From:   Luke Jones <luke@ljones.dev>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, perex@perex.cz, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, tangmeng@uniontech.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Sat, 01 Jul 2023 11:54:22 +1200
In-Reply-To: <87h6qpcq0i.wl-tiwai@suse.de>
References: <20230630043106.914724-1-luke@ljones.dev>
         <20230630043106.914724-2-luke@ljones.dev> <87h6qpcq0i.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.3 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTMwIGF0IDEwOjI5ICswMjAwLCBUYWthc2hpIEl3YWkgd3JvdGU6Cj4g
T24gRnJpLCAzMCBKdW4gMjAyMyAwNjozMTowNSArMDIwMCwKPiBMdWtlIEQuIEpvbmVzIHdyb3Rl
Ogo+ID4gCj4gPiAtLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwo+ID4gKysrIGIv
c291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKPiA+IEBAIC01ODgzLDcgKzU4ODMsNyBAQCBz
dGF0aWMgdm9pZAo+ID4gYWxjX2ZpeHVwX2hlYWRzZXRfbW9kZV9hbGMyNTVfbm9faHBfbWljKHN0
cnVjdCBoZGFfY29kZWMgKmNvZGVjLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgYWxjX3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgc3BlYy0+cGFyc2VfZmxhZ3MgfD0gSERBX1BJTkNGR19IRUFEU0VU
X01JQzsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWxjMjU1X3NldF9kZWZh
dWx0X2phY2tfdHlwZShjb2RlYyk7Cj4gPiAtwqDCoMKgwqDCoMKgwqB9IAo+ID4gK8KgwqDCoMKg
wqDCoMKgfQo+ID4gwqDCoMKgwqDCoMKgwqDCoGVsc2UKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgYWxjX2ZpeHVwX2hlYWRzZXRfbW9kZShjb2RlYywgZml4LCBhY3Rpb24pOwo+
ID4gwqB9Cj4gCj4gVGhpcyBjaGFuZ2UgbG9va3MgaXJyZWxldmFudC7CoCBDb3VsZCB5b3UgZHJv
cCBpdD8KPiBJZiBpdCBuZWVkcyB0byBiZSBmaXhlZCwgcHV0IGluIGFub3RoZXIgY2xlYW51cCBw
YXRjaC4KPiAKPiAKPiB0aGFua3MsCj4gCj4gVGFrYXNoaQoKTG9va3MgbGlrZSBpdCB3YXMgYSB3
aGl0ZXNwYWNlIHRoaW5nIHRoYXQgZ290IGNhdWdodCB3aGVuIHNhdmVkIGluIG15CmVkaXRvci4g
SSdsbCBkcm9wIGFuZCBzZW5kIGNsZWFudXAuCg==

