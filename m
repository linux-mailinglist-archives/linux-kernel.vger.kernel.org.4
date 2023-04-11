Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53B96DDB4D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDKMzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjDKMyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:54:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21EC469D;
        Tue, 11 Apr 2023 05:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E5F6625B8;
        Tue, 11 Apr 2023 12:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1150C433D2;
        Tue, 11 Apr 2023 12:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681217680;
        bh=j3Xg1BPP6tzN+QZty+6uCsWQ2SQQSx793sj3WwtoGBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWBvN+AEsD2BbfIRb74Rlr7n72p9iO7Haj61x2ORn3ANXtRGZiGpV+a7gMqeLE0Y/
         YOq7Hp/a4I62YbkXMAbviuxVXlnAzvWoyNMfeIzYuTOtTtFmnlKOGxbON0tWFRq3vl
         YYRuJJSI4dTxfeSJOIQo7SXVjPbqlsKmnomKNHmjIDXpFKA6NT5z6PjWZUIcaQtzhX
         KhRd0um8FND0bpMK6QPeQ3Vt0OjzMAMOEROG8nYv025Drmh9jJD9vC1eHfHShBwu5Q
         Sl6pAxy3ED5UqfoZW0KetqWVkaGZziVL74SYFT11+/9wRbYWOXynrQUtghTFvGwXx9
         2Z8qAVmcN5Ilg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org, agross@kernel.org
Subject: Re: (subset) [PATCH v3 0/3] arm64: dts: qcom: Add Qualcomm RB2 board dts
Date:   Tue, 11 Apr 2023 05:58:23 -0700
Message-Id: <168121789594.648775.16707170576274664021.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411072840.2751813-1-bhupesh.sharma@linaro.org>
References: <20230411072840.2751813-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 12:58:37 +0530, Bhupesh Sharma wrote:
> Changes since v2:
> -----------------
> - v2 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230315210145.2221116-1-bhupesh.sharma@linaro.org/
> - Addressed review comments from Bjorn about load conditions for vmmc
>   ldos and added [PATCH 3/3] accordingly in v3.
> - Collected Krzysztof's Ack for [PATCH 1/3].
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: Add base qrb4210-rb2 board dts
      commit: 8d58a8c0d930c52dd30bd50af24b786d55509cbf
[3/3] arm64: dts: qcom: qrb4210-rb2: Increase load on l22 and l24 for uSD and eMMC
      (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
