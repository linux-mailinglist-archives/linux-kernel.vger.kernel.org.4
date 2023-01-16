Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D9066BA09
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjAPJQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjAPJPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:15:13 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDD410D0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:15:11 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ss4so59265136ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnpTskfRMZwbhoXI1688tXbnxOI+uqcxkW8rKzQPJF0=;
        b=m4IVp1VF1AVyWFIoFgQ+j3t1BG3CRcwwd05JdKhKUPxd4dsUG4QGhtZuzNO4IUndoj
         e8sa6VR7TUOHzhEKU9PGrE9gbUcElaVYztwgFcTRH1yNc5PfCE+tikGfj/syqMyEioIC
         ZtUyyqHA0fRd0zYvDLA0O5PNmw7GVPmKLvigdN3+EhPoInUScgget3EiYvyO4rWe8q47
         dwBsX3lMujufTtRxKg7qdxujdaEhQqvBdw9llDYA5beiKHHkwhInQ6RxK91ltNLDLDox
         Jtt/aSp3ghk9Stjyquu/BFN/BBj7Z/9B8S1l1in99jk1W86WVKtp+W0272MfZIVpnJLL
         H9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnpTskfRMZwbhoXI1688tXbnxOI+uqcxkW8rKzQPJF0=;
        b=ojCXKf9wTm95Oxawg8PIgGe9NQWyHDTsE3Y+GG1XQ2GCC1g7i0MdEY0oDH4cFj8kj4
         0Om2Wqs9bClPGXXfSvcFvHFGodabo69Dj/DGxWeoVZ18m4PNRMfGf8Zo3LAY1HW9t2Vo
         J1mU6glVIlm1unEDM+dtnGCYfLWeTm0Ce84ctbU9ZcxcXD6bCH68FGwORvr8MoaPMCOF
         7TgBm+nkjZeDD0hnQ5b5w6LCQmClvy/fgVFlLazl+e+tEJhyKvXYgSKw8S2ZQSxZ9xAs
         ga/IIhdClgTWXM+WLvHkB8lUPDUh63QSEWL5HTq81DYJVF2R8/qRsDObDZGEI55xkS4g
         vc3g==
X-Gm-Message-State: AFqh2krkAsuXD0DgdHpZQnY7ZHOMfnoAJKMopq5/FprvhVO/Zu9CtFb2
        a2iPM3MI+vdW/n1m8zM9L/wwHA==
X-Google-Smtp-Source: AMrXdXtHdbDYcO9Ks0UVEetcITaXZxEwWZuDqueod98kTKdRACNQyJi2I6QGy217SMy0kJu4Bk4YmA==
X-Received: by 2002:a17:906:d217:b0:7c1:6fc:6048 with SMTP id w23-20020a170906d21700b007c106fc6048mr73025525ejz.24.1673860510197;
        Mon, 16 Jan 2023 01:15:10 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k22-20020a1709063fd600b00862497eafb2sm5522939ejj.103.2023.01.16.01.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 01:15:09 -0800 (PST)
Message-ID: <01425fed-b782-1cde-a808-eceee12bbf46@linaro.org>
Date:   Mon, 16 Jan 2023 10:15:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: reset: imx-src: add syscon and
 simple-mfd compatibles
Content-Language: en-US
To:     Bastian Krause <bst@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
References: <20230113-syscon-child-mfd-v1-0-0dd31b7de373@pengutronix.de>
 <20230113-syscon-child-mfd-v1-1-0dd31b7de373@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113-syscon-child-mfd-v1-1-0dd31b7de373@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 18:32, Bastian Krause wrote:
> This allows passing the reboot mode from the OS to the bootloader via the
> syscon-reboot-mode binding. Add a "simple-mfd" to support probing such a
> child node. The actual reboot mode node could then be defined in a
> board device-tree or fixed up by the bootloader.
> 
> Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Signed-off-by: Bastian Krause <bst@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/reset/fsl,imx-src.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml b/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
> index b11ac533f914c..9ec734e14e9f5 100644
> --- a/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
> +++ b/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
> @@ -38,6 +38,8 @@ properties:
>        - items:
>            - const: "fsl,imx6q-src"
>            - const: "fsl,imx51-src"
> +          - const: "syscon"
> +          - const: "simple-mfd"

This is not sufficient. You can easily check it by yourself - add
syscon-reboot-mode node and run dtbs_check.

Best regards,
Krzysztof

