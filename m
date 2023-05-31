Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F7371843E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbjEaOIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbjEaOH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:07:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF011BE4
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:03:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-568a85f180dso45716737b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685541756; x=1688133756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkdmJU7MS1CA/Dj/0Gr76+y/wuVU2Ut+UYAk4XMq1Lg=;
        b=Ul62Teod+ZCunAd2EaQQxKG83SZcds9E9ARf6Guo7N40whc2dZSgIbAE/efE5+07k3
         6J8STcdoUa+bUIB5012q2gLmDiwH85tW8sZnC4zKBkPsfswcvG55+lsK8NU7nhTwjESI
         y+XhYHIYN8tNQHohIYV427qwc0uyQXSz+F/vrpiroQ+0WX2t1IYKHoTOGDsmJpMdDtKl
         M2XO1w/dieA+wC7EV+O7Pb1QnNcZPegV/y1rhq/zDznyxUsQPTRXAn2IOrEB9axqM6b3
         osENZfZYT9q6lZTWEFOfHmGlHjB81v0DYFQQr2RzPVDB68XIFPbNjZnKTb9+icmY9Suk
         lvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685541756; x=1688133756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkdmJU7MS1CA/Dj/0Gr76+y/wuVU2Ut+UYAk4XMq1Lg=;
        b=ZvIdEDrMbFNKz/L+FT8wZUS7FV+9Ob0mmn7uT1gyrvBvOaK96vymF81PGzZOeC3b9+
         C+kDn4nnOq61g1C3T9/fIylLnex73aCSZki2B+5SWrSFkeakr7MMNDYYRmv0q3+RCC2y
         VIY2fuarsO2sp0crg68y0PkdveKSml97j42oALIdV3KoMxOW2cJjIeELcsOkmMiJLF3R
         K1R05HpWIiSeN82H1ngRs5OZUtUuj9JfAumHY6GBP1BkKe/BQiTPCzizyFTQQwx+jPId
         JtfhzS2kXNizI5cwNJNdQYfwW1Sfw1vHVUz784N13v2WwBoqZOLLiurTd8lNUnQ7uT5z
         +3YA==
X-Gm-Message-State: AC+VfDz16wvb0HI7WCd58wwjB2YwV3zhd8z2IjwUgNFrlnEJeWuB/cwl
        i+2HnMMi2UoOOvYPpCPDxHgNJ3k+FDcBG5E=
X-Google-Smtp-Source: ACHHUZ50A+8qlR08pz8bSpq1xdjUBTlxwXtgKuxqeCBhz/sJHN7MEZ8M5JmPDryHbJli2rjh2e3mkYiU0zWrKlQ=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:af15:0:b0:568:ee6d:3364 with SMTP id
 n21-20020a81af15000000b00568ee6d3364mr1151085ywh.4.1685541756307; Wed, 31 May
 2023 07:02:36 -0700 (PDT)
Date:   Wed, 31 May 2023 14:02:33 +0000
In-Reply-To: <875y8geiye.fsf@metaspace.dk>
Mime-Version: 1.0
References: <875y8geiye.fsf@metaspace.dk>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531140233.3707302-1-aliceryhl@google.com>
Subject: Re: [PATCH v1 4/7] rust: workqueue: define built-in queues
From:   Alice Ryhl <aliceryhl@google.com>
To:     nmi@metaspace.dk
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        tj@kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hindborg <nmi@metaspace.dk> writes:
> Alice Ryhl <aliceryhl@google.com> writes:
>> +/// Returns the system freezable work queue (`system_freezable_wq`).
>> +///
>> +/// It is equivalent to the one returned by [`system`] except that it's freezable.
> 
> Can we add a short definition of what "freezable" means?

I don't know what it means, but I would be happy to add an explanation
if you have one.

Alice
