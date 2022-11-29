Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC6A63B99D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 06:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbiK2F6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 00:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiK2F6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 00:58:05 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB7227FC7;
        Mon, 28 Nov 2022 21:58:04 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 212215C010E;
        Tue, 29 Nov 2022 00:58:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 29 Nov 2022 00:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669701484; x=
        1669787884; bh=toRxxeDncESQ5ly6fHLcJiv4LuWMVHyJPEIjPKru2Cg=; b=G
        nNXEBVXe4/fRb0d2elSjodffbQpUW6HTYxjt5noLwqTcLzbPnXgg4kZXhJ+y+N5A
        63IexRDGMr0sBbpXHlKacen0AsPhQwg2JvhVDyKI2pG7aYuyPox1aPYqQUAGS0vS
        DKeCqWIGOhjKD0RE65S1WrmryKdl4QJPy8lD1IOMzAEwXLDuZv3xc46Fbk+1//ew
        G8UJ15pOIM10t00bTipGEopPFXgxuxjcFN7ZgdPhO9ITMWqkVGyZ2hAjpAdaLvB+
        NZVOyqD6mBcAgwa+Kv7NPOMWKMT9+Z7AW/0Z802kkbFhmd8J3zOX7HtjB68zqSFF
        ThWfwj8i8svWWkQkoAz3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669701484; x=
        1669787884; bh=toRxxeDncESQ5ly6fHLcJiv4LuWMVHyJPEIjPKru2Cg=; b=e
        0O86b1KyCXPKIzyCduorHpOyPLo0c6fqtE4XdsEkGMVNoFjJ2UcVu/t32BDxw1F6
        VZopeONoAKs7vOX9QKO9QURn22eI6uXzk6xD3UGZ2HknF2z072r/FSJlxOy62QDP
        G/L+tmztMysaR1FeePGQiQQhF+kShkgO8o2uh/vR7MddHxsuNFQ+NZAqu/T2Aj+1
        9mlV8uaoC3yt3ATjcnbMFMDZn5+RQpz3FGhujsllztySNRLdo+Fl8UPBH074w5Y5
        rhH/cz4bWStDGX/NVpaCTy/x46eI7Me85xrDFeUWIsbGplTToygg9X6wOPAgCth7
        W/32C2sZ7DsrH/vIr2tzA==
X-ME-Sender: <xms:a5-FY0FPzggBOzOAbZJzLMxv5rdphYcOlbFwbSRStQOkMzWXYun95Q>
    <xme:a5-FY9VA7tBLpwflzxJjbXD9RXnomVL1y_mc9_injyfdvzM1Z2PaS4QYc-hfVWYst
    Q9tHpaoyh3soDlKsQ>
X-ME-Received: <xmr:a5-FY-JQbXX1E2z6nW9tN1zo2jNt7d7fU68O-UuJFaxaLovHL5msujne5iPVjqpOdUtET5wfNpf433hQGNtW2CqwWfp8RcWIcnIlymyaWSycy3sDh4lYgnSJDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjeefgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
    jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:a5-FY2HocQdN1pJKOSMsFwiuscapQ4Xvpw3i2_3L8LwbxA_kFBWFGA>
    <xmx:a5-FY6Xb9hVl1F91w-jl6U9WyWdio59MDEfHim9K3JV5jNB13041fA>
    <xmx:a5-FY5NfdDaSOUg18SOEOOeRGC-6D6y6PlhhvAt4nJ8CdpQ_hbHfxg>
    <xmx:bJ-FYzfOF2aBaFBgeiZqf2JlqgskeJ94j-vLJd08k8E4blXzoRLWFw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Nov 2022 00:58:02 -0500 (EST)
Message-ID: <565e1861-7052-9bd3-e7ba-e590bd91cf20@sholland.org>
Date:   Mon, 28 Nov 2022 23:58:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
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
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <bf8e33fd-a752-d5d5-859e-14302d069f2d@sholland.org>
 <CA+V-a8sz4i_wenTyA5tVTVB8dQWLmuXCf3CGYOPC+C07GJ8WTw@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 7/7] soc: renesas: Add L2 cache management for RZ/Five
 SoC
In-Reply-To: <CA+V-a8sz4i_wenTyA5tVTVB8dQWLmuXCf3CGYOPC+C07GJ8WTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/22 15:09, Lad, Prabhakar wrote:
>>> +     if (!ax45mp_priv->l2c_base) {
>>> +             ret = -ENOMEM;
>>> +             goto l2c_err;
>>> +     }
>>> +
>>> +     ret = ax45mp_configure_l2_cache(np);
>>> +     if (ret)
>>> +             goto l2c_err;
>>> +
>>> +     ret = ax45mp_configure_pma_regions(np);
>>> +     if (ret)
>>> +             goto l2c_err;
>>> +
>>> +     static_branch_disable(&ax45mp_l2c_configured);
>>
>> Instead of enabling this before the probe function, and disabling it
>> afterward, just enable it once here, in the success case. Then you can
>> drop the !ax45mp_priv check in the functions above.
>>
> I think I had tried it but static_branch_unlikely() was always returning true.

You use DEFINE_STATIC_KEY_FALSE above, so static_branch_unlikely()
should return false until you call static_branch_enable().

>> And none of the functions would get called anyway if the alternative is
>> not applied. I suppose it's not possible to do some of this probe logic
>> in the alternative check function?
>>
> you mean to check in the vendor errata patch function to see if this
> driver has probed?

I meant to do the equivalent of:

+     ax45mp_priv->ucctl_ok = ax45mp_cpu_cache_controlable();
+     ax45mp_priv->l2cache_enabled = ax45mp_cpu_l2c_ctl_status() &
AX45MP_L2_CACHE_CTL_CEN_MASK;

in the errata function, since that decides if the cache maintenance
functions actually do anything. But ax45mp_cpu_l2c_ctl_status() gets the
MMIO address from the DT, and trying to do that from the errata function
could get ugly, so maybe it is not a good suggestion.

Regards,
Samuel

