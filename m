Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B256407CE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiLBNkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiLBNkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:40:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8EABE1E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:40:00 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA25F21B7F;
        Fri,  2 Dec 2022 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669988398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bVqDiQnZa9AyRVdLubylzVhEywv734CEEk9VurbOMrU=;
        b=U/4exzS652SdfJqmW8xdO4aa2SJRoL9x/R8OULV2PQLVr9IVyAE9AcFVwW2bOCKkUI20S5
        hsrCG0/KimjKHHwCnlMzNA1jU9G1OXZlXaoMXzlohMhVHGpP+daOIONUkpHbMg1cHXbdm1
        SSEl1b2Cn1mOX29Ph+15XlvxU1ozVFY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8C22D133DE;
        Fri,  2 Dec 2022 13:39:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id avmqIC4AimPoUgAAGKfGzw
        (envelope-from <jgross@suse.com>); Fri, 02 Dec 2022 13:39:58 +0000
Message-ID: <f4e9b9bb-6906-084c-4b9e-144b2abb024b@suse.com>
Date:   Fri, 2 Dec 2022 14:39:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
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
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5 13/16] x86: decouple PAT and MTRR handling
In-Reply-To: <20221202132701.ymcp7a2yv3st33so@box.shutemov.name>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nUPj1uNSfJc2zDo5700NPXPS"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nUPj1uNSfJc2zDo5700NPXPS
Content-Type: multipart/mixed; boundary="------------CCVp1KJZ6wUIf0SSvKkUjCE4";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Message-ID: <f4e9b9bb-6906-084c-4b9e-144b2abb024b@suse.com>
Subject: Re: [PATCH v5 13/16] x86: decouple PAT and MTRR handling
References: <20221102074713.21493-1-jgross@suse.com>
 <20221102074713.21493-14-jgross@suse.com>
 <20221201162639.omlr5ff55go7uhlf@box.shutemov.name>
 <6d642051-31d8-81d5-f379-568360c5cb60@suse.com>
 <20221201235753.ybfc7gkgj7hlfkru@box.shutemov.name>
 <eded3906-0720-a300-50c7-f8dad61c32c0@suse.com>
 <20221202132701.ymcp7a2yv3st33so@box.shutemov.name>
In-Reply-To: <20221202132701.ymcp7a2yv3st33so@box.shutemov.name>

--------------CCVp1KJZ6wUIf0SSvKkUjCE4
Content-Type: multipart/mixed; boundary="------------JZdpnW6b0Ot5vsKXw2u8LDOf"

