Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D46D705066
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjEPOT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjEPOTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:19:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78FE8697;
        Tue, 16 May 2023 07:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57FB662668;
        Tue, 16 May 2023 14:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31991C4339B;
        Tue, 16 May 2023 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684246746;
        bh=MJyyMP9np2jIc+G+hDnN3CRXHy4kHK0ZP6EHijXOVLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXHvxvexi0ZmdqcvRgvYHTDu5IJRm9UvjO7sPnzF+4wmJhziuotbq5oeR+Hi84NAV
         uEf0XJ0ou4d/OIjq7iu4/83hZXCPDi014OjGrdL/QLtarRLbrdEq87+qoXlP8as7Ti
         DT27nFb//dLi8oGeGi7fmedcWcYgZDXUfiBnseInTyBbbDUgmKY7VbToq8OrUiK4GN
         vi7K0sy7VlBIfHMkjU6PLDnrRslE9nTfpqk79HhL/CCiwA6sdWCiT6d68dHTd+tEWJ
         Z6Swj2agkMwRBEDAzKOaJ/KV1Ft5p5LW3lPJTuuis4aJLNio1E5hGZredLEjWy20Zm
         oIOfJwRFlBLDQ==
Date:   Tue, 16 May 2023 19:49:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom-snps: correct struct qcom_snps_hsphy kerneldoc
Message-ID: <ZGOQ1nCT54+i/4i7@matsya>
References: <20230507144818.193039-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507144818.193039-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-05-23, 16:48, Krzysztof Kozlowski wrote:
> Update kerneldoc of struct qcom_snps_hsphy to fix:
> 
>   drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c:135: warning: Function parameter or member 'update_seq_cfg' not described in 'qcom_snps_hsphy'

Applied, thanks

-- 
~Vinod
