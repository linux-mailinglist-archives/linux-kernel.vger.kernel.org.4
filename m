Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898F9708E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 04:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjESCy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 22:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESCyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 22:54:24 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3639E1713;
        Thu, 18 May 2023 19:53:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A1E393200921;
        Thu, 18 May 2023 22:53:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 18 May 2023 22:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684464796; x=1684551196; bh=7042GrMdjbKnQZpgJlsRJ2HsrtNbk/oIz70
        Gd2zyuLU=; b=Gewg1dPn8EgXkzxAFPGioFMbOMxu4j/PSDmSj7vF4Sgv9v2gole
        f4HBtIic7YjUV1bVFFGPej35NIbmHHpoHvuwpUkF/7L+O1f4+d2uQfmqEVIpYAnm
        0R7vvNGJfWeNeK7loh8VWoDWGS3YAZ4wYE4mnkQLaKcJYTRArXZ3fBG94Y2jEZtk
        8bUckHgUeRHwyGJSgC0eGdHOHZoqPA6meVinJ22oUY0ZAcdB2X8hlK2cAZsmB6oy
        0MpKp0GVrboth1rgpa95b/gHReUc+/twIKPHncP76RhrYULuEHjIgoySggucMrYi
        PJ5PYmEcohaWV9qBybfTvsg7x5riW34JL0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684464796; x=1684551196; bh=7042GrMdjbKnQZpgJlsRJ2HsrtNbk/oIz70
        Gd2zyuLU=; b=tAIbvOz4XKrYbE8NSEh/vEAYIgqm+8mqTaIe0GTVEX+qNhDLKt0
        pDZvDpEViqMLUmh7vVitsIc1ZZU+k+OdYikUvXhB5R5CXWii3zSv4/25jwU6r85U
        TNsEKPwWNw8K8JAykOLZwHRYhNuxOMW+UFHdNqEi4uJJBomfWILCIuEla7SOARnM
        pwKQ1mJysixrs7rjhsppqe3ALRgbzA2XOqjumccFEBJj0y/ezXcxrnt3R7AdS+Dy
        46EYdfGhidvRfTrw4wmy7L9Mf0XfJiY+oc0FP2A1+TQUWTkHoTDfA5MkQXZll1hC
        x6EA4+IICgPbgWwltf8lHHHboEiyWyZ9uKQ==
X-ME-Sender: <xms:m-RmZDMPAZIZaEZe9d9-Pm2B6bQ8qFzd1CajBu_U5njRuo6RKbiRbg>
    <xme:m-RmZN9mFaP_E8ZBP4-BmlmUXvdMZ7itWFrqiZFNWTBQA-EMaK_txcROMB7ZqMrim
    oYEQxfizQG_mvKEtQ>
X-ME-Received: <xmr:m-RmZCR_fdnV9qyw5uKvEpqvwj4ZVJktbIQpVgMR4LOo8v12sLr-YQzhSvpcHJOe4m9uybBycW_xy_aTtHEUjp0aM_123OkIqf62D2_pvHXOqKdjITp-Ob_dmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeehleeivdehgfelveekiefhgfeuteetvedtvdffgffgudefjeeu
    heehueefhfevvdenucffohhmrghinhepsghouhhffhgrlhholhgrsgdrtghomhdpghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:m-RmZHvmvAwDhcveCh4iFeiW4GzsQyMLWv2BM026vDOeOlsqCCRqgQ>
    <xmx:m-RmZLdoKIMUl2yQUFLinMis0t6WByDMmSV5qbZQmEfCwYAVDaYdfA>
    <xmx:m-RmZD2c4-HrTnXEQbWPxld6MLJV6kLyppVEZP5cY-dlm-qMCLYnnA>
    <xmx:nORmZD9TZtE7u5hk5RI5EvW_3TrHYSJYpwLPArK1ApEFvVtv5vxB1w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 May 2023 22:53:13 -0400 (EDT)
Message-ID: <a45c9193-aa63-650f-dbb3-14b6c3f74eeb@sholland.org>
Date:   Thu, 18 May 2023 21:53:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-2-jszhang@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 01/10] dt-bindings: vendor-prefixes: add bouffalolab
In-Reply-To: <20230518152244.2178-2-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

Thanks for updating this series!

On 5/18/23 10:22, Jisheng Zhang wrote:
> In the following commits, we will support bl808 SoC which is from
> Bouffalo Lab Technology (Nanjing) Co., Ltd.
> 
> Add bouffalolab vendor prefix binding.
> 
> Link: https://en.bouffalolab.com/
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 82d39ab0231b..3566346f2f9e 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -200,6 +200,8 @@ patternProperties:
>      description: BOE Technology Group Co., Ltd.
>    "^bosch,.*":
>      description: Bosch Sensortec GmbH
> +  "^bouffalolab,.*":
> +    description: Bouffalo Lab Technology (Nanjing) Co., Ltd.

Have you thought about using the "bflb" abbreviation as the vendor
prefix, like you use throughout the driver code? This would save quite
some space in the DTB, and seems to be the most common variant seen in
the vendor SDK:

bouffalo_sdk$ git grep -i bflb | wc -l
14364
bouffalo_sdk$ git grep -i bouffalo | wc -l
1042
bouffalo_sdk$ git grep -i bouffalolab | wc -l
179

So that is what we were using for bringing up Linux and U-Boot over at
https://github.com/openbouffalo.

On the other hand, "bouffalolab" is certainly accurate as well, so I
understand if you prefer it. And we will of course adapt to whatever
gets merged, since our goal is upstreaming.

The vendor code drop[1] provided only one example, "bflb-uart,uart0",
which is not very helpful. Maybe you have received further information
from them?

What do you think?

Regards,
Samuel

[1]:
https://github.com/bouffalolab/bl808_linux/blob/main/linux-5.10.4-808/drivers/tty/serial/bflb_uart.c#L700

