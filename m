Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6D261172E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiJ1QNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiJ1QN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:13:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF1163F3B;
        Fri, 28 Oct 2022 09:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 74A9DCE2C27;
        Fri, 28 Oct 2022 16:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A27C433C1;
        Fri, 28 Oct 2022 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666973412;
        bh=UpjgFXWLdClvg90SKzBbXOWn0TxzW7/wabW66Ubp1QM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7kkAmfe8cDl+/oZoJOJY9Ytix1b+W4TrGXdNCIm5TI7FvzaaLkLfcpLYivHJuAlL
         PROK9roAnNak2Xk0MUZQDicxSn8NZUVC//z9vP5SNHDB4VtIPIw5bIccaAxCOfdV/T
         DzYd+5qlnwK8UIO98QljqK8xeLaula1Auc5uR5KDOAmsu5OOPzzr77gX3TsldoAJQ+
         T4tOjyP+n3PCFKX1y3D5+B8p9RDXpQboXiMRF9m7brSmqNSJafx4xU7fRKO4QmlPTx
         RwKu3NsmtxgE7sDF73AOvrwz8NMc/dWtgJZLUspqOmE6+OZCfJ/0FRlDQ/D1AgRuKD
         nKw+Y9Xxh31DA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ooRvi-000789-Tn; Fri, 28 Oct 2022 18:09:58 +0200
Date:   Fri, 28 Oct 2022 18:09:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/13] dt-bindings: phy: qcom,qmp-usb: fix sc8280xp
 binding
Message-ID: <Y1v+1gXaipKQqYOo@hovoldconsulting.com>
References: <20221028134407.19300-1-johan+linaro@kernel.org>
 <20221028134407.19300-12-johan+linaro@kernel.org>
 <CAL_JsqL+8OXb_0qE20wA-+Dkjqx1UjDTXiWG2CKp7=GkKeis0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqL+8OXb_0qE20wA-+Dkjqx1UjDTXiWG2CKp7=GkKeis0A@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 08:58:24AM -0500, Rob Herring wrote:
> On Fri, Oct 28, 2022 at 8:44 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > The current QMP USB PHY bindings are based on the original MSM8996 PCIe
> > PHY binding which provided multiple PHYs per IP block and these in turn
> > were described by child nodes.
> 
> Missing the DT list, so checks don't run and it's not in my review queue.

Sorry about that.

I've resent this series now as it has some minor changes to the binding,
but I believe the corresponding PCIe series should be good to go without
a resend (bindings reviewed by Krzysztof and presumably already
processed by the bot).

Johan
