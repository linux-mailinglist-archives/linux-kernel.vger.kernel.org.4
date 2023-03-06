Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F646ACE30
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCFTfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCFTfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:35:45 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25B96A1CD;
        Mon,  6 Mar 2023 11:35:44 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ec29so12462357edb.6;
        Mon, 06 Mar 2023 11:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678131343;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2FmQ1RxA+JCTff+KO7AZZBMrry2RXo2PGbyJ+O+NTU=;
        b=IgkVBROv3k/h35WvaHptNCygGYO2EPnMtdR7pvqwoaJPJkuq35AReJMKjzOkyqo97k
         d10hVnjL1TvevWflF2/XuEulOj95BSf5LalJSesE815fg8ZyfVk3aSx82rMkQ0rZd5te
         r/rLj3dbOMZYOOMt2p23OUmY0uXawWA9eSMNNyR7GSfqOkOmwkKQI/CWhfdOBiMvCyI8
         GdNclN5XHOebDQmAE3zJKeYV0RKZ+SJ5q7wrols86UlW66zwJPSE9qfoYzDu/qi3quKd
         syFPy/kq2EjKRf6YXhxcN32eTugjJbC9lcj2BGpB0y+K0CIjBjwzIWfyOKqwDrRUJQk5
         nlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678131343;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t2FmQ1RxA+JCTff+KO7AZZBMrry2RXo2PGbyJ+O+NTU=;
        b=ndjBrlVPr1Q8990Vnzuj0Xvf4FMAXFW0idjqZpBbsTuyyvFgqXmN0o9k6tZTvFdytm
         +lpyyor9lcQBVwj/w7EQNOh7rBbus3CilPe81TfZ1rn8UNyZmiNI3ltg/evx6qETZw63
         tk0TpHbelm8Ay+jkhUAFL8Aa/2OsR2Iqqij/F7FnwnEFOAh9BxmBAe62C/Tagan/tgzR
         oKYNahzgLXHDG9KANE11ONGMWu8NQUjD9joH8sToAVt+lgof6BVLkFKEg9NySbqu5941
         tQ8cmyrIEIEo/b3yMC6Yuul6PyGXQN4H1YNq6uE72tVAkeax0e+FNhYedOv+SvFeiTvv
         tpFA==
X-Gm-Message-State: AO0yUKVJnfL7AaFOnolz1uNMgj+81Yu4FyyVVOtqQsOBgFAxjeKNH/KT
        ZfudN0p6jePrMAEV6F43c8o=
X-Google-Smtp-Source: AK7set9FnRqj4wdi7KpzxrX8+EYM492qvgHgKOc71WHv9TSs29+Ns28onXcJgUAKen//D1i8sXWMfg==
X-Received: by 2002:a17:907:6da3:b0:878:50f7:a35a with SMTP id sb35-20020a1709076da300b0087850f7a35amr14881581ejc.72.1678131343499;
        Mon, 06 Mar 2023 11:35:43 -0800 (PST)
Received: from localhost (93-55-83-125.ip262.fastwebnet.it. [93.55.83.125])
        by smtp.gmail.com with ESMTPSA id fw20-20020a170907501400b00914fec9f40esm558931ejc.71.2023.03.06.11.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 11:35:43 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 06 Mar 2023 20:35:41 +0100
Message-Id: <CQZJWVOTWFL4.1PZ3DHSRFK0FJ@vincent-arch>
To:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>
Cc:     <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 1/2] docs: programming-language: remove mention of the
 Intel compiler
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
References: <20230306191712.230658-1-ojeda@kernel.org>
In-Reply-To: <20230306191712.230658-1-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The Intel compiler support has been removed in commit 95207db8166a
> ("Remove Intel compiler support").
>
> Thus remove its mention in the Documentation too.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
