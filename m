Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DBE673F67
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjASQ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjASQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:58:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D05677A9;
        Thu, 19 Jan 2023 08:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674147482; x=1705683482;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=LPC2X1IyUYqT3xMp2MnPgtVl8bSwFTiOdaClvXnl8yw=;
  b=YjR2GnmeCKg/sifiDmdAfYv7L7pbB1RhCzK2iN7uQUoBrGxpDdkspkAm
   aANQI+wPLa6hDwV5oY+eqt5+4KX8dvlVcilOvc7t/hBgZR/4y86yQDhHP
   ruPOc5cvxwbEmlSzroUg2hlkhj3CaX+ihAbxWGQM8slMMlnX1UX7DVHj9
   xiRl7AzbsL8YypHAPftTgX/3GLUj+XgzGBlXbcKgv2ixIgWi9nllc88nS
   78VMfp6fsoAIVpTC0+umi08KQ8Jv00sf64UkSQr0gTIiUCRIIbhEKe2R5
   q7bLPu4Dj1UikSrh0lj4XP7p7QiMVR87oIkLGBkAJxlCwx3xJQ6HW5m1O
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="327439928"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208,223";a="327439928"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 08:58:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="653454906"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208,223";a="653454906"
Received: from wardsamx-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.216.92])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 08:58:01 -0800
Message-ID: <33bb6a2a6b473d74c73a730671e6bd12c764bcd6.camel@linux.intel.com>
Subject: Re: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Date:   Thu, 19 Jan 2023 08:58:01 -0800
In-Reply-To: <CAJZ5v0hYMPkGuJnOBkr+nRX4yny2wa6toPVbhbipRRKyS4Ei4g@mail.gmail.com>
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
         <f76c13de-d250-ebc0-d234-ccb3a9ce3c28@linaro.org>
         <2627c37e07dce6b125d3fea3bf38a5f2407ad6a1.camel@intel.com>
         <5aabdd3010a02e361fbbe01f4af0e30d11f0ae6b.camel@linux.intel.com>
         <c7abcce47df0aaa55f1e6c65f501bc691d35eae8.camel@linux.intel.com>
         <c210542f-0a71-15f2-c58f-ec607e60b06d@linaro.org>
         <8547963350fb3bdb09a4693f0eb80c7199ab6f21.camel@linux.intel.com>
         <87627e1f-322c-a195-8ce6-8922d9787ff0@linaro.org>
         <340f3ecdaddb2c422dcbe3df712a082f333eab0d.camel@linux.intel.com>
         <d6f71181-1de4-7937-eda0-8805d9dfc3b4@linaro.org>
         <b51ecbb8ac774efc4fb4ac1349585b486303f86f.camel@linux.intel.com>
         <CAJZ5v0hYMPkGuJnOBkr+nRX4yny2wa6toPVbhbipRRKyS4Ei4g@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-GbUfNslkOBgyVn/ErPpj"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GbUfNslkOBgyVn/ErPpj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2023-01-19 at 13:17 +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 19, 2023 at 12:04 AM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Wed, 2023-01-18 at 23:14 +0100, Daniel Lezcano wrote:
> > > On 18/01/2023 22:16, srinivas pandruvada wrote:
> > > > On Wed, 2023-01-18 at 22:01 +0100, Daniel Lezcano wrote:
> > > > > On 18/01/2023 21:53, srinivas pandruvada wrote:
> > > > > > On Wed, 2023-01-18 at 21:00 +0100, Daniel Lezcano wrote:
> > > > > > > On 18/01/2023 20:16, srinivas pandruvada wrote:
> > > > > > > 
> > > > > > > [ ... ]
> > > > > > > 
> > > > > > > > > > But we'd better wait for the thermald test result
> > > > > > > > > > from
> > > > > > > > > > Srinvias.
> > > > > > > > > 
> > > > > > > > > A quick test show that things still work with
> > > > > > > > > thermald
> > > > > > > > > and
> > > > > > > > > these
> > > > > > > > > changes.
> > > > > > > > 
> > > > > > > > But I have a question. In some devices trip point
> > > > > > > > temperature
> > > > > > > > is
> > > > > > > > not
> > > > > > > > static. When hardware changes, we get notification. For
> > > > > > > > example
> > > > > > > > INT3403_PERF_TRIP_POINT_CHANGED for INT3403 drivers.
> > > > > > > > Currently get_trip can get the latest changed value.
> > > > > > > > But if
> > > > > > > > we
> > > > > > > > preregister, we need some mechanism to update them.
> > > > > > > 
> > > > > > > When the notification INT3403_PERF_TRIP_POINT_CHANGED
> > > > > > > happens, we
> > > > > > > call
> > > > > > > int340x_thermal_read_trips() which in turn updates the
> > > > > > > trip
> > > > > > > points.
> > > > > > > 
> > > > > > 
> > > > > > Not sure how we handle concurrency here when driver can
> > > > > > freely
> > > > > > update
> > > > > > trips while thermal core is using trips.
> > > > > 
> > > > > Don't we have the same race without this patch ? The thermal
> > > > > core
> > > > > can
> > > > > call get_trip_temp() while there is an update, no ?
> > > > Yes it is. But I can add a mutex locally here to solve.
> > > > But not any longer.
> > > > 
> > > > I think you need some thermal_zone_read_lock/unlock() in core,
> > > > which
> > > > can use rcu. Even mutex is fine as there will be no contention
> > > > as
> > > > updates to trips will be rare.
> > > 
> > > I was planning to provide a thermal_trips_update(tz, trips) and
> > > from
> > > there handle the locking.
> > > 
> > > As the race was already existing, can we postpone this change
> > > after
> > > the
> > > generic trip points changes?
> > I think so.
> 
> Well, what if this bug is reported by a user and a fix needs to be
> backported to "stable"?
> 
> Are we going to backport the whole framework redesign along with it?
> 
> Or is this extremely unlikely?
These trips are read at the start of DTT/Thermald and will be read once
after notification is received. So extremely unlikely. 
But we can add the patch before this series to address this issue,
which can be marked stable. I can submit this.

