Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBBA644B50
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiLFSVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLFST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:57 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F19209BB;
        Tue,  6 Dec 2022 10:19:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 46CBCCE198B;
        Tue,  6 Dec 2022 18:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB58BC43143;
        Tue,  6 Dec 2022 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350792;
        bh=prU1Dmpeny5mMbqJi+O9MomcazycuOAmbeMY8t40dCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKgccnGrrxqyDE7GAmZqvQcSdJK0oIk4pRmWJPwxwoqVIZeEiolZXDR1yAMaoYAH5
         L3uj5vZqlmgpwyCNFoii8tV+dZy/1OuqZhJZpBW2VEbMes3V8+pmtZb7e8C9jlYTYt
         3BbrVfo+p7Yo7NsuGdFz1F715v0s0FH4MfQO0QxxGa6u1kD61Qx6duKgUfJ9yT8nHQ
         mEkUbUyeU3XJpjoN2Rx6/fY1T7QEvSFcrltg5qa7MaZc+BcZEdboBVX854PdJh4CYH
         M45nKwONksfZkEb5FQqCwX/Ga1z9pTLndU0GAYLs+/B7bwcJ5uALkmeyVJrF/hRBfA
         FKiVabUUJroiQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, vkoul@kernel.org,
        konrad.dybcio@linaro.org
Subject: Re: [PATCH 0/2] arm64: dts: qcom: fix USB-DP PHY registers
Date:   Tue,  6 Dec 2022 12:18:56 -0600
Message-Id: <167035076327.3155086.12781605322798241404.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221111094729.11842-1-johan+linaro@kernel.org>
References: <20221111094729.11842-1-johan+linaro@kernel.org>
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

On Fri, 11 Nov 2022 10:47:27 +0100, Johan Hovold wrote:
> This series fixes DisplayPort support on sm6350 and sm8250, which used
> the wrong offset for the DP_PHY registers.
> 
> Johan
> 
> 
> Johan Hovold (2):
>   arm64: dts: qcom: sm6350: fix USB-DP PHY registers
>   arm64: dts: qcom: sm8250: fix USB-DP PHY registers
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sm6350: fix USB-DP PHY registers
      commit: 347b9491c595d5091bfabe65cad2fd6eee786153
[2/2] arm64: dts: qcom: sm8250: fix USB-DP PHY registers
      commit: f8d8840c72b3df61b5252052b79020dabec01ab5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
