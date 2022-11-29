Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1763C2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiK2OhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbiK2Og4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:36:56 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D1A2F3A1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:36:53 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id v81so6958059vkv.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iVWWojAEnJj6pUA2sQB+wh6d4JleW9LhBEsWmIdw14=;
        b=GFqymSFzeON5+KFVXLAku1fZvfnTBr0DRqmd/VmzHnaznqtC54lZLy0WMBgDrdBbrz
         AjJIWczeL9Px24NL1ueTPWYiqLzEUjUNHIbK2V4YbTd6/5uqtyPaY/MZryogtKOClSJ0
         KoamNisPtHi7XSlWcPzfY+1iApbV5m2m1+8DwxXZ0BRDsP293iChSB29asVxM/fksbvu
         GoZ+dbMJOtJdvceJ7lCRptUZhL+Z2ehdT1WOySBl4j9zzsVLysWHdBfoySmYECaKvzyz
         apbpUf/huMMz3n6k8JbVyc/wv+/CWALAZwfw9Vemp/HiZDeRbGf6qOcrt4iojgo2xvkL
         vIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iVWWojAEnJj6pUA2sQB+wh6d4JleW9LhBEsWmIdw14=;
        b=Xqk44FX9pJ6Ac0Sm2kv7qOfQ//7QHsCZOM30M0jhW88lcwCxwvl3yRenjukxqpX1LV
         BZiVYJDJT3TDQ8g+Z4eyYNsvt8b+6NNnusOqh9vv1n1db76BcK7Ksm0ar+wXGI0wengG
         tVO2mVrn++ZaFV9YDd6N+T54O8DJwoFBR5miFyUS2tFj9XIMHo58RaWl6RryItKSs72G
         sGrbfn5sCoFd7wypPJKWH8g9uPQnJjojPs5mv6DKLFVC4mk0i0oZfLhHUzg24I8MbIgg
         9uALY2hiOcRPw/9DLq6xx4dIUkGpKk+nd96wC5e4fRvFUcdG1nVv5+QdiipzkFEGKvtg
         vBFA==
X-Gm-Message-State: ANoB5plTvpEmWoEo6xSWAyUj3vH4EtHlpmjmqqkmthCUx+r/3vGGwyn3
        +LpMXXCYJ89Kp8fndCDglGt3K4bfe3e3Ph5ZNRs=
X-Google-Smtp-Source: AA0mqf6RQqo8VR7nzx9wA/xZ+9tVfyN0O+Tv7idDqeuh/FZZnnngJGnZC9SZ8awFYiNAHBVD89Ov8HIY4d07cqPXuCo=
X-Received: by 2002:a1f:1d08:0:b0:3bc:c8fa:a0b6 with SMTP id
 d8-20020a1f1d08000000b003bcc8faa0b6mr8703013vkd.10.1669732612842; Tue, 29 Nov
 2022 06:36:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:d7d0:0:b0:32b:a6dc:5605 with HTTP; Tue, 29 Nov 2022
 06:36:52 -0800 (PST)
Reply-To: michellegoodman035@gmail.com
From:   michelle goodman <goodmanmichelle700@gmail.com>
Date:   Tue, 29 Nov 2022 14:36:52 +0000
Message-ID: <CAL=4yxe+D29MgbJ7QhxZy-wuJ9y1PUkog_ZrWETVq1DoOhaq2Q@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo! Lernen wir uns kennen?
Vielen Dank
Michelle
