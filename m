Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFA460268A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiJRINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJRINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:13:23 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3D48FD58
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:13:22 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id y20so5244262uao.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NMWen063kjHSv41+KHkh7iCOekMntofpoetx09C1sC0=;
        b=FY5QM4c8dKCuXSTLaJrd0MNpR+eiDMWgeTShF8yYpJRQZDtkLWRbMhI3LIfbFDkwaA
         cnPmzvRcuUHcv3cG6QdPFGI2Jy2jIkA4plmZUTTgU18tflMOADxShon6XZMNopUJGTES
         t8jkW200HEznZnvtHgRB3XWtW6L2tJNUr5YUhTHrLG0sI3E6cGYuP+KC/rXnDQ8OTInF
         3ChuZLFehmcXiaQd7EGzW9nj6TEL0ZRLS36VSaLITqxwMY7Jp7XPGhikpT2Ue1TjdKkp
         EG//GHBjSvE2gP58DszdadvT7zTfHEXDjfbn7E3UJ6mTLpLjZy57vpOUc/bDL7JYtMZm
         7ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMWen063kjHSv41+KHkh7iCOekMntofpoetx09C1sC0=;
        b=cFQrDJrkavKXmUVrGqiH6wItUqSwZGr3J0f/ORUgrIBIZqvjXC6OAppyMAugj/gWTD
         6uX11pv5vG0SMHTu/KAerTOn5xmTt/vO8/FOodNlFlv2UFkjfAa2TzWmqHEzdY+h/jpk
         5dS1CLeFF7uj74RDrg8SlIY/xeskT8gMW82ABKE7YISykf6pMczbaLds7LRQA+oDIfpz
         6e1d6mvRw8DPpN0xvKmyZeNKd+scwQMOMh8NWuGBKOop71VKNxF56bs3dDlDKCJ8XUX0
         e+tZudt6sj7Mb1/FdtsDdo815423DHgn2CEhfzEBnBlYWhChRsc1J8xvr+oOeO3gOld5
         baeA==
X-Gm-Message-State: ACrzQf0deIMsrCPiCFB0QsUhDj0MNq78nvh8cFKkkyCjnj/vYC0Rnq+L
        9oywGrv0By2QpGr+QwGmMF8A58ijbagAPWpk010UsA==
X-Google-Smtp-Source: AMsMyM6brQLqJRZFJbrmuZceDf5wG7QVXbNGlTdyOcwqmY2CcwSz5X2mGWDXm61EMEKmYgLmhUYmMSyOIG6O9bhAvv0=
X-Received: by 2002:ab0:7412:0:b0:3d1:c2f7:3250 with SMTP id
 r18-20020ab07412000000b003d1c2f73250mr879228uap.21.1666080801748; Tue, 18 Oct
 2022 01:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsuc9G+RO81E=vHMqxYStsmLURLdOB0NF26kJ1=K8pRZA@mail.gmail.com>
 <7f576eb4-f8a6-53e0-17e9-285ecf03418c@redhat.com>
In-Reply-To: <7f576eb4-f8a6-53e0-17e9-285ecf03418c@redhat.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 18 Oct 2022 16:13:10 +0800
Message-ID: <CABVgOSnX7Dg9XttLL-63W=BrQMTisUCwmPGFCHnEfX2qS9KkTA@mail.gmail.com>
Subject: Re: not ok 1 - single_pixel_source_buffer: The buggy address belongs
 to the physical page
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005f49b805eb4aaab3"
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

--0000000000005f49b805eb4aaab3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 18, 2022 at 3:54 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> [adding a few folks to Cc list that might help with this issue]
>
> Hello Naresh,
>
> Thanks a lot for your report.
>
> On 10/18/22 08:40, Naresh Kamboju wrote:
> > Following kunit tests started failing on Linux mainline.
> >  - drm_format_helper_test =E2=80=94 FAIL
> >  - drm_test_fb_xrgb8888_to_xrgb2101010 =E2=80=94 FAIL
> >  - single_pixel_source_buffer =E2=80=94 FAIL
> >
> > Good: v6.0-3015-g2bca25eaeba6
> > Bad: v6.0-5118-g833477fce7a1
> >
>
> Could you please let me know how you are running this? I tried to reprodu=
ce it
> on v6.1-rc1 with the following command but all tests passed:
>
> ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/gpu/drm/tests/=
.kunitconfig --arch=3Dx86_64
> [09:41:53] Configuring KUnit Kernel ...
> [09:41:53] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=3Dx86_64 O=3D.kunit olddefconfig
> Building with:
> $ make ARCH=3Dx86_64 O=3D.kunit --jobs=3D8
> [09:45:51] Starting KUnit Kernel (1/1)...
> [09:45:51] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Running tests with:
> $ qemu-system-x86_64 -nodefaults -m 1024 -kernel .kunit/arch/x86/boot/bzI=
mage -append 'kunit.enable=3D1 console=3DttyS0 kunit_shutdown=3Dreboot' -no=
-reboot -nographic -serial stdio
> ...
> [09:47:40] Testing complete. Ran 195 tests: passed: 195
> [09:47:40] Elapsed time: 347.817s total, 0.003s configuring, 238.009s bui=
lding, 109.771s running

I can reproduce this with:
./tools/testing/kunit/kunit.py run --kunitconfig drivers/gpu/drm/tests
--kconfig_add CONFIG_KASAN=3Dy --kconfig_add CONFIG_KASAN_VMALLOC=3Dy
--kconfig_add CONFIG_KASAN_KUNIT_TEST=3Dy
drm_format_helper_test.*xrgb2101010

(The issue shows up only with KASAN enabled, and it looks like there's
a bug whereby KASAN failures don't trigger test failures unless
CONFIG_KASAN_KUNIT_TEST=3Dy)

It looks like the issue is probably with the conversion back to le32 here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/gpu/drm/tests/drm_format_helper_test.c#n441

That second call to le32buf_to_cpu() should probably take dst_size (or
rather, dst_size / sizeof(u32)) rather than using TEST_BUF_SIZE, which
is the maximum possible size of the buffer, not the actual size. That
fixes it here for me, though a proper fix would avoid the division.

Cheers,
-- David

--0000000000005f49b805eb4aaab3
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAS
P/SRJLj1tK2z8WfYTU2lkwJzG4R8GS2tHfXXMZueKTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEwMTgwODEzMjJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAISH71tqKyxO0devwcG9h
HFSqiRD+Q+NF4QvFdnDzrjqAx4L8+bwJh9I0daW4Kfb6fSJlSBxX9gb2kV8w5M/c3Mn7fBNDYYyE
4lac0/UMbjdiveJ1+oR8Nbtu8J/q93sRIJmovPWnzsYvV5vFkhS/2G4xaLM6/fIgw934Q9jJWl1l
WPZSfNjFK7WiamHx6Bis9aPihSpab3PNPnRwOXg6jjjRGViih0XW0oAl6/g7aiPipy1748jv37Gd
DDhQq84LilZiTW4dOi6IupVLrwztOWZwPbZ8ypg/yJMhyq+qYgT/4Fttz9NvQYEtZGnrTDTWww9j
Evy0FYNFqSHddVqk3g==
--0000000000005f49b805eb4aaab3--
