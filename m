Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FFB6DCE92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 02:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDKAwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 20:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDKAwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 20:52:06 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847A111C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:52:04 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r17so3235697pgr.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1681174324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v6V+o60g4Z94fKWiFocGXIM3dXpN2Q1E1XhBaapvdqE=;
        b=MxVaGynTHx79JmQkZ4SGsTuLdMrFz/0OMcjPJR/SOW6DBdaVY/tnw2IkkERVAPtvXw
         SlseE/frlHmeZvujHUxj972chtiF8/c6bdknyGzHnAIA5KQJu4Xl3Q9rKCbCJVjUVHAq
         i8IE/K0HSWIXbNg5aeEUV7dq4o1Li4efm8pgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681174324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6V+o60g4Z94fKWiFocGXIM3dXpN2Q1E1XhBaapvdqE=;
        b=6Fw2SDF+QiZxIfOi/6d70rB7fGZjQOCq8o6wSLpyXxlasx+Dh/7DPTKior1w7M6XfV
         vOObXRwVSJhhHHPscf7pZbuGVnIhuJ7AIyGaWn+jpQVMTgi9626cic+v27X1cfcHm1LP
         lHNcNNgZPesTeXizLumEyD1xgfUIOb5cl5VuvmhSyR2XZ39mSC7IbqkbhxkWVKsZ7VYX
         gZXY1hO1QNGfRD44JN/QVQgM9jxRrdqAfrr0d1XXA3xkrtzbM6FV4F0wI6Q3m3GQh3xt
         wxKG5Rg9SxHleX64GKaCIf0n7vpJjXBNkvJ4NsIZHgxYXYjN0dYE7r9wq9Z1FieExMIS
         ZoXA==
X-Gm-Message-State: AAQBX9duYrHK4cSj0dKBkPqp9m8xzWxRZ6eKiIj5d8IGFEVsagZRtFHe
        ZXl4rqsdfzfSEDG1kt6MyUSmaWaDr8MQ8aP4mB4mda0C8uAFW6YOHbI=
X-Google-Smtp-Source: AKy350ZArMX1FfQa9sqU2a5Ax2R/ev6+1te7gLj4D1FO2Rl9PU/nrbmif+QyMf7dDdRImTag8CbDmvQ+LxJxji5NOp8=
X-Received: by 2002:a63:5901:0:b0:513:290b:7516 with SMTP id
 n1-20020a635901000000b00513290b7516mr3042179pgb.3.1681174323741; Mon, 10 Apr
 2023 17:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230330072013.393245-1-alexander.komrakov@broadcom.com>
 <ZCU68tMu10hhsHgB@kroah.com> <CAMedr-_xinpsmzWO4G265gU4ofvvmGLBdZJ21LZyrd_X7DjaFQ@mail.gmail.com>
In-Reply-To: <CAMedr-_xinpsmzWO4G265gU4ofvvmGLBdZJ21LZyrd_X7DjaFQ@mail.gmail.com>
From:   Alex Komrakov <alexander.komrakov@broadcom.com>
Date:   Mon, 10 Apr 2023 17:51:27 -0700
Message-ID: <CAMedr--=4M48ASOEfGUxiRL0GTtRXgQKBxZR=5ij3F-kZ55kSQ@mail.gmail.com>
Subject: Re: [PATCH v5] [PATCH v5] pps: Add elapsed realtime timestamping
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, giometti@enneenne.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000067319905f904e690"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000067319905f904e690
Content-Type: text/plain; charset="UTF-8"

 greg k-h> Where is the Android code that needs this?  Have a pointer
to it anywhere?
 [AK]  https://cs.android.com/android/platform/superproject/+/master:cts/tests/location/location_gnss/src/android/location/cts/gnss/GnssLocationUpdateIntervalTest.java;drc=4788a776bc579841b0093c8f29215a1ce0686403;l=218]
 that requires 100ms accuracy. But you may challenge that 100ms
accuracy wouldn't require PPS.

