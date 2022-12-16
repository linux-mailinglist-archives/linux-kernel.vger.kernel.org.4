Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4D864ECBA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiLPOOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiLPOOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:14:21 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579162BB09
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 06:14:20 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id e13so3793713edj.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 06:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=R6Y9wbzKg0NbmB4AjAEL6H14ZChrWFx0hlN2XxHvBc27zrSdd/na0DCerF8SUKFHUc
         MTu3O1RYtnY0WigZq8nNGAHSJHQKiwPTVZ6HF8spZcs7hKDI+VmizIV8iNUjzEmW4rob
         UaHrQPy38gbeExCbEJ2bQUvHVRrWQdXuLA1GJFM3VSWf99D8DL5jJTCPjwtRoznmOuRr
         fIpgkx6JGE9swQh1RofT2ugTXSj6dIUPEayzon6SrrcK+Lprt2a1fF9jF7ldW389gLCx
         nqV/UbQxG/3UguVjjC5i1sjMypSwhtBzPdoN9sGgtD8I5YA/kYRAsc42cQ5OITXoy9Ob
         2nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=nu8rysnGGo7DxCYP7ZclKMNA9wAdmwX2UFszqB3QYkLrhZaBt9BVKos8TUOTvEDqwa
         9Udhmc83BLaG5uZIs0P5LzsTUD0ZNoJzrfNk785Klu3RCw9d7bDI9/uyLhD3n61n0iI9
         NDPQYvLp9k2D447XElzyxDL/NSBxxbndRGVaY15/GLNRuybTGvhzDwkF5I7K5yT9/f8j
         kp2qXyaO5wYbuLv62h0wBMtylYI+/ZjSlRCVSshhDYwBXBMRjYdmK2N5zufjVIZpdRz9
         kNyxQvKT9mdD711YxBMPh9aNN896CG4lNpKAblFXxWb4Fow9xiALJlQBdEdKVFDjIBi0
         kiEg==
X-Gm-Message-State: ANoB5pna6JuzEsu8Qar1B4+tAKD2JihBwbtNvxK2ddqXlm9N+GH91r9u
        ILTRVQ4RMwfRXmMXl98tPYZ49Xa9Rhiq9pMvwvs=
X-Google-Smtp-Source: AA0mqf6BSmGiKn9RwrZRjQ9xphWaxFRMLQtfrCkN0mNXTtvXh436rRG0C/W1XK/70b/joTiwwaz5IdmEm1aGS6uCx9Y=
X-Received: by 2002:a05:6402:230f:b0:46c:dc40:4635 with SMTP id
 l15-20020a056402230f00b0046cdc404635mr16626435eda.358.1671200058847; Fri, 16
 Dec 2022 06:14:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:3fd1:b0:7c0:b6b2:c759 with HTTP; Fri, 16 Dec 2022
 06:14:18 -0800 (PST)
Reply-To: subik7633@gmail.com
From:   Susan Bikram <timh79161@gmail.com>
Date:   Fri, 16 Dec 2022 06:14:18 -0800
Message-ID: <CAAfykGWx3g453Z-2xhG3w3njoXY=kEjEjeuXyKWegpPmjDz0dA@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
