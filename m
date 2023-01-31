Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893C76828B4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjAaJY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjAaJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:24:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A463C2E;
        Tue, 31 Jan 2023 01:24:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B530561471;
        Tue, 31 Jan 2023 09:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1371FC433EF;
        Tue, 31 Jan 2023 09:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675157093;
        bh=Pu1oJy8nsZuyzS4D5gDVYjFlN67VdKGyxTSPHjdWcfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joqnqOm2X1bEbJNusYPwLsFTlsi6CiQsM7UwVnFaUA+7Lqo9z7girTh5CogqCKQNk
         yNd2nIB5HJo6ghea2jDVwqkSsRRF8dTfxkPY+su1tLaOiVKgALNuZfDdnREwqVvAsN
         7l5JZBHMlV3SStaw/G9BbDr+Pq6cUMekDKp0ZmbsAeWeSDkJuYLJaVIYkSqsbIuaHg
         oV8JYwO9qWYY6R5ZCTaipaEMNuMitelE9mSiNvOX8bcm375bYSIR5D+IlRD4ftUVXU
         YOrS9H5HPtBu9YlIkonU0ESOtjGSVJkOtUoaXEeRvdVKYmxr7bF+ex53CchGY6AIpW
         TPuGebxBCjc0A==
Date:   Tue, 31 Jan 2023 09:24:47 +0000
From:   Lee Jones <lee@kernel.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mfd: qcom,tcsr: add compatible for
 IPQ5332
Message-ID: <Y9jeXzSq+ZKlla39@google.com>
References: <20230130170155.27266-1-quic_kathirav@quicinc.com>
 <20230130170155.27266-2-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230130170155.27266-2-quic_kathirav@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023, Kathiravan T wrote:

> Document the qcom,tcsr-ipq5332 compatible.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
