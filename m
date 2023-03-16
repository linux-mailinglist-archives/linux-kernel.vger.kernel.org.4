Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F8C6BDCBB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjCPXLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCPXLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:11:20 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1CC234C7;
        Thu, 16 Mar 2023 16:11:19 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso1934594ota.1;
        Thu, 16 Mar 2023 16:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679008278;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YcdmFaDt/Cf3OEZTuhE6C+fH1voZvs0au3xzuaV9u5Y=;
        b=NHqiaZ38ESCpwnaQAzL6DB3Rgds+gFstT1N5yF3hqRVRYpBe4Bx7fJmh4IdWqsQ22r
         NauoV7t7y6EYPEZ8WUGH8h6sZ8ntReyUwwn6e4bmgjwg2SeitRzh4X0b3+wW/W4qU37b
         m01COCxCYPXJRgiJJQXXeEwr9g4mcAd/U/tpBcAJSOArr6k9f9P5FlyN3SxLv15/6chh
         XLWibuN1k+ZgOqsaabzu5gv6nr+a4mGOf7GP2a14UKIoTaA9TjeqGKwvrn8Md3GAf3KS
         cjKjK+u8BtnBL010MxphmKoc95XpCGtvvTzk5r6G1jZHTo8vQ7Bcj4AowExp36fb3Pp+
         Q+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679008278;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcdmFaDt/Cf3OEZTuhE6C+fH1voZvs0au3xzuaV9u5Y=;
        b=kIcE6jA99qn1fGDI9Pf9kNh24sb7wSUDbHynSLPGaE3ARznP7R5fy1bNGP6SvFeeaD
         fdU9AP0w4J4r7p8e7Ic4ppr/no43rs5NQYce8SYbzuYlPi+8lNbqZ4AACp3Z1oz/GkqM
         eoH2VwK7s1S2N93GYfkwXbC9OAuHTwPd9desAnAalj7x+G+V4bAQHKJ6BbXi9JaQMHp+
         IbgppFf7XUGesCfBnhltLMpB5V1aN/99/GXmL+hBYYy6zrDd15eUT2Igzy2P9rw9sXFJ
         dxydqHSMnLnFoKRsviUSF1nS8r0QZlsvF3yRrjy4IxpITbbS/U81v1XKmllL4vsEob6f
         rtnA==
X-Gm-Message-State: AO0yUKXm1LjC5VznQRHlHMu9agYv0McoVSEbPWUfOvP2AqvzNFZMvxdp
        kg9k1I4f8GhxaDREXOsatNE=
X-Google-Smtp-Source: AK7set/ql1xaD1GZvmGqHKAwEjxQRA7/0GbY8h5F17WCkLSNgM3Fc5gunpWG2i+FvDx5HEKVMPiCgg==
X-Received: by 2002:a9d:2f0:0:b0:68b:caa8:6ef1 with SMTP id 103-20020a9d02f0000000b0068bcaa86ef1mr22677270otl.12.1679008278713;
        Thu, 16 Mar 2023 16:11:18 -0700 (PDT)
Received: from [127.0.0.1] (187-26-169-5.3g.claro.net.br. [187.26.169.5])
        by smtp.gmail.com with ESMTPSA id v13-20020a9d5a0d000000b00693c9f984b4sm354610oth.70.2023.03.16.16.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 16:11:18 -0700 (PDT)
Date:   Thu, 16 Mar 2023 20:11:11 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        irogers@google.com, namhyung@kernel.org
Subject: Re: linux-next: build failure after merge of the perf tree
User-Agent: K-9 Mail for Android
In-Reply-To: <20230317095025.49aa34f9@canb.auug.org.au>
References: <20230317095025.49aa34f9@canb.auug.org.au>
Message-ID: <7D15C431-1AB6-482E-B4B9-289A15C0E2E4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 16, 2023 7:50:25 PM GMT-03:00, Stephen Rothwell <sfr@canb=2Eauug=
=2Eorg=2Eau> wrote:
>Hi all,
>
>After merging the perf tree, today's linux-next build (native perf)
>failed like this:
>
>Auto-detecting system features:
>=2E=2E=2E                         clang-bpf-co-re: [ =1B[32mon=1B[m  ]
>=2E=2E=2E                                    llvm: [ =1B[31mOFF=1B[m ]
>=2E=2E=2E                                  libcap: [ =1B[32mon=1B[m  ]
>=2E=2E=2E                                  libbfd: [ =1B[32mon=1B[m  ]
>
>make[1]: *** Deleting file '/home/sfr/next/perf/util/bpf_skel/vmlinux=2Eh=
'
>libbpf: failed to find '=2EBTF' ELF section in /boot/vmlinux-6=2E0=2E0-5-=
powerpc64le
>Error: failed to load BTF from /boot/vmlinux-6=2E0=2E0-5-powerpc64le: No =
data available
>make[1]: *** [Makefile=2Eperf:1075: /home/sfr/next/perf/util/bpf_skel/vml=
inux=2Eh] Error 195
>make[1]: *** Waiting for unfinished jobs=2E=2E=2E=2E
>make: *** [Makefile=2Eperf:236: sub-make] Error 2
>Command exited with non-zero status 2
>
>To be clear this is a native build of perf on a PPC64le host using this
>command line:
>
>make -C tools/perf -f Makefile=2Eperf -s -O -j60 O=3D=2E=2E/perf EXTRA_CF=
LAGS=3D-Wno-psabi
>
>(I could probably remove the EXTRA_CLFAGS now that I am building with
>gcc 12=2E2)
>
>I don't know which commit caused this=2E

Can you try adding NO_BPF_SKEL=3D1 to the make -C tools/perf command line?

- Arnaldo

>
>I have used the perf tree from next-20230316 for today=2E
>
>
>
