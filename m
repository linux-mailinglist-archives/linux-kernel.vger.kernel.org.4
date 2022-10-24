Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD25D60980A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJXCEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJXCE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:04:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F5EBE0B;
        Sun, 23 Oct 2022 19:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE0ECB8085C;
        Mon, 24 Oct 2022 02:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EADC4347C;
        Mon, 24 Oct 2022 02:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666577062;
        bh=Gx54SLMLWd97CPTTomCjtwOCUWOpRCKo3+kTFErJVUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qDE7boqXUMPJj2TGaIddaR7hrpb+vFVoaSDwyDwhKloti1ETZOWsprnFW7h0u8KJ7
         KPSI149VAnNZSs1hy5yc+orDOWSHXqt4hyzlR6i8doxfBh2nDakY81Ma3Mo4sGs08e
         9SnbS0aHZQPNSRJ7W0yduz/yFQQWsfViAD78xbtoxJKvL30SqSLuMjOo3RtoNschjr
         J+/oU26qKE/gmsSfdJNsRVXNZG6AZFu121+GeqajX7OcGcuF1AE8vwTXnj48y6QdyE
         EWQdinCa1F5Rcf9JYBjA+z1YrcQ1xQyHjJx3TidKB5qyii6l0a1owmqP8ooZWn2SHq
         IyDKhjZVQPq4w==
Date:   Mon, 24 Oct 2022 10:04:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vf610-zii-dev-rev-c: fix polarity of at86rf233
 reset line
Message-ID: <20221024020416.GZ125525@dragon>
References: <Yzc0B6jNsZyQZizj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzc0B6jNsZyQZizj@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 11:23:03AM -0700, Dmitry Torokhov wrote:
> at86rf230 driver starts with having reset line high, and then drives it
> low and then high again, and even calls it "rstn" internally, therefore
> it needs to be annotated as "active low" in the DTS.
> 
> This will make difference when at86rf230 driver will be converted to
> gpiod API that respects declared line polarity.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied, thanks!
