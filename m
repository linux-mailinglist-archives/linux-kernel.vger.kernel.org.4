Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9F960D2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiJYSDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiJYSDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:03:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADEA167EA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:03:10 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t25so9181425ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=88oNzPUt/hklNuT3+gVgNnDseM0gTXsCehPcE6SyWPQ=;
        b=GFYJZG6otnGca9bScD7Poayx7YyMh2FQbAJYYZO3QTDhm0J/ucT8+44fWMqe5epE+B
         mktFu4Mbxv/S2SNToMGRkwQxhMKIzRbV2HO4ew52bvRjHsQug1NjA2+9lHZLwQYVXpj9
         TA1HCWRyJT1FctP5TNLJdqtez7ud9GmQGDZxpsm8DYertGakPGB3a2v0BpCvdVKZyG8i
         DeW3eE+l2KUCw6PEKqU7bxH+tXdoK1bP+2ImGVveCvseM680HkxvW1uTC02f4C3oWfBT
         eXopxfnGFa3zfi+AmyRBGlo9Uqa5E1DV2zZEL7yiaPW64t6TJxAxgCxe2gTNGoixjuep
         mmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88oNzPUt/hklNuT3+gVgNnDseM0gTXsCehPcE6SyWPQ=;
        b=bC/jW9HSL6rYjgrX/VkxQ36hOSla4oktyC4622fqq6v/aiaoVe7ZUGjf9r9KOASxgv
         G9HGNy8Lzyaai/gRVwi7p/pYbuuSx9+CD8p6znJimpwOTZHl7Qkhdxqt0OQmI/bhycgp
         vdUA1j1T35onByLPw8B6b1N3S29OIxIHHf0G/Y7rX8ge+THi+AhLkj0xiUrANa0xYOk2
         RGYc0GPNsIKDQPYxELMSDVLkekVtAId6aFRVuZyNAHvoBDhga/ySYJI3qeOnTqmqLWqn
         vqGcuNpgrcdsFFuygaeJpHdQlbjMJrgDKNouOjUKa4Hr/YKmNtg+/zUl0U3AVk9SMp47
         cKRg==
X-Gm-Message-State: ACrzQf2yhNOTsnr3IrQA14GzWKQtsWP+3BXhyWms8uPoNDmc+o82xs+H
        v4aQx6RVfe7Fr9cS3KvJ5fl2AqktcBo=
X-Google-Smtp-Source: AMsMyM7jxemvRjEyCefHxnSbqR9TVfe194cy8GGDQOoh2WAI27lcc+ychBfZC384Krp8HbdE96KbFA==
X-Received: by 2002:a17:907:2cce:b0:77a:6958:5aaa with SMTP id hg14-20020a1709072cce00b0077a69585aaamr32168489ejc.245.1666720988827;
        Tue, 25 Oct 2022 11:03:08 -0700 (PDT)
Received: from [192.168.1.100] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id j5-20020a170906830500b0072f112a6ad2sm1746651ejx.97.2022.10.25.11.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 11:03:08 -0700 (PDT)
Message-ID: <262e9819-88c4-abc9-dcce-ee020b847c6a@gmail.com>
Date:   Tue, 25 Oct 2022 20:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: rtl8192e: rtllib_crypt_wep: multiple blank lines
 removal
Content-Language: en-US
To:     Aaron Lawrence <t4rmin@zohomail.com>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221025104402.xvbfobi7sdnwlqs2@plymouth>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221025104402.xvbfobi7sdnwlqs2@plymouth>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 12:44, Aaron Lawrence wrote:
> Removal of multiple unnecessary blank lines in accordance with the
> Linux kernel coding-style regulations. Said issues ware detected on
> this file by the checkpatch script.
> 
> Signed-off-by: Aaron Lawrence <t4rmin@zohomail.com>
> ---
>   drivers/staging/rtl8192e/rtllib_crypt_wep.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_crypt_wep.c b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
> index 7790271a6a40..062285e4d939 100644
> --- a/drivers/staging/rtl8192e/rtllib_crypt_wep.c
> +++ b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
> @@ -27,7 +27,6 @@ struct prism2_wep_data {
>   	struct arc4_ctx tx_ctx_arc4;
>   };
>   
> -
>   static void *prism2_wep_init(int keyidx)
>   {
>   	struct prism2_wep_data *priv;
> @@ -46,7 +45,6 @@ static void *prism2_wep_init(int keyidx)
>   	return priv;
>   }
>   
> -
>   static void prism2_wep_deinit(void *priv)
>   {
>   	kfree_sensitive(priv);
> @@ -120,7 +118,6 @@ static int prism2_wep_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
>   	return 0;
>   }
>   
> -
>   /* Perform WEP decryption on given struct buffer. Buffer includes whole WEP
>    * part of the frame: IV (4 bytes), encrypted payload (including SNAP header),
>    * ICV (4 bytes). len includes both IV and ICV.
> @@ -180,7 +177,6 @@ static int prism2_wep_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
>   	return 0;
>   }
>   
> -
>   static int prism2_wep_set_key(void *key, int len, u8 *seq, void *priv)
>   {
>   	struct prism2_wep_data *wep = priv;
> @@ -194,7 +190,6 @@ static int prism2_wep_set_key(void *key, int len, u8 *seq, void *priv)
>   	return 0;
>   }
>   
> -
>   static int prism2_wep_get_key(void *key, int len, u8 *seq, void *priv)
>   {
>   	struct prism2_wep_data *wep = priv;
> @@ -207,7 +202,6 @@ static int prism2_wep_get_key(void *key, int len, u8 *seq, void *priv)
>   	return wep->key_len;
>   }
>   
> -
>   static void prism2_wep_print_stats(struct seq_file *m, void *priv)
>   {
>   	struct prism2_wep_data *wep = priv;
> @@ -231,13 +225,11 @@ static struct lib80211_crypto_ops rtllib_crypt_wep = {
>   	.owner			= THIS_MODULE,
>   };
>   
> -
>   static int __init rtllib_crypto_wep_init(void)
>   {
>   	return lib80211_register_crypto_ops(&rtllib_crypt_wep);
>   }
>   
> -
>   static void __exit rtllib_crypto_wep_exit(void)
>   {
>   	lib80211_unregister_crypto_ops(&rtllib_crypt_wep);

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
