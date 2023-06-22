Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AE27396CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjFVFW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjFVFW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:22:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBF6135
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:22:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F0592278A;
        Thu, 22 Jun 2023 05:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687411375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7oFg/oYyAIplKu/dLMHi2+rFZpdPpCxpAB8nl5OU3Jk=;
        b=k9PYmy3Koexfwi0bOkFkBMSsYQLK96W7GOqxCuUTGP3IMWfMgMUGkGIK7T+MWBWJaPubi8
        IyAF/gubA3KRvqZ8uYrQ+bCdNjDkEwre3fsN4x4H5Pkbc4eiLpew/tneTh5JxWfWxS9bdo
        UIiRxS4Z8f1RzZZBe0rhtLb/p0E82r4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 758351346D;
        Thu, 22 Jun 2023 05:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wwvCGq7ak2QvOAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 22 Jun 2023 05:22:54 +0000
Message-ID: <a8cd2788-a695-964a-3311-dbecb669bb72@suse.com>
Date:   Thu, 22 Jun 2023 07:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Per Bilse <Per.Bilse@citrix.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "open list:X86 ENTRY CODE" <linux-kernel@vger.kernel.org>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
References: <20230621151442.2152425-1-per.bilse@citrix.com>
 <20230621164038.GM2053369@hirez.programming.kicks-ass.net>
 <6523f3e2-8dfc-c2dd-6d14-9e0c3ac93cc8@citrix.com>
 <20230621200409.GC4253@hirez.programming.kicks-ass.net>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] Updates to Xen hypercall preemption
In-Reply-To: <20230621200409.GC4253@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oecT0HYsRhwt2FFO05EITBNU"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------oecT0HYsRhwt2FFO05EITBNU
Content-Type: multipart/mixed; boundary="------------oqu74iZ2pULV0PqV8grkLn3Y";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>, Per Bilse <Per.Bilse@citrix.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "open list:X86 ENTRY CODE" <linux-kernel@vger.kernel.org>,
 "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Message-ID: <a8cd2788-a695-964a-3311-dbecb669bb72@suse.com>
Subject: Re: [PATCH] Updates to Xen hypercall preemption
References: <20230621151442.2152425-1-per.bilse@citrix.com>
 <20230621164038.GM2053369@hirez.programming.kicks-ass.net>
 <6523f3e2-8dfc-c2dd-6d14-9e0c3ac93cc8@citrix.com>
 <20230621200409.GC4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230621200409.GC4253@hirez.programming.kicks-ass.net>

--------------oqu74iZ2pULV0PqV8grkLn3Y
Content-Type: multipart/mixed; boundary="------------3gp31eH3eMANbxQoI20vnwCw"

