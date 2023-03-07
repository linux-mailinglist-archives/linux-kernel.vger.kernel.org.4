Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960A46AD6CC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCGFat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjCGFaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:30:46 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C4557093;
        Mon,  6 Mar 2023 21:30:45 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 132so6909329pgh.13;
        Mon, 06 Mar 2023 21:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678167045;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XCBEBrW4KvfUOG26x/G4IxQZmFPxnQCEMhbweDvrUY=;
        b=lVPfTyASkjYG0xnrzjzqppKWof6Fj7btl93WfQOXnLLBEdWjofk1J/zkxO0wKN01Mt
         qzTElNXMsRid7cPPq/vg1kgTNAOKFLQnrbrWnOp4kdsu/UGmkOxOPh1oRCtVc2ehho+t
         i30X9XZ29qj35nP3aKkosVNaig8oWBJHrdi3lNz3wMT4/f1VJ6GSjd7nwvy3+48b4FHQ
         fGw6yQkLyg0j9IRe3IcW3/b+m4/0A1VUZOw4rnfv3a1pUZE0EwYqYRYLqMoIW29op7+0
         R/87PmsUMwNipi4JxdzXMmG4OtS45dbRrBrqlyqYb4UThmJfd1+hf9xpYTB5C5JIQRpA
         jXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678167045;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3XCBEBrW4KvfUOG26x/G4IxQZmFPxnQCEMhbweDvrUY=;
        b=3e0Xz7FatkdnGQqVbTyToWDcVDxwTaHQKlTqLxHAVdD35NOU0kvp0kKhMblYHXctj1
         WK8cWdjqbODiGduvVdjJ4o46w5H3X52G2jkR4d0J+sAHqmlxCnvYu+0LeJhiF5vleGbU
         w/I1gJn69LteUxx43yF4u2LBCYPTzkZc3qSeolUiGuJ8GUkM1R/2++UwFPGHitB1E3jt
         5lF1Q+Hayp7aHjr7PPzdLY78BNJ+M1ooIPrM7qkgjj4f4t/RKOfn4l/Y6P6rDp3y0KhA
         xqCiKzjzq2vjOxQuKbk5OaL7dJHGiChk2LRCpitN6FIbFlPueeAwkwv2JQcXAKmXs0ij
         drMw==
X-Gm-Message-State: AO0yUKWUT03khKi7/qiM7YOgwH8lgyo4dC7MH2fZnJbkPKbvvRWQyw74
        twXDBL8gvbXxoPzyno2Cinc=
X-Google-Smtp-Source: AK7set+TN1hNGmcvzRh0OOKH77hWokb+NdmKcrZ8TCKMjxGyGrByxJaL0z9+yvxtyzYG8jN4g3ZT5w==
X-Received: by 2002:a62:1dd4:0:b0:5d6:138f:5596 with SMTP id d203-20020a621dd4000000b005d6138f5596mr14087706pfd.14.1678167044871;
        Mon, 06 Mar 2023 21:30:44 -0800 (PST)
Received: from localhost ([203.220.77.23])
        by smtp.gmail.com with ESMTPSA id j13-20020aa78dcd000000b005a8bf239f5csm7174096pfr.193.2023.03.06.21.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 21:30:44 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 07 Mar 2023 15:30:39 +1000
Message-Id: <CQZWKF2U2GVM.1X6AAD3SM05D6@bobo>
To:     "Benjamin Gray" <bgray@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>
Cc:     <ajd@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <cmr@bluescreens.de>
Subject: Re: [RFC PATCH 07/13] powerpc/dexcr: Add sysctl entry for SBHE
 system override
From:   "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.13.0
References: <20221128024458.46121-1-bgray@linux.ibm.com>
 <20221128024458.46121-8-bgray@linux.ibm.com>
In-Reply-To: <20221128024458.46121-8-bgray@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 28, 2022 at 12:44 PM AEST, Benjamin Gray wrote:
> The DEXCR Speculative Branch Hint Enable (SBHE) aspect controls whether
> the hints provided by BO field of Branch instructions are obeyed during
> speculative execution.
>
> SBHE behaviour per ISA 3.1B:
>
> 0:	The hints provided by BO field of Branch instructions may be
> 	ignored during speculative execution
>
> 1:	The hints provided by BO field of Branch instructions are obeyed
> 	during speculative execution
>
> Add a sysctl entry to allow changing this aspect globally in the system
> at runtime:
>
> 	/proc/sys/kernel/speculative_branch_hint_enable
>
> Three values are supported:
>
> -1:	Disable DEXCR SBHE sysctl override
>  0:	Override and set DEXCR[SBHE] aspect to 0
>  1:	Override and set DEXCR[SBHE] aspect to 1
>
> Internally, introduces a mechanism to apply arbitrary system wide
> overrides on top of the prctl() config.

Why have an override for this, and not others?

Thanks,
Nick

