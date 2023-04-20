Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E586E8DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjDTJL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjDTJLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:11:15 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03095258;
        Thu, 20 Apr 2023 02:10:30 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-94a34d3812cso57068066b.2;
        Thu, 20 Apr 2023 02:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681981714; x=1684573714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eXhKdE5lqprqiAflIQDndd2L6jOpCRY4FudSchqd5w=;
        b=VJLJka4YDGT0SebadLggkylpPlxsqX/kUssRHuXOLFjgLTJDvbaOLre7i23WylDJTi
         zW3XU9F03ofh9XncGr0phQfa6wsatVE9ZhxcvGdnPHMjImH4F+sHRLb2Nc6TGUoHRwFb
         M4N023d0xNInKXQVA+yDRtTgANQ4vBlTLlXarf10HuRa6SZA5iYy+2mdlI/62ln18J+/
         OtzvWbEnBLdeJO5QmnFq6p7sAhvK96GqUrRY0weSOC6lT10wIl/gJ20o5LyMZaNpHk/q
         DPDxSCxN+cSSsHLF0c550cQgP4+bs391/Cbt9MFH15d2bmPq9rALzsoujxs6qey+X3Vm
         9whw==
X-Gm-Message-State: AAQBX9dIElfFxhINVdnRJ2daCegGfjEezHrBZlv5DSAZk2QBiCqVkbAs
        G3aqOq3PNDlX2rbLZUQU8BvP/Ietxtk=
X-Google-Smtp-Source: AKy350b0zw8rIX4c6M83szqn5QLghUr1D5U9pggBpQOuprP8Z9Obhj2Iw7t6obXeGfEGZPk5z+HGRA==
X-Received: by 2002:aa7:c406:0:b0:506:9ece:60cb with SMTP id j6-20020aa7c406000000b005069ece60cbmr842503edq.38.1681981714091;
        Thu, 20 Apr 2023 02:08:34 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906844700b0094f7b713e40sm490180ejy.126.2023.04.20.02.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 02:08:33 -0700 (PDT)
Message-ID: <2f2b20e4-34cd-a154-022f-c76c1b0e06c5@kernel.org>
Date:   Thu, 20 Apr 2023 11:08:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/9] tty: n_gsm: add missing description to gsm_config
Content-Language: en-US
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20230420085017.7314-1-daniel.starke@siemens.com>
 <20230420085017.7314-3-daniel.starke@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230420085017.7314-3-daniel.starke@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 04. 23, 10:50, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Currently, all available structure fields in gsmmux.h except those
> for gsm_config are commented.
> 
> Fix this by adding appropriate comments to the not commented fields.
> Note that 'mru' and 'mtu' refer to the size without basic/advanced option
> mode header and byte stuffing as defined in the standard in chapter 5.7.2.

Maybe you can start documenting them using kernel-doc? And convert the 
others and expose them all to Documentation and finally to:
https://www.kernel.org/doc/html/latest/
?

> Link: https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>   include/uapi/linux/gsmmux.h | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> v1 -> v2:
> Added remark regarding the mru/mtu size comment as this was unclear in the
> review.
> 
> Link: https://lore.kernel.org/all/AS4PR10MB5895ADDAF211A669CCF7F8C5E0919@AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM/
> 
> diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
> index 33ee7b857c52..422a52e184b3 100644
> --- a/include/uapi/linux/gsmmux.h
> +++ b/include/uapi/linux/gsmmux.h
> @@ -8,17 +8,17 @@
>   
>   struct gsm_config
>   {
> -	unsigned int adaption;
> -	unsigned int encapsulation;
> -	unsigned int initiator;
> -	unsigned int t1;
> -	unsigned int t2;
> -	unsigned int t3;
> -	unsigned int n2;
> -	unsigned int mru;
> -	unsigned int mtu;
> -	unsigned int k;
> -	unsigned int i;
> +	unsigned int adaption;	/* Convergence layer type */
> +	unsigned int encapsulation; /* Framing (0 = basic option, 1 = advanced option) */
> +	unsigned int initiator;	/* Initiator or responder */
> +	unsigned int t1;	/* Acknowledgment timer */
> +	unsigned int t2;	/* Response timer for multiplexer control channel */
> +	unsigned int t3;	/* Response timer for wake-up procedure */
> +	unsigned int n2;	/* Maximum number of retransmissions */
> +	unsigned int mru;	/* Maximum incoming frame payload size */
> +	unsigned int mtu;	/* Maximum outgoing frame payload size */
> +	unsigned int k;		/* Window size */
> +	unsigned int i;		/* Frame type (1 = UIH, 2 = UI) */
>   	unsigned int unused[8];	/* Can not be used */
>   };
>   

-- 
js
suse labs

