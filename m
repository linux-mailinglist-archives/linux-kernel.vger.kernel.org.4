Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E260E61EA89
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 06:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiKGFih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 00:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiKGFic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 00:38:32 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F9E2BF3
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 21:38:30 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id v1so14512989wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 21:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fuJxEvQ8hWJBVA+YQn5WV9w4flp3A4j0tI4rSSd1Ck=;
        b=CPJknGh76GKBqj/JyzrYpfhZTA4iLOZ7pJx8SQi6I9UWC5yUQMpW16eNZKtSj1pHns
         MxabvoZfAispcp4LT9u7H76KkohJEq+W1LOk7tp+rdt2UeJNaaqabgllcnG7+0wV3DKS
         E3CI+4Fo1UvFZt+OetXKS1zqc9h4aEFJfQ2JibgX550/Ah9y/5o7KaTEeZUW6BGYcOmK
         l7UISNPT8V+NkmCarotVjJVsCuoc5ydJ8yZOodm5O6FLxOY+86cPGmRQ9l3HA0PDBUCj
         8C7yOfSdUCec7RqHH9C0uuHHlHW3tqR//xHBnzOyD5zwbn98F4B1IWNcLFIt+Qlybh26
         6apQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fuJxEvQ8hWJBVA+YQn5WV9w4flp3A4j0tI4rSSd1Ck=;
        b=fd7FwmRMYwUC6kWHgqc1pvCeWJoY4+zfJs11t7KcT4PPNt7yN4WRg1s7kb/6tRhOu2
         HFSI3YXGAH7J7CrRIdd3jRmREWOayymdtq4eDbo8bOKtBy7l7GDRHfwRTL4OoZK1LeYp
         j2lCx7Ogs2tZXhB1feeKI2Egi2GgF89HjIXeSa4gzXbSNDm8dvWnl6yoo8Rp3ihY4IvD
         rH5w0Y1HCo5kJRHlRjPxpKV5N/GP7gKBWSrMBy8buTl667pPTq6NaFzewAxulLuJfnDL
         w+pFWAM6uYPX3KUE0tFEZ+oiUkG9CDALLubdSDPFS8Vak4rTwozE250bWoKW5j6yCMps
         HQNw==
X-Gm-Message-State: ACrzQf0+VXgVOB+LYgdq93uaO4HnqO3GN0Eea54dwSk4FZKsUq5ZFsKx
        rtDOm4cUNaA4PbxJt4J1F7QwoK/QuBo5+lD5DIk=
X-Google-Smtp-Source: AMsMyM6+M2K/rpCN/oYhU/3GtXRvPMP688eLkiH5jTpblIC8wN5UdW0f/9qta3jzxbRjKwe06xPLl3fydUe2rzMVCKw=
X-Received: by 2002:a5d:47aa:0:b0:236:7a97:7dde with SMTP id
 10-20020a5d47aa000000b002367a977ddemr30073051wrb.625.1667799509089; Sun, 06
 Nov 2022 21:38:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:15ca:0:0:0:0 with HTTP; Sun, 6 Nov 2022 21:38:28
 -0800 (PST)
Reply-To: seyba_daniel@yahoo.com
From:   Seyba Daniel <latifatonde4@gmail.com>
Date:   Mon, 7 Nov 2022 06:38:28 +0100
Message-ID: <CAFBpD=O_oWBM3Jd24LGPjrfN1QvDPqX2NMXcnXOiPQmgLR5VZw@mail.gmail.com>
Subject: HELLO,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I urgently seek your service to represent me in investing in
your region / country and you will be rewarded for your service without
affecting your present job with very little time invested in it, which you will
be communicated in details upon response.

My dearest regards

Seyba Daniel
