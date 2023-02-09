Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F1768FEDF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjBIEbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBIEa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:30:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237253EC42;
        Wed,  8 Feb 2023 20:30:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5203B82012;
        Thu,  9 Feb 2023 04:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB92C433D2;
        Thu,  9 Feb 2023 04:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916525;
        bh=sWvmC9ahPsg0xDLGldFddT4dv4jY9/tk2f9UYE0RvJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HNwEPX/3TanBuMz01oG7bY7mSc23DAii7zqVJbhCJIDJlzHkiYSux906cPId4vvv6
         lR3gZQEDlsN41SXuJpXjws/k8hkmlPatiJE95QEeAh0bvyZzw+sAl5DY85IPuGQjS0
         HqQhep5dJrpYxGMxAXLtRqBkCp7ltkIv0oicDtDhPcOCCqgcPgjpvihAHbXqJ9JPpk
         iD5tpV0jhKa1kJ/HfvPBeUWr6BGCf8lhNu0LhFLskcouBNKAotSYOla2xqXvi3mO2R
         8ko8wawxktkkgtGSVpRYF5O+iD2a48bR6+XUkEpcKUFU1CE7WszCx5c0TGoKlPWjoP
         cJVm1kKQoCTxw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: qcom: various sm8550 DT fixes
Date:   Wed,  8 Feb 2023 20:23:21 -0800
Message-Id: <167591660372.1230100.15286899195594133181.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207-topic-sm8550-upstream-sm8550-dt-fix-v1-0-698d132ab285@linaro.org>
References: <20230207-topic-sm8550-upstream-sm8550-dt-fix-v1-0-698d132ab285@linaro.org>
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

On Tue, 07 Feb 2023 11:06:56 +0100, Neil Armstrong wrote:
> Fixes PON compatible and DSI controllers compatible properties.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8550: fix DSI controller compatible
      commit: c64c1c245f667e32eb02eaa5d63363d35880664d
[2/2] arm64: dts: qcom: pmk8550: fix PON compatible
      commit: 12efdeec570c24e205484c1191265593f1dd4679

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
