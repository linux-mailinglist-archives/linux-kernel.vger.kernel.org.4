Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FA673A0B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjFVMRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjFVMRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:17:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D8010F2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:17:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F9FE22B75;
        Thu, 22 Jun 2023 12:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687436227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VqsOz0ZUUPar+Aeqqn/vg5vN/i1kZj6Y/y/QQi+nP+k=;
        b=jFXs34WrC5j0dG6j5lAnXMgQdyC3TUHYJrRQt4jAJeQ1sd27uUaTRJTCYDx6z5V0EGPnQt
        5NzhZqRhHZkZHfaz3FfdnYnR66lSQeyCZJArfjp7Aj3C1LKxyVE1NvWXke6VrV1EoKIWBJ
        RHKaNtI2Lrl3nAoeRifhSXI0sfzbPmE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA4E413905;
        Thu, 22 Jun 2023 12:17:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xxyRM8I7lGTeZQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 22 Jun 2023 12:17:06 +0000
Message-ID: <5484a739-5dc9-ab14-3bcf-3ba6c36542af@suse.com>
Date:   Thu, 22 Jun 2023 14:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Updates to Xen hypercall preemption
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
 <4d29bfe0-975a-c97f-3e79-5b77d95d3494@suse.com>
 <20230622111552.GI4253@hirez.programming.kicks-ass.net>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230622111552.GI4253@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PK0vDO0RRRTH0WlSOU9WiVzN"
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
--------------PK0vDO0RRRTH0WlSOU9WiVzN
Content-Type: multipart/mixed; boundary="------------0TQKO60zEo7bFW9BBB40VRyf";
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
Message-ID: <5484a739-5dc9-ab14-3bcf-3ba6c36542af@suse.com>
Subject: Re: [PATCH] Updates to Xen hypercall preemption
References: <20230621151442.2152425-1-per.bilse@citrix.com>
 <20230621164038.GM2053369@hirez.programming.kicks-ass.net>
 <6523f3e2-8dfc-c2dd-6d14-9e0c3ac93cc8@citrix.com>
 <20230621200409.GC4253@hirez.programming.kicks-ass.net>
 <a8cd2788-a695-964a-3311-dbecb669bb72@suse.com>
 <20230622082607.GD4253@hirez.programming.kicks-ass.net>
 <4d29bfe0-975a-c97f-3e79-5b77d95d3494@suse.com>
 <20230622111552.GI4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230622111552.GI4253@hirez.programming.kicks-ass.net>

--------------0TQKO60zEo7bFW9BBB40VRyf
Content-Type: multipart/mixed; boundary="------------yjVdNd1aSIrIRK1Yn0XnEKrk"

