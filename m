Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619D35E888A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 07:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiIXFaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 01:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiIXFaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 01:30:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BEA3AE54;
        Fri, 23 Sep 2022 22:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C3C7B8068A;
        Sat, 24 Sep 2022 05:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E8DC433C1;
        Sat, 24 Sep 2022 05:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663997416;
        bh=BCAUYNRKpCOGEQXu8iXQX164n+AhNyK7/OpgVHVpwOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EptptaZF4WpLNcwDZXFXphG6G3x+VQyN0EWz8bFQoBXHqWKOKlS9EyG+XGWsZoMGg
         YaimzxrwyTbhAx+Xo7W0fTzuna64sQJ0Ml6/bGFkQOylJfqiMG/6iTEmuPUTApKLCA
         ZOmF1dpxtlkpzY37Mf2PQC8baS0NBg+ZOw6iYPIR9drDxLwg0YeMkVMwj5jrBErDe3
         2jv0UbmfdTvFj4R4q1WKhQv8gJjzJ7Ox7YhSnGnrGXqOjfJP18HpSLeXuVZ/f9SFWb
         HsYH1wxswIM/PNqYL6IhghpKqoF9y/f0fJ5r/tYKoBOnp8ABiXk+rW+g92DHxzQMaj
         QFC7RRij0Wi4w==
Date:   Sat, 24 Sep 2022 11:00:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] phy: qcom-qmp: config and misc clean ups
Message-ID: <Yy6V40CiYMEPoZv1@matsya>
References: <20220920073826.20811-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920073826.20811-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-22, 09:38, Johan Hovold wrote:
> Here's the next and hopefully last set of QMP driver cleanups for a
> while.
> 
> These patches drops further configuration parameters that are unused or
> redundant since the QMP driver split.
> 
> This notably includes consolidating the lane configuration, which for
> legacy reasons was inconsistent.
> 

Applied, thanks for the cleanup!

-- 
~Vinod
