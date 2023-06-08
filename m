Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4622572843D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbjFHPwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbjFHPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:52:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D6D358A;
        Thu,  8 Jun 2023 08:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 613D460A6B;
        Thu,  8 Jun 2023 15:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8537BC433EF;
        Thu,  8 Jun 2023 15:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686239137;
        bh=xr/6q7JnC4tzY4zxwZyZW4Vxn/knhMtm376LLUDt7M0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3KP6VIMrM5igWkAGoGMjLww5WtcfxmHXuXNQkXvsa03LIa3irFcOaz/cyBfWgXEk
         gTcwDNkZjUBXpDCTk+gG0MXdOPDPfpNCaOFT7VdLuLKA3o/MXm02zF3M4Gxe99ZJ55
         xB9fhIfshUtKUmGwsoOwSwEczPAIdmJD7w+Myobkg9YDkW8CO0aYSW38Wr4JUGj4zb
         GPbC3YlqIqxOoqy4VEIqJuKojixsfDB84wusGCuYFKjza3eVB2D3x+CsPQdWQ1Uv6z
         jEkYlj8A5tGUozee+U21GaAfvx97zicGdZygI0QKLi6AlRzOO791XUSUYx5AACrrAQ
         bxcg1+IFykdmQ==
Date:   Thu, 8 Jun 2023 16:45:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: pm8008: drop bogus i2c module alias
Message-ID: <20230608154533.GP1930705@google.com>
References: <20230526091646.17318-1-johan+linaro@kernel.org>
 <20230526091646.17318-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230526091646.17318-3-johan+linaro@kernel.org>
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

> Prior to commit af503716ac14 ("i2c: core: report OF style module alias
> for devices registered via OF") drivers using OF matching needed an i2c
> module alias such as "i2c:pm8008" for module autoloading to work.
> 
> Drop the bogus i2c alias from the pm8008 driver which was merged long
> after i2c core was fixed and whose alias did not match the driver name
> ("pm8008") to begin with.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/mfd/qcom-pm8008.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
