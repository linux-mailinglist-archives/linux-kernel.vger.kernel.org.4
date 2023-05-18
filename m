Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FFB708418
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjEROld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjEROl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:41:26 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63121708
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:41:18 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53202149ae2so1423558a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1684420878; x=1687012878;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NW9LLhYTca2cJhIK8XTt/Nh6/suVOD01pOd44VESQ5c=;
        b=GdQCfpRE0SGkqI8Vw1uWDvMc/zSC6F72zrNhKYOwqVqPZV/RZMos7OTMzDYss7hYL8
         PfK5imLMaQkbv4WlOsl8BqmcScUPe2jfxZoms54uoW5xrOsXUPyG/zQbU/P90MQMaZOi
         rGlatnT1iW1m5JZ6/Vfrho2i2n91eRAqkhgCQ/Uonr6wYA8mYiKOhfS4Y1O/2kr/mKto
         YC+5Qz9hI+y9ZnYoo6/zqZPwqUEO9QYJcK+eBaXMb8ofHT4em+rF3f2SH0ARTkzeZ5B3
         vIRIqX2OlKm/djkHqAGmllJmSLXy59VJokCfXyOdTOf4epv65yuSWuXHxmf4p4lzsAEl
         P2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684420878; x=1687012878;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NW9LLhYTca2cJhIK8XTt/Nh6/suVOD01pOd44VESQ5c=;
        b=hTqRcBykr2JvWFK7/WmgGlPY2S8EgilKq/OtP3XRTJKB7ESRR12S2klLLWj78Jg7nb
         1NSg5YEc/A0hkgwA3SpVX2w0ohdkP2w3uKI+nqhP2/j68DBk2LL/3RSBIyJKTmuCk5Hb
         S4AQcHZTzJFQzVGSkYs0y3JR+Cf/uS+eS1W6we6LRs1L8gULmaRT4EGgip9TCnEGpE5d
         Pxn2JiD6k+05jRFa3tsvcMmkm+5/iU/geOwyrgJ3gTdFQEgVJCA7Bgy2ct3kh7aBmN0r
         gdo5U8TIIzwgHRD0EuVTwjDwY6uXOEmJtRfDgzwXYAoj8OH4sG3T7SJws3Ky9JtTGBbl
         ve6w==
X-Gm-Message-State: AC+VfDze0J12Di9FluVmfOxw0rmVAk/7A+RyhjNAP1KV6GaQAbK4secN
        lkKBxL4OfGsKaPrHt0W4jLGBzg==
X-Google-Smtp-Source: ACHHUZ6JxPhsiDataOovPdM7nE2IyeWvbCpA+HWBCPdSdabHeOsCxcgZRnCilCby2R6wCo4Qatxqpg==
X-Received: by 2002:a17:903:41c6:b0:1ac:482e:ed4d with SMTP id u6-20020a17090341c600b001ac482eed4dmr3743263ple.18.1684420877838;
        Thu, 18 May 2023 07:41:17 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902680500b001a245b49731sm1534690plk.128.2023.05.18.07.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 07:41:17 -0700 (PDT)
Date:   Thu, 18 May 2023 07:41:17 -0700 (PDT)
X-Google-Original-Date: Thu, 18 May 2023 07:41:15 PDT (-0700)
Subject:     Re: [PATCH v1] dt-bindings: riscv: deprecate riscv,isa
In-Reply-To: <20230518-hammock-doornail-478e8ea8e6a7@wendy>
CC:     anup@brainfault.org, ajones@ventanamicro.com,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        apatel@ventanamicro.com, atishp@atishpatra.org, jrtc27@jrtc27.com,
        rick@andestech.com, ycliang@andestech.com,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Message-ID: <mhng-95b99ff5-9024-4672-bb84-7599f7a05129@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 07:06:17 PDT (-0700), Conor Dooley wrote:
