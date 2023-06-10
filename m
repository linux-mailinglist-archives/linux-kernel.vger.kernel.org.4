Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3513272AE04
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 20:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjFJSBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 14:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjFJSBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 14:01:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6EE35A7;
        Sat, 10 Jun 2023 11:01:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DFCE61A27;
        Sat, 10 Jun 2023 18:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8F5C433D2;
        Sat, 10 Jun 2023 18:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686420063;
        bh=biYrgToGst6xjxcYYrSzkA+d1kchkIsGEDdT2rnJiNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FR+BRLRetNvogHjqPpJ5EXa7YWINouiHbh/Byt2KLW3YknsiJ5Zy76nt/TiUxIQWG
         1PiBF0dDvlH4rGuEPw2akmviCBhvH3xegFFKnWs0vPxVImOwl6Yq/iqBU7zEGJ3lrv
         fOBZmotk3k70Nf9G3H+IKL1HHTvyiUsJVAIV5lrwmIf+eRDiVBzfSiTBS2teHSWbWC
         dud20dgbcS7AousQ49UwzptKVltIX1EtNXwAgwUY8bNtif2CGe5dRP88bwdYd3F30h
         gtauZ6Kz8OgyKdbhFPVN2BKoB+swRWJDR36dxASq4XrIFly/L4b128n8vljwzOVaz+
         FqhMCTt+rydiQ==
Date:   Sat, 10 Jun 2023 19:17:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <Michael.Hennerich@analog.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: max14001: New driver
Message-ID: <20230610191724.7455734b@jic23-huawei>
In-Reply-To: <20230608175517.40217-3-kimseer.paller@analog.com>
References: <20230608175517.40217-1-kimseer.paller@analog.com>
        <20230608175517.40217-3-kimseer.paller@analog.com>
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

On Fri, 9 Jun 2023 01:55:17 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> binary inputs.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
The driver initialises a regmap then doesn't use it.
Fine not to use it, but get rid of the setup code, structures and include
as well. I assume this got forgotten after testing the code worked when it
wasn't used.

Other than that looks fine to me.

Jonathan
 
