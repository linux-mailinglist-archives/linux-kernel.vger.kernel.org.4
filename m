Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4578961A726
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 04:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiKEDCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 23:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKEDC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 23:02:27 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CAC419B9;
        Fri,  4 Nov 2022 20:02:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D50213200495;
        Fri,  4 Nov 2022 23:02:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 04 Nov 2022 23:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1667617345; x=
        1667703745; bh=XdWUMaONz6fIzha2orHqw2vz8cwoxNUELokI/bAeGp4=; b=h
        5SE6CyJwLH64nMQYli6nTF3VXbc+YlcIftp9+X2Hp5gdX4W7zpN5UVsHexkksV2r
        oEzFxrvWzoO52ht0tN5zg9Oc8EQAcyj+LoKsSr+sAhqwMSuOOEru71A2FJHd5QsP
        j6coAsbVSEdbWb5jZPMkvcSp3n/FAtd3mzLrAGtshJfxXfJqIBGiFNVR2blfu4V+
        HNjqEiL1UTe0xCGjyXFfCwPu9kqnqC6QNR1j3zYz/OExnpNUCRDousZcIv248RQZ
        De79/UdQ1LUx14QP4mWCKFkzj8Jec99FVZ6QF/Zo7bsLMbrwcG4Lwk4gTn3OnwPw
        A5V6b2DBHBnzAb5mK1FQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667617345; x=
        1667703745; bh=XdWUMaONz6fIzha2orHqw2vz8cwoxNUELokI/bAeGp4=; b=Y
        viCET6w0r2vwfXun/tbF2F/Dn1j1LttmPaOmfjzCPPw50Ys26a7UFH13N+TFasxB
        Do5jz6wtXt8vYM/wj0DE4P/5TUf4I8mY4Dpu3ZBRJCAYWYjCzuUmr8Hl34EfsXci
        6w0jd5WbhItBdGSGUntRLW3LyojyE3OiRR21MOrz0VFGocp7nlARU+d2ZKu2kqFV
        orpDEUwwUnSYlU8Hpz6If5lLx35MMwN91do8Nx2gm/X9rq6xQgLP+Yi0JIS+RO02
        xBke2Ed6EBEnGCwmKpNpkdlxEtDBeKYOwno/DB54lhXUuCD4RONwuuQBE9ozgGtE
        BO0NP73gon4aTLfyA/XKA==
X-ME-Sender: <xms:QdJlYx9QHtaawehSuJdmlOB1L2Qu6XsB_5Pr_lTMqHxD6pYETQHKew>
    <xme:QdJlY1sTbm1K6WsHmjuIWzsJ7RdP1BkLFnvq6a9vmBdzdur73zsDl0xMhpvZFpL-j
    bI_JXVpQijr1IhBhg>
X-ME-Received: <xmr:QdJlY_BXhjbVPAIRX76M9d1KkiVsn7209Pved9jZTZHQrPU9QEmdP8AZIg-NOwjDHnLiXhosyIrtqcHJB7_FBzEWIx51p7MPfi58xkq6BlDz8x3qdLv84DlO-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddvgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
    tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:QdJlY1d9WGC-gT7QL-MAK_XVSSwFiIixUbv3CdnfMrnPmG0_az-sBw>
    <xmx:QdJlY2NMwcA8JleC9mX4UBfbQQuD1U9-rgVdxt8xb5pK_4OzKW3Vhg>
    <xmx:QdJlY3kUGYP9O6uptnC7IVDkWPK73d40sNLnXUWR-JzOmXFCb7SM9A>
    <xmx:QdJlY9qh8693Yx8ZEOjepxnMb419xZSDlr5W1r9UqPcDXTI4PlckSw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Nov 2022 23:02:24 -0400 (EDT)
Message-ID: <91f6bf25-10a4-eb38-8d6d-14408b8e5e0d@sholland.org>
Date:   Fri, 4 Nov 2022 22:02:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/3] media: dt-bindings: media: Add Allwinner H6
 Deinterlace binding
Content-Language: en-US
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221101123201.3021129-1-jernej.skrabec@gmail.com>
 <20221101123201.3021129-2-jernej.skrabec@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221101123201.3021129-2-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/22 07:31, Jernej Skrabec wrote:
> Allwinner H6 Deinterlace core is used for deinterlacing interlaced video
> content.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  .../allwinner,sun50i-h6-deinterlace.yaml      | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun50i-h6-deinterlace.yaml

Reviewed-by: Samuel Holland <samuel@sholland.org>

