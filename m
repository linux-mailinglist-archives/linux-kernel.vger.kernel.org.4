Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253E3602287
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiJRDWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiJRDVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:21:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C028095AC0;
        Mon, 17 Oct 2022 20:17:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1710361425;
        Tue, 18 Oct 2022 03:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB071C4347C;
        Tue, 18 Oct 2022 03:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062899;
        bh=F13jGiDyLsy0Sm/OnEjAY0jLGtcGqkpnnNM314OJCGQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qgsewI4M2AxmFsJ9yo8Z5dzd9uI/yHgqvf03OZW1HDtRXEt6tEbupAV+44b1adDB2
         yDguKAX/WZNKWEirqD9itBQOwfWfkOCDt0Bkc/rQ5EGMMWUKS1UgQU9HuBydQ7+BlJ
         SJWzHOgkjCIuEWdPXZRgpStUfg2/IaBRxp4gTTLukHHGOJ75ohmT6o+oKjadaWwbL/
         NjTmgjnWPZVBW8QUnxCMO7NYeYnWfZpdLXLtfRS1V8zI4INq9qpjv/kQGdEsQOA2CT
         zY6Vlnap5QnjUP8yCKnZvF9FBOhw/OLYVcU27d1/1QM/r+ba5vsQhusyTWU2Cph0EL
         vfCHg0Ieqxokw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@somainline.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, robimarko@gmail.com
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: ipq6018: fix NAND node name
Date:   Mon, 17 Oct 2022 22:14:53 -0500
Message-Id: <166606235859.3553294.10965462764354410220.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220927201218.1264506-1-robimarko@gmail.com>
References: <20220927201218.1264506-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 22:12:17 +0200, Robert Marko wrote:
> Per schema it should be nand-controller@79b0000 instead of nand@79b0000.
> Fix it to match nand-controller.yaml requirements.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: ipq6018: fix NAND node name
      commit: 8857b0ab6a562c473c5bded0efda9390b82a84d4
[2/2] arm64: dts: qcom: ipq6018: move ARMv8 timer out of SoC node
      commit: feeef118fda562cf9081edef8ad464d89db070f4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
