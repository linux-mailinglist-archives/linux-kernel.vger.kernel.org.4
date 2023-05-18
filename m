Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969AB707EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjERLLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjERLLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:11:43 -0400
X-Greylist: delayed 5486 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 May 2023 04:11:18 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456CA10E6;
        Thu, 18 May 2023 04:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684408224; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=i/jxOxlicI5zWCrrOzlERhmF40xvJ+X3NjHAfehLC+oR13NCWx8ci8JpC7+T5x8PSS
    Ux28DA4adyVMpnEhy/OEoohUaXVoCnvJ+sJfrQtABXy74Luqop7JDmxsZySeq0CMIPPV
    ZkXpC85yjalur6lb5Ca0XkKLltZnu95mUz1hUs8/hg1HPegTxftUWZTq9NaNFN0f0jM3
    eTec+FUo25NIWBQIt+cMZ+kW3vTI798hZUNTcmm+N8xlXhCRWgLsnu1ZhKRIihFx6pQo
    V2pEjyjnnZqPY6cSX1ywWTuiaUtdpifRysTQGnNa/uF1EAZrNFdfoTtwGRqecgn6n73U
    h/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684408224;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=NEijn91Y8frPe3mx21CYziEmrOndT1BFgqTmRjdyTDg=;
    b=ReY+PInXvBEjsFE4mQEViAkc4IEsoTiOJeBMYB+QIo+T5Cx3KeR2d2I2MvfGsJzz6I
    VKVm7slVoPRBKYaC5QRRzxUGRh5+m+jc5/4h00lhzQ0+6g1xVQEOe2EUii6WIHJuYLlV
    fU4buavo3jDZShcBAw3MguClRgwX44WWBfcnLR5cgaTZvU+0nNnw+2n+OKKDNiuhJhh7
    aEXR8U9Td8lP/DnOP2H7GIk8cvbZcXOg6oqgMu5Yq4dPqbeLANHRH1RGBHlKIi9RlXZQ
    vUDgwrRxAfTWPzxkgS0bGP8VO18G6jG1R3CrTmz2jeMBdWZMCK/L9e6Wlf6ePhk7oBhq
    i5FQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684408224;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=NEijn91Y8frPe3mx21CYziEmrOndT1BFgqTmRjdyTDg=;
    b=ZO1OoBgWLCM67V6Mh5BBHOIz06/sEeZtTW9Qte+w5KOCsY8rToN7tZ/rk5VlXLzlb5
    PMm/YN6rnsqmZf7pa3ntkeXhTvl2D8zfta+GnK/9AYUvyNV417n6HjWRuI3kC1IOXeEk
    F52THWUursQxM0tXfS9OtoGQ/2gLJbk9wxQUjq9fEZ8JbsSN2FgGzJEMGViZ8lPbLDvU
    pReIulrLsJZm5DqnXIFOe1jsS5x+/nrLgUc4j+mSKR877oNS9xcSZ9x3JcQBLIqhd9jo
    q9UJMDTR5HwMYwzx9l/9SFJC8pzhNvSi8l6a8agx/d7h8zEKsCAK/SKGHwV6fHIvEZsJ
    x36g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684408224;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=NEijn91Y8frPe3mx21CYziEmrOndT1BFgqTmRjdyTDg=;
    b=FQyRzGQ0Dorlg5rgX7u/PjgKY5inrusOXv5ZvNI3uCDQn9Jw57IjG5BffSWUWCA0bN
    lMOT+cvPr2TbLw5fCdAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z2F1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4IBAOCOu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 18 May 2023 13:10:24 +0200 (CEST)
Date:   Thu, 18 May 2023 13:10:16 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-msm: Disable broken 64-bit DMA on MSM8916
Message-ID: <ZGYHmC3NW1W34HVQ@gerhold.net>
References: <20230518-msm8916-64bit-v1-1-5694b0f35211@gerhold.net>
 <2875f7ef-c43e-74f6-12b9-342bb2cfbaf8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2875f7ef-c43e-74f6-12b9-342bb2cfbaf8@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 11:48:55AM +0200, Konrad Dybcio wrote:
