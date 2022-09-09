Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0965B38D3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiIINWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIINWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:22:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17A710BA74;
        Fri,  9 Sep 2022 06:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E428F61FE5;
        Fri,  9 Sep 2022 13:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350D2C433D6;
        Fri,  9 Sep 2022 13:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662729749;
        bh=rJJ1FESy6OScB8OBsKbaugGMcKV7Z8WhZKhscbndiYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RDSdt6zc+1g/A7sfIYRWPlDC5e4rYVyOeaZD3D/4Yk5Qe1y3TjMY09jBxtXemOfsj
         mDO/9kUq01+i3NhU7i5Euecm/i0GlQvs54e6ZrD5PDjcZNpLhI9qZMCMbaRklNv+WC
         EDU2CGabAyrj29qcy5ZTDuyq/M+FRJrYNy/UD20Yee+8O7LWTTa6T14jU9GnWHkJ6X
         5xiZdEIxquovz1io3dLXe5MFsV8Y/Z3R99t31hChVxbVbfZ+qvn0vp3u/5RGuJyOA1
         7f6t/oeuAEsEysg7yw3BwqNH/6KqPYRYB+W3tSpYcIy7N4WvTy3eEWueDMV+ARU38j
         2sJZ5Hyuo/TUw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oWdxv-00025M-Bw; Fri, 09 Sep 2022 15:22:39 +0200
Date:   Fri, 9 Sep 2022 15:22:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] phy: qcom-qmp-combo: disable runtime PM on unbind
Message-ID: <Yxs+H8di+GLNRI6w@hovoldconsulting.com>
References: <20220907110728.19092-1-johan+linaro@kernel.org>
 <20220907110728.19092-2-johan+linaro@kernel.org>
 <167201e9-b9dc-5dca-ac37-b0593974ebc8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167201e9-b9dc-5dca-ac37-b0593974ebc8@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 12:26:30PM +0300, Dmitry Baryshkov wrote:
> On 07/09/2022 14:07, Johan Hovold wrote:
> > Make sure to disable runtime PM also on driver unbind.
> 
> Nit: technically the subject is misleading: you switched the code to use 
> devres- helpers rather than manually disabling the runtime PM.

I disagree. I'm summarising what the patch is doing, not how I
implemented it.

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Johan
