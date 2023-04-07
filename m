Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6696DA8AE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjDGGCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjDGGCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:02:33 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F4640E0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 23:02:31 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2C19C3F244
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680847349;
        bh=zft3hVuwccqOkIe+/jXqzbhmeCB7evQzBPJj2Wk1H3M=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=gS16hkVG5dO458cwTtzME3atj2rvaCDCP1FCz+Jafc/0+rbq126vr/JiQ2AsPBdcA
         a5JIWFR1Vhd5SD1x2irJkBswY+UQL29cbwmH8SE4ZKSCx8X6H1/KVg1+ITYe5Es6B2
         I4oggT3cK5Kyv3Yq8q9yGDrIpr9qrqTF750+/dXMvVR981tuH2V59y7f8ay0BQmbUv
         MCat5yicqLNGDsyH911X5vCGxh60mFK7rPV8/FEsbW5WPzb01iRYgiGxOO57Hm7o1P
         HYKKxo91b+GIISfCU/VK8emxPmgEiyO/Sq1DY5DffB3N6goZ3rG7sd5OzhsPLh14Rs
         7nas1rLhfruYA==
Received: by mail-ej1-f70.google.com with SMTP id fy17-20020a1709069f1100b00948fd62a55cso1148932ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 23:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680847348; x=1683439348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zft3hVuwccqOkIe+/jXqzbhmeCB7evQzBPJj2Wk1H3M=;
        b=HRWeYy6gpLV0bJTPYKS7w9D1ULJN9a9MSQbgVxpLm0wDzL+m1tKuzr90hUiLBSGPTt
         3XtUXwSc95ZJC9K8dkdxXd3RfeUhsqFp1i9XaUqnQZnmSemAyzfmUA/oM+gyAGgPtmcG
         sIG4oT+G5h2fZ76zCwxlH0C2jHBoijTh+bTV/u753xRdemXACzUuylQf9bk3ePHPFI4I
         W7GM5EmyKNBhnsOTCQQZbhFj9NiI0MRyQJnM8XgIh0D0mHMGU7P0ShSTzkDBTh82YpfN
         saaboPi2GNibWVBHKFxm5uSQQ2okkKchUvlTPi0CSYbLnmLg7uWjEnVRyCR9kUbJ4yfa
         NUFg==
X-Gm-Message-State: AAQBX9csm/efV+1Y/rCI0bX7M7iFYE2bQo2j2EJBpk7zsdo40TcdB1zX
        rhJUHhRYe5qImntx3R+Usgs6qRObJEuUgJIHfWjWjgZaLeIwM0XtpL1PBc7gDmZMnfWMmvhsytO
        YaLVyPlPPe5IOJxcGhe9CwuSIp8Qr4cddi6NhH+hEIV16LpXOEQaN
X-Received: by 2002:a17:906:5fc4:b0:931:6f5b:d284 with SMTP id k4-20020a1709065fc400b009316f5bd284mr1250719ejv.57.1680847347842;
        Thu, 06 Apr 2023 23:02:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350biOzYn0MLoPwUbPrGmvYajrj8BaF1U15y7bLZbkGzboiLnXtS/QsXw/tQKAqwtS4E9vpJ9KQ==
X-Received: by 2002:a17:906:5fc4:b0:931:6f5b:d284 with SMTP id k4-20020a1709065fc400b009316f5bd284mr1250697ejv.57.1680847347521;
        Thu, 06 Apr 2023 23:02:27 -0700 (PDT)
Received: from localhost (host-79-33-132-140.retail.telecomitalia.it. [79.33.132.140])
        by smtp.gmail.com with ESMTPSA id mb14-20020a170906eb0e00b00947a749fc3esm1677028ejb.33.2023.04.06.23.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 23:02:27 -0700 (PDT)
Date:   Fri, 7 Apr 2023 08:02:26 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, Kees Cook <keescook@chromium.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: allow to use INIT_STACK_ALL_ZERO
Message-ID: <ZC+x8pqUVzWQ35fv@righiandr-XPS-13-7390>
References: <20230210215141.108958-1-andrea.righi@canonical.com>
 <8178319F-4188-4F8E-AD8D-DCC392E26DBF@kernel.org>
 <Y+daEOZgaiF3IMTX@righiandr-XPS-13-7390>
 <4E6FDE1C-47B6-46A6-AF31-28AEB2348344@kernel.org>
 <Y+entVlMoV83vyzz@righiandr-XPS-13-7390>
 <CANiq72nQ4-md=KxtUcz3jHDXhLUdw1JxgbSKp7QsN0QKS3pV1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nQ4-md=KxtUcz3jHDXhLUdw1JxgbSKp7QsN0QKS3pV1A@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 12:52:18AM +0200, Miguel Ojeda wrote:
> On Sat, Feb 11, 2023 at 3:35 PM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > oic, with clang-16 we get a deprecated warning (but it doesn't fail),
> > then starting with clang-17 the -enable.. flag is not available anymore.
> 
> Wait, Kees' link says it is deprecated in Clang 16, and the removal
> will happen in 18.
> 
> > Then I agree that a better check would be version < 16, instead of < 17.
> 
> Applied to `rust-fixes` with that changed. Please take a look if it is
> what you expected (both content and commit message):
> https://github.com/Rust-for-Linux/linux/commit/1921ea54ab0d91d7a660c5bb980fce1efc9223f9

The check (< 16) looks correct and the comment also looks correct to me,
this option will be removed in clang 18, as mentioned here:
https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0-rc2/clang/docs/ReleaseNotes.rst#deprecated-compiler-flags

(Maybe we could add also this link as a reference)

Thanks!
-Andrea
