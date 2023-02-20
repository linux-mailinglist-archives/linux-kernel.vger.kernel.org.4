Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7642E69C482
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 04:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjBTDb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 22:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBTDbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 22:31:55 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93223E05A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 19:31:53 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id g35so142588vkd.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 19:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1zm8xJuaotm6vpzvHnpvokhYNz8wvFB8VkvBsqrPPrE=;
        b=XfOq/srI+PG5S3tIsdmDRgmwdsMQ+ZClbAz7T6USak/qOBTNy7W1gC6UP7/w29oxbE
         6iiGXn4GNQ6AtD83L4a1y1z3FFyz7AE1WrJmvJZ44qFUUH6e0dIfI9Mh6ljJivgskrUw
         /3sbkjEgoBSFRMK6t9WxS/xPOYYQVCkJj/MsN7NmcnRNRdrGC5vm1Rrd2hAknDdecrcJ
         zIMq4BCx6AretQvyByKBd/2v2LvxKeJnIoHsv7B5gckjF3nwcOwqrEc3lcNasxKFqpM7
         sDf7a++9fBZx/tpgPhwkKtWrYh+Tauk/SM5Z8Ue+RvsXoxwyu59CYJxwSq1ohAwLXkZM
         tAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zm8xJuaotm6vpzvHnpvokhYNz8wvFB8VkvBsqrPPrE=;
        b=1vgDB6hSMog3k4a63SC45stg7XX3HuDihp78jVty4A1nUpd/qB693yX8O1PzYAE0aY
         9B6z3gjbgC07fQTwM9+VL7sHQnEXogqp9TMhDYZ0UcdzMkeXqG/dTsOR7FaCjJtub/2P
         dHDSWbNyklYH8lNfwl08pTLUIskS6TgVg1tkETuayUyVAM1az/41rOIZ2J3QoCL6plWn
         qYPxG36G6smQVWKmSO1ZGEPmuAFshas5zLvha7UmHJFJeKW/I76nVmrENCTsMl9QTBJV
         7KHMDhdUrcIbe3Z1N9NTM5RXk4Tf/9bMd3kT5QrVy9ifpyT2yTUCWPIpdTRRmiyyxmXu
         xLdw==
X-Gm-Message-State: AO0yUKWV1KQw6cpYdyGwToTCc28cpW1rp9HK3Jq2TsS/6Jd4j+mgBWTO
        5fNgbLrxMfpeTlFvq837FI9a+hamVnvMYlahXRJBhkT5m5ftlIMm
X-Google-Smtp-Source: AK7set+D/gfVObR9SAgy5ZREo1wjRmgPl77pMBQmiXiEGzPyPFqKzCXsWSuVmTTX+jGxzmk5yK7IUvlUFUAsXEB6Jsk=
X-Received: by 2002:a1f:a682:0:b0:3d5:9b32:7ba4 with SMTP id
 p124-20020a1fa682000000b003d59b327ba4mr90534vke.15.1676863912532; Sun, 19 Feb
 2023 19:31:52 -0800 (PST)
MIME-Version: 1.0
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-5-apatel@ventanamicro.com> <81b03d13-a1d6-91ee-9867-48e960f0549d@dram.page>
In-Reply-To: <81b03d13-a1d6-91ee-9867-48e960f0549d@dram.page>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 20 Feb 2023 09:01:40 +0530
Message-ID: <CAK9=C2WOBKt9FNVNtkVsUMGeMxB7awBgbi_WN+TwiUx4OwTBoQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] dt-bindings: interrupt-controller: Add RISC-V
 incoming MSI controller
To:     Vivian Wang <uwu@dram.page>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 4:48 PM Vivian Wang <uwu@dram.page> wrote:
>
> On 1/3/23 22:14, Anup Patel wrote:
> > We add DT bindings document for the RISC-V incoming MSI controller
> > (IMSIC) defined by the RISC-V advanced interrupt architecture (AIA)
> > specification.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  .../interrupt-controller/riscv,imsics.yaml    | 168 ++++++++++++++++++
> >  1 file changed, 168 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
> > new file mode 100644
> > index 000000000000..b9db03b6e95f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
> > <snip>
> > +
> > +  interrupts-extended:
> > +    minItems: 1
> > +    maxItems: 16384
> > +    description:
> > +      This property represents the set of CPUs (or HARTs) for which given
> > +      device tree node describes the IMSIC interrupt files. Each node pointed
> > +      to should be a riscv,cpu-intc node, which has a riscv node (i.e. RISC-V
> > +      HART) as parent.
> > +
>
> This property doesn't seem to describe guest external interrupts. Should
> we add a reference to e.g. <&cpuN_intc 12> to indicate that IMSIC can
> send a 'Supervisor guest external interrupt'? Or just an idea, maybe we
> can add an additional interrupt controller to the CPU nodes to handle
> SGEI: (Various properties omitted)
>
> cpu0: cpu@N {
>         compatible = "riscv";
>
>         cpu0_intc: interrupt-controller {
>                 compatible = "riscv,cpu-intc";
>
>                 cpu0_gei: interrupt-controller {
>                         /* intc for hart-local hgeie/hgeip */
>                         compatible = "riscv,..."; /* Something here */
>                         interrupt-parent = <&cpu0_intc>;
>                         interrupts = <12>; /* SGEI */
>                         interrupt-controller;
>                         #interrupt-cells = <1>;
>                 }
>         }
> }
>
> interrupt-controller@... {
>         compatible = "riscv,imsics";
>         interrupts-extended = <&cpu0_intc 11>, <&cpu0_gei 1>, <&cpu0_gei 2> /* ... */;
> }
>
> I feel that this would be more appropriate, since the guest external
> interrupts are defined in the privileged architecture specification and
> are not specific to AIA. Though please do suggest more appropriate ways
> to formulate it.

This is unnecessary because GEILEN can be detected by init time
writes to hgeie CSR. Please look at KVM RISC-V AIA implementation
for more details. We only need "riscv,guest-index-bits" DT property
for address space holes.

In fact, we have tested these DT bindings with a variety of NUMA
configurations containing different numbers of IMISC guest files
per-HART.

Regards,
Anup
