Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9155C5E943E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiIYQN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiIYQN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:13:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B4F2C106
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 09:13:25 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b75so4524356pfb.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bzexp/haEvGbpUFIn6k+OIUVNaYMaRQAl7Js24bAaMI=;
        b=RAdIKoBn47/g9ou+KU1jeFhPvro4lR/ON2znehg5YHJVZweo/sLqLbFV3AonrV2lS9
         8gd+xMCQssawUhIPJAe3ZMDb+yRD+LhJ5558mAFcqMQttRAgMPlR0F7YJ0qbj2yacZFA
         QAb6GilwcmEa4RVuDYPHgqZVDtw/UPCRZQ96VpT/F/0JnFk1fLbLd1SR/JfieL/YkYPd
         p1emiiLb52r7s4F/Rr/VOb7G4Ty6fFQV3d3YBUEqVd8QFpXBLH7Ik55BUIeT6Ghhzdj5
         knikIGbkQOSYantHraZJsIRRLyiK5POP4LeUZwSlP1wcPF3H2qun0t9J7GPvtR9ARDyV
         J9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bzexp/haEvGbpUFIn6k+OIUVNaYMaRQAl7Js24bAaMI=;
        b=sG8jYklSMZA1YG81ISjQeFnB15geQJZaCCQJt4OqXTJ5NVngZmeVOZUnsJp7K9EU77
         ayPTTmXnqfJk1ODh+2LmoNMywXlRxGI7q5iqj3XflD+Ug/CxJOjD2z+EwuK1JzW7zIif
         /YaczZCJK9we8fqgVjRckEgpO6dBbl3qOQUqOTjf75NctWBU5uBq5PG7kK6IubRXhjAA
         Hgp+WvrS1fvsP8pF034wMFAr4VHrFIyyhXsU2AVFLctthM/qRoghejHAfAp8J1RgFlR7
         zgrk5j1J2H7C8lZezSqfKGgjyBkqjMlP0mpFSgzAqhLDi7kjuchO/DV4L6lT+rmtFpNO
         ycmA==
X-Gm-Message-State: ACrzQf2jgoeAnR0sbtxbGPI4vuUhtRTHL5bUnpn5UEUWpSR1wBK2VA5P
        +NQFHPbI+/GEQ0SX8WXC4YZMzkPrupgJo1P69DrJaOBUXKfaFjQS
X-Google-Smtp-Source: AMsMyM7BtEomWoITSvFpRu5DF8EBi6DY7ktlHHLnbO05z2OIc57I+VhdMh4GlnwZmL4zP8S79AasNRogagp78a/mqrA=
X-Received: by 2002:a65:6e0e:0:b0:434:59e0:27d3 with SMTP id
 bd14-20020a656e0e000000b0043459e027d3mr15926614pgb.185.1664122405220; Sun, 25
 Sep 2022 09:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN8LHqz7=OSvBpKCqKdV4L_4FPXtQ32bgYveA9yP2_xiQ@mail.gmail.com>
 <20220925042031.GA9845@1wt.eu> <CABXGCsOsm_QtFjd9KCYOc3E_4Tn_EVDhWifOPMU7_PZ7MC2big@mail.gmail.com>
 <20220925152142.GA13116@1wt.eu>
In-Reply-To: <20220925152142.GA13116@1wt.eu>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 25 Sep 2022 21:13:13 +0500
Message-ID: <CABXGCsN532FpFraXu_DiA4_SiRRXqy6zL0AD+oV0c5er4DJQJQ@mail.gmail.com>
Subject: Re: Unable bisect issue because kernel not building from old commits
To:     Willy Tarreau <w@1wt.eu>
Cc:     ast@kernel.org, yhs@fb.com, sean.wang@mediatek.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 8:21 PM Willy Tarreau <w@1wt.eu> wrote:
> Just add:
>
>    CROSS_COMPILE=/path/to/toolchain/bin/prefix-
>
> to your make command line and it will be fine.
>
> The makefile will append {gcc,ld,...} to this CROSS_COMPILE prefix to
> construct the full pathname to the binaries.

It works!
But I hit another build issue.

$ make clean &&
CROSS_COMPILE=~/Downloads/x86_64-gcc-7.5.0-nolibc-x86_64-linux/gcc-7.5.0-nolibc/x86_64-linux/bin/x86_64-linux-
make -j32 bzImage
***
  GEN     modules.builtin
  LD      .tmp_vmlinux.btf
  BTF     .btf.vmlinux.bin.o
  LD      .tmp_vmlinux.kallsyms1
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.S
  LD      .tmp_vmlinux.kallsyms2
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.S
  LD      vmlinux
  BTFIDS  vmlinux
FAILED: load BTF from vmlinux: Invalid argument
make: *** [Makefile:1159: vmlinux] Error 255
make: *** Deleting file 'vmlinux'

Full built output is here: https://pastebin.com/icF3gVgN
Thanks.

-- 
Best Regards,
Mike Gavrilov.
