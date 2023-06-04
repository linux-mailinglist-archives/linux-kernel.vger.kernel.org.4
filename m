Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E0D721663
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 13:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjFDLgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 07:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDLgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 07:36:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AF4AB;
        Sun,  4 Jun 2023 04:36:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 736E56118F;
        Sun,  4 Jun 2023 11:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FFBC433EF;
        Sun,  4 Jun 2023 11:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685878563;
        bh=0myt3UxTk1I9zCzwV7nwnIdFYp/I1R9+TK/H8JDJTck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aa3e/cR706d/Eg7+N3OFye6Y+X1X26nutxKi9oQKeFVUk+ksPrEytw2+iAEdguPn1
         VQezRvBc6MNfCqoHHOOVBtGdnnRisfOPAPG/YJe8K6hAyZQ5Ol5HZ0JcW24ltIdjH/
         PQc91cF4UAzr+yq1KkFG/x3M5DWKpcZkgdrsOfgMLXuHNSWSbeYhR6N/saeCIkci1j
         DAs2RoJ2Nh2D5ZDPA0Qlis8gYrGhzPXRupXXggAQKp1lvd8/b306dCk1K2RNUxEjNq
         3r+xTySLz5LDMtk8rc9zuvm/8Z/mE4gToOKG9QUFP82jomo0B54Qt0F0Qc5VjOMqDq
         zpSB8FAyfh8qw==
Date:   Sun, 4 Jun 2023 12:35:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     fl.scratchpad@gmail.com,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: iio: ad7192: Add mandatory
 reference voltage source
Message-ID: <20230604123559.4aab8de7@jic23-huawei>
In-Reply-To: <20230530-spoils-cod-c606ff33e75a@spud>
References: <20230530075311.400686-1-fl.scratchpad@gmail.com>
        <20230530075311.400686-5-fl.scratchpad@gmail.com>
        <20230530-spoils-cod-c606ff33e75a@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 18:22:45 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, May 30, 2023 at 09:53:10AM +0200, fl.scratchpad@gmail.com wrote:
> > From: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> > 
> > Add required reference voltage (VRef) supply regulator.
> > 
> > AD7192 requires three independent voltage sources: DVdd, AVdd and VRef
> > (on REFINx pin pairs).
> > 
> > Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
> > Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
Applied.

I'll leave 3 and 5 for a v4 posting.
> 
> Thanks,
> Conor.

