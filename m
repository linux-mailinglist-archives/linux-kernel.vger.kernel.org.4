Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88B46AC333
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCFO1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCFO1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:27:01 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAC32A169
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:26:23 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-536be69eadfso187169267b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jp-hosting.net; s=google; t=1678112699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vUK9dBxwCtJChugErkaN3rhrvTZzDikjig8o6BmvIW4=;
        b=dCTdhWwE7wZys+dU8bjZbFP+D+JCq2hGURMIO/RrLrTSlTGb3O3etF+80n505aWBhi
         J5OdRs64Iw/ofmOEcNM+eUTAPfEIGZVTRLugR3Wp7bfnNxxOIRGwtOaq2dP+bE10kNmy
         xHjNkWUybkJa5dX/A3cDf1BDzfKCW63W6aabRWK2BP3cJG6U8JTFIYVA8pwuR15/Tpai
         5GPAX2A+Hs8P2MW8aLAMW8MMWDKU2cq1fm1S45lYM8LoyYrGpWzPqOmMtVwy86F/dBiR
         W+dMlMPq8+rusdgzACYFHlJm2D+wT4pibabooW3BvEbV1oqZzgZxzqSBTR9aVgkE3lHx
         eSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678112699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUK9dBxwCtJChugErkaN3rhrvTZzDikjig8o6BmvIW4=;
        b=6Hv+xwlAyEyhhSo71U3ChOUeJK2ESUXmY+FbwWNEqWlxIFQ7gMcLjM34zuXVKYVUMK
         lMisCZcEMZfLl1PhMdkk+KEvQD0zR+mEPp3fB46mkWhe29/sgkZgJsfxLw1BrHEm95Is
         4MlDpliDaEN4mzPy5x2gq1fSpH+3Qzan4hwmbcE7IViu+xwTDa+oLPUHgKAi8tnah1Vt
         h6ftACB7uk8n92h2PkiDwnoVrlsF/qzxUOCXg7YImNyez9Ey6N7BWTOsAHcPMnmyVBOW
         lq3canJrW3DfFEgoCeDgA0pqAaWIfdGiWyTQAXqgEXzO+jFRbc900ZxGB7zIRxGR3jY1
         t/ZQ==
X-Gm-Message-State: AO0yUKUw36NegZ6WAf7C90nl3Oqdydw9d158Qhsf2rYPhstkVEdBbOob
        IU0rbFO+c5uPQ2yoFMsEuNNiX4Zm7O0Dm1LEv2sRWw==
X-Google-Smtp-Source: AK7set9yAZCmOPTvAjLTzJqkmaTjtbo2o10dCAPKPnkwQQk4VehVQblEdYfA4IJj16WnQKMN1EKyXqyqbXitfXolMsY=
X-Received: by 2002:a81:af4e:0:b0:521:db3f:9e27 with SMTP id
 x14-20020a81af4e000000b00521db3f9e27mr6992638ywj.2.1678112698544; Mon, 06 Mar
 2023 06:24:58 -0800 (PST)
MIME-Version: 1.0
References: <CALDQ5Ny1mbcUSk8pDL6HEq0Cgqze1tidyOeAgVxc5tyZNb+P_g@mail.gmail.com>
 <ac6d56df-0c1f-ca7c-5d2b-e6ae770518b5@infradead.org>
In-Reply-To: <ac6d56df-0c1f-ca7c-5d2b-e6ae770518b5@infradead.org>
From:   James Addison <jay@jp-hosting.net>
Date:   Mon, 6 Mar 2023 14:24:45 +0000
Message-ID: <CALDQ5NwGTi3q9B=ezat5H_eLtr1cDuR9j13UtB1-dCK-fxOOPQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] Documentation: update kernel parameter limit notes
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
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

On Sun, 5 Mar 2023 at 23:17, Randy Dunlap <rdunlap@infradead.org> wrote:
> I looked at this again.  It's not a limit on the number of kernel command line
> parameters AFAICT.  It's a limit on the number of parameters that are passed to
> the init process.  Basically any parameter that is not recognized as a kernel
> parameter OR anything that is after "--" on the kernel command line is put into
> an array of limited size for passing to the init process.

Ah: that completely explains it, thank you; my testing was inadequete.

I had been testing this using fairly-arbitrary (and therefore unrecognized)
parameter names, so it is expected and correct that when the number of those
exceeds MAX_INIT_ARGS, the kernel does not boot.

For completeness I'll perform similar testing soon using known-parameter names.
