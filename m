Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F04647E33
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 08:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiLIHDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 02:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiLIHCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 02:02:41 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BBE8B383
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 22:58:09 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id h26so3615437vsr.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 22:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9f+Xbbx/HTo/77SpZWiupFrDpNak4DycVVIAeUoIzD8=;
        b=gwwL7+npASAZz/0zjrKwP9qxdaz2luNfUKvGR2p/6Ejy9bHVCjmlukC/EV1lrOX/wi
         AcTHYsmfpBBdaI3l88eLvWLvRX6f+we4F4BtdTsup16Ghys+8pSJ1S/CakkMRaJCBdiK
         +WA6tbZaVAucztP/QOjlsXeoQyCo/rDg8NyK9LIhe90Dh0yk+h+r/GK3ya2nWTHu3XQA
         xzFA0nseJm3b8r37ej4mUlKJuhBiIsCrkXSbnGrXiFo04gRd9UVAiOsVnQ2iP5DDHOdm
         QJ4v64H87vK3xoDgVBNu9z3VeVtoeE38aiK4TBBWTLdGbi2pgx71R1Bg3GWR+B6/DHY2
         85bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9f+Xbbx/HTo/77SpZWiupFrDpNak4DycVVIAeUoIzD8=;
        b=TV8j8l0CXuFbkqtXNaOxeiR7cbSSrxQ1tGa2xTeHq5PWJ+Hm75l4eYs/d1aNqJ7Ele
         elcNh/b/FRNUKADAZUMmHNOu3y9uVmEY+5Mf6fhhhXAxlroeO1jk+2qNrS0cIcx4CmDx
         A6LpVwxPP89XDJ2W9U9esOe9F+Bw6AZOlWLlM0zyOOMMxu2ydYCy/9KRMPUog6qkczlG
         VYggtpQ4/ZeaGrUx//2crfuDsC3paM+wpGjjdyMRTbwiLXgypzHFR6kEPtUmEXg3Rf6s
         0TNz+1gIOb9ypvyNLlKUvBrYhmmks0sd64242UdzULwazeso8MUIgbLb/hBKgb/MvE4Q
         a3KA==
X-Gm-Message-State: ANoB5pk/+k1mOAegqJqmkrC11ZxeuRS2o6qGMmopD1e/ywXr/11O5A/r
        3/3svErFU03C+x6EZJ5ZxyVxBxrasBlZ/TzRIamCdw==
X-Google-Smtp-Source: AA0mqf78vvTGszPzbnlActIOpUOTI2XgBESLT+QC8csdeW7JDj98XaQLNB8h719MY58WpeT8qrXTavyVf9DIgNjkedU=
X-Received: by 2002:a05:6102:5785:b0:3b0:7178:7fe8 with SMTP id
 dh5-20020a056102578500b003b071787fe8mr38242211vsb.38.1670569088056; Thu, 08
 Dec 2022 22:58:08 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYu5JjZzpFfNOqzLV+KQnSL1VU7n8Yv-FrZYvuvwo1Ayug@mail.gmail.com>
In-Reply-To: <CA+G9fYu5JjZzpFfNOqzLV+KQnSL1VU7n8Yv-FrZYvuvwo1Ayug@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 9 Dec 2022 14:57:55 +0800
Message-ID: <CABVgOSms-8vXDVX68JX-4UEnaGyCgVyNWH37W8qGz7eVtFcWag@mail.gmail.com>
Subject: Re: security: policy_unpack.c:325:10: error: use of undeclared
 identifier 'TRI_TRUE'
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, apparmor@lists.ubuntu.com,
        Nick Terrell <terrelln@fb.com>,
        John Johansen <john.johansen@canonical.com>,
        Rae Moar <rmoar@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000165b8a05ef5fad8a"
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

