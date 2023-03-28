Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFEB6CC212
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjC1Ob6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjC1Ob4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:31:56 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0215A198
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:31:54 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AD9C91BF20A;
        Tue, 28 Mar 2023 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680013913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cS6PPoncge7WxV8QMPkorPfEpwyvKDYsj5quzqSchVg=;
        b=gFe5uypXFKGvQoREQ8B7JuD5S7+QZofkTTf75Ht985XN7h+ahqDyeo/BNrgqhpaTuFBh+0
        WhfE+GxAKHMxYktc62eJgZjVuX9NiOLaGWE1zVehPFsxtAlgNRoIbVvbz6RlQHStaxzLW9
        vdjv/k6Q24sLi/ButfuVS/JabW3eNLmOIaen0C64ojmurTW4N6WaKgeD9lDu5/2ioRIgIH
        vjFZl2hLtN9G79o/+UY9T32s/XoZoTa3tBcwjiHdxI4AJKISNGSAYN2hHiQiCwGoidGass
        kcW3Fllye4LbwltYisibfBIqfpt4mIAAq0TqlVQB7fsJnw6CBQ1iOY770zQO5Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tom Rix <trix@redhat.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] mtd: lpddr_cmds: remove unused words variable
Date:   Tue, 28 Mar 2023 16:31:48 +0200
Message-Id: <20230328143148.441555-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328000620.1778033-1-trix@redhat.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e6026eb080fa1c1ef6eec24567b733809a5e3018'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-28 at 00:06:20 UTC, Tom Rix wrote:
> clang with W=1 reports
> drivers/mtd/lpddr/lpddr_cmds.c:409:31: error: variable
>   'words' set but not used [-Werror,-Wunused-but-set-variable]
>         int ret, wbufsize, word_gap, words;
>                                      ^
> This variable is not used so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
