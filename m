Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AF374CBE6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjGJFHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjGJFGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3432115;
        Sun,  9 Jul 2023 22:05:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1702760E08;
        Mon, 10 Jul 2023 05:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E120FC433CA;
        Mon, 10 Jul 2023 05:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965506;
        bh=UsGeAdzoUYcHq4aU+PC7glPOnwY2hRQpMy+Vggsem0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRUslWz2HIod95l6w7zcxlJ1v8uX4pG7eWIj5dcjSRmTG/flo1n2Q4y3jNvdZHi8O
         uY83FHIvqjp+vB/JNr0jesFdzXFE7UkHITukDLnAX1twYX8a0MSfKzTy6/mZJqDPb6
         sN3hBMqXaVuo6SEWbmr1xKvh8DK81xTnNA3usf/pTv8sDTGwc4cxZ+SOfYxP1GqSWV
         u0KCXDnbFP3Y8YHHxbjtHIltUIy7GDNNPVjmv2NCVVBd6R3WeBXwvP2+wsk8niP+fc
         ePd2nLFX+wBMSWs0jPsMNH+mbXvMnCMvgVBEoWVH8VTnXnvgoKxEns8WxK4vXyUDz0
         AB+/PUUNCuLUA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Include state in trace event
Date:   Sun,  9 Jul 2023 22:07:44 -0700
Message-ID: <168896565965.1376307.2011861756792864928.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620230058.428833-1-quic_bjorande@quicinc.com>
References: <20230620230058.428833-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Jun 2023 16:00:58 -0700, Bjorn Andersson wrote:
> When tracing messages written to the RSC it's very useful to know the
> type of TCS being targeted, in particular if/when the code borrows a
> WAKE TCS for ACTIVE votes.
> 
> Add the "state" of the message to the traced information.
> 
> While at it, drop the "send-msg:" substring, as this is already captured
> by the trace event itself.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: rpmh-rsc: Include state in trace event
      commit: 1b06d8ca087a8fd9b395b577048636926db22f0e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