--------------JZdpnW6b0Ot5vsKXw2u8LDOf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMTIuMjIgMTQ6MjcsIEtpcmlsbCBBLiBTaHV0ZW1vdiB3cm90ZToNCj4gT24gRnJp
LCBEZWMgMDIsIDIwMjIgYXQgMDY6NTY6NDdBTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90
ZToNCj4+IE9uIDAyLjEyLjIyIDAwOjU3LCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+
Pj4gT24gVGh1LCBEZWMgMDEsIDIwMjIgYXQgMDU6MzM6MjhQTSArMDEwMCwgSnVlcmdlbiBH
cm9zcyB3cm90ZToNCj4+Pj4gT24gMDEuMTIuMjIgMTc6MjYsIEtpcmlsbCBBLiBTaHV0ZW1v
diB3cm90ZToNCj4+Pj4+IE9uIFdlZCwgTm92IDAyLCAyMDIyIGF0IDA4OjQ3OjEwQU0gKzAx
MDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4+Pj4gVG9kYXkgUEFUIGlzIHVzYWJsZSBv
bmx5IHdpdGggTVRSUiBiZWluZyBhY3RpdmUsIHdpdGggc29tZSBuYXN0eSB0d2Vha3MNCj4+
Pj4+PiB0byBtYWtlIFBBVCB1c2FibGUgd2hlbiBydW5uaW5nIGFzIFhlbiBQViBndWVzdCwg
d2hpY2ggZG9lc24ndCBzdXBwb3J0DQo+Pj4+Pj4gTVRSUi4NCj4+Pj4+Pg0KPj4+Pj4+IFRo
ZSByZWFzb24gZm9yIHRoaXMgY291cGxpbmcgaXMsIHRoYXQgYm90aCwgUEFUIE1TUiBjaGFu
Z2VzIGFuZCBNVFJSDQo+Pj4+Pj4gY2hhbmdlcywgcmVxdWlyZSBhIHNpbWlsYXIgc2VxdWVu
Y2UgYW5kIHNvIGZ1bGwgUEFUIHN1cHBvcnQgd2FzIGFkZGVkDQo+Pj4+Pj4gdXNpbmcgdGhl
IGFscmVhZHkgYXZhaWxhYmxlIE1UUlIgaGFuZGxpbmcuDQo+Pj4+Pj4NCj4+Pj4+PiBYZW4g
UFYgUEFUIGhhbmRsaW5nIGNhbiB3b3JrIHdpdGhvdXQgTVRSUiwgYXMgaXQganVzdCBuZWVk
cyB0byBjb25zdW1lDQo+Pj4+Pj4gdGhlIFBBVCBNU1Igc2V0dGluZyBkb25lIGJ5IHRoZSBo
eXBlcnZpc29yIHdpdGhvdXQgdGhlIGFiaWxpdHkgYW5kIG5lZWQNCj4+Pj4+PiB0byBjaGFu
Z2UgaXQuIFRoaXMgaW4gdHVybiBoYXMgcmVzdWx0ZWQgaW4gYSBjb252b2x1dGVkIGluaXRp
YWxpemF0aW9uDQo+Pj4+Pj4gc2VxdWVuY2UgYW5kIHdyb25nIGRlY2lzaW9ucyByZWdhcmRp
bmcgY2FjaGUgbW9kZSBhdmFpbGFiaWxpdHkgZHVlIHRvDQo+Pj4+Pj4gbWlzZ3VpZGluZyBQ
QVQgYXZhaWxhYmlsaXR5IGZsYWdzLg0KPj4+Pj4+DQo+Pj4+Pj4gRml4IGFsbCBvZiB0aGF0
IGJ5IGFsbG93aW5nIHRvIHVzZSBQQVQgd2l0aG91dCBNVFJSIGFuZCBieSByZXdvcmtpbmcN
Cj4+Pj4+PiB0aGUgY3VycmVudCBQQVQgaW5pdGlhbGl6YXRpb24gc2VxdWVuY2UgdG8gbWF0
Y2ggYmV0dGVyIHdpdGggdGhlIG5ld2x5DQo+Pj4+Pj4gaW50cm9kdWNlZCBnZW5lcmljIGNh
Y2hlIGluaXRpYWxpemF0aW9uLg0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyByZW1vdmVzIHRoZSBu
ZWVkIG9mIHRoZSByZWNlbnRseSBhZGRlZCBwYXRfZm9yY2VfZGlzYWJsZWQgZmxhZywgc28N
Cj4+Pj4+PiByZW1vdmUgdGhlIHJlbW5hbnRzIG9mIHRoZSBwYXRjaCBhZGRpbmcgaXQuDQo+
Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3Vz
ZS5jb20+DQo+Pj4+Pg0KPj4+Pj4gVGhpcyBwYXRjaCBicmVha3MgYm9vdCBmb3IgVERYIGd1
ZXN0Lg0KPj4+Pj4NCj4+Pj4+IEtlcm5lbCBub3cgdHJpZXMgdG8gc2V0IENSMC5DRCB3aGlj
aCBpcyBmb3JiaWRkZW4gaW4gVERYIGd1ZXN0WzFdIGFuZA0KPj4+Pj4gY2F1c2VzICNWRToN
Cj4+Pj4+DQo+Pj4+PiAJdGR4OiBVbmV4cGVjdGVkICNWRTogMjgNCj4+Pj4+IAlWRSBmYXVs
dDogMDAwMCBbIzFdIFBSRUVNUFQgU01QIE5PUFRJDQo+Pj4+PiAJQ1BVOiAwIFBJRDogMCBD
b21tOiBzd2FwcGVyIE5vdCB0YWludGVkIDYuMS4wLXJjMS0wMDAxNS1nYWRmZTc1MTJlMWQw
ICMyNjQ2DQo+Pj4+PiAJSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsg
SUNIOSwgMjAwOSksIEJJT1MgMC4wLjAgMDIvMDYvMjAxNQ0KPj4+Pj4gCVJJUDogMDAxMDpu
YXRpdmVfd3JpdGVfY3IwIChhcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jOjQyNykNCj4+
Pj4+IAkgQ2FsbCBUcmFjZToNCj4+Pj4+IAkgIDxUQVNLPg0KPj4+Pj4gCSA/IGNhY2hlX2Rp
c2FibGUgKGFyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmUuaDoxNzMgYXJjaC94ODYv
a2VybmVsL2NwdS9jYWNoZWluZm8uYzoxMDg1KQ0KPj4+Pj4gCSA/IGNhY2hlX2NwdV9pbml0
IChhcmNoL3g4Ni9rZXJuZWwvY3B1L2NhY2hlaW5mby5jOjExMzIgKGRpc2NyaW1pbmF0b3Ig
MykpDQo+Pj4+PiAJID8gc2V0dXBfYXJjaCAoYXJjaC94ODYva2VybmVsL3NldHVwLmM6MTA3
OSkNCj4+Pj4+IAkgPyBzdGFydF9rZXJuZWwgKGluaXQvbWFpbi5jOjI3OSAoZGlzY3JpbWlu
YXRvciAzKSBpbml0L21haW4uYzo0NzcgKGRpc2NyaW1pbmF0b3IgMykgaW5pdC9tYWluLmM6
OTYwIChkaXNjcmltaW5hdG9yIDMpKQ0KPj4+Pj4gCSA/IGxvYWRfdWNvZGVfYnNwIChhcmNo
L3g4Ni9rZXJuZWwvY3B1L21pY3JvY29kZS9jb3JlLmM6MTU1KQ0KPj4+Pj4gCSA/IHNlY29u
ZGFyeV9zdGFydHVwXzY0X25vX3ZlcmlmeSAoYXJjaC94ODYva2VybmVsL2hlYWRfNjQuUzoz
NTgpDQo+Pj4+PiAJICA8L1RBU0s+DQo+Pj4+Pg0KPj4+Pj4gQW55IHN1Z2dlc3Rpb24gaG93
IHRvIGZpeCBpdD8NCj4+Pj4+DQo+Pj4+PiBbMV0gU2VjdGlvbiAxMC42LjEuICJDUjAiLCBo
dHRwczovL2NkcmR2Mi5pbnRlbC5jb20vdjEvZGwvZ2V0Q29udGVudC83MzM1NjgNCj4+Pj4N
Cj4+Pj4gV2hhdCB3YXMgdGhlIHNvbHV0aW9uIGJlZm9yZT8NCj4+Pj4NCj4+Pj4gSSBndWVz
cyBNVFJSIHdhcyBkaXNhYmxlZCwgc28gdGhlcmUgd2FzIG5vIFBBVCwgdG9vPw0KPj4+DQo+
Pj4gUmlnaHQ6DQo+Pj4NCj4+PiBMaW51cycgdHJlZToNCj4+Pg0KPj4+IFsgICAgMC4wMDI1
ODldIGxhc3RfcGZuID0gMHg0ODAwMDAgbWF4X2FyY2hfcGZuID0gMHgxMDAwMDAwMDAwMA0K
Pj4+IFsgICAgMC4wMDM5NzZdIERpc2FibGVkDQo+Pj4gWyAgICAwLjAwNDQ1Ml0geDg2L1BB
VDogTVRSUnMgZGlzYWJsZWQsIHNraXBwaW5nIFBBVCBpbml0aWFsaXphdGlvbiB0b28uDQo+
Pj4gWyAgICAwLjAwNTg1Nl0gQ1BVIE1UUlJzIGFsbCBibGFuayAtIHZpcnR1YWxpemVkIHN5
c3RlbS4NCj4+PiBbICAgIDAuMDA2OTE1XSB4ODYvUEFUOiBDb25maWd1cmF0aW9uIFswLTdd
OiBXQiAgV1QgIFVDLSBVQyAgV0IgIFdUICBVQy0gVUMNCj4+Pg0KPj4+IHRpcC9tYXN0ZXI6
DQo+Pj4NCj4+PiBbICAgIDAuMDAzNDQzXSBsYXN0X3BmbiA9IDB4MjBiOGUgbWF4X2FyY2hf
cGZuID0gMHgxMDAwMDAwMDAwMA0KPj4+IFsgICAgMC4wMDUyMjBdIERpc2FibGVkDQo+Pj4g
WyAgICAwLjAwNTgxOF0geDg2L1BBVDogQ29uZmlndXJhdGlvbiBbMC03XTogV0IgIFdDICBV
Qy0gVUMgIFdCICBXUCAgVUMtIFdUDQo+Pj4gWyAgICAwLjAwNzc1Ml0gdGR4OiBVbmV4cGVj
dGVkICNWRTogMjgNCj4+Pg0KPj4+IFRoZSBkYW5nbGluZyAiRGlzYWJsZWQiIGNvbWVzIG10
cnJfYnBfaW5pdCgpLg0KPj4+DQo+Pj4NCj4+Pj4gSWYgdGhpcyBpcyB0aGUgY2FzZSwgeW91
IGNhbiBnbyB0aGUgc2FtZSByb3V0ZSBhcyBYZW4gUFYgZ3Vlc3RzIGRvLg0KPj4+DQo+Pj4g
QW55IHJlYXNvbiBYODZfRkVBVFVSRV9IWVBFUlZJU09SIGNhbm5vdCBiZSB1c2VkIGluc3Rl
YWQgb2YNCj4+PiBYODZfRkVBVFVSRV9YRU5QViB0aGVyZT8NCj4+Pg0KPj4+IERvIHdlIGhh
dmUgYW55IHZpcnR1YWxpemVkIHBsYXRmb3JtIHRoYXQgc3VwcG9ydHMgaXQ/DQo+Pg0KPj4g
WWVzLCBvZiBjb3Vyc2UuIEFueSBoYXJkd2FyZSB2aXJ0dWFsaXplZCBndWVzdCBzaG91bGQg
YmUgYWJsZSB0byB1c2UgaXQsDQo+PiBvYnZpb3VzbHkgVERYIGd1ZXN0cyBhcmUgdGhlIGZp
cnN0IG9uZXMgbm90IGJlaW5nIGFibGUgdG8gZG8gc28uDQo+Pg0KPj4gQW5kIGFib3ZlIGRt
ZXNnIHNuaXBwbGV0cyBhcmUgc2hvd2luZyByYXRoZXIgbmljZWx5IHRoYXQgbm90IGRpc2Fi
bGluZw0KPj4gUEFUIGNvbXBsZXRlbHkgc2hvdWxkIGJlIGEgYmVuZWZpdCBmb3IgVERYIGd1
ZXN0cywgYXMgYWxsIGNhY2hpbmcgbW9kZXMNCj4+IHdvdWxkIGJlIHVzYWJsZSAodGhlIFBB
VCBNU1Igc2VlbXMgdG8gYmUgaW5pdGlhbGl6ZWQgcXVpdGUgZmluZSkuDQo+Pg0KPj4gSW5z
dGVhZCBvZiBYODZfRkVBVFVSRV9YRU5QViB3ZSBjb3VsZCBpbnRyb2R1Y2Ugc29tZXRoaW5n
IGxpa2UNCj4+IFg4Nl9GRUFUVVJFX1BBVF9SRUFET05MWSwgd2hpY2ggY291bGQgYmUgc2V0
IGZvciBYZW4gUFYgZ3Vlc3RzIGFuZCBmb3INCj4+IFREWCBndWVzdHMuDQo+IA0KPiBUZWNo
bmljYWxseSwgdGhlIE1TUiBpcyB3cml0YWJsZSBvbiBURFguIEJ1dCBpdCBzZWVtcyB0aGVy
ZSdzIG5vIHdheSB0bw0KPiBwcm9wZXJseSBjaGFuZ2UgaXQsIGZvbGxvd2luZyB0aGUgcHJv
dG9jb2wgb2YgY2hhbmdpbmcgb24gTVAgc3lzdGVtcy4NCg0KV2h5IG5vdD8gSSBkb24ndCBz
ZWUgd2h5IGl0IGlzIHBvc3NpYmxlIGluIGEgbm9uLVREWCBzeXN0ZW0sIGJ1dCBub3Qgd2l0
aGluDQphIFREWCBndWVzdC4NCg0KPiBBbHRob3VnaCwgSSBkb24ndCBxdWl0ZSBmb2xsb3cg
d2hhdCByb2xlIGNhY2hlIGRpc2FibGluZyBwbGF5aW5nIG9uIHN5c3RlbQ0KPiB3aXRoIHNl
bGYtc25vb3Agc3VwcG9ydC4gSG0/DQoNCkl0IGlzIHRoZSByZWNvbW1lbmRlZCB3YXkgdG8g
ZG8gaXQuIFNlZSBTRE0gVm9sLiAzIENoYXB0ZXIgMTEgKCJNZW1vcnkgQ2FjaGUNCkNvbnRy
b2wiKToNCg0KVGhlIG9wZXJhdGluZyBzeXN0ZW0gaXMgcmVzcG9uc2libGUgZm9yIGluc3Vy
aW5nIHRoYXQgY2hhbmdlcyB0byBhIFBBVCBlbnRyeQ0Kb2NjdXIgaW4gYSBtYW5uZXIgdGhh
dCBtYWludGFpbnMgdGhlIGNvbnNpc3RlbmN5IG9mIHRoZSBwcm9jZXNzb3IgY2FjaGVzIGFu
ZA0KdHJhbnNsYXRpb24gbG9va2FzaWRlIGJ1ZmZlcnMgKFRMQikuIFRoaXMgaXMgYWNjb21w
bGlzaGVkIGJ5IGZvbGxvd2luZyB0aGUNCnByb2NlZHVyZSBhcyBzcGVjaWZpZWQgaW4gU2Vj
dGlvbiAxMS4xMS44LCDigJxNVFJSIENvbnNpZGVyYXRpb25zIGluIE1QIFN5c3RlbXMsDQri
gJ1mb3IgY2hhbmdpbmcgdGhlIHZhbHVlIG9mIGFuIE1UUlIgaW4gYSBtdWx0aXBsZSBwcm9j
ZXNzb3Igc3lzdGVtLiBJdCByZXF1aXJlcw0KYSBzcGVjaWZpYyBzZXF1ZW5jZSBvZiBvcGVy
YXRpb25zIHRoYXQgaW5jbHVkZXMgZmx1c2hpbmcgdGhlIHByb2Nlc3NvcnMgY2FjaGVzDQph
bmQgVExCcy4NCg0KQW5kIHRoZSBzZXF1ZW5jZSBmb3IgdGhlIE1UUlJzIGlzOg0KDQoxLiBC
cm9hZGNhc3QgdG8gYWxsIHByb2Nlc3NvcnMgdG8gZXhlY3V0ZSB0aGUgZm9sbG93aW5nIGNv
ZGUgc2VxdWVuY2UuDQoyLiBEaXNhYmxlIGludGVycnVwdHMuDQozLiBXYWl0IGZvciBhbGwg
cHJvY2Vzc29ycyB0byByZWFjaCB0aGlzIHBvaW50Lg0KNC4gRW50ZXIgdGhlIG5vLWZpbGwg
Y2FjaGUgbW9kZS4gKFNldCB0aGUgQ0QgZmxhZyBpbiBjb250cm9sIHJlZ2lzdGVyIENSMCB0
byAxDQogICAgYW5kIHRoZSBOVyBmbGFnIHRvIDAuKQ0KNS4gRmx1c2ggYWxsIGNhY2hlcyB1
c2luZyB0aGUgV0JJTlZEIGluc3RydWN0aW9ucy4gTm90ZSBvbiBhIHByb2Nlc3NvciB0aGF0
DQogICAgc3VwcG9ydHMgc2VsZi1zbm9vcGluZywgQ1BVSUQgZmVhdHVyZSBmbGFnIGJpdCAy
NywgdGhpcyBzdGVwIGlzIHVubmVjZXNzYXJ5Lg0KNi4gSWYgdGhlIFBHRSBmbGFnIGlzIHNl
dCBpbiBjb250cm9sIHJlZ2lzdGVyIENSNCwgZmx1c2ggYWxsIFRMQnMgYnkgY2xlYXJpbmcN
CiAgICB0aGF0IGZsYWcuDQo3LiBJZiB0aGUgUEdFIGZsYWcgaXMgY2xlYXIgaW4gY29udHJv
bCByZWdpc3RlciBDUjQsIGZsdXNoIGFsbCBUTEJzIGJ5IGV4ZWN1dGluZw0KICAgIGEgTU9W
IGZyb20gY29udHJvbCByZWdpc3RlciBDUjMgdG8gYW5vdGhlciByZWdpc3RlciBhbmQgdGhl
biBhIE1PViBmcm9tIHRoYXQNCiAgICByZWdpc3RlciBiYWNrIHRvIENSMy4NCjguIERpc2Fi
bGUgYWxsIHJhbmdlIHJlZ2lzdGVycyAoYnkgY2xlYXJpbmcgdGhlIEUgZmxhZyBpbiByZWdp
c3RlciBNVFJSZGVmVHlwZSkuDQogICAgSWYgb25seSB2YXJpYWJsZSByYW5nZXMgYXJlIGJl
aW5nIG1vZGlmaWVkLCBzb2Z0d2FyZSBtYXkgY2xlYXIgdGhlIHZhbGlkIGJpdHMNCiAgICBm
b3IgdGhlIGFmZmVjdGVkIHJlZ2lzdGVyIHBhaXJzIGluc3RlYWQuDQo5LiBVcGRhdGUgdGhl
IE1UUlJzLg0KMTAuIEVuYWJsZSBhbGwgcmFuZ2UgcmVnaXN0ZXJzIChieSBzZXR0aW5nIHRo
ZSBFIGZsYWcgaW4gcmVnaXN0ZXIgTVRSUmRlZlR5cGUpLg0KICAgICBJZiBvbmx5IHZhcmlh
YmxlLXJhbmdlIHJlZ2lzdGVycyB3ZXJlIG1vZGlmaWVkIGFuZCB0aGVpciBpbmRpdmlkdWFs
IHZhbGlkDQogICAgIGJpdHMgd2VyZSBjbGVhcmVkLCB0aGVuIHNldCB0aGUgdmFsaWQgYml0
cyBmb3IgdGhlIGFmZmVjdGVkIHJhbmdlcyBpbnN0ZWFkLg0KMTEuIEZsdXNoIGFsbCBjYWNo
ZXMgYW5kIGFsbCBUTEJzIGEgc2Vjb25kIHRpbWUuIChUaGUgVExCIGZsdXNoIGlzIHJlcXVp
cmVkIGZvcg0KICAgICBQZW50aXVtIDQsIEludGVsIFhlb24sIGFuZCBQNiBmYW1pbHkgcHJv
Y2Vzc29ycy4gRXhlY3V0aW5nIHRoZSBXQklOVkQNCiAgICAgaW5zdHJ1Y3Rpb24gaXMgbm90
IG5lZWRlZCB3aGVuIHVzaW5nIFBlbnRpdW0gNCwgSW50ZWwgWGVvbiwgYW5kIFA2IGZhbWls
eQ0KICAgICBwcm9jZXNzb3JzLCBidXQgaXQgbWF5IGJlIG5lZWRlZCBpbiBmdXR1cmUgc3lz
dGVtcy4pDQoxMi4gRW50ZXIgdGhlIG5vcm1hbCBjYWNoZSBtb2RlIHRvIHJlLWVuYWJsZSBj
YWNoaW5nLiAoU2V0IHRoZSBDRCBhbmQgTlcgZmxhZ3MNCiAgICAgaW4gY29udHJvbCByZWdp
c3RlciBDUjAgdG8gMC4pDQoxMy4gU2V0IFBHRSBmbGFnIGluIGNvbnRyb2wgcmVnaXN0ZXIg
Q1I0LCBpZiBjbGVhcmVkIGluIFN0ZXAgNiAoYWJvdmUpLg0KMTQuIFdhaXQgZm9yIGFsbCBw
cm9jZXNzb3JzIHRvIHJlYWNoIHRoaXMgcG9pbnQuDQoxNS4gRW5hYmxlIGludGVycnVwdHMu
DQoNClNvIGNhY2hlIGRpc2FibGluZyBpcyByZWNvbW1lbmRlZC4NCg0KDQpKdWVyZ2VuDQo=

