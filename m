Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4F9655B48
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 22:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiLXVSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 16:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiLXVSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 16:18:11 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED3EA468
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 13:18:09 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 124so5327830pfy.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 13:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n0tEj2KHHLXlRs/DpFrhZLI9re/SQ5h+K4lQdCJqf/I=;
        b=Eu7JWJQgRap8U5kq6yICeqv5y9X6K6LbFwtdlCPwE2B3a4ZEyTXIqC7BTmr4Sj5879
         jgJrU9zMgnCDVRWV9+DnE8ejx4MwHkJbkJMAqRMz9u0QBfMkmEYrMRP6+C9O2HpiJ5gU
         uQxQp7AN1ymhz2AMNbHK8K+rYPMMTR+kGMthRUcMWlWHSyhzwwZGw7Tr5djGL3+zOfN4
         4qXOvJeAdHJts1GkZ7LOUttNb8ppSk5g6mAeDqyhDCIxNCG8fwVlLCKsbulL279cpPj8
         sWv1GolkamqSCBKAkWiCWtXmKs/0P44hxgTVogfWnPQfPaNAjLI/5gx9jgeOX9tD2Bxm
         ttNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0tEj2KHHLXlRs/DpFrhZLI9re/SQ5h+K4lQdCJqf/I=;
        b=cnHeEbeZLM5LTRsHAHQLUJ8Rj+ot/Uw5EWcZz063+NcP1OuOR7QxP4S9eRQ968ELGk
         qJvura61CWejoB+HzXjOFTiRvwgJVIenwDrJC0379qAKhFnVKPx7ez2kIq6qjbfaUTrO
         hqj4Fiixpr9lUb48wdYK16gaOrj8cCBSnizobg5u/Eq7Z7Z1MKYrvgpv+mvu2PG1+0Eb
         e1XOHOATiY1WUu64PkVGhkxhvUhCj6qyhx5IC8swAbNvSHbAeIu0l8kH6w7sSl9VniCH
         LATZQPcFSx8RKiqM+a/5bXoin5QA+5Hc3XriqXDWM9LjWr2v/rs5B8zjhrA0+mtJLxdf
         VruA==
X-Gm-Message-State: AFqh2kpMaJEnlvzwIHQqOzOwEovqRxmWPX+ZYV7Q3i3gjY/+Lxpk2G3h
        5NMEMatNQrgvObFeEcwQYozTxwoAbnbgIN3vSGcwAw==
X-Google-Smtp-Source: AMrXdXudlR3eJWqL676SrUiUQ2KL6TdVyqZp+yAys+Xtb3e9mJru5OHtHaaQ4dUt6Bl6SBfXkPhTpieAoEN9ExP/jnw=
X-Received: by 2002:a63:161d:0:b0:46f:6225:c2f9 with SMTP id
 w29-20020a63161d000000b0046f6225c2f9mr564361pgl.225.1671916689378; Sat, 24
 Dec 2022 13:18:09 -0800 (PST)
MIME-Version: 1.0
References: <d7bb31547e9bbf6684801a7bbd857810@umbiko.net>
In-Reply-To: <d7bb31547e9bbf6684801a7bbd857810@umbiko.net>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Sat, 24 Dec 2022 16:17:58 -0500
Message-ID: <CA+pv=HO1mvnN5XZHkWDjWr=NJHJZxjcstiY4qtJGJ6mfsqPfQw@mail.gmail.com>
Subject: Re: rtla osnoise hist: average duration is always zero
To:     Andreas Ziegler <br015@umbiko.net>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 7:48 AM Andreas Ziegler <br015@umbiko.net> wrote:
>
> -- Observed in, but not limited to, Linux 6.1.1

Wait, "but not limited to"? What does that mean? Are there more
versions affected?

-- Slade
