Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFDE7070C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjEQS1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEQS04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:26:56 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37FC1739
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:26:55 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-760dff4b701so6962839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684348015; x=1686940015;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SefrbI4luUxkGPhDruiHFtUBNRN3yZ6zgSDA+Ss60NY=;
        b=H3JFE1jHp5TEZJc7lLOVSzFimQ6OuqRvaHdKgsh+0FijfB4S8X+4Tpfty2B9sQuhxu
         JavwJmSIC6V4ciE5nSbf0L13cOleRE84BdxZhvMy4Xhsu0bEvFRR8CJBkT7CMyKfC/44
         MTt+JfNXAMlgq9M/jF4jAz+BKxEbqLw1jK6Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684348015; x=1686940015;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SefrbI4luUxkGPhDruiHFtUBNRN3yZ6zgSDA+Ss60NY=;
        b=iq36ieO3seiAk9WE5IBIGgTAB9lqroudEOPs0Bqi7evntyymAIKEwCCBFc7HCYjGG9
         VEa1Wk+dzpn2SG8/MURV3asmWzcI2QzUF7VvlRqj9jsto6VJm63iUJDEqWvSd2HIovyx
         P2gRwAj8oWCEA207knhNiMT5v9GXTi0N7sgIYSN34C8vQ4pkO8s3BzedLEb0U9Gb2vwW
         9EcXHQv2bMj6L3/cD0yrYR7GZayz2l0xL+C8oKAjoU8vc+TsWgKrS0XMLO/icblvNFkg
         4HeW0stCnjT3U2aNmkbsOhsEoTTCpGOVNQl3jCW8Us3szz0bgbsAz/0CFabPX1I2vJjh
         LNLg==
X-Gm-Message-State: AC+VfDwwfPfp39mFuG0p6rIV2q8V72AKzTl1S6o5fioeKYgNjcax0uYC
        4he50yNr57bbPjjoU7Mt3Vw8DA==
X-Google-Smtp-Source: ACHHUZ4f//BL/tJ6X+98JURia5it3s8oKIZoUOVYBr7jSyI9pGhj6RAqk9wyfzBF1hn33q0tLld4YA==
X-Received: by 2002:a05:6e02:1b0d:b0:332:fcce:c26d with SMTP id i13-20020a056e021b0d00b00332fccec26dmr2703997ilv.0.1684348014895;
        Wed, 17 May 2023 11:26:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b6-20020a92dcc6000000b003350c8ae201sm7593874ilr.29.2023.05.17.11.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 11:26:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------9IyDAsnkaVQo7hLHfcxwSE0e"
Message-ID: <8abea32a-4895-7826-8a9c-9ddc5a7ad2bd@linuxfoundation.org>
Date:   Wed, 17 May 2023 12:26:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
        Thomas Renninger <trenn@suse.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.4-rc3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9IyDAsnkaVQo7hLHfcxwSE0e
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 6.4-rc3 or for
a later rc.

This cpupower fixes update for Linux 6.4-rc3 consists of:

- a resource leak fix
- fix drift in C0 percentage calculation due to System-wide TSC read.
   To lower this drift read TSC per CPU and also just after mperf read.
   This technique improves C0 percentage calculation in Mperf monitor

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

   Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.4-rc3

for you to fetch changes up to c2adb1877b76fc81ae041e1db1a6ed2078c6746b:

   cpupower: Make TSC read per CPU for Mperf monitor (2023-05-08 10:46:49 -0600)

----------------------------------------------------------------
linux-cpupower-6.4-rc3

This cpupower fixes update for Linux 6.4-rc3 consists of:

- a resource leak fix
- fix drift in C0 percentage calculation due to System-wide TSC read.
   To lower this drift read TSC per CPU and also just after mperf read.
   This technique improves C0 percentage calculation in Mperf monitor

----------------------------------------------------------------
Hao Zeng (1):
       cpupower:Fix resource leaks in sysfs_get_enabled()

Wyes Karny (1):
       cpupower: Make TSC read per CPU for Mperf monitor

  tools/power/cpupower/lib/powercap.c                | 23 +++++++++++-----
  .../cpupower/utils/idle_monitor/mperf_monitor.c    | 31 ++++++++++------------
  2 files changed, 30 insertions(+), 24 deletions(-)

