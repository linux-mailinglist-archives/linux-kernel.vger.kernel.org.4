Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8827E6272B2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 22:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbiKMVWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 16:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiKMVV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 16:21:56 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB9CFD2C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 13:21:55 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 29A165C0040;
        Sun, 13 Nov 2022 16:21:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 13 Nov 2022 16:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1668374513; x=
        1668460913; bh=41XsqqrtZaCPmz3R0QiN55X2zsU649LxW6CyggTOBgQ=; b=e
        Omn3Suo8Oc0kU4YHCSixyFeJEYm38Y78b24Fn/V9G4kw0RT7/u04fFk1jcHOJ/ol
        vKv55VmLH2JQyfvGY2VE2bhgmpK6V7LypV+nCoupRD7yxHai+a8InmwLl2Iv/vz7
        6ej8jPu98jOFovYs0N+Sf1Lq6L0/1jDwzYWF9YQ/CYs9Gd1EkLXaqb4OkVjgL76p
        eVm6bzPL/KPOwd49ykUjAz5mK1DB8RpB57yZSIvw65DlI+LUkDKrXyi8T4+rQr9/
        OtWqOLrv8+UqzAuml6CMIKvHIOCilKvihoYloqcUrWm5goMdZBuLEuuVrwJYNHCi
        9p1KLirsqBkN0A94FLRBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668374513; x=
        1668460913; bh=41XsqqrtZaCPmz3R0QiN55X2zsU649LxW6CyggTOBgQ=; b=u
        B3NqL3I2749BLXJ+Til1k7oa1Efk1kp63RGOoCmuhhATtjjbFOlKKimX/Va3Scfn
        fPVvZJISiFkO/rZK7h5gaXSVv1Vdmz3mlvveaGgBhytTeWeZRj44ZDzzeG1PKQlM
        Q2VRCTMrgJ+PfDAEIlXH6JftTEZHgHhCsMZ0EPMPqcBOT0V9E6o/j5D/UyHLj+Y3
        i3gyG81bBfinYtvP7FrdvaHrnpgUoFBA9hPNo5YZmYys/20Xt6lv0MEJ6hWf+0Q+
        MEE7boFJTj/kN7uu0ckyheep1/aKqfgPZk+tpPVTNseOu/+QZt45evQo68n32X8G
        v/0W+4YtNVd9M3XOQyD4Q==
X-ME-Sender: <xms:8F9xY4oU_T0ldh0R8d9Tuz7e7tj_0DY2NNQr9C8TQAtm-Gi9kV43jw>
    <xme:8F9xY-rWY6iBMzFOfRp03ziiqkGhQZIB-xW4NiHxaFy0B8UhcqlQrxvVLDGVf2ELM
    SXFSlLuNGm_xfXlTg>
X-ME-Received: <xmr:8F9xY9MVsWhYxhLOuGK2MbEa2pRHp7YaHwur4kj-0DNKDBwQovJ4GDjuYB0m5dnw-ocO91wLo8VUOA0B0z_RzAJYErAuJZ_cLJmEqoF0yb62keajCjp-EWrthQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedtgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefgtdfgleffkeevledvueetteefgfellefhjeetieeuhfehteeu
    feefgfehfeevfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:8F9xY_5IaQpIdgm6G1R1y28qH7A8_BvAxjKKCHZAk13vn6bypLvQmA>
    <xmx:8F9xY34M1NAa55Dx27DpjmtsEU0UiB63VSskjIhcjpy3AkYtvFEV1Q>
    <xmx:8F9xY_ghkbbiHJv5sYkykeD3Pt9Y6uUdWROJoxDrKGRGbRWDpVJXcw>
    <xmx:8V9xY0uwYHFr7XGwuCnBFOQFYodVp2-yLTPaCbej-yVAdR9UpTMgJw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 16:21:51 -0500 (EST)
Message-ID: <d28c69b9-0b78-aa96-1e73-6ef81539fa8b@sholland.org>
Date:   Sun, 13 Nov 2022 15:21:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] riscv: mm: Proper page permissions after initmem free
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>
References: <20221112113543.3165646-1-bjorn@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221112113543.3165646-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/22 05:35, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> 64-bit RISC-V kernels have the kernel image mapped separately, and in
> addition to the linear map. When the kernel is loaded, the linear map
> of kernel image is set to PAGE_READ permission, and the kernel map is
> set to PAGE_READ and PAGE_EXEC.
> 
> When the initmem is freed, the corresponding pages in the linear map
> should be restored to PAGE_READ and PAGE_WRITE. The corresponding
> pages in the kernel map should also be restored to PAGE_READ and
> PAGE_WRITE, by removing the PAGE_EXEC permission, and adding
> PAGE_WRITE.
> 
> This is not the case. For 64-bit kernels, only the linear map is
> restored to its proper page permissions at initmem free, and not the
> kernelmap.
> 
> In practise this results in that the kernel can potentially jump to
> dead __init code, and start executing invalid 0xcc instructions,
> without getting an exception.
> 
> Restore the freed initmem properly, by setting both the alias (kernel
> map) and the linear map to the correct permissions.
> 
> Fixes: e5c35fa04019 ("riscv: Map the kernel with correct permissions the first time")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  arch/riscv/kernel/setup.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org> # on D1

