Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26256BE2B0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjCQIJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCQIJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:09:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9819924BEC;
        Fri, 17 Mar 2023 01:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A5C62214;
        Fri, 17 Mar 2023 08:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7FDC433A0;
        Fri, 17 Mar 2023 08:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679040483;
        bh=YN9VvRwZ3itjby6vgOgEDDEAI+Atn0iRFKgDJ4cpskY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9f3tsr0PQT0MIlntxgP63RsAPeCd5TIGammVzk6jhu4mg6joKpYiIWHYJzs8ROGZ
         98CZ0IVRtZ8evD3GiRhdLvW/Yuwf6vcLaeeNOfHcHNTMBE3H8IrvMd/rWWCW4/IcGD
         TJAux1Wm0qKpBtJ3Fg1tFY27g6ASo3b+vrlSbUm6FzbHpTATwRqbsV8PZKZWprjbYo
         wHzGAzE9NCHJeCX0NWUw1YaPG1WrdjEEWdKaM/irpFVWOqphyPZW2yoABAXfbEMPET
         Lc5vACPa5IglHbTdAIL7cnSTiiTnKeviVdSC7iCjxMEwZUFzhXJWREnJiu+/HKhbeQ
         ZPeyd6KFzRxEQ==
Date:   Fri, 17 Mar 2023 08:07:58 +0000
From:   Lee Jones <lee@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: Add PM2250
Message-ID: <20230317080758.GF9667@google.com>
References: <20230315183819.3563704-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230315183819.3563704-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023, Konrad Dybcio wrote:

> Add a compatible for PM2250, commonly found with QCM2290.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

--
Lee Jones [李琼斯]
