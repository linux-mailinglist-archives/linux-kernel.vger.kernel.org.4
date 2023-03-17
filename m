Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8315D6BE2BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjCQILG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjCQIK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:10:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3FDC5AD3;
        Fri, 17 Mar 2023 01:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C831662213;
        Fri, 17 Mar 2023 08:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396C2C433EF;
        Fri, 17 Mar 2023 08:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679040601;
        bh=sruFD8cOATTc8+Gs52t1su3ztc8CQQ3I4J3wKKez8UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=urr/RkFZMCKAyid/VYR9klL04EIKbhS97k5e9SgHyayct82+iVTFhq6qmzFPtNt7Y
         3QcYhmowA/eiY1FQKWCKKXbQTlYG9+F3wLCq1wjcsAOmJzD7R11o9TzXyKm16af4Qd
         Rcthh8WaDeFgyYRULxX/FaGyeOSRrySnLu2ScWRY2+2ahlUlHaLbTmoUsf5NwqerD4
         d/koC+98yKiANKjxkh44I2MElgt0chb23b2rkCOgPtM2gWdA0PtUWP63TBtTuNAshS
         Xi6GldGPaQNhwp7e+JJQZlANdzSCBynaPfhI2ZwKEVyjnDB7+IgI1c9V8Qndc7ilxv
         Kq3GWymsBnFOw==
Date:   Fri, 17 Mar 2023 08:09:56 +0000
From:   Lee Jones <lee@kernel.org>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: add binding for aw200xx
Message-ID: <20230317080956.GG9667@google.com>
References: <20230314120252.48263-1-mmkurbanov@sberdevices.ru>
 <20230314120252.48263-2-mmkurbanov@sberdevices.ru>
 <20230316164031.GX9667@google.com>
 <d0d9dbe3-ed4c-9212-e145-8fb8eee956ba@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0d9dbe3-ed4c-9212-e145-8fb8eee956ba@sberdevices.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023, Martin Kurbanov wrote:

> On 2023-03-16 19:40, Lee Jones wrote:
> > On Tue, 14 Mar 2023, Martin Kurbanov wrote:
> >
> >> Add YAML devicetree binding for AWINIC AW20036/AW20052/AW20074
> >> led driver.
> >>
> >> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> >> ---
> >>  .../bindings/leds/awinic,aw200xx.yaml         | 126 ++++++++++++++++++
> >>  1 file changed, 126 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> >
> > Applied, thanks
>
> Hello Lee,
> Thank you for quick feedback! Sorry, I don't understand one thing.
> Driver implementation from the patch series must be improved, so
> currently it's not applied. Does dt bindings make sense without it?
> I don't think so. Please fix me if I'm wrong.

No problem.  Un-applied, thanks.

--
Lee Jones [李琼斯]
