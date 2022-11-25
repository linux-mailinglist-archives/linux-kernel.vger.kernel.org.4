Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5124638A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiKYMwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKYMwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:52:04 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B8B1D33E;
        Fri, 25 Nov 2022 04:52:02 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x2so6295402edd.2;
        Fri, 25 Nov 2022 04:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZM9q1K+42FsNfeDNYm/8tjXP/Kt4Gm+q17CqPvn1IU=;
        b=iVPArmm57/IEQXdp7tdJZqPU7TQN8yhQGrEQzHv6hpqKQFxi9oBS6DGdo0LwIZ7F9Q
         lBgR9+lpqH5ZuSr4N0zd5uHFNGmFw2vtBtHtTdN0738CicJC2xbL7nJbV+2KTZwXyKHj
         R6h9D5bEbWTPND1Vzli1NKP9AXXDYVl9V7+n7YhUmGKFzmxA2gvpKIqQhNZMRLKg+VE0
         YjGzMgreZ9YHmrKiLikM5zz8NUmvMl3MBdS2NGi+/RyCfM77WeeYhbIdSXx7MqryNb/S
         6PSdA52/ndBpH/TsG2taHYhax0n+0AepsOxg6VaZXkqkMlC0pU6b4aeDQJvotuCakawf
         qnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZM9q1K+42FsNfeDNYm/8tjXP/Kt4Gm+q17CqPvn1IU=;
        b=msDdTNc64sI1xeuv43IiiwCi7183If1cSl2OzYRgVZWiDdS8WvpOF8Dai7hQPXwe4y
         vJqetm0upvzqcahL3XyNPj923mMX1exFcWLJEk1MQU+O180VVX02pDTkWgrx4sBrAB8l
         Dm5Ue+1t42Tm0553euehCj+TwDHGr+KuqtKG55IcbDvDt+80HkL+QF2laP0b7qG6nGLU
         NYVXVdLCZwPjDxD836gZqgTuSz19UWrrpItPDw1eCfrJ8ML0Zklv+qSz+ZxscdUvniYb
         qYEfPiw2QTELQ/L8Xwm/TNw4owhHgBGVBqjfUT301dFHkYFJk2sW6sm5qrZnUWE9b3D4
         tr9g==
X-Gm-Message-State: ANoB5pkjsLfsQLbkxuNBlex3kflDraynSkILeqJPjrK5RUpY3xbGkdbj
        mSBtddfn7OdGaL4Tk+2PwNngRllvsfPASYQcbqY=
X-Google-Smtp-Source: AA0mqf5Lq4Pu7NoN/UM+TblOtprU1WDL5qvhXP3lh39E7rVRPYg6ZUFacZ1Y6gAGHGpxHM9DVnp+shoUQbO+jemouyI=
X-Received: by 2002:a05:6402:1f87:b0:468:7df:c38c with SMTP id
 c7-20020a0564021f8700b0046807dfc38cmr34475964edc.150.1669380721124; Fri, 25
 Nov 2022 04:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <70d1bfde-f57f-1741-08d3-23e362793595@linaro.org> <CA+V-a8s2awLp=YvbhA1Ohe500Oh1easLUcG9V4_FWov7Pf2i6g@mail.gmail.com>
 <9b0f8312-2caa-b9f3-edf3-1b720532f559@linaro.org> <Y4C0Jn1hl81ZCxOt@wendy>
In-Reply-To: <Y4C0Jn1hl81ZCxOt@wendy>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 25 Nov 2022 12:51:34 +0000
Message-ID: <CA+V-a8u_R9X10AQ2dV9ieDGx7OJPhLRW3ENAoRP2fqVQTVodPw@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] dt-bindings: cache: r9a07g043f-l2-cache: Add DT
 binding documentation for L2 cache controller
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Fri, Nov 25, 2022 at 12:25 PM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> On Fri, Nov 25, 2022 at 01:12:18PM +0100, Krzysztof Kozlowski wrote:
> > On 25/11/2022 11:34, Lad, Prabhakar wrote:
> > >>> +/* Device, Non-bufferable */
> > >>> +#define AX45MP_PMACFG_MTYP_DEV_NON_BUF                       (0 << 2)
> > >>> +/* Device, bufferable */
> > >>> +#define AX45MP_PMACFG_MTYP_DEV_BUF                   (1 << 2)
> > >>> +/* Memory, Non-cacheable, Non-bufferable */
> > >>> +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_NON_BUF     (2 << 2)
> > >>> +/* Memory, Non-cacheable, Bufferable */
> > >>> +#define AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF         (3 << 2)
> > >>
> > >> What are all these? They don't look like flags, because 3 = 1 | 2...
> > >> they don't look like constants, because we do not use shifts in
> > >> constants. Are these some register values? I also do not see the header
> > >> being used in the code, so why having a bindings header if it is not
> > >> used (DTS is not usage...)?
> > >>
> > > These are register bit values for the MTYP[5:2] field. The DTS example
> > > in the binding doc (above) uses these macros. I haven't included the
> > > DTS/I patches with this patchset yet do think I should?
> >
> > Then why storing it as bindings? Bindings headers describe the interface
> > implemented by drivers and used by DTS, but this is not implemented by
> > drivers.
>
> IIUC, some of these properties are non-discoverable attributes of the
> cache controller. I see two things that could be done here that are
> "better" than #defining bits:
> - add an RZ/Five specific compatible and use match data to set the
>   attributes which is only possible if the pma-regions are set on a
>   per SoC basis
> - make pma-regions into a child node, in which andestech,non-cacheable
>   andestech,non-bufferable etc are properties of the child node
>
For now the only way to get DMA working without IOCP is to have
AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF. But for future purposes I have
introduced the other available flags.

So maybe for now we could just have this flag
andestech,mem-non-cacheable-bufferable in the binding doc.

    cache-controller@2010000 {
        reg = <0x13400000 0x100000>;
        compatible = "andestech,ax45mp-cache", "cache";
        interrupts = <508 IRQ_TYPE_LEVEL_HIGH>;
        cache-line-size = <64>;
        cache-level = <2>;
        cache-sets = <1024>;
        cache-size = <262144>;
        cache-unified;
        andestech,pma-region@0x58000000 {
            reg = <0x58000000 0x08000000>;
            andestech,mem-non-cacheable-bufferable;
        };
        andestech,pma-region@0xdeadbeef {
            reg = <0xdeadbeef 0x08000000>;
            andestech,mem-non-cacheable-bufferable;
        };
        ....
    };

Did I chime in this time?

Cheers,
Prabhakar
