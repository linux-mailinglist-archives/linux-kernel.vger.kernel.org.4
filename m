Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31D568054C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbjA3E6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjA3E6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:58:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C80EC51;
        Sun, 29 Jan 2023 20:58:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 58CCE21A54;
        Mon, 30 Jan 2023 04:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675054684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsEAPOMyaeu/9McoDoMoMk0k2EHIrCJNQvu263sxO1U=;
        b=DuB4cgq2LIabTM8uZnAWF0eU1FHiS4CQQ2JFBzn+0d/xZ7kIKXp7iSZGWs+TcR0UkgGjJy
        Q+Ap+x7Ycxwu7xvNd7IUtiWyzX+iIo1yc7Zp079jxprwVrbrIZHmYIPA3m4c5Ny1YcF3XI
        +gJDo8xIK80N/4RSAYqBddgj9Uip/6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675054684;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsEAPOMyaeu/9McoDoMoMk0k2EHIrCJNQvu263sxO1U=;
        b=Ci2ysmXzLi2CtQmPQ6E555lg6r2QDTpj3135rPpTFD3SXKzx0T5vBmMeFOGjFioX35x/eT
        69X8ZFwmaPeV29CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23F1413A09;
        Mon, 30 Jan 2023 04:57:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /YhgLVdO12PzegAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 30 Jan 2023 04:57:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Paul Cercueil" <paul@crapouillou.net>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        =?utf-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH] MIPS: DTS: CI20: fix otg power gpio
In-reply-to: <b7745c417d5ac46efa273f1fc45217bb6254ea4f.camel@crapouillou.net>
References: <1e102159b4be526af88883374d112d558e3ac3f5.1675014494.git.hns@goldelico.com>,
 <b7745c417d5ac46efa273f1fc45217bb6254ea4f.camel@crapouillou.net>
Date:   Mon, 30 Jan 2023 15:57:53 +1100
Message-id: <167505467359.23017.2124580706077477317@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAzMCBKYW4gMjAyMywgUGF1bCBDZXJjdWVpbCB3cm90ZToKPiBMZSBkaW1hbmNoZSAy
OSBqYW52aWVyIDIwMjMgw6AgMTg6NDggKzAxMDAsIEguIE5pa29sYXVzIFNjaGFsbGVyIGEKPiDD
qWNyaXTCoDoKPiA+IEFjY29yZGluZyB0byBzY2hlbWF0aWNzIGl0IGlzIFBGMTUgYW5kIG5vdCBQ
RjE0IChNSUNfU1dfRU4pLgo+ID4gU2VlbXMgYXMgaWYgaXQgd2FzIGhpZGRlbiBhbmQgbm90IG5v
dGljZWQgZHVyaW5nIHRlc3Rpbmcgc2luY2UKPiA+IHRoZXJlIGlzIG5vIHNvdW5kIERUIG5vZGUu
Cj4gPiAKPiA+IEZpeGVzOiAxNThjNzc0ZDNjNjQgKCJNSVBTOiBJbmdlbmljOiBBZGQgbWlzc2lu
ZyBub2RlcyBmb3IgSW5nZW5pYwo+ID4gU29DcyBhbmQgYm9hcmRzLiIpCj4gPiBTaWduZWQtb2Zm
LWJ5OiBILiBOaWtvbGF1cyBTY2hhbGxlciA8aG5zQGdvbGRlbGljby5jb20+Cj4gCj4gSSBtaXNz
ZWQgaXQsIGJ1dCBldmVyeSB0aW1lIHlvdSBoYXZlIGEgRml4ZXM6IHRhZywgeW91IGFsc28gbmVl
ZCB0byBhZGQKPiBiZWxvdzoKPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwoKSSBkb24ndCB0
aGluayB5b3UgZG8gYW55IG1vcmUuICBUaGUgc3RhYmxlIHRlYW0gZ3JhYnMgYW55dGhpbmcgdGhh
dApsb29rcyBldmVuIHZhZ3VlbHkgbGlrZSBhIGZpeCBhbmQgYXBwbGllcyBpdC4gIEhhdmluZyBh
IHZhbGlkIEZpeGVzIHRhZwppcyBlbm91Z2ggZm9yIHRoZSBzdGFibGUgdGVhbSB0byB0YWtlIGlu
dGVyZXN0LgoKTmVpbEJyb3duCgoKPiAKPiB1bmxlc3MgdGhlIGJ1ZyB5b3UgZml4IGlzIGluIG9u
ZSBvZiB0aGUgUkNzIChhbmQgbm90IGluIGEgcmVsZWFzZWQKPiBrZXJuZWwpLgo+IAo+IEkgdGhp
bmsgeW91IHNob3VsZCBzZW5kIGEgVjIgd2l0aCB0aGlzIHRhZyAoYW5kIG15IEFDSykuCj4gCj4g
Q2hlZXJzLAo+IC1QYXVsCj4gCj4gPiAtLS0KPiA+IMKgYXJjaC9taXBzL2Jvb3QvZHRzL2luZ2Vu
aWMvY2kyMC5kdHMgfCAyICstCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2Jvb3QvZHRzL2lu
Z2VuaWMvY2kyMC5kdHMKPiA+IGIvYXJjaC9taXBzL2Jvb3QvZHRzL2luZ2VuaWMvY2kyMC5kdHMK
PiA+IGluZGV4IDk4MTlhYmIyNDY1ZGQuLmEyNzY0ODhjMGY3NTIgMTAwNjQ0Cj4gPiAtLS0gYS9h
cmNoL21pcHMvYm9vdC9kdHMvaW5nZW5pYy9jaTIwLmR0cwo+ID4gKysrIGIvYXJjaC9taXBzL2Jv
b3QvZHRzL2luZ2VuaWMvY2kyMC5kdHMKPiA+IEBAIC0xMTUsNyArMTE1LDcgQEAgb3RnX3Bvd2Vy
OiBmaXhlZHJlZ3VsYXRvckAyIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8NTAwMDAwMD47Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDUwMDAwMDA+Owo+ID4g
wqAKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBncGlvID0gPCZncGYgMTQgR1BJ
T19BQ1RJVkVfTE9XPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBncGlvID0g
PCZncGYgMTUgR1BJT19BQ1RJVkVfTE9XPjsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZW5hYmxlLWFjdGl2ZS1oaWdoOwo+ID4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gPiDCoH07
Cj4gCj4gCg==
