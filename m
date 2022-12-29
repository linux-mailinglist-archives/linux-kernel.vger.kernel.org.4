Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DF365930C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiL2XH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiL2XHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:07:25 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4ED16485
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:07:24 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id o13so10486287ilc.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o7uei9zrAWrOOZeeNT79yAqnNOL1YbIB/w/YKJPnjdA=;
        b=iZpCxqVbZUIzuHPBmJ/9MdkYPOqbyQAqyEST2lYuwe5QRxSe25tdwf2MFki0Icl1o4
         1+3eanZv8CvCx/yZ7maSBfhwPlMVVSO5FDRDLwLdg87KZH06dPPwQo8rLomXZOKpOfiI
         2SN8GFtVMDhumg+wIjGl9ZOBB6a1TgKnx3DX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7uei9zrAWrOOZeeNT79yAqnNOL1YbIB/w/YKJPnjdA=;
        b=AkqdCqDk/AKaFC0+fbuT3Me0l9DfKRD47jR58ySLhJRbNhul2uaue88n9/H5r7F0d5
         RL8E0IuayiucXkzyyar9dKdvBhJ2bNmoywASEg+io75AB5EjdG2L0nDOq40D/5EIOIei
         E7BJpUPPCsxtKXEnH+Pz3amfJx1rJ43C5bI8dtPLQdUMF97zDNKhhGg/rhRDUPh8VARf
         EAmlEnNRjE+ySgPU+bUpfEQOjVmjQKVErhZkWFBXMuDRZV8/VKZ86j+gKQyzPGcbDMpe
         xPy+6Incald37M44S0Hx8gdWMrb/pa2ovS7RqA5Rig1bWaA2rGywve5zjV6LGw+dvVUI
         zM+g==
X-Gm-Message-State: AFqh2kooV0QzoQoaEYzCpjtPjU8oJtW1Am/8GROSvMh2Zs+lYME55jqu
        0fkWiYB1xN7Vun98siqSQrtUbA==
X-Google-Smtp-Source: AMrXdXsgkS/UOfQRcOyPX4s3Ojqm+h0bJ1IAG4FBmO9jBY0wiE+b3tOwYft3t6MQDwa6csoUWZDYIA==
X-Received: by 2002:a92:c9cb:0:b0:304:c683:3c8a with SMTP id k11-20020a92c9cb000000b00304c6833c8amr4063217ilq.3.1672355243696;
        Thu, 29 Dec 2022 15:07:23 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o3-20020a92d383000000b0030341bffab8sm5980440ilo.31.2022.12.29.15.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 15:07:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------Wui0JXF5eqvFybFanSvyLAih"
Message-ID: <226f1d09-aed1-e1c7-1607-e71393cd3a51@linuxfoundation.org>
Date:   Thu, 29 Dec 2022 16:07:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 6.2-rc2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------Wui0JXF5eqvFybFanSvyLAih
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 6.2-rc2.

This KUnit update for Linux 6.2-rc2 consists of:

- alloc_string_stream_fragment() error path fix to free before
   returning a failure.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.2-rc2

for you to fetch changes up to 93ef83050e597634d2c7dc838a28caf5137b9404:

   kunit: alloc_string_stream_fragment error handling bug fix (2022-12-26 16:01:36 -0700)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-6.2-rc2

This KUnit update for Linux 6.2-rc2 consists of:

- alloc_string_stream_fragment() error path fix to free before
   returning a failure.

----------------------------------------------------------------
YoungJun.park (1):
       kunit: alloc_string_stream_fragment error handling bug fix

  lib/kunit/string-stream.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)
----------------------------------------------------------------
--------------Wui0JXF5eqvFybFanSvyLAih
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-6.2-rc2.diff"
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-6.2-rc2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9zdHJpbmctc3RyZWFtLmMgYi9saWIva3VuaXQvc3Ry
aW5nLXN0cmVhbS5jCmluZGV4IGY1ZjUxMTY2ZDhjMi4uY2MzMjc0M2MxMTcxIDEwMDY0NAot
LS0gYS9saWIva3VuaXQvc3RyaW5nLXN0cmVhbS5jCisrKyBiL2xpYi9rdW5pdC9zdHJpbmct
c3RyZWFtLmMKQEAgLTIzLDggKzIzLDEwIEBAIHN0YXRpYyBzdHJ1Y3Qgc3RyaW5nX3N0cmVh
bV9mcmFnbWVudCAqYWxsb2Nfc3RyaW5nX3N0cmVhbV9mcmFnbWVudCgKIAkJcmV0dXJuIEVS
Ul9QVFIoLUVOT01FTSk7CiAKIAlmcmFnLT5mcmFnbWVudCA9IGt1bml0X2ttYWxsb2ModGVz
dCwgbGVuLCBnZnApOwotCWlmICghZnJhZy0+ZnJhZ21lbnQpCisJaWYgKCFmcmFnLT5mcmFn
bWVudCkgeworCQlrdW5pdF9rZnJlZSh0ZXN0LCBmcmFnKTsKIAkJcmV0dXJuIEVSUl9QVFIo
LUVOT01FTSk7CisJfQogCiAJcmV0dXJuIGZyYWc7CiB9Cg==

--------------Wui0JXF5eqvFybFanSvyLAih--
