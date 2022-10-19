Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46194604F93
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJSSZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJSSZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:25:06 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A21CFC5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:25:03 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-131dda37dddso21753275fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJWA+tc9YhqI4k2KAIJogSf71IWflgzklnanU9Jdikw=;
        b=ENvsBfE0m0JaOXSlMWgjj/Ki06mt3/Or32tBfiCEvY42utQAD/xoDWYf81KaJevNYl
         chzShNWlRxtquVba4OIQRh7gpuekqzdOQ4wzPvcmoSVQiYfSBwyAxD844pOFSppDNuFe
         MSocL4nMNm8tkwpeBt4rpMgy25x1YPoJNwYOhrpKTKOfTSRcw5bMquMESMS7xtUYVIQp
         qZcxfM/nebuGgdYtpQDW2sVoizJLBxy+9fbxUc6nW2gJU09Oa5/TNL5V0W4cnZ5ynUSu
         bAxAjr830D/JPHgpkX6rCizY/09jGnzgyGjdtbDlQymK6qe2YUuM9PfHgrg6ywJGhl5z
         LUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJWA+tc9YhqI4k2KAIJogSf71IWflgzklnanU9Jdikw=;
        b=lL8ikRoA49Nk/v4eZOkKyDfi9hV0B4YVx31EN0AU1kewVIsueW7ZEQWS9wJJv0Ssqk
         E+Cm6oDR2RBHPYcgvdUcg3yNmvUbB4OJqO8rZd9/fNgCOmQBhTePny72N99oHg+A5usq
         kV2xCj6torAfbWx1cJ2tMYaZNO6WCqZEtO5kZ1A3TDafS1zmQeBBdUN5jMfrImMLUqGA
         N6NV3kfAOO3RNqOR1pT0T21m9Z/IfSbJSz3Phs0cvlhAPB1h8EyGyKUMHPZLemZM5tAY
         +pXdp7Te937q0IPm5V8taa5kzXF0Vgl+ViLbuoNghLXYcEUXK/3RoxPQKs/s5Cby7dDo
         gpqA==
X-Gm-Message-State: ACrzQf2VS/L8Hnlnh4yP+XvTyoqRT442SOIlPvP5EMSP3lcVqEs5HwIO
        6PjXIP1UsbqpRCYpRgZRlaM=
X-Google-Smtp-Source: AMsMyM6gwgap/EDcCwrNT34cesT3cV/ZEmvBBNzJ7TQBTRaO5iPWSM5z0DR3lpgqI3zyOp7WPFuTJw==
X-Received: by 2002:a05:6870:b392:b0:136:71ed:c874 with SMTP id w18-20020a056870b39200b0013671edc874mr22470109oap.66.1666203902269;
        Wed, 19 Oct 2022 11:25:02 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id c94-20020a9d27e7000000b006619f9a0c73sm2119416otb.1.2022.10.19.11.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:25:01 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:22:50 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] cpumask: limit visibility of FORCE_NR_CPUS
Message-ID: <Y1BAekFR0DVY4rfo@yury-laptop>
References: <20221019052200.1604488-1-yury.norov@gmail.com>
 <Y0/eAD+eN7+3R/4Q@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0/eAD+eN7+3R/4Q@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 02:22:40PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 18, 2022 at 10:22:00PM -0700, Yury Norov wrote:
> > In current form, FORCE_NR_CPUS is visible to all users building their
> > kernels, even not experts. It is also set in allmodconfig or allyesconfig,
> > which is not a correct behavior.
> 
> Seems you forgot to update the commit message to explain the choise usage.

OK, I'll fold-in something like this:

The 'choice' and sudo config UNFORCE_NR_CPUS are used to ensure that 
auto-generated configs that try to enable as much options as possible,
like allmodconfig, don't enable FORCE_NR_CPUS.

Is that what you mean?
