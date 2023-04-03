Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADBE6D4B53
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjDCPCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjDCPCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:02:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE638113C4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:02:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id er13so77571164edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680534164;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxDEaCL5e4bzi4gSCZXF+LmIoKQOllXUdmCj1K+tVWc=;
        b=giEQsdRD7fF37rGZgAnDCoTebtirCaBeirfH9U1pJ6CYFVgp9hEed8Pa9e87aDEBDQ
         jvqs3rqMitPz7ksefvLjnnkmT6d3tekUDBtpO5EVJsTNUajulOBrjbdIkUhxlfQWRrgF
         Y6sgR6RI/cw/FlV6JHyb8YA9ihih+VJvY7zdKrbI78hnQophQFboC2r1X1WrgHOU4Cfr
         xbRE0INs3yX4PwiQYN6/aObOVxs6x0zndrncTdLe3UUQcX0nPFyt2qfS11U9OcAMIs5n
         CmKe8bxyUej6cwK9xzP4rQgHHMMxseIKLBAQl4iEHxP9eXbS6J6mBOAbQMmcBnvX8Jwm
         4d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534164;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxDEaCL5e4bzi4gSCZXF+LmIoKQOllXUdmCj1K+tVWc=;
        b=s/3qgMyCQJGw9f8UF8B3cXzDURw3Nl88k4h8Njq7YK78BSeJKBWupTT4Yy0K0QvTOE
         Cb2UYF43oW94n3McOKDwiN4wwKOle9NQd9sBK/rlwI9w09eK/tngpRA9ouhkpkiGejoa
         qEvKABd8JwT3f/KTemVxhrI56kwa/FZ3NeFUcY59kHSxo19dfyeHIISC94ERqkb3exaU
         g2N2C4rp+7cLZLTCeN9wa+CJ0/MZLf7ByQwyhMj6mxgg5PmHX0l8gQtbDOOn2qWcy2zi
         ml0EMJ7lg8tCyUWNquqvk3fl1ElEoZStjD3n/aPXyF6GUNbW7ZALsy+ctvXwlMd14kLH
         8EqQ==
X-Gm-Message-State: AAQBX9ffK43xq4pUgF+otBxtd/dy3rYDi5PsXwX10+N1Tp6895OEGCS7
        VMfKSj0iHm0+UkvOlYPLYCKRmYMXmWiTag/iz5I=
X-Google-Smtp-Source: AKy350ayEaVfYYRTWH9Acd6EL1xT4OWeHtV4qIWHnrLtm5nuIqLZQhhwrdqe3uvs0uyNtdWrMgP2dpi61pFzDkpMTz8=
X-Received: by 2002:a17:907:8a06:b0:92d:878e:8566 with SMTP id
 sc6-20020a1709078a0600b0092d878e8566mr19476890ejc.10.1680534164275; Mon, 03
 Apr 2023 08:02:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:a783:b0:8b1:4cc0:8a35 with HTTP; Mon, 3 Apr 2023
 08:02:43 -0700 (PDT)
Reply-To: godwinrichard700@gmail.com
From:   Richard Godwin <hesterannhester@gmail.com>
Date:   Mon, 3 Apr 2023 08:02:43 -0700
Message-ID: <CAFqyS=SsUftPQa6uhJRojcQ8ZcxgVmXX1eWB_T_=VBbVsmkDLQ@mail.gmail.com>
Subject: URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Good morning,
How are you doing today, hope you are fine please i have something to
tell you. If you don't mind.

Am waiting for your response.

Bast regards.

Richard Godwin. Thanks.
