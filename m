Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3384464C94F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbiLNMyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLNMyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:54:11 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEB82188
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:54:10 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id qk9so44313087ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yyq11bQQtENu3KqWEWEFdqBQwrStkvzMA+RuKZwUclI=;
        b=VVM5FuOWCrx9fsGyw/uPdSA+WIvdkCh1cDgEDj1c+W3DDj7afKu+uv3ilZj5O/yI6Y
         dqmwM6oCKhV42Pau9WYcLJTS5cisijt/xdOxZVxHwo9TVGG/H0E6YH8bBShVn6Cm8YsB
         U0nARZ+fOBpWaw4xhJwR5rtpONYQcAuz0sEcuJyB/SwbFTiNeCOlsMGguYukT7cx1BiC
         ATRSnl7ScO3UY19zhjKRlXEUQ7ePngh37JgCTu6T34T5jYNKhimg1aF15K1EV8G2+xq0
         sLzD+xTTDP6bWdHN4Ok3VF9634/v29N/zRDsF0an3mb61a7wXMFP4u+Iaz0Jdi+kWSAW
         Ut6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyq11bQQtENu3KqWEWEFdqBQwrStkvzMA+RuKZwUclI=;
        b=eGG1wOy1K0331+ErzLGOAxB9C25919szHktgzmV3kmtMUAgr1HOrbSgN4qqkxC1Si/
         MXyqxKAE3DHZ6O7wXJ7cQL64KmyoU+AVfaLJWdImVMkcKnY0D5kRdD3c/Qn4f2Ft01dV
         It2kv01x40d/cJ5VueS/J3WQ4So49YhnldNHwv5Baga9cGooOP7V6oTZDg+zeiPA2Lw+
         84nZJDOOvDekhsWk8R0VH4B7L1uio0cgYQV3gMYmUqsJj2NJ+LXagiYsNBEp1RrpvN4b
         mKeX3/v/mFE25DVAABdBxZb6ovcl0lj6IhxHcfKo/IY1CF3M//3AL2oG2q832YpSvpe1
         6PdA==
X-Gm-Message-State: ANoB5pnjoMtcFSy2Z4VSNERnqLl8y7Ffh9aKQcgx7MgASzN5uKnZ6KNu
        BTrj3c+B78iBYz6f97lVcqtp40q7gdqSXa644yw=
X-Google-Smtp-Source: AA0mqf7kL0PMD0f7XrjUUFpY+Kfnj2JZhAKZ+1hs03ay7lUY/xlBf4N4Yl/GurGV2xLhejQ5n7lxk5R4bm/Wf3nw1sQ=
X-Received: by 2002:a17:906:6b97:b0:7c0:fe68:35e9 with SMTP id
 l23-20020a1709066b9700b007c0fe6835e9mr13446054ejr.49.1671022449496; Wed, 14
 Dec 2022 04:54:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7208:c599:b0:5d:378d:bea9 with HTTP; Wed, 14 Dec 2022
 04:54:09 -0800 (PST)
From:   Bill chris <bill1396hern@gmail.com>
Date:   Wed, 14 Dec 2022 07:54:09 -0500
Message-ID: <CANBK57FVkg=3nd6JxBPtY91d4Gmi7K75ybrAkWOAwAq_r0BU8Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Congratulations! You just won $353,219 from Power Ball Lottery.
