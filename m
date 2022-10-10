Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BC45FA35F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJJS3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJJS3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:29:19 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB9F74DC3;
        Mon, 10 Oct 2022 11:29:18 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id x13so4632083qkg.11;
        Mon, 10 Oct 2022 11:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOsBZkjdrgM0kxNA6WQpV8zyME75lDOA7Zb6ef0+bSc=;
        b=n0bpyrpymFAVNlIjLCwU2e3RnGzG/hPkeo+EUa8TbNCgcBk1z9i0E5CVYvVT51cIO2
         HKpT5IUByyGbF7OLqmOrhcoNYTVkeaUDN8eVEoretGpkqXj8Eiz7+w3GMGDtjwchv674
         L5fBUUEHzUc90UYDkro9fkTBAcEfdzcVZyY+O+/mOdskhlSvLwQTphZ8kzmOMlStO15y
         UJCmW7E4/Z7jgSVzMt8cdHdtkV4Zj8nP2LFXQrtaOldHe42vBpysZoGAazW83z2t2LCL
         WOSAmzon5bz9G2TmTILCrXODHFJXgK8oKS+8J/EsO9qSZFn7B/pFL0Tvwp4ahLc2xvCQ
         ysBw==
X-Gm-Message-State: ACrzQf1NGtUFBdQG5NoZUhmUdyyMzTcqTahxaEvHbDlPabbWsoU/kQeP
        +Ow0KqG/RoVOn/SKoQUKHh+Z30WUUxkkLCbtrvoOxb1wNII=
X-Google-Smtp-Source: AMsMyM78SI3QPa8mHj8qgXOu/6LdhSoZ/WQbpSV/P+I/SqC+Tq/Y9Vqzr3PLUqoRDDCVHubGRYVc70Us9LdRX/masWY=
X-Received: by 2002:ae9:e50e:0:b0:6e0:c985:6383 with SMTP id
 w14-20020ae9e50e000000b006e0c9856383mr13693142qkf.505.1665426558041; Mon, 10
 Oct 2022 11:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221010141630.zfzi7mk7zvnmclzy@techsingularity.net>
 <CAJZ5v0j9JyDZupNnQUsTUVv0WapGjK7b5S-4ewZ8-b=HOret2Q@mail.gmail.com> <20221010174526.3yi7nziokwwpr63s@techsingularity.net>
