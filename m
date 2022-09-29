Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919C05EF842
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiI2PE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiI2PEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:04:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1029515FD0;
        Thu, 29 Sep 2022 08:04:49 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id r8-20020a17090a560800b00205eaaba073so1589840pjf.1;
        Thu, 29 Sep 2022 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=IgnHi+RcHTXZNmj2VHSJ2SFXpFxGODlDM88DUFhnlCk=;
        b=gjUKFhvViouLKkhlJrIfKovkfe+bQSw5wSj/UfXX6uvTRu9tcQ/JU0XHYosAnXpHHn
         xIKYlYrQn2Ru5LKlYZCgt1Q6E24uZov8E299zwgwQ48Bh/4MkyrRgmA9250QX4J7zMVT
         MdHWq1k6Bnzzorhjd5V6FwJwWgLtwyGAdZfUKwpLAl+zja4xJgNU1b1boWG7xkVCbrmv
         OXOpJEGii0I6nmK6QDTECuWW9IeIu6p6QPafZf1tVvt3f0UuVkn8kn3rbGjWiHF3fcNF
         +HllUJaHZhtTONBaCD+gKLK9SnglzMi05W1Nv0gzUWT5cwmrRg/pEXcusA7kaavaRJtE
         z5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=IgnHi+RcHTXZNmj2VHSJ2SFXpFxGODlDM88DUFhnlCk=;
        b=iQPIzUewZeJVVQ4hlPmYAM7LJQ0aFsLiYN2lXg88/q9ljrGRoPv3/1BhoSXKo1+DvC
         jAFJoirelETsTgGLxh/TTVy3LcD3fA7VEGlGDg4OuJ5JBsd3VHaMR6DsFHfWmj+1zwYm
         rTZdAKz3X3N3Wspmoi/IclQA3MltfgqSHqpJ/yN6gCB1C1W7hQEFTYLtu9ceHs5PCFqi
         fSjcWIyWpsLrHUV7/5wQI1JKsYyPVZQorLgklbApKOeS8kI5eWbpSDVDQbI80cq/Yqqo
         V53CEzMpRjv8Tyfz1tFDXQajVEK8iqoVup/lAIPN3fAH/53EKAIcdhoSRsLvtblaT/X3
         PcNQ==
X-Gm-Message-State: ACrzQf3PuuIJ+nYceQHSddnyTtcGJh27rythqspGxnbIcVTXZrWUJj8k
        PYS7qIwYrLGDDsnPeXToVJs=
X-Google-Smtp-Source: AMsMyM5s5dW8ez5512q976BZUNSH3Ye55LuUnU26hsQIQQTP5qkGh3Kv0jmERjtEyK8+Fjp/5yxZIg==
X-Received: by 2002:a17:902:a511:b0:178:9702:7199 with SMTP id s17-20020a170902a51100b0017897027199mr3761615plq.155.1664463888193;
        Thu, 29 Sep 2022 08:04:48 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:637c:7f23:f348:a9e6])
        by smtp.gmail.com with ESMTPSA id b12-20020a63d80c000000b00422c003cf78sm5597419pgh.82.2022.09.29.08.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 08:04:47 -0700 (PDT)
Date:   Thu, 29 Sep 2022 08:04:44 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: wl1251: drop support for platform data
Message-ID: <YzW0DKogKykrtonb@google.com>
References: <20220928222210.1922758-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928222210.1922758-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 03:22:09PM -0700, Dmitry Torokhov wrote:
> There are no users of wl1251_platform_data left in the mainline kernel,
> so let's remove it.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  .../net/wireless/ti/wilink_platform_data.c    | 35 ---------------
>  drivers/net/wireless/ti/wl1251/sdio.c         |  8 +---
>  drivers/net/wireless/ti/wl1251/spi.c          | 15 ++-----
>  include/linux/wl12xx.h                        | 44 -------------------

Apparently there are a few places still referencing this header. I will
resubmit.

Thanks.

-- 
Dmitry
