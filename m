Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5807131BA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjE0Bpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238228AbjE0Bpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:45:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8051BE6D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:45:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307d20548adso801375f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685151846; x=1687743846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ri/mthOsR+FC7s1/H/J1smTMHriaL5bub6hFt3L7yNE=;
        b=qzKXlM7bDcnP8FYpH+hgQu6YAHWqCXYjZ7LEN9tFjXPIEEV93/kCYNn0wSyxxTBiLw
         u7h18hNVtd2vAsOW4BtLDbf+lTr61rtgu0u4DSwqFDYJHfUBLa81hwmKL4a4M3ydMm76
         0TzNtGUnkaGHQbdnqyVotJXZqlwNYXItrBG66FpKzi6/JF9Bm8NN4Zeqjskvbsmi/oGk
         so4NatIaAGbiTwNgDy1E+AHp2yeUfrlO6j0dXDxehEtnJL8gD5vaj0BlaICMDm3TiZXR
         VgU7AKCCEugx6pd2OnJc3ckNZdNI/UFOvpML77xO+p06+Wn92ORzX1FZ5YH+twxN/NUd
         Xwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151846; x=1687743846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ri/mthOsR+FC7s1/H/J1smTMHriaL5bub6hFt3L7yNE=;
        b=en2s5wE4f+Ola/ctZcEgnOZwbt2QDovPaRUS2SjH3x8mHX70i17Z39PUcL0lOESB+q
         20kjs+Ntcprg9oJFLNkOrV1+lWmjnBzZcYgKbytntRc+2fRZCgjNNg+ozYrtGv5f5axi
         IH4z9c1IQaAYcDXbQWlXkMppz4vWUM9OerJg4BC8nh2YkUSOB+8qfPrC5nTp2hhJs8Z+
         VIKACR2krmnL1zsGWZkcMDGvA9Cfp6c6bZmjoZQYnch2HJQ75gTYSqUZhnqLU96HAY1u
         DrQvg4B7fhJ1jeVXIIfludwnbwE7qPvN9yssJbvnsis4X1r5gkZZAaTju7VTa41EafQr
         j7Rg==
X-Gm-Message-State: AC+VfDzWr4QJBtjXlB1VmqqdOC5KDslvbp8qMVjBi5xAqA1LJHiOwyfR
        CBKjglSnzm3Stw0Lq4VOgSO6zPb2Un0/OHTRsCW5Ag==
X-Google-Smtp-Source: ACHHUZ6ZawPDKx7a8SGXdmOLKwXFTngn5C4MeWa2OyPUHjgySBUOAzaZd1fyftY3wtOoH7ZLX6RjcGxIdzOpHyG1wN4=
X-Received: by 2002:adf:e94f:0:b0:2ef:ba4f:c821 with SMTP id
 m15-20020adfe94f000000b002efba4fc821mr2588316wrn.36.1685151846445; Fri, 26
 May 2023 18:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <1684837327-18203-1-git-send-email-yangtiezhu@loongson.cn>
 <1684837327-18203-2-git-send-email-yangtiezhu@loongson.cn>
 <CAJ1xhMUZoO66b=LNVnjBN1GbHvXdo2b2y+YeONC36Ok=Xn5XFg@mail.gmail.com>
 <49e98308-ab8d-5811-66a8-9e17f22bb8c4@loongson.cn> <CAJ1xhMV=WaYbdGpiRedLUGnYp8JLzcP81Ksw1k1610xeHCiGBA@mail.gmail.com>
 <2932e212-ba17-090b-761b-b18e8f9c33e8@loongson.cn>
In-Reply-To: <2932e212-ba17-090b-761b-b18e8f9c33e8@loongson.cn>
From:   Leo Yan <leo.yan@linaro.org>
Date:   Sat, 27 May 2023 09:43:55 +0800
Message-ID: <CALZQ+UN0y29mJUypfSUHCLkMHzBVQTVU0i95MtHG3U+VzS+5Og@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf arm64: Handle __NR3264_ prefixed syscall number
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 03:18:28PM +0800, Tiezhu Yang wrote:
> On 05/24/2023 02:43 PM, Alexander Kapshuk wrote:

[...]

> Yes, there are only 2 patterns such as "__NR_" and "__NR3264_",
> I confirmed that in include/uapi/asm-generic/unistd.h.
>
> > routines, they may be combined into a single sub routine like so:
> > awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
> >         sub("^#define __NR(3264)?_", "")
> >         print | "sort -k2 -n"
> > }'

Thanks for improving this, Tiezhu and Alexander.

The format between '[46]' and '[__NR3264_ftruncate]' has changed back
and forth for several times due to various reasons ;)

Above change is a good improvement for me and I tested at my side
with below commands:

  $ aarch64-linux-gnu-gcc -E -dM -x c -I tools/include/uapi/ \
    tools/include/uapi/asm-generic/unistd.h \
    | awk '$2 ~ "__NR" && $3 !~ "__NR3264_" { sub("^#define
__NR(3264)?_", ""); print | "sort -k2 -n"}'

The result looks good to me.  You are welcome to add my review tag:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