--------------3gp31eH3eMANbxQoI20vnwCw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjEuMDYuMjMgMjI6MDQsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBXZWQsIEp1
biAyMSwgMjAyMyBhdCAwNzoxOToyMVBNICswMDAwLCBQZXIgQmlsc2Ugd3JvdGU6DQo+PiBP
biA2LzIxLzIwMjMgNTo0MCBQTSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+Pj4gSSBkb24n
dCB1bmRlcnN0YW5kIGl0IC0tIGZ1bmRhbWVudGFsbHksIGhvdyBjYW4gbGludXggc2NoZWR1
bGUgd2hlbiB0aGUNCj4+PiBndWVzdCBpc24ndCBldmVuIHJ1bm5pbmc/IEh5cGVyY2FsbCB0
cmFuc2ZlcnMgY29udHJvbCB0byB0aGUNCj4+PiBob3N0L2h5cGVydmlzb3IgYW5kIGxlYXZl
cyB0aGUgZ3Vlc3Qgc3VzcGVuZGVkLg0KPj4NCj4+IEhpIFBldGVyLCBhcyBub3RlZCBpbiBl
YXJsaWVyIG5vdGUgdG8gQW5keSwgdGhpcyBpcyBlc3NlbnRpYWxseSBleGlzdGluZw0KPj4g
Y29kZSB0aGF0IG90aGVyIGNvbW1pdHMgaGF2ZSByZW5kZXJlZCBpbmVmZmVjdGl2ZSBvdmVy
IHRpbWUuICBIZW5jZSwNCj4+IHRoZSBmaW5lciBkZXRhaWxzIG9mIGhvdyBvciB3aHkgaXQg
d29ya3MgaGF2ZW4ndCBjaGFuZ2VkIHNpbmNlIGl0IHdhcw0KPj4gZmlyc3QgaW50cm9kdWNl
ZC4NCj4gDQo+IFRoYXQgZG9lc24ndCBtZWFuIHlvdSBkb24ndCBoYXZlIHRvIGV4cGxhaW4g
aG93IHN0dWZmIHdvcmtzLg0KPiANCj4+PiBUaGlzIG1ha2VzIG5vIHNlbnNlOyB0aGUgcmFj
ZSB0aGF0IHdhcm5pbmcgd2FybnMgYWJvdXQgaXM6DQo+Pj4NCj4+PiAJQ1BVMAkJCUNQVTEN
Cj4+PiAJcGVyLWNwdSB3cml0ZQ0KPj4+IAk8cHJlZW1wdC1vdXQ+DQo+Pj4gCQkJCTxwcmVl
bXB0LWluPg0KPj4+IAkJCQlkby1oeXBlcmNhbGwNCj4+Pg0KPj4+IFNvIHlvdSB3cm90ZSB0
aGUgdmFsdWUgb24gQ1BVMCwgZ290IG1pZ3JhdGVkIHRvIENQVTEgYmVjYXVzZSB5b3UgaGFk
DQo+Pj4gcHJlZW1wdGlvbmVkIGVuYWJsZWQsIGFuZCB0aGVuIGNvbnRpbnVlIHdpdGggdGhl
IHBlcmNwdSB2YWx1ZSBvZiBDUFUxDQo+Pj4gYmVjYXVzZSB0aGF0J3Mgd2hlcmUgeW91J3Jl
IGF0IG5vdy4NCj4+DQo+PiBUaGlzIGlzc3VlIHdhcyByYWlzZWQgaW50ZXJuYWxseSwgYW5k
IGl0IHdhcyBub3RlZCB0aGF0IHRoZSBvbmx5IHdheQ0KPj4gZm9yIHRoZSBwcmVlbXB0aWJs
ZSBjb2RlIHRvIHN3aXRjaCB0YXNrIGlzIHZpYSBhbiBpbnRlcnJ1cHQgdGhhdCBnb2VzDQo+
PiB0aHJvdWdoIHhlbl9wdl9ldnRjaG5fZG9fdXBjYWxsKCksIHdoaWNoIGhhbmRsZXMgdGhp
cy4gIEknbSBoYXBweSB0bw0KPj4gY2hlY2sgd2l0aCBteSBzb3VyY2VzLCBidXQgaXQncyBo
b2xpZGF5IHNlYXNvbiByaWdodCBub3cuDQo+IA0KPiBUaGVuIGl0IHNob3VsZCBoYXZlIGFs
bCBzb3J0cyBvZiBjb21tZW50cyBvbiBhbmQgYSBjb21wcmVoZW5zaXZlDQo+IGNoYW5nZWxv
Zy4NCj4gDQo+Pj4+IDQpIFVwZGF0ZSBpcnFlbnRyeV9leGl0X2NvbmRfcmVzY2hlZCgpIHRv
IHJhd19pcnFlbnRyeV9leGl0X2NvbmRfcmVzY2hlZCgpLg0KPj4+PiBUaGUgY29kZSB3aWxs
IGNhbGwgaXJxZW50cnlfZXhpdF9jb25kX3Jlc2NoZWQoKSBpZiB0aGUgZmxhZyAoYXMgbm90
ZWQNCj4+Pj4gYWJvdmUpIGlzIHNldCwgYnV0IHRoZSBkeW5hbWljIHByZWVtcHRpb24gZmVh
dHVyZSB3aWxsIGxpdmVwYXRjaCB0aGF0DQo+Pj4+IGZ1bmN0aW9uIHRvIGEgbm8tb3AgdW5s
ZXNzIGZ1bGwgcHJlZW1wdGlvbiBpcyBzZWxlY3RlZC4gIFRoZSBjb2RlIGlzDQo+Pj4+IHRo
ZXJlZm9yZSB1cGRhdGVkIHRvIGNhbGwgcmF3X2lycWVudHJ5X2V4aXRfY29uZF9yZXNjaGVk
KCkuDQo+Pj4NCj4+PiBUaGF0LCBhZ2FpbiBtZWVkcyBtb3JlIGV4cGxhbmF0aW9uLiBXaHkg
ZG8geW91IHdhbnQgdGhpcyBpZiBub3QNCj4+PiBwcmVlbXB0aWJsZT8NCj4+DQo+PiBJJ20g
bm90IHF1aXRlIHN1cmUgd2hhdCB5b3UgbWVhbiBoZXJlLiAgRHluYW1pYyBwcmVlbXB0aW9u
DQo+PiB3aWxsIGxpdmVwYXRjaCBpcnFlbnRyeV9leGl0X2NvbmRfcmVzY2hlZCgpIHRvIGJl
IGEgbm8tb3AsIHdoaWxlDQo+PiByYXdfaXJxZW50cnlfZXhpdF9jb25kX3Jlc2NoZWQoKSBy
ZW1haW5zIGZ1bmN0aW9uYWwuICBUaGlzIHdhcw0KPj4gaW50cm9kdWNlZCBpbiBjb21taXQg
NDYyNGExNGY0ZGFhIGxhc3QgeWVhciB3aGljaCB3YXMgc2FpZCB0byBmaXgNCj4+IHRoZSBw
cm9ibGVtLCBidXQgZG9lc24ndC4gIFlvdSBtYXkgcmVtZW1iZXIsIGl0IHdhcyBzaWduZWQg
b2ZmIGJ5DQo+PiB5b3Vyc2VsZiBhbmQgTWFyayBSdXRsYW5kLg0KPiANCj4gSSBkb24ndCBz
ZWUgdGhlIHJlbGF0aW9uOyB3aGF0IHlvdSdyZSBkb2luZyBpcyBtYWtpbmcgZHluYW1pYyBw
cmVlbXB0DQo+IHRoYXQncyBub3QgY29uZmlndXJlZCBmb3IgZnVsbCBwcmVlbXB0IGRvIHBy
ZWVtcHRpb24uIFRoYXQncyB3ZWlyZCwgYW5kDQo+IGFnYWluIG5vIGNvbW1lbnRzLg0KPiAN
Cj4gSSdtIHdpdGggQW5keSBpbiB0aGF0IHNpbXBseSBmb3JjaW5nIGZ1bGwgcHJlZW1wdGlv
biB3b3VsZCBtYWtlIGZhciBtb3JlDQo+IHNlbnNlIC0tIGJ1dCBJJ20gc3RpbGwgbWlzc2lu
ZyBzb21ldGhpbmcgZnVuZGFtZW50YWwsIHNlZSBiZWxvdy4NCj4gDQo+Pj4gWW91J3JlIGRv
aW5nIDQgdGhpbmdzLCB0aGF0IHNob3VsZCBiZSA0IHBhdGNoZXMuIEFsc28sIHBsZWFzZSBn
aXZlIG1vcmUNCj4+PiBjbHVlcyBmb3IgaG93IHRoaXMgaXMgc3VwcG9zZWQgdG8gd29yayBh
dCBhbGwuDQo+Pg0KPj4gSSByZXNwZWN0ZnVsbHkgaGF2ZSB0byBkaXNhZ3JlZSB3aXRoIHRo
YXQuICBUaGUgZml4ZXMgaGVyZSBhcmUgdmVyeQ0KPj4gY2xvc2VseSByZWxhdGVkLCBhbmQg
d2UncmUgbm90IGludHJvZHVjaW5nIGFueXRoaW5nIG5ldywgd2UncmUgbWVyZWx5DQo+PiBy
ZS1lbmFibGluZyBjb2RlIHdoaWNoIGhhcyBiZWVuIHJlbmRlcmVkIGluZWZmZWN0aXZlIGR1
ZSB0byBvdmVyc2lnaHRzDQo+PiBpbiBjb21taXRzIG1hZGUgYWZ0ZXIgdGhlIGNvZGUgd2Fz
IGZpcnN0IGludHJvZHVjZWQuICBIb3cgdGhlIGNvZGUgaXMNCj4+IHN1cHBvc2VkIHRvIHdv
cmsgaGFzbid0IGNoYW5nZWQsIGFuZCBpcyBiZXlvbmQgdGhlIHNjb3BlIG9mIHRoZXNlIGZp
eGVzOw0KPj4gSSdtIHN1cmUgaXQgbXVzdCBoYXZlIGJlZW4gZGlzY3Vzc2VkIGF0IGdyZWF0
IGxlbmd0aCBhdCB0aGUgdGltZSAoY29tbWl0DQo+PiBmZGZkODExZGRkZTMpLg0KPiANCj4g
WW91IGRpZG4ndCBldmVuIHNvIG11Y2ggYXMgcmVmZXJlbmNlIHRoYXQgY29tbWl0LCBub3Ig
cHJvdmlkZSBhbnkgb3RoZXINCj4gZXhwbGFuYXRpb24uIEFuZCBoYXZpbmcgbm93IHJlYWQg
dGhhdCBjb21taXQsIEknbSBub3QgbXVjaCBlbmxpZ2h0ZW5kLg0KPiANCj4gKkhPVyogY2Fu
IGEgaHlwZXJjYWxsLCBzb21ldGhpbmcgdGhhdCBleGl0cyB0aGUgR3Vlc3QgYW5kIGhhcyB0
aGUNCj4gSG9zdC9IeXBlcnZpc29yIHJ1biBnZXQgcHJlZW1wdGVkIGluIHRoZSBHdWVzdCAt
LSB0aGF0IGlzbid0IHJ1bm5pbmcuDQo+IA0KPiBPciBhcmUgeW91IGNhbGxpbmcgYXBwbGVz
IHBlYXJzPw0KDQpUaGUgaHlwZXJjYWxscyB3ZSBhcmUgdGFsa2luZyBvZiBhcmUgc3luY2hy
b25vdXMgb25lcy4gVGhleSBhcmUgcnVubmluZw0KaW4gdGhlIGNvbnRleHQgb2YgdGhlIHZj
cHUgZG9pbmcgdGhlIGNhbGwgKGxpa2UgYSBzeXNjYWxsIGZyb20gdXNlcmxhbmQgaXMNCnJ1
bm5pbmcgaW4gdGhlIHByb2Nlc3MgY29udGV4dCkuDQoNClRoZSBoeXBlcnZpc29yIHdpbGwg
cmV0dXJuIHRvIGd1ZXN0IGNvbnRleHQgZnJvbSB0aW1lIHRvIHRpbWUgYnkgbW9kaWZ5aW5n
DQp0aGUgcmVnaXN0ZXJzIHN1Y2ggdGhhdCB0aGUgZ3Vlc3Qgd2lsbCBkbyB0aGUgaHlwZXJj
YWxsIGFnYWluIHdpdGggZGlmZmVyZW50DQppbnB1dCB2YWx1ZXMgZm9yIHRoZSBoeXBlcnZp
c29yLCByZXN1bHRpbmcgaW4gYSBwcm9wZXIgY29udGludWF0aW9uIG9mIHRoZQ0KaHlwZXJj
YWxsIHByb2Nlc3NpbmcuDQoNCkl0IGlzIGFuIGF3ZnVsIGludGVyZmFjZSBhbmQgSSBhZ3Jl
ZSB0aGF0IHN3aXRjaGluZyB0byBmdWxsIHByZWVtcHRpb24gaW4NCmRvbTAgc2VlbXMgdG8g
YmUgdGhlIHJvdXRlIHdoaWNoIHdlIHNob3VsZCB0cnkgdG8gdGFrZS4gVGhlIGRvd25zaWRl
IHdvdWxkDQpiZSB0aGF0IHNvbWUgd29ya2xvYWRzIG1pZ2h0IHNlZSB3b3JzZSBwZXJmb3Jt
YW5jZSBkdWUgdG8gYmFja2VuZCBJL08NCmhhbmRsaW5nIG1pZ2h0IGdldCBwcmVlbXB0ZWQu
DQoNCkp1c3QgdGhpbmtpbmcgLSBjYW4gZnVsbCBwcmVlbXB0aW9uIGJlIGVuYWJsZWQgcGVy
IHByb2Nlc3M/DQoNCg0KSnVlcmdlbg0K
--------------3gp31eH3eMANbxQoI20vnwCw
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------3gp31eH3eMANbxQoI20vnwCw--

--------------oqu74iZ2pULV0PqV8grkLn3Y--

--------------oecT0HYsRhwt2FFO05EITBNU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmST2q4FAwAAAAAACgkQsN6d1ii/Ey/A
JQf/ePzalWyngzTPEu55x8mVEDQtNwP94zQn5HO0JG9LRXt10cZp/7DL6n+TXPFRIdt3BKp5u9jE
eyFV7bnui61LRR0SHmy12FhFfiKHCD43zaiHys6/L+cnkoV8wqLDZlC5GAUol6OT5auQ4+fD6NZ6
QVIrlpCQ54Eok9LkOpVXqe/3oA6/YOJx/92YpGp/YYi1yhy7v6F9NrT4Pb0fgAbT/xuP1kyBg6AE
STsrSS1kIRj3UXFJpB9zMbHvrGqc+JKJQhshiuoNNN8fNI5efozHlb2xKP5E2NuqMdpOmDxf5tJK
oZuRbmBPmYTFUbPmxoKVWAgCGHLnP/83ax7BjlhceQ==
=56Y0
-----END PGP SIGNATURE-----

--------------oecT0HYsRhwt2FFO05EITBNU--
