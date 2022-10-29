Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC4A61264E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 00:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJ2W4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 18:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2W4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 18:56:30 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EC2193C7;
        Sat, 29 Oct 2022 15:56:29 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id r187so9660325oia.8;
        Sat, 29 Oct 2022 15:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CDxrPtvMdWK49rPH+mY/ZEv+auyGsnbknR3u+IjSJiY=;
        b=X6NydX/OuwvkbDr7OqBfXLpQ66Udrk5oVrAbQbRDx8SvADMA/wiGKSRzDLmjUbdKnG
         /dIyTmm0HeWAOIm6DsBGVOo9oThoia4DpmaxK72x9MMM7N4ks5TAxU3R3jc+L2vwWg/Q
         ps4M66w+tL0/SmlF2STSEt1IWjF36ULNLotPSbWRavOWzJ7J6hnrPwF7cQqBreUf2Cq3
         5iIZ900gRPy6odIZG/gGajtp2s0By38SSk1R5XWIJ6R4OVe4opT1uTXfXsn0uG6MQLlq
         ow8KVoeWoufGfcxFpHhcMLcCZMnDxsmjwiB36Ep/9+LWbRDruuoatiDTRyMbOL89NeoE
         tn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDxrPtvMdWK49rPH+mY/ZEv+auyGsnbknR3u+IjSJiY=;
        b=fPsDZp4c/X2ms4kkseUAIQCT4HhJqmuTz5X7pVYsCzegNUhLM88OBphg2Ly3QoEU91
         SbmQZr7UCEDEx+5fM7TlOGXk+C3XPxewtTYd4sICVXZP7VzVPlPXqgYq2WiyAM3JL6Aw
         Fnx/rUA1j7loZMtXntKUsNakkw+Uexy/FDFygxc7/Snm5Iq+SxWOwrc/PRR67MIcDJKB
         I8Yf4mlteW+rinzwjqTF6zBFdKgdd8dunJnmUWTGSvWbLMEgc0DHySSQU6S7ppzCqoyl
         dM7/frPOwMRvKMuYo1fU9XFvZcjS1vajjCZwUGyEp3Edmi3h4DxbxBBN3XgiS61q6Sdb
         U9TQ==
X-Gm-Message-State: ACrzQf3E8/1lHl2ZSDUyit2BPigdQmNN2rypuqNvz+xQF6zR0MInplct
        RZPRYqXg1GMz8yJHx/gy2v8627UQ/xg=
X-Google-Smtp-Source: AMsMyM5f7lyZ+2tFQIy6QZk1xsZZKvur4cBjd8fnBnx3AeIR3WjxbhF1sLteuqz0yrcCsP+v+Yp3eg==
X-Received: by 2002:a05:6808:f93:b0:355:4d84:c802 with SMTP id o19-20020a0568080f9300b003554d84c802mr3073874oiw.187.1667084188538;
        Sat, 29 Oct 2022 15:56:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w13-20020a9d450d000000b00661ac688285sm1114383ote.0.2022.10.29.15.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 15:56:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5ee0b72c-3942-8981-573f-73d97ea7ef08@roeck-us.net>
Date:   Sat, 29 Oct 2022 15:56:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC][PATCH v2 20/31] timers: usb: Use del_timer_shutdown()
 before freeing timer
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-usb@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <jstultz@google.com>
References: <20221027150525.753064657@goodmis.org>
 <20221027150928.983388020@goodmis.org>
 <4e61935b-b06b-1f2d-6c2b-79bdfd569cd6@roeck-us.net>
 <20221028140129.040d9acc@gandalf.local.home>
 <20221028141007.05f5c490@gandalf.local.home>
 <20221028195959.GA1073367@roeck-us.net>
 <20221029145241.GA3296895@roeck-us.net>
 <20221029151952.076821f2@gandalf.local.home>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221029151952.076821f2@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/22 12:19, Steven Rostedt wrote:
> On Sat, 29 Oct 2022 07:52:41 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> With the diffs I sent earlier applied, the warning still seen is
>>
>> WARNING: CPU: 0 PID: 9 at lib/debugobjects.c:502 debug_print_object+0xd0/0x100
>> ODEBUG: free active (active state 0) object type: timer_list hint: neigh_timer_handler+0x0/0x480
>>
>> That happens with almost every test, so I may have missed some others
>> in the noise.
> 
> Can you add this?
> 

It doesn't make a difference.

Guenter

> -- Steve
> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 3c4786b99907..3e2586c72c7e 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -895,6 +895,8 @@ void neigh_destroy(struct neighbour *neigh)
>   	if (neigh_del_timer(neigh))
>   		pr_warn("Impossible event\n");
>   
> +	del_timer_try_shutdown(&neigh->timer);
> +
>   	write_lock_bh(&neigh->lock);
>   	__skb_queue_purge(&neigh->arp_queue);
>   	write_unlock_bh(&neigh->lock);

