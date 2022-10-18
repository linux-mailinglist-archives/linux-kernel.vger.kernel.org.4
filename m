Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49B06021C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiJRDHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJRDGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:06:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6832791848;
        Mon, 17 Oct 2022 20:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD992B81C64;
        Tue, 18 Oct 2022 03:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED65AC433C1;
        Tue, 18 Oct 2022 03:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062397;
        bh=niOO9FJQTYwD9nH0HMg316JpLFsngToZ0pzNvf3J5WY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcZBsH04yMpU8bAMsBhGC75lhx8wvUNhpjNcHgd/MY0Z4OyCMnmdklLbW8i6o+lkq
         C/dKY/PKlVCWy6Zxi4zgw/GDoAgl3I/HiQZmbg89so3WjACjdM8vWedBuk1zw6ystA
         x1gYU7aUb8wTti+FNnkPqHGfD3avIgQqPnTWS7N2cEF/ShXu1Jbjoso26sJDGjOmc5
         w3Di6uHehBMdzqegs7mkkawU418PFOO+XEP9lBw3WBInHwiUxRzVjYhVBeOFdn5F/0
         8vhkhc1iv0FKgNJw7JoNUW09gqFsNEG4oq8Bt6OVXfRWE+deJVS3OvKrIWgCpkSa7+
         YCVXzQ/alKXEg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: add rpmh-stats node
Date:   Mon, 17 Oct 2022 22:05:19 -0500
Message-Id: <166606235857.3553294.679900263670569551.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220921080050.21383-1-johan+linaro@kernel.org>
References: <20220921080050.21383-1-johan+linaro@kernel.org>
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

On Wed, 21 Sep 2022 10:00:50 +0200, Johan Hovold wrote:
> Add a node describing the RPMh shared memory that can be used to
> retrieve statistics for the SoC low-power modes.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: add rpmh-stats node
      commit: b7e2ce42f61bd72e903952427538e2411b3a1429

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
