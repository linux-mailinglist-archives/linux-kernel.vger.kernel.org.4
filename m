Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99241708E66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjESDgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjESDgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:36:40 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FD112F;
        Thu, 18 May 2023 20:36:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6AF39320093A;
        Thu, 18 May 2023 23:36:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 18 May 2023 23:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684467397; x=1684553797; bh=diU1oZ3wF+1gcYWcuOQa1MF4aBn8RcnRjwd
        RnfN9NLI=; b=PcgdDiU25qGVCNKlDw3lx6EEI704++3C4s7rTxt29UIcctD5kXu
        jkT5jfKwKQAPXlqGgNbbPIjg+uozJwpfp93sod2rvuIbPYT1gZjvnJ+6dpQl0e8f
        7HtZ9e+coitfEXz27c8VWK7w81tUGkdCxiTYwvzc2/OFeoLWoT3pf2tTAhngD/xq
        YPThqbUYQGvEcYgL9GmRZSeXb4a/tixVwFU9P8O9X1AUUlKqh0o0RkR5PT+VCT4C
        FN7evi0S0ytQ6M7bzqPjoR3TULf/48+RO3k4m9olUS+Hhxz9wxIndaeRu0KnlhsB
        onl9Rmw1oIt07OmXToX+C1UdOqsYByZVVjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684467397; x=1684553797; bh=diU1oZ3wF+1gcYWcuOQa1MF4aBn8RcnRjwd
        RnfN9NLI=; b=BsCIbs3RnaBCP93urIOn5VhksdBzszTdcY2uhpmL6cDK+g1bY9C
        aPf07j3Swjds90Dk4m/N2luVy3OZkqSkbWsJKRgsay5VD4pyG23Wk4iT2TS8qq5I
        H3kKglNKmfRbXrEn+Ee1MvwM89dKrNoePrFentQtJal6H/BayroWfjkdsji4pDE4
        jfnvvoLEuGio4nNZXI0CLoJX4SPtV9BYykAvhqkE7ECjE+0s/XvGowl1wpw13Ry+
        zKaAQxn0wbQazqm7Xt67hB4PsPs8z1nlfwiieFbaWtmX/M7k/wakM5aDyedIE5q1
        bcr3H8XbYK0DrTXlc9A+CgWC/UaYytKSqww==
X-ME-Sender: <xms:xO5mZHiBQIWg6IR8Q5E86qmqRUFLujHm6iIEPACmMRk8qhWOxdhhPQ>
    <xme:xO5mZEAMX2MHn_MqiBmcJE8xBGMZ2c-9qVuOP3WRFRrZJ4x7ehrDqNVVW_x2WSx3V
    QPEnEdg3XKk13Svkw>
X-ME-Received: <xmr:xO5mZHEP2natGNvefyJlca2SueZnA8LygwImSdgTOvKccLZyjDcVDEnV2TlIvrmOoej6LQ2uH5Ql5M6hPSXvKiO7dmA5nYkyT0GyCnnJwnXSKQ6nM9UHyL9y0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejgfffhfdujeeftdeuudeguedttefgieetffffheejuefguedv
    heejteeftdfftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:xO5mZESFxwNEqLukoRaw-a01QgYzKvf2lNcav7j61kEnq5nuostvHg>
    <xmx:xO5mZEyaouxYljFYYKajxlhbrXsxPqiDQ6IgKILX7seS_qjEG8ksUg>
    <xmx:xO5mZK6W0n4Wy8t8BKhfKvWn5enrbBJqRN_T5jDorhKhwzlumZlXWw>
    <xmx:xe5mZJKaxnVRK1HdtxpDBz4pZ90i-3_70XEujgeYLEBjSH58GlcOlA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 May 2023 23:36:35 -0400 (EDT)
Message-ID: <fb80487a-9f79-746f-3bfc-4b9eea2ce8eb@sholland.org>
Date:   Thu, 18 May 2023 22:36:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
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
 <20230518152244.2178-3-jszhang@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 02/10] dt-bindings: interrupt-controller: Add
 bouffalolab bl808 plic
In-Reply-To: <20230518152244.2178-3-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 10:22, Jisheng Zhang wrote:
> Add compatible string for bouffalolab bl808 plic.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)

Indeed, this is a T-HEAD C906. So ignoring the question I raised about
the vendor prefix:

Reviewed-by: Samuel Holland <samuel@sholland.org>

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index f75736a061af..3f9439b0c163 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -65,6 +65,7 @@ properties:
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-plic
> +              - bouffalolab,bl808-plic
>            - const: thead,c900-plic
>        - items:
>            - const: sifive,plic-1.0.0

