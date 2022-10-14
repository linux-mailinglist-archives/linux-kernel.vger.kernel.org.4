Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322C95FF34E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJNR7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJNR7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:59:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B885FB4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:59:38 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f23so5438870plr.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lIA5kCd21RHEnMbxdNImt2sQ/3g725z4r3mMj6tBAeg=;
        b=hfa/QWPjWqnauRAj8LTTvkLH8F/ZfZmIPDY/huHYxu5usQnH2THr+sGzN/cWVm8Hg4
         hi3JZA4hN2jg9g1okYOWDiwT/CAMzepro+6AZLKfW7vNz8Rp+A8Q9bPaTIzbcberVsYN
         2A0sqgFqWi0uCLu/Ii+aL2/kLXUD86KYe2af4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIA5kCd21RHEnMbxdNImt2sQ/3g725z4r3mMj6tBAeg=;
        b=I7K7ZA+E6eCmW5atJXT34xGaPmDBxSzfhnd1UatpJdF6LH1uwRNL/ubzDYbInoq1Qs
         0yJIMDShOO9JxvT9e1xu0YL2l+Z27ZVLcr7rO11caO4PmmMYVPAqIlBijzFFbrmHCjfd
         0mrDq5yV1QYjuCTwCXVU1txgiJZnDumTeuBQ9JYtcYed2zPQMyic2yWnnEbkZQxRovIP
         7ce1Ur0G6ep/8Xn9JvSq2bEzx8S1N3FrtJ1pIo5VdEzFPLDKgRW5/WnLbdfiH/4ZvTtc
         uy+GdtZlf9vXDek1UPNCLSPZsMe12wfe54Vb69FWRJzH+Pp7x0RAzDmZN5U4PQpevdsW
         smHQ==
X-Gm-Message-State: ACrzQf0m+vZ/UXlo43Csq+yq7q5F3dIKYnMKhVTJ/F3oKJBnwsAAn8Mi
        Aaa5jxqhuDQTO8VWR/a74jA37P/aNlaDMg==
X-Google-Smtp-Source: AMsMyM4TRh2gr+kOS0rnlcc/KQKS33NEffPf3pWG7t7imgdj7HB2jOO7UNnIZR4eUJsSLYpCw3FUVA==
X-Received: by 2002:a17:90b:3d8:b0:20a:8e90:8e8c with SMTP id go24-20020a17090b03d800b0020a8e908e8cmr6907001pjb.138.1665770377827;
        Fri, 14 Oct 2022 10:59:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w11-20020a170902ca0b00b0017f7fa6808csm2015707pld.87.2022.10.14.10.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:59:36 -0700 (PDT)
Date:   Fri, 14 Oct 2022 10:59:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/9] integrity: Prepare for having "ima" and "evm"
 available in "integrity" LSM
Message-ID: <202210141050.A8DF7D10@keescook>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-1-keescook@chromium.org>
 <08a8b202-69b4-e154-28f5-337a898acf61@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08a8b202-69b4-e154-28f5-337a898acf61@digikod.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 04:40:01PM +0200, Mickaël Salaün wrote:
> This is not backward compatible

Why? Nothing will be running LSM hooks until init finishes, at which
point the integrity inode cache will be allocated. And ima and evm don't
start up until lateinit.

>, but can easily be fixed thanks to
> DEFINE_LSM().order

That forces the LSM to be enabled, which may not be desired?

> Side node: I proposed an alternative to that but it was Nacked:
> https://lore.kernel.org/all/20210222150608.808146-1-mic@digikod.net/

Yeah, for the reasons pointed out -- that can't work. The point is to
not have The Default LSM. I do think Casey's NAK was rather prickly,
though. ;)

-- 
Kees Cook
