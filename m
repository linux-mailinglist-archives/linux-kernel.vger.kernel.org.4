Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3A55F19C4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 06:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJAENy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 00:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJAENt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 00:13:49 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB015D116
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 21:13:48 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id q127so557993vsb.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 21:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=az3JWNtQIYwst/YHnOAoM0fl5jj8O7bI3wUNGblAbVs=;
        b=SR6eaCTQlhoUpYnRp8i6RKgji3nUydxU1G6i4wAI1o9yOw+80rd8EVryA2KlMWw92Z
         Mi4qdKH1/FAJKxl81Oj+fz87j/qPf8zSvh3UNwL9FFWhqrA40eva9Sfa/T7ipz9SKnqK
         MHsVDv6zAsPbnLWxFNu4WbyR/FjPuh7IlJjiofPp8jXYQYM/KpTQQi4H0X+dwrM94FBs
         zjkj/J73xu8NX5hbBxaltdfqMfqbt2s+FSlE6pSLnzrzsMBWgswJ+wDmTCkAr/+ZbTFF
         YKr78ySDtrOYQ/tBMZ+E7Ds4HfcfELGbsu2er+L1ahbRzSuydt5nhIhwlWNolIvioda4
         qJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=az3JWNtQIYwst/YHnOAoM0fl5jj8O7bI3wUNGblAbVs=;
        b=o1SU/wohf56sbcGK2jMEnVM8a7mNRDXbPWo+CnOI9YVIl8dTnUheL0ZmTC+3mn+E2V
         pteTSqiix4lonMrW11odDECyuhXi5Ot6ipiY1SeUqFk9VMQIK1k2JZAKIjm+sPzm0puv
         6bWkpCyirJ++AuplMnyhXWUv6T0dS880ZTXhaAaww0KYrJexAwlUVVmNehJEsFRLTRgl
         XCOaaKq8TG2jlLzPVA/YtaMZHyUhrDL8wDQFM+cGMwzLojeuXj5lupXIJEIGvrzIANsc
         5jx/no5cXMcv3R7at6rynOFjXm20sOcgaPlyrvaV98SzSmmuqF4HmXffNAMz3SAjtxxP
         ftKA==
X-Gm-Message-State: ACrzQf2EuDhOIpswkx/VQ3I4kvHuAgDamvzgzutA63Dsof1/UYfypaci
        K7KnEzXbCIHBv9TujZVyPffMId392pejDJ9869wiIQmt47k1uQ==
X-Google-Smtp-Source: AMsMyM5ApvVl++SKO3Vz8lEhweFNfC9tMnRsUoEYiO3XkQKJjJBf+tyatFml0jry6l9ftZ0Gj7soeQDQMs4Q//1FrD8=
X-Received: by 2002:a67:d908:0:b0:3a6:4768:bc3 with SMTP id
 t8-20020a67d908000000b003a647680bc3mr24652vsj.38.1664597627036; Fri, 30 Sep
 2022 21:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com> <20221001002638.2881842-3-dlatypov@google.com>
 <CABVgOSn3SupF_z84FghxX-yK-CLx_RQMkUxF_hGUw6a3w7h-7Q@mail.gmail.com> <CAGS_qxpDdAz6DZxojhnh_XRuJ4MR-oQkQNCES_Lpe1OEO8QTUQ@mail.gmail.com>
In-Reply-To: <CAGS_qxpDdAz6DZxojhnh_XRuJ4MR-oQkQNCES_Lpe1OEO8QTUQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 1 Oct 2022 12:13:35 +0800
Message-ID: <CABVgOSmcheQvBRKqc-0ftmbthx=EReoQ-910QV0QMNuxLWjTUQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] kunit: rename base KUNIT_ASSERTION macro to _KUNIT_FAILED
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000044ba4805e9f1560e"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000044ba4805e9f1560e
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 1, 2022 at 11:50 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Fri, Sep 30, 2022 at 8:26 PM David Gow <davidgow@google.com> wrote:
> >
> > On Sat, Oct 1, 2022 at 8:26 AM 'Daniel Latypov' via KUnit Development
> > <kunit-dev@googlegroups.com> wrote:
> > >
> > > Context:
> > > Currently this macro's name, KUNIT_ASSERTION conflicts with the name of
> > > an enum whose values are {KUNIT_EXPECTATION, KUNIT_ASSERTION}.
> > >
> > > It's hard to think of a better name for the enum, so rename this macro.
> > > It's also a bit strange that the macro might do nothing depending on the
> > > boolean argument `pass`. Why not have callers check themselves?
> > >
> > > This patch:
> > > Moves the pass/fail checking into the callers of KUNIT_ASSERTION, so now
> > > we only call it when the check has failed.
> > > Then we rename the macro the _KUNIT_FAILED() to reflect the new
> > > semantics.
> > >
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > ---
> >
> > Looks good to me. I can't say the name _KUNIT_FAILED() feels perfect
> > to me, but I can't think of anything better, either. We've not used a
> > leading underscore for internal macros much thus far, as well, though
> > I've no personal objections to starting.
>
> Yeah, I also didn't add a leading underscore on the new
> KUNIT_INIT_ASSERT() macro elsewhere in this series.
> So I'm not necessarily proposing that we should start doing so here.

Yeah: I noticed that. In general, I think I come down slightly on the
side of avoiding leading underscores. (And there's also the debate
about whether to have one or two, as while two underscores is
nominally "reserved for the system", the kernel uses it a lot --
probably because it considers itself "the system"). So I'd tend to
lean away from making all of our "internal" macros start with
underscores.
>
> It feels like that KUNIT_FAILED is far too similar to the enum
>     55 enum kunit_status {
>     56         KUNIT_SUCCESS,
>     57         KUNIT_FAILURE,
>     58         KUNIT_SKIPPED,
>     59 };
>
> I.e. we'd be remove one naming conflict between a macro and enum, but
> basically introducing a new one in its place :P
> Tbh, I was originally going to have this patch just be
> s/KUNIT_ASSERTION()/_KUNIT_ASSERTION() to reduce the conflict.
> But I figured we could reduce the number of arguments to the macro
> (drop `pass`) and have a reason to give it a different name.
>
> I'm also not entirely convinced about _KUNIT_FAILED(), but I haven't
> had any significantly better ideas since I sent the RFC in May.

Agreed: particularly since SKIPPED would seem to pair better with
FAILED than FAILURE, so they conflict quite a bit.

Let's stick with what we have in this change, and we can change it
later if someone comes up with a drastically better name.

Cheers,
-- David

--00000000000044ba4805e9f1560e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCU
RVhFZMl1+l4Il8Ys6VgFEBnrQ0pPeZo+RIzDD+YGNDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEwMDEwNDEzNDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAULwLDIwSE4PtSNkObffD
V9G2KlSRVu50PNa66nXSusjLlsqcVXY/1+WP8DnSPSJ7nZBGPGDmRLAusEoS0tluIPPr7f9HO4Np
9mv4XVmS27UTvXcWKIGaL187ST4W7xVSgfQZPVxGAs5pT84aVxbwb6u1A1eupQKgscocGVQz8Vce
h5k6f2eRJBof0/rxFpEzL7h6Bl8DuFpZywmoB9YvcxRT5zvD/AiXxczH1YGHmgocO4Vv4JUxceMW
gK2HiGqCXDjKHHQd/uh+gWqu8IWcrPtIpMKaxBVqWk36IfmS1QGkZZKiGc3WAFIglVCsEgpVBVWF
7F0mE0pYQv93NP9kpQ==
--00000000000044ba4805e9f1560e--
