Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1CF685FB2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjBAGQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAGQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:16:13 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EE210F9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 22:16:12 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t18so16273130wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 22:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43QZSGZeU/cV5AUl6DL3ZEkjlzFe9GKndh8lRkabxOs=;
        b=by/kQctD1VEeCskvu0Qs94/FFwDrKfWv766kkqiUy8Oly1jomKj0ooirqkNjAWzSnu
         CViRBXEkJCxwhWzsDj0givTbl1dLdjqborUXckrrkD4ix7H0EawA1dm+9ZuTn2ajmMfq
         amU77FfeJ2HtlUhYWHqEZih3J/qk4M5vkZHnaTdWYBN7lLzZytJ6t6+nyfWz2UH5Apmu
         ki+2+IL0cg1J/9iJiKO6EPW2DfcsxIlV5SQQkvOF798/ICCcDbkGWRVROerrFJh0+MZp
         xgbR99fhm/O5s4MD3iEAo2BFV28kos9PXYguZx1wne7QiJdqpffBd0QNf8kH4kYGjl2q
         CJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43QZSGZeU/cV5AUl6DL3ZEkjlzFe9GKndh8lRkabxOs=;
        b=xuEKumJA5ImG74KW3+uJGTDXuBAjHx9JWOkvLGAk1goL2pQZW+Hs5naj0FCgKSzZ+e
         FPSZ6rXIYtDUJkO+T+F3paI/wlQh3TZ7wUahwNZFyJNXLXWIJxXbvjrUtFBolp/jZaoG
         ZZnZUGNkcCo6HJHa/lSEm60mo4yT2dZ8ctgV21R5GtyAmpwUs82NuTWi7docOidOqOMx
         bZgvDuCyU1E/YCrflWhyv/lhbeqocr2T38afFEquLpItLoOyWBREQ3KS4sxm68e9x402
         srHz268n9iEG6/3fL0C3GKako7n/V4E4bGahjL8Bc/Cfh3tdAljw7fKxLzp3Ldaf6LCg
         Jdsw==
X-Gm-Message-State: AO0yUKVEoudzB25ZKB8aOtIuVtqy3yFRBzaDntQax/0ZOxDdnk22oi+R
        qWQ8TT0jJ9KaLkkjX1s1lmtLhLla/ro=
X-Google-Smtp-Source: AK7set9TArx9hwV4sIFA7TxpurE4lv+V0FhZ0CkKESKuyyrgRc/j7kutLtRz0Lkblse0PBblIiuyPQ==
X-Received: by 2002:a05:6000:68b:b0:2bf:c1f7:45a8 with SMTP id bo11-20020a056000068b00b002bfc1f745a8mr1503541wrb.4.1675232171295;
        Tue, 31 Jan 2023 22:16:11 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q2-20020a056000136200b002bfad438811sm16660963wrz.74.2023.01.31.22.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 22:16:10 -0800 (PST)
Date:   Wed, 1 Feb 2023 09:16:07 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: Added information about bit_rate
 configuration
Message-ID: <Y9oDp4X6cO8iB6vW@kadam>
References: <Y9laj+z0TuasBRx5@combine-ThinkPad-S1-Yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9laj+z0TuasBRx5@combine-ThinkPad-S1-Yoga>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 07:14:39PM +0100, Guru Mehar Rachaputi wrote:
> Information in the TODO file for bit_rate configuration is
> insufficient.
> 
> This patch adds information on how to approach when considering
> to modify bit_rate to support upto 300kbps.
> 
> Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
> ---

Thanks!

Acked-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

