Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6165371237C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243083AbjEZJZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbjEZJZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:25:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31538198;
        Fri, 26 May 2023 02:25:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A16E36421B;
        Fri, 26 May 2023 09:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C06C433EF;
        Fri, 26 May 2023 09:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685093137;
        bh=Xbck2y/dEVmRGDC/75EhtvzTmi0FeLabM4ueUhneLFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b1TMnOH+Ea87H0ryyLBz5HHOVVyBmm+wqi3yVU+ZP6Pqte0imfFZPO0nnSlmyyBlT
         fLgRnFuvJzKTvTAbp2ItlrRSB/woI7HyR0fWJKkCJV8+HDcrtj2vx1eDqBpw1RTPSj
         7d9KIRtTxmReJe5L02Df2cmG67GNBRJqVW8YWHoy4anxH6WFLbTEQiEw8nrDv7B37h
         DHm5jL1ZYRdRBJXmJaOJaZz1AtlIDKLyA2SYhavrh4B1/Ra+O+L0J0HZ047TF8z0Ag
         1eJY0SOkRdh/MDCQb/2XbsO7eBqEgua2gfY8sWb3SVFxntzT9eCDkaKBYEQFmFNEe6
         ZERIcphfYGYgg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q2Thj-0004cf-Vc; Fri, 26 May 2023 11:25:48 +0200
Date:   Fri, 26 May 2023 11:25:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: pm8008: fix module autoloading
Message-ID: <ZHB7Gy7RMGa41KI9@hovoldconsulting.com>
References: <20230526091646.17318-1-johan+linaro@kernel.org>
 <20230526091646.17318-2-johan+linaro@kernel.org>
 <a5891478-bf4a-8389-e1c9-00244c5b406e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5891478-bf4a-8389-e1c9-00244c5b406e@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 11:22:27AM +0200, Konrad Dybcio wrote:
> On 26.05.2023 11:16, Johan Hovold wrote:
> > Add the missing module device table alias to that the driver can be
> > autoloaded when built as a module.
> > 
> > Fixes: 6b149f3310a4 ("mfd: pm8008: Add driver for QCOM PM8008 PMIC")
> > Cc: stable@vger.kernel.org      # 5.14

> Looks like the commit referenced in Fixes is from 5.13-rc1, perhaps
> 5.13 would be more fitting here?

No, I just double checked. This driver was not present 5.13.

Johan
