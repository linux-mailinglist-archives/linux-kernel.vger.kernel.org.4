Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39BE73A715
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFVRUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFVRUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:20:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698B7173F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:20:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C58721B5F;
        Thu, 22 Jun 2023 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687454427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iQgxtcS2y7mFUCqYw3HrFkS5AuxMebvUmMi0RTxrzLk=;
        b=JVpPfJo54C9G9ronrOwqtHOTkEFK415GAbR78Zdl0yXAS6Cd+j1BzsxJf1ea+rh5uIbK8U
        lVYH8fXYy53fsGfrNNs8i0YsOKDwW/LYdWbcRjwVL0bl1tuT3sCVQAKeEN9VtkPUjcPsXx
        ANLFRF3yWusAoefTRaSo0qQJT80B4dE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D4FF132BE;
        Thu, 22 Jun 2023 17:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZEmmDtqClGSFVgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 22 Jun 2023 17:20:26 +0000
Message-ID: <7c56f418-e0f3-7c16-a3f7-0ae8bd12bbf0@suse.com>
Date:   Thu, 22 Jun 2023 19:20:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Per Bilse <Per.Bilse@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
References: <20230621151442.2152425-1-per.bilse@citrix.com>
 <20230621164038.GM2053369@hirez.programming.kicks-ass.net>
 <6523f3e2-8dfc-c2dd-6d14-9e0c3ac93cc8@citrix.com>
 <20230621200409.GC4253@hirez.programming.kicks-ass.net>
 <a8cd2788-a695-964a-3311-dbecb669bb72@suse.com>
 <20230622082607.GD4253@hirez.programming.kicks-ass.net>
 <4d29bfe0-975a-c97f-3e79-5b77d95d3494@suse.com>
 <8a5b8e4a-d238-4f35-b4c7-fb9e34650a14@app.fastmail.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] Updates to Xen hypercall preemption
In-Reply-To: <8a5b8e4a-d238-4f35-b4c7-fb9e34650a14@app.fastmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------eccGc3lFmkNHWDtRYvMGEf4I"
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
--------------eccGc3lFmkNHWDtRYvMGEf4I
Content-Type: multipart/mixed; boundary="------------8Kf1W7BQ9i20xL0ixxJs60m2";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Andy Lutomirski <luto@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Per Bilse <Per.Bilse@citrix.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Message-ID: <7c56f418-e0f3-7c16-a3f7-0ae8bd12bbf0@suse.com>
Subject: Re: [PATCH] Updates to Xen hypercall preemption
References: <20230621151442.2152425-1-per.bilse@citrix.com>
 <20230621164038.GM2053369@hirez.programming.kicks-ass.net>
 <6523f3e2-8dfc-c2dd-6d14-9e0c3ac93cc8@citrix.com>
 <20230621200409.GC4253@hirez.programming.kicks-ass.net>
 <a8cd2788-a695-964a-3311-dbecb669bb72@suse.com>
 <20230622082607.GD4253@hirez.programming.kicks-ass.net>
 <4d29bfe0-975a-c97f-3e79-5b77d95d3494@suse.com>
 <8a5b8e4a-d238-4f35-b4c7-fb9e34650a14@app.fastmail.com>
In-Reply-To: <8a5b8e4a-d238-4f35-b4c7-fb9e34650a14@app.fastmail.com>

--------------8Kf1W7BQ9i20xL0ixxJs60m2
Content-Type: multipart/mixed; boundary="------------BFHXRkKT26qsw2D0dQq7zYNq"

