Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920F15F5B10
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiJEUfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJEUfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:35:50 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F85D39BB9;
        Wed,  5 Oct 2022 13:35:49 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 27so2945596qkc.8;
        Wed, 05 Oct 2022 13:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2sIbsiDjA2SMjGMWD+26Laqk16I6ZwxVSuTAC9N2/A=;
        b=SAYe0EeTRn5ySNJLY9UgTUSOJ0t/cmdVcBr2P+xRdmkEDDPfVpLmgAwuTc95MdWDN7
         /CU77OoiTEujAbW8ivDREtCmnUIE9Ibw0EbdTC2nR4j29NYcJ9bE+9M+hJVYnmahxx0k
         UP+j3TvVS6H4rWhBfnim5Wr3hatctVRYdUigtJP0/0ue5RXj/1ungu0mL7HFACWRFM7s
         Sm+ZkDbOoaLf5+0hJYojFXo9HsUJsy/05b+m2r5+Fbt7T2KLFPHflcl46XnN7xr97BTQ
         Tm/cZExsV8/Ol92PaXx0no3QnYF20roCCtrNc0Bzc7l9bC5bqKr4VRU6Twkv4W3DioiJ
         7+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2sIbsiDjA2SMjGMWD+26Laqk16I6ZwxVSuTAC9N2/A=;
        b=bZsgkVXPlL0b+h+zkwQxyIEYy5S2Cl+q7VrNmKEqkWXWpfHDqDxFU3maDvGSBuNBah
         fqArgtheNQVeumBFJ9nd4T2kRV2jpxdWJYkzzxjAFu0qCQ4UyGDVbW3rk4CD/LUbF+s7
         O/+1i3GqswmduTs89/mH1WkZpx/2xKxCO0AciXNDrJ+3zUOWYR293gjt1f28dp3/pPcw
         jMY1wOnyI5zCtLYdB06s71F2gAM61JeuqN9Q1ScQisKT9BUP68OV+Z3+KIgsTlXKLxDx
         IH8l2j4QELu1vIFbaT+JfY5mFvhFMOVHT3T2mHew76D8Ocq0mRe/Ru3NwaYFXc1Bksp5
         SzJQ==
X-Gm-Message-State: ACrzQf16ntpmx9eYTU3v/wSFNHTGh0/RIkkGPX/x0d4ZfJTbayUPuCs9
        46d2qD0tzoPhdwV6ah7+cio=
X-Google-Smtp-Source: AMsMyM6CrC9+UVRmv8m9FFzFc/aplhzAFhIJWzXVFjGUi5tvtuzP5ttoNttmGvdGNAehNN8bcir2sg==
X-Received: by 2002:a37:e116:0:b0:6cf:4dbd:18f1 with SMTP id c22-20020a37e116000000b006cf4dbd18f1mr994643qkm.120.1665002148299;
        Wed, 05 Oct 2022 13:35:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f1-20020ac81341000000b00339b8a5639csm14623547qtj.95.2022.10.05.13.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 13:35:47 -0700 (PDT)
Message-ID: <33f5b1d2-7d31-de19-c47e-1fc53ce958e3@gmail.com>
Date:   Wed, 5 Oct 2022 13:35:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] usb: bdc: change state when port disconnected
Content-Language: en-US
To:     justinpopo6@gmail.com, alcooperx@gmail.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com
References: <1664997235-18198-1-git-send-email-justinpopo6@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1664997235-18198-1-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 12:13, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> When port is connected and then disconnected, the state stays as
> configured. Which is incorrect as the port is no longer configured,
> but in a not attached state.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
