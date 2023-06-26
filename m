Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC773E601
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjFZRJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjFZRJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:09:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121ECAA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:09:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98dfd15aae1so48476666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687799386; x=1690391386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mu2qc+86ZuPWNe3cOLE/kFwjMyt3M4/TYtXFbaFVOnc=;
        b=IbiWQ1ZGh+k+liHnuynXdUeZSe/d3JqltAcrWTsfUa3yTeA4F09/cNgGRNFiHAsnHu
         03arwTqKThwS5J4dOOHCiBaF4/iNMF8HKS7/qqJ8sZx0LwI1L5Wy5j/6c5eBpiz+I38S
         IE+ddPIWmm7Fz+fSo9EQu7XLBWLGfXzwywFlibdLO+Yro3GAOVl9JovOyQQ5mJ8FTdGH
         parDdl4PDyWcfKwOu1HQRYcJIS+v+OsKCqI7r16N+W7xbTmhe1JvLzeEryzCtu5ahxNq
         +9GGYJCRj718TQKRBCb6S9g82/C7/2ZMWcnnDpra8IJ6bXFwRlTgHZTo2r4mF0QN0xIw
         GDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687799386; x=1690391386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu2qc+86ZuPWNe3cOLE/kFwjMyt3M4/TYtXFbaFVOnc=;
        b=iIozlIq39lgPgMzweWzNpNp/6tnCGc4zUsivkFZkzjAwG7kuiwjqmAsQKnz8scPTP8
         Ez7adFzjySTxJZM0aKoRj/RMg5a6XHKzQ/Fo9u3k8py8dekbE5QPv4hvI8e9pVTAjnae
         dsH5Ic9ZeEeigd4Fj1pDC6GaLJU0w5NR7x0/w9XT4nplw3T1HunwJrT6LDbN2CSVWpG4
         6XZ4kpYkFu5jtbbsfo9zHjtWikDqCu1uqhPr+nFpuTF2/oPydrsKB1Rku8Lw7EyZSNcc
         Fh+sO13A30jYa2IXlRkQdzAbITHot8q2m9mMXDKzp7ErhcRhElGQEn8RC7mSDgmIYfsb
         FxtQ==
X-Gm-Message-State: AC+VfDxoABNF4GC840HjUD2UBjhQx2BeH4+a/rrWSOGUCMrTWmnchc70
        Q/wqycI+Lil8Lyi3/bydrmc=
X-Google-Smtp-Source: ACHHUZ5OempIeb3DeBX+Uk2xlx6uYM9zwdRKxgI3KYI/H8Xp9pdl0eIoZ4+j6vNfVBWP1DbtlzDSJA==
X-Received: by 2002:a17:906:7a17:b0:988:73e4:b781 with SMTP id d23-20020a1709067a1700b0098873e4b781mr17028967ejo.2.1687799386316;
        Mon, 26 Jun 2023 10:09:46 -0700 (PDT)
Received: from [192.168.0.103] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id b6-20020a1709064d4600b00988c6ac6b86sm3452782ejv.186.2023.06.26.10.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 10:09:45 -0700 (PDT)
Message-ID: <7caa96fb-4fb6-fb87-5d0c-fa6985fa127b@gmail.com>
Date:   Mon, 26 Jun 2023 19:09:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/3] Fix some checkpatch issues
Content-Language: en-US
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, eperi1024@gmail.com,
        hdegoede@redhat.com, quic_vjakkam@quicinc.com,
        johannes.berg@intel.com, tegongkang@gmail.com,
        gregkh@linuxfoundation.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
References: <20230625155632.32403-1-franziska.naepelt@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230625155632.32403-1-franziska.naepelt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/23 17:56, Franziska Naepelt wrote:
> This is a series of patches to fix some trivial checkpatch issues. Not all
> issues have been fixed. I intend to submit another series to fix more stuff.
> 
> Testing:
> 
> ---
> v3: Series to contain only remaining patches.
> 
> Franziska Naepelt (3):
>    staging: rtl8723bs: Fix space issues
>    staging: rtl8723bs: Fix alignment open parenthesis
>    staging: rtl8723bs: Fix remaining blank line issue
> 
>   .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 164 +++++++++---------
>   1 file changed, 85 insertions(+), 79 deletions(-)
> 
> --
> 2.39.2 (Apple Git-143)
> 
> 

checkpatch prints the following warning:
WARNING: From:/Signed-off-by: email address mismatch: 'From: Franziska 
Naepelt <franziska.naepelt@googlemail.com>' != 'Signed-off-by: Franziska 
Naepelt <franziska.naepelt@gmail.com>'

I propose you change the git email matching the one that you use to send.

When testing you can compile the driver with this command:
make -C . M=drivers/staging/rtl8723bs
Typically a compile of the entire kernel is not required.

Please use the subsystem and driver also for the Subject line of the 
cover letter.

Bye Philipp
