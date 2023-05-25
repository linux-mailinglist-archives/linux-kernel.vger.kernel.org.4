Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BDE71121A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjEYR1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjEYR1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:27:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADE4189
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:26:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f3b337e842so2692807e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selfcaring-info.20221208.gappssmtp.com; s=20221208; t=1685035618; x=1687627618;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lY8ccbGKRV0yQgSNg9RX5YStz86Ed8+7HWloI1s4q4o=;
        b=g00QYRslxnrVEihHlfRlHpZal9iJEr9jfGGvtXLPO56KnYmCIxCShCLpIqBWIkH3J2
         apfQEnrLyp+cQNFDUh5/SlM/afgTaeFGLtnc6QHxd+wfOSY+JAaZRSI/WOCfGtlr6xqU
         tMV2Cvw3lPeWGWQg4mhnJ/aexn5m705FG5tJnBUy1i+dYkPsIDT8vMNix5grxYhWX5zV
         kS/ax+AtOM6DAcG+h12hPakRMsZ70UosPEynID0U/sVTf3XkDPp/+WaIkWzl9JeKKKuc
         rXIMDgGYzdrdBhmfJiV24AhzEUkaIamWV880kFxyZVMMQf9Mp9HZd02bnDxhWd+aDPcv
         jSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035618; x=1687627618;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lY8ccbGKRV0yQgSNg9RX5YStz86Ed8+7HWloI1s4q4o=;
        b=CQDHPOD4R1Rn+oCj0vTc3ir9Ro4LUZn/aeqEdzjS24utOx09rtfYHxDOeMho3pIR9g
         ola7jLDZDVZbWD6SnwNvsqn7bPZRz2t7ucSBBoF9wvwe3/G/nrjKBP5OrJnBSNyBUkqa
         fVg77JMhM6NL2cq5FV7HnPTIheNonXxxBUk03GSztkdi+sVaj6JIEluu8A/8DLYfxK8c
         9Qu9/IttWvSLK2E+WAnxjXSDrHnveGIjWbyB1xDpk6WVQPEZgXpPd+hI/nchaTBGT5l4
         CnahOAgvpF+xRrbEdR8QRI3z9wwuNghS/xkuoUX89B0oyNT/pt/TOTVGE+ZZ9uqrMQoJ
         rrgw==
X-Gm-Message-State: AC+VfDyWx1B0+ACq5Bup/AfI15FrI9XJliSp3ikPYZvncsgeL7d/KbM2
        SQlZcKKm1eE7xmaBduugL3JQx35CWXU5idc1IbQQU8qN4jOUz3RU
X-Google-Smtp-Source: ACHHUZ7x1r/4td9Ryb86CeupmWhGPOlmdDkDJ0hyY5qhSkaBXAAf5ZCdr4BP/AWp9us1AH67+vyhN4Ot3US6L8O8hKs=
X-Received: by 2002:ac2:4119:0:b0:4f3:7c24:1029 with SMTP id
 b25-20020ac24119000000b004f37c241029mr6245074lfi.60.1685035617723; Thu, 25
 May 2023 10:26:57 -0700 (PDT)
Received: from 785115219520 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 May 2023 17:26:57 +0000
MIME-Version: 1.0
From:   Brad Krause <info@selfcaring.info>
Date:   Thu, 25 May 2023 17:26:57 +0000
Message-ID: <CAGethNxwo740z22BeDk-nSkV2uU85rFfwWctzm3zO8Sxuj0Onw@mail.gmail.com>
Subject: Can I write an article for your website?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Entrepreneurs have a lot on their plate when it comes to running a
business. Therefore, self-care should always be a high priority.

I'd like to address this topic in a free article for you.
Specifically, I'll write about why it's important for entrepreneurs to
make time for self-care.

I'll be sure to include useful tips like getting proper nutrition,
going to the gym/working out at home, trying relaxation techniques,
and time-saving tips (e.g., hiring services for their business) that
can help entrepreneurs focus more on self-care. Your website will also
be featured in the article.

Would you like to review the piece when I'm done? My hope is that
you'll find it a good addition for your website and decide to share it
with your readers.

Looking forward to hearing from you!

Many thanks,
Brad Krause of selfcaring.info
Be the best you that you can be.


P.S. If you=E2=80=99d prefer an article on a different topic, please let me
know. That said, I understand if you=E2=80=99re not interested in guest pos=
ts.
Just let me know and I won=E2=80=99t reach out to you again.
