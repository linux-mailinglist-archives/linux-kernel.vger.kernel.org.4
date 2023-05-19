Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81349708E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjESDbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjESDbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:31:42 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC0012F;
        Thu, 18 May 2023 20:31:41 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9FAA332007D7;
        Thu, 18 May 2023 23:31:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 18 May 2023 23:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684467097; x=1684553497; bh=Po/ogvPWUOXjRWtD3eSRZTMYszH7hxYjNm1
        SSZFz8Ag=; b=A0R0m+TSMqktHrkPrL9VqAT3f4aINfWvUXypjlxWTDx6o1QY+vM
        WLi8SlvdHxvtXzqUtaIVznbwomt3JX2/k5tde3bKkZDM1WpxLJMtyVvYHPuRlQRy
        ghISHthfBF+22z4nihxbKYAJ3A22uWF1GmZc5Y1xGCeIWCmirqlIHbZNXWBGKK68
        67ZuvbAQOC+GSzo1a3dHo3KJhYO9AW0pJz2RKZbkLyMxmj6bN+YdxvjEFCh+e8Ma
        vxeW39/Hgk7RPC2un7r40jimbb828m4Osdx/Wr4w5fRQOycCHcqt/K+oDgsVI6Cs
        ABuxm6LL9RAoOXZR9+bqbxlj8FybWFD8Vvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684467097; x=1684553497; bh=Po/ogvPWUOXjRWtD3eSRZTMYszH7hxYjNm1
        SSZFz8Ag=; b=n+V2uXd6XU9+8SwnC3Wd8UEeF0CsUodCgjU2IRdzaqnaKeCJP2F
        DrhigMLjcoBlyoLJRKk9cl15JuNzBG5gVqAliuHavCyFiTI6Koh621of5+HHbp8q
        hPpQEalIl5faa6SokhJcnCDgXOjXgsKdwtE+crYLDhsgLPXH1i8IauDB4nChk0b/
        mk3QaapXq0bCW63rFVvRlHpsnpgy3/lOxaXOXqCxSVwyDWVp7ggBZpeQ4h6LzXdq
        poRhGcq3bSUIvmnjXwnNDpreikmpVZ1qRwVW8xiT/gf4i10HWjPidUcJymKdkAhw
        Y7uBsKLKhHPlK4HfmNhGsOZXdil6WpxsoAQ==
X-ME-Sender: <xms:mO1mZChzbyEqY4cpb-3pXhlVytmnirLNR3dLFkfAOx1u0m_R8DaztA>
    <xme:mO1mZDAUwH7bdLlq71zXjVJwhnDPMxz5Edm-U4A9GN-vErXrYsMnw8XU9IakhoeT6
    JhgOh5FZpoeioQ4CQ>
X-ME-Received: <xmr:mO1mZKEQjL04REfqRlUFUuleD62wuE_58SbByw2adh39xjhPV2FDEiCHeK09260W_0lDrCKxMEpMpzVe-SzNf4rXA651dKbcVWkcoxPRyX1ue9DpLPstxtUhgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeekheegueeiteeghfehvefgkeefgefhtefhgfdukeekueffkeei
    fefhffeliedtfeenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgpdhgihhthh
    husgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:mO1mZLQm48IUIUyPWewYXpHB--oCenY9m4ybvF714-mFENhCmbh_YQ>
    <xmx:mO1mZPz2sBFSr-pI-JrY2rxhMJhzHaG4nIJpIT4zPCUM22v3m1SYIA>
    <xmx:mO1mZJ4tdj-Ah7gwWe8PoLLMLFkONa1XyAvHIY5j9IxnSclaG_J0XA>
    <xmx:me1mZPB365adlT_MO0zbMomtAp81BcTpg90ul8MylYJB2iW2fQfwVg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 May 2023 23:31:35 -0400 (EDT)
Message-ID: <c6e44e14-35b2-da09-5e8c-4d47e7a7a055@sholland.org>
Date:   Thu, 18 May 2023 22:31:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-7-jszhang@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 06/10] dt-bindings: riscv: Add bouffalolab bl808 board
 compatibles
In-Reply-To: <20230518152244.2178-7-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng, DT maintainers,

On 5/18/23 10:22, Jisheng Zhang wrote:
> Several SoMs and boards are available that feature the Bouffalolab
> bl808 SoC. Document the compatible strings.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/riscv/bouffalolab.yaml           | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> 
> diff --git a/Documentation/devicetree/bindings/riscv/bouffalolab.yaml b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> new file mode 100644
> index 000000000000..3b25d1a5d04a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/bouffalolab.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bouffalo Lab Technology SoC-based boards
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +description:
> +  Bouffalo Lab Technology SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: Carrier boards for the Sipeed M1s SoM
> +        items:
> +          - enum:
> +              - sipeed,m1s-dock
> +          - const: sipeed,m1s
> +          - const: bouffalolab,bl808

As mentioned in the message for patch 5, "The Bouffalolab bl808 SoC
contains three riscv CPUs, namely M0, D0 and LP. The D0 is 64bit RISC-V
GC compatible, so can run linux."

I have also been running U-Boot and NOMMU Linux on the less powerful,
but still quite fast, "M0" core. However, this core needs a different
DTB because:
 1) The CPU is different (T-HEAD E907 instead of C906).
 2) The interrupt routing is completely different.
    a. The M0 core contains a CLIC instead of a PLIC.
    b. The peripherals in the SoC are split between two buses. Those
       on one bus have their IRQs directly connected to M0, and share
       a multiplexed IRQ connection to D0; and vice versa for the
       other bus. So each bus's interrupt-parent needs to be swapped.

Using some preprocessor magic like we did for Allwinner and Renesas, I
was able to share most of the SoC and board DTs between the cores[1].
However, this still ends up with two DTs for each board. So here are my
questions:
 - Is this acceptable?
 - Is there precedent for how we should name the two board DTs?
 - How does this affect the board and SoC compatible strings?
   - Should there be a separate "bouffalolab,bl808-d0" in addition to
     "bouffalolab,bl808"?
   - Is it acceptable to use the same board compatible string for both,
     since the _board_ part of the DT does not change, only things
     inside the SoC?

It would be possible to avoid having two DTs per board by guarding all
of the differences behind "#ifdef CONFIG_64BIT", but that seems wrong
because you would end up with two totally incompatible DTBs named the
same thing, depending on how the DTB was built.

Thoughts?

Regards,
Samuel

[1]: https://github.com/openbouffalo/u-boot/commit/3ca800850f30

