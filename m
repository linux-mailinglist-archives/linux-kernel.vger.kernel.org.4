Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A466BC119
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjCOXcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjCOXcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E2B26CF6;
        Wed, 15 Mar 2023 16:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6169DB81F93;
        Wed, 15 Mar 2023 23:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C277C4339B;
        Wed, 15 Mar 2023 23:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923138;
        bh=9sQRd9LAGmB1NXqq1eIZfVxdADJJfusKOz3vKTJlJDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTk9ACgwM8qFAQ0SDSdRpfQnpf1c5STYEvxaM0cxVBPMLdIxEWH/H1tePLA9H9Ou0
         KJswhkZkEI7CYmRzdZeBj/5abepi2X69B+dcba/vfnCPqSCLWJmebVJVd/Klw58Hxx
         KpiHpdqgmMkJvn2sGCInrAGLxg2lA5jCXtm4ajqprj1hLlGQ+5ejjBt2KNG1yj40mL
         tMgIr2qbfbnIDWrqvs8QGUSGca1kpQ2qRIx3h7ulTDfnON7uv6AlXshnCTFzvLeCu2
         W9mNm8P4ZkwsNRrT9ZHMxlqpO5VmbV2NvnP0LRViHt12Ll40dqWgbsZLpItU0320kn
         tMb2d44TaTnXg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Guenter Roeck <linux@roeck-us.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-watchdog@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/5] arm64: qcom: add initial support for qcom sa8775p-ride
Date:   Wed, 15 Mar 2023 16:34:47 -0700
Message-Id: <167892332559.4030021.14393028691283989372.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230201152038.203387-1-brgl@bgdev.pl>
References: <20230201152038.203387-1-brgl@bgdev.pl>
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

On Wed, 1 Feb 2023 16:20:33 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This iteration contains a fixed DTS and all not already applied DT bindings
> patches (with tags collected).
> 
> v2 -> v3:
> - reorder properties (reg always first, etc.)
> - tweak node names
> - remove properties filled in by the firmware
> 
> [...]

Applied, thanks!

[5/5] arm64: dts: qcom: add initial support for qcom sa8775p-ride
      commit: 603f96d4c9d0cb42f934fb0b99440bb9e8ba4385

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
