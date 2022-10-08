Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF9E5F8500
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 13:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJHLde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 07:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJHLdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 07:33:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47F5474EF
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 04:33:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qw20so15544821ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 04:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oQx/0eIrDYpOi0EDDbnHHydn8n1/MpC3+4uz+2W5yo0=;
        b=BAa3LCiZgsXUNGlAE7tOH+EmIFdeTQKpTTJ5xJ7KshfcobjgqN7o5FPC1JoucysIUC
         jvsr4zO580LVBubMwiYGKjGPc/A2zHo+6ISwTm7ywUrIPeSUKS8qRspmLAvqZEyv5Z1c
         GzVQ+d7igRfZh3XodXvHZsUlaf6Zuiabo+QY4GGlrdnKPz/y5DfWFaJy9JqbiuDuph1I
         ofr1r1IW3ZA6xQcNGI5chVvjFZ8/6ohc43bKpanCHXIj6o6E2uyuTw5GwwZ3g6IGvZuB
         6p8xV3KYsM1qJjmHUN+eygHTfH3yWNfRwSO3SXfLOvyYGGd14NdGUg2JWzNjHhY41KRg
         9dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQx/0eIrDYpOi0EDDbnHHydn8n1/MpC3+4uz+2W5yo0=;
        b=bjuLY8OJC6q3bisHkmbs0rcIA+wCFuB7H0SDefwebCh5XdFoWdagDi9/clyxJim1ZH
         dzXA+4+OAgAe3bb9ELwWmVfgq3yZYPWnjKwJhJ40rscCCpG34OWGFjIZ8r1gzx696/aC
         PKgYenfC29emTGYI+CKANxXfKGZ83yjtqCrgERsALwB073U5AlmLbqivXciPUDaAVLla
         qRRLx6bVZ2k6PMEJ7odJt65zOwsKeJqmG63RNUMDXOY8fY4jzBfka6xJG1HcRcC37CFC
         4kJy/rGt+H6gmJ52dG+/MFJ73Lp0zjz0jInSFSRC0QFZ+6yeJOYPDKLChA4bdc5kFai+
         BY7w==
X-Gm-Message-State: ACrzQf0mY5xkkcQnAleVUUIiQhuTYw1+KAX/7wVOTN00sYBxE3wATSPT
        44K+XNn20X6bsAgHoun2IqISIQ==
X-Google-Smtp-Source: AMsMyM6rhWNb3A6dRryVy3rJGu5yzQTAs3357YPdwpUmZyCr4n59z190inREtA5Y3d6gVqLg3r0TMg==
X-Received: by 2002:a17:906:8a50:b0:78c:9179:9116 with SMTP id gx16-20020a1709068a5000b0078c91799116mr7478169ejc.625.1665228809300;
        Sat, 08 Oct 2022 04:33:29 -0700 (PDT)
Received: from ?IPV6:2003:d9:973f:8800:35d7:7623:f33e:520e? (p200300d9973f880035d77623f33e520e.dip0.t-ipconnect.de. [2003:d9:973f:8800:35d7:7623:f33e:520e])
        by smtp.googlemail.com with ESMTPSA id z8-20020a1709063ac800b007824c5fe95esm2653513ejd.50.2022.10.08.04.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 04:33:28 -0700 (PDT)
Message-ID: <77aefd92-86a1-b1d6-fe84-01f25de0dac3@colorfullife.com>
Date:   Sat, 8 Oct 2022 13:33:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: linux-next: manual merge of the driver-core tree with the jc_docs
 tree
To:     Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20220926210631.657728-1-broonie@kernel.org>
 <20220926224621.47llaskp6mihi4dd@tarta.nabijaczleweli.xyz>
 <878rm5rbka.fsf@meer.lwn.net> <YzI/3MjHgbXFHoHG@sirena.org.uk>
 <87czbgoc0s.fsf@meer.lwn.net>
 <AS8PR10MB483537EF2530D92C3D5BFF9ABF5B9@AS8PR10MB4835.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
Cc:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Spraul Manfred (XC-CT/PAC1)" <manfred.spraul@de.bosch.com>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <AS8PR10MB483537EF2530D92C3D5BFF9ABF5B9@AS8PR10MB4835.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Dienstag, 27. September 2022 21:25 , Jonathan Corbet <corbet@lwn.net> 
wrote:
> Mark Brown <broonie@kernel.org> writes:
>
>> On Mon, Sep 26, 2022 at 04:54:45PM -0600, Jonathan Corbet wrote:
>>> наб <nabijaczleweli@nabijaczleweli.xyz> writes:
>>>> This also reveals that I missed NBD_REQUEST_MAGIC (needs to go,
>>>> same reason as NBD_REPLY_MAGIC) in the first pass, but that's
>>>> unrelated here.
>>> I've been trying to make sense of that merge myself.  Is the right
>>> solution that I should just drop 32ba63d4b2e1a ?  Manfred, thoughts
>>> on that?
>> That'd certainly be a viable option too.
> OK, I have dropped the conflicting patch.  Manfred, if there are changes there that still need to get in, please resubmit that part and we'll get it done.

Dropping is the correct approach:
The values are part of the line protocol, and thus according to the 
current definition not in scope.

In theory, the change in include/uapi/linux/nbd.h is still useful, but I 
do not think that this is worth the effort.
>
>
> diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
> index 20d6cc91435d..88752b20e6c8 100644
> --- a/include/uapi/linux/nbd.h
> +++ b/include/uapi/linux/nbd.h
> @@ -11,6 +11,8 @@
>  *            Cleanup PARANOIA usage & code.
>  * 2004/02/19 Paul Clements
>  *            Removed PARANOIA, plus various cleanup and comments
> + *
> + * See doc/proto.md of the nbd package for more details on the protocol.
>  */
>
> #ifndef _UAPILINUX_NBD_H
> @@ -63,7 +65,6 @@ enum {
>
> #define NBD_REQUEST_MAGIC 0x25609513
> #define NBD_REPLY_MAGIC 0x67446698
> -/* Do *not* use magics: 0x12560953 0x96744668. */
>
> /*
>  * This is the packet used for communication between client and
> --
>

--

     Manfred

