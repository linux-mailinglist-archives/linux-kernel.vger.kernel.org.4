Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9988F72843E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbjFHPwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbjFHPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:52:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875AE358B;
        Thu,  8 Jun 2023 08:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B675B64E9D;
        Thu,  8 Jun 2023 15:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A73C433D2;
        Thu,  8 Jun 2023 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686239108;
        bh=v0S09gxGcrr5yO3mKqprr455Yowks9jvzBXWjjD335E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNVbA2xUQfTXND2I94jmKNiVGNAwv3eiadwJrmeJIgOIr4yknjJT0/4O1RiuBeYjS
         z3WoV4QpPOnnRvewrvAE+vwhewT5Yf9EyFwoMyj7EINpiGCm+R4xaqjThd+WibKV6V
         TqQTzJx3CrWu/KeayvFj0M9NeM6ucXB8WHQFEV53ArNjNlN8BXXlTCMVmigJL32+zD
         psgLIXnOWoIqUZa9irm8QZgk1gi1ir57yVAaFLNiJfyitX1gFa+OW4NRKM811cfv2q
         h10VX79BancgY03a5EvKeOMFJ64eNXi90Ek3aDHJ45fVGkjBFAOYNFWNf0F86xJPET
         o15pX+5r6RJxQ==
Date:   Thu, 8 Jun 2023 16:45:03 +0100
From:   Lee Jones <lee@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: pm8008: fix module autoloading
Message-ID: <20230608154503.GO1930705@google.com>
References: <20230526091646.17318-1-johan+linaro@kernel.org>
 <20230526091646.17318-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230526091646.17318-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023, Johan Hovold wrote:

> Add the missing module device table alias to that the driver can be
> autoloaded when built as a module.
> 
> Fixes: 6b149f3310a4 ("mfd: pm8008: Add driver for QCOM PM8008 PMIC")
> Cc: stable@vger.kernel.org      # 5.14
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/mfd/qcom-pm8008.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
