Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4CD6271D0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 19:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiKMSsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 13:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiKMSsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 13:48:16 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C661213F65
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:47:56 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 38F285C00A4;
        Sun, 13 Nov 2022 13:47:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 13 Nov 2022 13:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1668365276; x=
        1668451676; bh=jLwAX+ovDwzN5nN9OoV5+TSR0IIzP+kXMF9LXVhDf98=; b=d
        miGapuVqByPWnOswij8ehlKMyYVBmF8G6OtLeCG0h6EFm1oC7/nB1gU65m7cyEVf
        qiFMeKNH/fk4BOykT0ZYgeWTXP39vfYJsiXa6fIvsK+oFssni6THWyZU6AXCBn/M
        BkguG0H7qYKEDB7EYF3T8NDlvi3eOocipiUzOeNzgQlPWNb3Y/iDJ0GLiYaLBbiC
        +bf/aDuhBClIkGhyMW8sFWxehEKNE6E0OXf0atCL9H4ju3QbBDfLeRa5noBfyXYJ
        J7uk3H3PcORMjR3PV3stD4Boe8MHubZq2seo299JN8ffj1GjGJE6l/U17q/BAzuA
        Y8bZpVYeY66BRvAt+BTNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668365276; x=
        1668451676; bh=jLwAX+ovDwzN5nN9OoV5+TSR0IIzP+kXMF9LXVhDf98=; b=w
        mrA9NT/2kXHEXkqd/IkOIVzZIw9IxoFQwOVPzIeLBF5H2iAnzW+zHGfXURRAK2OF
        dXnf7EIrNYymVM/nPBxoAk1PELqiRe9ZRVyBXy8L3KGgJhMBVLkiW6SWjJ+I0833
        gt8pB2c7c4BqBAMjDym4ZXf2ndqvgeOvQPz9Om7aLMyuPRu4DaeBdIubEjWPzfpE
        8PbTUZ2SUBN3Du9djyBuYdk1wjAl0gEiwGuvuw8QQy83qu/MPB5v+ToVUSTw5V42
        SXRMiLGqB26qHYBbcYxk9N8BvYxmlKLFf1MQGV1NWGGPjb5vMVV9SHU1PP8QRlwi
        U97TSbX0ePDL+mm8mJeuw==
X-ME-Sender: <xms:2ztxYyRkHkq2TCkZawmVNjhRrG4dlT20uO7TPMjYf9bpoH1omDre9A>
    <xme:2ztxY3wXD64Wxf7NEHjrXB68Ms3EQJnmE7Nl-j1mnjR6qXzxtzYY8MI6kUMWwiaaW
    kqqRQpPMy4LcmICZw>
X-ME-Received: <xmr:2ztxY_2_NtGu2OOtK_lRisn2Mmv5Gz6TWMH_tvEzg1fNgqK4jplo2i8XObsPqvt_tSl85X_Lf2selCNpK8kWHpnwoYDVdki4wYlfXrosbnd95JsqTiO7GsKBBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedtgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ejredttdefjeenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghl
    sehshhholhhlrghnugdrohhrgheqnecuggftrfgrthhtvghrnhepkeejleelfeeitdfhtd
    fgkeeghedufeduueegffdvhfdukeelleeftdetjeehuddtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnug
    drohhrgh
X-ME-Proxy: <xmx:2ztxY-B47Oz3xWWppG3LKjj_SGN8ZYrr8bhO7JjUPjz3RGlcgq5TFQ>
    <xmx:2ztxY7h7DEBGbeDr15fkznPUNkWCCFLBJsykS-C5f2m1R9VuV9r7EA>
    <xmx:2ztxY6qZ_pqZZSGQZTJB55qGWevY3aqbmcinPHlWXMfni5xZ41ZXYw>
    <xmx:3DtxY6SfhmOOQ-ApZFNsFw0HTrdK17FHH1xQjZD7GNWEEg2lrvtD0Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 13:47:53 -0500 (EST)
Message-ID: <8bb6e2e2-267d-203a-f915-3e2c44f6d8ba@sholland.org>
Date:   Sun, 13 Nov 2022 12:47:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 16/18] mfd: sun4i-gpadc: Replace irqchip mask_invert with
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
 <20221112151835.39059-17-aidanmacdonald.0x0@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221112151835.39059-17-aidanmacdonald.0x0@gmail.com>
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

Reviewed-by: Samuel Holland <samuel@sholland.org>

