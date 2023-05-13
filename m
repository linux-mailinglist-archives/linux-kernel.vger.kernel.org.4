Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F66470193C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjEMSeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEMSec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:34:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355B81FDA;
        Sat, 13 May 2023 11:34:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D4FC61D6D;
        Sat, 13 May 2023 18:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4039C433EF;
        Sat, 13 May 2023 18:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684002871;
        bh=1G6HrXzM7Id2ujGj9Oq8Pmzskf+4RRUT5zQBHJ8W0gw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=caQnOqYsRwRdfuYAs/4x6koWVCac4R4fM8w3ZQCCG3q7t0WBUMAxfqq5BTrK2FMSZ
         PngBF46Dn0+8zqFiC7mz83QgX26+4PgpqCW/4wewTb/6rurIrS4h1AuSaP591NfZtx
         l1cEgVItGt5cbgQIxSwx06AMere1SDLrm1ROk5fY2hqjFODQpb5+e65uxiuj/YbD8a
         azAG8aRxU4zOc0m6eYvgEwN1cMl1cxq1DTFw379J0CE1IvmdZKz/w/8lBcvanQ3obC
         Db2uCOLaBFdyQ1dRXT9jKLDW2+4OGdaXTvo9Egd1qauK1/E9HEat9bX5y3i3rlsbMT
         DUd88t1ZWQyDA==
Date:   Sat, 13 May 2023 19:50:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, broonie@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: temperature: Add DT bindings for
 TMP006
Message-ID: <20230513195030.57b7939e@jic23-huawei>
In-Reply-To: <4d18eb55-a44c-4033-93cd-35c02cb179b3@linaro.org>
References: <ZFvo2TIiPiMFlbXC@yoga>
        <fc104fdd-3894-aa94-12dc-4c73b26d4159@linaro.org>
        <ZF08pzGPyReL1uAf@yoga>
        <4d18eb55-a44c-4033-93cd-35c02cb179b3@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 08:28:29 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 11/05/2023 21:06, Anup Sharma wrote:
> > On Thu, May 11, 2023 at 11:28:50AM +0200, Krzysztof Kozlowski wrote:  
> >> On 10/05/2023 20:56, Anup Sharma wrote:  
> >>> Add devicetree binding document for TMP006, IR thermopile sensor.  
> >>
> >> Why? Where is any user of this? DTS? Driver?
> >>  
> > 
> > The support for TMP006 is available at driver/iio/temperature  
> 
> There is no such compatible in the kernel. If you add OF support, you
> should change the driver.

(Very) old driver, so it uses the fallback method that i2c provides to bind to
the compatible with the vendor id dropped via i2c_device_id entry.

Having said that, I'd also prefer the addition of an explicit of_device_id table.
As there is only one supported device in this driver should be trivial.

Thanks,

Jonathan


> 
> 
> Best regards,
> Krzysztof
> 

