Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78B96AD622
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCGERQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCGERH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:17:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3275328A;
        Mon,  6 Mar 2023 20:17:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6B3BB80BA0;
        Tue,  7 Mar 2023 04:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1B2C433A0;
        Tue,  7 Mar 2023 04:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678162624;
        bh=E0VFhdTMfMES0QIejpeQT7Bl4k+8EEwaft3lnVN1UPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kfyf4NpscZnzM0CiDJs7JQffErHqmM9DF63GY+/1+kvR9NWvz9CbIqzhWxKTeBPK1
         Mmzjo+7AYaErakb9gZRbsFixBDMX5Zz8dGZFvKuqgWC6P+otXtv1JScsTW6dQ8roZD
         UhScj/sZ7rgM0Bpb43yXhS+JkEvJAp2adDscu0KmGJYB7Ue3kgxo27+zMjcxEA7XN5
         Bg22B1j0wXZJXx9afu3YI/Q9dtA3+qrdNkG57BSWWmJlRegTPyxN8dBmjpEHhY1o8s
         TyMt9ReUGnHrxOWc99+tJVRf70M12yr8hHmQPqp3BOEWhhITh7qyunHOKs86vKsOkP
         YvHNU4Mi1i56Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Yang Xiwen <forbidden405@foxmail.com>,
        devicetree@vger.kernel.org
Cc:     Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jaime Breva <jbreva@nayarsystems.com>
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-ufi: Fix sim card selection pinctrl
Date:   Mon,  6 Mar 2023 20:20:27 -0800
Message-Id: <167816282864.1458033.10898681034642002351.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <tencent_7036BCA256055D05F8C49D86DF7F0E2D1A05@qq.com>
References: <tencent_7036BCA256055D05F8C49D86DF7F0E2D1A05@qq.com>
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

On Wed, 1 Mar 2023 16:53:50 +0800, Yang Xiwen wrote:
> The previous commit mistakenly introduced sim_ctrl_default as pinctrl,
> this is incorrect, the interface for sim card selection varies between
> different devices and should not be placed in the dtsi.
> 
> This commit selects external SIM card slot for ufi001c as default.
> uf896 selects the correct SIM card slot automatically, thus does not need
> this pinctrl node.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-ufi: Fix sim card selection pinctrl
      commit: eaba416688f4f074ea3bf2ef975c9e2dbb06712b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
