Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A3C6408D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiLBO44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiLBO4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:56:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8591AD2D91
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:56:51 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0C99E1FDB3;
        Fri,  2 Dec 2022 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669993010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XBoUpP4HHw4c+t/+L8WwqyRNCxuiEZ2a4M3o0AVN0JA=;
        b=HXirF5aTu1NTr1KbFFbmXL3WMD+tjjDKc08puxeEkv5VY/fw97kHpuera30trMkRA/c0rS
        pD2lk/f5KoZAt0xXAQVQ49gMeuhy/2gGga9fH69Yf509HkEYxCbo8JHVIe9N4e3SIUxkXP
        hlfA6L+FvHzndPB2kTNDLuONVSvJxGI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AB322133DE;
        Fri,  2 Dec 2022 14:56:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id PFpMKDESimPOegAAGKfGzw
        (envelope-from <jgross@suse.com>); Fri, 02 Dec 2022 14:56:49 +0000
Message-ID: <d7000f26-2640-074e-10f2-c5232feaa9fd@suse.com>
Date:   Fri, 2 Dec 2022 15:56:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 13/16] x86: decouple PAT and MTRR handling
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20221102074713.21493-1-jgross@suse.com>
 <20221102074713.21493-14-jgross@suse.com>
 <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
 <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
 <20221201235753.ybfc7gkgj7hlfkru@box.shutemov.name>
 <eded3906-0720-a300-50c7-f8dad61c32c0@suse.com>
 <20221202132701.ymcp7a2yv3st33so@box.shutemov.name>
 <f4e9b9bb-6906-084c-4b9e-144b2abb024b@suse.com>
 <20221202143316.mtjz6dghecshldk2@box.shutemov.name>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20221202143316.mtjz6dghecshldk2@box.shutemov.name>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mhiKl7IcBv0P1QrVefCJKhbs"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------mhiKl7IcBv0P1QrVefCJKhbs
Content-Type: multipart/mixed; boundary="------------74ekdzUIKhtQAMS4rh000SD0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Message-ID: <d7000f26-2640-074e-10f2-c5232feaa9fd@suse.com>
Subject: Re: [PATCH v5 13/16] x86: decouple PAT and MTRR handling
References: <20221102074713.21493-1-jgross@suse.com>
 <20221102074713.21493-14-jgross@suse.com>
 <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
 <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
 <20221201235753.ybfc7gkgj7hlfkru@box.shutemov.name>
 <eded3906-0720-a300-50c7-f8dad61c32c0@suse.com>
 <20221202132701.ymcp7a2yv3st33so@box.shutemov.name>
 <f4e9b9bb-6906-084c-4b9e-144b2abb024b@suse.com>
 <20221202143316.mtjz6dghecshldk2@box.shutemov.name>
In-Reply-To: <20221202143316.mtjz6dghecshldk2@box.shutemov.name>

--------------74ekdzUIKhtQAMS4rh000SD0
Content-Type: multipart/mixed; boundary="------------Y0RcTrtcCX1XG7CicsZVyIjl"

