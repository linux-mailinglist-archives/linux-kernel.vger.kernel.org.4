Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47E567D57F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjAZTkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjAZTkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:40:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ABA10C3;
        Thu, 26 Jan 2023 11:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674762028; bh=3Cy3fCheTmqrR4p/UHrSVDCpMr75DaSNbA/rdAI8n7U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=HBa6NFSjxwkVC4icAYKaEvjCReBs6NeoPMh8yzRGk391NN4RwTbYrogm6AfFBTsRb
         57LXbqt0MgQYNtotRKkrgjTsnkRK9zn3ZmAmmrtVVj+9ivjH8Y/P+SWxsD3a1RwBQ2
         bWPWs0erExlgu1GzfNIhNVSXzRd0SpXGZs/XBkXDawDx0BuiHVfCraWzuqXIkvu1nz
         Pp/jW79KvDMZmg2TkXp0KCcgyZeM2Bo0TC9JldHcSTEqcppzRpXOEq7687LQRx7mCO
         5MVEUQNC+Jxhf58IVuMyLCzlXxmScwNy8NCpGj5QhMHDyFpzj1lcvmwbrJPbjlfHng
         UIOE27mVRR0CA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M5QFB-1pMV1F2FzJ-001NnE; Thu, 26 Jan 2023 20:40:28 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] platform/x86: dell-ddv: Various driver updates
Date:   Thu, 26 Jan 2023 20:40:16 +0100
Message-Id: <20230126194021.381092-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xs56crRTDDmuGrLXwfgHDSMS9wth5egEMSFsoUFS0MPo0fgEe6L
 1SuiXN15NOPi6kvgvZNICz1u51ZNbkGmeyr+pfGHGduf8HdhpygvZjnqG6Bg7hwjMOp/Bv2
 0ONQ1fZD5U27pU21BVzMB+I7zMiQ4Fl2n15qfLkJwopHrldk2Qw3EfWZjHDfAv9u0dSGVia
 1fy6GaISU3MuClFTZG9ZQ==
UI-OutboundReport: notjunk:1;M01:P0:ySjuomt81y0=;8mydRG8VOwe1OL2MnGsIjHoPX35
 kG8L/e17mbvxowjjKSTI2cqPLfqgNvcAlpbGoTuTwwuuG5MbkxJrde33C/z6smCwxzGSUv14s
 1tTFVZUy/KLgGqZ6XV6/JwFhu87DP2sJdW9SHiDWQpScfED5DbqTSjYvtphtteCanuGrz9G10
 5uTsnuwTxzC/YD6FbmOxpjaqmhCSsy4ooNbHfWmfvnYTXzkcXDHN6bu4nb6KUUVYF9rwKbNUE
 PNxnTmwDpEkcvRngb05jlQFE/E87xZXVT8upJpcX8kLGl9CZH4LwhWGCjnl2Ds8G2Yf6D0xSJ
 zlWwvS3TnV+6PqSCe/eKM0pEKw7piFHukjZkYgTI4Ttry9TR162bnEULMwYRF96olLga14DbM
 pXRq68OSWH5SUc91qxGhpDXwVlA7TTNBE2A6giKEUse5kSniNkpprbnxtPP8QvexjIADkGC/7
 U8tIqyAIvAyCAu7YSVHavy2q9xnyu9jDi2DdOCjZtFdnJUp9PZZGctsOo1o4O7zdth7BRTzFw
 NYjpk+PpVaV8oxbOSxg7A4QrI3ZYXz3MIGiQlIJ0kAybEf3HSNtVnPEkP4YloLVle7S/+qtvm
 iazn8OUdKa8ZzXuuabXRDGQSNyhKPpimPfh8OMlP/kHatPpode9468ja3Lb3w5s1JGv3Po4V7
 IYyy5tZjDTBYhZFIlEyztTXnplRXOHKDqnfzz/I3TqUI3KNhRc7/im1IjR3B8ijJbNT2nd3AE
 pCaG4ei8kVEthmNUH+KAEDunCGZtYF6aMj3Yw/ZhdcDYJOkfj7BKVDHah6awQVQAoZF0KooCa
 PO7CJ/unC05ouZaoADp692P/9Wj76+W5B1vtsBQgUZkRZXLhd/YZERBCnIzCNtvKto2FIbv80
 3LjN9bTxOlkDtBCRcLFzmfzTXaJIBD0ou2VRQX/fCuN3SKE3P5ZciKeZ6xBlhj8gXSwDAV7wO
 UtZ4YBLKGRNujdwrHAnWFmi+BfY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to bugreport 216655 on bugzilla, the contents of the
fan/thermal sensor buffers could be almost completely decoded.
It was also found out that newer Dell notebooks support a new
DDV WMI interface version, which just adds a additional method.

The first patch adds support for this new DDV WMI interface version,
while the second patch simplifies error handling then dealing with
empty buffers. The fourth patch adds a module param useful for testing
the driver on hardware exposing an unsupported DDV WMI interface
version. The last patch finally adds support for exposing the sensor
values over a standard hwmon interface.

The patch series was tested on a Dell Inspiron 3505, with the hwmon
patch being tested by multiple people over bugzilla and email. Those
who tested the final version of the hwmon patch are credited with
Tested-by tags.

Armin Wolf (5):
  platform/x86: dell-ddv: Add support for interface version 3
  platform/x86: dell-ddv: Return error if buffer is empty
  platform/x86: dell-ddv: Replace EIO with ENOMSG
  platform/x86: dell-ddv: Add "force" module param
  platform/x86: dell-ddv: Add hwmon support

 .../admin-guide/kernel-parameters.txt         |   3 +
 drivers/platform/x86/dell/Kconfig             |   1 +
 drivers/platform/x86/dell/dell-wmi-ddv.c      | 471 +++++++++++++++++-
 3 files changed, 465 insertions(+), 10 deletions(-)

=2D-
2.30.2

