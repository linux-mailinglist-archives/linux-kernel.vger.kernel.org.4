Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6448D654C01
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 05:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLWEwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 23:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLWEwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 23:52:33 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8CEBC19
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 20:52:30 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id f189so3594363vsc.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 20:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z20+RyUsiKCYY3UtMSTKOnq4RpClm0Q3mpq/PYpUDfo=;
        b=gjKIexK/ctrL75e3v8CxTAgZuNV8jF91r4VZGPZ9Dgdg0DbmTWMh8Vme8HJim6XTQM
         EFuvULI139z8qk5kKL46kfWilaWuL5+a2dLAzk545HRAHdbpCQLi5up2vBa6yjyfcNAS
         BzwjgOQQnzn/dOkmrqU0vQ/0YxFDm7TChZK4JR7oboun9nRp+1oUsX+8Ej0mpwzlA/n2
         VihVNPDbe9Iar5Px7Y+ea+scU/jGPEyA1cqBeGLMvC+wcXToFRVerirX5MklucXHgGmt
         GvRPis3zRJnByru5WJO2ogNj3Cv795VWF67bAZwZSaANUVdbyBFanIqdtSlTMQ1xI2+9
         ulMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z20+RyUsiKCYY3UtMSTKOnq4RpClm0Q3mpq/PYpUDfo=;
        b=TdqFmGLAjd6QeF4Y6tjS8rZjw9ixQqfhflUy4GKB7gD637L1q4eiqMuDdU38YAMUVH
         O9Nj4l+TQcFcDjBAqAUv+OFhi0BwPLMwK9zoliuNdKAOpRXHcoF7dqIM8c9jxWyXhCXL
         pjx+6vOmro0UG6y1ztMb0ZUZa/IHSf5VK90AKlJjtQmfmjQ1+A/5luttYip7pA70Zm1M
         jTtXE5COOux1CIywxaZRTOuZfQSTeIUwfUd5Sa37y9bUzlfS8SuA6soI3JSTfbqw98gB
         IyGIA6ehz3rb7TD+h7vDFYeyKBCft7qBHqAO8aiKRhnxAhaH1DtR/klP8mNILnAezoVm
         50vA==
X-Gm-Message-State: AFqh2kqeF7O89ASzHlOckv0N2Yq98p97JVdP12LYgcdQp06vcc4k9Vp5
        0DZO2sW4s2/luDIcCpfPMYXarEXp+5TtMXXHwjA=
X-Google-Smtp-Source: AMrXdXtD2c++8WNhjqvQg/qo4ety/6pGlkNweqLEzcZn0yu3YbmQAngj76u/sd9Oa3Ft+xcuYbMSZDWBNYUHy0z9Sxg=
X-Received: by 2002:a05:6102:1498:b0:3bf:968c:1724 with SMTP id
 d24-20020a056102149800b003bf968c1724mr955730vsv.28.1671771149897; Thu, 22 Dec
 2022 20:52:29 -0800 (PST)
MIME-Version: 1.0
References: <20221102160236.11696-1-iecedge@gmail.com> <20221114122255.72588f45@gandalf.local.home>
 <CAFA-uR8TakkW=KoA_9RXcyw00Zj8+nNn2erSZ4Y9ULNM8ne11g@mail.gmail.com>
 <20221114220216.05dd0541@gandalf.local.home> <20221116000707.a8a692e377d8daaf3764ee64@kernel.org>
 <20221115101837.37da9d1e@gandalf.local.home>
In-Reply-To: <20221115101837.37da9d1e@gandalf.local.home>
From:   Jianlin Lv <iecedge@gmail.com>
Date:   Fri, 23 Dec 2022 12:52:18 +0800
Message-ID: <CAFA-uR_Bhc8fdBXajKzSSXQ1Cf_iLirK0gS+TovPM9G7MLv=dg@mail.gmail.com>
Subject: Re: [PATCH] tracepoint: Allow livepatch module add trace event
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        alison.schofield@intel.com, davidgow@google.com,
        thunder.leizhen@huawei.com, jianlv@ebay.com,
        linux-kernel@vger.kernel.org
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

On Tue, Nov 15, 2022 at 11:17 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 16 Nov 2022 00:07:07 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > BTW, now the kprobe_ftrace_handler() uses ftrace_test_recursion_trylock()
> > to avoid ftrace recursion, is that OK for this case?
>
> Note, the ftrace_test_recursion_trylock() only prevents "same context"
> recursion. That is, it will not let normal context recurse into normal
> context, or interrupt context recurse into interrupt context.
>
> It has the logic of breaking up into 4 levels:
>
>  1. normal
>  2. softirq
>  3. irq
>  4. NMI
>
> It allows the high levels to recurse into lower levels
>  (e.g. irq context into normal context)
>
> Thus, the code within the ftrace_test_recursion_trylock() must itself be
> re-entrant to handle being called from different contexts.
>
> -- Steve

hi, Steve
Any other comments for code changes?
Is it possible for this patch to be merged?

Regards,
Jianlin
