Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B98D67A35A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjAXTrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbjAXTrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:47:21 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0D71CF59
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:47:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so14950899wrz.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNr1LUPBn6inNA8VZVETp+QL4Mct4+taZ8R3vQRhgHU=;
        b=Ku1KJyIH5iA0zb+ZLxSfwOMuGPi4LHYcc4LsFXU+tcttNuaRKEnrSgJq/ZgRsV8PU3
         fwDgRTiFBzga3hHanZDh+Iimdby5yQYstdZIF9XE7mqmY83a4yeT7wo40VoHndy99CJZ
         IjF2DdTHK+euJnh6+eXBawh++3suwxM7hI9qLRn4lXS0RePH6vjxa3dL4dx4G1j+V4om
         o/h3WaOVmPXy3hJYLRn41wl91kAeCKq8yzz1TKcdExud9V6JyMkEhclFjJo4gpB4jqot
         TYi2Jf/vskdmZi/EgjKpg9DXEBHGMWX+EGLwT0337BtkZcP4DN6ixBn9xoajHad+l/2B
         F6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nNr1LUPBn6inNA8VZVETp+QL4Mct4+taZ8R3vQRhgHU=;
        b=BmzowRgVuzCznCYMxIG3HRS3ktQNrmoqIafjxzT2wm4NT0zPHxmAIIfAT0draFwsYd
         WCg/bajUrRMdZ/Jk6aeKdShc6l9/TMlvtliwajGRZ/bSk/hNAqJGY/Qr3eT4oVxKHtLY
         bxms6cat2c3+lNlvVgR9QEsNRx3BkufeaWuF6S2F2pR+zWP655El4lGwYaC4Y1hWHUyf
         8v53CUvkCE9gf+8T2B5nuHuGStvL88RmTrYUWcRAfWfOc6uZd8wt0J8VJnezbYARsyhY
         kUaAnauvK5mQ6JkP4fOi0bg5+tDQVKfDQxsi342c8eTP/vU/b6xKhW8e5IOLECfRh91u
         q/tQ==
X-Gm-Message-State: AFqh2kpc6JhgfZ1kaawGQnLczoxwxi1YWRrrRONLRzbVwd7Vi69PNUkN
        Vd05eehdTNT2l4Czr2PjE6wrlg==
X-Google-Smtp-Source: AMrXdXsdV1/c0K60ElxHx9ZlIhlW/1kAwg7hXgxSo71OqXQP9dAljVq/0xZ+x8ceYca8lju7MBsLGA==
X-Received: by 2002:a5d:6b05:0:b0:2bd:cf99:e6ab with SMTP id v5-20020a5d6b05000000b002bdcf99e6abmr23775790wrw.65.1674589638559;
        Tue, 24 Jan 2023 11:47:18 -0800 (PST)
Received: from [192.168.187.211] ([86.12.200.143])
        by smtp.gmail.com with ESMTPSA id f5-20020adffcc5000000b002bfae3f6802sm2459515wrs.58.2023.01.24.11.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 11:47:18 -0800 (PST)
Message-ID: <2ad50d65-9ce2-de4c-b14f-98c086b2d8c0@raspberrypi.com>
Date:   Tue, 24 Jan 2023 19:47:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v6 0/6] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>
References: <20230120201104.606876-1-umang.jain@ideasonboard.com>
 <786df750-221e-82fc-a324-d30261296974@i2se.com>
 <62644cd8-c871-aee0-30b7-2fbab097504c@ideasonboard.com>
 <Y85MOdAVh/fv5HRt@pendragon.ideasonboard.com>
 <39f438f8-c41b-17e6-42ba-9d87098a1eee@i2se.com>
