Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E97B73046E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245332AbjFNQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245076AbjFNQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D69F2117;
        Wed, 14 Jun 2023 09:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E9AB6441C;
        Wed, 14 Jun 2023 16:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6511EC433C8;
        Wed, 14 Jun 2023 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686758420;
        bh=+GDOie9Y5yo7+W/LNlvEMtAgRoYKTZPL6eQTFkYQEAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzNHgCdTS6xkNGZHZecn8oCQ1hnOBMRgccEZuL1K56JWjWlhOBAa6PQSaJiIOHuXl
         zLQ8eg+V85K52AvN+CRMz7YU1nxDE+zHBpm48PxZjT10O5RYnEkUvlC2F8eK2e2BJ9
         RwAOUl/FH69+GPYOQYBlqJGMKZWI1a7Rt8U2FRDbW7tdAUNg05VuLQgi1vdBsfgF7k
         8x2R/j3DnJmMKy3PGOgnxlymj5QPRduu0NMlG5g3q3xTqplImswMwU+t2GRpqKpIpi
         pSSIFhNzMtvrRYyS+5i9CZlqBwUOu+oEs+bH9PLR+fYIyHOteP8tzElNrIGVpK8A+z
         j4xzrV5Uq9bYA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/8] arm64: dts: qcom: msm8939: Rework regulator constraints
Date:   Wed, 14 Jun 2023 09:03:38 -0700
Message-Id: <168675861182.1453524.2927753257641993379.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530-msm8939-regulators-v1-0-a3c3ac833567@gerhold.net>
References: <20230530-msm8939-regulators-v1-0-a3c3ac833567@gerhold.net>
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

On Wed, 14 Jun 2023 09:15:58 +0200, Stephan Gerhold wrote:
> Rework the regulator constraints for the MSM8939 device trees to be
> closer to reality. There are several mistakes in there, some of them
> taken over directly from Qualcomm's vendor kernel. Fortunately, none of
> the mistakes is absolutely critical because it turns out that the RPM
> firmware also validates the voltages and silently clamps the requests
> to a proper range. Still, this behavior should be clearly represented
> in the device tree rather than pretending to apply the wrong voltages.
> 
> [...]

Applied, thanks!

[1/8] arm64: dts: qcom: msm8939-pm8916: Add missing pm8916_codec supplies
      commit: dce9254511d6c9ea0d5ed7e4f21e6206e2ca35ce
[2/8] arm64: dts: qcom: msm8939: Disable lpass_codec by default
      commit: 6002a78023cded6f02eac7c812b076046cab8060
[3/8] arm64: dts: qcom: msm8939-sony-tulip: Fix l10-l12 regulator voltages
      commit: 209aea1ad505519faf018b596e4fdca0d0569469
[4/8] arm64: dts: qcom: msm8939-sony-tulip: Allow disabling pm8916_l6
      commit: 8771308c91cefc072f36415cec0b802ee55b1d96
[5/8] arm64: dts: qcom: msm8939: Fix regulator constraints
      commit: 9187d555c4ba9544c7f117062d241aa085f59a06
[6/8] arm64: dts: qcom: msm8939-pm8916: Clarify purpose
      commit: 88028fa047fb72826dd206b51550be780777718c
[7/8] arm64: dts: qcom: msm8939: Define regulator constraints next to usage
      commit: 5cdab9a8c70c4d979909dd1bb6d1f3eacd9fa270
[8/8] arm64: dts: qcom: msm8939-pm8916: Mark always-on regulators
      commit: ecbfba694b5baf2b854689c63ef011e905810c59

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
