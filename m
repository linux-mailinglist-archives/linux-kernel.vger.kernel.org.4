Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644C66D51AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjDCT6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjDCT6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:58:11 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A423912B;
        Mon,  3 Apr 2023 12:58:10 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id d22-20020a9d5e16000000b0069b5252ced7so16251542oti.13;
        Mon, 03 Apr 2023 12:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680551890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0ZVpErobEk7siRufyklDa0K2HoTMPy0mGGHyR65Aiw=;
        b=IGJlgGc6ui55ZzDAe/ckr5JVUxboqr8j8rhIUkuET3kVEeEFnJz/e2U+Bm5rH5ebuK
         Opddx2dUsuQitvJ8/KPoG7FZafHsdVBG77WUs0TLjSyOdJhqv1NyCrzSEdZW+eUsDHCu
         E+aUa+CKX1aAs2n/yzi0zTI76H7gYX44srGAaRBM/mkvBlUdFH4cH/Cv1wb9AGVXbtUm
         7Y61f3JZcoFTw2kSgXOqJQSzx6LGNYOdlXDXIsJD6bapinI8HWJPONjXMtUn8+6RQ1o6
         hjbB+a0pLzbhRTAhppKLZb45bC2ssfSo2PnubbMJpSnhd9e5eBPdCDcYspCyHw+c28XV
         UcSw==
X-Gm-Message-State: AAQBX9dtxoyNMKcR0IrpW3SKZsnZ0DYtRclutN/k8k1fqiG1Si2v3w8Q
        MtwFfv/cRpX3aBmtyBU58zl/3YH4uA==
X-Google-Smtp-Source: AKy350bGZH8h9G3cgIbWhS5PENOUJZ25o+LP1PRC4PeBlq22dweLKKypO5LxOd8z91F0sr/RVTOEfg==
X-Received: by 2002:a9d:291:0:b0:69f:a848:1bb2 with SMTP id 17-20020a9d0291000000b0069fa8481bb2mr9204636otl.8.1680551889791;
        Mon, 03 Apr 2023 12:58:09 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c21-20020a9d67d5000000b006a205a8d5bdsm4702200otn.45.2023.04.03.12.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 12:58:09 -0700 (PDT)
Received: (nullmailer pid 1465383 invoked by uid 1000);
        Mon, 03 Apr 2023 19:58:08 -0000
Date:   Mon, 3 Apr 2023 14:58:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, sudeep.holla@arm.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Support
 mailboxes unidirectional channels
Message-ID: <20230403195808.GA1362828-robh@kernel.org>
References: <20230327154528.460836-1-cristian.marussi@arm.com>
 <20230327154528.460836-2-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327154528.460836-2-cristian.marussi@arm.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 04:45:27PM +0100, Cristian Marussi wrote:
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
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v1 --> v2
> - added mbox-names unidirectional definitions and example
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 76 ++++++++++++++++---
>  1 file changed, 66 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 2f7c51c75e85..0204b102b47f 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -56,17 +56,41 @@ properties:
>      description:
>        Specifies the mailboxes used to communicate with SCMI compliant
>        firmware.
> -    items:
> -      - const: tx
> -      - const: rx
> +    oneOf:
> +      - items:
> +          - const: tx
> +      - items:
> +          - const: tx
> +          - const: rx

These 2 'items' can be collapsed to 1 with 'minItems: 1' added.

> +      - items:
> +          - const: tx
> +          - const: tx_reply
> +      - items:
> +          - const: tx
> +          - const: tx_reply
> +          - const: rx

Same on these 2 with 'minItems: 2' added.

>  
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
>  
>    shmem:
>      description:
> @@ -228,13 +252,23 @@ $defs:
>          maxItems: 1
>  
>        mbox-names:
> -        items:
> -          - const: tx
> -          - const: rx
> +        oneOf:
> +          - items:
> +              - const: tx
> +          - items:
> +              - const: tx
> +              - const: rx
> +          - items:
> +              - const: tx
> +              - const: tx_reply
> +          - items:
> +              - const: tx
> +              - const: tx_reply
> +              - const: rx
>  
>        mboxes:
>          minItems: 1
> -        maxItems: 2
> +        maxItems: 3
>  
>        shmem:
>          minItems: 1
> @@ -393,6 +427,28 @@ examples:
>          };
>      };
>  
> +  - |
> +    firmware {
> +        scmi {
> +            compatible = "arm,scmi";
> +            mboxes = <&mhu_U_tx 0 0>, <&mhu_U_rx 0 0>;
> +            mbox-names = "tx", "tx_reply";
> +            shmem = <&cpu_scp_lpri0>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            scmi_dvfs_2: protocol@13 {
> +                reg = <0x13>;
> +                #clock-cells = <1>;
> +
> +                mboxes = <&mhu_U_tx 1 0>, <&mhu_U_rx 1 0>, <&mhu_U_rx 1 1>;
> +                mbox-names = "tx", "tx_reply", "rx";
> +                shmem = <&cpu_scp_hpri0>, <&cpu_scp_hpri1>;
> +            };
> +        };
> +    };
> +
>    - |
>      firmware {
>          scmi {
> -- 
> 2.34.1
> 
