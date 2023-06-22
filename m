Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD0C739E94
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjFVKdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjFVKdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:33:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A00A1739
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:33:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B975204B7;
        Thu, 22 Jun 2023 10:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687430013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CofsqLgPabcXZOSG3gQpCRSy3P1GKa+zXZpgVoYz+EM=;
        b=ftpuJMVdqy+rMaMdu28Hk0aLt2+HNEKSWJZnKJ0XYKxQ2SKc94aWr6ht0w791y1XsIlZ37
        cARmZukF0eHSm32d8y3V4BOK68dYLgLgIe4RFZbEMuYfO4Y1XSWY/QJ+zuhTALM1pAF5F2
        qZ4oXPt57XTNkMLalCtFCgG7Smv/DS0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81F2D13905;
        Thu, 22 Jun 2023 10:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BITeHXwjlGRoPwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 22 Jun 2023 10:33:32 +0000
Message-ID: <4d29bfe0-975a-c97f-3e79-5b77d95d3494@suse.com>
Date:   Thu, 22 Jun 2023 12:33:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Per Bilse <Per.Bilse@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
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
 <a8cd2788-a695-964a-3311-dbecb669bb72@suse.com>
 <20230622082607.GD4253@hirez.programming.kicks-ass.net>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] Updates to Xen hypercall preemption
In-Reply-To: <20230622082607.GD4253@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HI0UtWftXQcOs3IvkcaEqPQm"
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
--------------HI0UtWftXQcOs3IvkcaEqPQm
Content-Type: multipart/mixed; boundary="------------s093lcKUAHQfI0hjA16TzzFn";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Per Bilse <Per.Bilse@citrix.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "open list:X86 ENTRY CODE" <linux-kernel@vger.kernel.org>,
 "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Message-ID: <4d29bfe0-975a-c97f-3e79-5b77d95d3494@suse.com>
Subject: Re: [PATCH] Updates to Xen hypercall preemption
References: <20230621151442.2152425-1-per.bilse@citrix.com>
 <20230621164038.GM2053369@hirez.programming.kicks-ass.net>
 <6523f3e2-8dfc-c2dd-6d14-9e0c3ac93cc8@citrix.com>
 <20230621200409.GC4253@hirez.programming.kicks-ass.net>
 <a8cd2788-a695-964a-3311-dbecb669bb72@suse.com>
 <20230622082607.GD4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230622082607.GD4253@hirez.programming.kicks-ass.net>

--------------s093lcKUAHQfI0hjA16TzzFn
Content-Type: multipart/mixed; boundary="------------fypZpVFiPcuZxNwNlCNDLzTm"