> On 18.05.2023 11:39, Stephan Gerhold wrote:
> > While SDHCI claims to support 64-bit DMA on MSM8916 it does not seem to
> > be properly functional. It is not immediately obvious because SDHCI is
> > usually used with IOMMU bypassed on this SoC, and all physical memory
> > has 32-bit addresses. But when trying to enable the IOMMU it quickly
> > fails with an error such as the following:
> > 
> >   arm-smmu 1e00000.iommu: Unhandled context fault:
> >     fsr=0x402, iova=0xfffff200, fsynr=0xe0000, cbfrsynra=0x140, cb=3
> >   mmc1: ADMA error: 0x02000000
> >   mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> >   mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00002e02
> >   mmc1: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000000
> >   mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> >   mmc1: sdhci: Present:   0x03f80206 | Host ctl: 0x00000019
> >   mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> >   mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> >   mmc1: sdhci: Timeout:   0x0000000a | Int stat: 0x00000001
> >   mmc1: sdhci: Int enab:  0x03ff900b | Sig enab: 0x03ff100b
> >   mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> >   mmc1: sdhci: Caps:      0x322dc8b2 | Caps_1:   0x00008007
> >   mmc1: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
> >   mmc1: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x5b590000
> >   mmc1: sdhci: Resp[2]:   0xe6487f80 | Resp[3]:  0x0a404094
> >   mmc1: sdhci: Host ctl2: 0x00000008
> >   mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x0000000ffffff224
> >   mmc1: sdhci_msm: ----------- VENDOR REGISTER DUMP -----------
> >   mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:  0x60006400 | DLL cfg2: 0x00000000
> >   mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:  0x00000000 | DDR cfg: 0x00000000
> >   mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 : 0xf88018a8 Vndr func3: 0x00000000
> >   mmc1: sdhci: ============================================
> >   mmc1: sdhci: fffffffff200: DMA 0x0000ffffffffe100, LEN 0x0008, Attr=0x21
> >   mmc1: sdhci: fffffffff20c: DMA 0x0000000000000000, LEN 0x0000, Attr=0x03
> > 
> > Looking closely it's obvious that only the 32-bit part of the address
> > (0xfffff200) arrives at the SMMU, the higher 16-bit (0xffff...) get
> > lost somewhere. This might not be a limitation of the SDHCI itself but
> > perhaps the bus/interconnect it is connected to, or even the connection
> > to the SMMU.
> > 
> > Work around this by setting SDHCI_QUIRK2_BROKEN_64_BIT_DMA to avoid
> > using 64-bit addresses.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> Would using 64bit address translation not require you to use (dma-)ranges
> with a greater-than-default size, like we do on newer platforms? Did you
> test that by chance?
> 

No, there is no "dma-ranges" in msm8916.dtsi. It seems to use 64-bit
(virtual) addresses by default for SDHCI, limited to 48-bit by the SMMU.

I tried limiting dma-ranges to 32-bit in msm8916.dtsi /soc@0 like
dma-ranges = <0 0 0 0xffffffff>; This seems to work as well as an
alternative to this patch, although it causes several annoying
"Invalid size 0xffffffff for dma-range(s)" warnings. I know the
0xffffffff isn't valid but I don't see how I would actually specify
2^32 there without rewriting the entire msm8916.dtsi to use
#address/size-cells = <2> instead of <1>.

It's not entirely clear to me where the actual limitation is coming from
here. It could be specific to the SDHCI (in which case this patch makes
more sense) or a general limitation of the bus/interconnect (in which
case dma-ranges might make more sense).

In any case 64-bit DMA is broken for SDHCI on MSM8916 so I would say
this patch is still the right thing to do. It's pointless to waste extra
cycles and memory to manage 64-bit pointers for SDHCI ADMA 64-bit, when
they can never work successfully on this SoC. The dma-ranges approach
doesn't change that, while SDHCI_QUIRK2_BROKEN_64_BIT_DMA actually makes
it use ADMA in 32-bit mode.

Thanks,
Stephan
