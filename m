Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B5060AED1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiJXPQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiJXPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:15:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C62721E29;
        Mon, 24 Oct 2022 06:54:41 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so13055780pji.1;
        Mon, 24 Oct 2022 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8lEhJhNYrJyVdV9ncTkj+ktV/kTdL2ObxQ9D4QNhvTU=;
        b=bTuKS/c1mvo5li261XMFcNENZgJuwEYgzg97KVKYJ0dS21QtyKdjaTgOcWToSC8aO7
         KZxWd2wUqwtWm8mkG9zQekHqUyMAhCsbSFptSGiaD+MyDkaAVCzwZcatk3pXuoqIYnN2
         O9xk3RMtwVz9iFHV6nKOnRKM2uV8cTq9ldu9AWEBL9zfDEoPGWTOq0V9k/nur56Vkce6
         Zig/2QN4kJkMC9UTz2mgc27mpsM/U+ENjK7lUU31UKg6ltePg0LDUBNwgbk/WVjaghGB
         JNuDVLFbKGOc9agHYJejVEyie9aMCAQPXnkqRRia+DMK5blFCQFFkicLQL1X4klC7vMH
         Qnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lEhJhNYrJyVdV9ncTkj+ktV/kTdL2ObxQ9D4QNhvTU=;
        b=NTozIYDRELTnDmjVOZ2CY/m3hMev34PaFn5L8U3y97J7ruiI6aVALBI0H3QBtDfijL
         +MtYSnrVjrIzhwhxuHOcisc0X/i7Kieb77k0NBiJ0QRRjRmjhAvFSwNUOfjvYTDj/owb
         Z27VHXWffXulp9sRaxaRNJmswRfxSDrSZr+hlbkk0aYSS/xIlfg6Wpb/eXnZLeDAa1AM
         THq+3/m+6LMGUIsbQ0pEl0gVB6SyiZsVroLuaM8j4RElpBsdu7g7RZBiJlC8mjFYGFBd
         ilgaUMcUssmgMNz6+6OeGMmVuuDf9lrYsF+J5H+aYwSiELi0d8FaDiGghblAFPaLyHX4
         xNJg==
X-Gm-Message-State: ACrzQf0lprxmZNqDI53cDA8JAulabgwm+vXHlVnZ7zhEABuUYv1Rt2/p
        T26iLIKc17aAmYry6ebR9KNC8/EJKY0hDA==
X-Google-Smtp-Source: AMsMyM6rrLGnzYSpUMpqzUHEUu978FrkEXYqX08g8cmUrmbT1TyyLxE8Jdo+56cIy5QKoDk3jkSuvA==
X-Received: by 2002:a17:903:1112:b0:178:a030:5f72 with SMTP id n18-20020a170903111200b00178a0305f72mr33101227plh.12.1666612774369;
        Mon, 24 Oct 2022 04:59:34 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3698:60f8:9964:1fb4])
        by smtp.gmail.com with ESMTPSA id o15-20020a6548cf000000b0043c22e926f8sm17238603pgs.84.2022.10.24.04.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:59:33 -0700 (PDT)
Date:   Mon, 24 Oct 2022 04:59:31 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: tps6507x-ts: remove variable loops
Message-ID: <Y1Z+I7EBn+P0m6wG@google.com>
References: <20221020181642.24417-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020181642.24417-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 07:16:42PM +0100, Colin Ian King wrote:
> The variable loops is being incremented but is never referenced,
> it is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thank you.

-- 
Dmitry
