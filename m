Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1015A71233D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbjEZJSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242981AbjEZJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B194913D;
        Fri, 26 May 2023 02:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4167364224;
        Fri, 26 May 2023 09:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D17C433D2;
        Fri, 26 May 2023 09:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685092707;
        bh=So5XfsxbD7IMm6wrDQNtnCLOFMdEi5ODkd8Op316AJA=;
        h=From:To:Cc:Subject:Date:From;
        b=Rl0K6KwR6v7RH6wdwgHKrD+4ETsnaMLVOJJ6aYfrJ96Zi/JXqC4otKJwzci1mZbUq
         tG/Ml3QfnB7PEGbtxAXCI3VeG5VIA6X+9KNRQ66NmbNEEgG7nkAqhB1muHXfBd6hjC
         5JvQWihi+A1hR93Yz/TvCCiPrnG3E3arl4UipRwRlifNnYHd+kFOgxxFwToEMiGvL2
         XxOUYTjGpk2QNswksCMWFSt6MgsFYyFOcEH8SOtwWqwVJuDBYH51HCuR13/qSUnrbt
         hSYoR5S0EYsdM3yjMlxXOnem8/a8ZOPyYU+A4FiqcnNDYVNCnrcKjN796WtTgK7yaJ
         iYamAcOsdFf+A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q2Tao-0004WY-BR; Fri, 26 May 2023 11:18:39 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] mfd: pm8008: fix module autoloading
Date:   Fri, 26 May 2023 11:16:44 +0200
Message-Id: <20230526091646.17318-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the missing module device table alias needed for module
autoloading to the pm8008 driver and drops a bogus i2c module alias
which has never been used.

Johan


Johan Hovold (2):
  mfd: pm8008: fix module autoloading
  mfd: pm8008: drop bogus i2c module alias

 drivers/mfd/qcom-pm8008.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.39.3