> On Thu, May 18, 2023 at 07:13:15PM +0530, Anup Patel wrote:
>> On Thu, May 18, 2023 at 4:02 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>> > On Thu, May 18, 2023 at 09:58:30AM +0100, Conor Dooley wrote:
>
>> > > -  riscv,isa:
>> > > -    description:
>> > > -      Identifies the specific RISC-V instruction set architecture
>> > > -      supported by the hart.  These are documented in the RISC-V
>> > > -      User-Level ISA document, available from
>> > > -      https://riscv.org/specifications/
>> > > -
>> > > -      Due to revisions of the ISA specification, some deviations
>> > > -      have arisen over time.
>> > > -      Notably, riscv,isa was defined prior to the creation of the
>> > > -      Zicsr and Zifencei extensions and thus "i" implies
>> > > -      "zicsr_zifencei".
>> > > -
>> > > -      While the isa strings in ISA specification are case
>> > > -      insensitive, letters in the riscv,isa string must be all
>> > > -      lowercase to simplify parsing.
>> > > -    $ref: "/schemas/types.yaml#/definitions/string"
>> > > -    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
>> > > -
>> > >    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
>> > >    timebase-frequency: false
>> > >
>> > > @@ -133,8 +117,13 @@ properties:
>> > >        DMIPS/MHz, relative to highest capacity-dmips-mhz
>> > >        in the system.
>> > >
>> > > +oneOf:
>> > > +  - required:
>> > > +      - riscv,isa
>> >
>> > This is the part Anup keeps reminding me about. We can create better ways
>> > to handle extensions in DT and ACPI, but we'll still need to parse ISA
>> > strings to handle legacy DTs and holdouts that keep creating ISA strings,
>> > at least during the deprecation period, since ISA strings are still "the
>> > way to do it" according to the spec.
>> 
>> Coming up with an alternate way in DT is fine but we can't deprecate
>> ISA strings since ISA strings are widely used:
>> 1) Various bootloaders
>
> Aye, for the reason, as I mentioned earlier and in the RFC thread,
> removing existing parsers isn't a good idea.

Removing and deprecating are different.  We can deprecate stuff.

>> 2) It is part of /proc/cpuinfo
>
> That is irrelevant.
>
>> 3) Hypervisors use it to communicate HW features to Guest/VM.
>> Hypervisors can't get away from generating ISA strings because
>> Hypervisors don't know what is running inside Guest/VM.
>
> Generate both :) As things stand, your guests could interpret what you
> communicate to them via riscv,isa differently!
>
>> In the case of ACPI, it is a very different situation. Like Sunil mentioned,
>> ACPI will always follow mechanisms defined by RVI (such as ISA string).
>> Other ACPI approaches such as GUID for ISA extension are simply not
>> scalable and will take a lot more memory for ACPI tables compared to
>> ISA strings.
>
> My proposal should actually suit ACPI, at least for Linux, as it would
> be a chance to align currently misaligned definitions. I won't speak to
> GUIDs or whatever as that's someone else's problem :)

We talked a bit in the patchwork meeting with Drew about ACPI.  Any 
actual spec/encoding would need to be different, of course, but 
conceptually it seems to fit fine.  It's also broadly similar to what 
we've done with riscv_hwprobe() for userspace, which is nice.

>> > Also, if we assume the wording in the spec does get shored up, then,
>> > unless I'm missing something, the list of advantages for this boolean
>> > proposal from your commit message would be
>> 
>> IMO, we should try our best to have the wordings changed in RVI spec.
>
> Yes, doing so is beneficial for all of us regardless of what happens
> here. I do think that it is partially orthogonal - it allows us to not
> design an interface that needs to be capable of communicating a wide
> variety of versions, but I don't think it solves some of the issues
> that riscv,isa has. If I thought it did, I would not have gone to the
> trouble of respinning this patch out of the other approach.
>
>> > * More character choices for name -- probably not a huge gain for ratified
>> >   extensions, since the boolean properties will likely still use the same
>> >   name as the ISA string (riscv,isa-extension-<name>). But, for vendor
>> >   extensions, this is indeed a major improvement, since vendor extension
>> >   boolean property names may need to be extended in unambiguous ways to
>> >   handle changes in the extension.
>> >
>> > * Simpler, more complete DT validation (but we still need a best effort
>> >   for legacy ISA strings)
>> >
>> > * Simpler DT parsing (but we still need the current parser for legacy ISA
>> >   strings)
>> >
>> > > +  - required:
>> > > +      - riscv,isa-base
>> > > +
>> > >  required:
>> > > -  - riscv,isa
>> > >    - interrupt-controller
>> > >
>> > >  additionalProperties: true
>> > > @@ -177,7 +166,13 @@ examples:
>> > >                  i-tlb-size = <32>;
>> > >                  mmu-type = "riscv,sv39";
>> > >                  reg = <1>;
>> > > -                riscv,isa = "rv64imafdc";
>> > > +                riscv,isa-base = "rv64i";
>> > > +                riscv,isa-extension-i;
>> > > +                riscv,isa-extension-m;
>> > > +                riscv,isa-extension-a;
>> > > +                riscv,isa-extension-f;
>> > > +                riscv,isa-extension-d;
>> > > +                riscv,isa-extension-c;
>> 
>> One downside of this new approach is it will increase the size of DTB.
>> Imaging 50 such DT properties in 46 CPU DT nodes.
>
> I should do a comparison between 50 extensions in riscv,isa and doing
> this 50 times and see what the sizes are.

I'm not sure how sensitive people are to DT size (presumably it'd be DTB 
size)?

It's also not clear what we can do about it: RISC-V has lots of 
extensions, that's going to take encoding space.  Sticking with an 
ambiguous encoding because it's smaller seems like a way to get 
burned in the long run.
