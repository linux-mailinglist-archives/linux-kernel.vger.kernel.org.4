Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850DF73558D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjFSLPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjFSLO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:14:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEA9C6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:14:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51a2661614cso4571090a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687173296; x=1689765296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YYO+FdD02HoQtON3gY3N67r0LjDnfpgEGatkCF/SPuM=;
        b=vmBfiw9NB0m0oRyziSLMIbgVVuWC8KucOqqtglZqMCYjfwBwb2yaY8khBcq+6D8OBR
         MdPMNQKT2L+9alij30NUHbXFPbCgPhaOcYTe0dFD1vf53SG7W+UgBXUVpTUGPLrZwpIj
         ZM4pKV5YC9OgEb/tF4xUDQR+/JwLPY1t7Y+hlyVIhFACLYP2/ETBzG08uoas7Qp6cIJ+
         oKFyiCKC6LhRt3sLbAlB9WHiaPGGCCq4lWfJ+cRmqQVSp5Xb0pU24CfJ8s03Uq5+iBJ9
         w1RtVzQV8cm7xeYE6XGLIk0koOuLmAft1JsU4eCKmu65Pjiumyd5DVaTrBG5CZv8EWCB
         mrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687173296; x=1689765296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYO+FdD02HoQtON3gY3N67r0LjDnfpgEGatkCF/SPuM=;
        b=kval1laaVtpaBy0ZJo8nl+KrWPc8jPhCRLjJLutDvPMN41TpiCosIE1IGT1WysUoo1
         tm/MYQy2A2P71aHrzgGiFhUtEvSHDEH8L3I+gmrKtW42yqwf9kYIXp3stlvRHxHWziqK
         rWpg+EkqUL/Crs5xZV5ku7UooeMCif8gXk2bNfQHQAxA2ggL50jWhcMposeUzmSrplu+
         jUXolncEYH4J1mnA/XmcvfOkYEXRYz9T2/l+Rd84J9hIDElKtveq/xIm6royYICa/Ype
         M4eSY82M/aVzVcwiwdINnLKAnI0+SEyY8G16TUBVn1iRwnwDQzjzoLr7jCiSauVeahhQ
         jWYg==
X-Gm-Message-State: AC+VfDyzbYoklLPII0HfqmuMhr0AhflRUoMo+lKeTakPgHTr7ItCDaFh
        5IQk+5u1ZKWE8kalOZKtqUcoOg==
X-Google-Smtp-Source: ACHHUZ6KrZgsHnmsIkFvEKH2MSdqPB9TyfdERyrH3BK4EWJ+r0jnQQb3AE+Pg2hladpawECOYZvXWg==
X-Received: by 2002:a17:907:7f13:b0:988:74eb:b6d8 with SMTP id qf19-20020a1709077f1300b0098874ebb6d8mr3266923ejc.51.1687173296058;
        Mon, 19 Jun 2023 04:14:56 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906338c00b009887a671017sm2111636eja.179.2023.06.19.04.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 04:14:55 -0700 (PDT)
Message-ID: <7472fb6b-5884-586c-0965-b3bef83109f3@tessares.net>
Date:   Mon, 19 Jun 2023 13:14:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] mptcp: Reorder fields in 'struct
 mptcp_pm_add_entry'
Content-Language: en-GB
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev
References: <e47b71de54fd3e580544be56fc1bb2985c77b0f4.1687081558.git.christophe.jaillet@wanadoo.fr>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e47b71de54fd3e580544be56fc1bb2985c77b0f4.1687081558.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 18/06/2023 11:46, Christophe JAILLET wrote:
> Group some variables based on their sizes to reduce hole and avoid padding.
> On x86_64, this shrinks the size of 'struct mptcp_pm_add_entry'
> from 136 to 128 bytes.
> 
> It saves a few bytes of memory and is more cache-line friendly.

Good catch and thank you for having shared this patch, it looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
