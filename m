Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45C16AA906
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 10:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCDJ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 04:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCDJ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 04:57:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2269755
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 01:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SfhZHUyfDsg19uG6RM4Ou8sW0goxAG745IQOeAQ8QYU=; b=Ck3glLKyuw7zsPy3T5KPDKYpN8
        wB/Yp42kmEqRur+bfCTNoaRtiKT1gguMX2NimFz3qLYreym9aFs2UXARN+gJeyaXsmS5LpBKrzqV+
        X19X34RGt8OBT54oYeqiDnFxtPELuc88iMoBShYKWPk6JuitQahUMZbJdgyWrPFrEtjWEjE44ZNeR
        E8+bXSnFld7gfazK0o+5JexvzG8itIlLIvZD3OS4V95G4CW7SIU6HZklJLtovgTuSevKZaac5Z6vG
        FC8o3nUGjGpedR6ZjI5oBkhWwzKFg10Fdgg6WQOmpmR50+ZsmcGQBOEoy4IevED76M6C0PAycAlTS
        B8v3lqwA==;
Received: from [2001:8b0:10b:5:4ce9:a0c4:1cf4:98d9] (helo=u3832b3a9db3152.ant.amazon.com)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYOe5-003mLX-IZ; Sat, 04 Mar 2023 09:57:42 +0000
Message-ID: <c34964056595a5a59d0d53410933a5582ef07d10.camel@infradead.org>
Subject: Re: IRQ affinity not working on Xen pci-platform device^W^W^W QEMU
 split-irqchip I/O APIC.
From:   David Woodhouse <dwmw2@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>
Date:   Sat, 04 Mar 2023 09:57:40 +0000
In-Reply-To: <87356ljr6m.ffs@tglx>
References: <07866eaf6354dd43d87cffb6eebf101716845b66.camel@infradead.org>
         <87fsalkcck.ffs@tglx>
         <1060e7786498f384634b01c335bf7bf43365e1fe.camel@infradead.org>
         <87356ljr6m.ffs@tglx>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
        boundary="=-5Pj+37JDg51UR5035j2m"
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5Pj+37JDg51UR5035j2m
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2023-03-04 at 01:28 +0100, Thomas Gleixner wrote:
> David!
>=20
> On Fri, Mar 03 2023 at 16:54, David Woodhouse wrote:
> > On Fri, 2023-03-03 at 17:51 +0100, Thomas Gleixner wrote:
> > > >=20
> > > > [=C2=A0=C2=A0=C2=A0 0.577173] ACPI: \_SB_.LNKC: Enabled at IRQ 11
> > > > [=C2=A0=C2=A0=C2=A0 0.578149] The affinity mask was 0-3
> > > > [=C2=A0=C2=A0=C2=A0 0.579081] The affinity mask is 0-3 and the hand=
ler is on 2
> > > > [=C2=A0=C2=A0=C2=A0 0.580288] The affinity mask is 0 and the handle=
r is on 2
> > >=20
> > > What happens is that once the interrupt is requested, the affinity
> > > setting is deferred to the first interrupt. See the marvelous dance i=
n
> > > arch/x86/kernel/apic/msi.c::msi_set_affinity().
> > >=20
> > > If you do the setting before request_irq() then the startup will assi=
gn
> > > it to the target mask right away.
> > >=20
> > > Btw, you are using irq_get_affinity_mask(), which gives you the desir=
ed
> > > target mask. irq_get_effective_affinity_mask() gives you the real one=
.
> > >=20
> > > Can you verify that the thing moves over after the first interrupt or=
 is
> > > that too late already?
> >=20
> > It doesn't seem to move. The hack to just return IRQ_NONE if invoked on
> > CPU !=3D 0 was intended to do just that. It's a level-triggered interru=
pt
> > so when the handler does nothing on the "wrong" CPU, it ought to get
> > invoked again on the *correct* CPU and actually=C2=A0work that time.
>=20
> So much for the theory. This is virt after all so it does not
> necessarily behave like real hardware.

