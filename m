Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE4D663E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjAJKZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbjAJKYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:24:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30748192A5;
        Tue, 10 Jan 2023 02:24:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0942615B0;
        Tue, 10 Jan 2023 10:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543ACC433D2;
        Tue, 10 Jan 2023 10:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673346284;
        bh=dTgPvsgrg4/CD/5ArDil+Tfp0HpNO3onh2BF3ZkA0yQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dkXylVkIew5hS9NGMeN8q1e/E1K3AL1CHW/aod2KYag4L0tf8zmZTtlLTa24sm8/G
         pJtFaOCBuJsxdLh1uWoXOS6fjxsk1rEbL88p1B/joz5jWmENpYIuGhaBk9IGIcM4H3
         cM2jnyRePODHWdG9gLLJLeAeQlNJ5Nd1/tEUpa1XsaEHDjq7Hfu0DaBlPIFxG1LPI+
         0X2cpHMvAC1tfCBoV1pr0NOxjbpjpIWXPSyiHmGJQMe1UhTJhaD2IeO/Qg9XWj10WH
         a1zAYhtFpIWZoAYO4KpMB4GSG//9yQPRhx7rqnGnINiMJkswabQcoqMXJ9BEQmWlBN
         1LbIDXr6nVRXQ==
Date:   Tue, 10 Jan 2023 10:24:38 +0000
From:   Lee Jones <lee@kernel.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v10 2/3] dt-bindings: mfd: Add compatible string for UART
 support
Message-ID: <Y7085l4J0jbrkd6G@google.com>
References: <20221207104005.v10.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221207104005.v10.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
 <Y7WkeCi7/x/t37JM@google.com>
 <Y7YjmtwByTR+8tbZ@google.com>
 <Y7bdmiZ9lqKZXCfq@google.com>
 <Y7buUdgLfnQqnG+x@google.com>
 <Y7b6dC6dDNO2bVjr@google.com>
 <Y7cSKFIakdGKKokE@google.com>
 <CANg-bXDrSJCGk27YKheupm9YND1fSaBaYfQ1Bd-4C-PnH67ioQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANg-bXDrSJCGk27YKheupm9YND1fSaBaYfQ1Bd-4C-PnH67ioQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2023, Mark Hasemeyer wrote:

> On Wed, Jan 4, 2023 at 9:08 AM Lee Jones <lee@kernel.org> wrote:
> > I changed the subject line and applied the patch, thanks.
> 
> Hey Lee, a couple comments/questions:
> 1. The subject line of this patch was updated in v11 of the series.
> 2. What tree was the patch applied to? I don't see the changes in linux-next.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml

Thanks for flagging.  You will do tomorrow.

-- 
Lee Jones [李琼斯]
