Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CBB64BE90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbiLMVhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbiLMVhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:37:12 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A507624F19;
        Tue, 13 Dec 2022 13:37:11 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id q18-20020a056830441200b006704633f258so725763otv.0;
        Tue, 13 Dec 2022 13:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ffFvuzeAsFg4usIiUX8o14DQ+ZaIRo1HJb/MQnPkF9g=;
        b=lVHYHiVdiriGasw8OkvwLO1dBUMsjqhbb0P5PrAKWxYGG+8JyfBkmBgUxloWixBVKz
         F5w9K3bkIHgyKBk/GTHCK5svvqYo339g8xZNr2XDCJnkoBOthB1CpX7jh+2YCsze/JqD
         yglo6EA+r8K9DEakGxN7Jsq7GJmxkbJ/GHS62lrUo8jTHWR4iqAPfVyTpy1C9PvOt6bu
         patcV0mRzOAwydXPk3jgUv6pe0ht8prcK5Acp+uH4mWRFZGxFkkDxhYEHcYoNcN6na50
         9x8RDiAtBdNHesGeBRQC46yCRxgiD2kLyw/q7ZmSzL6bhUsmyxCtCOLa9WhodoRc3Uv+
         aFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffFvuzeAsFg4usIiUX8o14DQ+ZaIRo1HJb/MQnPkF9g=;
        b=t7smc+mWGmZq7xP+vPwsdRwskbs295TSx+dWJSj4jTTLa+JLUgm/vsgvu4NG5AJzTV
         cYdsP07RXDIg1QkOifO4/KWU40pRxxEKBQnu7O76c94S8UuAFWp8XOCrJZAAJFeTkWtC
         2YrTCSCcLbowAXGzNNAfWtaXouV4k39/gfWodrS/QHwMShtCxmEFs8WigBmgaug5Ds/A
         P4ElAAUuMLYMxU5YdHw8Z2mwLd86nOWVNFk9Vwj3z3t2BI6BnnDy+Ha6XUNkjKovfIw5
         Nwg39lnPsQHjeulX4ll+ozRdjMxlRRd7PkkUyp+dUVvDHE6jVa5LCe3sbiSke5zzFnD3
         Dh/g==
X-Gm-Message-State: ANoB5plLdgic6Cou0483qqkt8r3eQVxx8oloQr7HdzAY27FhB+CTYaNh
        YjVG8F4elM7Sh060yG3dnsA=
X-Google-Smtp-Source: AA0mqf7l7tmOEMaF5vfVk9r2cjRUTnBsKExODssz2oKdil7MUCQWwASGcftynjuqy7MK1t5WT6zCYw==
X-Received: by 2002:a9d:63d6:0:b0:671:cacb:681b with SMTP id e22-20020a9d63d6000000b00671cacb681bmr784330otl.22.1670967430928;
        Tue, 13 Dec 2022 13:37:10 -0800 (PST)
Received: from [127.0.0.1] ([187.19.236.93])
        by smtp.gmail.com with ESMTPSA id v21-20020a9d7d15000000b0066c3bbe927esm1662336otn.21.2022.12.13.13.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 13:37:10 -0800 (PST)
Date:   Tue, 13 Dec 2022 18:36:49 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the perf tree
User-Agent: K-9 Mail for Android
In-Reply-To: <20221214083434.4616378b@canb.auug.org.au>
References: <20221214083434.4616378b@canb.auug.org.au>
Message-ID: <45524A4F-3892-46B5-B987-6DCF11F58DF8@gmail.com>
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



On December 13, 2022 6:34:34 PM GMT-03:00, Stephen Rothwell <sfr@canb=2Eau=
ug=2Eorg=2Eau> wrote:
>Hi all,
>
>Commit
>
>  9e03ed43cd4f ("perf stat: Check existence of os->prefix, fixing a segfa=
ult")
>
>is missing a Signed-off-by from its author=2E

Thanks, I'll fix this as well=2E

- Arnaldo=20
>