----------------------------------------------------------------
--------------9IyDAsnkaVQo7hLHfcxwSE0e
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.4-rc3.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.4-rc3.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9wb3dlcmNhcC5jIGIvdG9v
bHMvcG93ZXIvY3B1cG93ZXIvbGliL3Bvd2VyY2FwLmMKaW5kZXggMGNlMjllZTRjMmU0Li5h
N2E1OWM2YmFjZGEgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9wb3dl
cmNhcC5jCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9wb3dlcmNhcC5jCkBAIC00
MCwyNSArNDAsMzQgQEAgc3RhdGljIGludCBzeXNmc19nZXRfZW5hYmxlZChjaGFyICpwYXRo
LCBpbnQgKm1vZGUpCiB7CiAJaW50IGZkOwogCWNoYXIgeWVzX25vOworCWludCByZXQgPSAw
OwogCiAJKm1vZGUgPSAwOwogCiAJZmQgPSBvcGVuKHBhdGgsIE9fUkRPTkxZKTsKLQlpZiAo
ZmQgPT0gLTEpCi0JCXJldHVybiAtMTsKKwlpZiAoZmQgPT0gLTEpIHsKKwkJcmV0ID0gLTE7
CisJCWdvdG8gb3V0OworCX0KIAogCWlmIChyZWFkKGZkLCAmeWVzX25vLCAxKSAhPSAxKSB7
Ci0JCWNsb3NlKGZkKTsKLQkJcmV0dXJuIC0xOworCQlyZXQgPSAtMTsKKwkJZ290byBvdXRf
Y2xvc2U7CiAJfQogCiAJaWYgKHllc19ubyA9PSAnMScpIHsKIAkJKm1vZGUgPSAxOwotCQly
ZXR1cm4gMDsKKwkJZ290byBvdXRfY2xvc2U7CiAJfSBlbHNlIGlmICh5ZXNfbm8gPT0gJzAn
KSB7Ci0JCXJldHVybiAwOworCQlnb3RvIG91dF9jbG9zZTsKKwl9IGVsc2UgeworCQlyZXQg
PSAtMTsKKwkJZ290byBvdXRfY2xvc2U7CiAJfQotCXJldHVybiAtMTsKK291dF9jbG9zZToK
KwljbG9zZShmZCk7CitvdXQ6CisJcmV0dXJuIHJldDsKIH0KIAogaW50IHBvd2VyY2FwX2dl
dF9lbmFibGVkKGludCAqbW9kZSkKZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2Vy
L3V0aWxzL2lkbGVfbW9uaXRvci9tcGVyZl9tb25pdG9yLmMgYi90b29scy9wb3dlci9jcHVw
b3dlci91dGlscy9pZGxlX21vbml0b3IvbXBlcmZfbW9uaXRvci5jCmluZGV4IGU3ZDQ4Y2I1
NjNjMC4uYWU2YWYzNTRhODFkIDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci91
dGlscy9pZGxlX21vbml0b3IvbXBlcmZfbW9uaXRvci5jCisrKyBiL3Rvb2xzL3Bvd2VyL2Nw
dXBvd2VyL3V0aWxzL2lkbGVfbW9uaXRvci9tcGVyZl9tb25pdG9yLmMKQEAgLTcwLDggKzcw
LDggQEAgc3RhdGljIGludCBtYXhfZnJlcV9tb2RlOwogICovCiBzdGF0aWMgdW5zaWduZWQg
bG9uZyBtYXhfZnJlcXVlbmN5OwogCi1zdGF0aWMgdW5zaWduZWQgbG9uZyBsb25nIHRzY19h
dF9tZWFzdXJlX3N0YXJ0Owotc3RhdGljIHVuc2lnbmVkIGxvbmcgbG9uZyB0c2NfYXRfbWVh
c3VyZV9lbmQ7CitzdGF0aWMgdW5zaWduZWQgbG9uZyBsb25nICp0c2NfYXRfbWVhc3VyZV9z
dGFydDsKK3N0YXRpYyB1bnNpZ25lZCBsb25nIGxvbmcgKnRzY19hdF9tZWFzdXJlX2VuZDsK
IHN0YXRpYyB1bnNpZ25lZCBsb25nIGxvbmcgKm1wZXJmX3ByZXZpb3VzX2NvdW50Owogc3Rh
dGljIHVuc2lnbmVkIGxvbmcgbG9uZyAqYXBlcmZfcHJldmlvdXNfY291bnQ7CiBzdGF0aWMg
dW5zaWduZWQgbG9uZyBsb25nICptcGVyZl9jdXJyZW50X2NvdW50OwpAQCAtMTY5LDcgKzE2
OSw3IEBAIHN0YXRpYyBpbnQgbXBlcmZfZ2V0X2NvdW50X3BlcmNlbnQodW5zaWduZWQgaW50
IGlkLCBkb3VibGUgKnBlcmNlbnQsCiAJYXBlcmZfZGlmZiA9IGFwZXJmX2N1cnJlbnRfY291
bnRbY3B1XSAtIGFwZXJmX3ByZXZpb3VzX2NvdW50W2NwdV07CiAKIAlpZiAobWF4X2ZyZXFf
bW9kZSA9PSBNQVhfRlJFUV9UU0NfUkVGKSB7Ci0JCXRzY19kaWZmID0gdHNjX2F0X21lYXN1
cmVfZW5kIC0gdHNjX2F0X21lYXN1cmVfc3RhcnQ7CisJCXRzY19kaWZmID0gdHNjX2F0X21l
YXN1cmVfZW5kW2NwdV0gLSB0c2NfYXRfbWVhc3VyZV9zdGFydFtjcHVdOwogCQkqcGVyY2Vu
dCA9IDEwMC4wICogbXBlcmZfZGlmZiAvIHRzY19kaWZmOwogCQlkcHJpbnQoIiVzOiBUU0Mg
UmVmIC0gbXBlcmZfZGlmZjogJWxsdSwgdHNjX2RpZmY6ICVsbHVcbiIsCiAJCSAgICAgICBt
cGVyZl9jc3RhdGVzW2lkXS5uYW1lLCBtcGVyZl9kaWZmLCB0c2NfZGlmZik7CkBAIC0yMDYs
NyArMjA2LDcgQEAgc3RhdGljIGludCBtcGVyZl9nZXRfY291bnRfZnJlcSh1bnNpZ25lZCBp
bnQgaWQsIHVuc2lnbmVkIGxvbmcgbG9uZyAqY291bnQsCiAKIAlpZiAobWF4X2ZyZXFfbW9k
ZSA9PSBNQVhfRlJFUV9UU0NfUkVGKSB7CiAJCS8qIENhbGN1bGF0ZSBtYXhfZnJlcSBmcm9t
IFRTQyBjb3VudCAqLwotCQl0c2NfZGlmZiA9IHRzY19hdF9tZWFzdXJlX2VuZCAtIHRzY19h
dF9tZWFzdXJlX3N0YXJ0OworCQl0c2NfZGlmZiA9IHRzY19hdF9tZWFzdXJlX2VuZFtjcHVd
IC0gdHNjX2F0X21lYXN1cmVfc3RhcnRbY3B1XTsKIAkJdGltZV9kaWZmID0gdGltZXNwZWNf
ZGlmZl91cyh0aW1lX3N0YXJ0LCB0aW1lX2VuZCk7CiAJCW1heF9mcmVxdWVuY3kgPSB0c2Nf
ZGlmZiAvIHRpbWVfZGlmZjsKIAl9CkBAIC0yMjUsMzMgKzIyNSwyNyBAQCBzdGF0aWMgaW50
IG1wZXJmX2dldF9jb3VudF9mcmVxKHVuc2lnbmVkIGludCBpZCwgdW5zaWduZWQgbG9uZyBs
b25nICpjb3VudCwKIHN0YXRpYyBpbnQgbXBlcmZfc3RhcnQodm9pZCkKIHsKIAlpbnQgY3B1
OwotCXVuc2lnbmVkIGxvbmcgbG9uZyBkYmc7CiAKIAljbG9ja19nZXR0aW1lKENMT0NLX1JF
QUxUSU1FLCAmdGltZV9zdGFydCk7Ci0JbXBlcmZfZ2V0X3RzYygmdHNjX2F0X21lYXN1cmVf
c3RhcnQpOwogCi0JZm9yIChjcHUgPSAwOyBjcHUgPCBjcHVfY291bnQ7IGNwdSsrKQorCWZv
ciAoY3B1ID0gMDsgY3B1IDwgY3B1X2NvdW50OyBjcHUrKykgeworCQltcGVyZl9nZXRfdHNj
KCZ0c2NfYXRfbWVhc3VyZV9zdGFydFtjcHVdKTsKIAkJbXBlcmZfaW5pdF9zdGF0cyhjcHUp
OworCX0KIAotCW1wZXJmX2dldF90c2MoJmRiZyk7Ci0JZHByaW50KCJUU0MgZGlmZjogJWxs
dVxuIiwgZGJnIC0gdHNjX2F0X21lYXN1cmVfc3RhcnQpOwogCXJldHVybiAwOwogfQogCiBz
dGF0aWMgaW50IG1wZXJmX3N0b3Aodm9pZCkKIHsKLQl1bnNpZ25lZCBsb25nIGxvbmcgZGJn
OwogCWludCBjcHU7CiAKLQlmb3IgKGNwdSA9IDA7IGNwdSA8IGNwdV9jb3VudDsgY3B1Kysp
CisJZm9yIChjcHUgPSAwOyBjcHUgPCBjcHVfY291bnQ7IGNwdSsrKSB7CiAJCW1wZXJmX21l
YXN1cmVfc3RhdHMoY3B1KTsKKwkJbXBlcmZfZ2V0X3RzYygmdHNjX2F0X21lYXN1cmVfZW5k
W2NwdV0pOworCX0KIAotCW1wZXJmX2dldF90c2MoJnRzY19hdF9tZWFzdXJlX2VuZCk7CiAJ
Y2xvY2tfZ2V0dGltZShDTE9DS19SRUFMVElNRSwgJnRpbWVfZW5kKTsKLQotCW1wZXJmX2dl
dF90c2MoJmRiZyk7Ci0JZHByaW50KCJUU0MgZGlmZjogJWxsdVxuIiwgZGJnIC0gdHNjX2F0
X21lYXN1cmVfZW5kKTsKLQogCXJldHVybiAwOwogfQogCkBAIC0zNTMsNyArMzQ3LDggQEAg
c3RydWN0IGNwdWlkbGVfbW9uaXRvciAqbXBlcmZfcmVnaXN0ZXIodm9pZCkKIAlhcGVyZl9w
cmV2aW91c19jb3VudCA9IGNhbGxvYyhjcHVfY291bnQsIHNpemVvZih1bnNpZ25lZCBsb25n
IGxvbmcpKTsKIAltcGVyZl9jdXJyZW50X2NvdW50ID0gY2FsbG9jKGNwdV9jb3VudCwgc2l6
ZW9mKHVuc2lnbmVkIGxvbmcgbG9uZykpOwogCWFwZXJmX2N1cnJlbnRfY291bnQgPSBjYWxs
b2MoY3B1X2NvdW50LCBzaXplb2YodW5zaWduZWQgbG9uZyBsb25nKSk7Ci0KKwl0c2NfYXRf
bWVhc3VyZV9zdGFydCA9IGNhbGxvYyhjcHVfY291bnQsIHNpemVvZih1bnNpZ25lZCBsb25n
IGxvbmcpKTsKKwl0c2NfYXRfbWVhc3VyZV9lbmQgPSBjYWxsb2MoY3B1X2NvdW50LCBzaXpl
b2YodW5zaWduZWQgbG9uZyBsb25nKSk7CiAJbXBlcmZfbW9uaXRvci5uYW1lX2xlbiA9IHN0
cmxlbihtcGVyZl9tb25pdG9yLm5hbWUpOwogCXJldHVybiAmbXBlcmZfbW9uaXRvcjsKIH0K
QEAgLTM2NCw2ICszNTksOCBAQCB2b2lkIG1wZXJmX3VucmVnaXN0ZXIodm9pZCkKIAlmcmVl
KGFwZXJmX3ByZXZpb3VzX2NvdW50KTsKIAlmcmVlKG1wZXJmX2N1cnJlbnRfY291bnQpOwog
CWZyZWUoYXBlcmZfY3VycmVudF9jb3VudCk7CisJZnJlZSh0c2NfYXRfbWVhc3VyZV9zdGFy
dCk7CisJZnJlZSh0c2NfYXRfbWVhc3VyZV9lbmQpOwogCWZyZWUoaXNfdmFsaWQpOwogfQog
Cg==

--------------9IyDAsnkaVQo7hLHfcxwSE0e--