--------------fypZpVFiPcuZxNwNlCNDLzTm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMDYuMjMgMTA6MjYsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBUaHUsIEp1
biAyMiwgMjAyMyBhdCAwNzoyMjo1M0FNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
PiANCj4+IFRoZSBoeXBlcmNhbGxzIHdlIGFyZSB0YWxraW5nIG9mIGFyZSBzeW5jaHJvbm91
cyBvbmVzLiBUaGV5IGFyZSBydW5uaW5nDQo+PiBpbiB0aGUgY29udGV4dCBvZiB0aGUgdmNw
dSBkb2luZyB0aGUgY2FsbCAobGlrZSBhIHN5c2NhbGwgZnJvbSB1c2VybGFuZCBpcw0KPj4g
cnVubmluZyBpbiB0aGUgcHJvY2VzcyBjb250ZXh0KS4NCj4gDQo+IChzbyB0aW1lIGFjdHVh
bGx5IHBhc3NlcyBmcm9tIHRoZSBndWVzdCdzIHBvdj8pDQoNCkNvcnJlY3QuDQoNCj4gDQo+
PiBUaGUgaHlwZXJ2aXNvciB3aWxsIHJldHVybiB0byBndWVzdCBjb250ZXh0IGZyb20gdGlt
ZSB0byB0aW1lIGJ5IG1vZGlmeWluZw0KPj4gdGhlIHJlZ2lzdGVycyBzdWNoIHRoYXQgdGhl
IGd1ZXN0IHdpbGwgZG8gdGhlIGh5cGVyY2FsbCBhZ2FpbiB3aXRoIGRpZmZlcmVudA0KPj4g
aW5wdXQgdmFsdWVzIGZvciB0aGUgaHlwZXJ2aXNvciwgcmVzdWx0aW5nIGluIGEgcHJvcGVy
IGNvbnRpbnVhdGlvbiBvZiB0aGUNCj4+IGh5cGVyY2FsbCBwcm9jZXNzaW5nLg0KPiANCj4g
RWVldXcuLiB0aGF0J3MgcHJldHR5IHRlcnJpYmxlLiBBbmQgY2hhbmdpbmcgdGhpcyBpc24n
dCBpbiB0aGUgY2FyZHMsDQo+IGxpa2UgYXQgYWxsPw0KDQpJbiB0aGUgbG9uZyBydW4gdGhp
cyBzaG91bGQgYmUgcG9zc2libGUsIGJ1dCBub3QgZm9yIGFscmVhZHkgZXhpc3RpbmcgWGVu
DQp2ZXJzaW9ucy4NCg0KPiANCj4gVGhhdCBpcywgd2h5IGlzbid0IHRoaXMgd2hvbGUgdGhp
bmcgd3JpdHRlbiBsaWtlOg0KPiANCj4gCWZvciAoOzspIHsNCj4gCQlyZXQgPSBoeXBlcmNh
bGwoZm9vKTsNCj4gCQlpZiAocmV0ID09IC1FQUdBSU4pIHsNCj4gCQkJY29uZF9yZXNjaGVk
KCk7DQo+IAkJCWNvbnRpbnVlOw0KPiAJCX0NCj4gCQlicmVhazsNCj4gCX0NCg0KVGhlIGh5
cGVydmlzb3IgZG9lc24ndCByZXR1cm4gLUVBR0FJTiBmb3IgaHlzdGVyaWNhbCByZWFzb25z
Lg0KDQpUaGlzIHdvdWxkIGJlIG9uZSBvZiB0aGUgb3B0aW9ucyB0byBjaGFuZ2UgdGhlIGlu
dGVyZmFjZS4gT1RPSCB0aGVyZSBhcmUgY2FzZXMNCndoZXJlIGFscmVhZHkgZXhpc3Rpbmcg
aHlwZXJjYWxscyBuZWVkIHRvIGJlIG1vZGlmaWVkIGluIHRoZSBoeXBlcnZpc29yIHRvIGRv
DQpwcmVlbXB0aW9uIGluIHRoZSBtaWRkbGUgZHVlIHRvIGUuZy4gc2VjdXJpdHkgcmVhc29u
cyAoYXZvaWRpbmcgY3B1IGhvZ2dpbmcgaW4NCnNwZWNpYWwgY2FzZXMpLg0KDQpBZGRpdGlv
bmFsbHkgc29tZSBvZiB0aGUgaHlwZXJjYWxscyBiZWluZyBzdWJqZWN0IHRvIHByZWVtcHRp
b24gYXJlIGFsbG93ZWQgaW4NCnVucHJpdmlsZWdlZCBndWVzdHMsIHRvby4gVGhvc2UgYXJl
IG1vc3RseSBoeXBlcmNhbGxzIGFsbG93ZWQgZm9yIFBWIGd1ZXN0cw0Kb25seSwgYnV0IHNv
bWUgYXJlIHVzYWJsZSBieSBhbGwgZ3Vlc3RzLg0KDQo+IA0KPj4gSXQgaXMgYW4gYXdmdWwg
aW50ZXJmYWNlIGFuZCBJIGFncmVlIHRoYXQgc3dpdGNoaW5nIHRvIGZ1bGwgcHJlZW1wdGlv
biBpbg0KPj4gZG9tMCBzZWVtcyB0byBiZSB0aGUgcm91dGUgd2hpY2ggd2Ugc2hvdWxkIHRy
eSB0byB0YWtlLg0KPiANCj4gV2VsbCwgSSB3b3VsZCB2ZXJ5IHN0cm9uZ2x5IHN1Z2dlc3Qg
dGhlIHJvdXRlIHRvIHRha2UgaXMgdG8gc2NyYXAgdGhlDQo+IHdob2xlIHRoaW5nIGFuZCBp
bnZlc3QgaW4gZG9pbmcgc29tZXRoaW5nIHNhbmVyIHNvIHdlIGRvbid0IGhhdmUgdG8ganVt
cA0KPiB0aHJvdWdoIGhvb3BzIGxpa2UgdGhpcy4NCj4gDQo+IFRoaXMgaXMgcXVpdGUgcG9z
c2libHkgdGhlIHdvcnN0IHBvc3NpYmxlIGludGVyZmFjZSBmb3IgdGhpcyBYZW4gY291bGQN
Cj4gaGF2ZSBjb21lIHVwIHdpdGggLS0gYXdhcmRzIG1hdGVyaWFsIGZvciBzdXJlLg0KDQpZ
ZXMuDQoNCj4gDQo+PiBUaGUgZG93bnNpZGUgd291bGQgYmUgdGhhdCBzb21lIHdvcmtsb2Fk
cyBtaWdodCBzZWUgd29yc2UgcGVyZm9ybWFuY2UNCj4+IGR1ZSB0byBiYWNrZW5kIEkvTyBo
YW5kbGluZyBtaWdodCBnZXQgcHJlZW1wdGVkLg0KPiANCj4gSXMgdGhhdCBhbiBhY3R1YWwg
Y29uY2Vybj8gTWFyayB0aGlzIGEgbGVnYXh5IGludGVmYWNlIGFuZCBhbnlib2R5IHdobw0K
PiB3YW50cyB0byBnZXQgYXdheSBmcm9tIGl0IHVwZGF0ZXMuDQoNCkl0IGlzbid0IHRoYXQg
ZWFzeS4gU2VlIGFib3ZlLg0KDQo+IA0KPj4gSnVzdCB0aGlua2luZyAtIGNhbiBmdWxsIHBy
ZWVtcHRpb24gYmUgZW5hYmxlZCBwZXIgcHJvY2Vzcz8NCj4gDQo+IE5vcGUsIHRoYXQncyBh
IHN5c3RlbSB3aWRlIHRoaW5nLiBQcmVlbXB0aW9uIGlzIHNvbWV0aGluZyB0aGF0J3MgZHJp
dmVuDQo+IGJ5IHRoZSByZXF1aXJlbWVudHMgb2YgdGhlIHRhc2tzIHRoYXQgcHJlZW1wdCwg
bm90IHNvbWV0aGluZyBieSB0aGUNCj4gdGFza3MgdGhhdCBnZXQgcHJlZW1wdGVkLg0KDQpE
ZXBlbmRzLiBJZiBhIHRhc2sgaW4gYSBub24tcHJlZW1wdCBzeXN0ZW0gY291bGQgc3dpdGNo
IGl0c2VsZiB0byBiZQ0KcHJlZW1wdGFibGUsIHdlIGNvdWxkIGRvIHNvIGFyb3VuZCBoeXBl
cmNhbGxzIHdpdGhvdXQgY29tcHJvbWlzaW5nIHRoZQ0KZ2VuZXJhbCBwcmVlbXB0aW9uIHNl
dHRpbmcuIERpc2FibGluZyBwcmVlbXB0aW9uIGluIGEgcHJlZW1wdGFibGUgc3lzdGVtDQpz
aG91bGQgY29udGludWUgdG8gYmUgcG9zc2libGUgZm9yIHNob3J0IGNvZGUgcGF0aHMgb25s
eSwgb2YgY291cnNlLg0KDQo+IEFuZHkncyBpZGVhIG9mIGhhdmluZyB0aGF0IHRoaW5nIGlu
dGVyY2VwdGVkIGFzIGFuIGV4Y2VwdGlvbiAoRVhUQUJMRQ0KPiBsaWtlKSBhbmQgcmVsb2Nh
dGluZyB0aGUgSVAgdG8gYSBwbGFjZSB0aGF0IGRvZXMgY29uZF9yZXNjaGVkKCkgYmVmb3Jl
DQo+IGdvaW5nIGJhY2sgaXMgYW4gb3B0aW9uLi4gZ3Jvc3MsIGJ1dCBwb3NzaWJseSBiZXR0
ZXIsIGR1bm5vLg0KPiANCj4gUXVpdGUgdGhlIG1lc3MgaW5kZWVkIDovDQoNClllYWguDQoN
Cg0KSnVlcmdlbg0K
--------------fypZpVFiPcuZxNwNlCNDLzTm
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------fypZpVFiPcuZxNwNlCNDLzTm--

--------------s093lcKUAHQfI0hjA16TzzFn--

--------------HI0UtWftXQcOs3IvkcaEqPQm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSUI3wFAwAAAAAACgkQsN6d1ii/Ey8P
zQf+Jt7rJKZ8Ph+Az2fHWgGV5OOyTxc3Ec6WvJjnQXBSubGVrTvWdDhNu+b0C9NzFyz11AWWxao4
1RqN8n5TVbdQqRCQ1W+VM/pSHuDa67Lug+H+TOOqP03n7ikdOKIHwE/08dLHryPjLHShlWBBvJex
HGHcfqkJVFe1KEXxUjdNJhbOqw8K6CpnmWlSDMo1zZjDf/0laXecA8zlEvF9kAauTyGuATtVgD1E
R+U1VUjs8B0EU4S4cCPRsoidF7pbB7ou+9ghzUAIeBPqtWlvyayxK+oMlDMvnRR7YRIz56/O7xm6
7KWZcHrvdhVx03RG6rRP8NBKo21kUKire/hJUiR9bQ==
=jsnE
-----END PGP SIGNATURE-----

--------------HI0UtWftXQcOs3IvkcaEqPQm--
