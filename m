Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEB36C4E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjCVOo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjCVOnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14B065C72;
        Wed, 22 Mar 2023 07:42:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFAF36217A;
        Wed, 22 Mar 2023 14:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01EBC4339C;
        Wed, 22 Mar 2023 14:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496149;
        bh=Wt77lysSTPBf3Cq7dk0L3R6p4ERUUZCZGTRyiUHFh+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQFFv3zFs99AiH/b6BzeX5CPJ4DlvIwRMO1iYSQ0Vbo2/gg9nVrz5//DR+2NaBQYY
         RWwP4Tjz0VX84waNDy3CFw5GBdSZBRT8q9iwR5cfpjQx7YRQbEfEhYpu7ZNjwt8Vb5
         DjdxpdoYSrghT04XjwreiAGCasV98gNVTAwRlmUvGEVgpfpVkK4qkzzmUq/gFoFFck
         cZDgaWCQ9V0aggZp02KzjuqAjqWnwM0SB2giMWgsw0okfL1fjlbYMfd35cqoCiLRNB
         UJXVt2e2yWwSh/DvHspnQHUlkIBzg15lTX5B24uYarOCTAN1qDoQVhTKh/RMEsu6Oi
         qhkUdPOoRKLxw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, agross@kernel.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] firmware: qcom_scm: Clear download bit during reboot
Date:   Wed, 22 Mar 2023 07:45:22 -0700
Message-Id: <167949631650.1081726.14607318206320828086.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1678979666-551-1-git-send-email-quic_mojha@quicinc.com>
References: <1678979666-551-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 20:44:26 +0530, Mukesh Ojha wrote:
> During normal restart of a system download bit should
> be cleared irrespective of whether download mode is
> set or not.
> 
> 

Applied, thanks!

[1/1] firmware: qcom_scm: Clear download bit during reboot
      commit: 781d32d1c9709fd25655c4e3e3e15370ae4ae4db

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
