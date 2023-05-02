Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B9A6F4755
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjEBPfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbjEBPfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:35:39 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB172E7;
        Tue,  2 May 2023 08:35:37 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C6C53C76A8;
        Tue,  2 May 2023 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683041706; bh=R9A1qU0xozFT1PTNbx8XF9Yii7u7muqM0dWSf6l21ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jFIjUf8jPNHIGqUtQXcb8eZaH6a3cBc0gsQnwtR3J6XeKHROAfT8XhpfZKOzuGZUS
         yZR6YajptRLzaksDUpkSSO0xitf2v3baxLFVVj/o6lOLNJAdgNvfU9i1dLacrFivVZ
         3IORo94VhcuvJTJr3OFMmXTniCwvBXIXx/4V18Cs=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/4] Input: pwm-vibra - add support for enable GPIO
Date:   Tue, 02 May 2023 17:35:04 +0200
Message-ID: <841522397.0ifERbkFSE@z3ntu.xyz>
In-Reply-To: <ZFBdobY1yxMXYfFt@google.com>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
 <20230427-hammerhead-vibra-v1-3-e87eeb94da51@z3ntu.xyz>
 <ZFBdobY1yxMXYfFt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 2. Mai 2023 02:47:29 CEST Dmitry Torokhov wrote:
> On Thu, Apr 27, 2023 at 10:34:28PM +0200, Luca Weiss wrote:
> > Some pwm vibrators have a dedicated enable GPIO that needs to be set
> > high so that the vibrator works. Add support for that optionally.
> 
> So this is not simply a power supply in your case controlled by a GPIO?
> We truly can have both GPIO and a separate regulator?

Yes it appears to be the EN pin on the ISA1000A, see
https://electronics.stackexchange.com/q/380475

On apq8026-lg-lenok there is a similar setup for the vibration motor although 
there I don't know whether it's actually a fixed-regulator or not, but since 
the two devices were built in a similar time (without checking further) I 
could assume they both contain the same IC.

Regards
Luca

> 
> Thanks.




