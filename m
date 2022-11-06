Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAC961E773
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 00:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiKFXFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 18:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiKFXFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 18:05:42 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05869C76D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 15:05:42 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id z30so6288871qkz.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 15:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jVnLsWWWxt8pZRLm37lvWNvM3dSu+XL/qyjNa8oWWxs=;
        b=KgZK/6z52QMlfNyuOlM+fSZMlG7h84ABlpCu9fNMyPQmdQejjB5lEnPdUoT/jfBXds
         tbThvKt6FKDjhIZo5pThoaCaXqwtRG2oWWijDd3WtrH6MOxQBKBtBrLygAjOGghkYffU
         +/ej+lyMBnHs0gqXozeDdvVyaY/+c7Pv3Toto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVnLsWWWxt8pZRLm37lvWNvM3dSu+XL/qyjNa8oWWxs=;
        b=FVVDqEdcIoDtYZdqcRTtt7d6hoPBLF0tqpP5kspLspv89+c1Wct3p7cuNrwfgscFS5
         n4KdNFRHiSBwUb5K0Bs5rprfC8iYgkJ6msZzMpiqUXZgP/ugd5zA2QQ4iWIjrInjEzIv
         DNpeBX9lzh9/4a/sks0wT9TTr8UuCGWc22mJhuhU7n8sO+c7tkITmZ94qSnNOyf9fINz
         4Iy1SjJeNym15MPEFRdIEpHQfmgrJYps6lhWjx7josFvTXXA8jmH6CPdRcrg3stOS1gh
         80QuuKurhid6i2i8glpoFsvyeCSbPFJtWoTXCy+C9Ue6kuBwQNS5nQxePG0zSGKnVXnd
         N4xg==
X-Gm-Message-State: ACrzQf12wrj8KyhhpEP2rHaI9tNbNEp3zYm6ha79c6adTdLndM5kleYt
        G6LtuqqvE4NXRA5MzDN7W5sT5abK4VvoVw==
X-Google-Smtp-Source: AMsMyM44cdDchlisuy5Jsx3XtxmBJ4xK1U86h9bXl4jSWopNZK7+Gb4oxWpa8BTMZr+XQOcwTj4zuA==
X-Received: by 2002:a05:620a:462b:b0:6fa:55e4:c499 with SMTP id br43-20020a05620a462b00b006fa55e4c499mr20575816qkb.736.1667775940912;
        Sun, 06 Nov 2022 15:05:40 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id q19-20020a05620a0d9300b006aedb35d8a1sm5331049qkl.74.2022.11.06.15.05.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 15:05:39 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-368edbc2c18so89482987b3.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 15:05:38 -0800 (PST)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr46162795ywr.58.1667775938495; Sun, 06
 Nov 2022 15:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20221106054535.709068702@goodmis.org> <20221106054649.099333291@goodmis.org>
 <CAHk-=wiD3VWYqgO7JLqRCJvYHiO5RicGAERH1dWQ2pDqnXDy6g@mail.gmail.com>
 <20221106160956.2414d73f@rorschach.local.home> <CAHk-=wjYY9k7TzyJvWOPSPLL+jHkdogyWuOUyStfE5h1=0Qk0w@mail.gmail.com>
 <20221106165220.4d7e5dac@rorschach.local.home> <CAHk-=whO5PXEzWwf=4=fvdqim6cGTczVoN4KJ5H+dabHo-OTHw@mail.gmail.com>
 <20221106175257.3f1b9a55@rorschach.local.home>
In-Reply-To: <20221106175257.3f1b9a55@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Nov 2022 15:05:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whSYax5cXe_mY0+xMo=BPXa-CRVDC7_ukYJyqSAKYQjag@mail.gmail.com>
Message-ID: <CAHk-=whSYax5cXe_mY0+xMo=BPXa-CRVDC7_ukYJyqSAKYQjag@mail.gmail.com>
Subject: Re: [PATCH v5a 5/5] treewide: Convert del_timer*() to timer_shutdown*()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 6, 2022 at 2:53 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I can post a v7a with the updated change log and also Guenter's
> tested-by tag. But the patches will remain the same. Are you going to
> just take that then?

Sure. Not today, I need to go do the rc4, but if you do a pull request
with that series, I'll pull it.

Thanks,
         Linus
