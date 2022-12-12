Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312B5649996
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiLLHdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiLLHdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:33:51 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965E964D2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:33:50 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so7432681fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=44mY906XqhKcACOV5fTJAik7ypDNSLC211K5iRGjNok=;
        b=55T2KB8HguFI1OW4dL/Hnwz3xrQZwDubEVqoH+spqdy2k11HX2Sm6JoV60BPgRd0Di
         Y4Xp8fKuE7Y5JezfYaRLMZ4SoK+32evGMQYS7yBU5nzZ88r97Q/04KfRpy9U6W33w+1x
         UIgOIo8eBolQb2LE2ohntQYjQL+j3UErOcbtF48GWcfyZ8p7mDkg9ZXsmJ+K9E8DS9up
         D4442wxYL/PgABG7znzUrD5zztFqIEf/A89uftasnRQ3JKGXGBgFwsicimThKcNXIqsy
         o2wi5KrMgQ9I1Dj51QmJF2GBjhG0W+r1/fZaBRvX0+WGg06/gZtyKJCTuCPE+zo7Qqm2
         kaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44mY906XqhKcACOV5fTJAik7ypDNSLC211K5iRGjNok=;
        b=OUJraiuBDQFdA8WjZRYE2jKfPAWTMwZOCrON3i5giCxmT5I7eC+E8tdW1XziEsp20g
         aW7Q3gzHhWHdhAFYXmDJHO6w+xAt+sKCrIaSb2O/1u3EkkDkSZTQh6ElUt3jFcHVzgfK
         I6tScL2n2LWu12ktw9XKm4z6ZjBh6gmmxjQhKZQAptXtm5FQ5QdsH5LeDG2EPY2/Ur/O
         DgZw7bxvKH5e0dMHzTgBNJZNZlKldli/AEbe6FJFfG0FQtGHP7hae+oDBOmSuDluEd4p
         lp1xPB6Vv2RN0k1plX50zdbYYRP7qa1KHm9Fo7pUP8YAKS1BZ0JDFyY96vAxRnuqLHVk
         AFUw==
X-Gm-Message-State: ANoB5pln04eT4rQx3dcZyPTKgq1mw5n+owbKeoD4WPxmeYesZFzWUHGE
        UYhalgHa7Fsr2rE8rOS65vMerSupZx26i3bZ6X8/g0CQ0CoVCswj
X-Google-Smtp-Source: AA0mqf6wVjmmeGmBMR7Ho+cfEfiEATO7ydj8XkX5Z1Ub3+qbefm8qQ2rbpOo8X4cJMiJIIDu6cVY+q1D/eYOb6YMhCs=
X-Received: by 2002:a05:6870:2194:b0:144:9a39:6440 with SMTP id
 l20-20020a056870219400b001449a396440mr9948943oae.32.1670830429712; Sun, 11
 Dec 2022 23:33:49 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?5pmT5qyj6IuP?= <suxiaoxin.chelsea@bytedance.com>
Date:   Mon, 12 Dec 2022 15:33:38 +0800
Message-ID: <CAHMTk5G7L7_xVSTfxH8v1ax6Uc7E7BePfvHPwRbZvCp05bArBg@mail.gmail.com>
Subject: post to the list
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i wonder whether you can receive my message, cuz i got rejected at the
first time.
