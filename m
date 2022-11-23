Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5C9636B94
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiKWUvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiKWUvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:51:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A36A75A;
        Wed, 23 Nov 2022 12:51:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 400B861F14;
        Wed, 23 Nov 2022 20:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75623C433C1;
        Wed, 23 Nov 2022 20:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669236662;
        bh=u+jIA5bbyqfpJJg8KeTP4XjS+uwsLl+fZhCYqeb9d30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dPkETCDg/A3l8WzvE9vechnqBRke16ndcE/g3VExKScZPKvcaxccmNmo3JqG3ivar
         VbqpqiA1D4iRMrRx+CAR9n4wT54LmHcpqP4yKq0xyK8ThNWNmn3ICr+dW0r2ijX4nt
         uMSGUSeMaN7UFcP7Arp04xIuRjavFWHfpWDY2VTL18ThGXkrvRu941511O+CQ3afgj
         ywZokUg99sz4SA/tgZ9VWZ5RI6i4V9K2Jk29GNd90qvsedccC85OubHcLQOUfORsWG
         tUE3/Cwj1cGmCakw+RB5Uuajbm6JX6l5aWFa4+tsX/bJ9KjAttplR0QJ5s/OZd2BsB
         UUGTNLVwiZIsg==
Date:   Wed, 23 Nov 2022 21:03:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Cosmin Tanislav <demonsingur@gmail.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH] dt-bindings: iio: temperature: ltc2983: drop $ref for
 -nanoamp properties
Message-ID: <20221123210334.010003b8@jic23-huawei>
In-Reply-To: <20aab566-081f-962f-2966-1011b337edf6@linaro.org>
References: <20221115151653.393559-1-cosmin.tanislav@analog.com>
        <20aab566-081f-962f-2966-1011b337edf6@linaro.org>
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

On Tue, 15 Nov 2022 16:21:13 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 15/11/2022 16:16, Cosmin Tanislav wrote:
> > Currently there are -nanoamp properties both with and without a $ref.
> > dt-schema has been modified to handle it as a standard unit, but the
> > change has been reverted since there were still occurrences of
> > -nanoamp properties with a $ref.
> > Remove this since it's the only occurrence left.
> > 
> > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>  
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof

Applied
> 

