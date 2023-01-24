Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDFB679FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjAXRRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjAXRRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:17:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23C4173B;
        Tue, 24 Jan 2023 09:17:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CFC0612FD;
        Tue, 24 Jan 2023 17:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CF2C433EF;
        Tue, 24 Jan 2023 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674580653;
        bh=LCa2E8/jVUPBhEQJOos1nf13087EgA3kWouqC8M1bd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qkQVmWi77Ps21jD4g32ZeUQVGNomNJ/Xoe7rqHKhJrccQ7NaBHHpf5MRwjcl9V+Ih
         8kH3lnhrc8TzmXLDIzeTVAlSaNNBraJI2XdnwXUrk3WAyvLlLszqPZM8FZyt9AtgF0
         RZZnQUzPrbpGtO5ZcqQrbLMFe1rMpWjAyQC0ndTA=
Date:   Tue, 24 Jan 2023 18:17:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Lee Jones <lee@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v3 0/5] dt-bindings: usb: Convert some more simple
 OHCI/EHCI bindings
Message-ID: <Y9ASq0VZ6G7Efe7s@kroah.com>
References: <20230110-dt-usb-v3-0-5af0541fcf8c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110-dt-usb-v3-0-5af0541fcf8c@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:05:15PM -0600, Rob Herring wrote:
> The 'ohci-usb' compatible is another 'generic' compatible for OHCI, but 
> isn't documented with a schema. Let's add it to generic-ohci.yaml 
> schema. While looking at this, I found a few other USB host bindings 
> which are simple enough to use the 'generic' schemas.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Am I supposed to take these in my USB tree?

I'm still confused if you all want me to take these types of things or
not...

thanks,

greg k-h
