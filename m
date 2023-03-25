Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A2A6C8BBA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjCYGac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCYGaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:30:30 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B7A13D44
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:30:29 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id j7so4769614ybg.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679725829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YCsz5gjxK6JQwSVDqvJoWgRcBVz6BRaMzthOQnV1Xtg=;
        b=lYfVk3ByclSJhcf+dSu5Q0P3ob5Jsw/QaRsNr0opHAS2MJljIc2xrcPa8jw+VjN2nc
         jGlVSDVMM68SFg9viGJbfMcA9o8Bs1Qxxat8fCmpk0Q3GdhG0hhBMrNYpvCsCBGq7pCi
         PRm66m5O1pV54oQb6b8D/11U06uZnup8f8LZeL7wTphtcPSBH/PB1xTySfZnpBmQRCNy
         n3pkpBdfUgPYi4Mya0A9dsF4v+OAR1CiSUaoNXI05MEfx+cplbggpvI7e9zn8oEBKvz9
         8Lk9D7kaZF8V9qU/MJ+hoeIV2o/N5Fs/2qrsWySL+cwCxKsbFWk3wiXB0ge5GQMGY8f5
         wPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679725829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCsz5gjxK6JQwSVDqvJoWgRcBVz6BRaMzthOQnV1Xtg=;
        b=5rVRFn8Eb+H7/rRT4wA9hXgFEGoFP0jI5GCesz4APgXUKXzRAxw6ZZSSUtRtgNfLSu
         hs5SXdz5tSyC3u2lKmvNndMmQUkbIezyDY7N9GmHC7PKOLPJRSL454c3NBqPsngr9bNJ
         d9iz5Hv/f0hvoxHdtDJqXIp5WYfKReEMWkW79HaRkMmiviOWaTsyA5ue5Ew/YrTnRzP/
         Weuq4v7CQzScsY/4UpGCOIaHogHJqmMXvMM216aNr422XWDiss2fQ1UJVkFOJuaWTLMa
         01w85S5pfA2RQuEnAQx5QlYEg2Ni+yMbDqMZXoaTXLF7dhBzznGWRhl2FSvDoEIX6w4y
         LT0A==
X-Gm-Message-State: AAQBX9clHB92fl9VoaJ4Bt/r0n5dHuy8pD36i1T1Fe0qBCGTcJx8M6iJ
        gKD6MLYbfCQ5hF0D9JaBMiymytfjfPum/ud8D0sPLA==
X-Google-Smtp-Source: AKy350ZI8rS91e72s6iQYNgW2v2lXMIlEhdukupUJUSrcC5WkCpmy53syKq8fSEd+NGE7oM1HAMlDxLKS+3qwQX2l0w=
X-Received: by 2002:a05:6902:1101:b0:b76:126b:5aa1 with SMTP id
 o1-20020a056902110100b00b76126b5aa1mr2390790ybu.8.1679725828666; Fri, 24 Mar
 2023 23:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230324-regmap-kunit-v1-0-62ef9cfa9b89@kernel.org> <20230324-regmap-kunit-v1-2-62ef9cfa9b89@kernel.org>
In-Reply-To: <20230324-regmap-kunit-v1-2-62ef9cfa9b89@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 25 Mar 2023 14:30:17 +0800
Message-ID: <CABVgOSmFkFihwT_AN0foqu+_=MQ_rJMPi7MKgj0Y8Dk0d_L2zA@mail.gmail.com>
Subject: Re: [PATCH 2/2] regmap: Add some basic kunit tests
To:     Mark Brown <broonie@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005b950505f7b3a57d"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005b950505f7b3a57d
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Mar 2023 at 08:27, Mark Brown <broonie@kernel.org> wrote:
>
> On the theory that it's better to make a start let's add some KUnit tests
> for regmap. Currently this is a bit of a mess but it passes and hopefully
> will at some point help catch problems. We provide very basic cover for
> most of the core functionality that operates at the register level,
> repeating each test for each cache type in order to exercise the caches.
> There is no coverage of anything to do with the bulk operations at the bus
> level or formatting for byte stream buses yet.
>
> Each test creates it's own regmap since the cache structures are built
> incrementally, meaning we gain coverage from the different access
> patterns, and some of the tests cover different init scenarios.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

It looks like regmap.basic_ranges is broken here (um, i386, arm64):
KTAP version 1
1..1
   KTAP version 1
   # Subtest: regmap
   1..1
       KTAP version 1
       # Subtest: basic_ranges
   # basic_ranges: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:399
   Expected data->written[test_range.selector_reg] to be true, but is false
   # basic_ranges: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:400
   Expected data->written[test_range.window_start] to be true, but is false
   # basic_ranges: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:408
   Expected data->written[test_range.selector_reg] to be true, but is false
   # basic_ranges: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:409
   Expected data->written[test_range.window_start] to be true, but is false
   # basic_ranges: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:415
   Expected data->written[test_range.selector_reg] to be true, but is false
   # basic_ranges: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:416
   Expected data->read[test_range.window_start] to be true, but is false
   # basic_ranges: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:424
   Expected data->written[test_range.selector_reg] to be true, but is false
   # basic_ranges: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:425
   Expected data->read[test_range.window_start] to be true, but is false
   # basic_ranges: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:429
   Expected data->read[i] to be false, but is true
   # basic_ranges: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:430
   Expected data->written[i] to be false, but is true
   # basic_ranges: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:429
   Expected data->read[i] to be false, but is true
   # basic_ranges: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:430
   Expected data->written[i] to be false, but is true
       not ok 1 none
<same for flat, rbtree>

The other tests all pass fine.

Am I missing a prerequisite?

Cheers,
-- David

--0000000000005b950505f7b3a57d
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAR
N9h7GAntwLiu3VyfwDn1Uy8Up29ALil0bHDWvQuqDzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMjUwNjMwMjlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEATALJGFEL6h4bpXAkDg3G
5nB2AdJarbqF2Ci2okv8TWAhMA06iujjLPTr4a0vAO94Gh/UTtCaTahA7hyvcJq/97BnU/IO9FKg
gseq0Dbl6TVTKSVnD6df6qzM4+Moyt5HIX9NfxDfzpu1991y4UzfuACpU9J7VqJ/UlXriPb582+G
IOdK33F+msaydOzM+/MKPAlroPelvEKcrWUt9YaVDl1J4xOkz81kiZNWwVFinMrGPFgFbk1D5CWm
spFtD7QwYJa6tQaQ3dW4u3kFaK/rIZOnObtVIXQkprM2z82EUqVrLVHrIhWVcJ/GLw88VnH+8s2i
fPIuPlKvht+K7Cy+gQ==
--0000000000005b950505f7b3a57d--