I think you're right. This looks like a QEMU bug with the "split
irqchip" I/OAPIC.

For reasons I'm unclear about, and which lack a comment in the code,
QEMU still injects I/OAPIC events into the kernel with kvm_set_irq().
(I think it's do to with caching, because QEMU doesn't cache interrupt-
remapping translations anywhere *except* in the KVM IRQ routing table,
so if it just synthesised an MSI message every time it'd have to
retranslate it every time?)

Tracing the behaviour here shows:

 =E2=80=A2 First interrupt happens on CPU2.
 =E2=80=A2 Linux updates the I/OAPIC RTE to point to CPU0, but QEMU doesn't
   update the KVM IRQ routing table yet.
 * QEMU retriggers the (still-high, level triggered) IRQ.
 =E2=80=A2 QEMU calls kvm_set_irq(11), delivering it to CPU2 again.
 =E2=80=A2 QEMU *finally* calls ioapic_update_kvm_routes().
 =E2=80=A2 Linux sees the interrupt on CPU2 again.

  $ qemu-system-x86_64 -display none -serial mon:stdio \
     -accel kvm,xen-version=3D0x4000a,kernel-irqchip=3Dsplit \
     -kernel ~/git/linux/arch/x86/boot//bzImage=C2=A0\
     -append "console=3DttyS0,115200 xen_no_vector_callback" \
     -smp 4 --trace ioapic\* --trace xenstore\*


...

xenstore_read tx 0 path control/platform-feature-xs_reset_watches
ioapic_set_irq vector: 11 level: 1
ioapic_set_remote_irr set remote irr for pin 11
ioapic_service: trigger KVM IRQ 11
[    0.523627] The affinity mask was 0-3 and the handler is on 2
ioapic_mem_write ioapic mem write addr 0x0 regsel: 0x27 size 0x4 val 0x26
ioapic_update_kvm_routes: update KVM route for IRQ 11: fee02000 8021
ioapic_mem_write ioapic mem write addr 0x10 regsel: 0x26 size 0x4 val 0x180=
21
xenstore_reset_watches=20
ioapic_set_irq vector: 11 level: 1
ioapic_mem_read ioapic mem read addr 0x10 regsel: 0x26 size 0x4 retval 0x1c=
021
[    0.524569] ioapic_ack_level IRQ 11 moveit =3D 1
ioapic_eoi_broadcast EOI broadcast for vector 33
ioapic_clear_remote_irr clear remote irr for pin 11 vector 33
ioapic_mem_write ioapic mem write addr 0x0 regsel: 0x26 size 0x4 val 0x26
ioapic_mem_read ioapic mem read addr 0x10 regsel: 0x26 size 0x4 retval 0x18=
021
[    0.525235] ioapic_finish_move IRQ 11 calls irq_move_masked_irq()
[    0.526147] irq_do_set_affinity for IRQ 11, 0
[    0.526732] ioapic_set_affinity for IRQ 11, 0
[    0.527330] ioapic_setup_msg_from_msi for IRQ11 target 0
ioapic_mem_write ioapic mem write addr 0x0 regsel: 0x26 size 0x4 val 0x27
ioapic_mem_write ioapic mem write addr 0x10 regsel: 0x27 size 0x4 val 0x0
ioapic_mem_write ioapic mem write addr 0x0 regsel: 0x27 size 0x4 val 0x26
ioapic_mem_write ioapic mem write addr 0x10 regsel: 0x26 size 0x4 val 0x180=
21
[    0.527623] ioapic_set_affinity returns 0
[    0.527623] ioapic_finish_move IRQ 11 calls unmask_ioapic_irq()
ioapic_mem_write ioapic mem write addr 0x0 regsel: 0x26 size 0x4 val 0x26
ioapic_mem_write ioapic mem write addr 0x10 regsel: 0x26 size 0x4 val 0x802=
1
ioapic_set_remote_irr set remote irr for pin 11
ioapic_service: trigger KVM IRQ 11
ioapic_update_kvm_routes: update KVM route for IRQ 11: fee00000 8021
[    0.529571] The affinity mask was 0 and the handler is on 2
[    xenstore_watch path memory/target token FFFFFFFF92847D40
xenstore_watch_event path memory/target token FFFFFFFF92847D40
ioapic_set_irq vector: 11 level: 1
0.530486] ioapic_ack_level IRQ 11 moveit =3D 0


