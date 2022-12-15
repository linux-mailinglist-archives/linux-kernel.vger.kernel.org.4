Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931C564D779
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLOH75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiLOH7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:59:49 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A072E9FA;
        Wed, 14 Dec 2022 23:59:44 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f18so2177910wrj.5;
        Wed, 14 Dec 2022 23:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KX0PWE2xH1wSf/y+zwbZJi36dKHohqN+VlC//8Gj03Y=;
        b=CRXXChB9RPUbelebK5Wi627ibXjWXRYZrVQK9fV7JL2upp00d1sz8VO5aqxykceunt
         z6Waxut3u1vjPaKhvIs5yya2XbkvBN+azS6J1pViAiWoSwz21h7DqKd520x/txMPZ2o8
         seoMqz/JKzPxzKyooayFzlm03v1REqNISxqHdRCZg+2JTyjzVAKy2TBrAgafuwPjnobL
         3GLWti82hybD3IhVMxbQP7b0IJ2BSvsBrd2OAuRTIklJncrocTtiBv3TMV+Wa8NBGsZV
         xNX1p2t6WdXMyvg6LpMbSatM8M78rT9ZvbCLr6De19ezXIpPVukdRzNWm+YaJnydIPsN
         UV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX0PWE2xH1wSf/y+zwbZJi36dKHohqN+VlC//8Gj03Y=;
        b=1K5M3LP8vLXS94/Ir5Q3WIR0CijYdK+rfgQNuNZGVPFqaw9HDz4YRTzlpE1l/1R1ph
         Z82zmipesPjR1+hHsTk0sjbYS5mg7xi6/tcqKTLbXjF8xnFZQn2M+GNwqaNZPPLBHv8+
         RGaZOZasq1FteUOKJlBsRoBjMpyADySbodkNF5mJgXebDObliS+YATFBX1vj109LXEV1
         ul7b5I1mHbeIwGxG+QEU1rdSx0weoI7Nyb8TTlV6h9NPjmDJau0XTFiaik8qkjrSdZ+/
         fpRhORpdLKWoNoynOJnOMTwp6GnOUfnU7Hnvs0uc0PoprmtCTXMjgDtWt6jyS4NlUCYg
         u+5A==
X-Gm-Message-State: ANoB5pl/UOShhHfJarRu+Mc+aZJWK2Mhr9sStpR7I65Vxxaa+P/9WBT6
        bCYH5Gr9FoNNmAAbafCCTEo=
X-Google-Smtp-Source: AA0mqf64n9wNAGf4SoZErGss2bZlF+akwx2ZmjXfqJnjEXlBPkfi6KoVksXeh4Nx+Kjh9mK3UgjFxg==
X-Received: by 2002:a5d:4e82:0:b0:242:7139:601a with SMTP id e2-20020a5d4e82000000b002427139601amr16180937wru.28.1671091183130;
        Wed, 14 Dec 2022 23:59:43 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d5489000000b00242109cf587sm5134961wrv.28.2022.12.14.23.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 23:59:42 -0800 (PST)
Date:   Thu, 15 Dec 2022 10:59:30 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 5/7] vc04_services: vchiq_arm: Drop VCHIQ_RETRY usage on
 disconnect
Message-ID: <Y5rT4qNDTCiVoHnu@kadam>
References: <20221215065853.34477-1-umang.jain@ideasonboard.com>
 <20221215065853.34477-6-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215065853.34477-6-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 12:28:51PM +0530, Umang Jain wrote:
> Drop the usage of VCHIQ_RETRY when the vchiq has connection status
> VCHIQ_CONNSTATE_DISCONNECTED. Disconnected is will not be valid to
> carry on a retry, replace the VCHIQ_RETRY with -EINVAL.
> 
> This patch removes the usage of vCHIQ_RETRY completely and act as
> intermediatory to address the TODO item:
> 	* Get rid of custom function return values
> for vc04_services/interface.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---

It sounds like this should have a Fixes tag because the original
behavior was wrong.

regards,
dan carpenter

