Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0774E60FCB4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbiJ0QL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiJ0QLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:11:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0023017A034
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:11:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id x21so2000174ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K6TvWMbZub8pntZMuUKc5MwiN8S9uLNQzCsgKNpVi64=;
        b=CntVm28Qiyg7R4bF0AdhOlA0IWC+JlFP7SPcZqKF9VXhggZnN2JPi3NJsStKN/X/CN
         PyHWV3p4KBlN+nlIX/UjqEQ1CB5l9/faR1aHu6/SeTwvaRO9O2g/a7pDZiacGNEbjfYb
         OYcd0vWz378UVmoIvTFFFD2+IF2tUtW3KQBFab71g/bswt5VhMnEozDh5h5y1vsdW8yt
         aI5vgH0YkX/qH9TKbO618kTaslcvYZot3l0/wQlk1a/KNppMeHUJ5fam0JrKiWbmIWds
         Ulw1sXbn0B4XSBekzmJYWsB67teaAO9nQVwuuZhqDcEkrngxMqxOAU3k1upQ5FzRLhph
         8zPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6TvWMbZub8pntZMuUKc5MwiN8S9uLNQzCsgKNpVi64=;
        b=C2vXTVQDZLYfiCcl5o59imWs8uhdicxxmL1sJ696+SkxMkBdoN6GUvEmuaO5hMNjh2
         0XTz5RAJlma5oc/9T+VapVpKwA2RSVjwD47dcRbIpZaHj52CM0GWq5lNf+YQNUTDIDoX
         lRO8To1kQII4GgfU+dATeuFYH2V5W+ak2wosiCrpj6d03gW69REXAJBjnqHbRcXmmZXu
         L9HekZnBRxCM7QWPpLslVcx9ZS2ybp0e4R0E8ki2fkjOi3A5KHPnt7qg1giEkiZjbk6q
         JrUTpPRX+jhoh+KQ39Qv4ukAZgiyEHMyrAxOcXfMdDMcZVUca9ScFjTMQC6B2+76QpLx
         rRNA==
X-Gm-Message-State: ACrzQf2LyxTAC8+qEo1niWubZJ5BN6s6spQ60NT2nsDnKFTnPycPD+2T
        L5OqAKaemFgd2Q0Op7NBGg7nqAhrVD7VPsWQOVsiqgpQmIw=
X-Google-Smtp-Source: AMsMyM7GPa/3hESijUOVV5eScuYi7B5lfgd0dNy0FNvzr713sbcUvZ/1UHUz2uhWehirT6pPRlBfd9lLP4fbpSjOExs=
X-Received: by 2002:a17:906:9b87:b0:733:1795:2855 with SMTP id
 dd7-20020a1709069b8700b0073317952855mr43156970ejc.156.1666887099469; Thu, 27
 Oct 2022 09:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221024224657.2917482-1-dionnaglaze@google.com>
 <20221024224657.2917482-3-dionnaglaze@google.com> <CAMkAt6qFiF2J+eBu0kv77yJyLbiKjs5cjsa4Qg6zVeR1AKuy3A@mail.gmail.com>
In-Reply-To: <CAMkAt6qFiF2J+eBu0kv77yJyLbiKjs5cjsa4Qg6zVeR1AKuy3A@mail.gmail.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 27 Oct 2022 09:11:28 -0700
Message-ID: <CAAH4kHZuvdKYCwkuG7bOwQsAvctgqXhxZLpCWORnngwHavWsDQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] x86/sev: Change snp_guest_issue_request's fw_err
To:     Peter Gonda <pgonda@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> In another thread Borislav suggested we edit snp_issue_guest_request()
> to take a parameter struct pointer instead of a long list of args.
> Should we use the opportunity to do this instead of making this list
> longer?

I'm just renaming and changing the type of an argument. If you'd like
a struct argument cleanup patch first, I can do that.

-- 
-Dionna Glaze, PhD (she/her)
