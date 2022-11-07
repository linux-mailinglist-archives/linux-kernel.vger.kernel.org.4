Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD22561FEC8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiKGTi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiKGTiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:38:23 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8450D18B;
        Mon,  7 Nov 2022 11:38:21 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id v28so11575248pfi.12;
        Mon, 07 Nov 2022 11:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xYh2Or4INhXXE6mnrqC2mCYqRnEraDaLEynm/0+s7eo=;
        b=AsgShuKCbmr3rqEvVeI2xPAVn9zNq/oP7VqIKwBggiQ2y/ewJjsxvfTig8LVJt3waC
         XCYlhIMQFz2ZwCz5J09UEwtwkU7yIWJViwRThHjCe1nD+fUsTFY4RSLYYpWRuvV19pWr
         6wPo8Q4n1VpGRg6xdVfavm7dHrkRJZ2koAmFy/RLTsHY/8KsafDViGJUuuyFNKwTJIaq
         YjuuQjIEKTeXMcSQc6/TEU8LqhKtbZZ1+ipNJoD2bSsSChxTWVLbJQlUHYAzqIxCaKXD
         OljPrVdk8MYLWPSbjyGF+Yxcvlyy/R86pnaPbhZCT7AwQMW+ww9NWwFv3xzu4f/N4iWL
         gP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYh2Or4INhXXE6mnrqC2mCYqRnEraDaLEynm/0+s7eo=;
        b=pMqaXYzOOcrFGRGpheNsdZ17t35MxjYbxoB/rv/dfYJ9QKl+RI7XR+rl/MFsXKqSdi
         V2Z58rnQb2o+OInHBeKtAzrWK2JSQKUHBFp9Q9fJDa9iXDjpkYDPC96Ge9OQCJC07LqE
         OQX3uKq6ddOnKQuxe9mnqSAsPB2P1n1cLLjvDNKse8OYmywpMJwYBMoZl4DesMbhJ5Fl
         VsLR7vf48qGDv8bw901foGFuKrNU2ZgVzFoW+dr9taLS2tK9K5LzetZkqYpiJeiJAJzF
         DUlg6YM4DWrSlUVB4pMG/yh49PtTFFvMe1w5GAXMsNV2b8B03Z0QrVqbfdQ0O+4qVaxq
         462A==
X-Gm-Message-State: ACrzQf1cAMB13V2FBkMOR4BozLhn+uxsch1MVG94QgYOjx96bZdW7vMQ
        9VK7O69U8c+U8wnvkuNC/TY=
X-Google-Smtp-Source: AMsMyM52rUQaWCxUXTUxIpOZbKa+9RcURoD/q3C64zRmhCWcq4Yc2XiYTPjnyiWB+7qLQCGmtiB51Q==
X-Received: by 2002:a63:124b:0:b0:470:3c0:7a57 with SMTP id 11-20020a63124b000000b0047003c07a57mr26849679pgs.142.1667849900869;
        Mon, 07 Nov 2022 11:38:20 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:626:eb80:9eb9:1fd7])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090adb4200b00214247989dfsm4710877pjx.13.2022.11.07.11.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:38:20 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:38:17 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        linux-input@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: Re: [PATCH] Input: joystick - fix Kconfig warning for JOYSTICK_ADC
Message-ID: <Y2leqU8YJ1S6FqqH@google.com>
References: <20221104201238.31628-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104201238.31628-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 01:12:38PM -0700, Randy Dunlap wrote:
> Fix a Kconfig warning for JOYSTICK_ADC by also selecting
> IIO_BUFFER.
> 
> WARNING: unmet direct dependencies detected for IIO_BUFFER_CB
>   Depends on [n]: IIO [=y] && IIO_BUFFER [=n]
>   Selected by [y]:
>   - JOYSTICK_ADC [=y] && INPUT [=y] && INPUT_JOYSTICK [=y] && IIO [=y]
> 
> Fixes: 2c2b364fddd5 ("Input: joystick - add ADC attached joystick driver.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Artur Rojek <contact@artur-rojek.eu>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: Paul Gazzillo <paul@pgazz.com>
> Cc: Necip Fazil Yildiran <fazilyildiran@gmail.com>

Applied, thank you.

-- 
Dmitry
