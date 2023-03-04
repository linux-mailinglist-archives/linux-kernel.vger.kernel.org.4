Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8DC6AAC38
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCDTtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCDTtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:49:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFD012588;
        Sat,  4 Mar 2023 11:49:42 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f13so23281240edz.6;
        Sat, 04 Mar 2023 11:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677959381;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdbceIB//4CprYcbvak19Op82ezBXZxuSVZv0PM672w=;
        b=d346E6D8/LoGxqefmkby/fo6rLlITnLrk8Rf36ObDzrvd9fhdXrjgQzZFRfm+itiRA
         n+iZFtpvmF7DgGTxL9gC+NM9z0OiMHD7vsRZB3kOe0q23hGmd2jB+C9V4fVhwKvWMhhq
         Nr3NUJxnvlf6FyPuS8Xctxj6bQRe5gI1y+qWU0ukuU3idp74LfblqOE13eRW0wc431AY
         3cr6qCpnYICPH6n6wZH63Jl5QhyIXzP7+vv2P97ddiTawlFOkWkCVFEJ9iDobPs20Zo0
         xscxHC0F/ExnePyin9Vo52S5lA6Et53glNZBjxozqd1FtYsBblPwwrKa8MA0iP1Volk5
         ttQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677959381;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QdbceIB//4CprYcbvak19Op82ezBXZxuSVZv0PM672w=;
        b=n0eUxUNLIxgP41TtInO5NUqii68X1r3ISZhC8/lCrjzSy4wEYe9vWMe+HiWGccLVf6
         wfNRnKKTAxoGKIdp1Pqckx4wiIIyY0UYYBUaWO8NZ2JX4W/V+LSXfBJLythtM48QOCBG
         iN+Z8gs2FcU7utdfvhNoSubPDY511n5eMlf6cqfa5p1Qx5kz5uOHIFP1VfuyZudj+56H
         nShvr2/VvwcwlKwF28vRMjOJm727bBFG8N4X6MUHyq5lSrn/PkoXgdQtDFukBL8Lmo80
         6cydtgjLuQWVKQN8I4gtSLd1p6YPEI+3tWdC9tvcpXko7cSbaiI0TUmlGCiXphzoIQYv
         JGzw==
X-Gm-Message-State: AO0yUKXtuX8xPsMsSgUrpDRJbdMX2F5ZV4dWkdUONC6NsctiK+0lL1p+
        oi43xVD2vVw4sDYjxPCA3CictftBFJu4ZCqn0bk=
X-Google-Smtp-Source: AK7set9VmPrmzAScTDdqvonIYoaYZtyNwRWu8eCgfunHfXqbOViROuouebK9bBdofvnoWu6rjwNZKQ==
X-Received: by 2002:a17:906:2782:b0:8b1:7daf:6285 with SMTP id j2-20020a170906278200b008b17daf6285mr4944427ejc.35.1677959381342;
        Sat, 04 Mar 2023 11:49:41 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:5e25:9ef5:7977:d60c])
        by smtp.gmail.com with ESMTPSA id ke18-20020a17090798f200b008c06de45e75sm2358971ejc.107.2023.03.04.11.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 11:49:40 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 04 Mar 2023 20:49:39 +0100
Message-Id: <CQXUYHAJ12RS.3EEFE9KI8L9TJ@vincent-arch>
To:     <patrickblass@mailbox.org>, "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Morgan Bartlett" <mjmouse9999@gmail.com>,
        "Niklas Mohrin" <dev@niklasmohrin.de>
Cc:     "Geoffrey Thomas" <geofft@ldpreload.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Viktor Garske" <viktor@v-gar.de>,
        "Sven Van Asbroeck" <thesven73@gmail.com>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: str: fix requierments->requirements typo for rust
 str
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
References: <20230303-str-rs-typo-v1-1-d022b4a57591@mailbox.org>
In-Reply-To: <20230303-str-rs-typo-v1-1-d022b4a57591@mailbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Patrick Blass <patrickblass@mailbox.org>
>
> Fix a trivial spelling error in the rust str file.
>
> Fixes: 247b365dc8dc ("rust: add `kernel` crate")
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/978
> Signed-off-by: Patrick Blass <patrickblass@mailbox.org>

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
