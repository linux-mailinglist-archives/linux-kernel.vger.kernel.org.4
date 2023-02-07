Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D82468D053
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjBGHOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjBGHOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:14:33 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D29328D2B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:14:30 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hr39so11179934ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 23:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8et7fqhXMZCX8yNZEl4XlBS2pBmshqKJu+GGm8vBsZg=;
        b=ARBY6eWrN4qlGRVPG5DZPKNtm1SuDQj4wvbFH7xYIkoNYWRTHHwNZ2SyUXvuew+4Bs
         dje1FdfVGW5l0BUTKihx4W20GmIWVxDZspr+DtFmjkR57t/xxrr2gUjHc36Lo48WG2ee
         5vuenodmgE2gemJe78UTVZWU3Q+1Iqgi/tlFIvx2Bxt2JQY7OGIeg85QdLATci00QBZf
         cZK+F0ZC/g+eXH7+JZcR1/ZHcgWsykYOfOTZhG78SsD+RYZlbA4f8EgO6zW0yq+lqwko
         s3mGfeDAX22PU5eOCO5neW66A5wPEwsXTr2pgStYzpRiSUH+WfL2Om95EDgh3rUl5QYj
         MwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8et7fqhXMZCX8yNZEl4XlBS2pBmshqKJu+GGm8vBsZg=;
        b=XmicAFxiy+dmLEbJ2XJYUsNbOYiXUdZp/PL8Wvum4r8dTJBejwog26u3MDeJikrT/j
         iZNEMrL5/kRQwa0nWgfgvOrS9wQU7YFGdJqukhEO2Rmg63H9snwvedjaCPY8FbQBeSbA
         phkKnuMOWr3siWZo9kyowOR2q3X31m9okRkmX6eRALd+s08/Cb9bB9CkPa4Kuf0ows4k
         QM6QWSrTNwN8rzc3Nr8puACHiW3xbvna0kzAxq7FzMTmkPiRo4JpcsjMA57HS5A+7GI6
         6aPj5ox7W/I70E1jtppN0nHFE4yk4TjwpBf/NqL8lJMGgvUMQ+OkgAojOYxOcT3jodQS
         v63A==
X-Gm-Message-State: AO0yUKWOKAV5yXkSQn2VCZHjlMfHsQpsGx6g/hVaCdtKCHh5VE1kumbk
        GpmG2afCpZL2xAmIM2W+bCmNlsXYYYM=
X-Google-Smtp-Source: AK7set+KW6YImdMyiDc5jVPDsax4qe+JlnpIf6tRd7CTOJuc8gxu5yezriHBE0i0sApkEQo5PSzgqg==
X-Received: by 2002:a17:906:4748:b0:84d:47e3:fe49 with SMTP id j8-20020a170906474800b0084d47e3fe49mr2583042ejs.39.1675754068889;
        Mon, 06 Feb 2023 23:14:28 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id rh25-20020a17090720f900b00887830e535csm6435740ejb.159.2023.02.06.23.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 23:14:28 -0800 (PST)
Date:   Tue, 7 Feb 2023 08:14:26 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] staging: vt6655: Macro with braces issue changed to
 inline function
Message-ID: <cover.1675753094.git.gurumeharrachaputi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
as '(iobase)' to avoid precedence issues" changed to inline function. In
relation to this, names of the callers of macro are also modified to call
this function.


Changes in v4:
	- Modified commit message to be clear

Changes in v3:
	1. Whitespace error from checkpatch fixed
	2. Should be applied together with changes in v2 for testing

Changes in v2:
	- Macros with one statement that is to call 'iowrite8' function changed
	to inline function as reviewed by gregkh@linuxfoundation.org.
	In relation to this, names of the callers of macro are also modified
	to call this function.


Guru Mehar Rachaputi (4):
  staging: vt6655: Add braces to macro parameter 'iobase'
  staging: vt6655: Macro with braces issue change to inline function
  staging: vt6655: Macro with braces issue change to inline function
  staging: vt6655: Macro with braces issue changed to inline function

 drivers/staging/vt6655/card.c        |  4 ++--
 drivers/staging/vt6655/channel.c     |  4 ++--
 drivers/staging/vt6655/device_main.c | 12 ++++++------
 drivers/staging/vt6655/mac.c         |  8 ++++----
 drivers/staging/vt6655/mac.h         | 12 +++++++++---
 5 files changed, 23 insertions(+), 17 deletions(-)

-- 
2.34.1


-- 
Thanks & Regards,
Guru