From:   Phil Elwell <phil@raspberrypi.com>
In-Reply-To: <39f438f8-c41b-17e6-42ba-9d87098a1eee@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQvMDEvMjAyMyA4OjQxLCBTdGVmYW4gV2FocmVuIHdyb3RlOg0KPiBIaSBQaGlsLA0K
PiANCj4gQW0gMjMuMDEuMjMgdW0gMDk6NTggc2NocmllYiBMYXVyZW50IFBpbmNoYXJ0Og0K
Pj4gT24gTW9uLCBKYW4gMjMsIDIwMjMgYXQgMDE6MTg6MzBQTSArMDUzMCwgVW1hbmcgSmFp
biB3cm90ZToNCj4+PiBIaSBTdGVmYW4sDQo+Pj4NCj4+PiBUaGFuayBmb3IgdGhlIHRlc3Rp
bmcuDQo+Pj4NCj4+PiBPbiAxLzIzLzIzIDU6MDQgQU0sIFN0ZWZhbiBXYWhyZW4gd3JvdGU6
DQo+Pj4+IEhpIFVtYW5nLA0KPj4+Pg0KPj4+PiBBbSAyMC4wMS4yMyB1bSAyMToxMCBzY2hy
aWViIFVtYW5nIEphaW46DQo+Pj4+PiBUaGlzIHNlcmllcyBqdXN0IGludHJvZHVjZXMgZml2
ZSBleHRyYSBwYXRjaGVzIGZvciBkcm9wcGluZyBpbmNsdWRlDQo+Pj4+PiBkaXJlY3RpdmVz
IGZyb20gTWFrZWZpbGVzIChzdWdnZXN0ZWQgYnkgR3JlZyBLSCkgYW5kIHJlYmFzZWQuDQo+
Pj4+Pg0KPj4+Pj4gVGhlIG1haW4gcGF0Y2ggKDYvNikgcmVtb3ZlcyBwbGF0Zm9ybSBkZXZp
Y2UvZHJpdmVyIGFidXNlIGFuZCBtb3Zlcw0KPj4+Pj4gdGhpbmdzIHRvIHN0YW5kYXJkIGRl
dmljZS9kcml2ZXIgbW9kZWwgdXNpbmcgYSBjdXN0b21fYnVzLiBTcGVjaWZpYw0KPj4+Pj4g
ZGV0YWlscyBhcmUgZWxhYm9yYXRlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+Pj4+Pg0K
Pj4+Pj4gVGhlIHBhdGNoIHNlcmllcyBpcyBiYXNlZCBvbiB0b3Agb2YgZDUxNDM5MmYxN2Zk
ICh0YWc6IG5leHQtMjAyMzAxMjApDQo+Pj4+PiBvZiBsaW51eC1uZXh0Lg0KPj4+PiBhcHBs
aWVkIHRoaXMgc2VyaWVzIG9uIHRvcCBvZiBsaW51eC1uZXh0IGFuZCBidWlsZCBpdCB3aXRo
DQo+Pj4+IGFybS9tdWx0aV92N19kZWZjb25maWcgcGx1cyB0aGUgZm9sbG93aW5nOg0KPj4+
Pg0KPj4+PiBDT05GSUdfQkNNX1ZJREVPQ09SRT15DQo+Pj4+IENPTkZJR19CQ00yODM1X1ZD
SElRPW0NCj4+Pj4gQ09ORklHX1ZDSElRX0NERVY9eQ0KPj4+PiBDT05GSUdfU05EX0JDTTI4
MzU9bQ0KPj4+PiBDT05GSUdfVklERU9fQkNNMjgzNT1tDQo+Pj4+IENPTkZJR19CQ00yODM1
X1ZDSElRX01NQUw9bQ0KPj4+Pg0KPj4+PiBhbmQgdGhlIGRldmljZXMgZG9lc24ndCByZWdp
c3RlciBvbiBSYXNwYmVycnkgUGkgMyBCIFBsdXM6DQo+Pj4+DQo+Pj4+IFvCoMKgIDI1LjUy
MzMzN10gdmNoaXE6IG1vZHVsZSBpcyBmcm9tIHRoZSBzdGFnaW5nIGRpcmVjdG9yeSwgdGhl
IHF1YWxpdHkgaXMgdW5rbm93biwgeW91IGhhdmUgYmVlbiB3YXJuZWQuDQo+Pj4+IFvCoMKg
IDI1LjU0MTY0N10gYmNtMjgzNV92Y2hpcSAzZjAwYjg0MC5tYWlsYm94OiBGYWlsZWQgdG8g
cmVnaXN0ZXIgYmNtMjgzNV9hdWRpbyB2Y2hpcSBkZXZpY2UNCj4+Pj4gW8KgwqAgMjUuNTUz
NjkyXSBiY20yODM1X3ZjaGlxIDNmMDBiODQwLm1haWxib3g6IEZhaWxlZCB0byByZWdpc3Rl
ciBiY20yODM1LWNhbWVyYSB2Y2hpcSBkZXZpY2UNCj4+PiBJIHdhcyBhYmxlIHRvIHJlcHJv
ZHVjZSBhbmQgaXQgc2VlbXMgdGhlIGlzc3VlIGhlcmUgaXMgdGhlIGNoYW5nZQ0KPj4+IG1l
bnRpb25lZCBpbiB0aGUgY292ZXINCj4+Pg0KPj4+IC0gZHJvcCBkbWFfc2V0X21hc2tfYW5k
X2NvaGVyZW50DQo+Pj4NCj4+PiBpbiBWNi4NCj4+Pg0KPj4+IChJIHVzdWFsbHkgdGVzdCBw
YXRjaGVzIG9uIFJQaSA0QiB3aXRoIHZjc20tY21hIGFuZCBiY20yODM1LWlzcCBhcHBsaWVk
DQo+Pj4gc28gbXkgYnJhbmNoIGhhcyB0aGUgRE1BIGh1bmsgaW5jbHVkZWQgd2hpbGUgSSB3
YXMgdGVzdGluZyBWNikNCj4+Pg0KPj4+IEJlbG93IGlzIHRoZSBodW5rIHdoaWNoIHNob3Vs
ZCByZXNvbHZlIHRoZSBpc3N1ZS4NCj4+Pg0KPj4+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy92
YzA0X3NlcnZpY2VzL2ludGVyZmFjZS92Y2hpcV9hcm0vdmNoaXFfZGV2aWNlLmMNCj4+PiAr
KysgYi9kcml2ZXJzL3N0YWdpbmcvdmMwNF9zZXJ2aWNlcy9pbnRlcmZhY2UvdmNoaXFfYXJt
L3ZjaGlxX2RldmljZS5jDQo+Pj4gQEAgLTYsNiArNiw3IEBADQo+Pj4gwqAgwqAgKi8NCj4+
Pg0KPj4+IMKgIMKgI2luY2x1ZGUgPGxpbnV4L2RldmljZS9idXMuaD4NCj4+PiArI2luY2x1
ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+DQo+Pj4gwqAgwqAjaW5jbHVkZSA8bGludXgvc2xh
Yi5oPg0KPj4+IMKgIMKgI2luY2x1ZGUgPGxpbnV4L3N0cmluZy5oPg0KPj4+DQo+Pj4gQEAg
LTcyLDYgKzczLDEyIEBAIGludCB2Y2hpcV9kZXZpY2VfcmVnaXN0ZXIoc3RydWN0IGRldmlj
ZSAqcGFyZW50LA0KPj4+IGNvbnN0IGNoYXIgKm5hbWUpDQo+Pj4gwqAgwqDCoMKgwqDCoMKg
wqAgZGV2aWNlLT5kZXYudHlwZSA9ICZ2Y2hpcV9kZXZpY2VfdHlwZTsNCj4+PiDCoCDCoMKg
wqDCoMKgwqDCoCBkZXZpY2UtPmRldi5yZWxlYXNlID0gdmNoaXFfZGV2aWNlX3JlbGVhc2U7
DQo+Pj4NCj4+PiArwqDCoMKgwqDCoMKgIHJldCA9IGRtYV9zZXRfbWFza19hbmRfY29oZXJl
bnQoJmRldmljZS0+ZGV2LCBETUFfQklUX01BU0soMzIpKTsNCj4+PiArwqDCoMKgwqDCoMKg
IGlmIChyZXQgPCAwKSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmNo
aXFfZGV2aWNlX3JlbGVhc2UoJmRldmljZS0+ZGV2KTsNCj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPj4+ICvCoMKgwqDCoMKgwqAgfQ0KPj4+ICsN
Cj4+PiDCoCDCoMKgwqDCoMKgwqDCoCByZXQgPSBkZXZpY2VfcmVnaXN0ZXIoJmRldmljZS0+
ZGV2KTsNCj4+PiDCoCDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KSB7DQo+Pj4gwqAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHB1dF9kZXZpY2UoJmRldmljZS0+ZGV2KTsNCj4+
Pg0KPj4+IEl0IHNlZW1zIHdlIG5lZWQgdG8gaW5jbHVkZSB0aGUgZG1hX3NldF9tYXNrX2Fu
ZF9jb2hlcmVudCgpIGV2ZW4gaWYNCj4+PiBiY20yODM1LWF1ZGlvLCBiY20yODM1LWNhbWVy
YSBkZXZpY2UgZG9lc24ndCBkbyBETUE/IEkgbmVlZCB0byBsb29rIGludG8NCj4+PiB3aHkg
aXMgdGhhdC8NCj4gDQo+IERvIHlvdSBoYXZlIGFuIGFuc3dlciBmb3IgdGhpcz8NCg0KVGhh
dCdzIGJlY2F1c2UgdmNoaXEgZG9lcyB1c2UgRE1BIGZvciBidWxrIHRyYW5zZmVycywgaXQn
cyBqdXN0IHRoYXQgdGhlIERNQSBoYXJkd2FyZQ0KaXMgZHJpdmVuIGZyb20gdGhlIFZQVSBz
aWRlLiBBbmQgZXZlbiB0aG91Z2ggdGhlIFZQVSBjYW4gb25seSBhZGRyZXNzIDFHQiwgaXQg
dXNlcyB0aGUNCnVwcGVyIGFkZHJlc3MgYml0cyB0byBkZXRlcm1pbmUgY2FjaGVhYmlsaXR5
IG9mIGFjY2Vzc2VzLCBoZW5jZSB0aGUgbmVlZCBmb3IgMzItYml0DQpETUEgYWRkcmVzc2Vz
Lg0KDQpQaGlsDQoNCg==
