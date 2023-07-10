Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6EE74CB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjGJFEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjGJFEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:04:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A0D198;
        Sun,  9 Jul 2023 22:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A1A260DF0;
        Mon, 10 Jul 2023 05:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C24DC433C7;
        Mon, 10 Jul 2023 05:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965471;
        bh=f/H1w3WwU/KKTpXAMsp55x0LRP59EqqbpBhHqMf+0LQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y0DUWSta2M3O5nxsvWrSB7XFOI/hS8win5Yx2CoDRe7FsOV5D6ooy821Yw9ktvHVI
         tHIaeivtCD/n8Qwb1w65LMAb5JLrpXztdOmjR23W45OzcICoN4pFkZdJ+/NDkCkciB
         o2IxJ7TOyS/ety8T1I5lFIv2dboA3xFleb+gT0boGhOQLpIQPLoFyCWUy3qHxnKTjG
         p0JMBlMocrtxYqT0T7aRbHeElwy8AAgJzFP88ovA8jgZaNeYzTcG7fcIKr5FnhWQ2h
         GKN578rASu8IOGxFZycMm6s2UNL/RFbALL1GBM0CvKdtD+IDJv7ButhEG9gZRSZbvq
         jan9wXgY9O+Mg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH 0/2] Hook up 8280 SCM icc
Date:   Sun,  9 Jul 2023 22:07:12 -0700
Message-ID: <168896565969.1376307.16519130815216294170.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622-topic-8280scmicc-v1-0-6ef318919ea5@linaro.org>
References: <20230622-topic-8280scmicc-v1-0-6ef318919ea5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Jun 2023 17:56:14 +0200, Konrad Dybcio wrote:
> The icc handle for SCM was missing on 8280. Add it.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sc8280xp: Add missing SCM interconnect
      commit: 0a69ccf20b0837db857abfc94d7e3bacf1cb771b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
