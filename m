Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60D7748DC1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjGET24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjGET2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:28:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D4A10F;
        Wed,  5 Jul 2023 12:28:53 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e97fcc60so23884b3a.3;
        Wed, 05 Jul 2023 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688585333; x=1691177333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5TBB3lA3219LHYvO7O8r0trL8ZFv8X/mAnxkxOqj7IU=;
        b=D4HgX8p1dsAjSTSuUpPw7eJzRpQlgXgDnNzA+16nqrjL0N8EAm35oPzpWOlXhKnc98
         3y7MTGth2VRvMXujfnC6+U6Uv/7jUGGKOSrQMCOVraZ9xsSOOH3qyMpWOzumV5INHeMo
         qfSMh1RelkiplWKsSHQOWoIv3hJvwc1Ow1tWMKJb1kpMxDGp39Nsrp9k4Zfp0mINbnGv
         kwktloYdBkGs9HKMX3t5XEL91vkHuhkBf13z5mrU7hc9cs6NIyToiH89xJ8EB2PdglhK
         Nlg2LZnyIp9WxPAR+M6RV9kHR3cYuJIC+7iEEfJh1Mtb1OJRKUE977SdM5nmWFxiytrc
         MmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688585333; x=1691177333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TBB3lA3219LHYvO7O8r0trL8ZFv8X/mAnxkxOqj7IU=;
        b=gi4m/zYNtep8kefrv8hYebjsCViazAQLhphN9ptiWxJcwZcp4TI8Lo974y3zofsTzI
         4tUZoOkX/3l+v+kbSLl/ni5eKV309luZLVacp3741KMJiqFVO0yhpQ/gSkoA00m1QV4+
         5yflBG9iwe3puw0peVppUMnRBVQDbyTViakFp4ZOLGYPHdvWYLdFYw3u7cv52374r1ZI
         cnXFAgzrJlhfBUA1NeyCdkOYnHC0i4yWYt1JbqyVojqAv/60nhGm9Ci/uuLCxHy3QfyZ
         5ndfUQb20pm/Xz70+k4du98KMDhQLUEwERXBVr6dZBGBiMcmBGgsfJwvPqOhAQPwC8lN
         ECZA==
X-Gm-Message-State: AC+VfDx+Ns48vb3HojSRm5ESTXBsRCNPXrtu4s1CzyjIfOemxmCgOyFx
        llmGP1QT5C+SsmG6E7rrs6tAuRnJYrU=
X-Google-Smtp-Source: ACHHUZ4AIOheQA4xlTJnOr83/5E/dTQaqiCrhFN98TmyBgMB+ONKUzbrg7FpEsnizg+x6GZMv2g66A==
X-Received: by 2002:a05:6a20:3ca1:b0:123:b57:a3de with SMTP id b33-20020a056a203ca100b001230b57a3demr12810543pzj.46.1688585332898;
        Wed, 05 Jul 2023 12:28:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9fac:a99f:7f0a:397])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78497000000b0067aa2a70179sm14310213pfn.46.2023.07.05.12.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:28:52 -0700 (PDT)
Date:   Wed, 5 Jul 2023 12:28:50 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH RESEND] input: cpcap-pwrbutton: remove initial kernel-doc
 notation
Message-ID: <ZKXEcr+43Qkj8Y4m@google.com>
References: <20230703230005.14877-1-rdunlap@infradead.org>
 <20230704000821.z3tx4chw7x6pn6nq@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704000821.z3tx4chw7x6pn6nq@mercury.elektranox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 02:08:21AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Jul 03, 2023 at 04:00:05PM -0700, Randy Dunlap wrote:
> > Change the beginning "/**" in the file to "/*" since it is not a
> > kernel-doc comment. This prevents a kernel-doc warning:
> > 
> > drivers/input/misc/cpcap-pwrbutton.c:2: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> >  * CPCAP Power Button Input Driver
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: linux-input@vger.kernel.org
> > ---
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Applied, thank you.

BTW, the driver is missing SPDX annotation, Sebastian I wonder if you
could send a patch addressing this (given you are the author it is
better coming from you).

Thanks!

-- 
Dmitry
