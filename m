Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBF361DA8F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 14:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiKENTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 09:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKENT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 09:19:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D1FDF45;
        Sat,  5 Nov 2022 06:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22181B81CD0;
        Sat,  5 Nov 2022 13:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7D8C433D6;
        Sat,  5 Nov 2022 13:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667654365;
        bh=n978bdZclo1OUqgWipKVcYfrpp2oIPsYbXjMUSCLzwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=krMh5ThZKLX5Tes9Y3K/uXBT2Ll9Gw2n9lCBLhGo5GK28z+kbMBpMwH37LFRYJXWL
         Fa3mpSbdi1LlKhbtkMXwhE8YqVSi0yeGkRUzTnoZU+M8KGJHDFE+np/9sjYfbtkyLf
         p3D0rr0Pm7hG+h+afcUcmw8RuzYVIgyULiGM2KL4JXQm+vJn65nPBUR7NR8mib2sRL
         iG/TCm+K8l7vUhCmvbhuB+t/XGSVIxtoXJ8JFqyP69evAH6cWccPRfjMrDUjK7F7Wo
         RZzvnKHGQWzHLrizdSdO4UzfYlyVYb6vHPOYFmPXQoEjg3sovEdLyd37u+DaxNbNIE
         qsoipVHk3/Seg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1orJ4j-0007Bh-Us; Sat, 05 Nov 2022 14:19:06 +0100
Date:   Sat, 5 Nov 2022 14:19:05 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
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
Message-ID: <Y2ZiySD7vaJAbUO1@hovoldconsulting.com>
References: <20221028133603.18470-1-johan+linaro@kernel.org>
 <20221028133603.18470-11-johan+linaro@kernel.org>
 <33b13789-33d6-a22f-82c9-4c5691d0737d@linaro.org>
 <Y1zot8aJ1WXnbrwF@hovoldconsulting.com>
 <Y2ZShqNfwB65lX+0@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2ZShqNfwB65lX+0@matsya>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 05:39:42PM +0530, Vinod Koul wrote:
> On 29-10-22, 10:47, Johan Hovold wrote:
> > On Fri, Oct 28, 2022 at 05:57:01PM -0400, Krzysztof Kozlowski wrote:

> > > Also missing cc devicetree list.
> > 
> > Yes, I know, but as I mentioned in my reply to Rob on the QMP USB
> > series, I do not intend to repost this series unless someone insists as
> > there were no binding-related changes in v4 (or v3).
> 
> It is always better to repost and get that out :-)

Yeah, it's just that I was expecting this series to merged the same day,
and I didn't want to spam the list in vain.

Johan
