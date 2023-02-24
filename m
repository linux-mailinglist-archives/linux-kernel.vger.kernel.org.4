Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350F76A18AA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBXJYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBXJYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:24:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623E160132;
        Fri, 24 Feb 2023 01:24:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24C07B81BE0;
        Fri, 24 Feb 2023 09:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87F6C433D2;
        Fri, 24 Feb 2023 09:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677230677;
        bh=JTlnceaMAn4H4iP52lMgGtEKORtQS2pIE1OgoKHtH70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0SnnPEB9P7u/XrrEaaj4ngWoTVK+LbZYKwmiKVwik0UlY/j92e47u15eUBezSasE
         JRpEU6EDLZwrTLMsjLjbgbmwf6F2ZM0G39mIcpMdJwAQP0u9l8LglNnspzlAV6X4+9
         cnbw8yQx/Rrn7ULq2BIbkcP7cFq/CMZUheKMCm9YbPnmR6si3ynw3VraRHB91RX7RM
         Whr2X58fVheKV91vkWk79IrtFX9MFnalwzArxR5Fz3QHUjdkNXgLJr86fS6SSVMehy
         fshjbZohaOuONv7iiluA9ksW1jd8bbPfvBLsLZVFH3ghSH2w0aHU7QAYGSReHyRBnc
         OXtwkvTuB1H/g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pVUJs-0003wL-JT; Fri, 24 Feb 2023 10:24:48 +0100
Date:   Fri, 24 Feb 2023 10:24:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 16/22] dt-bindings: rtc: qcom-pm8xxx: add nvmem-cell
 offset
Message-ID: <Y/iCYA3xQEE4w2Th@hovoldconsulting.com>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <20230202155448.6715-17-johan+linaro@kernel.org>
 <Y+bJqIpgZ0fbzL2b@mail.local>
 <Y+dQXlABqc/uzIXc@hovoldconsulting.com>
 <Y+fF94EOkUuMq9Fc@mail.local>
 <Y+0NiJsp4JjeyrqH@hovoldconsulting.com>
 <Y/hzcxrS3D0O3s9U@hovoldconsulting.com>
 <Y/iA/sQh/p9980qQ@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/iA/sQh/p9980qQ@mail.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 10:18:54AM +0100, Alexandre Belloni wrote:
> On 24/02/2023 09:21:07+0100, Johan Hovold wrote:

> > Looks like these last two patches adding support for the nvmem offset
> > has not been applied yet. Still hoping you can get them merged for 6.3
> > even if this one does not apply cleanly unless you first merge your
> > rtc-fixes branch.
> 
> This is still my plan, I'm travelling right now but they will be sent for
> 6.3

Perfect, thanks!

Johan
