Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665115FC56A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJLMfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiJLMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:35:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6807027CDF;
        Wed, 12 Oct 2022 05:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14EC6B81A88;
        Wed, 12 Oct 2022 12:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32A1C433D6;
        Wed, 12 Oct 2022 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665578119;
        bh=P1sBFZ5OfQ3xulKkj/ktcKq5OmyfyAwZboKPGajaiIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JCu8ojD/4ZuqUvqQwYzussHK7WszyvO+WxymQNq0453fLTWCA2vXd3m02RFuPve73
         nq9vauPqKJv2B9IRAjdOr4AA4iUOj7s5eZXlCP+nyO0jVDC2U9DrtmWS4+q2eclNhy
         e5/dy8tR8p9T3g59BwfeLW22IIiC8Z9+Vvle1fuJCgmgD+e6JE1DMdQeUJqnwfBEb5
         rv13pNqiZd86Q4fpnp0Davc+kDKrV+P7NKkPUQhvBNUCMD+q5dULKfgpMc5hDmeF9E
         PtmQPkvV8iAvZHP4ARMV1ZHsAIjVM+LGC0Tv/9HWk4zhOubJb6m75ZA3fFJ/o6pYqg
         6yNR/Zgwt5Eyw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oiawz-0008Ev-Ll; Wed, 12 Oct 2022 14:35:05 +0200
Date:   Wed, 12 Oct 2022 14:35:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] phy: qcom-qmp: further prep cleanups
Message-ID: <Y0a0eYNrexI8uwfn@hovoldconsulting.com>
References: <20221012081241.18273-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012081241.18273-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 10:12:27AM +0200, Johan Hovold wrote:
> Here's the next batch of QMP cleanups in preparation for adding support
> for SC8280XP and its four-lane PCIe PHYs.
> 
> Note that these apply on top of the following two series that have been
> reviewed and should be ready to be merged when the PHY tree opens:

I forgot to mention this series:

	https://lore.kernel.org/lkml/20220928152822.30687-1-johan+linaro@kernel.org/

which has also been reviewed but did not make it into 6.1.

> 	https://lore.kernel.org/linux-arm-msm/20220929092916.23068-1-johan+linaro@kernel.org/
> 	https://lore.kernel.org/all/20220927092207.161501-1-dmitry.baryshkov@linaro.org/
> 
> After this I have one more series of related cleanups before posting the
> SC8280XP support.
 
Johan
