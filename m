Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9100F710433
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbjEYEvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEYEu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204E0C0;
        Wed, 24 May 2023 21:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B902760E95;
        Thu, 25 May 2023 04:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E034C4339E;
        Thu, 25 May 2023 04:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990256;
        bh=TdfLoBzX6T1ga4COI8Ol05eLHKYAwOAAF9TAth+8sxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDbxXBfFLCALdBmLQPjuTQKThsINnX88PcJjd/6HhkGF/eXDoqWHngxdxAIhKaeaB
         c3rspGIaJrNgpQpcnipB+LMkxc6lSpQdZ/2OfCO5V6uSY5qCHlo/zNVIbJZuKlAypb
         8UtDBxK/yzX//K3vGkuYKs+l4c0V9KVn/+LgVqEJO0kP5ddXedNllUb30hL+020a+G
         XLDS3notIhZUiNWSyj36oIUndX6/qSVQ+ckLeJurG0qSsbhM9j8CNnlId5z1Ww8bAa
         DspiXTeqoZ23EsYIQ/O7ST4omgyPUcbUmbjx2wZOSMpaEuhebFxi/yZFBQYCVn62Lf
         CFS/ayNAIjwTQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v3] soc: qcom: Rename ice to qcom_ice to avoid module name conflict
Date:   Wed, 24 May 2023 21:53:35 -0700
Message-Id: <168499048182.3998961.2686790605303889326.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516082856.150214-1-abel.vesa@linaro.org>
References: <20230516082856.150214-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 11:28:56 +0300, Abel Vesa wrote:
> The following error was reported when building x86_64 allmodconfig:
> 
> error: the following would cause module name conflict:
>   drivers/soc/qcom/ice.ko
>   drivers/net/ethernet/intel/ice/ice.ko
> 
> Seems the 'ice' module name is already used by some Intel ethernet
> driver, so lets rename the Qualcomm Inline Crypto Engine (ICE) module
> from 'ice' to 'qcom_ice' to avoid any kind of errors/confusions.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: Rename ice to qcom_ice to avoid module name conflict
      commit: 47820d3263a4a7ba258fe2efe26ae5afb5b83036

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