Thanks,
Srinivas


--=-GbUfNslkOBgyVn/ErPpj
Content-Disposition: attachment;
	filename*0=0001-thermal-int340x-Protect-trip-temperature-from-dynami.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-thermal-int340x-Protect-trip-temperature-from-dynami.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAyMTU3YzE1YWI4NTY1ODVjNDIxMTE5YWM0NTg3NzQ3MzExY2IyYTk5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2
YWRhQGxpbnV4LmludGVsLmNvbT4KRGF0ZTogVGh1LCAxOSBKYW4gMjAyMyAwODozNzoxNSAtMDgw
MApTdWJqZWN0OiBbUEFUQ0hdIHRoZXJtYWw6IGludDM0MHg6IFByb3RlY3QgdHJpcCB0ZW1wZXJh
dHVyZSBmcm9tIGR5bmFtaWMKIHVwZGF0ZQoKVHJpcCB0ZW1wZXJhdHVyZXMgYXJlIHJlYWQgdXNp
bmcgQUNQSSBtZXRob2RzIGFuZCBzdG9yZWQgaW4gdGhlIG1lbW9yeQpkdXJpbmcgem9uZSBpbml0
aWFsaXp0aW9uIGFuZCB3aGVuIHRoZSBmaXJtd2FyZSBzZW5kcyBhIG5vdGlmaWNhdGlvbiBmb3IK
Y2hhbmdlLiBUaGlzIHRyaXAgdGVtcGVyYXR1cmUgaXMgcmV0dXJuZWQgd2hlbiB0aGUgdGhlcm1h
bCBjb3JlIGNhbGxzIHZpYQpjYWxsYmFjayBnZXRfdHJpcF90ZW1wKCkuCgpCdXQgaXQgaXMgcG9z
c2libGUgdGhhdCB3aGlsZSB1cGRhdGluZyB0aGUgbWVtb3J5IGNvcHkgb2YgdGhlIHRyaXBzIHdo
ZW4KdGhlIGZpcm13YXJlIHNlbmRzIGEgbm90aWZpY2F0aW9uIGZvciBjaGFuZ2UsIHRoZXJtYWwg
Y29yZSBpcyByZWFkaW5nIHRoZQp0cmlwIHRlbXBlcmF0dXJlIHZpYSB0aGUgY2FsbGJhY2sgZ2V0
X3RyaXBfdGVtcCgpLiBUaGlzIG1heSByZXR1cm4gaW52YWxpZAp0cmlwIHRlbXBlcmF0dXJlLgoK
VG8gYWRkcmVzcyB0aGlzIGFkZCBhIG11dGV4IHRvIHByb3RlY3QgdGhlIGludmFsaWQgdGVtcGVy
YXR1cmUgcmVhZHMgaW4KdGhlIGNhbGxiYWNrIGdldF90cmlwX3RlbXAoKSBhbmQgaW50MzQweF90
aGVybWFsX3JlYWRfdHJpcHMoKS4KClNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzIFBhbmRydXZhZGEg
PHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPgotLS0KIC4uLi9pbnRlbC9pbnQz
NDB4X3RoZXJtYWwvaW50MzQweF90aGVybWFsX3pvbmUuYyB8IDE2ICsrKysrKysrKysrKysrKy0K
IC4uLi9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvaW50MzQweF90aGVybWFsX3pvbmUuaCB8ICAxICsK
IDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvaW50MzQweF90aGVy
bWFsX3pvbmUuYyBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvaW50MzQw
eF90aGVybWFsX3pvbmUuYwppbmRleCA2MmMwYWE1ZDA3ODMuLmZkOTA4MDY0MGUwMyAxMDA2NDQK
LS0tIGEvZHJpdmVycy90aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9pbnQzNDB4X3RoZXJt
YWxfem9uZS5jCisrKyBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvaW50
MzQweF90aGVybWFsX3pvbmUuYwpAQCAtNDksNiArNDksOCBAQCBzdGF0aWMgaW50IGludDM0MHhf
dGhlcm1hbF9nZXRfdHJpcF90ZW1wKHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp6b25lLAog
CWlmIChkLT5vdmVycmlkZV9vcHMgJiYgZC0+b3ZlcnJpZGVfb3BzLT5nZXRfdHJpcF90ZW1wKQog
CQlyZXR1cm4gZC0+b3ZlcnJpZGVfb3BzLT5nZXRfdHJpcF90ZW1wKHpvbmUsIHRyaXAsIHRlbXAp
OwogCisJbXV0ZXhfbG9jaygmZC0+dHJpcF9tdXRleCk7CisKIAlpZiAodHJpcCA8IGQtPmF1eF90
cmlwX25yKQogCQkqdGVtcCA9IGQtPmF1eF90cmlwc1t0cmlwXTsKIAllbHNlIGlmICh0cmlwID09
IGQtPmNydF90cmlwX2lkKQpAQCAtNjUsMTAgKzY3LDE0IEBAIHN0YXRpYyBpbnQgaW50MzQweF90
aGVybWFsX2dldF90cmlwX3RlbXAoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnpvbmUsCiAJ
CQkJYnJlYWs7CiAJCQl9CiAJCX0KLQkJaWYgKGkgPT0gSU5UMzQwWF9USEVSTUFMX01BWF9BQ1Rf
VFJJUF9DT1VOVCkKKwkJaWYgKGkgPT0gSU5UMzQwWF9USEVSTUFMX01BWF9BQ1RfVFJJUF9DT1VO
VCkgeworCQkJbXV0ZXhfdW5sb2NrKCZkLT50cmlwX211dGV4KTsKIAkJCXJldHVybiAtRUlOVkFM
OworCQl9CiAJfQogCisJbXV0ZXhfdW5sb2NrKCZkLT50cmlwX211dGV4KTsKKwogCXJldHVybiAw
OwogfQogCkBAIC0xODAsNiArMTg2LDggQEAgaW50IGludDM0MHhfdGhlcm1hbF9yZWFkX3RyaXBz
KHN0cnVjdCBpbnQzNHhfdGhlcm1hbF96b25lICppbnQzNHhfem9uZSkKIAlpbnQgdHJpcF9jbnQg
PSBpbnQzNHhfem9uZS0+YXV4X3RyaXBfbnI7CiAJaW50IGk7CiAKKwltdXRleF9sb2NrKCZpbnQz
NHhfem9uZS0+dHJpcF9tdXRleCk7CisKIAlpbnQzNHhfem9uZS0+Y3J0X3RyaXBfaWQgPSAtMTsK
IAlpZiAoIWludDM0MHhfdGhlcm1hbF9nZXRfdHJpcF9jb25maWcoaW50MzR4X3pvbmUtPmFkZXYt
PmhhbmRsZSwgIl9DUlQiLAogCQkJCQkgICAgICZpbnQzNHhfem9uZS0+Y3J0X3RlbXApKQpAQCAt
MjA3LDYgKzIxNSw4IEBAIGludCBpbnQzNDB4X3RoZXJtYWxfcmVhZF90cmlwcyhzdHJ1Y3QgaW50
MzR4X3RoZXJtYWxfem9uZSAqaW50MzR4X3pvbmUpCiAJCWludDM0eF96b25lLT5hY3RfdHJpcHNb
aV0udmFsaWQgPSB0cnVlOwogCX0KIAorCW11dGV4X3VubG9jaygmaW50MzR4X3pvbmUtPnRyaXBf
bXV0ZXgpOworCiAJcmV0dXJuIHRyaXBfY250OwogfQogRVhQT1JUX1NZTUJPTF9HUEwoaW50MzQw
eF90aGVybWFsX3JlYWRfdHJpcHMpOwpAQCAtMjMwLDYgKzI0MCw4IEBAIHN0cnVjdCBpbnQzNHhf
dGhlcm1hbF96b25lICppbnQzNDB4X3RoZXJtYWxfem9uZV9hZGQoc3RydWN0IGFjcGlfZGV2aWNl
ICphZGV2LAogCWlmICghaW50MzR4X3RoZXJtYWxfem9uZSkKIAkJcmV0dXJuIEVSUl9QVFIoLUVO
T01FTSk7CiAKKwltdXRleF9pbml0KCZpbnQzNHhfdGhlcm1hbF96b25lLT50cmlwX211dGV4KTsK
KwogCWludDM0eF90aGVybWFsX3pvbmUtPmFkZXYgPSBhZGV2OwogCWludDM0eF90aGVybWFsX3pv
bmUtPm92ZXJyaWRlX29wcyA9IG92ZXJyaWRlX29wczsKIApAQCAtMjgxLDYgKzI5Myw3IEBAIHN0
cnVjdCBpbnQzNHhfdGhlcm1hbF96b25lICppbnQzNDB4X3RoZXJtYWxfem9uZV9hZGQoc3RydWN0
IGFjcGlfZGV2aWNlICphZGV2LAogCWFjcGlfbHBhdF9mcmVlX2NvbnZlcnNpb25fdGFibGUoaW50
MzR4X3RoZXJtYWxfem9uZS0+bHBhdF90YWJsZSk7CiAJa2ZyZWUoaW50MzR4X3RoZXJtYWxfem9u
ZS0+YXV4X3RyaXBzKTsKIGVycl90cmlwX2FsbG9jOgorCW11dGV4X2Rlc3Ryb3koJmludDM0eF90
aGVybWFsX3pvbmUtPnRyaXBfbXV0ZXgpOwogCWtmcmVlKGludDM0eF90aGVybWFsX3pvbmUpOwog
CXJldHVybiBFUlJfUFRSKHJldCk7CiB9CkBAIC0yOTIsNiArMzA1LDcgQEAgdm9pZCBpbnQzNDB4
X3RoZXJtYWxfem9uZV9yZW1vdmUoc3RydWN0IGludDM0eF90aGVybWFsX3pvbmUKIAl0aGVybWFs
X3pvbmVfZGV2aWNlX3VucmVnaXN0ZXIoaW50MzR4X3RoZXJtYWxfem9uZS0+em9uZSk7CiAJYWNw
aV9scGF0X2ZyZWVfY29udmVyc2lvbl90YWJsZShpbnQzNHhfdGhlcm1hbF96b25lLT5scGF0X3Rh
YmxlKTsKIAlrZnJlZShpbnQzNHhfdGhlcm1hbF96b25lLT5hdXhfdHJpcHMpOworCW11dGV4X2Rl
c3Ryb3koJmludDM0eF90aGVybWFsX3pvbmUtPnRyaXBfbXV0ZXgpOwogCWtmcmVlKGludDM0eF90
aGVybWFsX3pvbmUpOwogfQogRVhQT1JUX1NZTUJPTF9HUEwoaW50MzQweF90aGVybWFsX3pvbmVf
cmVtb3ZlKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJt
YWwvaW50MzQweF90aGVybWFsX3pvbmUuaCBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4
X3RoZXJtYWwvaW50MzQweF90aGVybWFsX3pvbmUuaAppbmRleCAzYjQ5NzFkZjFiMzMuLjhmOTg3
MmFmZDBkMyAxMDA2NDQKLS0tIGEvZHJpdmVycy90aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1h
bC9pbnQzNDB4X3RoZXJtYWxfem9uZS5oCisrKyBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQz
NDB4X3RoZXJtYWwvaW50MzQweF90aGVybWFsX3pvbmUuaApAQCAtMzIsNiArMzIsNyBAQCBzdHJ1
Y3QgaW50MzR4X3RoZXJtYWxfem9uZSB7CiAJc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2Vfb3Bz
ICpvdmVycmlkZV9vcHM7CiAJdm9pZCAqcHJpdl9kYXRhOwogCXN0cnVjdCBhY3BpX2xwYXRfY29u
dmVyc2lvbl90YWJsZSAqbHBhdF90YWJsZTsKKwlzdHJ1Y3QgbXV0ZXggdHJpcF9tdXRleDsKIH07
CiAKIHN0cnVjdCBpbnQzNHhfdGhlcm1hbF96b25lICppbnQzNDB4X3RoZXJtYWxfem9uZV9hZGQo
c3RydWN0IGFjcGlfZGV2aWNlICosCi0tIAoyLjM4LjEKCg==


--=-GbUfNslkOBgyVn/ErPpj--
