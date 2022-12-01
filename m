Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D02863F76D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiLASZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLASZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:25:29 -0500
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B596CAB014;
        Thu,  1 Dec 2022 10:25:28 -0800 (PST)
Received: from SOPL295.local (unknown [IPv6:2a02:8440:3340:1594:24ae:608:767e:668e])
        (Authenticated sender: robert.jarzmik@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 2C82519F5A5;
        Thu,  1 Dec 2022 19:25:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1669919126;
        bh=dxvABszEI6f7fdBGZdc2GTOEK6aNP1EbO7qdl8El1gc=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=OA/u/VmM1VnCvfyxgiyXf/+WpVsYAHQyLPYdIxm00XnXyaN4rVTm1j028WiWIsd/C
         wooRkG8K8l1LHVIeVqMeQnecetvYynmJs/E9tRnc3kmu9mTarCiM3GFFRf2hihghHu
         zr4HaQX/q4wLYEAN6fb8+08H20vrgDcczbcWTpUdwEopScbW0mItcjuq9v+29M6zSF
         KEsrGq3qB+fDCDSRr3W1ZD/mjIfoiGcSsxq9wugUGE5uUNmRUAUDmRexFZ1YERey2B
         pKIYpHQQPeT8dec1XkP2BM3Y+Xw5oV549f9rDrA/zmRoo5krclET9WhCQ8uWrAmzF0
         JGKpKcViioQqw==
References: <20221201100953.701963-1-j.neuschaefer@gmx.net>
User-agent: mu4e 1.8.11; emacs 28.1
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: pxa2xx: Remove bogus interrupt-parent; line
Date:   Thu, 01 Dec 2022 19:24:34 +0100
In-reply-to: <20221201100953.701963-1-j.neuschaefer@gmx.net>
Message-ID: <m21qpjf0c3.fsf@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> writes:

> Specifying interrupt-parent without a value (in other words, as=20
> a bool)
> doesn't really mean anything. Remove one such property in the=20
> PXA2xx DT,
> at /pxabus/interrupt-controller@40d00000.
>
> This patch was tested to cause no detrimental effect on PXA255.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

--
Robert