This is with Linux doing basically nothing when the handler is invoked
on the 'wrong' CPU, and just waiting for it to be right.

Commenting out the kvm_set_irq() calls in ioapic_service() and letting
QEMU synthesise an MSI every time works. Better still, so does this,
making it update the routing table *before* retriggering the IRQ when
the guest updates the RTE:

--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -405,6 +409,7 @@ ioapic_mem_write(void *opaque, hwaddr addr,
uint64_t val,
                 s->ioredtbl[index] |=3D ro_bits;
                 s->irq_eoi[index] =3D 0;
                 ioapic_fix_edge_remote_irr(&s->ioredtbl[index]);
+                ioapic_update_kvm_routes(s);
                 ioapic_service(s);
             }
         }
@@ -418,7 +423,6 @@ ioapic_mem_write(void *opaque, hwaddr addr,
uint64_t val,
         break;
     }
=20
-    ioapic_update_kvm_routes(s);
 }
=20
 static const MemoryRegionOps ioapic_io_ops =3D {



Now, I don't quite see why we don't get a *third* interrupt, since
Linux did nothing to clear the level of IRQ 11 and the last trace I see
from QEMU's ioapic_set_irq confirms it's still set. But I've exceeded
my screen time for the day, so I'll have to frown at that part some
more later. I wonder if the EOI is going missing because it's coming
from the wrong CPU? Note no 'EOI broadcast' after the last line in the
log I showed above; it isn't just that I trimmed it there.

I don't think we need to do anything in Linux; if the handler gets
invoked on the wrong CPU it'll basically find no events pending for
that CPU and return having done nothing... and *hopefully* should be
re-invoked on the correct CPU shortly thereafter.

--=-5Pj+37JDg51UR5035j2m
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMwMzA0MDk1NzQwWjAvBgkqhkiG9w0BCQQxIgQgrFR4lPm1
WDljiYico/w9DdB2c2h8YkQJLvf05v7Z9ZIwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCKjldEN2e1QiSry0BI/VClUsT9X5i9xsQl
o5kzxXgu2IcI3OzrESs3dmEUgan8PvGOpS+0L8yUygr+0V3VZTHZnnAZERRWE6iD/xpASyp3o9Da
KPdkfMcgtls6X8k5xI7YELkBQZGcp4SO2QTGXIH0wINAvU64i/k6LpYVKcs5+KTBiPelpCGfGBjx
QqotOvWPQJauEwDkBR2MoQq1PwvacnSc6BYw5gq0BjiQKgkP73rihMBfAnf6ASr8i1A3IYRHFIg4
lCvFYJnI8MImFRjfSYQMdfV3j23Em5OWpBX5/iyJLpdpnU+H1d5n9NniF7g/icK1+gSpMm30J2Uk
sg2yzg2KXz8IyMtVcgOJFqSUZNjPAY/3p5cQ1q3Wlv8+jMgk8xGGrtGjNdAmxkGQZtvB3Kro+jWU
9vPi6Z/LY3gZ+E+z5rjOaUhMYPfaIuT5ZGdeBeESOrDQhqXqB2XTdsEAIFlyg9P4XpBC0XkYzNMf
0N5T2tc5VllfvYq+fIyPAoN33TlhovAIaKqe4j9QU0UBnarSeDKYTLyDhqK9k8ZlA45wR0kvMpJA
PkixXqrDKh54cs8c9NVlHhg2D0lrm7mOw4qQigOXQqGnQ2HefDzFaAXliDYImXK90rtoGCCf9Tt8
F9OdnbfSKrM68mjIuPwQiI3EqraMswlE8pEs8kKLlwAAAAAAAA==


--=-5Pj+37JDg51UR5035j2m--
