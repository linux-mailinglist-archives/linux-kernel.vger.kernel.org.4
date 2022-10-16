Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1E95FFCF9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 03:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJPBuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 21:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJPBuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 21:50:19 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB063641A;
        Sat, 15 Oct 2022 18:50:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f193so7660338pgc.0;
        Sat, 15 Oct 2022 18:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/1BdzxeIg7w9gIlh2BqBXfrVYmSA9tAnQeElbhlBoI=;
        b=qMqY5heCSen56xVKaV/5wzpUM1FqNEyD3JnmsD6Yr0QpNL4zchlWhWXmEEG6qXkNqB
         rsIRo6UzWGPM5gyZPwcuv5XMk/BhLjSHoSrJ4Vmx/iR+imJD7dQN6k1dz8WlyLrFetNp
         1Xq8FpZ7J7ATVRgW5xB4aHvUT6cyFcY7WktQstKrftc2Uk+8QlFSHvFz6XBN8sTs6P2/
         IBwfXob2A//EO4xdltfYynWnJYSlNpEWJZeK+137p1ufa0bbwZbiZ+6iKVVBVwWuEU/e
         zfEVhPxBZ+VM5GaqU3tgeqRLu/r+5yjOUlNoE0ydNUDonlmISw4XH9Qp6ZhFkNY7ndub
         2gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/1BdzxeIg7w9gIlh2BqBXfrVYmSA9tAnQeElbhlBoI=;
        b=iYgtgOArt2KGrutmMnM57yQlQbLqhcfxKB58ZPuGQXlZT9OK/dGSfPnW8K8GVB2y7Q
         oie7a29+gNNg3afo+37pmMFOdApJlby8hYj6AtF+wvMahyPDqMjPmr8Ms5QBdTPdLMGO
         T0qElHljjw2tzjg0bQXXwGPI/7/zR8aU1Bj9QZyiIGbF2BR5WLhj4CJ5TPgyjSONOoF9
         w0gviwlHvYqUy/Q+OiZlR3Seyu52zmciDk7Uy1XpV0kVKHxgyjHDLlQ6vE728cioSygM
         HtlXJqAmBt+nbWuCk/gYOCfJPZVCScF3/4sPBKkKT5A2shE22jPaP9F0Ov5B4mjEQpe9
         qCGQ==
X-Gm-Message-State: ACrzQf2Broxeb+NEz/Hp6m+h8faUyY+7d7BKCnTcZIakNWNdGmFxXQX/
        kRzVo+Z4gY8KCEOUIRNYdn8=
X-Google-Smtp-Source: AMsMyM6EaDNCx6y52k83yvupZzhX/2k4t/GRJ2q6pnJs+cvSRjSeD6ngwAH4M5tfeXmXuY5twxPGKA==
X-Received: by 2002:a63:5a08:0:b0:43c:9fcc:cc54 with SMTP id o8-20020a635a08000000b0043c9fcccc54mr4753029pgb.229.1665885018679;
        Sat, 15 Oct 2022 18:50:18 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-23.three.co.id. [180.214.232.23])
        by smtp.gmail.com with ESMTPSA id mv6-20020a17090b198600b001f559e00473sm7095864pjb.43.2022.10.15.18.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 18:50:18 -0700 (PDT)
Message-ID: <7c888efc-4b02-3470-8659-9922774f4fa7@gmail.com>
Date:   Sun, 16 Oct 2022 08:50:14 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 00/13] [RFC] Rust support
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Olliver Schinagl <oliver+list@schinagl.nl>,
        Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
 <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com>
 <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
 <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
 <5c0bb1db-5589-32ca-ac22-4aafb3c15751@schinagl.nl>
 <20220728112114.0000003a@garyguo.net>
 <a4803f2e-2e46-1c7d-0e89-96f5cbb0ad11@schinagl.nl>
 <00604162-9157-3862-b463-de90cb17c69a@schinagl.nl>
 <0cd7ad6a-7b70-2b09-9f17-40ffbc17a7fa@gmail.com>
In-Reply-To: <0cd7ad6a-7b70-2b09-9f17-40ffbc17a7fa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/22 08:44, Bagas Sanjaya wrote:
> 
> I have to say two advices:
> 
> First, don't top-post. I don't know what context you're replying to
> (in fact I have to cut the reply context below your message).
> 
> Second, please post the patch inline, not attached. git format-patch +
> git send-email should suffice.
> 

Oh, I forget to mention this. Is it RFC? If so, you need to specify
--subject-prefix="RFC PATCH" to git format-patch.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

