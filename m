Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB0E637D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKXPdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiKXPdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:33:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A98E676F;
        Thu, 24 Nov 2022 07:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32CE96219E;
        Thu, 24 Nov 2022 15:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC7AC433D6;
        Thu, 24 Nov 2022 15:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669303998;
        bh=Ir4muPjBKsPcyktJyw/fUL6Kv3BECljIo7S6hUAHENk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9lQnAte63QviEpIGUt8Q7smUNS5lfe3WHwPlg1V8bDYXgMGcpkX0dQN6oO26ve0V
         rM/0u6oDkhwzf7u1mJcjgXbgZCtlvkxBdRHnzMxdlaA0vTCiyDjd3BSXOdaqSdMW2g
         OMcxqV4whlN/HG4x+Ve8KG9SluJr9GzjsEWwz96SP7hsTnPJYaya92Tc1bb0CXwfaY
         NL0ZGZd4+Fl1xpFkRqvTNylTdl17+zi7qCjkBcyM1xewuipMDslaFiNeatoLpQQwUU
         JjlRWYobqNAmk9Auc98xmhN1CWFurD4fnYgqx8qmpYTt1maOjYqb3jR+n49nPyjWfI
         S8RcftBzeN1AQ==
Date:   Thu, 24 Nov 2022 21:03:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] phy: qcom-qmp-combo: preparatory fixes (set 1/3)
Message-ID: <Y3+Oupd55ZEEX+jx@matsya>
References: <20221114081346.5116-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114081346.5116-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-11-22, 09:13, Johan Hovold wrote:
> Here's a set of fixes for bugs founds while fixing the devicetree
> binding and adding (proper) support for SC8280XP to the combo driver.
> 
> The full series is over forty patches and I'll be posting these in three
> parts of which this is the first. In an effort to get all of these into
> 6.2, I'll also be submitting all three series before waiting for the
> previous ones to be applied.
> 
> The first fix below could possibly be considered 6.1-rc material, but I
> believe it's be fine to take all of these for 6.2.
> 
> Note that the next part of the series will do away with some of problems
> with this driver that led to the issues being fixed here (e.g. the split
> driver data and configuration).

Applied, thanks

-- 
~Vinod
