Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACDC710466
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbjEYEw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbjEYEv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE0DE69;
        Wed, 24 May 2023 21:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B0BF63C35;
        Thu, 25 May 2023 04:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67BEC433B0;
        Thu, 25 May 2023 04:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990274;
        bh=RIfi/iTTcYW7sLyzymuTkDgbF9dWHV9h80/MQWAd3ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6w+tFQAF39f9atIW0OuZ4ODb32YUuEK4ORUQj3E2SkudjbRmeC9rp2rvvA5tWYQT
         ukMVrHmKXpUrWcK9AhoUe0YUmp97De5VaRu8z+K1Mqe6T7dGKCWFNHnyZ+KN/NO/3J
         IujoxR63ObAJbq6C/+ww0ELb4lwsgVYPDkezPAsQdxWawEVMmKfKrkocm9pBfxgIQh
         W9TCxa40b9ShhrqcktZSSIP8tUj83vyMmvf5RazyrOuuzS59GNn5KNLXOUl+FK/PSv
         NbEO/ivcxYb4DRcfImLPKPglygyvcy8pCgZH2lTmKOBKGVuir3bR4/NlX1M3yKwInk
         qGpAeRWSYL0Lw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH] arm64: dts: qcom: msm8996-tone: Enable LPG LEDs
Date:   Wed, 24 May 2023 21:53:54 -0700
Message-Id: <168499048183.3998961.1831208063916493266.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413-tone_led-v1-1-bc3c73393bfa@linaro.org>
References: <20230413-tone_led-v1-1-bc3c73393bfa@linaro.org>
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

On Thu, 13 Apr 2023 02:37:36 +0200, Konrad Dybcio wrote:
> Enable the notification LED(s) wired up to the PMI8994(6) LPG.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8996-tone: Enable LPG LEDs
      commit: 3e459be2a315dd017cbed6a86c23e636987b493f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
