Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3517F616200
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiKBLsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiKBLsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:48:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510C228723;
        Wed,  2 Nov 2022 04:48:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j12so16330381plj.5;
        Wed, 02 Nov 2022 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrt48o0wxQzQSNwn9v0lTmEHxq/zDXHhMvj06dfThtY=;
        b=TY2LrmuIAoR+xdiGyBablBuIPoXvzxK6cMCmSG4gN3TWjqpd30TwaP+LzPRqMH1drI
         +y/3lRjhS9NFfbNfUjgujDC5BH2NgR733/m96E7Oe4xYVN0ym+ftOuQKxbgaRke+rS6Z
         Wp8r+sgub3NlWrpc/YSJBmmikuvfmKyqmXAfpmmKgFtXYQRJagntlifh68AauVxlB1BF
         /AEeCt4+brNpUwI+Lb8j47PnhjsA/I+rvCuYnbhmFFhk6eEdUUyKjT2Ib6WrNtaapS5U
         rU99ywZWfG7MKxJdg5hWcAKdNZSHE5x7Gph/KiaVXz1I8g5OMdi4zmVPKP1U7qf9/cNs
         ozaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lrt48o0wxQzQSNwn9v0lTmEHxq/zDXHhMvj06dfThtY=;
        b=tKSbla9CumoMIV0Py4EjrTGWj245m8MALqX6d7GtCs9qbSm/451Rw17RnCmGndQ+en
         +JckLjt67wZqggJhnQvaOcCcJ1kCWKhfs0MR8TtC9UqX2Q7DAmEQzKY7jq4McgeC0c+K
         nJis1XT/ZV4X+/ohn9IMUpGPBF8qG962eJpP7ZXuyc6bcEWh9B7f5zDxJy3T2ZVlmdTa
         XBLwhxwCVOoPPj38fcSmquqv1HsIkPhlUhV0ikCug2F2fQZzzY3us3bA8/PhDXCjNPva
         +/+EAyt+k46PzYr+eSZ4m23rfDStuwgWKgu+uDFZFr0LtEiN+LH9nhxi1tVBBUtGAx/l
         tFxw==
X-Gm-Message-State: ACrzQf3VutA3WgvbXj6k/8j5Mpu/dNpR96tNmOitFzJLMGZv0GJahxm2
        12fMlEwC/KRhhLGxqSsFcDQ=
X-Google-Smtp-Source: AMsMyM7CtWB8wxg+vrruuJ9K0sE0Tig7eyYj0WyGmnUalTtz2/1PxHmG4YgJO+NqaE2OkWJQIkgbzw==
X-Received: by 2002:a17:90b:4f45:b0:213:ccc6:87df with SMTP id pj5-20020a17090b4f4500b00213ccc687dfmr19537471pjb.227.1667389686843;
        Wed, 02 Nov 2022 04:48:06 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 13-20020a62190d000000b00562cfc80864sm8295435pfz.36.2022.11.02.04.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 04:48:06 -0700 (PDT)
Message-ID: <4e54c76a-138a-07e0-985a-dd83cb622208@gmail.com>
Date:   Wed, 2 Nov 2022 20:48:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs/driver-api/miscellaneous: Remove kernel-doc of
 serial_core.c
To:     Jiri Slaby <jslaby@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since merge of tty-6.0-rc1, "make htmldocs" with Sphinx >=3.1 emits
a bunch of warnings indicating duplicate kernel-doc comments from
drivers/tty/serial/serial_core.c.

This is due to the kernel-doc directive for serial_core.c in
serial/drivers.rst added in the merge. It conflicts with an existing
kernel-doc directive in miscellaneous.rst.

Remove the latter directive and resolve the duplicates.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Fixes: 607ca0f742b7 ("Merge tag 'tty-6.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty")
Cc: stable@vger.kernel.org # 6.0
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Hi Jiri,

I've seeing the increased warnings of duplicates from "make htmldocs"
since the 6.0 merge window. They look like (partial):

/linux/Documentation/driver-api/serial/driver.rst:111: WARNING: Duplicate C declaration, also defined at driver-api/miscellaneous:111.
Declaration is '.. c:function:: void uart_write_wakeup(struct uart_port *port)'.
/linux/Documentation/driver-api/serial/driver.rst:111: WARNING: Duplicate C declaration, also defined at driver-api/miscellaneous:111.
Declaration is '.. c:None:: struct uart_port *port'.
/linux/Documentation/driver-api/serial/driver.rst:343: WARNING: Duplicate C declaration, also defined at driver-api/miscellaneous:343.
Declaration is '.. c:function:: void uart_update_timeout(struct uart_port *port, unsigned int cflag, unsigned int baud)'.
/linux/Documentation/driver-api/serial/driver.rst:343: WARNING: Duplicate C declaration, also defined at driver-api/miscellaneous:343.
Declaration is '.. c:None:: struct uart_port *port'.
/linux/Documentation/driver-api/serial/driver.rst:343: WARNING: Duplicate C declaration, also defined at driver-api/miscellaneous:343.
Declaration is '.. c:None:: unsigned int cflag'.
/linux/Documentation/driver-api/serial/driver.rst:343: WARNING: Duplicate C declaration, also defined at driver-api/miscellaneous:343.
Declaration is '.. c:None:: unsigned int baud'.
/linux/Documentation/driver-api/serial/driver.rst:376: WARNING: Duplicate C declaration, also defined at driver-api/miscellaneous:376.

These warning messages are not easy to track down, as there is an
unresolved issue in Sphinx's C domain parser who can't handle a
function and a struct of the same name and causes duplicates in a
later stage of Sphinx processing.

But the warnings shown above turned out to be true duplicates.

There is a not-clearly-documented rule in including kernel-doc
comments into .rst files. Any kernel-doc comment can be included
at most once in the whole documentation tree. Otherwise, you can't
be sure of which target a cross-reference points to.

As I don't have full context of these kernel-doc comments, this is
meant as a band-aide patch, especially the reference to
serial/driver.rst added at the bottom.

If I can get acks from you and/or Greg, I'd like Jon to take the
fix, as this issue affects the -doc tree most.

Thanks,
Akira

--
 Documentation/driver-api/miscellaneous.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/miscellaneous.rst b/Documentation/driver-api/miscellaneous.rst
index 304ffb146cf9..4a5104a368ac 100644
--- a/Documentation/driver-api/miscellaneous.rst
+++ b/Documentation/driver-api/miscellaneous.rst
@@ -16,12 +16,11 @@ Parallel Port Devices
 16x50 UART Driver
 =================
 
-.. kernel-doc:: drivers/tty/serial/serial_core.c
-   :export:
-
 .. kernel-doc:: drivers/tty/serial/8250/8250_core.c
    :export:
 
+See serial/driver.rst for related APIs.
+
 Pulse-Width Modulation (PWM)
 ============================
 

base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
-- 
2.25.1

