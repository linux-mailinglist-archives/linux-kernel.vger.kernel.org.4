Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0306BC106
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjCOXcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjCOXcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205D726C0C;
        Wed, 15 Mar 2023 16:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96CEA61E98;
        Wed, 15 Mar 2023 23:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454D9C4339E;
        Wed, 15 Mar 2023 23:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923133;
        bh=b90fAwRGYTnSjQRuOr59tMiAdhryQor3duVFOrFJSEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uKhVAlU4UhktEyRGdNSKY51v4QRCNHaZGpfnWaeANO8MxEx+0nf81GgiUZHvLVGJh
         ecF5MmNdhfFqK4tOCxlE2PsqIQLaLMylu0nIF74jsmurFTlejx2KZaj06sKviMSpxn
         falUO+mnXQ2pO0vuutv7zurDvq92tY0Cdovlhx4SyTiXywaTmcbgqJl/WQM/SAvG3n
         3pWcsLIX6wj53AhJEUkFyE8mV3VzquwqPhN2SLTKwXKnAVhch6UtP+KmYe8P8b2+bO
         K2RVWpF9kZU9OrbxxNdWyrx5Vm/CKuZHRqkjKK/QCVcik8ww8IKS5udsliQ4w5mY6L
         PQRFcRog+NuxQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        agross@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        quic_shazhuss@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sa8540p-ride: correct name of remoteproc_nsp0 firmware
Date:   Wed, 15 Mar 2023 16:34:42 -0700
Message-Id: <167892332562.4030021.10351902419014521818.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307232340.2370476-1-bmasney@redhat.com>
References: <20230307232340.2370476-1-bmasney@redhat.com>
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

On Tue, 7 Mar 2023 18:23:40 -0500, Brian Masney wrote:
> The cdsp.mbn firmware that's referenced in sa8540p-ride.dts is actually
> named cdsp0.mbn in the deliverables from Qualcomm. Let's go ahead and
> correct the name to match what's in Qualcomm's deliverable.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sa8540p-ride: correct name of remoteproc_nsp0 firmware
      commit: b891251b40d4dc4cfd28341f62f6784c02ad3a78

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
