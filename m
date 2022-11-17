Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1E062DD3B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiKQNwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbiKQNvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:51:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2BB65FE;
        Thu, 17 Nov 2022 05:51:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FD98B8206D;
        Thu, 17 Nov 2022 13:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CA0C433C1;
        Thu, 17 Nov 2022 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668693111;
        bh=6LXtYkaXpc656JJPaAoyFD2EShPivYPbaTNhtrdLYdo=;
        h=From:To:Cc:Subject:Date:From;
        b=gB/LH6txua4K9iRxJW/G4/xGWen7nIZdRYKK+McQem6aE/eBmQ1l1hnbtw3qLYRaI
         Xp2TQt2+HYAYmnZU63u+LTqf9oufu/I2vDMPziP77iPsW0wFLRPuA8ytaYrMf4/0da
         vuPtN4lZQwojQ85GMcwI2+islUkH59wsrS+P7uVClOkrPpcaLysTMlnGn0P4xrThqT
         n9nS8k9JvoQWLUoBIuqx2l45okbNMmhirMg3ridfpb1k+IV62W7Iez7z5xSkWCjRnv
         Ewl7VGsIUHlvSe7kLhi8R4XSg67oaanQqb6wj9fRrasKHZ/N9yBVfilnM1Lqw8QiUh
         3Vt8bOXJjaSLQ==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect fix for 6.1-rc
Date:   Thu, 17 Nov 2022 15:51:46 +0200
Message-Id: <20221117135146.9261-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This pull request contains a tiny fix for the current cycle. The
details are in the signed tag. It has been in linux-next for a week.
Please pull into char-misc-linus when possible.

Thanks,
Georgi


The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.1-rc6

for you to fetch changes up to 1498a5a79980fb86458297df2b4aaa9cc56503b3:

  dt-bindings: interconnect: qcom,msm8998-bwmon: Correct SC7280 CPU compatible (2022-10-19 13:16:28 +0300)

----------------------------------------------------------------
interconnect fix for v6.1-rc

This contains a tiny fix to align the driver compatible string in the
binding documentation with the one used in DTS.

- dt-bindings: interconnect: qcom,msm8998-bwmon: Correct SC7280 CPU compatible

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      dt-bindings: interconnect: qcom,msm8998-bwmon: Correct SC7280 CPU compatible

 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