--------------Y0RcTrtcCX1XG7CicsZVyIjl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMTIuMjIgMTU6MzMsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gT24gRnJp
LCBEZWMgMDIsIDIwMjIgYXQgMDI6Mzk6NThQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90
ZToNCj4+IE9uIDAyLjEyLjIyIDE0OjI3LCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+
Pj4gT24gRnJpLCBEZWMgMDIsIDIwMjIgYXQgMDY6NTY6NDdBTSArMDEwMCwgSnVlcmdlbiBH
cm9zcyB3cm90ZToNCj4+Pj4gT24gMDIuMTIuMjIgMDA6NTcsIEtpcmlsbCBBLiBTaHV0ZW1v
diB3cm90ZToNCj4+Pj4+IE9uIFRodSwgRGVjIDAxLCAyMDIyIGF0IDA1OjMzOjI4UE0gKzAx
MDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4+Pj4gT24gMDEuMTIuMjIgMTc6MjYsIEtp
cmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4+Pj4+Pj4gT24gV2VkLCBOb3YgMDIsIDIwMjIg
YXQgMDg6NDc6MTBBTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+Pj4+Pj4+IFRv
ZGF5IFBBVCBpcyB1c2FibGUgb25seSB3aXRoIE1UUlIgYmVpbmcgYWN0aXZlLCB3aXRoIHNv
bWUgbmFzdHkgdHdlYWtzDQo+Pj4+Pj4+PiB0byBtYWtlIFBBVCB1c2FibGUgd2hlbiBydW5u
aW5nIGFzIFhlbiBQViBndWVzdCwgd2hpY2ggZG9lc24ndCBzdXBwb3J0DQo+Pj4+Pj4+PiBN
VFJSLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFRoZSByZWFzb24gZm9yIHRoaXMgY291cGxpbmcg
aXMsIHRoYXQgYm90aCwgUEFUIE1TUiBjaGFuZ2VzIGFuZCBNVFJSDQo+Pj4+Pj4+PiBjaGFu
Z2VzLCByZXF1aXJlIGEgc2ltaWxhciBzZXF1ZW5jZSBhbmQgc28gZnVsbCBQQVQgc3VwcG9y
dCB3YXMgYWRkZWQNCj4+Pj4+Pj4+IHVzaW5nIHRoZSBhbHJlYWR5IGF2YWlsYWJsZSBNVFJS
IGhhbmRsaW5nLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFhlbiBQViBQQVQgaGFuZGxpbmcgY2Fu
IHdvcmsgd2l0aG91dCBNVFJSLCBhcyBpdCBqdXN0IG5lZWRzIHRvIGNvbnN1bWUNCj4+Pj4+
Pj4+IHRoZSBQQVQgTVNSIHNldHRpbmcgZG9uZSBieSB0aGUgaHlwZXJ2aXNvciB3aXRob3V0
IHRoZSBhYmlsaXR5IGFuZCBuZWVkDQo+Pj4+Pj4+PiB0byBjaGFuZ2UgaXQuIFRoaXMgaW4g
dHVybiBoYXMgcmVzdWx0ZWQgaW4gYSBjb252b2x1dGVkIGluaXRpYWxpemF0aW9uDQo+Pj4+
Pj4+PiBzZXF1ZW5jZSBhbmQgd3JvbmcgZGVjaXNpb25zIHJlZ2FyZGluZyBjYWNoZSBtb2Rl
IGF2YWlsYWJpbGl0eSBkdWUgdG8NCj4+Pj4+Pj4+IG1pc2d1aWRpbmcgUEFUIGF2YWlsYWJp
bGl0eSBmbGFncy4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBGaXggYWxsIG9mIHRoYXQgYnkgYWxs
b3dpbmcgdG8gdXNlIFBBVCB3aXRob3V0IE1UUlIgYW5kIGJ5IHJld29ya2luZw0KPj4+Pj4+
Pj4gdGhlIGN1cnJlbnQgUEFUIGluaXRpYWxpemF0aW9uIHNlcXVlbmNlIHRvIG1hdGNoIGJl
dHRlciB3aXRoIHRoZSBuZXdseQ0KPj4+Pj4+Pj4gaW50cm9kdWNlZCBnZW5lcmljIGNhY2hl
IGluaXRpYWxpemF0aW9uLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFRoaXMgcmVtb3ZlcyB0aGUg
bmVlZCBvZiB0aGUgcmVjZW50bHkgYWRkZWQgcGF0X2ZvcmNlX2Rpc2FibGVkIGZsYWcsIHNv
DQo+Pj4+Pj4+PiByZW1vdmUgdGhlIHJlbW5hbnRzIG9mIHRoZSBwYXRjaCBhZGRpbmcgaXQu
DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdy
b3NzQHN1c2UuY29tPg0KPj4+Pj4+Pg0KPj4+Pj4+PiBUaGlzIHBhdGNoIGJyZWFrcyBib290
IGZvciBURFggZ3Vlc3QuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IEtlcm5lbCBub3cgdHJpZXMgdG8g
c2V0IENSMC5DRCB3aGljaCBpcyBmb3JiaWRkZW4gaW4gVERYIGd1ZXN0WzFdIGFuZA0KPj4+
Pj4+PiBjYXVzZXMgI1ZFOg0KPj4+Pj4+Pg0KPj4+Pj4+PiAJdGR4OiBVbmV4cGVjdGVkICNW
RTogMjgNCj4+Pj4+Pj4gCVZFIGZhdWx0OiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgTk9QVEkN
Cj4+Pj4+Pj4gCUNQVTogMCBQSUQ6IDAgQ29tbTogc3dhcHBlciBOb3QgdGFpbnRlZCA2LjEu
MC1yYzEtMDAwMTUtZ2FkZmU3NTEyZTFkMCAjMjY0Ng0KPj4+Pj4+PiAJSGFyZHdhcmUgbmFt
ZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJT1MgMC4wLjAgMDIv
MDYvMjAxNQ0KPj4+Pj4+PiAJUklQOiAwMDEwOm5hdGl2ZV93cml0ZV9jcjAgKGFyY2gveDg2
L2tlcm5lbC9jcHUvY29tbW9uLmM6NDI3KQ0KPj4+Pj4+PiAJIENhbGwgVHJhY2U6DQo+Pj4+
Pj4+IAkgIDxUQVNLPg0KPj4+Pj4+PiAJID8gY2FjaGVfZGlzYWJsZSAoYXJjaC94ODYvaW5j
bHVkZS9hc20vY3B1ZmVhdHVyZS5oOjE3MyBhcmNoL3g4Ni9rZXJuZWwvY3B1L2NhY2hlaW5m
by5jOjEwODUpDQo+Pj4+Pj4+IAkgPyBjYWNoZV9jcHVfaW5pdCAoYXJjaC94ODYva2VybmVs
L2NwdS9jYWNoZWluZm8uYzoxMTMyIChkaXNjcmltaW5hdG9yIDMpKQ0KPj4+Pj4+PiAJID8g
c2V0dXBfYXJjaCAoYXJjaC94ODYva2VybmVsL3NldHVwLmM6MTA3OSkNCj4+Pj4+Pj4gCSA/
IHN0YXJ0X2tlcm5lbCAoaW5pdC9tYWluLmM6Mjc5IChkaXNjcmltaW5hdG9yIDMpIGluaXQv
bWFpbi5jOjQ3NyAoZGlzY3JpbWluYXRvciAzKSBpbml0L21haW4uYzo5NjAgKGRpc2NyaW1p
bmF0b3IgMykpDQo+Pj4+Pj4+IAkgPyBsb2FkX3Vjb2RlX2JzcCAoYXJjaC94ODYva2VybmVs
L2NwdS9taWNyb2NvZGUvY29yZS5jOjE1NSkNCj4+Pj4+Pj4gCSA/IHNlY29uZGFyeV9zdGFy
dHVwXzY0X25vX3ZlcmlmeSAoYXJjaC94ODYva2VybmVsL2hlYWRfNjQuUzozNTgpDQo+Pj4+
Pj4+IAkgIDwvVEFTSz4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gQW55IHN1Z2dlc3Rpb24gaG93IHRv
IGZpeCBpdD8NCj4+Pj4+Pj4NCj4+Pj4+Pj4gWzFdIFNlY3Rpb24gMTAuNi4xLiAiQ1IwIiwg
aHR0cHM6Ly9jZHJkdjIuaW50ZWwuY29tL3YxL2RsL2dldENvbnRlbnQvNzMzNTY4DQo+Pj4+
Pj4NCj4+Pj4+PiBXaGF0IHdhcyB0aGUgc29sdXRpb24gYmVmb3JlPw0KPj4+Pj4+DQo+Pj4+
Pj4gSSBndWVzcyBNVFJSIHdhcyBkaXNhYmxlZCwgc28gdGhlcmUgd2FzIG5vIFBBVCwgdG9v
Pw0KPj4+Pj4NCj4+Pj4+IFJpZ2h0Og0KPj4+Pj4NCj4+Pj4+IExpbnVzJyB0cmVlOg0KPj4+
Pj4NCj4+Pj4+IFsgICAgMC4wMDI1ODldIGxhc3RfcGZuID0gMHg0ODAwMDAgbWF4X2FyY2hf
cGZuID0gMHgxMDAwMDAwMDAwMA0KPj4+Pj4gWyAgICAwLjAwMzk3Nl0gRGlzYWJsZWQNCj4+
Pj4+IFsgICAgMC4wMDQ0NTJdIHg4Ni9QQVQ6IE1UUlJzIGRpc2FibGVkLCBza2lwcGluZyBQ
QVQgaW5pdGlhbGl6YXRpb24gdG9vLg0KPj4+Pj4gWyAgICAwLjAwNTg1Nl0gQ1BVIE1UUlJz
IGFsbCBibGFuayAtIHZpcnR1YWxpemVkIHN5c3RlbS4NCj4+Pj4+IFsgICAgMC4wMDY5MTVd
IHg4Ni9QQVQ6IENvbmZpZ3VyYXRpb24gWzAtN106IFdCICBXVCAgVUMtIFVDICBXQiAgV1Qg
IFVDLSBVQw0KPj4+Pj4NCj4+Pj4+IHRpcC9tYXN0ZXI6DQo+Pj4+Pg0KPj4+Pj4gWyAgICAw
LjAwMzQ0M10gbGFzdF9wZm4gPSAweDIwYjhlIG1heF9hcmNoX3BmbiA9IDB4MTAwMDAwMDAw
MDANCj4+Pj4+IFsgICAgMC4wMDUyMjBdIERpc2FibGVkDQo+Pj4+PiBbICAgIDAuMDA1ODE4
XSB4ODYvUEFUOiBDb25maWd1cmF0aW9uIFswLTddOiBXQiAgV0MgIFVDLSBVQyAgV0IgIFdQ
ICBVQy0gV1QNCj4+Pj4+IFsgICAgMC4wMDc3NTJdIHRkeDogVW5leHBlY3RlZCAjVkU6IDI4
DQo+Pj4+Pg0KPj4+Pj4gVGhlIGRhbmdsaW5nICJEaXNhYmxlZCIgY29tZXMgbXRycl9icF9p
bml0KCkuDQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+PiBJZiB0aGlzIGlzIHRoZSBjYXNlLCB5b3Ug
Y2FuIGdvIHRoZSBzYW1lIHJvdXRlIGFzIFhlbiBQViBndWVzdHMgZG8uDQo+Pj4+Pg0KPj4+
Pj4gQW55IHJlYXNvbiBYODZfRkVBVFVSRV9IWVBFUlZJU09SIGNhbm5vdCBiZSB1c2VkIGlu
c3RlYWQgb2YNCj4+Pj4+IFg4Nl9GRUFUVVJFX1hFTlBWIHRoZXJlPw0KPj4+Pj4NCj4+Pj4+
IERvIHdlIGhhdmUgYW55IHZpcnR1YWxpemVkIHBsYXRmb3JtIHRoYXQgc3VwcG9ydHMgaXQ/
DQo+Pj4+DQo+Pj4+IFllcywgb2YgY291cnNlLiBBbnkgaGFyZHdhcmUgdmlydHVhbGl6ZWQg
Z3Vlc3Qgc2hvdWxkIGJlIGFibGUgdG8gdXNlIGl0LA0KPj4+PiBvYnZpb3VzbHkgVERYIGd1
ZXN0cyBhcmUgdGhlIGZpcnN0IG9uZXMgbm90IGJlaW5nIGFibGUgdG8gZG8gc28uDQo+Pj4+
DQo+Pj4+IEFuZCBhYm92ZSBkbWVzZyBzbmlwcGxldHMgYXJlIHNob3dpbmcgcmF0aGVyIG5p
Y2VseSB0aGF0IG5vdCBkaXNhYmxpbmcNCj4+Pj4gUEFUIGNvbXBsZXRlbHkgc2hvdWxkIGJl
IGEgYmVuZWZpdCBmb3IgVERYIGd1ZXN0cywgYXMgYWxsIGNhY2hpbmcgbW9kZXMNCj4+Pj4g
d291bGQgYmUgdXNhYmxlICh0aGUgUEFUIE1TUiBzZWVtcyB0byBiZSBpbml0aWFsaXplZCBx
dWl0ZSBmaW5lKS4NCj4+Pj4NCj4+Pj4gSW5zdGVhZCBvZiBYODZfRkVBVFVSRV9YRU5QViB3
ZSBjb3VsZCBpbnRyb2R1Y2Ugc29tZXRoaW5nIGxpa2UNCj4+Pj4gWDg2X0ZFQVRVUkVfUEFU
X1JFQURPTkxZLCB3aGljaCBjb3VsZCBiZSBzZXQgZm9yIFhlbiBQViBndWVzdHMgYW5kIGZv
cg0KPj4+PiBURFggZ3Vlc3RzLg0KPj4+DQo+Pj4gVGVjaG5pY2FsbHksIHRoZSBNU1IgaXMg
d3JpdGFibGUgb24gVERYLiBCdXQgaXQgc2VlbXMgdGhlcmUncyBubyB3YXkgdG8NCj4+PiBw
cm9wZXJseSBjaGFuZ2UgaXQsIGZvbGxvd2luZyB0aGUgcHJvdG9jb2wgb2YgY2hhbmdpbmcg
b24gTVAgc3lzdGVtcy4NCj4+DQo+PiBXaHkgbm90PyBJIGRvbid0IHNlZSB3aHkgaXQgaXMg
cG9zc2libGUgaW4gYSBub24tVERYIHN5c3RlbSwgYnV0IG5vdCB3aXRoaW4NCj4+IGEgVERY
IGd1ZXN0Lg0KPiANCj4gQmVjYXVzZSB0aGUgcHJvdG9jb2wgeW91IGRlc2NyaWJlZCBiZWxv
dyByZXF1aXJlcyBzZXR0aW5nIENSMC5DRCB3aGljaCBpcw0KPiBub3QgYWxsb3dlZCBpbiBU
RFggZ3Vlc3QgYW5kIGNhdXNlcyAjVkUuDQoNCkhtbSwgeWVzLCBzZWVtcyB0byBiZSBhIHZh
bGlkIHJlYXNvbi4gOi0pDQoNCj4gDQo+Pj4gQWx0aG91Z2gsIEkgZG9uJ3QgcXVpdGUgZm9s
bG93IHdoYXQgcm9sZSBjYWNoZSBkaXNhYmxpbmcgcGxheWluZyBvbiBzeXN0ZW0NCj4+PiB3
aXRoIHNlbGYtc25vb3Agc3VwcG9ydC4gSG0/DQo+Pg0KPj4gSXQgaXMgdGhlIHJlY29tbWVu
ZGVkIHdheSB0byBkbyBpdC4gU2VlIFNETSBWb2wuIDMgQ2hhcHRlciAxMSAoIk1lbW9yeSBD
YWNoZQ0KPj4gQ29udHJvbCIpOg0KPj4NCj4+IFRoZSBvcGVyYXRpbmcgc3lzdGVtIGlzIHJl
c3BvbnNpYmxlIGZvciBpbnN1cmluZyB0aGF0IGNoYW5nZXMgdG8gYSBQQVQgZW50cnkNCj4+
IG9jY3VyIGluIGEgbWFubmVyIHRoYXQgbWFpbnRhaW5zIHRoZSBjb25zaXN0ZW5jeSBvZiB0
aGUgcHJvY2Vzc29yIGNhY2hlcyBhbmQNCj4+IHRyYW5zbGF0aW9uIGxvb2thc2lkZSBidWZm
ZXJzIChUTEIpLiBUaGlzIGlzIGFjY29tcGxpc2hlZCBieSBmb2xsb3dpbmcgdGhlDQo+PiBw
cm9jZWR1cmUgYXMgc3BlY2lmaWVkIGluIFNlY3Rpb24gMTEuMTEuOCwg4oCcTVRSUiBDb25z
aWRlcmF0aW9ucyBpbiBNUCBTeXN0ZW1zLA0KPj4g4oCdZm9yIGNoYW5naW5nIHRoZSB2YWx1
ZSBvZiBhbiBNVFJSIGluIGEgbXVsdGlwbGUgcHJvY2Vzc29yIHN5c3RlbS4gSXQgcmVxdWly
ZXMNCj4+IGEgc3BlY2lmaWMgc2VxdWVuY2Ugb2Ygb3BlcmF0aW9ucyB0aGF0IGluY2x1ZGVz
IGZsdXNoaW5nIHRoZSBwcm9jZXNzb3JzIGNhY2hlcw0KPj4gYW5kIFRMQnMuDQo+Pg0KPj4g
QW5kIHRoZSBzZXF1ZW5jZSBmb3IgdGhlIE1UUlJzIGlzOg0KPj4NCj4+IDEuIEJyb2FkY2Fz
dCB0byBhbGwgcHJvY2Vzc29ycyB0byBleGVjdXRlIHRoZSBmb2xsb3dpbmcgY29kZSBzZXF1
ZW5jZS4NCj4+IDIuIERpc2FibGUgaW50ZXJydXB0cy4NCj4+IDMuIFdhaXQgZm9yIGFsbCBw
cm9jZXNzb3JzIHRvIHJlYWNoIHRoaXMgcG9pbnQuDQo+PiA0LiBFbnRlciB0aGUgbm8tZmls
bCBjYWNoZSBtb2RlLiAoU2V0IHRoZSBDRCBmbGFnIGluIGNvbnRyb2wgcmVnaXN0ZXIgQ1Iw
IHRvIDENCj4+ICAgICBhbmQgdGhlIE5XIGZsYWcgdG8gMC4pDQo+PiA1LiBGbHVzaCBhbGwg
Y2FjaGVzIHVzaW5nIHRoZSBXQklOVkQgaW5zdHJ1Y3Rpb25zLiBOb3RlIG9uIGEgcHJvY2Vz
c29yIHRoYXQNCj4+ICAgICBzdXBwb3J0cyBzZWxmLXNub29waW5nLCBDUFVJRCBmZWF0dXJl
IGZsYWcgYml0IDI3LCB0aGlzIHN0ZXAgaXMgdW5uZWNlc3NhcnkuDQo+PiA2LiBJZiB0aGUg
UEdFIGZsYWcgaXMgc2V0IGluIGNvbnRyb2wgcmVnaXN0ZXIgQ1I0LCBmbHVzaCBhbGwgVExC
cyBieSBjbGVhcmluZw0KPj4gICAgIHRoYXQgZmxhZy4NCj4+IDcuIElmIHRoZSBQR0UgZmxh
ZyBpcyBjbGVhciBpbiBjb250cm9sIHJlZ2lzdGVyIENSNCwgZmx1c2ggYWxsIFRMQnMgYnkg
ZXhlY3V0aW5nDQo+PiAgICAgYSBNT1YgZnJvbSBjb250cm9sIHJlZ2lzdGVyIENSMyB0byBh
bm90aGVyIHJlZ2lzdGVyIGFuZCB0aGVuIGEgTU9WIGZyb20gdGhhdA0KPj4gICAgIHJlZ2lz
dGVyIGJhY2sgdG8gQ1IzLg0KPj4gOC4gRGlzYWJsZSBhbGwgcmFuZ2UgcmVnaXN0ZXJzIChi
eSBjbGVhcmluZyB0aGUgRSBmbGFnIGluIHJlZ2lzdGVyIE1UUlJkZWZUeXBlKS4NCj4+ICAg
ICBJZiBvbmx5IHZhcmlhYmxlIHJhbmdlcyBhcmUgYmVpbmcgbW9kaWZpZWQsIHNvZnR3YXJl
IG1heSBjbGVhciB0aGUgdmFsaWQgYml0cw0KPj4gICAgIGZvciB0aGUgYWZmZWN0ZWQgcmVn
aXN0ZXIgcGFpcnMgaW5zdGVhZC4NCj4+IDkuIFVwZGF0ZSB0aGUgTVRSUnMuDQo+PiAxMC4g
RW5hYmxlIGFsbCByYW5nZSByZWdpc3RlcnMgKGJ5IHNldHRpbmcgdGhlIEUgZmxhZyBpbiBy
ZWdpc3RlciBNVFJSZGVmVHlwZSkuDQo+PiAgICAgIElmIG9ubHkgdmFyaWFibGUtcmFuZ2Ug
cmVnaXN0ZXJzIHdlcmUgbW9kaWZpZWQgYW5kIHRoZWlyIGluZGl2aWR1YWwgdmFsaWQNCj4+
ICAgICAgYml0cyB3ZXJlIGNsZWFyZWQsIHRoZW4gc2V0IHRoZSB2YWxpZCBiaXRzIGZvciB0
aGUgYWZmZWN0ZWQgcmFuZ2VzIGluc3RlYWQuDQo+PiAxMS4gRmx1c2ggYWxsIGNhY2hlcyBh
bmQgYWxsIFRMQnMgYSBzZWNvbmQgdGltZS4gKFRoZSBUTEIgZmx1c2ggaXMgcmVxdWlyZWQg
Zm9yDQo+PiAgICAgIFBlbnRpdW0gNCwgSW50ZWwgWGVvbiwgYW5kIFA2IGZhbWlseSBwcm9j
ZXNzb3JzLiBFeGVjdXRpbmcgdGhlIFdCSU5WRA0KPj4gICAgICBpbnN0cnVjdGlvbiBpcyBu
b3QgbmVlZGVkIHdoZW4gdXNpbmcgUGVudGl1bSA0LCBJbnRlbCBYZW9uLCBhbmQgUDYgZmFt
aWx5DQo+PiAgICAgIHByb2Nlc3NvcnMsIGJ1dCBpdCBtYXkgYmUgbmVlZGVkIGluIGZ1dHVy
ZSBzeXN0ZW1zLikNCj4+IDEyLiBFbnRlciB0aGUgbm9ybWFsIGNhY2hlIG1vZGUgdG8gcmUt
ZW5hYmxlIGNhY2hpbmcuIChTZXQgdGhlIENEIGFuZCBOVyBmbGFncw0KPj4gICAgICBpbiBj
b250cm9sIHJlZ2lzdGVyIENSMCB0byAwLikNCj4+IDEzLiBTZXQgUEdFIGZsYWcgaW4gY29u
dHJvbCByZWdpc3RlciBDUjQsIGlmIGNsZWFyZWQgaW4gU3RlcCA2IChhYm92ZSkuDQo+PiAx
NC4gV2FpdCBmb3IgYWxsIHByb2Nlc3NvcnMgdG8gcmVhY2ggdGhpcyBwb2ludC4NCj4+IDE1
LiBFbmFibGUgaW50ZXJydXB0cy4NCj4+DQo+PiBTbyBjYWNoZSBkaXNhYmxpbmcgaXMgcmVj
b21tZW5kZWQuDQo+IA0KPiBZZWFoLCBJIHJlYWQgdGhhdC4NCj4gDQo+IEJ1dCB0aGUgcXVl
c3Rpb24gaXMgd2hhdCBraW5kIG9mIHNjZW5hcmlvIGNhY2hlIGRpc2FibGluZyBpcyBhY3R1
YWxseQ0KPiBwcmV2ZW50cyBpZiBzZWxmLXNub29wIGlzIHN1cHBvcnRlZD8gSW4gdGhpcyBj
YXNlIGNhY2hlIHN0YXlzIGludGFjdCAobm8NCj4gV0JJTlZEKS4gVGhlIG5leHQgdGltZSBh
IGNhY2hlIGxpbmUgZ2V0cyBhY2Nlc3NlZCB3aXRoIGRpZmZlcmVudCBjYWNoaW5nDQo+IG1v
ZGUgdGhlIG9sZCBsaW5lIGdldHMgc25vb3BlZCwgcmlnaHQ/DQo+IA0KPiBXb3VsZCBpdCBi
ZSB2YWxpZCB0byBhdm9pZCB0b3VjaGluZyBDUjAuQ0QgaWYgWDg2X0ZFQVRVUkVfU0VMRlNO
T09QPw0KPiANCg0KVGhhdCdzIGEgcXVlc3Rpb24gZm9yIHRoZSBJbnRlbCBhcmNoaXRlY3Rz
LCBJIGd1ZXNzLg0KDQpJJ2QganVzdCBhc2sgdGhlbSBob3cgdG8gc2V0dXAgUEFUIGluIFRE
WCBndWVzdHMuIEVpdGhlciB0aGV5IG5lZWQgdG8NCmNoYW5nZSB0aGUgcmVjb21tZW5kZWQg
c2V0dXAgc2VxdWVuY2UsIG9yIHRoZSBQQVQgc3VwcG9ydCBiaXQgbmVlZHMgdG8NCmJlIGNs
ZWFyZWQgSU1PLg0KDQoNCkp1ZXJnZW4NCg==
--------------Y0RcTrtcCX1XG7CicsZVyIjl
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------Y0RcTrtcCX1XG7CicsZVyIjl--

--------------74ekdzUIKhtQAMS4rh000SD0--

--------------mhiKl7IcBv0P1QrVefCJKhbs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmOKEjEFAwAAAAAACgkQsN6d1ii/Ey9w
4gf/XYFTUMv2uOGUOM0HPAsUBxw0dEsvaVudgrCmnz74KGQQK6bNsy38E553+TCasNfooVkYoPIv
R/nKSrY8epCUmKSNfp/NIaU8kSIv2Og47sETfjPysnbchjgl74nb8okoNM36Rr8dhEtIaITC7mEu
lP1lHo0ITYLuUECr+BgDBV7uAk1tGpZkK+NElmvJOXoUklw/O/lK3liCjqkCm12HHQiJMsmeD5uH
/mWc6M2taAOtJBKhVnx2t5hSyStfL8E+DkajrbsyYBJGfpr/Z+a+lWVfLaEcf0hQYgLVg9BSA8Iq
/1WD+UPxfcgFvgaOOMc8KveWP6DK/VOZIDOh6SNwIQ==
=LNPa
-----END PGP SIGNATURE-----

--------------mhiKl7IcBv0P1QrVefCJKhbs--