In-Reply-To: <20221010174526.3yi7nziokwwpr63s@techsingularity.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Oct 2022 20:29:05 +0200
Message-ID: <CAJZ5v0je1dS4xSG46r64s8G5sJHjiziX92GBaKXaxueTim3wJA@mail.gmail.com>
Subject: Re: Intermittent boot failure after 6492fed7d8c9 (v6.0-rc1)
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-rtc@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000064876605eab25638"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000064876605eab25638
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 10, 2022 at 7:50 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Mon, Oct 10, 2022 at 04:47:50PM +0200, Rafael J. Wysocki wrote:
> > Hi Mel,
> >
> > Thanks for the report!
> >
> > On Mon, Oct 10, 2022 at 4:25 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > Hi Rafael,
> > >
> > > I'm seeing intermittent boot failures after 6492fed7d8c9 ("rtc: rtc-cmos:
> > > Do not check ACPI_FADT_LOW_POWER_S0") due to a NULL pointer exception
> > > early in boot. It fails to boot 5 times after 10 boot attempts and I've
> > > only observed it on one machine so far. Either a revert or the patch below
> > > fixes it but it's unlikely it is the correct fix.
> > >
> > > --- drivers/rtc/rtc-cmos.c.orig 2022-10-10 15:11:50.335756567 +0200
> > > +++ drivers/rtc/rtc-cmos.c      2022-10-10 15:11:53.211756691 +0200
> > > @@ -1209,7 +1209,7 @@
> > >          * Or else, ACPI SCI is enabled during suspend/resume only,
> > >          * update rtc irq in that case.
> > >          */
> > > -       if (cmos_use_acpi_alarm())
> > > +       if (cmos_use_acpi_alarm() && cmos)
> > >                 cmos_interrupt(0, (void *)cmos->rtc);
> > >         else {
> > >                 /* Fix me: can we use cmos_interrupt() here as well? */
> >
> > It looks like I've exposed a race condition there.
> >
> > Generally speaking, it is misguided to install an event handler that
> > is not ready to handle the event at that time before making sure that
> > the event is disabled.
> >
> > Does the attached patch help?
> >
>
> It failed 3/10 times.

This is still not acceptable.

> That's less than the previous 5/10 failures but I
> cannot be certain it helped without running a lot more boot tests. The
> failure happens in the same function as before.

I've overlooked the fact that acpi_install_fixed_event_handler()
enables the event on success, so it is a bug to call it when the
handler is not ready.

It should help to only enable the event after running cmos_do_probe()
where the driver data pointer is set, so please try the attached
patch.

--00000000000064876605eab25638
Content-Type: text/x-patch; charset="US-ASCII"; name="rtc-handler-wake-setup-debug.patch"
Content-Disposition: attachment; 
	filename="rtc-handler-wake-setup-debug.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l933xoba0>
X-Attachment-Id: f_l933xoba0

LS0tCiBkcml2ZXJzL3J0Yy9ydGMtY21vcy5jIHwgICAyNCArKysrKysrKysrKysrKysrKystLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKSW5k
ZXg6IGxpbnV4LXBtL2RyaXZlcnMvcnRjL3J0Yy1jbW9zLmMKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgt
cG0ub3JpZy9kcml2ZXJzL3J0Yy9ydGMtY21vcy5jCisrKyBsaW51eC1wbS9kcml2ZXJzL3J0Yy9y
dGMtY21vcy5jCkBAIC0xMzUyLDcgKzEzNTIsNyBAQCBzdGF0aWMgdm9pZCBjbW9zX2NoZWNrX2Fj
cGlfcnRjX3N0YXR1cyhzCiAKIHN0YXRpYyBpbnQgY21vc19wbnBfcHJvYmUoc3RydWN0IHBucF9k
ZXYgKnBucCwgY29uc3Qgc3RydWN0IHBucF9kZXZpY2VfaWQgKmlkKQogewotCWNtb3Nfd2FrZV9z
ZXR1cCgmcG5wLT5kZXYpOworCWludCByZXQ7CiAKIAlpZiAocG5wX3BvcnRfc3RhcnQocG5wLCAw
KSA9PSAweDcwICYmICFwbnBfaXJxX3ZhbGlkKHBucCwgMCkpIHsKIAkJdW5zaWduZWQgaW50IGly
cSA9IDA7CkBAIC0xMzY0LDEzICsxMzY0LDIwIEBAIHN0YXRpYyBpbnQgY21vc19wbnBfcHJvYmUo
c3RydWN0IHBucF9kZXYKIAkJaWYgKG5yX2xlZ2FjeV9pcnFzKCkpCiAJCQlpcnEgPSBSVENfSVJR
OwogI2VuZGlmCi0JCXJldHVybiBjbW9zX2RvX3Byb2JlKCZwbnAtPmRldiwKKwkJcmV0ID0gY21v
c19kb19wcm9iZSgmcG5wLT5kZXYsCiAJCQkJcG5wX2dldF9yZXNvdXJjZShwbnAsIElPUkVTT1VS
Q0VfSU8sIDApLCBpcnEpOwogCX0gZWxzZSB7Ci0JCXJldHVybiBjbW9zX2RvX3Byb2JlKCZwbnAt
PmRldiwKKwkJcmV0ID0gY21vc19kb19wcm9iZSgmcG5wLT5kZXYsCiAJCQkJcG5wX2dldF9yZXNv
dXJjZShwbnAsIElPUkVTT1VSQ0VfSU8sIDApLAogCQkJCXBucF9pcnEocG5wLCAwKSk7CiAJfQor
CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKworCWNtb3Nfd2FrZV9zZXR1cCgmcG5wLT5kZXYp
OworCisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyB2b2lkIGNtb3NfcG5wX3JlbW92ZShzdHJ1Y3Qg
cG5wX2RldiAqcG5wKQpAQCAtMTQ1NCwxMCArMTQ2MSw5IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBj
bW9zX29mX2luaXQoc3RydWN0IHAKIHN0YXRpYyBpbnQgX19pbml0IGNtb3NfcGxhdGZvcm1fcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIHsKIAlzdHJ1Y3QgcmVzb3VyY2UgKnJl
c291cmNlOwotCWludCBpcnE7CisJaW50IGlycSwgcmV0OwogCiAJY21vc19vZl9pbml0KHBkZXYp
OwotCWNtb3Nfd2FrZV9zZXR1cCgmcGRldi0+ZGV2KTsKIAogCWlmIChSVENfSU9NQVBQRUQpCiAJ
CXJlc291cmNlID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfSU8sIDAp
OwpAQCAtMTQ2Nyw3ICsxNDczLDEzIEBAIHN0YXRpYyBpbnQgX19pbml0IGNtb3NfcGxhdGZvcm1f
cHJvYmUoc3QKIAlpZiAoaXJxIDwgMCkKIAkJaXJxID0gLTE7CiAKLQlyZXR1cm4gY21vc19kb19w
cm9iZSgmcGRldi0+ZGV2LCByZXNvdXJjZSwgaXJxKTsKKwlyZXQgPSBjbW9zX2RvX3Byb2JlKCZw
ZGV2LT5kZXYsIHJlc291cmNlLCBpcnEpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwlj
bW9zX3dha2Vfc2V0dXAoJnBkZXYtPmRldik7CisKKwlyZXR1cm4gMDsKIH0KIAogc3RhdGljIGlu
dCBjbW9zX3BsYXRmb3JtX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo=
--00000000000064876605eab25638--
