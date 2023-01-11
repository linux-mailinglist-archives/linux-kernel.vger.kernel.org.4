Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7867566539D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjAKFWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjAKFSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F9613F72;
        Tue, 10 Jan 2023 21:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B10E961A32;
        Wed, 11 Jan 2023 05:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30773C433EF;
        Wed, 11 Jan 2023 05:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413815;
        bh=r3eUZ8KOW7lqRoM2nfAPQ4cjqrchAFdxP4QUSi7lgdg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ICu4W2R4fOr+JAD/m1CWWapK9K8DW05Y5nVu5oSYsOu+DIG3vI1Tq2gmhaLfF7BXP
         ZOGTXYZO7pQUFNLOnhOUorxXoLkmTn34YSVp0hMvAjWevXphwhh8Ew1gu1K4Mkz59z
         ws389FF0FeZHo3anBcWo8QuQ49/sWLBOjsGJOAmVtxfAXekPYE0PFeHlCkZ2hhoOaZ
         zHGF+tWAT+kmcOAo81z7xAY5PkMVrJYPw8ETh2W3napRp3JoR06qFGqWSK17NHXeEJ
         UQOglagpJ7xkbyvelaMvfNm5HbLyuMW5fsv3mRVHIWsldJnRXmJC4iv5UfVAqBPCkO
         u1ggKqBlcA3dw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        quic_rohkumar@quicinc.com, dianders@chromium.org,
        quic_srivasam@quicinc.com, devicetree@vger.kernel.org,
        agross@kernel.org, srinivas.kandagatla@linaro.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Set performance state for audio
Date:   Tue, 10 Jan 2023 23:09:40 -0600
Message-Id: <167341377724.2246479.5097877341806387252.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1670932566-22923-1-git-send-email-quic_srivasam@quicinc.com>
References: <1670932566-22923-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 17:26:06 +0530, Srinivasa Rao Mandadapu wrote:
> Set a performance state for audio clks so that the minimally
> correct corner voltage is picked when audio is active.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7180: Set performance state for audio
      commit: 76ee8cd53016d0e157c20aa3dfaf2b86c0481111

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
