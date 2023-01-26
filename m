Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD8367D68C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjAZUhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAZUhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:37:18 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A45728EC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:37:16 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id h10so1293139ilq.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3eT8OlmJ/cvpeFa+CMg7lyhz2OoajpKwuYq94B2ZkiQ=;
        b=cW9hmEOQ1/8OV4wVUy3XmSkGeoIzCwJ+DKcyUKz1ZGmDgHdGf2xwXE72ELEJvckmZU
         P14K8LthH+Yv3LUFXX3K2qk8vUZMHYmb8IcQxxd2arJNhuC1c93CaazNLSB4e8dpGv0y
         v3GLPJEcrz92/H5KCrsJ5VG9g0G9ImqyFB8Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eT8OlmJ/cvpeFa+CMg7lyhz2OoajpKwuYq94B2ZkiQ=;
        b=FsVH1as2y0q3NSf2r/i2Ip45waPo6DcGA+l7lD8JIm13fkQUmpZFtA5zrLKjr9KN87
         CLEnAu3X3qrBHTyq31XWczPpIcBvrZ5jTlhBhSWXEvtuYYx8Lj7jy7HJ/hpxfTn5sEdk
         POtagWoX86GhCyZOOdhUAiR7tIQYzNR/tIyzMW/MJkw09Zz9V8CGeFY9kcldBFmvKFcu
         6JykZz7kyO2EDo1IbfuSxkmJGttxKwXhWOVIAJhpYFo/GvAs/fgkJ5jBc7Ib21qJp3MJ
         4SCND0JpIkSLgex1az8RDPaqAHHgo+INIgRkXHqzbXFzTLDyyXrYWtRMlBmoPJF2cXzP
         gF6w==
X-Gm-Message-State: AO0yUKU4USmnEJ1Kuo+pFOPP70aBChfSkuX0Tw/Pz8uDNh4TcUJ9TBLz
        MpQVM2Wi28od3oAK/kX/rKLQug==
X-Google-Smtp-Source: AK7set+ZAYNF5Gm2Q/PzHEOSck1J/FKk8Wd90kiTp9R+X3GrE7zuFFDhukCNaDrchud6aJTKXaZFgA==
X-Received: by 2002:a92:7f01:0:b0:310:bcf6:9acd with SMTP id a1-20020a927f01000000b00310bcf69acdmr297671ild.3.1674765436147;
        Thu, 26 Jan 2023 12:37:16 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i16-20020a02cc50000000b0039e97f04e1esm742133jaq.155.2023.01.26.12.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 12:37:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------rtJyWblrBlrD4sA9gfXE41Ey"
Message-ID: <3bbe9344-4546-5bd1-52ae-ed6532528e6c@linuxfoundation.org>
Date:   Thu, 26 Jan 2023 13:37:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.2-rc6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------rtJyWblrBlrD4sA9gfXE41Ey
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 6.2-rc6.

This Kselftest fixes update for Linux 6.2-rc6 consists of a single
fix to a amd-pstate test Makefile bug that deletes source files
during make clean run.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 9fdaca2c1e157dc0a3c0faecf3a6a68e7d8d0c7b:

   kselftest: Fix error message for unconfigured LLVM builds (2023-01-12 13:38:04 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.2-rc6

for you to fetch changes up to a49fb7218ed84a4c5e6c56b9fd933498b9730912:

   selftests: amd-pstate: Don't delete source files via Makefile (2023-01-25 10:01:35 -0700)

----------------------------------------------------------------
linux-kselftest-fixes-6.2-rc6

This Kselftest fixes update for Linux 6.2-rc6 consists of a single
fix to a amd-pstate test Makefile bug that deletes source files
during make clean run.

----------------------------------------------------------------
Doug Smythies (1):
       selftests: amd-pstate: Don't delete source files via Makefile

  tools/testing/selftests/amd-pstate/Makefile | 5 -----
  1 file changed, 5 deletions(-)
----------------------------------------------------------------
--------------rtJyWblrBlrD4sA9gfXE41Ey
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-6.2-rc6.diff"
Content-Disposition: attachment; filename="linux-kselftest-fixes-6.2-rc6.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2FtZC1wc3RhdGUvTWFrZWZp
bGUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9hbWQtcHN0YXRlL01ha2VmaWxlCmluZGV4
IDVmMTk1ZWU3NTZkNi4uNWZkMTQyNGRiMzdkIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9hbWQtcHN0YXRlL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2FtZC1wc3RhdGUvTWFrZWZpbGUKQEAgLTcsMTEgKzcsNiBAQCBhbGw6CiB1bmFt
ZV9NIDo9ICQoc2hlbGwgdW5hbWUgLW0gMj4vZGV2L251bGwgfHwgZWNobyBub3QpCiBBUkNI
ID89ICQoc2hlbGwgZWNobyAkKHVuYW1lX00pIHwgc2VkIC1lIHMvaS44Ni94ODYvIC1lIHMv
eDg2XzY0L3g4Ni8pCiAKLWlmZXEgKHg4NiwkKEFSQ0gpKQotVEVTVF9HRU5fRklMRVMgKz0g
Li4vLi4vLi4vcG93ZXIveDg2L2FtZF9wc3RhdGVfdHJhY2VyL2FtZF9wc3RhdGVfdHJhY2Uu
cHkKLVRFU1RfR0VOX0ZJTEVTICs9IC4uLy4uLy4uL3Bvd2VyL3g4Ni9pbnRlbF9wc3RhdGVf
dHJhY2VyL2ludGVsX3BzdGF0ZV90cmFjZXIucHkKLWVuZGlmCi0KIFRFU1RfUFJPR1MgOj0g
cnVuLnNoCiBURVNUX0ZJTEVTIDo9IGJhc2ljLnNoIHRiZW5jaC5zaCBnaXRzb3VyY2Uuc2gK
IAo=

--------------rtJyWblrBlrD4sA9gfXE41Ey--
