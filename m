Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9BE71440E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjE2GQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjE2GQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:16:35 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80F5ED
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:16:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bad102ce9eeso4063524276.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685340963; x=1687932963;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=jmjP9j++MRBLdN8rfr+SqJTV9f1XKJdeCPimoc4lPKYVpw76K+XJIQsYAtdrA7gF4n
         1SaJbICc614D+5TJseSaIuOCtYVo8VoIrVnXgsdf4+kCN4/sTzY0lmmzNlwkDN06S3KX
         UAc3Vetup5ocJf3t46getpJbmyFFL31D/cS4Q7ZYc6BWAblARgfaab7mCyzZL5fo6Psr
         P0SX549xKpDAXZo6zA129lHVS/1OcgpXJrCWPDsqGFbibM5j6RdIKWAZBPVJ8JA891Iz
         SVvWjSZybG3RdHRqibagmzqSupd2lFtkMFthM+y/7Am/kX9dcJmVFGYTMSf0ZeFwq4kf
         Jrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685340964; x=1687932964;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=HQXJRoedGOGFhwL85Dblb4ND8tmy5UZ0YSRsUackV8duQtp+mdnYj4Um+2Lse8tKMq
         PcAMOzqydSqu7hnaocLLkOb5ZfjrN+OLizjoVfgaJHI3M3wEyJaL2rKhUs3v8L6xt+hW
         6k7g9KVftCjaBL6fTn79dhW9Bm57SCq7Nwa5BQ6gh5WlaLDevN0PDYOidoprOUy4LFsz
         LSbxmzgWbzs/jA/2++3PRgbudMrdQdheKnPUObcHU6xBSui2GsR/X7kPnXHeJyVlq4wo
         PEqjTGLErcr0l3IWEaew2cV4bnOEpQqAKsirdLjVOd5gSkJIwCcYwXdXnE0VwR8xxzHK
         HGZQ==
X-Gm-Message-State: AC+VfDzbIQhuyLy5LqusghbV5yH5fLywuiA2Gs2DSu7qEhxv7y6tVXJQ
        c+9pPbMAYfld2TAebe64uSkN5tCi0dW3BzssR20=
X-Google-Smtp-Source: ACHHUZ5mER2Rzdz2RWP7zak3yY0eQnK0yqG8LbRLfpq+ciuwMKRNQdgcbF6LmTRnUnZfH1HDD+rlc8rVb6TIe6jouiw=
X-Received: by 2002:a25:4148:0:b0:ba8:1e01:ead5 with SMTP id
 o69-20020a254148000000b00ba81e01ead5mr9430746yba.60.1685340963536; Sun, 28
 May 2023 23:16:03 -0700 (PDT)
MIME-Version: 1.0
Sender: mrderick.smith2@gmail.com
Received: by 2002:a05:7108:5386:b0:30b:2a5b:30b0 with HTTP; Sun, 28 May 2023
 23:16:02 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Sun, 28 May 2023 23:16:02 -0700
X-Google-Sender-Auth: WmBFA3qCmfVyriCgQimHjX2virg
Message-ID: <CAO-9xdkGmDRhnyb2T0xHjfLF0efFvD28KsjZzXviF2ua5Hfw7Q@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
