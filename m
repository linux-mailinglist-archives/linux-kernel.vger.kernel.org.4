Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F072E6349EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbiKVWUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiKVWUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:20:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE166069B;
        Tue, 22 Nov 2022 14:20:12 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so206418pjk.1;
        Tue, 22 Nov 2022 14:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMD7Jgl2KgCfF+QO8SwcvRtFPaaTs1AYlnI8eW4kDD0=;
        b=aBVZEoH8qA5lCWPlLzie61AdlSz5jtqxrjmRYfn/mSfkn6vJzjWzB2X1I+omfNOOS/
         cmKpldGmf44zYIDqMCitFQAi9cu01ikrALC2qW7E4ic7qGWLmU+wOtqDpynZwUr2VcVA
         p7+vPmAGNEnX1FonsXYpaCK9iPIEPR6+Xb7OPklJgOlIFUOZ+YWLYi3koxeZsBEOpaES
         +OJKUmv0v2/1JAewaqjGYaRFTP17LkVTCXp4FnAsGXanLdBSsuaFlhA0rmdFV2lbmR2g
         sJdxSKWXnirZBlGCjZUhbicRUkJTpREucq7saBUrUrtffhDLOtoyC4SERbhy9VuZYpzm
         Vijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMD7Jgl2KgCfF+QO8SwcvRtFPaaTs1AYlnI8eW4kDD0=;
        b=HHkokbpEGJnJib6pqE0olQPIM+4GUYMewPdyfamXUeufR3q4BZ2BLM2QizOTxeA41i
         mPF0u9RiULuxRl3wJLhnfxY0mOUDgjFUP9w76aebooiyiNS6zD4vEUlSsJIUN6gECtu/
         vB9PM9w/0aRlcbKcysXsYiuEA6UG5hKCTskLfzn+obWCxJ2ul2wAwtX3gsFJSW99fnG/
         cMXu0UE6OIJ/gdh3RcuqOQsa/A9s+lO6gesGdYAV8fwJl2ASnzMawurrD/OhXMGQxMVy
         GE477l9AFSe25q8i3PO3B+YG2DHXJp/+2hDrAjsG5nSjr2jzD5krlER/tPzJTwHsa5wC
         Tp+Q==
X-Gm-Message-State: ANoB5pmqTKF7uW5ZrLNhJ4hxEk0mdDU+5TIcPYJ8SfxUa44xxgoddghK
        JAXC/OOXo0Aq63SPU8eMwzjAb2XEHf0=
X-Google-Smtp-Source: AA0mqf70rc8f7GuW0CGJ215l3r6HkDEEPA9Mh41Lf6aiyNDX/vO0KZSGBeFI5qu4YCqZa6EiyCFbKw==
X-Received: by 2002:a17:90b:2552:b0:212:f8d0:a075 with SMTP id nw18-20020a17090b255200b00212f8d0a075mr26863305pjb.92.1669155612094;
        Tue, 22 Nov 2022 14:20:12 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:af8d:6047:29d5:446c])
        by smtp.gmail.com with ESMTPSA id w68-20020a627b47000000b0057280487af1sm11083846pfc.206.2022.11.22.14.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:20:11 -0800 (PST)
Date:   Tue, 22 Nov 2022 14:20:08 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: stmpe-ts - drop obsolete dependency on
 COMPILE_TEST
Message-ID: <Y31LGJHOtZIKPJsR@google.com>
References: <20221121145203.1efb0c08@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121145203.1efb0c08@endymion.delvare>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 02:52:03PM +0100, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied, thank you.

-- 
Dmitry
