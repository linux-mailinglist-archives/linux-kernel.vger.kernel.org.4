Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2002160DA68
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 06:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiJZEqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 00:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJZEq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 00:46:27 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADBFA3B49
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 21:46:27 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-3691e040abaso136175487b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 21:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hN2Hz+GXCU2iD3nh6qDRcSf2QxFIARscJFRamikyjx0=;
        b=TM8WAlIshMKmxKS3RyLR0RcY44k5Tk96FalyD+2KdmQFkqJiAEAG1DOYzXWX7LeBdJ
         KIpAgrxWItwyVDbDfm7tqfBCxWCet8O1omEFKuNHReEXiEYBBF41pwPQ/Ahf1JsNSxZG
         HlMt2IVC9a8spDO+ZnBOLxcvnxz5Vc1MuT3qy5C7kdIDZPGLBHkdJi1arWkccwDEQ798
         5Ugg4xYFcE9/agQQhZ7z0+Xajpntzkhpxk6quvTA6WTCorWwmZzs2CmrhRaLIvBjyktX
         apnXBSBuq5tUalnWk4pqjcm07H5jWcRbb16AuRPjAZ3dsR07S0KxEA/1pSeWgDk7RYCh
         3NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hN2Hz+GXCU2iD3nh6qDRcSf2QxFIARscJFRamikyjx0=;
        b=41ip+6iBcDVrTl0wfC8dMF0mbOoIFTZ5cjc5P7wfIEfV3yVlyUBy9R6Gkqr6o5YVl0
         /rQZkumRzKHssWzWnHZu1BbPhliL8o0HgzNFaY5oI8ZQfL/CdY20CZGtT79RAzTzZC1C
         hCq97JlT/l+QN0/cUZpBgfxRnM8clvT2298fQ4dYrMt+Pg2tvx8ozyU4V3V7Pq6tnaci
         YDxFYLcAZZJghMFfewiZIDtQc4ppk8Ax/iEPPeVZrMNi3akTuCXgLDCQn/waRjBQZ+rQ
         o5bm/shaS0uAfdEc5nOMRybH9jJ7CxDA+vvTQ0jyB0nWZkqwDOoimgPQFpFE3RKZjMf4
         jCTg==
X-Gm-Message-State: ACrzQf0SxKO8eOWz4k7XEBkqJnXcRkbpFh5AlL3blLgXJHHomEoPgo2m
        EiV2XxOkwmiU611mJAnHhm96SeaPNv8y5ogNuCs=
X-Google-Smtp-Source: AMsMyM7hsKX56clnXTKtbJwqz9XjQut1BKr0ewUd+04uZhU8NlCEArX+q+FiC5HImH7YsL/VZT7yYCU4OvW+cg1kKio=
X-Received: by 2002:a81:8c9:0:b0:36d:3e4f:330e with SMTP id
 192-20020a8108c9000000b0036d3e4f330emr13172970ywi.49.1666759586355; Tue, 25
 Oct 2022 21:46:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:908d:b0:311:2cca:fee5 with HTTP; Tue, 25 Oct 2022
 21:46:25 -0700 (PDT)
Reply-To: royandersonCCB@outlook.com
From:   ROY ANDERSON <okwutedubai@gmail.com>
Date:   Wed, 26 Oct 2022 00:46:25 -0400
Message-ID: <CACwY7A3J-f9xf6pw9=wjrf6_J1znUksmKBOCz7ah+eavXhYzeg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
My name is Roy Anderson. I came across your contact and noticed we can
be of value to each other. I have a proposal that i want to share with
you.

Your prompt response will be appreciated for more details.
Send reply to email : roy.an.erson@outlook.com
Sincerely,
Roy Anderson