--------------JZdpnW6b0Ot5vsKXw2u8LDOf
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------JZdpnW6b0Ot5vsKXw2u8LDOf--

--------------CCVp1KJZ6wUIf0SSvKkUjCE4--

--------------nUPj1uNSfJc2zDo5700NPXPS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmOKAC4FAwAAAAAACgkQsN6d1ii/Ey8Y
kwf/avbjjfhvc0Yw72FwouLLPMVUuiUlIONeVtGjAg3396hZryxeTrGG5qteHG3xiCS6MhHBwrI2
HPFNw+EdDC4PhxiilX4W5ohghAsPonRJsNYqOYn0FhAmHeVaxajVjBE882LrBRJmZe/Yh2OfytXr
f5DPoscV71D5F+JU2c3L4yGJLWjApDJ/89N5B5twbm1+QQMAHfRFH5uOo13BixKpvbU+LWR8/NiX
ymLDZDV27eyXyRsfDYpvZUA4Yc2UznpSUifH2/Wi6+hNzXst7IUFe/xyIirjeSYcsF8MeuHZiVFb
FcinK9k33myG+25cBiodocJSxMJ9LsZqkX4LL3keLw==
=sZKC
-----END PGP SIGNATURE-----

--------------nUPj1uNSfJc2zDo5700NPXPS--
