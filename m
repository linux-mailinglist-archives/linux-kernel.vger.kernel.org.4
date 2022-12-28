Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2380D65864B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 20:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiL1TOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 14:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiL1TNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 14:13:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839BC15FCA;
        Wed, 28 Dec 2022 11:13:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22FDAB818C8;
        Wed, 28 Dec 2022 19:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C60EC433EF;
        Wed, 28 Dec 2022 19:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672254829;
        bh=v94CXa36zIMp9DOqCD7zQebw66UQI3X3ozPtbJeqUaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TR5iXlFDGMLoTc2/nSRKIphi0NMNYJpEUdZoB1s/fIBz7KovbnO+Hsn2TG2QN9vCi
         bm9CiQRzzDUnudOHPeP6VJA86BZ7pCATkda5U7RjZq8vRuro+e8QLsRe2efl6sVfMx
         t1wtgD5ngH2SmB8240EUIChCR7mBBYLQp90A/1lKpsOp5xL7aqbpowSphdqRJ01pCc
         jj/5d0lBV6JFjNfIQ3RfI1+SGeUkfxIPjS48wu/M3bniJJUel+TNrPMh7R+5xpsohI
         zCSyuIwkMWHbuHBLEKZIKLwtblA7B7AAXGHLImODIZhk2l0Otf19DCASPdhwkt2qbp
         4gOfMI3TE6d9Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     steev@kali.org
Cc:     agross@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: c630: Fix firmware paths
Date:   Wed, 28 Dec 2022 13:13:45 -0600
Message-Id: <167225482207.977158.2618349540018032300.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221226004727.204986-1-steev@kali.org>
References: <20221225040821.8395-1-steev@kali.org> <20221226004727.204986-1-steev@kali.org>
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

On Sun, 25 Dec 2022 18:47:27 -0600, Steev Klimaszewski wrote:
> The firmware paths were pointing to qcom/manufacturer whereas other
> devices have them under qcom/chipset/manufacturer, so fix this up on the
> c630, so we follow the same standard setup.
> 
> 

Applied, thanks!

[01/1] arm64: dts: qcom: c630: Fix firmware paths
       commit: 40103eabe3d3139a69e5235cf3a86c89214ef584
[26/26] arm64: dts: qcom: c630: set venus firmware name
        (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
