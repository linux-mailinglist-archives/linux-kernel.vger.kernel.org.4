Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6309F6238F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiKJBg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiKJBgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:36:54 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C4B23BD8;
        Wed,  9 Nov 2022 17:36:53 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y203so454320pfb.4;
        Wed, 09 Nov 2022 17:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7oEB0lmZcsgH+1cJj1K5vcGagIGFkzSpM0f9u/agpKk=;
        b=j5vAZZswxbBkHZzlL1ibLXLQbQGvK/q/voHBPTA1Ws2DdyIcIxirEPVoIIwi4/sXEE
         6pddZ/yGus6geTiEG+0QBsLNJaFZiuRoroNmFDwac3SFK5jSBJJ1XsU1BVsBg4HcSgK8
         r/SwCyk8LffYTykINyVSGMn4tWufX2ZbWeq4TX2XF2kw1yeCFOeyJy+0dE0tvsY29awC
         O/Ok6itCX7IiW9utGLN1ra+3onkKIV9LsL7CAy28lBgBe5WcSqNh3SrrnzoYzi2rSaev
         v9Rg7JfLrNfbxgEtzAIb122i3+gGXWIxqnswqCjYjom6IY3HrAqMEXWzMGDD0yfoDfap
         dQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oEB0lmZcsgH+1cJj1K5vcGagIGFkzSpM0f9u/agpKk=;
        b=0ra0n48820Js5P7QwTUcCKkavO/QhdA8MBC9bNaDdhpO9TdHloI8+9TIM6tQKpLcqs
         FZH+hQB9vWj4eDqv8uHKasD1npVOE5KRwg/T/7mro79gWv5KZkBnrXb6thXBDVr+TzUu
         ccvywpYG4sjZ/xjuhN6K2NQbeUDL0tPuYxgP09M5IiVtKXGhUgZU8LHDgE4QRCvulPc+
         1zdKgqaXmmFU6cx6IfPjPR8zYMu2M2xBhipp8JWrZx7+rfyLnb78Cf5ubLZzaayLPxAj
         VPq2xYdtEZr0QaF18SlfXnqDf0Ml4SWrXnImC6jNXqrjFy0gA1iaMbiJ715VU9y32qkF
         OD1w==
X-Gm-Message-State: ACrzQf2s5VOV8lM47ts3HqJsMmRaf2mEkWq171eL0KyWP+Mwca9fjWn8
        mxj+Ujruq2FkUcp/00wD8EE=
X-Google-Smtp-Source: AMsMyM5pxt6O5G2t44hmX7bNcOIwJjfDwhc/Z1C5/sklTlOtzuBZmTn3pd4yijWcrTIVK+UNfOb4xA==
X-Received: by 2002:aa7:83c8:0:b0:56d:8e07:4618 with SMTP id j8-20020aa783c8000000b0056d8e074618mr51245416pfn.33.1668044213225;
        Wed, 09 Nov 2022 17:36:53 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-25.three.co.id. [180.214.232.25])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902bd0c00b001754fa42065sm9755598pls.143.2022.11.09.17.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 17:36:52 -0800 (PST)
Message-ID: <0323ce55-bb9b-dd85-93e8-22ad3591b7f3@gmail.com>
Date:   Thu, 10 Nov 2022 08:36:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] Documentation: media: Add ST VGXY61 driver documentation
 to userspace API table of contents
To:     Benjamin MUGNIER <benjamin.mugnier@foss.st.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-next@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Xavier Roumegue <xavier.roumegue@oss.nxp.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20221109100147.218947-1-bagasdotme@gmail.com>
 <f0aee291-ce44-400b-be3a-dfe38c62e450@foss.st.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <f0aee291-ce44-400b-be3a-dfe38c62e450@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 21:50, Benjamin MUGNIER wrote:
> Hi Bagas,
> 
> I already submitted this here:
> https://www.spinics.net/lists/linux-media/msg221143.html
> 
> Thanks.
> 

Oh, I don't see above! Thanks anyway.

PS: Please don't top post your reply; reply inline with appropriate
context. I had to cut the whole context below your reply.

-- 
An old man doll... just what I always wanted! - Clara

