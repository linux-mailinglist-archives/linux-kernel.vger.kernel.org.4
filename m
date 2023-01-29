Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B4D67FDFB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjA2J73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjA2J71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:59:27 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862A41CF49;
        Sun, 29 Jan 2023 01:59:25 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id y9so9992762lji.2;
        Sun, 29 Jan 2023 01:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPipLoV9xpeZrMSZnRkjHG1ExEX/WmrAWbw2HYLcp7w=;
        b=E17nfm30HjfVmHMD7hVNo6B6xo45S15vUrhCxnZ2ifMErkB61spvUvLILT4LOOsLB7
         FBnkQCIZceGxcGzJEWgWvuKaQTM49xEXB0NIYK2tL/xgdHl15bE/GqUu0zzzHJgbPgfP
         dOZaMbYzKU+IzGxp11Lrny04OmjALMynKZ6CNlvf8srN2z8wYQmxoLddFe4jrSQK7ZWh
         Qn8WL+tEOIVqaAysrDAmvG0Gw7WUMgSm2OwMAzo2YeBEMJ3lqP50KDnqin2WVUv8x1o0
         u3Sh6+eCsVi00C2o8yg73RKniooRkrWg65WcBjeB90KnNmUSO+vgwlflZbtDQUjDgTOK
         cL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPipLoV9xpeZrMSZnRkjHG1ExEX/WmrAWbw2HYLcp7w=;
        b=V+P7zaIOpmNjhHxxXOjfxgVNSObflGpmBNlOjHJebM4goYfH0AzW0Isa0thQk6Tdy6
         vhumsYy8C3z3y0U95zbSz7lnHpDUDOiFXYIAC4k9neeXtfAIhhNnwUguSplCgGDwvhOP
         U3ULJKUh6msOUvocPZozMK9u9yzcet6ejTR96m2hqZYG0eF1LxJkaWHVzEn7M42Jdunf
         HlFfrBwUsDHUuLNVfmNklTvp8T/07IGystcIovz8VTbG/X4Gz5hr4dmRID6zq7P+iPQ+
         0hXGxKfIPyix2AKGCn6Plqll8JDStkPwTBgJUcROBPJdxUH2YNEG0cydLnwZTmZMvtAb
         /qWQ==
X-Gm-Message-State: AO0yUKVwGMOQR50Zylm30gBXpbybojwiK1cwBFDmccrZjvjyDUhLYq5Q
        VSeQYsuzWNA6VEkcRVvcxuE830Q5RfDKIemjqXweq0h4uYVSbw==
X-Google-Smtp-Source: AK7set9Ybn3OVstxhp/3flSGQAZ5B3zyUnwgJBGTAQOmJrgGY4GmDx6Rzr5lAu2P5zBOsJ3Sa+pndbn6i4ZkQ+2RntM=
X-Received: by 2002:a2e:2a42:0:b0:290:3f19:e955 with SMTP id
 q63-20020a2e2a42000000b002903f19e955mr685589ljq.315.1674986363452; Sun, 29
 Jan 2023 01:59:23 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 29 Jan 2023 10:58:45 +0100
Message-ID: <CA+icZUU_ew7pzWJJZLbj1xsU6MQTPrj8tkFfDhNdTDRQfGUBMQ@mail.gmail.com>
Subject: [6.1.7][6.2-rc5] perf all metrics test: FAILED!
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        llvm@lists.linux.dev, Ben Hutchings <benh@debian.org>
Content-Type: multipart/mixed; boundary="00000000000032cc8705f3642789"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000032cc8705f3642789
Content-Type: text/plain; charset="UTF-8"

[ CC LLVM linux folks + Ben from Debian kernel team ]

Hi,

I am playing with LLVM version 16.0.0-rc1 which was released yesterday and PERF.

After building my selfmade LLVM toolchain, I built perf and run some
perf tests here on my Intel SandyBridge CPU (details see below).

perf all metrics test: FAILED!

