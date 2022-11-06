Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4AA61E1F3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 12:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiKFL6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 06:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiKFL6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 06:58:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82104B7D2;
        Sun,  6 Nov 2022 03:58:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4113AB80B56;
        Sun,  6 Nov 2022 11:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F55CC433C1;
        Sun,  6 Nov 2022 11:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667735911;
        bh=cTtPRH7ZyC8b8Z48VH1fn2uIiHq+Pe0IFFKV797KoCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qPBTwUdmzJziKrhm3/oHkKrrTljFoEDoo1SRRTu2yHkHd4xf5hmV0g/H0l5LC8ceW
         goI7iCspHoqEplCH61kcJ7tDRK7hq7ruU2ER01/oAoyBEG/p06ZH0nsBLe0NZxLHeq
         avvnz7PSrz/A7qE3JB3VJi3YhSfujtlKg1+VX5kryajs7/w56yK5w79sNj+s1lmCXS
         dJMWqfJ1RImkixlE01EozrD+xAl8jq+oTY7/vEm5qTA+aXas3c2qKeOH/86t+vBHma
         2hechTIzyHcclasHuyggjzjrUnkvsepg6ieDqpXlHjBS7rzYTyvF+hnkcEATVwHGH/
         VjXnIVwgYrJog==
Date:   Sun, 6 Nov 2022 11:58:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: qcom,spmi-vadc: simplify
 compatible enum
Message-ID: <20221106115821.664fc3d5@jic23-huawei>
In-Reply-To: <166723402653.2979037.13977255259751466976.robh@kernel.org>
References: <20221027143411.277980-1-krzysztof.kozlowski@linaro.org>
        <166723402653.2979037.13977255259751466976.robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022 11:33:47 -0500
Rob Herring <robh@kernel.org> wrote:

> On Thu, 27 Oct 2022 10:34:10 -0400, Krzysztof Kozlowski wrote:
> > The second compatible item in oneOf is just an enum, not a list.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml  | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>

Series applied to the togreg branch of iio.git.
Initially pushed out as testing to let 0-day poke at the whole tree before
I make a mess of linux-next.

Thanks,

Jonathan
