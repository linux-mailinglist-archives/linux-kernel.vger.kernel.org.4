Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28B566E233
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjAQPcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjAQPcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:32:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42B135262;
        Tue, 17 Jan 2023 07:32:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 88F086896D;
        Tue, 17 Jan 2023 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673969525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a9LZzcQ1wBQ7DCn68UxwLj36sYNRsJCxc5KjuK09bEw=;
        b=oToo5eMTgEofYlyer6Y0PW/GH7bZ2ChC82iOYxSIYa3cyfGoZRJ7E+TxMJOiM3pEZLuYIF
        I03hwgNkgU2dWl/lIzWzDmUpl8pO3g2BjlOq/iDIVNrVzv0EQGunrOo4+K32I1R8b9nya2
        bqjdII0+fqtswdis+odrOqZfaT/E8t4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E6F51390C;
        Tue, 17 Jan 2023 15:32:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K4UeBnW/xmPaTgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 17 Jan 2023 15:32:05 +0000
Message-ID: <05d451d0-ab2b-53a5-d666-529b0880b259@suse.com>
Date:   Tue, 17 Jan 2023 16:32:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
References: <20230113140610.7132-1-jgross@suse.com>
 <CAJZ5v0gP_NUeQimn21tJuUjpMAOW_wFrRe4jstN13So_4_T4QQ@mail.gmail.com>
 <e5cc2f96-82bc-a0dc-21fa-2f605bc867d1@suse.com>
 <CAJZ5v0ggSbR7+RiXuJo4aq+PYWS-eb9R2iSr0DFfVhcaJ1bfUQ@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/acpi: fix suspend with Xen
In-Reply-To: <CAJZ5v0ggSbR7+RiXuJo4aq+PYWS-eb9R2iSr0DFfVhcaJ1bfUQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pQ03Tt00E1mOWOXtVZrZRoHz"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pQ03Tt00E1mOWOXtVZrZRoHz
Content-Type: multipart/mixed; boundary="------------hO6119jhcG5jS1kjYpjos0iV";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= <marmarek@invisiblethingslab.com>
Message-ID: <05d451d0-ab2b-53a5-d666-529b0880b259@suse.com>
Subject: Re: [PATCH] x86/acpi: fix suspend with Xen
References: <20230113140610.7132-1-jgross@suse.com>
 <CAJZ5v0gP_NUeQimn21tJuUjpMAOW_wFrRe4jstN13So_4_T4QQ@mail.gmail.com>
 <e5cc2f96-82bc-a0dc-21fa-2f605bc867d1@suse.com>
 <CAJZ5v0ggSbR7+RiXuJo4aq+PYWS-eb9R2iSr0DFfVhcaJ1bfUQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0ggSbR7+RiXuJo4aq+PYWS-eb9R2iSr0DFfVhcaJ1bfUQ@mail.gmail.com>

--------------hO6119jhcG5jS1kjYpjos0iV
Content-Type: multipart/mixed; boundary="------------ts1PE2ihPsdh0koBqvijVVKl"