...with both Debian's perf version 6.1.7 and my selfmade version 6.2-rc5.

Just noticed:

Couldn't bump rlimit(MEMLOCK), failures may take place when creating
BPF maps, etc

Run the below tests with `sudo` - made this go away - still FAILED.

But maybe I am missing to activate some sysfs/debug or whatever other stuff?

Last perf version which was OK:

~/bin/perf -v
perf version 6.0.0

echo "linux-perf: Adjust limited access to performance monitoring and
observability operations"
echo 0 | sudo tee /proc/sys/kernel/kptr_restrict
/proc/sys/kernel/perf_event_paranoid
0

~/bin/perf test 10 86 92 93 94 95
10: PMU events                                                      :
10.1: PMU event table sanity                                        : Ok
10.2: PMU event map aliases                                         : Ok
10.3: Parsing of PMU event table metrics                            : Ok
10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
86: perf record tests                                               : Ok
92: perf stat tests                                                 : Ok
93: perf all metricgroups test                                      : Ok
94: perf all metrics test                                           : Ok
95: perf all PMU test                                               : Ok

echo 1 | sudo tee /proc/sys/kernel/kptr_restrict
/proc/sys/kernel/perf_event_paranoid
echo "linux-perf: Reset limited access to performance monitoring and
observability operations"

If you need further information, please let me know.

Thanks.

Regards,
-Sedat-

P.S. Instructions

[ REPRODUCER ]

LLVM_MVER="16"

# Debian LLVM
##LLVM_TOOLCHAIN_PATH="/usr/lib/llvm-${LLVM_MVER}/bin"
# Selfmade LLVM
LLVM_TOOLCHAIN_PATH="/opt/llvm/bin"
if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
   export PATH="${LLVM_TOOLCHAIN_PATH}:${PATH}"
fi

PYTHON_VER="3.11"
MAKE="make"
MAKE_OPTS="V=1 -j1 HOSTCC=clang-$LLVM_MVER HOSTLD=ld.lld
HOSTAR=llvm-ar CC=clang-$LLVM_MVER LD=ld.lld AR=llvm-ar
STRIP=llvm-strip"

echo "LLVM MVER ........ $LLVM_MVER"
echo "Path settings .... $PATH"
echo "Python version ... $PYTHON_VER"
echo "make line ........ $MAKE $MAKE_OPTS"

LANG=C LC_ALL=C make -C tools/perf clean 2>&1 | tee ../make-log_perf-clean.txt

LANG=C LC_ALL=C $MAKE $MAKE_OPTS -C tools/perf
PYTHON=python${PYTHON_VER} install-bin 2>&1 | tee
../make-log_perf-install_bin_python${PYTHON_VER}_llvm${LLVM_MVER}.txt


[ TESTS ]

[ TESTS - START ]

echo 0 | sudo tee /proc/sys/kernel/kptr_restrict
/proc/sys/kernel/perf_event_paranoid

[ TESTS - DEBIAN ]

/usr/bin/perf -v
perf version 6.1.7

/usr/bin/perf test 10 92 98 99 100 101

 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 92: perf record tests                                               : Ok
 98: perf stat tests                                                 : Ok
 99: perf all metricgroups test                                      : Ok
100: perf all metrics test                                           : FAILED!
101: perf all PMU test                                               : Ok

[ TESTS - DILEKS ]

~/bin/perf -v
perf version 6.2.0-rc5

~/bin/perf test 7 87 93 94 95 96

  7: PMU events                                                      :
  7.1: PMU event table sanity                                        : Ok
  7.2: PMU event map aliases                                         : Ok
  7.3: Parsing of PMU event table metrics                            : Ok
  7.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 87: perf record tests                                               : Ok
 93: perf stat tests                                                 : Ok
 94: perf all metricgroups test                                      : Ok
 95: perf all metrics test                                           : FAILED!
 96: perf all PMU test                                               : Ok

[ TESTS - FAILED ]

