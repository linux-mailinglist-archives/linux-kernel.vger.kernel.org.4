Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29186C4E53
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjCVOoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjCVOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36FF65C71;
        Wed, 22 Mar 2023 07:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73C3E62171;
        Wed, 22 Mar 2023 14:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F55CC433D2;
        Wed, 22 Mar 2023 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496146;
        bh=ZEk6Is/AQpeKoK8s9K0Qw78Ve1+e894VSLCsUZNA1oI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SF7Z7qjsi8zhnTqqp9TEsLV29TxRvGf8ky10uomJs2Q5KfAkeGnVuXOpcS9WTjEt+
         VF57zdvkJC7mxbCmRlO6HmpH7zxawwJBGJT/j2prF7+Y4fXDjztiUj9CR4xRCxWpzg
         y5D4DWvetwEB0U43aqNgLgf0wqGStlgaGtNF7NcQm3P/j2tGI3bnxSESv3chXjr2qG
         MA+wn4Q3PgAOPji6SuJ4xAFOVjnrc7QV+SlwSe9/J4n8mLCk4PJIWcGZIrJqzrkFh/
         wz9MVm7ki5juhRsdr6qq4AtpkYNEzTj5VJxsQ7XzAzgC5q6IXSPeN+LElIaAM8ARZW
         B9ATPF6902T7w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: soc: qcom: smd-rpm: re-add missing qcom,rpm-msm8994
Date:   Wed, 22 Mar 2023 07:45:19 -0700
Message-Id: <167949631652.1081726.4452705235754573255.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305122428.167580-1-krzysztof.kozlowski@linaro.org>
References: <20230305122428.167580-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Mar 2023 13:24:28 +0100, Krzysztof Kozlowski wrote:
> Re-add the qcom,rpm-msm8994 compatible, dropped during conversion from
> TXT to DT schema:
> 
>   apq8094-sony-xperia-kitakami-karin_windy.dtb: smd: rpm:rpm-requests:compatible:0: 'qcom,rpm-msm8994' is not one of ['qcom,rpm-apq8084' ...]
> 
> 

Applied, thanks!

[1/1] dt-bindings: soc: qcom: smd-rpm: re-add missing qcom,rpm-msm8994
      commit: 34d84c3b0f63978efcb5136a6fd2e7e9d889da70

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
