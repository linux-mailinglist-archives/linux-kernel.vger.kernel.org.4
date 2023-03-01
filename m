Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9166A6915
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCAIrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCAIrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:47:04 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B5C39CE5;
        Wed,  1 Mar 2023 00:47:03 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-53852143afcso347875977b3.3;
        Wed, 01 Mar 2023 00:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677660422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v4mPV72jd2hzN0tntVH2fsyOXHkaMBWmVayF09dUUVs=;
        b=aENFs1TCgRD0LbV1tdMk62zekAJlEbowaCycHWNmRzEXZjH+Dgp3qvEHnVDWE0SVQg
         DYvaGH2DpXTOrFtChmv/r5XkHurQLNBZva7KJcFLAwaCCOP72XgssJ6/Qt5EukZaIGgs
         /EzsTjk3fJV2Ow+vB2Vmj0QZP9fgIAgH1frwdz+ycDBT29xsaMIMmLMCpjL8vOfRttV5
         LLZVjFc3BcwFT1kxxu0CDwG6t/zfioU85mK1J4Zt/3qIPYXwPgVVqvHIMOpTapn/ZhFQ
         Vz/775x5QOV96RDiN1s8vCK3l5WoSpIF5HpGatM35RVxG+DJ6D4OiyGOh2+IY2jMGy3P
         Wm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677660422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4mPV72jd2hzN0tntVH2fsyOXHkaMBWmVayF09dUUVs=;
        b=occnpdnTfPDwAxjWZXhX3I4AMWlpRItbnpQ/FQ2+WTW1+7Zjdn6eU13Zk0u7mCOgpO
         E9BWxH/1agaFcTEh+GBclX2fujEMwuu4OKmhyix2gRxDAWSmHob6vGcLUFWg//FHnU2s
         TLNKm7NrwI0Lzhp1nS77R4s4khGGY/AIfuj0yTRbYP9QvcT0uiSRr3H2JKhFdiRQc8DX
         Tvxy98cgVqjnpqvzaX7gktLiLG+F47rncMfBcn3Q7zjLDLgDFu3vOG1aknxafkFO/yM3
         vJXTZ/VVLUBn9o6UvTAdXZIzDAGfb19OvO6/B9PEM8BYOgQzHVkOKRd6XKQtafMiwTxL
         Zajw==
X-Gm-Message-State: AO0yUKUFa1PVBFHR/fosGwDChV8l4wXSlj+7LHvOxcIIw3sacUu6dp/D
        pywcQcoUOt08Xd3+MdF3Q7H5CBllrO2V+4E/cxqUapylNJI=
X-Google-Smtp-Source: AK7set8l0AOWgSOUd0Yz90f50JI20Jp5OOzMsU3lMH4b4gpTmOBFkrFI6UECoAvS8Qg/Y6uFvJjg34K6cLRW4vIA04A=
X-Received: by 2002:a5b:211:0:b0:91d:98cd:bfe4 with SMTP id
 z17-20020a5b0211000000b0091d98cdbfe4mr2922125ybl.10.1677660422378; Wed, 01
 Mar 2023 00:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20230228175929.7534-1-ubizjak@gmail.com> <20230228175929.7534-2-ubizjak@gmail.com>
 <20230301075519.dbf770fed0476e2b6ecdad37@kernel.org>
In-Reply-To: <20230301075519.dbf770fed0476e2b6ecdad37@kernel.org>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 1 Mar 2023 09:46:50 +0100
Message-ID: <CAFULd4b0zQSzesH3mrbtThH17VnoPzVhg2R6cDpDZTMsPeDWpQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring_buffer: Change some static functions to void
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
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

On Tue, Feb 28, 2023 at 11:55 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Tue, 28 Feb 2023 18:59:27 +0100
> Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > The results of some static functions are not used. Change the
> > type of these function to void and remove unnecessary returns.
> >
> > No functional change intended.
>
> NAK, instead of dropping the errors, please handle it on the caller side.

I was under the impression that the intention of these two functions
is to warn if there is any corruption in data pages detected. Please
note that the patch has no effect on code size, as the compiler is
smart enough to drop unused return values by itself. So, the change is
mostly cosmetic as I was just bothered by unused returns. I'm not
versed enough in the code to introduce additional error handling, so
considering its minimal impact, the patch can just be dropped.

Uros.