/usr/bin/perf test --verbose 100 2>&1 | tee
perf-test-verbose-100-perf-all-metrics-test_debian-perf-6-1-7.txt

~/bin/perf test --verbose 95 2>&1 | tee
perf-test-verbose-95-perf-all-metrics-test_dileks-perf-6-2-rc5.txt

[ TESTS - STOP ]

echo 1 | sudo tee /proc/sys/kernel/kptr_restrict
/proc/sys/kernel/perf_event_paranoid

- EOT -

--00000000000032cc8705f3642789
Content-Type: text/plain; charset="US-ASCII"; 
	name="debian-perf-6-1-7_test-verbose-100-perf-all-metrics-test.txt"
Content-Disposition: attachment; 
	filename="debian-perf-6-1-7_test-verbose-100-perf-all-metrics-test.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_ldh7lvfx0>
X-Attachment-Id: f_ldh7lvfx0

Q291bGRuJ3QgYnVtcCBybGltaXQoTUVNTE9DSyksIGZhaWx1cmVzIG1heSB0YWtlIHBsYWNlIHdo
ZW4gY3JlYXRpbmcgQlBGIG1hcHMsIGV0YwoxMDA6IHBlcmYgYWxsIG1ldHJpY3MgdGVzdCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6Ci0tLSBzdGFydCAtLS0KdGVz
dCBjaGlsZCBmb3JrZWQsIHBpZCAzOTQzMgpUZXN0aW5nIEF2ZXJhZ2VfRnJlcXVlbmN5ClRlc3Rp
bmcgQzJfUGtnX1Jlc2lkZW5jeQpUZXN0aW5nIEMzX0NvcmVfUmVzaWRlbmN5ClRlc3RpbmcgQzNf
UGtnX1Jlc2lkZW5jeQpUZXN0aW5nIEM2X0NvcmVfUmVzaWRlbmN5ClRlc3RpbmcgQzZfUGtnX1Jl
c2lkZW5jeQpUZXN0aW5nIEM3X0NvcmVfUmVzaWRlbmN5ClRlc3RpbmcgQzdfUGtnX1Jlc2lkZW5j
eQpUZXN0aW5nIENMS1MKVGVzdGluZyBDT1JFX0NMS1MKVGVzdGluZyBDUEkKVGVzdGluZyBDUFVf
VXRpbGl6YXRpb24KVGVzdGluZyBDb3JlSVBDClRlc3RpbmcgRFJBTV9CV19Vc2UKVGVzdGluZyBE
U0JfQ292ZXJhZ2UKVGVzdGluZyBFeGVjdXRlX3Blcl9Jc3N1ZQpUZXN0aW5nIEZMT1BjClRlc3Rp
bmcgR0ZMT1BzClRlc3RpbmcgSUxQClRlc3RpbmcgSVBDClRlc3RpbmcgSW5zdHJ1Y3Rpb25zClRl
c3RpbmcgSXBGYXJCcmFuY2gKVGVzdGluZyBLZXJuZWxfQ1BJClRlc3RpbmcgS2VybmVsX1V0aWxp
emF0aW9uClRlc3RpbmcgTUVNX1BhcmFsbGVsX1JlcXVlc3RzClRlc3RpbmcgTUVNX1JlcXVlc3Rf
TGF0ZW5jeQpUZXN0aW5nIFJldGlyZQpUZXN0aW5nIFNMT1RTClRlc3RpbmcgU01UXzJUX1V0aWxp
emF0aW9uClRlc3RpbmcgVHVyYm9fVXRpbGl6YXRpb24KVGVzdGluZyBVUEkKVGVzdGluZyB0bWFf
YmFja2VuZF9ib3VuZApUZXN0aW5nIHRtYV9iYWRfc3BlY3VsYXRpb24KVGVzdGluZyB0bWFfYnJh
bmNoX21pc3ByZWRpY3RzClRlc3RpbmcgdG1hX2JyYW5jaF9yZXN0ZWVycwpUZXN0aW5nIHRtYV9j
b3JlX2JvdW5kClRlc3RpbmcgdG1hX2RpdmlkZXIKVGVzdGluZyB0bWFfZHJhbV9ib3VuZApNZXRy
aWMgJ3RtYV9kcmFtX2JvdW5kJyBub3QgcHJpbnRlZCBpbjoKIyBSdW5uaW5nICdpbnRlcm5hbHMv
c3ludGhlc2l6ZScgYmVuY2htYXJrOgpDb21wdXRpbmcgcGVyZm9ybWFuY2Ugb2Ygc2luZ2xlIHRo
cmVhZGVkIHBlcmYgZXZlbnQgc3ludGhlc2lzIGJ5CnN5bnRoZXNpemluZyBldmVudHMgb24gdGhl
IHBlcmYgcHJvY2VzcyBpdHNlbGY6CiAgQXZlcmFnZSBzeW50aGVzaXMgdG9vazogMjAzLjkyMiB1
c2VjICgrLSAwLjE5MSB1c2VjKQogIEF2ZXJhZ2UgbnVtLiBldmVudHM6IDMwLjAwMCAoKy0gMC4w
MDApCiAgQXZlcmFnZSB0aW1lIHBlciBldmVudCA2Ljc5NyB1c2VjCiAgQXZlcmFnZSBkYXRhIHN5
bnRoZXNpcyB0b29rOiAyMTkuNzMwIHVzZWMgKCstIDAuMjE2IHVzZWMpCiAgQXZlcmFnZSBudW0u
IGV2ZW50czogMTU5LjAwMCAoKy0gMC4wMDApCiAgQXZlcmFnZSB0aW1lIHBlciBldmVudCAxLjM4
MiB1c2VjCgogUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3BlcmYgYmVuY2ggaW50ZXJu
YWxzIHN5bnRoZXNpemUnOgoKICAgICA8bm90IGNvdW50ZWQ+ICAgICAgTUVNX0xPQURfVU9QU19S
RVRJUkVELkxMQ19ISVQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKDAsMDAl
KQogICAgIDxub3QgY291bnRlZD4gICAgICBDWUNMRV9BQ1RJVklUWS5TVEFMTFNfTDJfUEVORElO
RyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoMCwwMCUpCiAgICAgPG5vdCBj
b3VudGVkPiAgICAgIENQVV9DTEtfVU5IQUxURUQuVEhSRUFEICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKDAsMDAlKQogICAgIDxub3QgY291bnRlZD4gICAgICBNRU1fTE9B
RF9VT1BTX01JU0NfUkVUSVJFRC5MTENfTUlTUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAoMCwwMCUpCgogICAgICAgNCw0NTYzNzU1MzIgc2Vjb25kcyB0aW1lIGVsYXBzZWQK
CiAgICAgICAxLDQxNTgyOTAwMCBzZWNvbmRzIHVzZXIKICAgICAgIDMsMDI3MDgzMDAwIHNlY29u
ZHMgc3lzClRlc3RpbmcgdG1hX2RzYl9zd2l0Y2hlcwpUZXN0aW5nIHRtYV9kdGxiX2xvYWQKVGVz
dGluZyB0bWFfZmV0Y2hfYmFuZHdpZHRoClRlc3RpbmcgdG1hX2ZldGNoX2xhdGVuY3kKVGVzdGlu
ZyB0bWFfZnBfYXJpdGgKVGVzdGluZyB0bWFfZnBfc2NhbGFyClRlc3RpbmcgdG1hX2ZwX3ZlY3Rv
cgpUZXN0aW5nIHRtYV9mcm9udGVuZF9ib3VuZApUZXN0aW5nIHRtYV9oZWF2eV9vcGVyYXRpb25z
ClRlc3RpbmcgdG1hX2l0bGJfbWlzc2VzClRlc3RpbmcgdG1hX2wzX2JvdW5kCk1ldHJpYyAndG1h
X2wzX2JvdW5kJyBub3QgcHJpbnRlZCBpbjoKIyBSdW5uaW5nICdpbnRlcm5hbHMvc3ludGhlc2l6
ZScgYmVuY2htYXJrOgpDb21wdXRpbmcgcGVyZm9ybWFuY2Ugb2Ygc2luZ2xlIHRocmVhZGVkIHBl
cmYgZXZlbnQgc3ludGhlc2lzIGJ5CnN5bnRoZXNpemluZyBldmVudHMgb24gdGhlIHBlcmYgcHJv
Y2VzcyBpdHNlbGY6CiAgQXZlcmFnZSBzeW50aGVzaXMgdG9vazogMjA0LjE5OSB1c2VjICgrLSAw
LjIyOCB1c2VjKQogIEF2ZXJhZ2UgbnVtLiBldmVudHM6IDMwLjAwMCAoKy0gMC4wMDApCiAgQXZl
cmFnZSB0aW1lIHBlciBldmVudCA2LjgwNyB1c2VjCiAgQXZlcmFnZSBkYXRhIHN5bnRoZXNpcyB0
b29rOiAyMTkuOTM0IHVzZWMgKCstIDAuMjMyIHVzZWMpCiAgQXZlcmFnZSBudW0uIGV2ZW50czog
MTU5LjAwMCAoKy0gMC4wMDApCiAgQXZlcmFnZSB0aW1lIHBlciBldmVudCAxLjM4MyB1c2VjCgog
UGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3BlcmYgYmVuY2ggaW50ZXJuYWxzIHN5bnRo
ZXNpemUnOgoKICAgICA8bm90IGNvdW50ZWQ+ICAgICAgTUVNX0xPQURfVU9QU19SRVRJUkVELkxM
Q19ISVQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKDAsMDAlKQogICAgIDxu
b3QgY291bnRlZD4gICAgICBDWUNMRV9BQ1RJVklUWS5TVEFMTFNfTDJfUEVORElORyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoMCwwMCUpCiAgICAgPG5vdCBjb3VudGVkPiAg
ICAgIENQVV9DTEtfVU5IQUxURUQuVEhSRUFEICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKDAsMDAlKQogICAgIDxub3QgY291bnRlZD4gICAgICBNRU1fTE9BRF9VT1BTX01J
U0NfUkVUSVJFRC5MTENfTUlTUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAo
MCwwMCUpCgogICAgICAgNCw0NTg5NDM0NTMgc2Vjb25kcyB0aW1lIGVsYXBzZWQKCiAgICAgICAx
LDQ2ODI1MTAwMCBzZWNvbmRzIHVzZXIKICAgICAgIDIsOTc2NDAwMDAwIHNlY29uZHMgc3lzClRl
c3RpbmcgdG1hX2xjcApUZXN0aW5nIHRtYV9saWdodF9vcGVyYXRpb25zClRlc3RpbmcgdG1hX21h
Y2hpbmVfY2xlYXJzClRlc3RpbmcgdG1hX21lbV9iYW5kd2lkdGgKVGVzdGluZyB0bWFfbWVtX2xh
dGVuY3kKVGVzdGluZyB0bWFfbWVtb3J5X2JvdW5kClRlc3RpbmcgdG1hX21pY3JvY29kZV9zZXF1
ZW5jZXIKVGVzdGluZyB0bWFfbXNfc3dpdGNoZXMKVGVzdGluZyB0bWFfcG9ydHNfdXRpbGl6YXRp
b24KVGVzdGluZyB0bWFfcmV0aXJpbmcKVGVzdGluZyB0bWFfc3RvcmVfYm91bmQKVGVzdGluZyB0
bWFfeDg3X3VzZQp0ZXN0IGNoaWxkIGZpbmlzaGVkIHdpdGggLTEKLS0tLSBlbmQgLS0tLQpwZXJm
IGFsbCBtZXRyaWNzIHRlc3Q6IEZBSUxFRCEK
--00000000000032cc8705f3642789
Content-Type: text/plain; charset="US-ASCII"; 
	name="dileks-perf-6-2-rc5-test-verbose-95-perf-all-metrics-test.txt"
