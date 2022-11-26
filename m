Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9EF63982A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKZTjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKZTjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:39:19 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CFB1A824;
        Sat, 26 Nov 2022 11:39:16 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D81D75C00B7;
        Sat, 26 Nov 2022 14:39:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 26 Nov 2022 14:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669491555; x=
        1669577955; bh=0Xacy2MFR0NStzqlX4jQQv2QXRX4Mm2Xkg6hMAxNiYI=; b=F
        aIpojefdjZ3ipXpZo6YTdFlE8vmSfNU+qvhPx11yUpypsLhSfRRHV9vQCzBDYfWw
        a6UnSfXp3de5XiI+TifetoH0sVuJbY+vkNskFe51z5Rhz63JQRJUSS1HmhA+cK+8
        sHGLeDzA0KKBYT3k2F4NuHKYucSCEli+qHzoUn4B8UIrGkKZ8PboCZVskRO3pVWf
        0exUdSVdLU7t8uBMUYNqIQNDc02M675KYOXb8PHryTmI23eHTQf30iZrE8Peddzc
        qJ4d1uJuhz3MbNLq9Wx1VtUEnICMzkuhU72GfgdpLqn7xLpz+G5bCk6Hf+FYodUT
        e11jKA5oSqv+2rAo5fsJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669491555; x=
        1669577955; bh=0Xacy2MFR0NStzqlX4jQQv2QXRX4Mm2Xkg6hMAxNiYI=; b=x
        HYqKe2eD1pbU8yOC7ItQNuXwKAOuFgiqpeEcO5uvpercZ44w5cEuNY79Z5H9yci4
        OZnVhT+NJIBMdiPR92QT0vWoeg3CKplMpIy4KdLQf+QxW7Hv62WuavO9mmjULAh4
        FWQKxeL4+oa6WBVqrLTjgVerEWqyLxa8xzWJaFnL/R9X3cDcp85G5iNSbQ1UuTgg
        nnYReXr0YYjG9H7WJ935TLaFrWH1QAqkSErl9Pk3AJkbsJ5y0CsupHk6P6beffE4
        RSyFT91gEvfL0XiJLTCJwLI+09B/txo3K5u9Yh0EELhlR4DCkTZ773bRzZwiqgnV
        DDSYPxwpmpFgmTWa58NCA==
X-ME-Sender: <xms:Y2uCY-OFQy8GWAooGDbwA8xXQE2OSmoxikSRT2dKKNPwO9FDUawSVw>
    <xme:Y2uCY88PRFlItwSp2iqBk0bK-DS0_F0chGnScfSkXJ_yp0-URtHIBc5K6E5VRLbId
    4J86XXzpgMUDV1JSA>
X-ME-Received: <xmr:Y2uCY1QNYzQcUe3wnuxTZbit26VXpDjbIicDfw83wAkLWWrjwXUqXqbi08jm5fN7poEAo5_3pmzSaQKvizZGjOp_6floU-8rz5n8sA2bDPz1B8MOR3TGkWAjqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieejgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeekjeelleefiedthfdtgfekgeehudefudeugeffvdfhudekleel
    fedtteejhedutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:Y2uCY-uQebIl79PaIlW3vUggSs2u5lZKJl7tm91i_vzNChaK-yQRTA>
    <xmx:Y2uCY2ea3dReSJp7QD3zyjL5MKd1V39EzbEexNjETaQzlc5qLeA3UQ>
    <xmx:Y2uCYy3k7eRYiPvUgIeeXFkGlmEa8WAoiiH3Z093JpXf5GGKvsO6Ow>
    <xmx:Y2uCY27CkCtxy0FZDlOW_l4nJvPbUd9qC8fjc1Zo1TjLDSb2-WiYtw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 14:39:14 -0500 (EST)
Message-ID: <f9039589-410e-faa9-fc7a-b1e71039dae5@sholland.org>
Date:   Sat, 26 Nov 2022 13:39:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/3] dt-bindings: timer: sifive,clint: add comaptibles for
 T-Head's C9xx
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20221121041757.418645-1-uwu@icenowy.me>
 <20221121041757.418645-2-uwu@icenowy.me>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221121041757.418645-2-uwu@icenowy.me>
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

On 11/20/22 22:17, Icenowy Zheng wrote:
> T-Head C906/C910 CLINT is not compliant to SiFive ones (and even not
> compliant to the newcoming ACLINT spec) because of lack of mtime
> register.
> 
> Add a compatible string formatted like the C9xx-specific PLIC
> compatible, and do not allow a SiFive one as fallback because they're
> not really compliant.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Samuel Holland <samuel@sholland.org>

