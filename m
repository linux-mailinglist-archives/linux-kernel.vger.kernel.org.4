Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D145FFCA0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 01:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJOXeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 19:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJOXeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 19:34:14 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9321DA62
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 16:34:10 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so3883620otu.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+jzEUqbWtBeB9kCbXWG0XvcCyj0LENJYNoMRZHZ2sQ=;
        b=HeSYkYVFz5toVpabXxQDB+DAKyZfVC2VSAvN/xbuohc/iQJepvNJcH6kAYXhHIErI6
         4RuCrCLOmaxQRMQiCXu6IUlIvnflyIzsZFXwnmjzTpUtRKc+JJcsEv98moo2Yy0ZiHBI
         OpamfUTOHwdfqhhk5Hz/Xhnjzfyhh3omDkWRscKjOfymKT5l8KMN+GnVpXjL7Y9+qmu2
         xa8ZiawTMWffwQdUsz3niyISnEIE/lEElLV1NdS/0maRlIGeSYJQfKe+2f7VGnIaoHq7
         NKRYg3De8/xilI3SpC5s4Mc64qPXICsAvMFvZ8maFh2hWkqSZEpqvZpCyrceVWi10Da8
         9QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+jzEUqbWtBeB9kCbXWG0XvcCyj0LENJYNoMRZHZ2sQ=;
        b=twLIemNCkteUl7GdB9nQL59Fnx+O3gelz73fNTc/iS1SC+/saWKljNjgINGyW1pQaT
         /bjRefOuhiFck4iIRHbwFiqtygvy68CNIoOETNMIU8cszf62PZsZYUCZBscNbueyeZYm
         rhmY+wAaTIVfs0bbU78o+jJY8AHDc7HNJ3Z3o2J4pEZuTos6+Fz4tHxXtOnISjEvKDak
         CGBv/g9FYwys8+0YGcxWxUP7F+3rd2j59HyFgFNhdKsldhF1O9iTHA31jgez7J7Oe5TQ
         PomoNEr7gWJoy5ScclSatKgIufo0vGCegapS58SxIvJDdQ/caogkyiLqw61grsPB4G1p
         io7A==
X-Gm-Message-State: ACrzQf2HYQfTaXDs1ogO+qpTww8DrafNOiOQO+iZ8PDfoklcRVVbFCn3
        sRKg5U9Reb28V0lIryMMLkqb91kB+1OHIA==
X-Google-Smtp-Source: AMsMyM7GjyMRI5yohg0orqz5B3sv9bc0OjNgA2CyKOAqR7JhaUTQ+/f+xio/mOyi7OAXaT7UZMbo+Q==
X-Received: by 2002:a9d:4915:0:b0:661:cf09:1752 with SMTP id e21-20020a9d4915000000b00661cf091752mr2048084otf.346.1665876850286;
        Sat, 15 Oct 2022 16:34:10 -0700 (PDT)
Received: from bebop.lan (2603-8080-2704-6601-b457-170a-9e05-cc6d.res6.spectrum.com. [2603:8080:2704:6601:b457:170a:9e05:cc6d])
        by smtp.gmail.com with ESMTPSA id w3-20020a4adec3000000b004808e0d8467sm2653858oou.2.2022.10.15.16.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 16:34:09 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] sound: dice: Firestudio Mobile
Date:   Sat, 15 Oct 2022 18:33:28 -0500
Message-Id: <20221015233330.8679-1-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short series adds a configuration block for the Firestudio Mobile I
just acquired.  Very similar to the Firestudio, but a lower port count.

My understanding is that the Low, Medium, and High speeds refer to
48kHz, 96kHz, and 192kHz sample rates, of which only the first two are
supported by this hardware line.  Please correct me if this is not
correct.

Thanks!


