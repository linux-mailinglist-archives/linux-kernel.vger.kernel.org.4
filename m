Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED1062A0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiKORqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiKORqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:46:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DCED102;
        Tue, 15 Nov 2022 09:46:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39A78B81A58;
        Tue, 15 Nov 2022 17:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E806AC433C1;
        Tue, 15 Nov 2022 17:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668534393;
        bh=aM71vjEc3suE5OvWeMbnuYK0ZusD+tn/gIFjHXgqcVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENzOp+H9CIbY4GRuazb9R6hEn2P0G9SKYOjpFlQvVI8IhLMHBCqB1H8SGI3NewRxE
         93zTVCNBHAkDyLD7L+5vLWmjl3yUm+aUZQ1+9818qSioIZgRlg2//aX2zp1CXPhK3R
         ZNWHJF4ueuWcxZ6deX/7RoBZYU4JDIRx77lxh7KgS/RMPOAFq8MYrz+aRfmtzDkjJI
         qtXr8Gp8xzSWih9VGmSFuGnBsShTLWuGex1+zSUPVLTwqBSaYXkDg/yb9wbGnBC8eO
         v+K9yRCcx9PAC8AKKdvqASZGzON5zIT0v6U6KEj/27z1buSx5CMeg10yWNpz9Zf5V5
         gBwaWymjYulIw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     dianders@chromium.org
Cc:     Andy Gross <agross@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, judyhsiao@chromium.org,
        mka@chromium.org, linux-arm-msm@vger.kernel.org,
        sheng-liang.pan@quanta.corp-partner.google.com,
        konrad.dybcio@linaro.org, swboyd@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Make herobrine-audio-rt5682 mic dtsi's match more
Date:   Tue, 15 Nov 2022 11:46:27 -0600
Message-Id: <166853438868.1276519.8897557062525056739.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221114162807.1.I0900b97128f9bb03e5f96fcb3068c227a33f143a@changeid>
References: <20221114162807.1.I0900b97128f9bb03e5f96fcb3068c227a33f143a@changeid>
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

On Mon, 14 Nov 2022 16:28:28 -0800, Douglas Anderson wrote:
> The 1-mic and 3-mic dtsi still had two minor cosmetic differences
> after commit 3d11e7e120ee ("arm64: dts: qcom: sc7280: sort out the
> "Status" to last property with
> sc7280-herobrine-audio-rt5682.dtsi"). Let's fix them so the two files
> diff better. This is expected to have no effect though it will
> slightly change the generated dtb by removing an unnecessary 'status =
> "okay"' from the sound node.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Make herobrine-audio-rt5682 mic dtsi's match more
      commit: f98d1a3c653e7e6f540e680eb8fef046c21cb091

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
