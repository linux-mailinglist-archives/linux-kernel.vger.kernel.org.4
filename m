Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8D7463A7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjGCUFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGCUFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:05:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4DBE47;
        Mon,  3 Jul 2023 13:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B89FE60FB7;
        Mon,  3 Jul 2023 20:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE4DC433C8;
        Mon,  3 Jul 2023 20:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688414709;
        bh=HMYHrnct763XNoqfgMdWwT9leFqY7lF1BFAXSKXrag8=;
        h=From:To:Cc:Subject:Date:From;
        b=t17vuLTQJ80VV5K8qo8Jo7Bayb/Fy9BnDbtQaNaCpLCsdB7v1w0lgd9M8Nx1H7xXy
         UDwiGt1wX95chfNzfC98fzWL/LUq/dI6IjsC0u80BJ5sdtEgckJn2OeeELrtMPSfGE
         KnKdVV9wK5fwl8l1fBLSgTNarI+016iXdCzblhOlVX8qif9kTN3B/+QrlT7Wfexsdo
         SKPSers/Z8npTSJA8KogywU4M2oqhWGVnWX4CEfOLalWo/G20W8VV0H5uXLqG7kw32
         ieMvQseYRuIco92KDbo+S5N5msuoDbGAfzjAueuxRE3uVsN9hvYHoyK9ORCqnEbOnc
         yTH4OWqAbkHcA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [GIT PULL] hwspinlock updates for v6.5
Date:   Mon,  3 Jul 2023 13:08:53 -0700
Message-ID: <20230703200854.3081448-1-andersson@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v6.5

for you to fetch changes up to 1b39e7607144337d752f36c2068ed79447462f99:

  hwspinlock: omap: drop of_match_ptr for ID table (2023-06-14 08:15:24 -0700)

----------------------------------------------------------------
hwspinlock updates for v6.5

This drops the last of_match_ptr() from the hwspinlock drivers, solving
the resulting "defined but not used" warning/error.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      hwspinlock: omap: drop of_match_ptr for ID table

 drivers/hwspinlock/omap_hwspinlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
