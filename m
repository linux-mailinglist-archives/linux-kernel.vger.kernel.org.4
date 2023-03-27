Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633556CA7F6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjC0Om0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjC0OmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:42:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D9C49DC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:42:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i5so37386530eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679928133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fs5/HM5qqW623t8e8pfj393oYcjttpgt4VndkKlo3JY=;
        b=Z988Tfce6KckbW69GGT1f+rLgV/MW/o7zVagyMUu59Wr5Sw2i26FQ7K1kM/8xqs5rO
         SFkqj4cz/MdK93sh2SViP6ZVURy74oeiGzWU7wfF5X3GwPzB7x9yo5twmnVmgeZCHbqO
         jhd1lSZaP5y9sb1yI2jA6dEHTpRytiKBfAaiS4fttbhaE3BROcnsuIENbQTgxHWoEpQI
         /kt60G71V+R3zQQiaWRLn4Ul77ur05MrFuwZkgIcBVpdyRW9hjpSRPtkcgwwKm13JzwJ
         9A9MnD7UWQ0+Ricppxo23UoVB98EJ8pcdjJcG5P4AaTm1FQNGYt4wMUhXkKy7kAyf4QM
         K61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679928133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs5/HM5qqW623t8e8pfj393oYcjttpgt4VndkKlo3JY=;
        b=XbtPf81RXgamEKiRbCHtBMo7UNWBWu8jjRwIKw/VAdobnsb5JIgEGNOiq9kqitR4dw
         zW447IrUSRGNDIQf+GccdOPPBtNvwWcLKURI1ND6qpZN+aG+GnO5tiSehiZGzFDMmy2/
         imCXTN+3Ekkf06CK34MTZVhgEZr8lyipUWVY57YZ+E2ja2vFzCOxd2xyZ6bntr0fSxrJ
         Q5WaHp0m67AFI4ABNQiJGm2KsjW57E1MlcU0lF3AQbv5gbdD/XVqjTbtu6fquMdqbALm
         lz51Xzji8OTCcoB+jhwKGsJloX0EkRcNMf87QLnOmtmj32mYJo0GkQItOn0ae5tsNkbm
         XYaA==
X-Gm-Message-State: AAQBX9cCnWtDtINVUhCBZcKSPg5pSIKn/aa9dsDDvx4d3tJTQ2nCwc42
        LD8aigQMNp1w184qdsfirk+TCA==
X-Google-Smtp-Source: AKy350axq3RPPlmGDbM+6cTYhrCNcBKzL+dJ3Kv3/HVf3XqJ0wYV0FWWPvC7kaS1wSMB8DdDmPd8Xw==
X-Received: by 2002:a17:907:a70c:b0:8b1:88aa:46da with SMTP id vw12-20020a170907a70c00b008b188aa46damr13400329ejc.48.1679928133302;
        Mon, 27 Mar 2023 07:42:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:581e:789c:7616:5ee? ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id wf4-20020a170907d68400b0093f3d12d64bsm3398427ejc.179.2023.03.27.07.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 07:42:12 -0700 (PDT)
Message-ID: <dd8d1503-e2bf-7032-4d0a-16d9a5b2aa51@linaro.org>
Date:   Mon, 27 Mar 2023 16:42:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: firmware: arm,scmi: Support mailboxes
 unidirectional channels
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     sudeep.holla@arm.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, nicola.mazzucato@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20230327140342.222168-1-cristian.marussi@arm.com>
 <20230327140342.222168-2-cristian.marussi@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327140342.222168-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 16:03, Cristian Marussi wrote:
> SCMI defines two kinds of communication channels between the agent and the
> platform: one bidirectional 'a2p' channel used by the agent to send SCMI
> commands and synchronously receive the related replies, and an optional
> 'p2a' unidirectional channel used to asynchronously receive delayed
> responses and notifications emitted from the platform.
> 
> When configuring an SCMI transport based on mailboxes, the current binding
> supports only mailboxes providing bidirectional channels: in such a case
> one mailbox channel can be easily assigned to each SCMI channel as above
> described.
> 
> In case, instead, to have to deal with mailboxes providing only distinct
> unidirectional channels, it becomes necessary to extend the binding in
> order to be able to bind 2 distinct unidirectional mailbox channels to the
> same SCMI 'a2p' channel.
> 
> Bidirectional and unidirectional channels support for the SCMI mailbox
> transport can coexist by carefully considering the effective combination
> of defined 'mboxes' and 'shmem' descriptors.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: devicetree@vger.kernel.org

Please drop the autogenerated scripts/get_maintainer.pl CC-entries from
commit msg. There is no single need to store automated output of
get_maintainers.pl in the git log. It can be easily re-created at any
given time, thus its presence in the git history is redundant and
obfuscates the log.

If you need it for your own patch management purposes, keep it under ---.


> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 42 +++++++++++++++++--
>  1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 2f7c51c75e85..9a7dc30e386f 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -63,10 +63,24 @@ properties:
>    mboxes:
>      description:
>        List of phandle and mailbox channel specifiers. It should contain
> -      exactly one or two mailboxes, one for transmitting messages("tx")
> -      and another optional for receiving the notifications("rx") if supported.
> +      exactly one, two or three mailboxes; the first one or two for transmitting
> +      messages ("tx") and another optional ("rx") for receiving notifications
> +      and delayed responses, if supported by the platform.
> +      The number of mailboxes needed for transmitting messages depends on the
> +      type of channels exposed by the specific underlying mailbox controller;
> +      one single channel descriptor is enough if such channel is bidirectional,
> +      while two channel descriptors are needed to represent the SCMI ("tx")
> +      channel if the underlying mailbox channels are of unidirectional type.
> +      The effective combination in numbers of mboxes and shmem descriptors let
> +      the SCMI subsystem determine unambiguosly which type of SCMI channels are
> +      made available by the underlying mailbox controller and how to use them.
> +       1 mbox / 1 shmem => SCMI TX over 1 mailbox bidirectional channel
> +       2 mbox / 2 shmem => SCMI TX and RX over 2 mailbox bidirectional channels
> +       2 mbox / 1 shmem => SCMI TX over 2 mailbox unidirectional channels
> +       3 mbox / 2 shmem => SCMI TX and RX over 3 mailbox unidirectional channels
> +      Any other combination of mboxes and shmem is invalid.
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 3

Missing update to mbox-names.

>  
>    shmem:
>      description:
> @@ -234,7 +248,7 @@ $defs:
>  
>        mboxes:
>          minItems: 1
> -        maxItems: 2
> +        maxItems: 3

The same. How is it supposed to work? tx rx and that's it?

>  
>        shmem:
>          minItems: 1
> @@ -393,6 +407,26 @@ examples:
>          };
>      };
>  
> +  - |
> +    firmware {
> +        scmi {
> +            compatible = "arm,scmi";
> +            mboxes = <&mhu_U_tx 0 0>, <&mhu_U_rx 0 0>;
> +            shmem = <&cpu_scp_lpri0>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;

I don't think adding one more example with difference in only one piece
is needed here.

Best regards,
Krzysztof

