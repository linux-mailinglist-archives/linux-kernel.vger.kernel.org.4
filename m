Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2C268FEF9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBIEcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjBIEb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC45ADBD3;
        Wed,  8 Feb 2023 20:30:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 181F9B8200B;
        Thu,  9 Feb 2023 04:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1F8C4339B;
        Thu,  9 Feb 2023 04:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916513;
        bh=4bVh3I1e94F8/5NqC68u92sRd/Qw0kN9cG/YbNTHhd4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VneTLEh0l+licHAG/V74qMkoxAxo9Xq+86I+dY40uzTm9Iu4YoKeoYA3VHsy854Rh
         GCr5PWHXD6FN215dqVhzQRCjKqgQMoBcI/N0DRNApfJdurHQa0F8ZaJ4yvsjSZkRUi
         ZAFtUfyJItVnBuTz4y9YDCzJ5Kpb1169Gly5NxUmAaSr9mJxJDaboxXUJKqLML9ckE
         UVxXvvfjNL/dymTar5lf/YRClMeh7GLvr6F0vjxV3lok2lClRHRJsCtAcuZMtLSSGY
         3fT1e8qhS/8vCjtXhDkJhM3SoJs+1M0q5RgkAeSTUuU1YvoYqK5tcfSvPRk7ifJYhY
         +aQHC9Szg8LAw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: use "okay" for status
Date:   Wed,  8 Feb 2023 20:23:10 -0800
Message-Id: <167591660368.1230100.17185472042798429804.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127095319.64560-1-krzysztof.kozlowski@linaro.org>
References: <20230127095319.64560-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 27 Jan 2023 10:53:19 +0100, Krzysztof Kozlowski wrote:
> "okay" over "ok" is preferred:
> 
>   serial@f991f000: status:0: 'ok' is not one of ['okay', 'disabled', 'reserved']
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: use "okay" for status
      commit: 8676ff664b0ec6de46adf1abc59b7903c6b6049c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