--000000000000165b8a05ef5fad8a
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Dec 2022 at 15:36, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Following build regresion found on Linux next-20221208 tag.
>
> Regressions found on riscv:
>   - build/clang-nightly-defconfig
>   - build/gcc-8-defconfig
>   - build/gcc-11-defconfig
>   - build/clang-15-defconfig
>
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
> ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- 'HOSTCC=sccache clang'
> 'CC=sccache clang' defconfig
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
> ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- 'HOSTCC=sccache clang'
> 'CC=sccache clang'
> security/apparmor/policy_unpack.c:316:18: error: unknown type name 'tri'
> VISIBLE_IF_KUNIT tri aa_unpack_array(struct aa_ext *e, const char
> *name, u16 *size)
>                  ^
> security/apparmor/policy_unpack.c:325:10: error: use of undeclared
> identifier 'TRI_TRUE'
>                 return TRI_TRUE;
>                        ^
> security/apparmor/policy_unpack.c:328:9: error: use of undeclared
> identifier 'TRI_NONE'
>         return TRI_NONE;
>                ^
> security/apparmor/policy_unpack.c:331:9: error: use of undeclared
> identifier 'TRI_FALSE'
>         return TRI_FALSE;
>                ^
> security/apparmor/policy_unpack.c:455:42: error: use of undeclared
> identifier 'TRI_TRUE'
>                 if (aa_unpack_array(e, NULL, &size) != TRI_TRUE)
>                                                        ^
> security/apparmor/policy_unpack.c:529:42: error: use of undeclared
> identifier 'TRI_TRUE'
>                 if (aa_unpack_array(e, NULL, &size) != TRI_TRUE)
>                                                        ^
> security/apparmor/policy_unpack.c:559:42: error: use of undeclared
> identifier 'TRI_TRUE'
>                 if (aa_unpack_array(e, NULL, &size) != TRI_TRUE)
>                                                        ^
> security/apparmor/policy_unpack.c:611:42: error: use of undeclared
> identifier 'TRI_TRUE'
>                 if (aa_unpack_array(e, NULL, &size) != TRI_TRUE ||
>                                                        ^
> security/apparmor/policy_unpack.c:674:42: error: use of undeclared
> identifier 'TRI_TRUE'
>                 if (aa_unpack_array(e, NULL, &size) != TRI_TRUE)
>                                                        ^
> 9 errors generated.
> make[4]: *** [scripts/Makefile.build:252:
> security/apparmor/policy_unpack.o] Error 1
> make[4]: Target 'security/apparmor/' not remade because of errors.
> make[3]: *** [scripts/Makefile.build:504: security/apparmor] Error 2
>
> Build link,
>   - https://builds.tuxbuild.com/2IcJeyR3s4kGd2Nca8vVq7Sleao/
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221208/testrun/13508560/suite/build/test/gcc-11-defconfig/details/
>
> Build results comparison:
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221208/testrun/13508560/suite/build/test/gcc-11-defconfig/history/
>
>
> steps to reproduce:
> # To install tuxmake on your system globally:
> # sudo pip3 install -U tuxmake
> #
> # See https://docs.tuxmake.org/ for complete documentation.
> # Original tuxmake command with fragments listed below.
> # tuxmake --runtime podman --target-arch riscv --toolchain gcc-11
> --kconfig defconfig
>
>
> tuxmake --runtime podman --target-arch riscv --toolchain gcc-11
> --kconfig https://builds.tuxbuild.com/2IcJeyR3s4kGd2Nca8vVq7Sleao/config
>
> --
> Linaro LKFT
> https://lkft.linaro.org

I suspect this is in need of the fix here:
https://lore.kernel.org/all/bff89220-df3a-a148-2ba4-6aad3874f322@canonical.com/

Cheers,
-- David

--000000000000165b8a05ef5fad8a
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC0
pHc88TDcIHKN1zFq4z5vAnqHEhCLRh61epNjoFoY/jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEyMDkwNjU4MDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAR8EhmjJo+IF4YNXEp4co
iSSb636ziNwYr6nOuP+I8b17oqSwceTwk26otCFe8tfklzr43oRwahPUmPROZcrKte6y732xS8x+
uvjHT510VZhPOtpJY3xGoS52poxYbBi+XBfcpDDpSm5sa6AHMM6gVEIUS9SfqjlfD/prqXEL+aEr
6hKQG8SFg+rThQX1sBs/4x0MyDyDebi3BtEwpHEtnqmZD0RAEydY+dockRlk4a9c2G+69CSbYw5G
mNyI8WaV1sRBwDugl7VlA+LPqsLU/ZWNCadeW41gzQAOoXkEUy5jcKWbSIqEpBRo0EYkz18cI8LM
rKpx73Bzxt/X+29dXg==
--000000000000165b8a05ef5fad8a--
