Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382BE63CFB9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiK3H1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiK3H1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:27:49 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE492637;
        Tue, 29 Nov 2022 23:27:48 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A410132004CE;
        Wed, 30 Nov 2022 02:27:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 30 Nov 2022 02:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669793266; x=
        1669879666; bh=SNR+K9Qu74FASN1Mi74Byj9LreGIZut1vVkeNJJoQek=; b=u
        QkfV6j4htHuZQb+mEVJ4HguVyyqz3zCgrFJClDQvILgHflXCjPooSSJncNXtEsNv
        FKS3qM0GiQMwNA0cJSqz8kUW5yPdI/p6bBUeCqfxPrGlc37EgjIQyzTT7zUN4NOg
        6rwRI166if01eyUmQjhWIN8Ff5MRLGus3z33BStkzMp4IfSkngHugY03uq5lbbAP
        tf8im/iLmXVz6bDnOJo0xpINCkdtlFFZoawdgxFCBwPromXpNL2iBcqCAexqcvTw
        bYTsZVt01xIXRCI4JVTzukgjTztTl6Zr+5eTFTQrlgfIfBxkFQLbAqobv+bKRKEg
        C/CTgKYgz5nyBo+fpIEnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669793266; x=
        1669879666; bh=SNR+K9Qu74FASN1Mi74Byj9LreGIZut1vVkeNJJoQek=; b=L
        CTWXzkG9y5jYl81O9mw/6WFOD4RGDa6upJFwqq5GH2OctRKDVnnrxVdAio16cvPC
        pfKOz2bBNQkZW9lp5zQUiArWLK2lxaNvcxKA+N15MoZu59F9lh8IBHHBZqAM+9Zn
        uMx6gv8aiS6h6w7iOBAd1hbX/CoNCwbT0M9QCxBQALOP02gU/9n+ahmZsZKhoXb5
        RLvFINtCuTfSH5URMVyddJvQ65MSIKIb+myqNe2SNPuiQExXiWcDsYxoaoR3zFEB
        3cUReQ8YEfJlegP4r0IkSbjMZ2w3uK2O9C9XtFvXDeYxyjL7uS+Mz+4tKN1NrGQQ
        hJyohAUgkO1QDcHRfynKA==
X-ME-Sender: <xms:8QWHYyJjO7zY-b4m1rHqTWPubgZiF_OqTshoA3--Y66VbanmG-UMjg>
    <xme:8QWHY6Ldp6erM07LfqwVKYCQWetsX89E49gYR2mEANwMHb4f2wbpp0mC1NpiGMIhJ
    ZSSkdIQoEz4k_6pCw>
X-ME-Received: <xmr:8QWHYytCUfj6ZDlBuA3tl1k4rpG5EKvdW4oS0vb31jDDQJHA0cgEl60BwPh9_MSMuCBkZ-_cE5wf7K0EFUeQsn0gbcYYtDogMgASvQ5wx-nj1EntoLx7ZD1j5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtddvgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeekjeelleefiedthfdtgfekgeehudefudeugeffvdfhudekleel
    fedtteejhedutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:8QWHY3Y6k0qlKAbL5adX-eZINdEC-5Q_AeSHe6jdjkMj-ovvrGm8Zg>
    <xmx:8QWHY5asQXx5dNpDIEoShx5Cy3tu1IsSGgvjctcFnwisZHNJV-hl5Q>
    <xmx:8QWHYzDcM5gYk9-Wuk6W6WkQj5smWxV02aZvsDp_dgKli464oOwliA>
    <xmx:8gWHY9TbKbvvp68qC2h43SFEBlF7_qXivEzDpQRxKKpYsUjQegwHuw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Nov 2022 02:27:45 -0500 (EST)
Message-ID: <fb3e59ee-2cfc-e7a6-041c-d94fa426fb2a@sholland.org>
Date:   Wed, 30 Nov 2022 01:27:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 8/9] MAINTAINERS: riscv: add entry for Bouffalolab SoC
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-9-jszhang@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221127132448.4034-9-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/22 07:24, Jisheng Zhang wrote:
> Add Jisheng Zhang as Bouffalolab SoC maintainer.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00ff4a2949b8..a6b04249853c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17729,6 +17729,15 @@ F:	arch/riscv/
>  N:	riscv
>  K:	riscv
>  
> +RISC-V BOUFFALOLAB SOC SUPPORT
> +M:	Jisheng Zhang <jszhang@kernel.org>
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> +F:	Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml

I don't think you need to add YAML bindings here, because
get_maintainers.pl will find the maintainers listed inside the files.

Regards,
Samuel

> +F:	arch/riscv/boot/dts/bouffalolab/
> +F:	drivers/tty/serial/bflb_uart.c
> +
>  RISC-V MICROCHIP FPGA SUPPORT
>  M:	Conor Dooley <conor.dooley@microchip.com>
>  M:	Daire McNamara <daire.mcnamara@microchip.com>