Content-Disposition: attachment; 
	filename="dileks-perf-6-2-rc5-test-verbose-95-perf-all-metrics-test.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_ldh7lxvt1>
X-Attachment-Id: f_ldh7lxvt1

Q291bGRuJ3QgYnVtcCBybGltaXQoTUVNTE9DSyksIGZhaWx1cmVzIG1heSB0YWtlIHBsYWNlIHdo
ZW4gY3JlYXRpbmcgQlBGIG1hcHMsIGV0YwogOTU6IHBlcmYgYWxsIG1ldHJpY3MgdGVzdCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6Ci0tLSBzdGFydCAtLS0KdGVz
dCBjaGlsZCBmb3JrZWQsIHBpZCAzOTE5OApUZXN0aW5nIElMUApUZXN0aW5nIHRtYV9jb3JlX2Jv
dW5kClRlc3RpbmcgdG1hX21lbW9yeV9ib3VuZApUZXN0aW5nIHRtYV9icmFuY2hfbWlzcHJlZGlj
dHMKVGVzdGluZyB0bWFfbWFjaGluZV9jbGVhcnMKVGVzdGluZyB0bWFfaXRsYl9taXNzZXMKVGVz
dGluZyBJcEZhckJyYW5jaApUZXN0aW5nIHRtYV9sM19ib3VuZApNZXRyaWMgJ3RtYV9sM19ib3Vu
ZCcgbm90IHByaW50ZWQgaW46CiMgUnVubmluZyAnaW50ZXJuYWxzL3N5bnRoZXNpemUnIGJlbmNo
bWFyazoKQ29tcHV0aW5nIHBlcmZvcm1hbmNlIG9mIHNpbmdsZSB0aHJlYWRlZCBwZXJmIGV2ZW50
IHN5bnRoZXNpcyBieQpzeW50aGVzaXppbmcgZXZlbnRzIG9uIHRoZSBwZXJmIHByb2Nlc3MgaXRz
ZWxmOgogIEF2ZXJhZ2Ugc3ludGhlc2lzIHRvb2s6IDIwOC4wMzMgdXNlYyAoKy0gMC4yMTQgdXNl
YykKICBBdmVyYWdlIG51bS4gZXZlbnRzOiAzMC4wMDAgKCstIDAuMDAwKQogIEF2ZXJhZ2UgdGlt
ZSBwZXIgZXZlbnQgNi45MzQgdXNlYwogIEF2ZXJhZ2UgZGF0YSBzeW50aGVzaXMgdG9vazogMjE2
LjcyOCB1c2VjICgrLSAwLjE4MiB1c2VjKQogIEF2ZXJhZ2UgbnVtLiBldmVudHM6IDE2Mi4wMDAg
KCstIDAuMDAwKQogIEF2ZXJhZ2UgdGltZSBwZXIgZXZlbnQgMS4zMzggdXNlYwoKIFBlcmZvcm1h
bmNlIGNvdW50ZXIgc3RhdHMgZm9yICdwZXJmIGJlbmNoIGludGVybmFscyBzeW50aGVzaXplJzoK
CiAgICAgPG5vdCBjb3VudGVkPiAgICAgIE1FTV9MT0FEX1VPUFNfUkVUSVJFRC5MTENfSElUICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgwLDAwJSkKICAgICA8bm90
IGNvdW50ZWQ+ICAgICAgQ1lDTEVfQUNUSVZJVFkuU1RBTExTX0wyX1BFTkRJTkcgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKDAsMDAlKQogICAgIDxub3QgY291bnRlZD4g
ICAgICBDUFVfQ0xLX1VOSEFMVEVELlRIUkVBRCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAoMCwwMCUpCiAgICAgPG5vdCBjb3VudGVkPiAgICAgIE1FTV9M
T0FEX1VPUFNfTUlTQ19SRVRJUkVELkxMQ19NSVNTICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICgwLDAwJSkKCiAgICAgICA0LDU1NTIyODQ4MCBzZWNvbmRzIHRpbWUgZWxh
cHNlZAoKICAgICAgIDEsNTA0MTM3MDAwIHNlY29uZHMgdXNlcgogICAgICAgMywwNDAxOTMwMDAg
c2Vjb25kcyBzeXMKVGVzdGluZyB0bWFfZnBfc2NhbGFyClRlc3RpbmcgdG1hX2ZwX3ZlY3RvcgpU
ZXN0aW5nIHRtYV94ODdfdXNlClRlc3RpbmcgRXhlY3V0ZV9wZXJfSXNzdWUKVGVzdGluZyBHRkxP
UHMKVGVzdGluZyBEU0JfQ292ZXJhZ2UKVGVzdGluZyB0bWFfZHNiX3N3aXRjaGVzClRlc3Rpbmcg
dG1hX2ZldGNoX2JhbmR3aWR0aApUZXN0aW5nIHRtYV9icmFuY2hfcmVzdGVlcnMKVGVzdGluZyB0
bWFfbGNwClRlc3RpbmcgdG1hX21zX3N3aXRjaGVzClRlc3RpbmcgRkxPUGMKVGVzdGluZyB0bWFf
ZmV0Y2hfbGF0ZW5jeQpUZXN0aW5nIENQVV9VdGlsaXphdGlvbgpUZXN0aW5nIERSQU1fQldfVXNl
ClRlc3RpbmcgdG1hX2ZwX2FyaXRoClRlc3RpbmcgQ1BJClRlc3RpbmcgTUVNX1BhcmFsbGVsX1Jl
cXVlc3RzClRlc3RpbmcgTUVNX1JlcXVlc3RfTGF0ZW5jeQpUZXN0aW5nIHRtYV9tZW1fYmFuZHdp
ZHRoClRlc3RpbmcgdG1hX2RyYW1fYm91bmQKTWV0cmljICd0bWFfZHJhbV9ib3VuZCcgbm90IHBy
aW50ZWQgaW46CiMgUnVubmluZyAnaW50ZXJuYWxzL3N5bnRoZXNpemUnIGJlbmNobWFyazoKQ29t
cHV0aW5nIHBlcmZvcm1hbmNlIG9mIHNpbmdsZSB0aHJlYWRlZCBwZXJmIGV2ZW50IHN5bnRoZXNp
cyBieQpzeW50aGVzaXppbmcgZXZlbnRzIG9uIHRoZSBwZXJmIHByb2Nlc3MgaXRzZWxmOgogIEF2
ZXJhZ2Ugc3ludGhlc2lzIHRvb2s6IDIwNy42ODAgdXNlYyAoKy0gMC4xNzYgdXNlYykKICBBdmVy
YWdlIG51bS4gZXZlbnRzOiAzMC4wMDAgKCstIDAuMDAwKQogIEF2ZXJhZ2UgdGltZSBwZXIgZXZl
bnQgNi45MjMgdXNlYwogIEF2ZXJhZ2UgZGF0YSBzeW50aGVzaXMgdG9vazogMjE3LjgzMyB1c2Vj
ICgrLSAwLjIwMiB1c2VjKQogIEF2ZXJhZ2UgbnVtLiBldmVudHM6IDE2MS4wMDAgKCstIDAuMDAw
KQogIEF2ZXJhZ2UgdGltZSBwZXIgZXZlbnQgMS4zNTMgdXNlYwoKIFBlcmZvcm1hbmNlIGNvdW50
ZXIgc3RhdHMgZm9yICdwZXJmIGJlbmNoIGludGVybmFscyBzeW50aGVzaXplJzoKCiAgICAgPG5v
dCBjb3VudGVkPiAgICAgIE1FTV9MT0FEX1VPUFNfUkVUSVJFRC5MTENfSElUICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgwLDAwJSkKICAgICA8bm90IGNvdW50ZWQ+
ICAgICAgQ1lDTEVfQUNUSVZJVFkuU1RBTExTX0wyX1BFTkRJTkcgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKDAsMDAlKQogICAgIDxub3QgY291bnRlZD4gICAgICBDUFVf
Q0xLX1VOSEFMVEVELlRIUkVBRCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAoMCwwMCUpCiAgICAgPG5vdCBjb3VudGVkPiAgICAgIE1FTV9MT0FEX1VPUFNf
TUlTQ19SRVRJUkVELkxMQ19NSVNTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICgwLDAwJSkKCiAgICAgICA0LDU1NTY5ODg2MyBzZWNvbmRzIHRpbWUgZWxhcHNlZAoKICAg
ICAgIDEsNDgxNzY5MDAwIHNlY29uZHMgdXNlcgogICAgICAgMywwNjMzODcwMDAgc2Vjb25kcyBz
eXMKVGVzdGluZyB0bWFfc3RvcmVfYm91bmQKVGVzdGluZyB0bWFfbWVtX2xhdGVuY3kKVGVzdGlu
ZyB0bWFfZHRsYl9sb2FkClRlc3RpbmcgdG1hX21pY3JvY29kZV9zZXF1ZW5jZXIKVGVzdGluZyBL
ZXJuZWxfQ1BJClRlc3RpbmcgS2VybmVsX1V0aWxpemF0aW9uClRlc3RpbmcgdG1hX2Zyb250ZW5k
X2JvdW5kClRlc3RpbmcgQ0xLUwpUZXN0aW5nIFJldGlyZQpUZXN0aW5nIFVQSQpUZXN0aW5nIHRt
YV9wb3J0c191dGlsaXphdGlvbgpUZXN0aW5nIEF2ZXJhZ2VfRnJlcXVlbmN5ClRlc3RpbmcgQzJf
UGtnX1Jlc2lkZW5jeQpUZXN0aW5nIEMzX0NvcmVfUmVzaWRlbmN5ClRlc3RpbmcgQzNfUGtnX1Jl
c2lkZW5jeQpUZXN0aW5nIEM2X0NvcmVfUmVzaWRlbmN5ClRlc3RpbmcgQzZfUGtnX1Jlc2lkZW5j
eQpUZXN0aW5nIEM3X0NvcmVfUmVzaWRlbmN5ClRlc3RpbmcgQzdfUGtnX1Jlc2lkZW5jeQpUZXN0
aW5nIFR1cmJvX1V0aWxpemF0aW9uClRlc3RpbmcgQ29yZUlQQwpUZXN0aW5nIElQQwpUZXN0aW5n
IHRtYV9oZWF2eV9vcGVyYXRpb25zClRlc3RpbmcgdG1hX2xpZ2h0X29wZXJhdGlvbnMKVGVzdGlu
ZyBDT1JFX0NMS1MKVGVzdGluZyBTTVRfMlRfVXRpbGl6YXRpb24KVGVzdGluZyBTb2NrZXRfQ0xL
UwpUZXN0aW5nIFVOQ09SRV9GUkVRClRlc3RpbmcgSW5zdHJ1Y3Rpb25zClRlc3RpbmcgdG1hX2Jh
Y2tlbmRfYm91bmQKVGVzdGluZyB0bWFfYmFkX3NwZWN1bGF0aW9uClRlc3RpbmcgdG1hX3JldGly
aW5nClRlc3RpbmcgdG1hX2RpdmlkZXIKVGVzdGluZyBTTE9UUwp0ZXN0IGNoaWxkIGZpbmlzaGVk
IHdpdGggLTEKLS0tLSBlbmQgLS0tLQpwZXJmIGFsbCBtZXRyaWNzIHRlc3Q6IEZBSUxFRCEK
--00000000000032cc8705f3642789--
