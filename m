Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0706E9073
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbjDTKj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjDTKjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:39:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A9B19B4;
        Thu, 20 Apr 2023 03:37:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0C5961518;
        Thu, 20 Apr 2023 10:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8F4C433EF;
        Thu, 20 Apr 2023 10:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681987061;
        bh=irIU68TcV1yMUBP/LKJhStaIl6jVDYhAMhhYqnF1eW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=omLgnpysdHVrU2VELnr+Wq6EVXsIuE6bnDWe5Te9H5bYjA5MKKrcQtyZdYEhylgc0
         apTMvsMuV++GALQgMJa30CSJbCmATJOYMwdB9oa57KYsdg+Xy67IrdDwYhFQ8OReNA
         LoA+dnm+c/Y4ygXAvSdjzk964hU2WQX0+QG+8xVW6P/9QiOejsffd5vZrix524h7sJ
         gXh34cg6vIR0Cst31cCITkcwPAI5CG/zjdI6wNZNP8Iaf2zkh70jxXJhOkdL9dpLJA
         +TJd2gQt/6J8e7N/R6GK1WlTYW+uLEyJD5qFQntL3O9C/+bhUUpf0Aim0E5zxyvQ66
         WapKzR7cXu9XA==
Date:   Thu, 20 Apr 2023 11:37:35 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] dt-bindings: mfd: stm32: Remove unnecessary blank
 lines
Message-ID: <20230420103735.GK9904@google.com>
References: <20230417181342.v2.1.I483a676579cc7e3ac07e1db649091553743fecc8@changeid>
 <fde49fb8-c337-3a6b-811e-b9d7c3620393@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fde49fb8-c337-3a6b-811e-b9d7c3620393@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023, Krzysztof Kozlowski wrote:

> On 17/04/2023 18:14, Patrick Delaunay wrote:
> > Remove double blank line.
> > 
> > Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > ---
> > 
> > Changes in v2:
> > - update commit title and commit message to reflect what the change is
> >   V1="dt-bindings: mfd: stm32: Fix STM32F4 DT include fil
> 
> More than one file has the same issue. This is quite a churn to handle
> such patch one by one. Please fix all of them or just skip, as it is
> harmless.

It was easier to just apply it this time.

-- 
Lee Jones [李琼斯]
