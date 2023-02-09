Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E18690997
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBINNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBINNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:13:49 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A9E35252
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:13:48 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso3860995wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6UehWyei7/9LT/zdDWEG+kb3SxxswNdb+BNIsHrBAY=;
        b=VW9IWKgXOJnS+fkXvo9z0KGmuha7WJOSwQ5kZZ0QI0BqPLeuiICgn7wjLuG4whN+sW
         /lSY8t8zDdRmNwLkNr254fhbukvO/uaQ70AqO7E8wqmhcRhPm977LNzV304MMRZmIGA5
         y4L32I5hmUkeXYBssuS/DnansqmqeIecDggBbXlsarYB/EC0FVCZp/SZhVRr5MwfGXu/
         NTQqtG/5sIoXaDYOsbY5kQB/1IJWEhrYpLpsLaoTKJs0KCMiMtHKdyMlYl0eD7bYgkne
         /8P8/nbpwS7otH1W9SDFQiqYIWTszqXQu9QWE7zSkqPKSxCY1RDdlgKnr6LMkJtgNbDp
         PO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6UehWyei7/9LT/zdDWEG+kb3SxxswNdb+BNIsHrBAY=;
        b=2e2ZKnLDPeXWmKkYP7z25PmwTEVXhzn1diedD0IDMJi+ZzMWHJM1E3+o1quytIrr0/
         pYDM7e5//d/cs1J3coyJ15/3FzYaKUsKXbhlN+jOljrJ62ZXESofBUBMcORwUSlyK4DK
         4N14GJMXbW4BNik/D0R6B6Watj8EFXBzJ4WVvLys+IoWmxCiXChZoM6cdC7WxkvHCgyP
         v8Tu7IP1aPqDZAnr85xE35GQzoGqWcm9JYceytQaki9FpPF1dgIO8cG/HWswXoqD/Uwj
         xakeYqzs5PGUy/wMbqUNpgbc9SHfMYewko5g+H93edtRpDUy8RRLjlotl8cosa1dxF8Z
         CuqQ==
X-Gm-Message-State: AO0yUKUqp1fZPNzp5RiuRnJybH7Nvi6sm9f6dkjYDc2zdgbuTJi30XUx
        XbPprDOmUJLg3joEIO/sHeRoXIni6LJlYaIM
X-Google-Smtp-Source: AK7set8qUqtAQ280xAnflz7cGJ/UCFJKJcGzVQxHQki5DgEpE8Huz8lXehp0eWuK/9fmEwqsotr98Q==
X-Received: by 2002:a05:600c:5108:b0:3dc:58d5:3a80 with SMTP id o8-20020a05600c510800b003dc58d53a80mr4250290wms.24.1675948427081;
        Thu, 09 Feb 2023 05:13:47 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ja13-20020a05600c556d00b003dc4b4dea31sm1789394wmb.27.2023.02.09.05.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:13:46 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/5] soundwire: qcom: stablity fixes
Date:   Thu,  9 Feb 2023 13:13:31 +0000
Message-Id: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During x13s audio testing we hit few corner cases due to issues
in codec drivers and some obvious code bugs.

Here are the fixes for those issues, mostly the issues are around
devices loosing the sync in between runtime pm suspend resume path.

With codec fixes along with these fixes, audio on x13s is pretty stable.

Thanks,
Srini

Srinivas Kandagatla (5):
  soundwire: qcom: update status correctly with mask
  soundwire: qcom: enable runtime pm before controller is registered
  soundwire: qcom: wait for fifo to be empty before suspend
  soundwire: qcom: add software workaround for bus clash interrupt
    assertion
  soundwire: qcom: set clk stop need reset flag at runtime

 drivers/soundwire/qcom.c | 111 +++++++++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 38 deletions(-)

-- 
2.21.0

