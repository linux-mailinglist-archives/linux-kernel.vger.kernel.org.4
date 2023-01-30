Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975C3680533
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjA3Es0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjA3EsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:48:11 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545C2CA27;
        Sun, 29 Jan 2023 20:48:08 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 143so6788701pgg.6;
        Sun, 29 Jan 2023 20:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pJb94rjIHZo2BMdRNvbQcNb61J/Yk21KZHD3NHxtnxQ=;
        b=adFa1nbHwrUeShQ1L9PrtyF9oqTBezNRr1a9recfKzuREN6r6vYYPak6pGmbutGjhe
         /HKP+Os+9kgNKGyFhpQTpc8QnZHrChQ/ZUR7BVM0z9syBkOHxZSiTBWMbPa8nMDL8jeI
         apyANl3kOvxekrd48ww8FhFyrZ6KiHPdnecFuJnEkm8dUViUPPf6zDNgyq7510e9lhfc
         /gJ8kpP5HTZq5GBjbCjUm28E2novviR8R+nOpgxynGy+AUv1TtNrdth+LG19blN61y5c
         som4Q+EVrGBkX65dpNXUVH3DeIFifm60kL/O/7p+orQV572KxwlDxIMshv8v5/QwHeVB
         di5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJb94rjIHZo2BMdRNvbQcNb61J/Yk21KZHD3NHxtnxQ=;
        b=kPygQ72hcHgyyQSMBmKq0WxhXB7vJVsB4c51xu94rsNW7mikEp1kqCgvUXn6bayM+B
         nBbcDZmD8mjMlKokDiy6tQpYMyDJA6F3kI7MBKDXy78lNtT8pfy/46ZKLURxt1lNcoJS
         KOyx+uFkbJWpbnz4VGlMVtVIA7kBIWpg2KvvNolVKiFAZeAC3fMzB5UsqJTCgcBidGnM
         THG4JYa8wdeDV0xUkuQ2tKmdKA6GT5/BYFNrJ1MCoYbnD8Zfx9lYgaEQi9dKbISFurze
         FQAq0ehCWtrMLDzMetfMbbPLQDE/Z5OdvGhsGCnN6BrnmQyPgjvoKhLGaVdF5vetLbzN
         RuJw==
X-Gm-Message-State: AO0yUKWLSAFVuyy7OmxHmhPgrhhpUyHu/HK58rJgLR4xUsL1RwiMovBC
        Cb71WNqR9rvIN49Ljy11rLe3FcHvrqo=
X-Google-Smtp-Source: AK7set8a+Vd5nk2nJUzG+xUX6PJWfh1HQy31OtbAiiNKbzcdoBMo57HrGI/J4uRhHZnLwfRCEhtXpQ==
X-Received: by 2002:a05:6a00:a18:b0:590:6a57:9904 with SMTP id p24-20020a056a000a1800b005906a579904mr19580518pfh.14.1675054087747;
        Sun, 29 Jan 2023 20:48:07 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6882:174b:bc70:101])
        by smtp.gmail.com with ESMTPSA id x2-20020aa793a2000000b00592591d1634sm5798510pff.97.2023.01.29.20.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:48:07 -0800 (PST)
Date:   Sun, 29 Jan 2023 20:48:04 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ye.xingchen@zte.com.cn
Cc:     wsa+renesas@sang-engineering.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: =?iso-8859-1?Q?olpc=5Fa?=
 =?iso-8859-1?Q?psp_-_Use=A0devm=5Fplatform=5Fget=5Fand=5Fioremap=5Fresour?=
 =?iso-8859-1?Q?ce=28=29?=
Message-ID: <Y9dMBJnKfCTzSg7i@google.com>
References: <202301281608287301370@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301281608287301370@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 04:08:28PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied, thank you.

-- 
Dmitry
