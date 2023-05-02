Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD556F4599
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjEBNzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbjEBNzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:55:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9412449B;
        Tue,  2 May 2023 06:55:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a66e7a52d3so28160995ad.0;
        Tue, 02 May 2023 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683035713; x=1685627713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OtDG78lsF+fPLCI3Bu6R8mmS7IAEKSK44SfSSK62yEQ=;
        b=sUeb8DpcI9qJ7BfUs5EDtDiAZ+/Lzvm8vsvnyc3tctb10tAIroUvfTC5crgm1odtGA
         EZXSc9WI4Knc1NKFfUMMlD1nXM0eYD8UVrzssL5b0cWeMZzInA4zMngztvsUxf87PByK
         Ph6OYT4ihvHFffqnh6VffwbGq4cuCEauiKO+7tZRjGAtwjGGlXgsF4EcwBD0dCmgXq4y
         hTsELhdyHOdaSywPjr2s2Ty1alGE2G0KLhlR/NEMPQDR5aozubVgj3LJxukPvnBZYOco
         VD0WQLTFjhU0muuthbOKKhZTRwUdW8qrvDNTyGLjQf1r5rJopu6CtxUvTvbTW+odPfFT
         gNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683035713; x=1685627713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OtDG78lsF+fPLCI3Bu6R8mmS7IAEKSK44SfSSK62yEQ=;
        b=lMeAqpEyxv/MiEZcbQOrt7Hq1F/zH47B5MN1Zuk0YCoPom5r5ReH8sCQc0lV5TorOq
         Ch+q0Lisi+h0aDIx4HQQsHbz3pE6aArwIe8WTK+YTOJ78MJzDPfjZUmEuE9qgv5YUkqQ
         TE0kzva5axWkwf9qu/p/FBWhqAdo2PdhsVfp/Ja/byTKklbV69LnSnlQadWPxs9vFxj+
         h9EoA/Pc/3a4UM8ncvKdiCjvcxEf+U/2O7iZwaCkX+vUWMxmqT++KwEj5ZWJ4FTlzhhl
         kgxa5QI6CTPQldZ0P+R4VGwhtTOXLF2KnwZtbK08hCBcRENOKHHqWBq7F3JSKT6ypBy0
         Ywlg==
X-Gm-Message-State: AC+VfDyEnMsuH29iCQVX2gB8SA2sprmYXsD+61r5OIAwosJVp2uU/8ON
        cjXa9BwePOun0wc5UyhTIyjwuLCJcyY=
X-Google-Smtp-Source: ACHHUZ7DeInHVfAfYZ22GsC4kcFN6f/dkzYAtsUYOB4o+CgyTpUfedoFFZbn35SDfP5T0CYCPn26JQ==
X-Received: by 2002:a17:903:4d:b0:1aa:dba2:d155 with SMTP id l13-20020a170903004d00b001aadba2d155mr9903572pla.48.1683035713298;
        Tue, 02 May 2023 06:55:13 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902a51100b001a967558656sm15959491plq.42.2023.05.02.06.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 06:55:09 -0700 (PDT)
