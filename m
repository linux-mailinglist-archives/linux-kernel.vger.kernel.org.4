Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBF15EEE1A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiI2Gxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiI2Gxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:53:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F7312F75A;
        Wed, 28 Sep 2022 23:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF1CF6204D;
        Thu, 29 Sep 2022 06:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120D8C433D7;
        Thu, 29 Sep 2022 06:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664434420;
        bh=LFweTsO4MnTTYYrLm4uANYodqTvLuM/O38rajPJjUpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/jcWnHlQGeqx5DFF4DF/OjeOleao/Vk935sILJGHluqLfPzeo4l3jeTBxAulB4FE
         9e8M9k/uJ8QD2dZ85kfG0g9RgE/4cv2AycD1OlaOJRobQ1c//7zJFzmbGTxpRpML1H
         dBN2tLdinznd2cg5J6okc7aDlT7QXTnP/kJ3BhOUL7XXoSaM3zbxVDM7ZBmoEq+53X
         2+dAYFVVA/B3il8VrZs54V+acYS1noEI7d2kFvjbvWLuw4Ufg98zmJAGNYL8KXjBqB
         CXKFJGh7ITHCZi9MSO7PG3AVBxsc8uGY0EqC/fqrRkipAl/eGJLfDS+WWRTxxe0UpV
         L0kXxwWip2wSQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1odnQY-0006Nf-6k; Thu, 29 Sep 2022 08:53:46 +0200
Date:   Thu, 29 Sep 2022 08:53:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] phy: qcom-qmp-pcie: unify ipq registers
Message-ID: <YzVA+rJY8I1xMwhN@hovoldconsulting.com>
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-5-johan+linaro@kernel.org>
 <CD3050AE-693F-4AD7-9F1E-016E2AB1DF99@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD3050AE-693F-4AD7-9F1E-016E2AB1DF99@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 08:34:37PM +0300, Dmitry Baryshkov wrote:
> 
> 
> On 28 September 2022 18:28:13 GMT+03:00, Johan Hovold <johan+linaro@kernel.org> wrote:
> >The IPQ register array is identical to sm8250_pcie_regs_layout so drop
> >the former.
> 
> I'd not do such merge. They belong to different generations. I'd
> suggest changing these arrays to use symbolic names defined in
> corresponding qmp headers.

That could be done too, but this is not how these drivers are
implemented currently. Whenever the resource lists match, they end up
being reused. These values need not even change between revisions.

Johan
