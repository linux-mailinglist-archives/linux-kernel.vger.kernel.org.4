Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783FA6A29C9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 13:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBYMrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 07:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYMrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 07:47:47 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3194818AAF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 04:47:45 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id h17so562626qka.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 04:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ppt8xrJTok6dPPvHOc17Af1SESjrgSpeCBregmeAoWo=;
        b=OE5CDuZ4uoGuXthbAXSnvToCXo47fumN91CJ7Y5cQRlPWcSbCpAcLL0tjzdVniromD
         vvLL8+EzFfX3+7J0fLJ1WfYrIYqCqQ+J6+zoUWpvo5856BFVF5M42MJLtnD0Zrosiszo
         E4+XA53X2ulBhtHWixDW1z+rGYISnVqVM6r7Qmx5P9V3QqR1oHpdHXI2PkXJ8dFP+yZe
         jJUg9w0mibVX1EZGZ12FHb++1FXCl6uiFoolVQqVck+C7Twtkn8CnPyGhBp0WFVEWQ0B
         aLIas6WsnYI49GsxV0aFaIv8fJqKgMQEhFirzKWX4JUJSClpkByohPmJziblqHZyMP1i
         ELQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppt8xrJTok6dPPvHOc17Af1SESjrgSpeCBregmeAoWo=;
        b=mkNKgmAmWdR7S7/szPdMchUKMdsRa7htwZt9Jdo0qtGpqcZSL0kcgyE3Jv599f6/5c
         DEWB032eoaF8/hSw83uK49hgxEoyeCslQ3Zmp6Nms9DL9r7B/drxtHn/oSGRH1tFebI/
         cZtZjU/ToY1MKnqm2jjRZc1JBIMXgb2FYFmsWYgGuaGP7VbMQ6BFrq0lwxC5yorMYA7U
         PdPJbj4P5T6fGH6t44UGxwohxJFXd+cHl859Dwn4adaJlhPLYP3CROzl4apvrg2Sk/fn
         ITpMlxWYoUv8JbNC/JFHBLv3GQ5icMHcv/T15lYvnGXWhx4S8fWUzH/8QX0kKNHCezsS
         Cr8A==
X-Gm-Message-State: AO0yUKU1ECxkEQh/lz1cF6dh3pGEmYnkTWo9yJLVHcVfp60WEnIieiXV
        DigD0rakCC6iuTHHo5UGppBYumkmEqIdul4WWQ==
X-Google-Smtp-Source: AK7set+aavpjNvIKpx9y9NBzkxKtTW9OrtSVecHJGHPKleA6RbAa6ZIRXpUA9WswIZMz7U+8jUx4OOWtO29AxtGLafI=
X-Received: by 2002:a05:620a:158a:b0:71f:b917:f4df with SMTP id
 d10-20020a05620a158a00b0071fb917f4dfmr3197262qkk.2.1677329264031; Sat, 25 Feb
 2023 04:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20230224154235.277350-1-brgerst@gmail.com> <cfdb9c5a-4723-d920-511e-b57ae6c492f7@bytedance.com>
 <CAMzpN2hvPHWYOeyzfpRmk39XYwCrSJx0UyqxE48F1TjTNyoKAg@mail.gmail.com> <ca5788873c373249983ab6ac9ee173b12293641e.camel@infradead.org>
In-Reply-To: <ca5788873c373249983ab6ac9ee173b12293641e.camel@infradead.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sat, 25 Feb 2023 07:47:33 -0500
Message-ID: <CAMzpN2ixYTKQaNoizkeNBrHQH_2SN9OMexnK9t3oVMDDCMwbOA@mail.gmail.com>
Subject: Re: [External] [PATCH v2 0/5] x86-64: Remove global variables from boot
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Usama Arif <usama.arif@bytedance.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
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

On Sat, Feb 25, 2023 at 5:20 AM David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Fri, 2023-02-24 at 16:38 -0500, Brian Gerst wrote:
> > Removing the globals before the parallel boot series, would be the
> > best option IMO.  That would make the transition simpler.
>
> Looks like this:
>
> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/parallel-6.2-rc8-brfirst
>
> Passes basic smoke testing in qemu, including suspend to RAM and
> offlining CPU0.

Looks good, thanks.

--
Brian Gerst
