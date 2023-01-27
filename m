Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ED467E059
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjA0JeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjA0JeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:34:13 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD3E30E80
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:33:44 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id a11so7330459lfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soCJk/9uoz+KgQdqW+wxg6SrKosE5IXTc6rEokgR5tQ=;
        b=nmx1zldl8cWuQyK0N1qgKg6BmyRFI+kb+zi/9Gh+JmAGnpiZx8TKP/iUSuWxDTugNT
         4ApVSh+H2nLh6wYsv/zecBYs7qmCoIjMI2VN0qiy/N321v122T65GUOHEjvzeQL/ZCWb
         iqrYTUEmQOXJi3WzMGtT4d9upHBSn48afH96k4qOdLPpObxbwGEfbrlW0viMZNIiXF+I
         KBvLSDUeQg+9akyNMFkrVPYd9AWKEqhEFqQVqyI80QHA5xUs+QQXTlDg005MtJl8jYe4
         VmUrO3+XR/RyED9zU5X2nWPn7Xtf6xvCwea7+DOAqYPIccf49tuelr7eOBoHJNPc10y6
         oT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soCJk/9uoz+KgQdqW+wxg6SrKosE5IXTc6rEokgR5tQ=;
        b=h7h9M0Ysj9RxlT7PpwjVpLTJNcQKSRpJ2V7NujFB8Uq55a2EOfA4C3rWlX0Hd9NqH5
         Qpw0IYJ7FypUmfljCmubugWCjUtlNripfuLs255G+xrBaWYFGVr2cSZb2TPriNB3uXty
         vGS5CsBCevZUD60KJiZdJ/BnPj/5N9ZuRidsp0f0Hrznlz/R3YBHYLtwaoyJm2X44qx4
         YBbeN3sUih2TIir3EYisdpjYACZp+95MAI41vGeXm80NZ8Yvx/pJI7YVG05H2C3RFG2x
         rcalW9bJWDYXG9nIFRvKCPqkViooRjEeC66ZpNB4AAtUP/JHydG/NQq2XK256mRxNupr
         qmfg==
X-Gm-Message-State: AFqh2koKRKRBx+W1W+g7rd5PIC2DLr2npzWv0wPTyX1zt26blxATv32/
        6fggEWv0sqZhXs9h1H3E/1Vj3iHPYZQRWviIj2cQPn8W
X-Google-Smtp-Source: AMrXdXvYCB/YyX8cXrhjlYamC83gUruSrIydgGTh/NwquX1nwVfbE3S8e8OFgGX/agTLQyFtTUAZYvAjrUF5HZvpJio=
X-Received: by 2002:a05:6512:2241:b0:4d5:8342:9424 with SMTP id
 i1-20020a056512224100b004d583429424mr2316557lfu.330.1674812022561; Fri, 27
 Jan 2023 01:33:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:71da:0:b0:218:462c:35c with HTTP; Fri, 27 Jan 2023
 01:33:41 -0800 (PST)
Reply-To: www.pbox.tg@gmail.com
From:   "PROXY & CONSULTATION" <www.proconsult.togo@gmail.com>
Date:   Fri, 27 Jan 2023 09:33:41 +0000
Message-ID: <CAOOF-dBE-pzvar0JWo0fGjcqc79xtMpYqy_rois9OkRuTbG5iA@mail.gmail.com>
Subject: TOP PRIORITY
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello sir,
How are you doing?
I have been contacting you for quite some time now without any response.
Could you please confirm if this still remains your email address.
There is an important information I want to share with you.
Awaiting your feedback.
Thanks,
AB Lussy