--------------yjVdNd1aSIrIRK1Yn0XnEKrk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMDYuMjMgMTM6MTUsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBUaHUsIEp1
biAyMiwgMjAyMyBhdCAxMjozMzozMVBNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
Pj4gT24gMjIuMDYuMjMgMTA6MjYsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiANCj4+Pj4g
VGhlIGRvd25zaWRlIHdvdWxkIGJlIHRoYXQgc29tZSB3b3JrbG9hZHMgbWlnaHQgc2VlIHdv
cnNlIHBlcmZvcm1hbmNlDQo+Pj4+IGR1ZSB0byBiYWNrZW5kIEkvTyBoYW5kbGluZyBtaWdo
dCBnZXQgcHJlZW1wdGVkLg0KPj4+DQo+Pj4gSXMgdGhhdCBhbiBhY3R1YWwgY29uY2Vybj8g
TWFyayB0aGlzIGEgbGVnYXh5IGludGVmYWNlIGFuZCBhbnlib2R5IHdobw0KPj4+IHdhbnRz
IHRvIGdldCBhd2F5IGZyb20gaXQgdXBkYXRlcy4NCj4+DQo+PiBJdCBpc24ndCB0aGF0IGVh
c3kuIFNlZSBhYm92ZS4NCj4gDQo+IFdlbGwsIHRoZSBvbGQgc3R1ZmYgZ2V0cyB0byB1c2Ug
ZnVsbCBwcmVlbXB0aW9uIG9uIERvbTAsIHRoZW4gdGhlIG5ldw0KPiBzdHVmZiBnZXRzIG1v
cmUgc2hpbnkgb3B0aW9ucy4NCg0KWWVhaCwgYnV0IHdoYXQgYWJvdXQgdGhlIGh5cGVyY2Fs
bHMgZnJvbSBub24tZG9tMCBzeXN0ZW1zIG5lZWRpbmcgdGhlIHNhbWUNCmhhbmRsaW5nPyBU
aGlzIHdvdWxkIHJlcXVpcmUgdG8gcnVuIGFsbCBndWVzdHMgd2hpY2ggYXJlIHVzaW5nIGh5
cGVyY2FsbHMNCmZ1bGx5IHByZWVtcHRpdmUuDQoNCj4gDQo+Pj4+IEp1c3QgdGhpbmtpbmcg
LSBjYW4gZnVsbCBwcmVlbXB0aW9uIGJlIGVuYWJsZWQgcGVyIHByb2Nlc3M/DQo+Pj4NCj4+
PiBOb3BlLCB0aGF0J3MgYSBzeXN0ZW0gd2lkZSB0aGluZy4gUHJlZW1wdGlvbiBpcyBzb21l
dGhpbmcgdGhhdCdzIGRyaXZlbg0KPj4+IGJ5IHRoZSByZXF1aXJlbWVudHMgb2YgdGhlIHRh
c2tzIHRoYXQgcHJlZW1wdCwgbm90IHNvbWV0aGluZyBieSB0aGUNCj4+PiB0YXNrcyB0aGF0
IGdldCBwcmVlbXB0ZWQuDQo+Pg0KPj4gRGVwZW5kcy4gSWYgYSB0YXNrIGluIGEgbm9uLXBy
ZWVtcHQgc3lzdGVtIGNvdWxkIHN3aXRjaCBpdHNlbGYgdG8gYmUNCj4+IHByZWVtcHRhYmxl
LCB3ZSBjb3VsZCBkbyBzbyBhcm91bmQgaHlwZXJjYWxscyB3aXRob3V0IGNvbXByb21pc2lu
ZyB0aGUNCj4+IGdlbmVyYWwgcHJlZW1wdGlvbiBzZXR0aW5nLiBEaXNhYmxpbmcgcHJlZW1w
dGlvbiBpbiBhIHByZWVtcHRhYmxlIHN5c3RlbQ0KPj4gc2hvdWxkIGNvbnRpbnVlIHRvIGJl
IHBvc3NpYmxlIGZvciBzaG9ydCBjb2RlIHBhdGhzIG9ubHksIG9mIGNvdXJzZS4NCj4gDQo+
IFNvIHNvbWV0aGluZyBhbG9uZyB0aG9zZSBsaW5lcyB3YXMgc3VnZ2VzdGVkIGVsc2V3aGVy
ZSwgYW5kIEknbSBzdGlsbA0KPiBub3QgZW50aXJlbHkgc3VyZSBob3cgSSBmZWVsIGFib3V0
IGl0LCBidXQgbG9vayBoZXJlOg0KPiANCj4gICAgaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcv
ci8yMDIzMDQwMzA1MjIzMy4xODgwNTY3LTEtYW5rdXIuYS5hcm9yYUBvcmFjbGUuY29tDQo+
IA0KPiBTcGVjaWZpY2FsbHkgcGF0Y2hlcyA3IGFuZCA4LiBJdCBpcyB2ZXJ5IGNsb3NlIHNv
IHRoYXQgeW91IGN1cnJlbnRseQ0KPiBkby93YW50LiBUaG9zZSBwYXRjaGVzIGFyZSBtYW55
IG1vb25zIG9sZCBhbmQgaSd2ZSBub3Qgc2VlbiBhbiB1cGRhdGUgb24NCj4gdGhlbSwgc28g
SSd2ZSBubyBpZGVhIHdoZXJlIHRoZXkgYXJlLg0KPiANCj4gSXQgc29sdmVzIGEgc2ltaWxh
ciBwcm9ibGVtIGV4Y2VwdCBpdCBpcyAncmVwIHN0cmluZycgaW5zdHJ1Y3Rpb25zDQo+IHRo
YXQncyBiZWluZyBpbnRlcnJ1cHRlZC4NCg0KUmlnaHQuIEknbGwgcGluZyBBbmt1ci4NCg0K
DQpKdWVyZ2VuDQo=
--------------yjVdNd1aSIrIRK1Yn0XnEKrk
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------yjVdNd1aSIrIRK1Yn0XnEKrk--

--------------0TQKO60zEo7bFW9BBB40VRyf--

--------------PK0vDO0RRRTH0WlSOU9WiVzN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSUO8EFAwAAAAAACgkQsN6d1ii/Ey9c
Bwf+LKk00R9TWDPdBVz/78ddnQ9KJX3R4vASOFPZ/174/UmM1TKHmmAo7/92tYwuKPmsSEdysEBQ
1DrRSKUAymbP7MHn6vVNpjrcFb/xujdt19Q0NTNApCGKydfrWSUpkNdggEHAqJOvOX9jtYFFT4lk
RisW2QQiEozYdG+vn9jQ7zejPB9NnaBEhE8+imHWxvRDEpWvrekDg96p0NwWK2a1YhYjPpSshWcR
yjsFqI6S3pLxt7GHgQ4eQLW1kfHh2LG6prja9DrQz3eqAtQOAAHalD7Cx8P0nJ6ZZ3oX8d/+tP5f
T9VFJO69dabOC2tXuO/9ZK41o5NKK3VJVr8mR8D+3A==
=4uJs
-----END PGP SIGNATURE-----

--------------PK0vDO0RRRTH0WlSOU9WiVzN--
