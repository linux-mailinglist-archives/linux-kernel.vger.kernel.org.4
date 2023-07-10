Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFD474D705
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGJNJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjGJNIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:08:10 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFA7128
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:07:52 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-794779e1044so1322858241.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688994468; x=1691586468;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qByi5P9M7+yOnaVyMG6pvW4P+aOlzbN0OZfndybu/l0=;
        b=RMn0hYn3nJp7OLaCv7EsxRMKJMq0VKEtqfzh9lsB4v9cyu7d4QO9BCqBtuVUqDXMiR
         m5WVrfWXMpivmIO6pBVBMUSwvIb91WRt6Wy6Dmf5od/uNbfPluAYhl/oQbflmGKMpIyI
         LZgKCwZq9qYznRk7x9BCe2ki4L8u2PQqtJYvdnylc4icSoF4GlMEq2h0Nc/vQRkStSSN
         uCGBeaNywHm0K8HS3tWN+B89PxKvejGXlI7Jxn4lBqUR9QQZ/EeJqfGZe7wyAIkvxvh1
         vZtUeeOKeuxuGjyWdoeB2OUVNdO6ye8pH4X3z3MSW+u339tI+8bpY+3V4ibhmktozX/C
         qyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688994468; x=1691586468;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qByi5P9M7+yOnaVyMG6pvW4P+aOlzbN0OZfndybu/l0=;
        b=bF5wjQWx1Q/ig2QIay/oiDTtgGuyD0FsKjIHBqNwc29t0fhwFE7FkFQo89v+Sq7khC
         4grgvaAVHBdFxjus1A08XIAfoD9h4Mswo627WGNLgcxaJTBMfkc6krtEd0pi8oamVIKo
         1nBgj72mexNa43me/goHWQNGtUoXwCXUVi4h1WAQGg8ekMFVApMuJrpyBQRo+RZ162aj
         kTWnoD2ANkRuqIaE3x8YaNoHWRXt7dXmxMOkIsexuPU/okrQZd9v62nb858LQon4VA5E
         4pxsHLiRuJRBqJ2S+7UHkvCHtF7kEZCg7DvNz/MIv0Lb6cB7b8yjcARO8nl15pyYJP9Q
         2i4w==
X-Gm-Message-State: ABy/qLbG1jiN0IOg+vuASx6roxAPCt7JH8ubwyx94VQM5ADNqJr+/MyN
        nbR7+og4H4KHaqU0PZfrRvrCWjlPuy68tv/tro8=
X-Google-Smtp-Source: APBJJlG2geRCmqHmc5V7aMP8u9trTniUoS8keyC7559oLVYTTKDK+dL72O4MGGw3zJucbQsjrAxAiVoU2NlKfkit0aU=
X-Received: by 2002:a67:f996:0:b0:443:4eca:f7f0 with SMTP id
 b22-20020a67f996000000b004434ecaf7f0mr5369644vsq.11.1688994468609; Mon, 10
 Jul 2023 06:07:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:64cb:0:b0:781:caa:4818 with HTTP; Mon, 10 Jul 2023
 06:07:48 -0700 (PDT)
Reply-To: mr.richard101kone@gmail.com
From:   Richard Wilson <williamphilip0056@gmail.com>
Date:   Mon, 10 Jul 2023 06:07:48 -0700
Message-ID: <CADkLOGae59YpMJCjgqrK7uWXx7=ndDK2b5uQN+uHTHYAQ0w3KQ@mail.gmail.com>
Subject: Deposit
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 

Dear
I am contacting you to assist retrieve his huge deposit Mr. Alexander
left in the bank before its get confiscated by the bank. Get back to
me for more detail's
Barr's Richard Wilson