--------------ts1PE2ihPsdh0koBqvijVVKl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDEuMjMgMTU6MDksIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiBPbiBNb24s
IEphbiAxNiwgMjAyMyBhdCA3OjQ1IEFNIEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNv
bT4gd3JvdGU6DQo+Pg0KPj4gT24gMTMuMDEuMjMgMjA6NDAsIFJhZmFlbCBKLiBXeXNvY2tp
IHdyb3RlOg0KPj4+IE9uIEZyaSwgSmFuIDEzLCAyMDIzIGF0IDM6MDYgUE0gSnVlcmdlbiBH
cm9zcyA8amdyb3NzQHN1c2UuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gQ29tbWl0IGYxZTUy
NTAwOTQ5MyAoIng4Ni9ib290OiBTa2lwIHJlYWxtb2RlIGluaXQgY29kZSB3aGVuIHJ1bm5p
bmcgYXMNCj4+Pj4gWGVuIFBWIGd1ZXN0IikgbWlzc2VkIG9uZSBjb2RlIHBhdGggYWNjZXNz
aW5nIHJlYWxfbW9kZV9oZWFkZXIsIGxlYWRpbmcNCj4+Pj4gdG8gZGVyZWZlcmVuY2luZyBO
VUxMIHdoZW4gc3VzcGVuZGluZyB0aGUgc3lzdGVtIHVuZGVyIFhlbjoNCj4+Pj4NCj4+Pj4g
ICAgICAgWyAgMzQ4LjI4NDAwNF0gUE06IHN1c3BlbmQgZW50cnkgKGRlZXApDQo+Pj4+ICAg
ICAgIFsgIDM0OC4yODk1MzJdIEZpbGVzeXN0ZW1zIHN5bmM6IDAuMDA1IHNlY29uZHMNCj4+
Pj4gICAgICAgWyAgMzQ4LjI5MTU0NV0gRnJlZXppbmcgdXNlciBzcGFjZSBwcm9jZXNzZXMg
Li4uIChlbGFwc2VkIDAuMDAwIHNlY29uZHMpIGRvbmUuDQo+Pj4+ICAgICAgIFsgIDM0OC4y
OTI0NTddIE9PTSBraWxsZXIgZGlzYWJsZWQuDQo+Pj4+ICAgICAgIFsgIDM0OC4yOTI0NjJd
IEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MgLi4uIChlbGFwc2VkIDAuMTA0
IHNlY29uZHMpIGRvbmUuDQo+Pj4+ICAgICAgIFsgIDM0OC4zOTY2MTJdIHByaW50azogU3Vz
cGVuZGluZyBjb25zb2xlKHMpICh1c2Ugbm9fY29uc29sZV9zdXNwZW5kIHRvIGRlYnVnKQ0K
Pj4+PiAgICAgICBbICAzNDguNzQ5MjI4XSBQTTogc3VzcGVuZCBkZXZpY2VzIHRvb2sgMC4z
NTIgc2Vjb25kcw0KPj4+PiAgICAgICBbICAzNDguNzY5NzEzXSBBQ1BJOiBFQzogaW50ZXJy
dXB0IGJsb2NrZWQNCj4+Pj4gICAgICAgWyAgMzQ4LjgxNjA3N10gQlVHOiBrZXJuZWwgTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDFjDQo+Pj4+
ICAgICAgIFsgIDM0OC44MTYwODBdICNQRjogc3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBr
ZXJuZWwgbW9kZQ0KPj4+PiAgICAgICBbICAzNDguODE2MDgxXSAjUEY6IGVycm9yX2NvZGUo
MHgwMDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UNCj4+Pj4gICAgICAgWyAgMzQ4LjgxNjA4M10g
UEdEIDAgUDREIDANCj4+Pj4gICAgICAgWyAgMzQ4LjgxNjA4Nl0gT29wczogMDAwMCBbIzFd
IFBSRUVNUFQgU01QIE5PUFRJDQo+Pj4+ICAgICAgIFsgIDM0OC44MTYwODldIENQVTogMCBQ
SUQ6IDY3NjQgQ29tbTogc3lzdGVtZC1zbGVlcCBOb3QgdGFpbnRlZCA2LjEuMy0xLmZjMzIu
cXViZXMueDg2XzY0ICMxDQo+Pj4+ICAgICAgIFsgIDM0OC44MTYwOTJdIEhhcmR3YXJlIG5h
bWU6IFN0YXIgTGFicyBTdGFyQm9vay9TdGFyQm9vaywgQklPUyA4LjAxIDA3LzAzLzIwMjIN
Cj4+Pj4gICAgICAgWyAgMzQ4LjgxNjA5M10gUklQOiBlMDMwOmFjcGlfZ2V0X3dha2V1cF9h
ZGRyZXNzKzB4Yy8weDIwDQo+Pj4+DQo+Pj4+IEZpeCB0aGF0IGJ5IGFkZGluZyBhbiBpbmRp
cmVjdGlvbiBmb3IgYWNwaV9nZXRfd2FrZXVwX2FkZHJlc3MoKSB3aGljaA0KPj4+PiBYZW4g
UFYgZG9tMCBjYW4gdXNlIHRvIHJldHVybiBhIGR1bW15IG5vbi16ZXJvIHdha2V1cCBhZGRy
ZXNzICh0aGlzDQo+Pj4+IGFkZHJlc3Mgd29uJ3QgZXZlciBiZSB1c2VkLCBhcyB0aGUgcmVh
bCBzdXNwZW5kIGhhbmRsaW5nIGlzIGRvbmUgYnkgdGhlDQo+Pj4+IGh5cGVydmlzb3IpLg0K
Pj4+DQo+Pj4gSG93IGV4YWN0bHkgZG9lcyB0aGlzIGhlbHA/DQo+Pg0KPj4gSSBiZWxpZXZl
ZCB0aGUgZmlyc3Qgc2VudGVuY2Ugb2YgdGhlIGNvbW1pdCBtZXNzYWdlIHdvdWxkIG1ha2Ug
dGhpcw0KPj4gY2xlYXIgZW5vdWdoLg0KPiANCj4gVGhhdCB3YXMgY2xlYXIsIGJ1dCB0aGUg
Zml4IHBhcnQgd2Fzbid0IHJlYWxseS4NCj4gDQo+PiBJIGNhbiBleHBhbmQgdGhlIGNvbW1p
dCBtZXNzYWdlIHRvIGdvIG1vcmUgaW50byBkZXRhaWwgaWYgeW91IHRoaW5rDQo+PiB0aGlz
IGlzIHJlYWxseSBuZWVkZWQuDQo+IA0KPiBJTU8gY2FsbGluZyBhY3BpX3NldF93YWtpbmdf
dmVjdG9yKCkgd2l0aCBhIGtub3duLWludmFsaWQgd2FrZXVwDQo+IHZlY3RvciBhZGRyZXNz
IGluIGRvbTAgaXMgcGxhaW4gY29uZnVzaW5nLg0KPiANCj4gSSdtIG5vdCBzdXJlIHdoYXQg
dG8gZG8gYWJvdXQgaXQgeWV0LCBidXQgSU1WIHNvbWV0aGluZyBuZWVkcyB0byBiZSBkb25l
Lg0KDQpBbm90aGVyIHBvc3NpYmlsaXR5IHdvdWxkIGJlIHRvIG1vZGlmeSBhY3BpX3NsZWVw
X3ByZXBhcmUoKSwgZS5nLiBsaWtlIHRoZQ0KYXR0YWNoZWQgcGF0Y2ggKGNvbXBpbGUgdGVz
dGVkIG9ubHkpLg0KDQoNCkp1ZXJnZW4NCg==
--------------ts1PE2ihPsdh0koBqvijVVKl
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-acpi-fix-suspend-with-Xen-PV.patch"
Content-Disposition: attachment;
 filename="0001-acpi-fix-suspend-with-Xen-PV.patch"