Message-ID: <64790637-279a-a1ca-292b-f9f1fac69f14@gmail.com>
Date:   Tue, 2 May 2023 22:54:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] docs/ja_JP/SubmittingPatches: fix typo of Reviewd
To:     Deming Wang <wangdeming@inspur.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, shibata@linuxfoundation.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20230502010157.1655-1-wangdeming@inspur.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20230502010157.1655-1-wangdeming@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wy1DQyBrb3N1a2UsIGhlIGRvZXNuJ3QgcmV2aWV3IGphX0pQIGRvY3MgYW55bW9yZV0NCg0K
SGksDQoNCk9uIE1vbiwgMSBNYXkgMjAyMyAyMTowMTo1NyAtMDQwMCwgRGVtaW5nIFdhbmcg
d3JvdGU6DQo+IFdlIHNob3VsZCB1c2UgdGhlIFJldmlld2VkIHJlcGxhY2UgdGhlIFJldmll
d2QuDQoNCkNhbid0IHBhcnNlIC4uLg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEZW1pbmcg
V2FuZyA8d2FuZ2RlbWluZ0BpbnNwdXIuY29tPg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24v
dHJhbnNsYXRpb25zL2phX0pQL1N1Ym1pdHRpbmdQYXRjaGVzIHwgMiArLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNClRoaXMgbG9va3Mg
bGlrZSBhIHJlc2VuZCBvZiBhIHBhdGNoIHlvdSBwb3N0ZWQgZWFybGllciB3aXRoIHRoZSBj
aGFyc2V0DQppbiB0aGUgbWFpbCBoZWFkZXIgZml4ZWQuDQoNCldoZW4geW91IGRvIHJlc2Vu
ZCwgcGxlYXNlIG1ha2UgaXQgb2J2aW91cyBmb3IgcmV2aWV3ZXJzIGl0IGlzIGEgcmVzZW5k
Lg0KDQpJbiB0aGlzIGNhc2UsIHlvdSBoYXZlIGNoYW5nZWQgdGhlIHRpdGxlIGFuZCBjaGFu
Z2Vsb2cgdGV4dCwgc28gaXQNCnNob3VsZCBoYXZlIGJlZW4gc2VudCBhcyBhIHYyLg0KDQpZ
b3UgYXJlIGF0dGVtcHRpbmcgdG8gZml4IGFuIGlzc3VlIGluIGEgdHJhbnNsYXRpb24gb2YN
ClN1Ym1pdHRpbmdQYXRjaGVzIChvcmlnaW5hbCBvbmUgaXMgbm93IHN1Ym1pdHRpbmctcGF0
Y2hlcy5yc3QNCnVuZGVyIERvY3VtZW50YXRpb24vcHJvY2Vzcy8pLCBzbyBwbGVhc2UgZm9s
bG93IHRoZSBjb252ZW50aW9ucw0KZGVzY3JpYmVkIHRoZXJlLiANCg0KQW55d2F5LCBKb24g
bWlnaHQganVzdCBwaWNrIHRoaXMgb25lIHdpdGggaGlzIGVkaXQgb2YgY2hhbmdlbG9nLg0K
DQpTbyAoYWdhaW4pLA0KDQpSZXZpZXdlZC1ieTogQWtpcmEgWW9rb3Nhd2EgPGFraXlrc0Bn
bWFpbC5jb20+DQoNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0
aW9ucy9qYV9KUC9TdWJtaXR0aW5nUGF0Y2hlcyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRp
b25zL2phX0pQL1N1Ym1pdHRpbmdQYXRjaGVzDQo+IGluZGV4IDA0ZGViNzdiMjBjNi4uNTMz
NGRiNDcxNzQ0IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9q
YV9KUC9TdWJtaXR0aW5nUGF0Y2hlcw0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0
aW9ucy9qYV9KUC9TdWJtaXR0aW5nUGF0Y2hlcw0KPiBAQCAtNDUwLDcgKzQ1MCw3IEBAIFJl
dmlld2VkLWJ5OiDjgr/jgrDjga/jgIHjgZ3jgozjgajjga/nlbDjgarjgorjgIHkuIvoqJjj
ga7jg6zjg5Pjg6Xjg7zjgqLlrqPoqIANCj4gICAgICAgICAgICAgIOeKtuazgeOBq+OBiuOB
hOOBpuOBneOBruWuo+iogOOBl+OBn+ebrueahOOChOapn+iDveOBjOato+OBl+OBj+Wun+eP
vuOBmeOCi+OBk+OBqOOBq+mWouOBl+OBpuOAgQ0KPiAgICAgICAgICAgICAg44GE44GL44Gq
44KL5L+d6Ki844KC44GX44Gq44GEKOeJueOBq+OBqeOBk+OBi+OBp+aYjuekuuOBl+OBquOB
hOmZkOOCiinjgIINCj4gIA0KPiAtUmV2aWV3ZC1ieSDjgr/jgrDjga/jgZ3jga7jg5Hjg4Pj
g4HjgYzjgqvjg7zjg43jg6vjgavlr77jgZfjgabpganliIfjgarkv67mraPjgafjgYLjgaPj
gabjgIHmt7HliLvjgarmioDooZPnmoQNCj4gK1Jldmlld2VkLWJ5IOOCv+OCsOOBr+OBneOB
ruODkeODg+ODgeOBjOOCq+ODvOODjeODq+OBq+WvvuOBl+OBpumBqeWIh+OBquS/ruato+OB
p+OBguOBo+OBpuOAgea3seWIu+OBquaKgOihk+eahA0KPiAg5ZWP6aGM44KS5q6L44GX44Gm
44GE44Gq44GE44Go44GE44GG5oSP6KaL44Gu5a6j6KiA44Gn44GZ44CC6IiI5ZGz44Gu44GC
44KL44Os44OT44Ol44O844Ki44Gv6Kqw44Gn44KCKOODrOODk+ODpeODvA0KPiAg5L2c5qWt
44KS57WC44GI44Gf44KJKeODkeODg+ODgeOBq+WvvuOBl+OBpiBSZXZpZXdlZC1ieSDjgr/j
grDjgpLmj5DnpLrjgafjgY3jgb7jgZnjgILjgZPjga7jgr/jgrDjga8NCj4gIOODrOODk+OD
peODvOOCouOBruWvhOS4juOCkuOCr+ODrOOCuOODg+ODiOOBmeOCi+WDjeOBjeOAgeODrOOD
k+ODpeODvOOBrumAsuaNl+OBruW6puWQiOOBhOOCkuODoeODs+ODhuODiuOBqw0K
