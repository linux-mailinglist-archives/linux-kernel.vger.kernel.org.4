Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685E2638E99
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiKYQvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiKYQvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:51:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B9611802;
        Fri, 25 Nov 2022 08:51:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B8FCB82B96;
        Fri, 25 Nov 2022 16:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C106C433C1;
        Fri, 25 Nov 2022 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669395061;
        bh=icHKk06I7LpqiDqMP789HRUwYmQW5jPo6VqdPDTS/l0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fW+oXsPKDd4V7QfsuSQ8mi7itl3qhA+l/jsjxp4R/tQbLLacjNOTuvmDFGKAJmST/
         Ns6JCKP+scAu/e1n0oWRGYl+XJn5quEPOizb96pg6sFF6eAiDtQjwQEB+fM6m0XSyB
         wxqbHzuB/Z2nnh7UAlOyIMhIcWjoYq3/Qs63H2NIczJ8gBtazTsxtN7MGq3EFAQbC+
         Qz7olmfgnO2AVTXZb3Bd6FP3CbRufW//0y0ogMGm+tP223+leTuRpplXZF5mYIek/e
         fNc/5un+ub/9cXPeAUjncq2bqDzMScZw4y9Nnhi3glWGdSG89NAsFp4X3PiY+H8ooG
         lbp+OS619LKiA==
Date:   Fri, 25 Nov 2022 16:50:54 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 6/7] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
Message-ID: <Y4DybtJuw9f5vl/D@spud>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <70d1bfde-f57f-1741-08d3-23e362793595@linaro.org>
 <CA+V-a8s2awLp=YvbhA1Ohe500Oh1easLUcG9V4_FWov7Pf2i6g@mail.gmail.com>
 <9b0f8312-2caa-b9f3-edf3-1b720532f559@linaro.org>
 <Y4C0Jn1hl81ZCxOt@wendy>
 <ab0e55a2-d99a-328e-4f54-6a75936a1c81@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0e55a2-d99a-328e-4f54-6a75936a1c81@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 04:55:11PM +0100, Krzysztof Kozlowski wrote:
> On 25/11/2022 13:25, Conor Dooley wrote:
> > On Fri, Nov 25, 2022 at 01:12:18PM +0100, Krzysztof Kozlowski wrote:
> >> On 25/11/2022 11:34, Lad, Prabhakar wrote:
> >>>>> +/* Device, Non-bufferable */
> >>>>> +#define AX45MP_PMACFG_MTYP_DEV_NON_BUF                       (0 << 2)
> >>>>> +/* Device, bufferable */
> >>>>> +#define AX45MP_PMACFG_MTYP_DEV_BUF                   (1 << 2)
> >>>>> +/* Memory, Non-cacheable, Non-bufferable */
> >>>>> +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_NON_BUF     (2 << 2)
> >>>>> +/* Memory, Non-cacheable, Bufferable */
> >>>>> +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF         (3 << 2)
> >>>>
> >>>> What are all these? They don't look like flags, because 3 = 1 | 2...
> >>>> they don't look like constants, because we do not use shifts in
> >>>> constants. Are these some register values? I also do not see the header
> >>>> being used in the code, so why having a bindings header if it is not
> >>>> used (DTS is not usage...)?
> >>>>
> >>> These are register bit values for the MTYP[5:2] field. The DTS example
> >>> in the binding doc (above) uses these macros. I haven't included the
> >>> DTS/I patches with this patchset yet do think I should?
> >>
> >> Then why storing it as bindings? Bindings headers describe the interface
> >> implemented by drivers and used by DTS, but this is not implemented by
> >> drivers.
> > 
> > IIUC, some of these properties are non-discoverable attributes of the
> > cache controller. I see two things that could be done here that are
> > "better" than #defining bits:
> 
> I did not comment about properties. I comment about constants. Why
> register values/offsets/addresses are in this particular case suitable
> for binding headers?

I don't think we disagree here. I'm not in favour of the defines either
here. Perhaps I confused you by accidentally not adding Prabhakar to the
to field.

The dt needs to convey his particular cache implementation's bufferable
and/or coherent regions so I was suggesting alternatives for conveying
this information, without resorting to defines.

> > - add an RZ/Five specific compatible and use match data to set the
> >   attributes which is only possible if the pma-regions are set on a
> >   per SoC basis
> > - make pma-regions into a child node, in which andestech,non-cacheable
> >   andestech,non-bufferable etc are properties of the child node

