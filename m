Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98D85BD4ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiISSv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiISSv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:51:27 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3A1476D5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:51:26 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h130-20020a1c2188000000b003b4cadadce7so4009120wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=KOHOy6vA9ZnsPk6u3LYcHqNXTndDFya+wLFq+gWL6lg=;
        b=HtLt5xhGAXR9J21gbStTz1uppWovmTC1SebucrN0NgtjjhM2gommhIeP3ma9cgqto5
         QMpFIKt+v0tVQiuxZOGllkxryvfZjUtvqgZq+u8uMAteZY0XNvp/Pq7NLYcYKIKuBtmR
         fuCt+ZI6CAQSS28T9zgA3nENmJRDgMrk8SMihnfsk/q+gy26igMUOnJD+YYSSVcf569x
         quXc2dTZTedZ5gjrZmEukWrX2AoF2z8I40+eZvuqyh+/52644wh7rI3nWjeD2hbiG5jy
         8RwYA2osZl4gSJD5+8E69Y4gl9OMKzwtghrBrvUZp5cxsm/6ARQHC8dY0afKM+shd227
         CJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KOHOy6vA9ZnsPk6u3LYcHqNXTndDFya+wLFq+gWL6lg=;
        b=5I3GP+4NgtNTDwR+VY4tUm9u39Uo/G57oWlf3laeZWSHijBhHrA77LIbJ/EAUcclcC
         v43Q06ogRew+rQ3mgnIn/dGGNHsHJLPTD5rptvkfFHmz4zAAlKsst8tYBSmDhwkYa7TK
         XMKuOC9c4AumWJbiwFdcGpAFl/Kxit6AlFscxyCoP5HfN3qXtWouIsrb3StNksRvzEmH
         DRf9vzReaWI3k6TXx3IJdZVC7z1WU+exmanisMP5egzSGYJf/i/9WeG5ZGPDkMuY1B/t
         FuSomwrvN6jc7aenRYdBKqYqQTC80qlKhXHtnWQh704YXpuDPb9ZrVvIBLHU9FsteSxm
         U2FA==
X-Gm-Message-State: ACgBeo3ahPz9tKZj+7qe5bcmp++Zn00tJRhhGNuYKMbWfhON342FoYYd
        /yzj4Mweq8bj1I45Cm+iNcw=
X-Google-Smtp-Source: AA6agR7YxVWSSigx6zzSDCXal2Mb1B9ah0ovuIRh/oce/tQf90CAo0F1hy6vxd6aeph5TNUHSWZQfw==
X-Received: by 2002:a05:600c:4e4d:b0:3b4:7659:38c with SMTP id e13-20020a05600c4e4d00b003b47659038cmr19927651wmq.176.1663613484783;
        Mon, 19 Sep 2022 11:51:24 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a10:9fb4:d689:f4a2:c991? (p200300c78f3e6a109fb4d689f4a2c991.dip0.t-ipconnect.de. [2003:c7:8f3e:6a10:9fb4:d689:f4a2:c991])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b002252ec781f7sm14626452wrs.8.2022.09.19.11.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 11:51:24 -0700 (PDT)
Message-ID: <672512d7-06ae-c6ca-280c-13183c5bdd00@gmail.com>
Date:   Mon, 19 Sep 2022 20:51:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] staging: rtl8192e: spaces preferred around that '<<'
 (ctx:VxV)
Content-Language: en-US
To:     Aruna Hewapathirane <aruna.hewapathirane@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     f3sch.git@outlook.com, guozihua@huawei.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220919141624.8765-1-aruna.hewapathirane@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220919141624.8765-1-aruna.hewapathirane@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/22 16:16, Aruna Hewapathirane wrote:
> This patch fixes 2 checkpatch CHECK issues
> 
> Signed-off-by: Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtllib_tx.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
> index f651947f6b44..933f347fc17e 100644
> --- a/drivers/staging/rtl8192e/rtllib_tx.c
> +++ b/drivers/staging/rtl8192e/rtllib_tx.c
> @@ -818,10 +818,10 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
>   					 cpu_to_le16(rtllib_query_seqnum(ieee, skb_frag,
>   							     header.addr1));
>   				frag_hdr->seq_ctl =
> -					 cpu_to_le16(le16_to_cpu(frag_hdr->seq_ctl)<<4 | i);
> +					 cpu_to_le16(le16_to_cpu(frag_hdr->seq_ctl) << 4 | i);
>   			} else {
>   				frag_hdr->seq_ctl =
> -					 cpu_to_le16(ieee->seq_ctrl[0]<<4 | i);
> +					 cpu_to_le16(ieee->seq_ctrl[0] << 4 | i);
>   			}
>   			/* Put a SNAP header on the first fragment */
>   			if (i == 0) {


Please remove the 3/3
add a V2 and a change history