greg k-h> My bot will remind you that you dropped the version information off :(
[AK] Done in [PATCH v6]:

greg k-h> That should be "ppsX" right?
 [AK]Done in [PATCH v6]:

 greg k-h> Why are your new entries above the main pps entry?
Shouldn't they be  below it?
 [AK] Done in [PATCH v6]:


>>
>> >
>> > Signed-off-by: Alexander Komrakov <alexander.komrakov@broadcom.com>
>> > ---
>> >  Documentation/ABI/testing/sysfs-pps | 27 +++++++++++++++++++++++
>> >  Documentation/driver-api/pps.rst    | 19 ++++++++++++++++
>> >  drivers/pps/kapi.c                  | 24 +++++++++++++++++---
>> >  drivers/pps/sysfs.c                 | 34 +++++++++++++++++++++++++++++
>> >  include/linux/pps_kernel.h          |  2 ++
>> >  5 files changed, 103 insertions(+), 3 deletions(-)
>>
>> My bot will remind you that you dropped the version information off :(
>>
>> > diff --git a/Documentation/ABI/testing/sysfs-pps b/Documentation/ABI/testing/sysfs-pps
>> > index 25028c7bc37d..031ec89e1ed6 100644
>> > --- a/Documentation/ABI/testing/sysfs-pps
>> > +++ b/Documentation/ABI/testing/sysfs-pps
>> > @@ -1,3 +1,30 @@
>> > +What:                /sys/class/pps/pps0/assert_elapsed
>>
>> That should be "ppsX" right?
>>
>> > +Date:                October 2021
>> > +Contact:     Alexander Komrakov <alexander.komrakov@broadcom.com>
>> > +Description:
>> > +             The /sys/class/pps/ppsX/assert_elapsed file reports the
>> > +             elapsed real-time assert events and the elapsed
>> > +             real-time assert sequence number of the X-th source
>> > +             in the form:
>> > +
>> > +                     <secs>.<nsec>#<sequence>
>> > +
>> > +             If the source has no elapsed real-time assert events
>> > +             the content of this file is empty.
>> > +
>> > +What:                /sys/class/pps/ppsX/clear_elapsed
>> > +Date:                October 2021
>> > +Contact:     Alexander Komrakov <alexander.komrakov@broadcom.com>
>> > +Description:
>> > +             The /sys/class/pps/ppsX/clear_elapsed file reports the elapsed
>> > +             real-time clear events and the elapsed real-time clear
>> > +             sequence number of the X-th source in the form:
>> > +
>> > +                     <secs>.<nsec>#<sequence>
>> > +
>> > +             If the source has no elapsed real-time clear events the
>> > +             content of this file is empty.
>> > +
>> >  What:                /sys/class/pps/
>>
>> Why are your new entries above the main pps entry?  Shouldn't they be
>> below it?
>>
>> thanks,
>>
>> greg k-h

--00000000000067319905f904e690
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
dlCTVYtojuUaRbmzA19y0yWkhdD+tvBz6ZhiadUNgctJrRB/eM/Haly51x78TAN/7VMnEWcMJOAI
VqjxmYlUuUSDPxgXnmYPrOW6BoN2Gdu8XPtl7PMaDi5hpmKwmXBjAgMBAAGjggHgMIIB3DAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCoGA1UdEQQjMCGBH2FsZXhhbmRlci5rb21yYWtvdkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFPkwjpj+
FmVF/4S+Xdk0AEyqpwxWMA0GCSqGSIb3DQEBCwUAA4IBAQCb5JMXul2vbdO/cV9H0z8JwNx+fZND
3wpL+BeVFFv2+CqHQUsGXEE2RfswQsmqO2oiD5oDDaxmQf7L4Oriw+KftdjmrJdJNCcMaJmhLNVw
YQeqEpOVnI5QlzKjUEwRqBpmbP01qvCoywUk+rP3NyesFiVLnFUTeclNnsdbwsbq7E9sAaDOmqaB
RHynszy96G2ivLxlhO8mmtesGggPPO1ZtDNoRtqLhCQ3w3dJwV11auZCqJEoMHzGxc7ZWKveQZnW
VfoQxBddLcnLJHjOvhYNiZrbpyPq0sCDoJpOlFH1MaXTVRYhUOIZ/brFvlUB3I/AC9nxzt6W37L1
7ma2ySaiMYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIM
BJ2duBPw/VvvslqDMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAfmQAUc0DHHGRO
U0g/xAUk0hkq2pwhgUQnuJACsqvlRzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0yMzA0MTEwMDUyMDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAcE/DSjuVL1obrbiyvKDf9nZTwXh140UY
IpMk9JeZz/V+P+SEhzj55UZv3Pj+YvlCHSi/wApfgMcmekXgI+0JJ0HGwYv6nxy9RjGFfwL+nT7D
SRTzeSTp+H7pfMXh+zl7F6BInQOd7PRKbvUxJneAaZY0LnXKJ0JjEOHcdXcmef2tPfSIbKc9fQSp
tbHW3K9TMf3DlGAT9oiijgEoV2KkHxmEi4xYgi8aJAyJmAMGb1tKhy6JMfv9mREkkFEKIYT+u9LK
AVEDG3SbHGP+hcS2/UyWwQ2jvNowSKIEaK8YhBmYo7PzZEmek0BjhXcZ8oLWBbLJfVyI18BYCVE8
OMghyA==
--00000000000067319905f904e690--
