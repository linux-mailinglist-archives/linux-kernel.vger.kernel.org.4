Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905B16271B6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 19:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiKMSmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 13:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiKMSmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 13:42:42 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5441004F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:42:41 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 052DA5C004E;
        Sun, 13 Nov 2022 13:42:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 13 Nov 2022 13:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1668364958; x=
        1668451358; bh=ybooOqqk/Ihrtuboknoyno4ISJ9N4IMWZ9ys6fexnjs=; b=u
        mCnuAzhm9wOAuiVAC9F9NLpkibdhyXnDrHFB5cOWKfOx4KVnsTjd6TY7WrrpAmwb
        /Ogtku1ueLbyLdg4IoB3Mcv89eOGWH5D96CCPDHqmxjVkQqxWTKppQ0bd9oLGso1
        GVaHsLIKrmKSQ/6QD3xkCxpyrtG7zB3vzhQg0m31+nD7u4gHcJAMxlZpdlLXnixm
        gpd55loEerPyih2cc5qAxBuC8SThZ10RgEw3/CvS3Kz+YCYuiusjouA0QKO7sNfy
        wpBnKmwjNAzXZIg27Z5poyG4UBhV5NVIdPbOUP7VgKSd8d7MEpoHgBv4Kv38JYk5
        t5eeyRWeSEonSCWagwWyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668364958; x=
        1668451358; bh=ybooOqqk/Ihrtuboknoyno4ISJ9N4IMWZ9ys6fexnjs=; b=g
        PB3tD85wCijD2sYGfAm5m9JLGfITQ3NoiWQodB8OK+0i5re78e9ciZhme9pNDn+I
        MpVG02iqltrlZ/GbqaE/iG9t+Hs37d6CSWCkcgWcoabtUtRgEw/JXnv7pP0QF2xe
        8PTtKzsJDvVD587639RcFf7Qu2VlCnpR7tDb03bzSDtkS8FkhPXekVF3VNP2yGHK
        5oYu/eOu6d9t0YqHldiS+cfGiF6jVtS4AFKhNN1JNLNRbUuU33xjj5VtzkpYQQ/5
        L9i75U5dY6QNbgJ/0QTUSnuq+04p4+Zh/MoJlrxPW3wZyYHCNlmySvwu7/PaUm7d
        +kEtgI4rK+038R7HP/t7g==
X-ME-Sender: <xms:nDpxY28iYEHVbyq-atsSn0M2HZVLYAyY0rj5MFKAPO2ZLsYlwk7Iww>
    <xme:nDpxY2t_KH2IuHq4DpwzKlmI7apULYd3LmBsjNo-X7fSzDDQkfL16Gw7QIWiJnnHf
    tmVpIT1t2CSNWChFw>
X-ME-Received: <xmr:nDpxY8C6vOSmMExtpQrdhOXurBqyAePaYi6ncfQxmFC1gUsGrLzDQfcFLS0k98TjHI1SaoOVVPJynZBvzDMwreVH62s5lO0cVZlVaVkHeVtzEFv7mNp4I2kU0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedtgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ejredttdefjeenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghl
    sehshhholhhlrghnugdrohhrgheqnecuggftrfgrthhtvghrnhepkeejleelfeeitdfhtd
    fgkeeghedufeduueegffdvhfdukeelleeftdetjeehuddtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnug
    drohhrgh
X-ME-Proxy: <xmx:nDpxY-dvB-KBdRYcrkkiLUN7-p4CkAVfYaoZF0YfV3BGYwoNuUf-Pw>
    <xmx:nDpxY7Pz66KLVt6a2UNXQPuckKv12ND7KuXYHeayrnZKOTOCQ7Td9w>
    <xmx:nDpxY4kxVL-4280k04rPvGHG65aa3lhKF0IJpzzEk6UyAxmL7XY6CQ>
    <xmx:njpxY4deUl2zWAp6AQSHNt23P0963j4Bo0JxZJ6N3fLn2A1tfB0SEA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 13:42:35 -0500 (EST)
Message-ID: <f11d70cd-6d64-9023-f2f9-9697ada5e115@sholland.org>
Date:   Sun, 13 Nov 2022 12:42:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 03/18] mfd: axp20x: Replace irqchip mask_invert with
 unmask_base
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, lee@kernel.org
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, brgl@bgdev.pl,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-4-aidanmacdonald.0x0@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221112151835.39059-4-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/22 09:18, Aidan MacDonald wrote:
> Remove use of the deprecated mask_invert flag. Inverted mask
> registers (where a '1' bit enables an IRQ) can be described more
> directly as an unmask register.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/mfd/axp20x.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)

Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org>

