Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB123693A7E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 23:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBLWge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 17:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBLWgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 17:36:33 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F8A9ECD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 14:36:31 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id t74so1349569vkc.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 14:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m5X+loVkekmWAtecIw7mDl3tfiILMPh5j36qJ91yzL4=;
        b=nWDmOYxr1N+J11/m5t6fG/l13wuHTyUtyzsLr4y9aoSA0Bg77CSGQFT8Feq3i5xRlg
         WtyTeruo4+DBnw1NxQ9juNfACIGUxmxeu3PEMx/jCZLc7zMCoLY1kyilssnfck+o44Q3
         8gglsGdXLoVUVECPJHKqCfb89v85alwG9Jb44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5X+loVkekmWAtecIw7mDl3tfiILMPh5j36qJ91yzL4=;
        b=XqFBPuQcYOl9kOhyFCxPyfmqEq+3J90nXdGdwtF492wvT60h8ozXj5E6EmwQYLGk9+
         bZDpSgGjDGKgrRf4W9QOaqcuLGgJIL7Ct6dTtfWEfk+3W+R2I2ApSAuFvsxFUcuo7ncu
         ngY5EdhCBsInWBTBx9QYtOriyqVaiR/IgWckXhXEYQC5u8pX14NUCFEbLEyh5q7UWrrh
         DieoNSASadisqBrOaRHaq4fyW8H7JKnQzqnRkeGS5pRD/FiWYeC4wnGIjukJvTrPSy2j
         7gv0GSO9RjvrUg+sFFVrp7sMURLp5mhcwvaryLZGSn3lfevoYoPfatlyznHKVHO4HwBs
         VJjg==
X-Gm-Message-State: AO0yUKXr9SWjt+8fu/RzFb4ZK1z85kiqJhbQuJoQ8UYB7+iQskLvBC4g
        ndjsBDjsw7so0BWRk4GcxTfdK3/4uA0KuIp9WJN2zIozxXVhS1wAuQU=
X-Google-Smtp-Source: AK7set9CT/bP6FdQMWLZJ9gvk3wqo+zOjk/BDlcennIWv05w/gqQD1hEwzOYOa+C5KiHIRp+6+1xwuRg+i2xZbNOZwQ=
X-Received: by 2002:a1f:1786:0:b0:401:7237:7c37 with SMTP id
 128-20020a1f1786000000b0040172377c37mr265318vkx.43.1676241390343; Sun, 12 Feb
 2023 14:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20230213081128.0659dd4d@canb.auug.org.au> <317345605.121578.1676237317911.JavaMail.zimbra@nod.at>
In-Reply-To: <317345605.121578.1676237317911.JavaMail.zimbra@nod.at>
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Sun, 12 Feb 2023 14:36:19 -0800
Message-ID: <CAOFdcFOA6DJ31K-HNx71Wr0ZEg+SK_ydw1vTjgjpd_-fOj8D6w@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the uml tree
To:     Richard Weinberger <richard@nod.at>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Sun, Feb 12, 2023 at 1:28 PM Richard Weinberger <richard@nod.at> wrote:
> Peter, am I allowed to add "Signed-off-by: Peter Foley <pefoley2@pefoley.com>"
> to these patches?
>

Yeah, I guess I forgot to pass --signoff to git commit :|
Sorry about that.
Please add the missing trailer and I'll fix my config.
