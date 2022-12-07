Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0E644FFF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLGAHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiLGAHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:07:00 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847F1002
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:06:59 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3b5d9050e48so170086107b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 16:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HXgLDr1n/+xAVukg6gKX/0TpU9mRimvh3G5TlxnBz6g=;
        b=exXeum7wqVGnbRYbAY94VKseR8t66PoiNTCRjhOGL/vlm2QFvt3vuqCTXZGjwEKndU
         OmlWvpPP7jQLFPDVRSdkBN4AvuazSC2Ms4+zr/ZinuI5FdHTdaprcsJIbtOIehN7ZHEO
         gjRrhK3l9HMImsfvw4e72Et0ELcVyvvq3/bQDlRtCt3LlHJYP38mqb9pUm3dNsR/bx4r
         Jp68TCQNz6gaVaSfi0rl9oOrawK/lPrzGdraukItASK8mYqeSredcJ7NTN30kAdxMmiD
         Vq7RKEbvEneN6XNwKWQm7cuGUlYTzWrfOYcHnLoqgz/0IwEO3JHSaAzWoHuELVrv0/vD
         x3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXgLDr1n/+xAVukg6gKX/0TpU9mRimvh3G5TlxnBz6g=;
        b=gjEBLQurEz819D2kKyN2VwioKP0nG1e5ME03yYIljKdUlwOfjvpsV+wZw/swlfoqKY
         G4hPiYXPlkKCoHPE+a8NOx5+hGSl8EJDLqiyZPBZ4eEIkzZEBD4AGc4T3A4rpxe4FL4H
         b6VZAqcdkO571QNeSRJCSUvgOwTkEDHiHmxW45qKs/mMeBOVtoO4NYsYIWFJ5+VoD6sU
         gZtB9HlQQrg4KVX6zkZ6JyxZvmTryfTEUpN6m4dppmDg072JYvHQKVDPs6neIlsOg3n8
         3nlnkyn+rIvK3sJ0p67QsvvBtCS4DGFGSVOO4wHq+Zw8vMl81LLWiPFeREYBd0owy1oC
         PReQ==
X-Gm-Message-State: ANoB5plTNAkqBVgiovkPJY8hclkKaopoVI42eOLzi/JrthoYBwasfxmQ
        j56naByM5NdrsiDXzG/tzj779ir17ZVQZ12erEOSlw==
X-Google-Smtp-Source: AA0mqf4cnAiozi/iWQDnrGVKXZ+2ZUzCBo8345aoW0itQwcsuYnRsud83YCR6WxeMt6XiOBmd49ALiNgx93e6J+m2M0=
X-Received: by 2002:a0d:d751:0:b0:3e8:76df:4afd with SMTP id
 z78-20020a0dd751000000b003e876df4afdmr14015886ywd.380.1670371618632; Tue, 06
 Dec 2022 16:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
 <20221130155519.20362-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdaQWZE6=BNEh5hSH9=jBK=TcLoD1uUb=JyNYmHFvaSAfg@mail.gmail.com> <Y41MxPthLjitvzEl@sol>
In-Reply-To: <Y41MxPthLjitvzEl@sol>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Dec 2022 01:06:46 +0100
Message-ID: <CACRpkdb67ygsEuZhRZ9TGmmNXhiU2LsuefD0-48xtCLx3fq-KA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] Documentation: gpio: Add a section on what to
 return in ->get() callback
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>
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

On Mon, Dec 5, 2022 at 2:43 AM Kent Gibson <warthog618@gmail.com> wrote:

> My preference would be for the driver API to be extended with a new
> callback for the output buffer, say get_output(), and have the existing
> get() always return the input buffer.

This has a certain elegance to it, as it cuts to the bone of the
problem and partition it in two halves, reflecting the two pieces
of hardware: input and output buffer. Also follows Rusty Russells
API hierarchy.

Yours,
Linus Walleij
