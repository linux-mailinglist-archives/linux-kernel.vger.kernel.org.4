Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8591D710502
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbjEYE5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbjEYEzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:55:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C8C19BB;
        Wed, 24 May 2023 21:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09657642D7;
        Thu, 25 May 2023 04:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC496C433A8;
        Thu, 25 May 2023 04:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990325;
        bh=C+Y8GbIu10SV1j1Q6UAo8otqtZg5gdkFQ010fV+gUsc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PfZDiyAiSy3iOnLhIp+I4QzCAq0jY9Gp6iRJx3oCmwW/4yTvRLzQ24bjWvbK4qUDp
         4AWnn1F3MmvXajMwZNfAYel4E0eRQ7N+d3uzyA5WcYH3B1KJQiXvmOu9H+uKFf8MT5
         ax3PlFmKIWr9Mk0J7pUDNm9Bi7TVKkVduHzzUG0T4+WoV3Qfitu/cYAlK9BEIEeDcb
         NW+s9zDWZ1cw9fb3o59mXDO4AJGV+Lb389Kg//3C87C9FLPpvwEmM8fdWftZr7tTXV
         G2AsVqCZi5SwtKwFQKRMmjZmzB4nZfzDfZWfV2ycaW9f0pBDHq2EwiL0OQeE5ShmGr
         GWHhIEYRYyfNw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ5018 family
Date:   Wed, 24 May 2023 21:54:42 -0700
Message-Id: <168499048181.3998961.17201898359512917541.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230429193336.600629-1-robimarko@gmail.com>
References: <20230429193336.600629-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Sat, 29 Apr 2023 21:33:35 +0200, Robert Marko wrote:
> Add SOC IDs for the IPQ5018 family.
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ5018 family
      commit: e5b03cd101bd3dbbc7cbbe4c6e55a37070386494
[2/2] soc: qcom: socinfo: Add IDs for IPQ5018 family
      commit: 0369a5906e46a2431a8fe04aa79cba6583e53e73

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
