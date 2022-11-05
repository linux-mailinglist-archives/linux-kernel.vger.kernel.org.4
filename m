Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA4161D9D4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 13:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKEMJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 08:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKEMJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 08:09:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7D364FB;
        Sat,  5 Nov 2022 05:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6B9EB82D64;
        Sat,  5 Nov 2022 12:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B127DC433C1;
        Sat,  5 Nov 2022 12:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667650188;
        bh=+rs6Q+VjOlHj+euSJ4o9S8ikRCeAGUE9DzDvLfyibdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+FRiPsAMrVf7EpIXJlJh7YkPvn8BTHV1EBTaIlm6gPA5Tm+jylGj4zsiMqTeQfmf
         7OuurQkPK6yQGhF1IwsNT1iZcI4ZAqe+Q6M65xI67x/vPS7/4iI4MgipLHAm58wDxv
         zBV2JgGcVWi16bPr2peWGZnuNQAWEMrgsWp7zeUCMojY2U6zXGIN1gPfqseLQA3QuY
         Tsz4sfZOxqtY7s8hYse5+hF4aBUk7fOr8qkdQuDjaEPhdWKxZDpTQlOEmxButgOL4G
         sKTlY+gyq6TnY9Z+ZYyOZjCB6eTQFMoatok2csYBvhWaPjmUvHatnFZ97KX5K5S+AW
         xN+effbYPJ0pg==
Date:   Sat, 5 Nov 2022 17:39:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/16] dt-bindings: phy: qcom,qmp-pcie: rename current
 bindings
Message-ID: <Y2ZShqNfwB65lX+0@matsya>
References: <20221028133603.18470-1-johan+linaro@kernel.org>
 <20221028133603.18470-11-johan+linaro@kernel.org>
 <33b13789-33d6-a22f-82c9-4c5691d0737d@linaro.org>
 <Y1zot8aJ1WXnbrwF@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1zot8aJ1WXnbrwF@hovoldconsulting.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-10-22, 10:47, Johan Hovold wrote:
> On Fri, Oct 28, 2022 at 05:57:01PM -0400, Krzysztof Kozlowski wrote:
> > On 28/10/2022 09:35, Johan Hovold wrote:
> > > The current QMP PCIe PHY bindings are based on the original MSM8996
> > > binding which provided multiple PHYs per IP block and these in turn were
> > > described by child nodes.
> > > 
> > > Later QMP PCIe PHY blocks only provide a single PHY and the remnant
> > > child node does not really reflect the hardware.
> > > 
> > > The original MSM8996 binding also ended up describing the individual
> > > register blocks as belonging to either the wrapper node or the PHY child
> > > nodes.
> > > 
> > > This is an unnecessary level of detail which has lead to problems when
> > > later IP blocks using different register layouts have been forced to fit
> > > the original mould rather than updating the binding. The bindings are
> > > arguable also incomplete as they only the describe register blocks used
> > > by the current Linux drivers (e.g. does not include the per lane PCS
> > > registers).
> > > 
> > > In preparation for adding new bindings for SC8280XP which further
> > > bindings can be based on, rename the current schema file after IPQ8074,
> > > which was the first SoC added to the bindings after MSM8996 (which has
> > > already been split out), and add a reference to the SC8280XP bindings.
> > > 
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > 
> > Also missing cc devicetree list.
> 
> Yes, I know, but as I mentioned in my reply to Rob on the QMP USB
> series, I do not intend to repost this series unless someone insists as
> there were no binding-related changes in v4 (or v3).

It is always better to repost and get that out :-)

-- 
~Vinod
