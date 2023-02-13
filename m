Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FEB6953CF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjBMWVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBMWVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:21:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC3920042;
        Mon, 13 Feb 2023 14:21:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C8CAB8198E;
        Mon, 13 Feb 2023 22:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890DAC433A4;
        Mon, 13 Feb 2023 22:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676326870;
        bh=uPpOp2N58RQPlHMhSStXpoHLm5GlicGnX0KefJR66VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BL+S2Ey7BqtCqiBDhEvfEX1QnxPwbWMygknQCciYrXcDoT0KnvzszOGeiEVPauekT
         y2Z5maDX6iIh8xAvJVxAqN29csv2WF6Hhsf3ltHJWHHaRc9b0uuuxqFOTO3uKSmwpv
         Qy6Ib4jQ098hIg7qqXp1TYE1DrqSTJDLmpZ/eg9s/d96yCQCE29GC6gvvFy5otudcM
         0IjpN48IKVREKVa9mYpCME6sEOflam6BGJAGk6xWGuzGWIvDgHmGMym8bm3TjqISew
         gZQuP+58lx+uypbRIWcNFOs0I27ey4BR9MFWi040y0eG1KvPmUkk7PvuhN24ILETqK
         365e2W60NCJaQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: remove invalid interconnect property from cryptobam
Date:   Mon, 13 Feb 2023 14:23:06 -0800
Message-Id: <167632698311.557014.9648200229884885250.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209-topic-sm8550-upstream-cryptobam-remove-interconnect-v1-1-84587c7bad0f@linaro.org>
References: <20230209-topic-sm8550-upstream-cryptobam-remove-interconnect-v1-1-84587c7bad0f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Feb 2023 09:44:43 +0100, Neil Armstrong wrote:
> The interconnect property is already present in the qce node, which
> is the consumer of the cryptobam, so no need for an interconnect property
> as documented by the bindings.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: remove invalid interconnect property from cryptobam
      commit: 26e95ff8a912fd787a65ae1ae4cc4684f5f84fce

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
