Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3290672D35
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjARX4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjARX4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:56:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A5247435;
        Wed, 18 Jan 2023 15:56:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0105F61ADD;
        Wed, 18 Jan 2023 23:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6225C433F1;
        Wed, 18 Jan 2023 23:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674086159;
        bh=rB3uci14ZtarYdqY2ylJKrE1q8vmSrkvrEdGLhvpa/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aQ+GZ/dUcW1DbG+bkcDe+4ckB4KCgKiLIInp4VA4HvcjsTleJ/HYmHQ/vTeG7WuAU
         UjWKbus8/UM/fsHtQR1PRTsECEzHuyjbU6hNaCV33/mtnXQmad/7qM7Xsqk01d/P7h
         vpQD1KoPmN42YT324M6rPQzpyi2pePOdNljb0XuxG/6DjwLt5FqAB0EXwXVUJ4LJo8
         aL5hPEQUz1WrxPlM6C0niZvGzgPDDq20iNYDNYJrjOhMhBFtlkEeER2MN/NtqSNqQJ
         WoYbA5M81fU+JbeMKUZL9XqEiOCVwx4FU9ne33280nigJSI1HpvFMwbFtSc6npN8Z/
         AsCj0CqJjzMMw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org,
        rfoss@kernel.org
Cc:     robert.foss@linaro.org
Subject: Re: [PATCH v1] arm64: dts: qcom: sm8350: Use 2 interconnect cells
Date:   Wed, 18 Jan 2023 17:55:43 -0600
Message-Id: <167408614052.2989059.12874514471754492819.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230117115712.1054613-1-rfoss@kernel.org>
References: <20230117115712.1054613-1-rfoss@kernel.org>
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

On Tue, 17 Jan 2023 12:57:11 +0100, rfoss@kernel.org wrote:
> From: Robert Foss <robert.foss@linaro.org>
> 
> Use two interconnect cells in order to optionally
> support a path tag.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8350: Use 2 interconnect cells
      commit: 4f287e31ff5f464526651ee3cb3fd3e96b2e5746

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
