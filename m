Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FEB5F251A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 21:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJBTWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 15:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJBTWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 15:22:30 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F88929813;
        Sun,  2 Oct 2022 12:22:29 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q83so6782834iod.7;
        Sun, 02 Oct 2022 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lHVZ8hajxDUrSE+HbGsQ29juLRzmP+3OYmThWC7Wxv8=;
        b=KQ4vBaSlYIP4u1I/BPdJgxVVFPDaagY/zt1RxWx9HY+nT96NppjnXfubKBNOpe6LPq
         BP7RuWgMB1BCdYjrb2NfTJfBCCv9ue7xXblHxtvMR5jETp5PgzTRU0XzgL4lvXFeTbVl
         7RmZhD3gCUzzuyGTVPrd+uDXsp/ubrZVv4j6H9ATwf86Hy8Q6WsLZgrTSh/Yf3z/yWPe
         7Je3R45+zUMfK5XOYuDs7tEeIHBiTbsNH9+sLF/EHB5loe9Ms+YaUT4TfnWuzOPzth+7
         jpo8GPdJv4I1bb5LVUQTlCujErWqJ4rR5zfbIQbcuwULQi0J0yiXXznxuzI8aOerHfvz
         R7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lHVZ8hajxDUrSE+HbGsQ29juLRzmP+3OYmThWC7Wxv8=;
        b=loxuUGVDuQGu11lnYbJvWdyg3cdS3K7e9Ir12nH/VUQsQcvstAJyFH+6kmPczZTzjS
         WPYBJv8cux3yWlkxrpndmYv/BRx7XvSaMH9ymHeuOufDUxHhbVdKvsJrwUd7Jwo/BQmj
         la/mfzvcKyQGZk9EaaQHAsJeGtHokIRCvzTLE5tX4SdNmPQ3qZLD7Nitb4l/xTBvquCf
         mscCECM/HfBmoEDDVSdir3TvET7+x8g6pLfoA1s2hogmJTX24jdj7ho7DtlMN/KtjGlY
         ddrifFRdxHF7IUEMZkIws+sDbqvhHqQmZJ8WJlqZA2eTpPsdC6owVDmNy12wFOmgaQKX
         YtFg==
X-Gm-Message-State: ACrzQf1gJabFIG673sqKYxVwJ/y4aGn60tKFoR39a13N7e4c22r7edi2
        ZyUE0O5KtRVBcpihZEnm1K1pDE5AMIeLfzejBlw=
X-Google-Smtp-Source: AMsMyM7nDCFxZShox/Abpgr4yMv7bbmXQ24CAd47DFbld3g8JcZrMuD7UAMmEunW/Izg3puGwlGPjCYfYgZqRA1EzB0=
X-Received: by 2002:a05:6602:2a45:b0:6a4:43dc:40ef with SMTP id
 k5-20020a0566022a4500b006a443dc40efmr7435527iov.64.1664738548708; Sun, 02 Oct
 2022 12:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221001202836.3110985-1-masahiroy@kernel.org>
In-Reply-To: <20221001202836.3110985-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 2 Oct 2022 21:22:17 +0200
Message-ID: <CANiq72=GidTB23dH1kXu1jTMSH-7Qe-2NLaD5ChrzLEU3X=O7w@mail.gmail.com>
Subject: Re: [PATCH] docs: bump minimal GNU Make version to 3.82
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 1, 2022 at 10:30 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The error message looks weird, but the reason is that the 'private'
> keyword is only supported since GNU Make 3.82.

Sorry about that. Indeed, it was added in 3.82 [1,2]. Given GCC 5.1
(the current minimum) was released 5 years later, I guess it is OK to
increase it.

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

[1] https://git.savannah.gnu.org/cgit/make.git/commit/?id=5b4d419476e9fbda8ea26017f6ec15956d103ed9
[2] https://git.savannah.gnu.org/cgit/make.git/tree/ChangeLog?h=3.82#n814

Cheers,
Miguel