Content-Transfer-Encoding: base64

RnJvbSA1YTJkZTcyNTBjNGU4NzgyZWQ4OWM3ODk4MDYxODE1MDU4ZmEyNzEwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
CkRhdGU6IFR1ZSwgMTcgSmFuIDIwMjMgMTY6MjA6MDQgKzAxMDAKU3ViamVjdDogW1BBVENI
XSBhY3BpOiBmaXggc3VzcGVuZCB3aXRoIFhlbiBQVgpNSU1FLVZlcnNpb246IDEuMApDb250
ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1F
bmNvZGluZzogOGJpdAoKQ29tbWl0IGYxZTUyNTAwOTQ5MyAoIng4Ni9ib290OiBTa2lwIHJl
YWxtb2RlIGluaXQgY29kZSB3aGVuIHJ1bm5pbmcgYXMKWGVuIFBWIGd1ZXN0IikgbWlzc2Vk
IG9uZSBjb2RlIHBhdGggYWNjZXNzaW5nIHJlYWxfbW9kZV9oZWFkZXIsIGxlYWRpbmcKdG8g
ZGVyZWZlcmVuY2luZyBOVUxMIHdoZW4gc3VzcGVuZGluZyB0aGUgc3lzdGVtIHVuZGVyIFhl
bjoKCiAgICBbICAzNDguMjg0MDA0XSBQTTogc3VzcGVuZCBlbnRyeSAoZGVlcCkKICAgIFsg
IDM0OC4yODk1MzJdIEZpbGVzeXN0ZW1zIHN5bmM6IDAuMDA1IHNlY29uZHMKICAgIFsgIDM0
OC4yOTE1NDVdIEZyZWV6aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzIC4uLiAoZWxhcHNlZCAw
LjAwMCBzZWNvbmRzKSBkb25lLgogICAgWyAgMzQ4LjI5MjQ1N10gT09NIGtpbGxlciBkaXNh
YmxlZC4KICAgIFsgIDM0OC4yOTI0NjJdIEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUg
dGFza3MgLi4uIChlbGFwc2VkIDAuMTA0IHNlY29uZHMpIGRvbmUuCiAgICBbICAzNDguMzk2
NjEyXSBwcmludGs6IFN1c3BlbmRpbmcgY29uc29sZShzKSAodXNlIG5vX2NvbnNvbGVfc3Vz
cGVuZCB0byBkZWJ1ZykKICAgIFsgIDM0OC43NDkyMjhdIFBNOiBzdXNwZW5kIGRldmljZXMg
dG9vayAwLjM1MiBzZWNvbmRzCiAgICBbICAzNDguNzY5NzEzXSBBQ1BJOiBFQzogaW50ZXJy
dXB0IGJsb2NrZWQKICAgIFsgIDM0OC44MTYwNzddIEJVRzoga2VybmVsIE5VTEwgcG9pbnRl
ciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDAxYwogICAgWyAgMzQ4Ljgx
NjA4MF0gI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlCiAgICBb
ICAzNDguODE2MDgxXSAjUEY6IGVycm9yX2NvZGUoMHgwMDAwKSAtIG5vdC1wcmVzZW50IHBh
Z2UKICAgIFsgIDM0OC44MTYwODNdIFBHRCAwIFA0RCAwCiAgICBbICAzNDguODE2MDg2XSBP
b3BzOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgTk9QVEkKICAgIFsgIDM0OC44MTYwODldIENQ
VTogMCBQSUQ6IDY3NjQgQ29tbTogc3lzdGVtZC1zbGVlcCBOb3QgdGFpbnRlZCA2LjEuMy0x
LmZjMzIucXViZXMueDg2XzY0ICMxCiAgICBbICAzNDguODE2MDkyXSBIYXJkd2FyZSBuYW1l
OiBTdGFyIExhYnMgU3RhckJvb2svU3RhckJvb2ssIEJJT1MgOC4wMSAwNy8wMy8yMDIyCiAg
ICBbICAzNDguODE2MDkzXSBSSVA6IGUwMzA6YWNwaV9nZXRfd2FrZXVwX2FkZHJlc3MrMHhj
LzB4MjAKCkZpeCB0aGF0IGJ5IGFkZGluZyBhbiBvcHRpb25hbCBhY3BpIGNhbGxiYWNrIGFs
bG93aW5nIHRvIHNraXAgc2V0dGluZwp0aGUgd2FrZXVwIGFkZHJlc3MsIGFzIGluIHRoZSBY
ZW4gUFYgY2FzZSB0aGlzIHdpbGwgYmUgaGFuZGxlZCBieSB0aGUKaHlwZXJ2aXNvciBhbnl3
YXkuCgpGaXhlczogZjFlNTI1MDA5NDkzICgieDg2L2Jvb3Q6IFNraXAgcmVhbG1vZGUgaW5p
dCBjb2RlIHdoZW4gcnVubmluZyBhcyBYZW4gUFYgZ3Vlc3QiKQpSZXBvcnRlZC1ieTogTWFy
ZWsgTWFyY3p5a293c2tpLUfDs3JlY2tpIDxtYXJtYXJla0BpbnZpc2libGV0aGluZ3NsYWIu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+Ci0t
LQogYXJjaC94ODYvaW5jbHVkZS9hc20vYWNwaS5oIHwgOCArKysrKysrKwogZHJpdmVycy9h
Y3BpL3NsZWVwLmMgICAgICAgIHwgNiArKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL2FjcGkuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2FjcGkuaAppbmRleCA2NTA2
NGQ5ZjdmYTYuLjhlYjc0Y2YzODZkYiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9h
c20vYWNwaS5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2FjcGkuaApAQCAtMTQsNiAr
MTQsNyBAQAogI2luY2x1ZGUgPGFzbS9tbXUuaD4KICNpbmNsdWRlIDxhc20vbXBzcGVjLmg+
CiAjaW5jbHVkZSA8YXNtL3g4Nl9pbml0Lmg+CisjaW5jbHVkZSA8YXNtL2NwdWZlYXR1cmUu
aD4KIAogI2lmZGVmIENPTkZJR19BQ1BJX0FQRUkKICMgaW5jbHVkZSA8YXNtL3BndGFibGVf
dHlwZXMuaD4KQEAgLTYzLDYgKzY0LDEzIEBAIGV4dGVybiBpbnQgKCphY3BpX3N1c3BlbmRf
bG93bGV2ZWwpKHZvaWQpOwogLyogUGh5c2ljYWwgYWRkcmVzcyB0byByZXN1bWUgYWZ0ZXIg
d2FrZXVwICovCiB1bnNpZ25lZCBsb25nIGFjcGlfZ2V0X3dha2V1cF9hZGRyZXNzKHZvaWQp
OwogCitzdGF0aWMgaW5saW5lIGJvb2wgYWNwaV9za2lwX3NldF93YWtldXBfYWRkcmVzcyh2
b2lkKQoreworCXJldHVybiBjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1hFTlBW
KTsKK30KKworI2RlZmluZSBhY3BpX3NraXBfc2V0X3dha2V1cF9hZGRyZXNzIGFjcGlfc2tp
cF9zZXRfd2FrZXVwX2FkZHJlc3MKKwogLyoKICAqIENoZWNrIGlmIHRoZSBDUFUgY2FuIGhh
bmRsZSBDMiBhbmQgZGVlcGVyCiAgKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9zbGVl
cC5jIGIvZHJpdmVycy9hY3BpL3NsZWVwLmMKaW5kZXggMGI1NTdjMGQ0MDVlLi40Y2E2Njcy
NTEyNzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS9zbGVlcC5jCisrKyBiL2RyaXZlcnMv
YWNwaS9zbGVlcC5jCkBAIC02MCwxMyArNjAsMTcgQEAgc3RhdGljIHN0cnVjdCBub3RpZmll
cl9ibG9jayB0dHNfbm90aWZpZXIgPSB7CiAJLnByaW9yaXR5CT0gMCwKIH07CiAKKyNpZm5k
ZWYgYWNwaV9za2lwX3NldF93YWtldXBfYWRkcmVzcworI2RlZmluZSBhY3BpX3NraXBfc2V0
X3dha2V1cF9hZGRyZXNzKCkgZmFsc2UKKyNlbmRpZgorCiBzdGF0aWMgaW50IGFjcGlfc2xl
ZXBfcHJlcGFyZSh1MzIgYWNwaV9zdGF0ZSkKIHsKICNpZmRlZiBDT05GSUdfQUNQSV9TTEVF
UAogCXVuc2lnbmVkIGxvbmcgYWNwaV93YWtldXBfYWRkcmVzczsKIAogCS8qIGRvIHdlIGhh
dmUgYSB3YWtldXAgYWRkcmVzcyBmb3IgUzIgYW5kIFMzPyAqLwotCWlmIChhY3BpX3N0YXRl
ID09IEFDUElfU1RBVEVfUzMpIHsKKwlpZiAoYWNwaV9zdGF0ZSA9PSBBQ1BJX1NUQVRFX1Mz
ICYmICFhY3BpX3NraXBfc2V0X3dha2V1cF9hZGRyZXNzKCkpIHsKIAkJYWNwaV93YWtldXBf
YWRkcmVzcyA9IGFjcGlfZ2V0X3dha2V1cF9hZGRyZXNzKCk7CiAJCWlmICghYWNwaV93YWtl
dXBfYWRkcmVzcykKIAkJCXJldHVybiAtRUZBVUxUOwotLSAKMi4zNS4zCgo=
--------------ts1PE2ihPsdh0koBqvijVVKl
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------ts1PE2ihPsdh0koBqvijVVKl--

--------------hO6119jhcG5jS1kjYpjos0iV--

--------------pQ03Tt00E1mOWOXtVZrZRoHz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPGv3QFAwAAAAAACgkQsN6d1ii/Ey/t
pQf9HeeMJXbkh42aotcK+nPu2x0SigRqr7VfWbrHxxTP6gHTMjFt1xW8k9aqIIqiXxeVdaye+exK
wyODG2Wrnqgr1EWBD+TP+rqrDz7mBb1M0RaqD6cw2MWoaLWCqBhLgXX+SmWzfqboUYYjzgjZhgh2
MscSViGCeIMPVudT329DXzXnjG/F3bEnhnlKpUWpyP4gSnJUkMfqJSSFIUoUiLcu5Y0iO9smzmnx
1m7UvCWA4WZvBdoIa4orQOMbRsMRLZO6gC7fiuw4jRuEZvTMrSZsWIdtWDxZjPksF97iZptWvsd9
McjuvE9enebbW+Kq+2sK/d6hrLfv1etpRu7JzHRBFQ==
=pclZ
-----END PGP SIGNATURE-----

--------------pQ03Tt00E1mOWOXtVZrZRoHz--
