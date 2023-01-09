Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3031661F97
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjAIICd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjAIIC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:02:28 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC294FCDA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:02:27 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso12013532pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gzWfkg4ZC7kc3QEtk+OYVwq1uaceASK3hTBpAc94uQ0=;
        b=dTXSsdMcCi67LNWErLwMapGj/WTi4uejeFaA7SJH2fnn1vCcR8dZdoMFteHa0nR/F8
         kh+oCK+ztYw5Rf4gKv4TV5Gdah2TQm8k+XL62wM3ueN5p/GVMw+ZxiAACMfUSzIVYbOS
         Xs/nMno96/ZqDQeh4Ni75wvFBhmTroKQxcbhm4q51cwo2RV7y5bjDGNUrbcVui5pdBIO
         maly1bWQ5ih++hsQEb8M2G7xGXr3oBPVCCk3T43pqAWK62Nn+VOQIWNnXhpyxUBBHkNU
         nfmOSpXVUGQYU4xxVcOQgeMSNx1UD0P+L7qHDevVACiS1B0xvaGy9HU6baIVxrjTdUnG
         7qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzWfkg4ZC7kc3QEtk+OYVwq1uaceASK3hTBpAc94uQ0=;
        b=1Gl28ePr7eV4hQlNlb017nE33fuukEkl+IqZmCtkGKJrzLcpva9eUdJ/b8c5QwO48y
         /UCQ+7SYLE4TkdBV66kLIWhHj5WkNmb08T4rMc6xAmZIOV2ordLKcePGHub2QNVfMUc4
         C40ebDTqv+1HFBx2hIl+xvto46beebKVeoXc4TTJSl8qmk+U+IUNbOYfN3sVtBc2NOF5
         GMyUsc8j+DysWiriTP5OsnZmRgesYxbK3CyC7KOgTmuM2n2kVRo6EuvBHRwHsNax1HE8
         htWMDpRAJP16irdhDYKhI9OTKX/h00UGXOPE2LnVfs2+7iFkfachdnnOuIxGBgHEIyux
         43tA==
X-Gm-Message-State: AFqh2kp20niPBVTE/g2aNr7LL835HAkgP6hjFhsqrJhLN7TATuvyJRZ9
        GY1vdXBx0Wqa/fYkkE1T2X1Yn4JLuOO4aDi5GFLU8g==
X-Google-Smtp-Source: AMrXdXuftWpX5mTStYap+1P6OPLCG3xf/3GpmVYY9n9/X2wdAH3VchswgQCSQ8KEuwHPflydKDj31E8wKJDgPlqWB90=
X-Received: by 2002:a17:90a:db53:b0:227:208f:65f with SMTP id
 u19-20020a17090adb5300b00227208f065fmr119951pjx.32.1673251347239; Mon, 09 Jan
 2023 00:02:27 -0800 (PST)
MIME-Version: 1.0
References: <20230102165551.1564960-1-conor@kernel.org> <20230103092816.w6hknvd4caeahdo4@orel>
 <Y7s2+McYXLeEMNck@spud>
In-Reply-To: <Y7s2+McYXLeEMNck@spud>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Mon, 9 Jan 2023 00:02:16 -0800
Message-ID: <CAHBxVyHUPPakb3djAuJMkRjXOew9+PC6nARv+RT-GrMWPdCRGw@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: riscv: add SBI PMU event mappings
To:     Conor Dooley <conor@kernel.org>
Cc:     Andrew Jones <ajones@ventanamicro.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com,
        will@kernel.org, mark.rutland@arm.com, opensbi@lists.infradead.org,
        samuel@sholland.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 8, 2023 at 1:34 PM Conor Dooley <conor@kernel.org> wrote:
>
> Drew, Atish,
>
> Mainly just a question about the OpenSBI doc at the end. Gonna fix up
> the rest of the wording and resend in a few.
>
> On Tue, Jan 03, 2023 at 10:28:16AM +0100, Andrew Jones wrote:
> > On Mon, Jan 02, 2023 at 04:55:51PM +0000, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > The SBI PMU extension requires a firmware to be aware of the event to
> > > counter/mhpmevent mappings supported by the hardware. OpenSBI may use
> > > DeviceTree to describe the PMU mappings. This binding is currently
> > > described in markdown in OpenSBI (since v1.0 in Dec 2021) & used by QEMU
> > > since v7.2.0.
> > >
> > > Import the binding for use while validating dtb dumps from QEMU and
> > > upcoming hardware (eg JH7110 SoC) that will make use of the event
> > > mapping.
> > >
> > > Link: https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_support.md
> > > Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc # Performance Monitoring Unit Extension
> > > Co-developed-by: Atish Patra <atishp@rivosinc.com>
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>
> > > +  riscv,event-to-mhpmevent:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > +    description:
> > > +      Represents an ONE-to-ONE mapping between a PMU event and the event
> > > +      selector value that platform expects to be written to the MHPMEVENTx CSR
> >                             ^ the
>
> I think this one is arguable, it makes sense both ways IMO. I don't care
> since it's not my prose though ;)
>
> > > +      for that event.
> > > +      The mapping is encoded in an matrix format where each element represents
> > > +      an event.
> > > +      This property shouldn't encode any raw hardware event.
> > > +    items:
> > > +      items:
> > > +        - description: event_idx, a 20-bit wide encoding of the event type and
> > > +            code. Refer to the SBI specification for a complete description of
> > > +            the event types and codes.
> > > +        - description: upper 32 bits of the event selector value for MHPMEVENTx
> > > +        - description: lower 32 bits of the event selector value for MHPMEVENTx
> >
> > > +     * codes, U74 uses a bitfield for events encoding, so several U74 events
> > > +     * can be bound to single perf id.
> >                                 ^ a   ID
> >
> > > +     * See SBI PMU hardware id's in OpenSBI's include/sbi/sbi_ecall_interface.h
> >
> > IDs
>
> Most of this stuff comes directly from the doc in OpenSBI that I
> copy-pasted. Atish, what do you wanna do once the binding is upstream
> about the original doc?
>

I will fixup the doc based on the final version of the binding once it
is upstream.

> Thanks,
> Conor.
>
