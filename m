Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15EF74CBB0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjGJFFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjGJFFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7657AE66;
        Sun,  9 Jul 2023 22:04:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 843CB60DED;
        Mon, 10 Jul 2023 05:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB50C433CD;
        Mon, 10 Jul 2023 05:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965475;
        bh=5ggmlQDwZCuX+DdnA/m4DFd5oQxmn+nLqX4ZrH9EfY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfHuT7GCFLiJ88z9aK7E8X1DjgPiSR8pXHajGRyGRxUlumWP3BPpg7hp5RcjHt1NO
         CxmBvLnpw2yX3KDdipCrrLSfeyoO5/nsHpo8fbYfK+OLV9Fr+WWppQbShBGwceg9eG
         8RJJoHdoJvqV0BHzirsmo6h18IJpkiSQyMOixY6JbTKVRQoTI27iBCOh1WtUsehE1l
         65fwr0jmKxXf2wxEKjlbp8jhl35TtK5WM3JrDovMwc/ocWKdJ+9i/KBxUidZ0kIDVT
         aQrlQiKEwgjT7XKqAy6cYO6UAg5rIpf3n9jvLKvgtxDKA+wEh69Eh5vZ+Kwc2n980w
         N8VYzEC+oq7lA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcm2290: Add USB3 PHY
Date:   Sun,  9 Jul 2023 22:07:16 -0700
Message-ID: <168896565946.1376307.8655863846818291010.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230606-topic-qcm2290_usb3-v1-1-3e8fbcb89088@linaro.org>
References: <20230606-topic-qcm2290_usb3-v1-1-3e8fbcb89088@linaro.org>
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


On Tue, 06 Jun 2023 19:29:19 +0200, Konrad Dybcio wrote:
> Describe the USB3 PHY and hook it up to the USB3 controller.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: qcm2290: Add USB3 PHY
      commit: 0c55f6229bc3a17c48c7c488805d98f253ab61d3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
