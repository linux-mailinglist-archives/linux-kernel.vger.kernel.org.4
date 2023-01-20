Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6CF675A73
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjATQu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjATQus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:50:48 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AEECFD2D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:50:26 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id h10so807252ilq.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Pig0AkBOvaeFca7AUxlrmx+4DIj5cyOOxxsypim2SI=;
        b=EdhP42VuFoWrhtgTwaNy5bAFJbuwgCBIb4fnvsGiZnEq2wotooRzlRVRONyGRNDz8/
         YPQulmzKOV70jzz4TisRYDgVXMZdTD3xRgZNWxL8JKhvqKD6olJMWTzRzBDY+N/14X4B
         HeJ/qbl2GoKqH9lZC/IokvEbM3kNpLKnHMopk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Pig0AkBOvaeFca7AUxlrmx+4DIj5cyOOxxsypim2SI=;
        b=2QTJkeTkFp/LUhwgu6jSkj//lnl13l3scci1qO1jkfaC5+SqW0ojj/K8K1noKpbUCB
         0/X5RtCuof2uegR6lPd/QtjvnCoE366skqoPWvlcPsGZfNJG4sVF+phkI/xdlSnJ581S
         K91VDn+cuEPYSXcCO3ShINlKtUpZ2mZiHpvEzssiDMa4Q4Iiyiz9d9rF6B6qD8VXsVPp
         U5rjknL/9qaIVrB4VU8zlLRTH6wzGFaUMkFnUccRfmiyyNAu8CE6seP597h8vKAUZinF
         w/kqYKbhHk7XUP/8rUCc0TRn4gb8yag+T/jTWr/+9Tb4ANOwTgaOQzkm8hX6R0px+fBL
         FThA==
X-Gm-Message-State: AFqh2kqRnmOu19O7gjS0bOhzr49u8KJMHgTlo3M5O3YDwzDAk2v7iuoo
        HnYpuGBOY3uHUbivgzGBLpKi8A==
X-Google-Smtp-Source: AMrXdXuBr6OCQQnpIertUfxQPbY4vO4KliTWR0eET2QYTtdGcWqITjb7ezJqEQnY4htBQYSv3Os38g==
X-Received: by 2002:a92:2a07:0:b0:30c:1dda:42dd with SMTP id r7-20020a922a07000000b0030c1dda42ddmr2437637ile.1.1674233425999;
        Fri, 20 Jan 2023 08:50:25 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z7-20020a056638214700b003a2a167e7d9sm5239323jaj.96.2023.01.20.08.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 08:50:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------1klToZunSY0BdrxCM0DQGXVt"
Message-ID: <eff9a27c-3ebb-2529-fc97-ab4e74d6e437@linuxfoundation.org>
Date:   Fri, 20 Jan 2023 09:50:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.2-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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
--------------1klToZunSY0BdrxCM0DQGXVt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 6.2-rc5.

This Kselftest fixes update for Linux 6.2-rc5 consists of a single
fix to address error seen during unconfigured LLVM builds.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.2-rc5

for you to fetch changes up to 9fdaca2c1e157dc0a3c0faecf3a6a68e7d8d0c7b:

   kselftest: Fix error message for unconfigured LLVM builds (2023-01-12 13:38:04 -0700)

----------------------------------------------------------------
linux-kselftest-fixes-6.2-rc5

This Kselftest fixes update for Linux 6.2-rc5 consists of a single
fix address error seen during unconfigured LLVM builds.

----------------------------------------------------------------
Mark Brown (1):
       kselftest: Fix error message for unconfigured LLVM builds

  tools/testing/selftests/lib.mk | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
----------------------------------------------------------------
--------------1klToZunSY0BdrxCM0DQGXVt
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-6.2-rc5.diff"
Content-Disposition: attachment; filename="linux-kselftest-fixes-6.2-rc5.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpYi5tayBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2xpYi5tawppbmRleCAyOTExNDRjMjg0ZmIuLmY3OTAwZTc1ZDIz
MCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGliLm1rCisrKyBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpYi5tawpAQCAtMjAsNyArMjAsNyBAQCBDTEFOR19U
QVJHRVRfRkxBR1MgICAgICAgICAgICAgIDo9ICQoQ0xBTkdfVEFSR0VUX0ZMQUdTXyQoQVJD
SCkpCiAKIGlmZXEgKCQoQ1JPU1NfQ09NUElMRSksKQogaWZlcSAoJChDTEFOR19UQVJHRVRf
RkxBR1MpLCkKLSQoZXJyb3IgU3BlY2lmeSBDUk9TU19DT01QSUxFIG9yIGFkZCAnLS10YXJn
ZXQ9JyBvcHRpb24gdG8gbGliLm1rCiskKGVycm9yIFNwZWNpZnkgQ1JPU1NfQ09NUElMRSBv
ciBhZGQgJy0tdGFyZ2V0PScgb3B0aW9uIHRvIGxpYi5taykKIGVsc2UKIENMQU5HX0ZMQUdT
ICAgICArPSAtLXRhcmdldD0kKENMQU5HX1RBUkdFVF9GTEFHUykKIGVuZGlmICMgQ0xBTkdf
VEFSR0VUX0ZMQUdTCg==

--------------1klToZunSY0BdrxCM0DQGXVt--
