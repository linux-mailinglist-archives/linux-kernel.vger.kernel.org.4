Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F324D6F1DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346305AbjD1Rwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345949AbjD1Rws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:52:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190491725
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:52:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a6c5acf6ccso1931695ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682704367; x=1685296367;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Sm6/iSCnW/BG0/EaShhAT/vTfvS6f0HmuxjwLPnDMFrftS+cKBG9MgVeJ1PKYiRMGt
         MMu0XSVgJtjo7FR/zGDQmdMWhdsAekgOtC9mnXf4L+oi2B7ih5xw+DEx1Kqnxme7wWy6
         KOzWTMYqGga06TzO/8CH4Q582R8bsv8e/mdO1gHQmaZ7nJjzRQG55AZ9MpkcKvniIKAZ
         TbuaCLohwgg5DyUWH5SU60Bm5cvMHwB9M6vLowy5hnuS33zyQHJhnYk2+jM9rk/ib0zQ
         vYV3rTq7Y0jgGV1XD18Bu6YROjlIbskrKuKn30AWSbUsMMH04HBzHZUrnHeAqFphPYvK
         dmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682704367; x=1685296367;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=UvplQSenpLgs0q4HA2ugv09Qs0/Ut0JpaiL1WnPLGvYZ47cHHQ+lj6yXLfRLJ+NZP7
         hJpl75McoL1tyXMEAlUBg/adHokTzTXPBA3rey1j/g0akn0L/RDGv/iby85J0smz2eyy
         o8b39BzZrhfZ2mmSOjarq5efRzC5DZYT/2iGADhoGd3tWsTiuVjKOdTqm39Ox2PPYCYz
         yBgDGd2JFvQQXNnvYnJRpLMPXFN34w4prlRpb4EyoZtM3/ELMn5FZTdlUkKkBJnhTfyp
         DnpusEfINuBbCrCMfH30hs44DhlBM1Y4OO9qXOvPJMtQLP+vebT4CJl4stwe/bZsYQC5
         FTBw==
X-Gm-Message-State: AC+VfDybcPRegVNHBNyVWs5SUhBe0wswh2nPU7JIR90Yhi+RMfxB0mMY
        qTmXsK4ZkWnt5YKniskH7AM3kARocjg2no0Nr43Q4z+Y
X-Google-Smtp-Source: ACHHUZ4rMkggqNW+9vIcG65vMduqqNYaVL1KHY6im50exu4VT7gsHNg7YB3cklu95nj+WuOukeIBVxQgK+siMZOUijo=
X-Received: by 2002:a17:90a:4dc5:b0:246:b4b4:5540 with SMTP id
 r5-20020a17090a4dc500b00246b4b45540mr6195656pjl.1.1682704367263; Fri, 28 Apr
 2023 10:52:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:cc55:b0:d9:238f:3fb3 with HTTP; Fri, 28 Apr 2023
 10:52:46 -0700 (PDT)
From:   Calors Lowwth1 <calorsloweth1@gmail.com>
Date:   Fri, 28 Apr 2023 10:52:46 -0700
Message-ID: <CACA_ZJZCiPVSADPWrQQnpA7beowpJT2aR32ud_myXztnNortyw@mail.gmail.com>
Subject: Reply me back i have something important to tell you
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


