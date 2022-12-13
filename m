Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38664BE8B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiLMVfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLMVfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:35:43 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3126B24BD2;
        Tue, 13 Dec 2022 13:35:43 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id m7-20020a9d6447000000b0066da0504b5eso668376otl.13;
        Tue, 13 Dec 2022 13:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CNX4PqimcEc8+WvrM+v0L1cP4zzmkD9zoQBmjrGWCSs=;
        b=HVhtWcdC+4j0JLgOLq57s0QwlYo8nQNYhXvYgJWuxJXt5BVYmeNscj3ulCtU9JOtu0
         RYf9U1TotXu70Qglm+tGhqd41IUn63rxBQHmOSLRVdtx0L06OdjZNY7ozvnGhSSW4TO2
         unU36D+xk46scAA4QVswRkg3uOCikRLH1KMV9nUgYNSxT4BMpj8FjnAy3gwjm/wVYNQQ
         HeuYZWI82G60GIn4p/THPlPVKv19UrDp1N5UTKtHl9Jkr5sTXiUy1Zq61IcllhMDXkYH
         dzHyJKtsSo+ucJePXOok5LAbkTzqJeQRfnW9kIHd++58f0maEdfFvNA6lEgebDSOoRpH
         iPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNX4PqimcEc8+WvrM+v0L1cP4zzmkD9zoQBmjrGWCSs=;
        b=UCEPSP1gasb79kcHPoA5AVCVCmCwl2Q4xmvUfWkY5TjIsh4pX6E2IT8456//Lfq7e5
         ppEMuq4PQWvHuGOrJG5VphjUKGra04GTdqmHWat0LudxzAs7CWKUnEzmvJMtcjvBfvwq
         WUtsKGYHc+2iM4osaBmr1Sk+QFPod0MTkQl2yzg4idYtfC1/CjxP7asPfMnIx/NjbIvE
         //RSyzq5tXbkqbYoos12KsPBBtlU7BXqidt+fvxKUjFkJti7YSGcNEFPMNe5dHIw+SSI
         Bynj3Z+Ncs1tI/OxNkETWTJdyxkKRMPuYRovTJSl5+5FPoTq7mPZvpgv96VoTWbOqyr2
         vGDw==
X-Gm-Message-State: ANoB5plMeDT9E1FgN6MYT8Sz3sK1DDRbrk+OHUI1YJWGtkFq4TZiDOKf
        ZoxJ2cLSylVRTAy0cak9Boo=
X-Google-Smtp-Source: AA0mqf7DS7fgWqk7zx6QzX4I8e3sB0Tbiy52sz3cXJATiTFBJO2bE9gbyMInEqvhHzoNTObb1hR7rA==
X-Received: by 2002:a9d:7518:0:b0:670:9e3a:73c8 with SMTP id r24-20020a9d7518000000b006709e3a73c8mr3892838otk.15.1670967342498;
        Tue, 13 Dec 2022 13:35:42 -0800 (PST)
Received: from [127.0.0.1] ([187.19.236.93])
        by smtp.gmail.com with ESMTPSA id e22-20020a544f16000000b0035aa617156bsm5030383oiy.17.2022.12.13.13.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 13:35:41 -0800 (PST)
Date:   Tue, 13 Dec 2022 18:35:20 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the perf tree
User-Agent: K-9 Mail for Android
In-Reply-To: <20221214083119.248fa4a8@canb.auug.org.au>
References: <20221214083119.248fa4a8@canb.auug.org.au>
Message-ID: <DE1831F3-6F50-4299-A457-4F19C32D2C81@gmail.com>
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



On December 13, 2022 6:31:19 PM GMT-03:00, Stephen Rothwell <sfr@canb=2Eau=
ug=2Eorg=2Eau> wrote:
>Hi all,
>
>In commit
>
>  4d59952792c4 ("perf test: Update event group check for support of uncor=
e event")
>
>Fixes tag
>
>  Fixes: b20d9215a35fb6ed ("perf test: Add event group test for events in=
 multiple PMUs")
>
>has these problem(s):
>
>  - Target SHA1 does not exist
>
>Maybe you meant
>
>Fixes: 82e236e28a79 ("perf test: Add event group test for events in multi=
ple PMUs")
>

Thanks, I'll fix this and force push=2E

- Arnaldo=20
