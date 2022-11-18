Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C8D630594
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 00:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbiKRX4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 18:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiKRXzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 18:55:00 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51396BE84B;
        Fri, 18 Nov 2022 15:28:02 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BCE6C5C0452;
        Fri, 18 Nov 2022 18:28:01 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Fri, 18 Nov 2022 18:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1668814081; x=1668900481; bh=Em
        Q0dI/Gjx0666r9UJYHPwl0Uf9CBk7ouATv1q7n5/I=; b=hBYuZJsLbPJkH0T13B
        dQlwf74qszBFR7+i+3xGPK+q8efi4WSCtF+rfsikE6W4LuRpfa3I0b92mo4JHYlH
        IL5jfgfq1oPz577dxNXW+4Zb2AQYso6xG23qADFq8Z9IOK1tXPS/s106nBdRPc+S
        imIjPE1IZrdBR+c12yqMrDXTosA/xOUQw1HoGWE4m4EH9mro0XkElKxTastAJg2e
        hT71y+k3WAYxJW43kXUlUbekyKqrwnA6779egUk1hVPXoTQ3xSWo8QfJFrJ/jYif
        YKFIyDfOniyLHyBEG0MCx9fsMX8SfWF9BQ8QIAhY3RfqY4dl+hyXefDudOYuAnio
        9WTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668814081; x=1668900481; bh=EmQ0dI/Gjx0666r9UJYHPwl0Uf9C
        Bk7ouATv1q7n5/I=; b=lhxgsfh6+XIQCHG64wuk4L3O9Y2mQoJdwdwKyuyUmlWw
        vdQVX+GyHjkKgLwJW1yxnjFDwOG+3BE4f6O4952Jo6dWVVoyBSiI2MF0nf0ywxCp
        mdPOws7uvsr3JZr4syQusKz6AMYlGT4AFAN/NVuAmRPNqTHWfM4QW3bLbnFZwRom
        Y0BTi2e9hPyQEtz6AmGCmoMhrEieONsvLPWSXEtNNmNlzlIEnDv8W+zl4lg/RM6g
        6AJZkjR/qL0uqSn10l6xwLd4kAIUgmN6v0ikRV1kbTVxzPmp4EDh5LxBojliW6Vw
        hwMykwEaXIHj2yHWk72ZxHbcxJKgqBWTv7xyWG7QjA==
X-ME-Sender: <xms:ARV4YytcmM5encL_jFy9qzh1J1MGTWgQPN1GVelQnZe6PwPybwGx2g>
    <xme:ARV4Y3f8R2PAuc2SVxuZgz7QJ5ip0H5LfsD6Uqn0Pqn8aTUNMl59AjM1Si3EE6Tgc
    u84-znVpVB3H-m1F6U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomheptehlihhs
    thgrihhruceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrg
    htthgvrhhnpeeukeffkefhjeethedtieegudejvedvhfejleekheefhfdufffhjefgjeei
    heehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:ARV4Y9zAjdmvnzSBrBtzB1LoH-nh_q0SdU39bKjFcDV1nneIoT445A>
    <xmx:ARV4Y9MxVNREu4GfZokXBsnqK7CFVSZqveqBOwhaMS8DlhaTrDTuaA>
    <xmx:ARV4Yy-NZDHYBeQRzwuFhx3zqQKZmjm1fVjw9XZHkEq1CL9CczL9BA>
    <xmx:ARV4Y5lqWBT6WOPeUAS7q7AlKL60TUjtqBPMsH9uLRwIGuS8yMQFqg>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8EBC42D40090; Fri, 18 Nov 2022 18:28:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <6cb6c30b-2670-446a-8425-92d340ab5b90@app.fastmail.com>
In-Reply-To: <20221117190507.87535-2-linmengbo0689@protonmail.com>
References: <20221117190507.87535-1-linmengbo0689@protonmail.com>
 <20221117190507.87535-2-linmengbo0689@protonmail.com>
Date:   Sat, 19 Nov 2022 09:27:39 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-input@vger.kernel.org
Cc:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: input: cyttsp5: document vddio-supply
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022, at 5:05 AM, Lin, Meng-Bo wrote:
> The Samsung touchscreen controllers are often used with external pull-up
> for the interrupt line and the I2C lines, so we might need to enable
> a regulator to bring the lines into usable state. Otherwise, this might
> cause spurious interrupts and reading from I2C will fail.
> 
> Document support for a "vddio-supply" that is enabled by the cyttsp5
> driver so that the regulator gets enabled when needed.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

> ---
> .../devicetree/bindings/input/touchscreen/cypress,tt21000.yaml | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> index 1959ec394768..869a9bdd962f 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> @@ -34,6 +34,9 @@ properties:
>    vdd-supply:
>      description: Regulator for voltage.
>  
> +  vddio-supply:
> +    description: Optional Regulator for I/O voltage.
> +
>    reset-gpios:
>      maxItems: 1
>  
> -- 
> 2.30.2
> 
> 
> 
