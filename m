Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D719866D21D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjAPW72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjAPW7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:59:25 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE45274B5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:59:24 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id v127so26099581vsb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TkkUsEwrv+2V9UAHItUrpPV5yAcwmN1K3z1/Xa1wp6E=;
        b=tyMlUO/0N8JvtANZ1CLULHkwFOdKsVBmpUJrC08l4nBSMtzxpeUDERdEnwK8NazxID
         BvAoZLWrBu3UdOrtdUVn0c2cISJ5ycAjPpeDmD18CI6OXEHy2MBETYfaCeNpZKVL4ijW
         EiVecOBpmfyAz2BPXQHnyG5JudZ3azjRf5oVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkkUsEwrv+2V9UAHItUrpPV5yAcwmN1K3z1/Xa1wp6E=;
        b=fnotAyb1eZp2J1Kj9FFFxUUpJxoW3zAo2+OYjRrfIzqjVdmMp3RYk0cCzNY1mSefVE
         2os2mWO101OvI+tj/6ri/OSfXj+5ou6T+OIO+m0fdDWVZ3Xhdzd1Xxlo1jIMk0c/KJh5
         nhHa64kqPopy1PJMd2WugGRNt83m41VRZpgty13NSdhVcDDFeb9F4DeFqPPDniHuO+GD
         ssjtA8/r4OOc+Md086SUYQmYJtLoM1Gof1EHF6EbYL9lF+EvJTWCwlSTFwqBy9dEsCfj
         HYCKJxozUH9qLi0bv73WtZChzszOddnPhUmA1lUC0BIEgnBdzBuxqoIx3wLGj6OjEIKy
         30NQ==
X-Gm-Message-State: AFqh2kpUWljQVa5VhaNJ7wDbi3nqF5UCQQcYcmQD888xNYW+LK+hAjg0
        9d+hvyOU5AXZ7qmAgMEKkzPL3XBMTx2w/e/sxGs0q9VoIDm9L20sECk=
X-Google-Smtp-Source: AMrXdXvA8PZ8QYiuV/L2cjM9k+hmb8K6qRjhicgMlm4cPEd+X43ILlUiG9cotA74flgCqnociuRuiGlDpg/kn/Wl4ZI=
X-Received: by 2002:a67:e9ca:0:b0:3d3:d06a:3229 with SMTP id
 q10-20020a67e9ca000000b003d3d06a3229mr80529vso.28.1673909962980; Mon, 16 Jan
 2023 14:59:22 -0800 (PST)
MIME-Version: 1.0
References: <20230114-doc-v1-1-efec2689e423@pefoley.com> <87edrxgk25.fsf@meer.lwn.net>
 <CAOFdcFNKJacBVtrV-hJyUu6hKBVFaKdpA84cZ6WGnZ=ZGnb4kQ@mail.gmail.com> <cb1333e8-0e0b-2e3a-f5e1-553d2722be82@infradead.org>
In-Reply-To: <cb1333e8-0e0b-2e3a-f5e1-553d2722be82@infradead.org>
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Mon, 16 Jan 2023 14:59:12 -0800
Message-ID: <CAOFdcFPY7=BqhQ7D17j-ER3dW6HyMXE8Ba7HpT_+hRZVnBXYvQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Avoid duplicate Kconfig inclusion
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 4:55 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Since b1663d7e3a7961 puts the Documentation/Kconfig just after
> lib/Kconfig.debug, there's not much difference in its location in a
> *config menu, but I would rather see it separated (independent) from
> lib/Kconfig.debug because I think that it would make any future changes
> easier.
>
> Also, b1663d7e3a7961 came first. :)
>

Fair enough, sent a v2 with the top-level include kept and the Kernel
hacking one removed.
