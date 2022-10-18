Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A58B602376
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJREuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJREt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:49:58 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ABB3AE4F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:49:56 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id s2so18850881edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wU8IHOfM4hswgqZGu+LJM0ZkLCs9dAHmqHUo0AsxfRw=;
        b=DmszYEiC6f2av8yP8PjH+ngiKvKm53m7DzdgJYHm7VbZCMJoRat5wGmW++vQm9Bz7X
         Whf93gtPh3sB9kWjqmiX9EQRqLmiUoQ3UQSUgRydCREniCmjZ1KgoIgrdPcMcW4VpgFA
         Ev3uPK2TxGJjaOZ8Wv3vCXDDjQI9rrUe5Gys31T8I8ZMgKP9HGZV3C2aEO1R/DfoUwWL
         Exe4MIwonEiVv4/dyHgykZID/zQKl3kOGo790t9VcbTFJOFoQuyNgDprdnNPdhhNACs5
         4BLKFRxEsgAuo/0FyTrlqblPKgxuphv7caLOT9JYmhQBwUlsMJsEUgki38wq9hFiKGt9
         HK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wU8IHOfM4hswgqZGu+LJM0ZkLCs9dAHmqHUo0AsxfRw=;
        b=2JPTxPxQQKgmzu9DM3XfUpaHzgsSd1ls6b3R9VC5tEOLzhOrVICGlUr3wsKnFM6qw4
         JzL3gXI/sPfNrjyJrl5e/E/JRjab2KngdgL/2Ps30C+hevXze+oOsA8z5oXzKgAOfScN
         DUJ2s8sdk2nYvARZWORmH20EFAn0dD6+IMGgbHAFg+jQx3uf3SHueKTjBdin+XlEG6UE
         KD0rg3Um9OxYir5Vop8aisjJCufsGxrkju2rnlKcz+s6b7ld60+zrtsAe7vQ0uEBs41Z
         pfzUrs7nSxz+eIfKC/DNVTAz7vP6yscr6TwKJ2i6YptLyeBEW2L16jp2/7vBrXH3oU51
         b7qg==
X-Gm-Message-State: ACrzQf0JSmys5WwzVw2VBXbsgIoyU0coePoBwb5Oj6yUDelq6GrdGmaK
        mUV8osXjFXcF+nedvaD+qx1RjUA1CbF+7oO/gIWIa7cWZz8=
X-Google-Smtp-Source: AMsMyM7XTycQr9pX9Qf4E5am2lGz+pRzQO3q6D4At+U0Y6bIckM9XZcR0xGrhjkN5iIoNvFdrRTKxgQfY4te3qtcd8E=
X-Received: by 2002:a05:6402:1555:b0:458:ed89:24e9 with SMTP id
 p21-20020a056402155500b00458ed8924e9mr944812edx.55.1666068595211; Mon, 17 Oct
 2022 21:49:55 -0700 (PDT)
MIME-Version: 1.0
From:   Amit <amitchoudhary0523@gmail.com>
Date:   Tue, 18 Oct 2022 10:19:46 +0530
Message-ID: <CAFf+5zgw5guo7O1LvwaCaRLLUv6dCw2Hm6C07zTXDGO_UynhHQ@mail.gmail.com>
Subject: gcc compilation flags for C programs to catch almost all errors.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc compilation flags for C programs to catch almost all errors:

-Wall -Werror -Wextra -Wundef -Wunreachable-code -Winit-self
-Wparentheses -Wconversion -Wsign-conversion -Wsign-compare
-Werror-implicit-function-declaration -Wmissing-prototypes
-Wmissing-declarations -Wformat-security
