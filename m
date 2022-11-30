Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD7963CE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 05:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiK3Epa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 23:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiK3Ep1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 23:45:27 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A402686B8;
        Tue, 29 Nov 2022 20:45:26 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E31D73200961;
        Tue, 29 Nov 2022 23:45:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 29 Nov 2022 23:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669783524; x=
        1669869924; bh=ByC7oIYW2NFxc/BVn9LYGbe9Bh9sYFXXAHsj3pV/Q4I=; b=I
        Ocn3rDGLpO3BkAbPH0tE2Kjo9lSwrpWosOrLZUjjbrnbWkF47KRFACb5CbNqVtxB
        v5My+Ig/BNn5w4883+103vmyRu+NsGaM1IC/2PARbNmfF3DiM4wQMZsy/2dEs4KT
        ax7Aqna8eLPB7QWXCAplFpu4D+WITKN5eSJGgXMXl6NTTcIdcVd1HRyf07vSLOAr
        HCiwzea25LfJEhLGZ0I8Sr+6GI9qYsWXzpEe3ROTFORBuBOwp6RIGej42H6p+AMJ
        JRrCJmNWSE+niERdD/moTxhI6KLYOexwfZGUvmW3PZGwIsS1VE22C79X3mazHJhA
        xVnBkLRvxKnfFkKGLAZZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669783524; x=
        1669869924; bh=ByC7oIYW2NFxc/BVn9LYGbe9Bh9sYFXXAHsj3pV/Q4I=; b=R
        xsRMMn2nTjKNW+dCgX06kiTo4jbgwmH7aWXRWKBfKBxtKgCnzsngu3MijaPclnOm
        ly1u+RDNKkPGuQGhkuO57ZnN92ncUlr0LcAqfVSVE6jBPo06shic6vHtBuaggsB4
        QRm+w221YfeEEC/gLZ8uZE7G1zPRtcXvxYypAQo3WCxg3nDydYkFP5i7Yi5gAcAV
        brs6M3edvU1qfBnA0vtW1FMJ8C/iFZbQOOwIhitmVEuiAWmnrwPyYHBjmHPrvtR2
        C0ImFt33oBGNNCxHfDX24PAG4zsC/mj0BDYiTncSHrEhdqLX/Var9A+yIzwAye8n
        kCVr5lg9/P8Bw9Jbx6JWg==
X-ME-Sender: <xms:5N-GY2yeWc_4Umcd10EsF4166chLQ8V8IiqgOX88xGOYiPL3gkcAfw>
    <xme:5N-GYySYA8ms8vnPz11fgn90mYJyVSZ93b04POF_08nirUiLAKOwTPURBX5veShGl
    ZZapGOAV0zMcAaJHg>
X-ME-Received: <xmr:5N-GY4V3yEHYHZmFsnPDNzbpEkHxVwt6HkSoKM4W2w-txFVi0XsSjN4wgHTdFV-UTanXkliU3wklBxSgph56gF6jNsjgH5Bo7mlShVkj_PPK-GCiQ9ZXpXDJDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtddvgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgeetkeevhfeghffgieegjeffjedvieehvdefgfetvdejieduteet
    iefhfffguefgnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhh
    ohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:5N-GY8jNO-eAoVBaKJ8iwhYqaBdc7K-MxRa0pvitmUHDnu5JEDsZ_Q>
    <xmx:5N-GY4AS_I8MdO1MQY6GC1KcijpolmhylP0LYlPYcRknHvmktmosaw>
    <xmx:5N-GY9J82VVTzjuN3O3V0J2H7gGP09j8wu4iLKolCDE8_YikS6lxWg>
    <xmx:5N-GY07_PvV5xV19qe5TnHy9zeC2gdHoPjuvYSYWDumBA9zTFy2vpQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Nov 2022 23:45:23 -0500 (EST)
Message-ID: <174d93be-bedf-bf8c-4a66-284931a997b3@sholland.org>
Date:   Tue, 29 Nov 2022 22:45:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221129140313.886192-1-apatel@ventanamicro.com>
 <20221129140313.886192-3-apatel@ventanamicro.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: timer: Add bindings for the RISC-V
 timer device
In-Reply-To: <20221129140313.886192-3-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 08:03, Anup Patel wrote:
> We add DT bindings for a separate RISC-V timer DT node which can
> be used to describe implementation specific behaviour (such as
> timer interrupt not triggered during non-retentive suspend).
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/timer/riscv,timer.yaml           | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/riscv,timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/riscv,timer.yaml b/Documentation/devicetree/bindings/timer/riscv,timer.yaml
> new file mode 100644
> index 000000000000..cf53dfff90bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/riscv,timer.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/riscv,timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V timer
> +
> +maintainers:
> +  - Anup Patel <anup@brainfault.org>
> +
> +description: |+
> +  RISC-V platforms always have a RISC-V timer device for the supervisor-mode
> +  based on the time CSR defined by the RISC-V privileged specification. The
> +  timer interrupts of this device are configured using the RISC-V SBI Time
> +  extension or the RISC-V Sstc extension.
> +
> +  The clock frequency of RISC-V timer device is specified via the
> +  "timebase-frequency" DT property of "/cpus" DT node which is described
> +  in Documentation/devicetree/bindings/riscv/cpus.yaml
> +
> +properties:
> +  compatible:
> +    enum:
> +      - riscv,timer
> +
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 4096   # Should be enough?
> +
> +  riscv,timer-cant-wake-cpu:

I don't want to derail getting this merged, but if you do end up sending
another version, could you please spell out the word "cannot" here and
in the code? The missing apostrophe makes this jarring (and an entirely
different word).

> +    type: boolean
> +    description:
> +      If present, the timer interrupt can't wake up the CPU from
> +      suspend/idle state.

And in that case I would also suggest clarifying this as "one or more
suspend/idle states", since the limitation does not apply to all idle
states. At least it should never apply to the architectural WFI state;
for the SBI idle state binding, it only applies to those with the
"local-timer-stop" property.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - interrupts-extended
> +
> +examples:
> +  - |
> +    timer {
> +      compatible = "riscv,timer";
> +      interrupts-extended = <&cpu1intc 5>,
> +                            <&cpu2intc 5>,
> +                            <&cpu3intc 5>,
> +                            <&cpu4intc 5>;

The CLINT and PLIC bindings also include the M-mode interrupts. Should
we do the same here?

Regards,
Samuel

