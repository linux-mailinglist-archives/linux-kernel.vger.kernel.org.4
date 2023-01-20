Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E752674DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjATHFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjATHFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:05:41 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E146C10B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:05:39 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id e16so4599565ljn.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QK5TyWq3jmV/FF1eAdnxbrVmjZxFxpiPdR2J1+jaR64=;
        b=ZJ2SA0WbSMLKMXyvCWgbZHmAIChSN5P+/bLEj3ZcH9LIt0TCFk3LsHUc63u2QtwEXW
         85cZwc6bDN8jwQlWXUY84jez74suFTe4jQPDXXCm3jIlQQRdD5k9KY9pCwWkWw9WzNo/
         LGkgvqqw9upCX2qj3yQJ2bAVLaY/pwaalwHTEuzTzQMuvVbzNBc31CuVn3grEtWTaZfQ
         VGFfzFHK1mb5oYpWgruINlUc1tygAlKF+tLWeRflF+4X0LdHyeETjmvhjUy7Q3LLHWGH
         u4qgItBkCc3F4CP1XPUsAbDcZlsH+EHtHdqpUy9WsN8ZROV5DPo/O7jjEPA+JPMZJKzV
         IsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QK5TyWq3jmV/FF1eAdnxbrVmjZxFxpiPdR2J1+jaR64=;
        b=Zg1z+7tW200U7bIPWFmte48LaBnie1rDHC/stSvbz7OD6Nz5393r1GYGpy2Ld+5BU4
         BBW6TW/9jjwgIwV5+h4KPYOdIemrRaIbkg7RAEaFyukZfve2t6FoBxDhTIwtQlXGg6Sd
         uLxtCzG90IlyEM9Fs9pn8w8y2AT5nHQs0H0b3l8mzfaPhb4s3aT45sZV/ODSvw1/svDD
         ThI1XwrgAntupjlI83CQqf7YLIAeVOiVV7YSEr9rNDn1H18fKqj8D0YOi3XwfyVvoVw8
         /uVe/g5eryDU2sB4DEH5ho5lrxpKjwhEdviI8i0crSIBpAXYxKLscxj+mtrGFv/PmhP8
         EtOA==
X-Gm-Message-State: AFqh2ko8MawpV0pruebjEyL+2mJHUpRoLkfqkxGMAxmtGPnvYk5/meu2
        DD5GIw76A+M9/wE6bNbai1fX6WA5DfvbufHnmUBiM2O+aQoZbn8Zcto=
X-Google-Smtp-Source: AMrXdXvV7bJEkjkGEnC3MXmZ4xYZ94cFJFd7a4KZIqnQetB8szgH8nudb48DzSQyo04P6VO0IctrXDRG+MlPc/eGdg8=
X-Received: by 2002:a17:906:b054:b0:870:709e:1692 with SMTP id
 bj20-20020a170906b05400b00870709e1692mr952612ejb.3.1674198327874; Thu, 19 Jan
 2023 23:05:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a54:288b:0:b0:1f4:d13d:321f with HTTP; Thu, 19 Jan 2023
 23:05:26 -0800 (PST)
Reply-To: infowusagikbertk@gmail.com
From:   Gilbert Wusa <gil76872008wu@gmail.com>
Date:   Fri, 20 Jan 2023 07:05:26 +0000
Message-ID: <CAExCNCfGp0oS9tU9YpAQDLNB_7TywQnjS+QDAFAZbNNwf_mZ2w@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22e listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7003]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gil76872008wu[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings,
My name is Mr. Gilbert Wusa, please something came up and I wish we
can discuss that, I work with a prime bank in Turkey.

Thanks, and God blessings
Mr. Gilbert
