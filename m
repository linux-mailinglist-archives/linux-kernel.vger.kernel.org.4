Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5C96977C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjBOIIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjBOIIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:08:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE72366BC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:07:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a2so18156443wrd.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPMJsA1KpeE5VoKwKV4tJd2pa41EOw8Ss33XN/h6Hpc=;
        b=dxxjsaIKM7IF5XURFRVgZLsB9Hlouv5GlxlsQUQKT5Go7ayu32gHi2ryj/tzAqXTHw
         5Km7YTJo4oFXb6/8ca1xrBIxQt+VDv24Q4B5vsvFTlcuZxQhAhfYpsacK+RdE4v4OSig
         6RxERd3TZ7PK/O53nY9Tk7J1Hgy7xGdkVeaSyp42gH8k8neuzSTzei3NjVgQzbIeAHx7
         DXj6pUxNnQlRRTVS4YSrCjvZyQ4oeyuhqdnaCDoyH91XpJtvPwCdcEuJIgpgMgWdWM4Y
         PiRCtPlqyIFeFuZGrg84Xs/GiHRt+TisQhVDMPCYi/lgj5mondLDBcUilmvSbdqqk/ZH
         itRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPMJsA1KpeE5VoKwKV4tJd2pa41EOw8Ss33XN/h6Hpc=;
        b=ImdTHnQjEPWBRrhPz8PggFDJsx2kbJfPrdADVwkyWE/GVxgjSsH258Me6O0kxlBB45
         mRUJfuSOZ+8F2+X6Km5ubYbzNHLOlxUfD6S3bg6t9KphDTaKN6j3n2jcpbB8kreTHtYs
         zt5iv1mBh6jjiUI+A8luWl7um2suUV3ybDpVsvjYHbOwXoSfLtwt3cP5qwkY2E35gtcK
         250EXQoiEulO6PH/DX6Z8vizdpLpONCtEmpqXDqhUpDArbx2KkIB1LkevdymxigxyqWu
         NQUlTt3jAyGaEoPPJqJ/8/sVfZJC0/djan6HcEUXnztH3oaibEa9p0WhwxjwWAy4GqHT
         NVQg==
X-Gm-Message-State: AO0yUKU1SEOYhviPvImot0JOCqavq03ZHZ7CkMvcdY2cSRmyRNHHFEgh
        OIm+3Mb6g50EMwyRAJLLNyzqOnBjJa5HN7vK
X-Google-Smtp-Source: AK7set/i88qdd3+GM+tZM98/pv3VHLnrlJpTWpFeuVjLM7BbjrcmP3iwkYHWh5OP4ps9FFX9mAcPug==
X-Received: by 2002:adf:e6ce:0:b0:2c4:848:bbd4 with SMTP id y14-20020adfe6ce000000b002c40848bbd4mr871805wrm.36.1676448465631;
        Wed, 15 Feb 2023 00:07:45 -0800 (PST)
Received: from smtpclient.apple ([77.137.71.15])
        by smtp.gmail.com with ESMTPSA id b16-20020adfe650000000b002c5534db60bsm8619336wrn.71.2023.02.15.00.07.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Feb 2023 00:07:45 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH -tip v2] x86/kprobes: Remove unneeded casting from
 immediate value
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <167641982421.1677831.18379341946856978545.stgit@mhiramat.roam.corp.google.com>
Date:   Wed, 15 Feb 2023 10:07:33 +0200
Cc:     X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AEF3FED8-BF58-4B9E-B36E-662A09636A70@gmail.com>
References: <167641982421.1677831.18379341946856978545.stgit@mhiramat.roam.corp.google.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 15, 2023, at 2:10 AM, Masami Hiramatsu (Google) =
<mhiramat@kernel.org> wrote:
>=20
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Remove unneeded casting from immediate value assignments for relative
> jump offset. Since the immediate values in the 'insn' data structure =
are
> assigned from immediate bytes as a signed value to =
insn.immediate.value
> by insn_field_set(). Thus, if we need to access that value as a signed
> value (in this kprobe's case), we don't need to cast it.
> This is a kind of clean up (should not change behavior) follows =
Nadav's
> bugfix.
>=20
> Link: =
https://lore.kernel.org/all/20230208071708.4048-1-namit@vmware.com/
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks for incorporating my feedback.

Acked-by: Nadav Amit <namit@vmware.com>

