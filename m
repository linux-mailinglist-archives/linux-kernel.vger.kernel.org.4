Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6292B6B2CEF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjCISbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCISb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:31:29 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7CEFCBCA;
        Thu,  9 Mar 2023 10:31:24 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id da10so10805719edb.3;
        Thu, 09 Mar 2023 10:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678386683;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL3vJQLMwvrFPZuvcGQteeoAwE6uQDEGn/ryjX0udFs=;
        b=c/ayMgaTqA7KmwLm3w+8MifM19qRJgJZjzhw01kpuloVxckvEvz/VFpmdgz9xoBQaN
         nX0AhgC1diWxOizDCuiDcw8L+1N/gtuqtAmLOpZt67sG3F4g//upnLtp6l0FPILGZs+G
         0abwxTXP4MUYCb5aM+J2VMVb/BHkvOuqY9I19j+nzHxZj3hkw6D5H/Y02ZE/31Jn0QwW
         Hbzh/ClZCjW3nngo6FcplR1fOs13qwITiXAw/Jd0R/Eg7ijrWUup98tn7uKPj49Z9Y6j
         0mseloTiy3FHtlw5CcPbViS3yf18jaylCQYm+hRtA5V9T1uEiSz7cQ3+b43heStLS0nt
         jA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678386683;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DL3vJQLMwvrFPZuvcGQteeoAwE6uQDEGn/ryjX0udFs=;
        b=bZj5ZVFnWZykc7bB23kiG94MAL6mlLsWV93uGdkUGlXsEEm83qSYtiEc3dQ1v89OhE
         OS3vOHdbW5LBjZPqfq8+B/+ukDEmvi75ySxbwgR0mYlc6atU0nwgkSsxSub8DLl5bGkm
         nt7saTz5J7yhXZjtXJ1+Mo1S8OJGvTj9NWuLrcb/15G4DE9+o/T+6f/ujQsdEmXkJYFL
         mrNj0PdhlAfnLZFqolcy115SoWDgRrbZZGkT4qeUwlh9dMzaImCxjwM0XMhSEnrmbQnl
         nEuI8Odv5c+oUbVRZCSnMPC68D9h4nMo5i6iVQr3DL4YUgoRkGt+Ru10L4eKXzYSPssp
         bu9g==
X-Gm-Message-State: AO0yUKVWV8j2+6qRP0mPhmFHpgSh9h2DhNR+tHEmqLzEwbmSMJW3QqEZ
        mjwYlOCar+ON0w1/9Pz8P/I=
X-Google-Smtp-Source: AK7set93LX8u8C2K/QXC31rjkLzGQHb9164p5fyPr/+MiCfzM84OLN7njAKXluPAiku1Kf/IFgh8AA==
X-Received: by 2002:aa7:d74b:0:b0:4bb:e249:f1d1 with SMTP id a11-20020aa7d74b000000b004bbe249f1d1mr18950788eds.33.1678386683242;
        Thu, 09 Mar 2023 10:31:23 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:5e25:9ef5:7977:d60c])
        by smtp.gmail.com with ESMTPSA id gv26-20020a1709072bda00b008e93991c034sm9134088ejc.46.2023.03.09.10.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 10:31:22 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 09 Mar 2023 19:31:21 +0100
Message-Id: <CR22F969CUPF.1MU6YEMD6OE7W@vincent-arch>
Cc:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dyndbg: remove unused 'base' arg from
 __ddebug_add_module()
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Jason Baron" <jbaron@akamai.com>, <jim.cromie@gmail.com>
References: <cover.1677612539.git.jbaron@akamai.com>
 <855201dc0204a1428a79d415c97df2b6e11c95c3.1677612539.git.jbaron@akamai.com>
In-Reply-To: <855201dc0204a1428a79d415c97df2b6e11c95c3.1677612539.git.jbaron@akamai.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> __ddebug_add_module() doesn't use the 'base' arg. Remove it.
>
> Cc: Jim Cromie <jim.cromie@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Tested-by: Jim Cromie <jim.cromie@gmail.com>
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> ---

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
