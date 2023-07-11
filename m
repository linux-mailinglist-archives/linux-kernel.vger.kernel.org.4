Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0394874ED60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGKLxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGKLxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:53:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BDD10C0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:53:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9928abc11deso706610366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689076414; x=1691668414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ggjdezSq0XBXnmFq0BRmocCfymy1PCWm7Nw1Mg4zaQI=;
        b=N3zXRtpMralX0T/rmh6eDsEQoZf+YaS8jNrlblaQQRtU/2D5o1pVibrBt/hlK4e8fu
         Gf287512p4j0zXt2fJXNngmy3XUT9KUEJog5rSpq2tA7+XWddRzClW4HgCd28sEIjA7c
         7y+5NVR9YS0FusFIqSaUQ5emvkzkR54bn2VWGmBqM/IPgbtgw5COwbWCDeZ65GqGiEKt
         jImKJPedtQOVb7Ip6V8xnkt4jbzrFr25taSYJzbW3ysUqNWJanXZAGmrqrv0InJ3G6vW
         CdlM5qPBy1fSZSn41dArM9zM/sUhWI9QJe9yXySkL47/zRHRxnoczRFl6L0f80Har4tK
         hd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689076414; x=1691668414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggjdezSq0XBXnmFq0BRmocCfymy1PCWm7Nw1Mg4zaQI=;
        b=b1YB5h+JLltX6vBCyBwg4iiemVfdmXlsFz/Xq6EbZpQwu2BjVf/99dA5PK1We9LWqd
         pXxUK/O8QpIbiGwYRpVJvyE7jvEo8yTIt8we0amIvy2sHsgn9TcAHvOD96qTJiGDBBFd
         MpgULEJxCMAk8NCri7a2MN3zOF5T5QupfIZPotb3AXZhebDtG5rGUWSqGhRQoEDlJQEV
         uumWpc/Ox5Opz0iKGuszgJQ0j2dqQWALDeKtlWow+PKL9+PyU3x/an/2k/ybR+TUCpHF
         1fDQNkVkp9ZxDXJ51H7zZougmu56yhwHguSRY39IsfzCYc2l8Eomyar7vN1eAtQD6Caz
         gGbw==
X-Gm-Message-State: ABy/qLYQTa3L/zTHtoabkXlLJk6sGqEOu3B8SjBo9+CYNJiqelD49kpN
        ublw+YjtLQh2e2NQzv2igmom17vOR7OXbvDy4dk=
X-Google-Smtp-Source: APBJJlHquG8S/uL1eP4Mtl2ZCDFiPHFCkpnm0iFQioH65XkGFwzUjNhHNCofxtpC4Guvyvg362zqqQ==
X-Received: by 2002:a17:906:360a:b0:992:a836:a194 with SMTP id q10-20020a170906360a00b00992a836a194mr12932511ejb.59.1689076414025;
        Tue, 11 Jul 2023 04:53:34 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.194.156])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090619c900b00988b8ff849csm1072834ejd.108.2023.07.11.04.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 04:53:33 -0700 (PDT)
Message-ID: <3d9739d5-655b-2535-0dc1-aafdf7e36e8f@linaro.org>
Date:   Tue, 11 Jul 2023 13:53:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] MIPS: prefer 'unsigned int' to bare use of 'unsigned'
To:     xuanzhenggang001@208suo.com, tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230709141701.16324-1-denghuilong@cdjrlc.com>
 <e30eb541f2fc615b264a70af2f40a5f9@208suo.com>
Content-Language: en-US
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e30eb541f2fc615b264a70af2f40a5f9@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 16:19, xuanzhenggang001@208suo.com wrote:
> Fix the following warnings reported by checkpatch:
> 
> arch/mips/kernel/linux32.c:128: WARNING: Prefer 'unsigned int' to bare 
> use of 'unsigned'
> arch/mips/kernel/linux32.c:129: WARNING: Prefer 'unsigned int' to bare 
> use of 'unsigned'
> arch/mips/kernel/linux32.c:129: WARNING: Prefer 'unsigned int' to bare 
> use of 'unsigned'
> arch/mips/kernel/linux32.c:129: WARNING: Prefer 'unsigned int' to bare 
> use of 'unsigned'
> 
> Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>
> ---
>   arch/mips/kernel/linux32.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

