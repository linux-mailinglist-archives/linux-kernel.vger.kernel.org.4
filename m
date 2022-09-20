Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38245BE829
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiITOJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiITOIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:08:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD6A520B9;
        Tue, 20 Sep 2022 07:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC3D362A38;
        Tue, 20 Sep 2022 14:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D617C433C1;
        Tue, 20 Sep 2022 14:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663682919;
        bh=hBWGuLHbJhISwXVp5Y2WWvwMfSnoyTJ0CuMkDeoWT44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ziq1dFWSBH9MPMpoyS3G6lV8819jF++Hoxe5HsBdvjiFOSJtCGF+XBYT4KyEttGGt
         n+FlIaeqIN6dPSZrQtU+lZZJXO3KdyWZTRVfqWop3wT47PzcDGb/8AVFtmwldl81oJ
         DdRQkwX5Lf0F9dvkWKxhYZ0NOJWhNnj0wWgWJRWMzSb74l+50Oj57iETGCodM8qLQA
         DRS5yZH6jm46RxdU3Sccp+zy57fBbF07j9qB4hKcW0Wk63tvAWnYlykhtrvLn2cpwH
         Kum8H1oIrUlok9FYm4Cma292fRhIyYEV/LvsKPMCVbMQCkx0XpNJx/7T6Clgq6dg8p
         pO/dgo0AwI9OQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oadvW-0000Bs-1B; Tue, 20 Sep 2022 16:08:42 +0200
Date:   Tue, 20 Sep 2022 16:08:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] phy: qcom-qmp-combo: drop redundant DP config flag
Message-ID: <YynJatNg2Cfa8ix4@hovoldconsulting.com>
References: <20220920073826.20811-1-johan+linaro@kernel.org>
 <20220920073826.20811-18-johan+linaro@kernel.org>
 <66450c6b-6435-e537-2268-c6fc97d92824@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66450c6b-6435-e537-2268-c6fc97d92824@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 03:52:23PM +0200, Neil Armstrong wrote:
> On 20/09/2022 09:38, Johan Hovold wrote:
> > Drop the DP_COM control block flag from the configuration data, which is
> > set for all combo PHYs and hence no longer needed since the QMP driver
> > split.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks for reviewing, Neil.

Johan