--------------BFHXRkKT26qsw2D0dQq7zYNq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMDYuMjMgMTg6MzksIEFuZHkgTHV0b21pcnNraSB3cm90ZToNCj4gT24gVGh1LCBK
dW4gMjIsIDIwMjMsIGF0IDM6MzMgQU0sIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+PiBPbiAy
Mi4wNi4yMyAxMDoyNiwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+Pj4gT24gVGh1LCBKdW4g
MjIsIDIwMjMgYXQgMDc6MjI6NTNBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+
Pg0KPj4+PiBUaGUgaHlwZXJjYWxscyB3ZSBhcmUgdGFsa2luZyBvZiBhcmUgc3luY2hyb25v
dXMgb25lcy4gVGhleSBhcmUgcnVubmluZw0KPj4+PiBpbiB0aGUgY29udGV4dCBvZiB0aGUg
dmNwdSBkb2luZyB0aGUgY2FsbCAobGlrZSBhIHN5c2NhbGwgZnJvbSB1c2VybGFuZCBpcw0K
Pj4+PiBydW5uaW5nIGluIHRoZSBwcm9jZXNzIGNvbnRleHQpLg0KPj4+DQo+Pj4gKHNvIHRp
bWUgYWN0dWFsbHkgcGFzc2VzIGZyb20gdGhlIGd1ZXN0J3MgcG92PykNCj4+DQo+PiBDb3Jy
ZWN0Lg0KPj4NCj4+Pg0KPj4+PiBUaGUgaHlwZXJ2aXNvciB3aWxsIHJldHVybiB0byBndWVz
dCBjb250ZXh0IGZyb20gdGltZSB0byB0aW1lIGJ5IG1vZGlmeWluZw0KPj4+PiB0aGUgcmVn
aXN0ZXJzIHN1Y2ggdGhhdCB0aGUgZ3Vlc3Qgd2lsbCBkbyB0aGUgaHlwZXJjYWxsIGFnYWlu
IHdpdGggZGlmZmVyZW50DQo+Pj4+IGlucHV0IHZhbHVlcyBmb3IgdGhlIGh5cGVydmlzb3Is
IHJlc3VsdGluZyBpbiBhIHByb3BlciBjb250aW51YXRpb24gb2YgdGhlDQo+Pj4+IGh5cGVy
Y2FsbCBwcm9jZXNzaW5nLg0KPj4+DQo+Pj4gRWVldXcuLiB0aGF0J3MgcHJldHR5IHRlcnJp
YmxlLiBBbmQgY2hhbmdpbmcgdGhpcyBpc24ndCBpbiB0aGUgY2FyZHMsDQo+Pj4gbGlrZSBh
dCBhbGw/DQo+Pg0KPj4gSW4gdGhlIGxvbmcgcnVuIHRoaXMgc2hvdWxkIGJlIHBvc3NpYmxl
LCBidXQgbm90IGZvciBhbHJlYWR5IGV4aXN0aW5nIFhlbg0KPj4gdmVyc2lvbnMuDQo+Pg0K
Pj4+DQo+Pj4gVGhhdCBpcywgd2h5IGlzbid0IHRoaXMgd2hvbGUgdGhpbmcgd3JpdHRlbiBs
aWtlOg0KPj4+DQo+Pj4gCWZvciAoOzspIHsNCj4+PiAJCXJldCA9IGh5cGVyY2FsbChmb28p
Ow0KPj4+IAkJaWYgKHJldCA9PSAtRUFHQUlOKSB7DQo+Pj4gCQkJY29uZF9yZXNjaGVkKCk7
DQo+Pj4gCQkJY29udGludWU7DQo+Pj4gCQl9DQo+Pj4gCQlicmVhazsNCj4+PiAJfQ0KPj4N
Cj4+IFRoZSBoeXBlcnZpc29yIGRvZXNuJ3QgcmV0dXJuIC1FQUdBSU4gZm9yIGh5c3Rlcmlj
YWwgcmVhc29ucy4NCj4+DQo+PiBUaGlzIHdvdWxkIGJlIG9uZSBvZiB0aGUgb3B0aW9ucyB0
byBjaGFuZ2UgdGhlIGludGVyZmFjZS4gT1RPSCB0aGVyZSBhcmUgY2FzZXMNCj4+IHdoZXJl
IGFscmVhZHkgZXhpc3RpbmcgaHlwZXJjYWxscyBuZWVkIHRvIGJlIG1vZGlmaWVkIGluIHRo
ZSBoeXBlcnZpc29yIHRvIGRvDQo+PiBwcmVlbXB0aW9uIGluIHRoZSBtaWRkbGUgZHVlIHRv
IGUuZy4gc2VjdXJpdHkgcmVhc29ucyAoYXZvaWRpbmcgY3B1IGhvZ2dpbmcgaW4NCj4+IHNw
ZWNpYWwgY2FzZXMpLg0KPj4NCj4+IEFkZGl0aW9uYWxseSBzb21lIG9mIHRoZSBoeXBlcmNh
bGxzIGJlaW5nIHN1YmplY3QgdG8gcHJlZW1wdGlvbiBhcmUgYWxsb3dlZCBpbg0KPj4gdW5w
cml2aWxlZ2VkIGd1ZXN0cywgdG9vLiBUaG9zZSBhcmUgbW9zdGx5IGh5cGVyY2FsbHMgYWxs
b3dlZCBmb3IgUFYgZ3Vlc3RzDQo+PiBvbmx5LCBidXQgc29tZSBhcmUgdXNhYmxlIGJ5IGFs
bCBndWVzdHMuDQo+Pg0KPj4+DQo+Pj4+IEl0IGlzIGFuIGF3ZnVsIGludGVyZmFjZSBhbmQg
SSBhZ3JlZSB0aGF0IHN3aXRjaGluZyB0byBmdWxsIHByZWVtcHRpb24gaW4NCj4+Pj4gZG9t
MCBzZWVtcyB0byBiZSB0aGUgcm91dGUgd2hpY2ggd2Ugc2hvdWxkIHRyeSB0byB0YWtlLg0K
Pj4+DQo+Pj4gV2VsbCwgSSB3b3VsZCB2ZXJ5IHN0cm9uZ2x5IHN1Z2dlc3QgdGhlIHJvdXRl
IHRvIHRha2UgaXMgdG8gc2NyYXAgdGhlDQo+Pj4gd2hvbGUgdGhpbmcgYW5kIGludmVzdCBp
biBkb2luZyBzb21ldGhpbmcgc2FuZXIgc28gd2UgZG9uJ3QgaGF2ZSB0byBqdW1wDQo+Pj4g
dGhyb3VnaCBob29wcyBsaWtlIHRoaXMuDQo+Pj4NCj4+PiBUaGlzIGlzIHF1aXRlIHBvc3Np
Ymx5IHRoZSB3b3JzdCBwb3NzaWJsZSBpbnRlcmZhY2UgZm9yIHRoaXMgWGVuIGNvdWxkDQo+
Pj4gaGF2ZSBjb21lIHVwIHdpdGggLS0gYXdhcmRzIG1hdGVyaWFsIGZvciBzdXJlLg0KPj4N
Cj4+IFllcy4NCj4+DQo+Pj4NCj4+Pj4gVGhlIGRvd25zaWRlIHdvdWxkIGJlIHRoYXQgc29t
ZSB3b3JrbG9hZHMgbWlnaHQgc2VlIHdvcnNlIHBlcmZvcm1hbmNlDQo+Pj4+IGR1ZSB0byBi
YWNrZW5kIEkvTyBoYW5kbGluZyBtaWdodCBnZXQgcHJlZW1wdGVkLg0KPj4+DQo+Pj4gSXMg
dGhhdCBhbiBhY3R1YWwgY29uY2Vybj8gTWFyayB0aGlzIGEgbGVnYXh5IGludGVmYWNlIGFu
ZCBhbnlib2R5IHdobw0KPj4+IHdhbnRzIHRvIGdldCBhd2F5IGZyb20gaXQgdXBkYXRlcy4N
Cj4+DQo+PiBJdCBpc24ndCB0aGF0IGVhc3kuIFNlZSBhYm92ZS4NCj4+DQo+Pj4NCj4+Pj4g
SnVzdCB0aGlua2luZyAtIGNhbiBmdWxsIHByZWVtcHRpb24gYmUgZW5hYmxlZCBwZXIgcHJv
Y2Vzcz8NCj4+Pg0KPj4+IE5vcGUsIHRoYXQncyBhIHN5c3RlbSB3aWRlIHRoaW5nLiBQcmVl
bXB0aW9uIGlzIHNvbWV0aGluZyB0aGF0J3MgZHJpdmVuDQo+Pj4gYnkgdGhlIHJlcXVpcmVt
ZW50cyBvZiB0aGUgdGFza3MgdGhhdCBwcmVlbXB0LCBub3Qgc29tZXRoaW5nIGJ5IHRoZQ0K
Pj4+IHRhc2tzIHRoYXQgZ2V0IHByZWVtcHRlZC4NCj4+DQo+PiBEZXBlbmRzLiBJZiBhIHRh
c2sgaW4gYSBub24tcHJlZW1wdCBzeXN0ZW0gY291bGQgc3dpdGNoIGl0c2VsZiB0byBiZQ0K
Pj4gcHJlZW1wdGFibGUsIHdlIGNvdWxkIGRvIHNvIGFyb3VuZCBoeXBlcmNhbGxzIHdpdGhv
dXQgY29tcHJvbWlzaW5nIHRoZQ0KPj4gZ2VuZXJhbCBwcmVlbXB0aW9uIHNldHRpbmcuIERp
c2FibGluZyBwcmVlbXB0aW9uIGluIGEgcHJlZW1wdGFibGUgc3lzdGVtDQo+PiBzaG91bGQg
Y29udGludWUgdG8gYmUgcG9zc2libGUgZm9yIHNob3J0IGNvZGUgcGF0aHMgb25seSwgb2Yg
Y291cnNlLg0KPj4NCj4+PiBBbmR5J3MgaWRlYSBvZiBoYXZpbmcgdGhhdCB0aGluZyBpbnRl
cmNlcHRlZCBhcyBhbiBleGNlcHRpb24gKEVYVEFCTEUNCj4+PiBsaWtlKSBhbmQgcmVsb2Nh
dGluZyB0aGUgSVAgdG8gYSBwbGFjZSB0aGF0IGRvZXMgY29uZF9yZXNjaGVkKCkgYmVmb3Jl
DQo+Pj4gZ29pbmcgYmFjayBpcyBhbiBvcHRpb24uLiBncm9zcywgYnV0IHBvc3NpYmx5IGJl
dHRlciwgZHVubm8uDQo+Pj4NCj4+PiBRdWl0ZSB0aGUgbWVzcyBpbmRlZWQgOi8NCj4+DQo+
PiBZZWFoLg0KPiANCj4gSGF2aW5nIG9uZSBpbXBsZW1lbnRhdGlvbiBvZiBpbnRlcnJ1cHQg
aGFuZGxlcnMgdGhhdCBzY2hlZHVsZSB3aGVuIHRoZXkgaW50ZXJydXB0IGtlcm5lbCBjb2Rl
ICh0aGUgbm9ybWFsIGZ1bGwgcHJlZW1wdCBwYXRoKSBpcyBvbmUgdGhpbmcuICBIYXZpbmcg
dHdvIG9mIHRoZW0gKGZ1bGwgcHJlZW1wdCBhbmQgc3VwZXItc3BlY2lhbC1YZW4pIGlzIElN
TyBxdWl0ZSBhIGJpdCB3b3JzZS4gIEVzcGVjaWFsbHkgc2luY2Ugbm8gb25lIHRlc3RzIHRo
ZSBsYXR0ZXIgdmVyeSB3ZWxsLg0KPiANCj4gSGF2aW5nIGEgaG9ycmlibGUgWGVuLXNwZWNp
ZmljIGV4dGFibGUtbGlrZSB0aGluZ3kgc2VlbXMgaG9uZXN0bHkgcmF0aGVyIGxlc3MgYmFk
LiAgSXQgY291bGQgZXZlbiBoYXZlIGEgbGl0dGxlIHNlbGYtY29udGFpbmVkIHRlc3QgdGhh
dCBydW5zIGF0IGJvb3QsIEkgYmV0Lg0KPiANCj4gQnV0IEknbGwgYml0ZSBvbiB0aGUgcGVy
Zm9ybWFuY2UgaW1wYWN0IGlzc3VlLiAgV2hhdCwgZXhhY3RseSwgaXMgd3Jvbmcgd2l0aCBm
dWxsIHByZWVtcHRpb24/ICBGdWxsIHByZWVtcHRpb24gaGFzIHR3byBzb3VyY2VzIG9mIG92
ZXJoZWFkLCBJIHRoaW5rLiAgT25lIGlzIGEgYml0IG9mIGJvb2trZWVwaW5nLiAgVGhlIG90
aGVyIGlzIHRoZSBvdmVyaGVhZCBpbmhlcmVudCBpbiBhY3R1YWxseSByZXNjaGVkdWxpbmcg
LS0gY29udGV4dCBzd2l0Y2ggY29zdCwgbG9zaW5nIHRoaW5ncyBmcm9tIGNhY2hlLCBldGMu
DQo+IA0KPiBUaGUgYm9va2tlZXBpbmcgcGFydCBzaG91bGQgaGF2ZSBxdWl0ZSBsb3cgb3Zl
cmhlYWQuICBUaGUgc2NoZWR1bGluZyBwYXJ0IHNvdW5kcyBsaWtlIGl0IG1pZ2h0IGp1c3Qg
bmVlZCBzb21lIHNjaGVkdWxlciB0dW5pbmcgaWYgaXQncyByZWFsbHkgYSBwcm9ibGVtLg0K
PiANCj4gSW4gYW55IGNhc2UsIGZvciBiYWNrZW5kIElPLCBmdWxsIHByZWVtcHRpb24gc291
bmRzIGxpa2UgaXQgc2hvdWxkIGJlIGEgd2luLCBub3QgYSBsb3NzLiAgSWYgSSdtIGFza2lu
ZyBkb20wIHRvIGRvIGJhY2tlbmQgSU8gZm9yIG1lLCBJIGRvbid0IHdhbnQgaXQgZGVsYXll
ZCBiZWNhdXNlIGRvbTAgd2FzIGJ1c3kgZG9pbmcgc29tZXRoaW5nIGVsc2UgYm9yaW5nLiAg
SU8gaXMgZmFzdGVyIHdoZW4gdGhlIGxhdGVuY3kgYmV0d2VlbiByZXF1ZXN0aW5nIGl0IGFu
ZCBhY3R1YWxseSBzdWJtaXR0aW5nIGl0IHRvIGhhcmR3YXJlIGlzIGxvd2VyLg0KDQpNYXli
ZS4gSSB3YXMgYXNzdW1pbmcgdGhhdCBmdWxsIHByZWVtcHRpb24gd291bGQgcmVzdWx0IGlu
IG1vcmUgY29udGV4dA0Kc3dpdGNoZXMsIGVzcGVjaWFsbHkgaW4gY2FzZSBtYW55IGd1ZXN0
cyBhcmUgaGFtbWVyaW5nIGRvbTAgd2l0aCBJL09zLg0KVGhpcyBtZWFucyB0aGF0IG1vcmUg
dGltZSBpcyBzcGVudCB3aXRoIHN3aXRjaGluZyBpbnN0ZWFkIG9mIGRvaW5nIHJlYWwNCndv
cmssIHJlc3VsdGluZyBpbiBkb20wIGJlaW5nIGF0IDEwMCUgY3B1IGZhc3RlciB3aXRoIGRv
aW5nIGxlc3Mgd29yay4NCg0KSU1ITyB0aGUgcmVhc29uIGlzIHNpbWlsYXIgdG8gdGhlIHJl
YXNvbiB3aHkgc2VydmVycyB0ZW5kIHRvIGJlIHJ1bg0Kd2l0aG91dCBwcmVlbXB0aW9uICho
aWdoZXIgdGhyb3VnaHB1dCBhdCB0aGUgZXhwZW5zZSBvZiBoaWdoZXIgbGF0ZW5jeSkuDQpG
dWxsIHByZWVtcHRpb24gaXMgcHJlZmVycmVkIGZvciBzeXN0ZW1zIGJlaW5nIHVzZWQgaW50
ZXJhY3RpdmVseSwgbGlrZQ0Kd29ya3N0YXRpb25zIGFuZCBsYXB0b3BzLCBhcyBoZXJlIGxh
dGVuY3kgZG9lcyBtYXR0ZXIsIGFzIGxvbmcgYXMgdGhlDQpzeXN0ZW0gaXNuJ3QgbGltaXRl
ZCBieSBjcHUgcG93ZXIgbW9zdCBvZiB0aGUgdGltZS4NCg0KSSdtIHByZXR0eSBzdXJlIFhl
biBpbnN0YWxsYXRpb25zIGxpa2UgaW4gUXViZXNPUyB3aWxsIHByZWZlciB0byBydW4gdGhl
DQpndWVzdHMgZnVsbHkgcHJlZW1wdGl2ZSBmb3IgdGhhdCB2ZXJ5IHJlYXNvbi4NCg0KPiBD
YW4gYW55b25lIGFjdHVhbGx5IGRlbW9uc3RyYXRlIGZ1bGwgcHJlZW1wdGlvbiBiZWluZyBh
IGxvc3Mgb24gYSByZWFsIFhlbiBQViB3b3JrbG9hZD8NCg0KU2hvdWxkIGJlIGRvYWJsZSwg
YnV0IEkgdGhpbmsgYWJvdmUgcmVhc29uaW5nIGlzIHBvaW50aW5nIGludG8gdGhlIHJpZ2h0
DQpkaXJlY3Rpb24gYWxyZWFkeS4NCg0KDQpKdWVyZ2VuDQo=
--------------BFHXRkKT26qsw2D0dQq7zYNq
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------BFHXRkKT26qsw2D0dQq7zYNq--

--------------8Kf1W7BQ9i20xL0ixxJs60m2--

--------------eccGc3lFmkNHWDtRYvMGEf4I
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmSUgtkFAwAAAAAACgkQsN6d1ii/Ey+6
eggAimHaZYpf92E4dtXuWaSbAwLELCZaSzE0aS6MNJBKC8RlK8Cvy4W0Wcmyo6BBv/dVsYEls0PE
WxsPZJh4xFa3yOk6AkLpFEKgp2PLXTw1TDWuiZrQ+QFkbnh4XE1r6bL45+lZeR04KnmgMlcGLAHh
zyquY2/JtMsyVkwPIzO+hURZrbYQ70HPJOmKtY+AAjJVIFZZoO0gkstrchy/ZaTiK/yfVrDRRvp5
k0VoJgQss6kOKSCvSTS+SXAzsWIMFafYDUg0n2BFty3OQa+RgCpkyd271bd1lpI0IYodbcBa9sYv
Blg9xt+iIItVQmQIVNkxIGu0pslbyC0Ow6ytVVRseA==
=GWjd
-----END PGP SIGNATURE-----

--------------eccGc3lFmkNHWDtRYvMGEf4I--
