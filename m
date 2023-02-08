Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEA068EF4B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjBHMp0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Feb 2023 07:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjBHMpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:45:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC283C16
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 04:45:15 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-189-p1NzTKurMx-XOzJkMOJ9Kw-1; Wed, 08 Feb 2023 12:45:12 +0000
X-MC-Unique: p1NzTKurMx-XOzJkMOJ9Kw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Wed, 8 Feb
 2023 12:45:10 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Wed, 8 Feb 2023 12:45:10 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rob Herring' <robh@kernel.org>, Evan Green <evan@rivosinc.com>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        "vineetg@rivosinc.com" <vineetg@rivosinc.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "slewis@rivosinc.com" <slewis@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v2 4/6] dt-bindings: Add RISC-V misaligned access
 performance
Thread-Topic: [PATCH v2 4/6] dt-bindings: Add RISC-V misaligned access
 performance
Thread-Index: AQHZOxZ0HOszyZvzhUaVsFXdLDVyyK7E/WfQ
Date:   Wed, 8 Feb 2023 12:45:10 +0000
Message-ID: <4bd24def02014939a87eb8430ba0070d@AcuMS.aculab.com>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <20230206201455.1790329-5-evan@rivosinc.com>
 <20230207170550.GA3719881-robh@kernel.org>
In-Reply-To: <20230207170550.GA3719881-robh@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring
> Sent: 07 February 2023 17:06
> 
> On Mon, Feb 06, 2023 at 12:14:53PM -0800, Evan Green wrote:
> > From: Palmer Dabbelt <palmer@rivosinc.com>
> >
> > This key allows device trees to specify the performance of misaligned
> > accesses to main memory regions from each CPU in the system.
> >
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> > ---
> >
> > (no changes since v1)
> >
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml
> b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index c6720764e765..2c09bd6f2927 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -85,6 +85,21 @@ properties:
> >      $ref: "/schemas/types.yaml#/definitions/string"
> >      pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:_[hsxz](?:[a-z])+)*$
> >
> > +  riscv,misaligned-access-performance:
> > +    description:
> > +      Identifies the performance of misaligned memory accesses to main memory
> > +      regions.  There are three flavors of unaligned access performance: "emulated"
> > +      means that misaligned accesses are emulated via software and thus
> > +      extremely slow, "slow" means that misaligned accesses are supported by
> > +      hardware but still slower that aligned accesses sequences, and "fast"
> > +      means that misaligned accesses are as fast or faster than the
> > +      cooresponding aligned accesses sequences.
> > +    $ref: "/schemas/types.yaml#/definitions/string"
> > +    enum:
> > +      - emulated
> > +      - slow
> > +      - fast
> 
> I don't think this belongs in DT. (I'm not sure about a userspace
> interface either.)
> 
> Can't this be tested and determined at runtime? Do misaligned accesses
> and compare the performance. We already do this for things like memcpy
> or crypto implementation selection.

There is also an long discussion about misaligned accesses
for loooongarch.

Basically if you want to run a common kernel (and userspace)
you have to default to compiling everything with -mno-stict-align
so that the compiler generates byte accesses for anything
marked 'packed' (etc).

Run-time tests can optimise some hot-spots.

In any case 'slow' is probably pointless - unless the accesses
take more than 1 or 2 extra cycles.

Oh, and you really never, ever want to emulate them.

Technically misaligned reads on (some) x86-64 cpu are slower
than aligned ones, but the difference is marginal.
I've measured two 64bit misaligned reads every clock.
But it is consistently slower by much less than one clock
per cache line.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

