Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841AA62ED46
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbiKRFoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbiKRFoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:44:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20804AF16;
        Thu, 17 Nov 2022 21:44:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D6116231D;
        Fri, 18 Nov 2022 05:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DF4C433C1;
        Fri, 18 Nov 2022 05:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668750244;
        bh=26JuICvWqdOYN2lvbjVbjUW2AdARfI5g0RNvblB4jZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKGNpGMGAb0+yRiYMaUC19vV1FAFQ3pR0cN/QQYdry1LPzE0b7yf2yNvNokniOYoC
         W6izWQbirDEUrmO6BDcBsuhwpcxxkcMfexlDKLV3akFboJMnz840LVlhCAM9V7yA+f
         IaWM7up5vJPD1qB6iyln+PQ2PX/TizIYviqtyQ75pArhiKOWLqG4x30iXgohTDyF5w
         jxlymmklX1xuYXUmr1BLphSB/C1txfmC2m2iQ1L8Bh/VxXLPbwFkiQfLWPvNpARPiy
         9T/HYFHVkajoJoBnaltUDaZv1/qrJ1z1YrtRChOqja8B8ZIE97vf+FkGScdyv3ntiQ
         9+ubujmrGYYmg==
Date:   Fri, 18 Nov 2022 13:44:00 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/3] dt-bindings: mfd: Add DT compatible string
 "google,cros_ec_uart"
Message-ID: <Y3cboMlFTRzSJyQ8@google.com>
References: <20221117114818.v7.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221117114818.v7.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117114818.v7.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:48:47AM -0700, Mark Hasemeyer wrote:
> Add DT compatible string in
> Documentation/devicetree/bindings/mfd/cros_ec.txt

The patch doesn't apply.  Please rebase it.
