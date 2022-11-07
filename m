Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F8461FEAC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiKGT3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiKGT3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:29:33 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930E6286E7;
        Mon,  7 Nov 2022 11:29:31 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so11229656pjk.1;
        Mon, 07 Nov 2022 11:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iEfHzcEzKlzRhD24huqH+pW0tBmUJkRfOPCyvf1PhCo=;
        b=NaDgM/8fqSn0Ytep+9iy7n7d5MogwapgEPfJQvSZZM9LqlDLfAzrYtitca102w4Ej+
         tXv9Hq3y6YZ8EqhfDqQTbKbHbW0FDJVhSbr0TkkoIiglI4W91KBaM/CgJ/xfpo93ErKF
         gLosliu+3B6Ni6Ftv5r8WcyNVvtdbn65uhzNoXKTalNangO2P++YnP2K/AzEeAbdhCYF
         Ijq0kTHcawaOR1qraOZkwGgSboI4Hk8zHkLM0RIzhA0cVyllYgXvH8mReYHq2FEjK550
         uYa6I2xu8p/0GFCmO8d99iCs2QqPdMmUgKR/JCu7oRD3h27C8QrF9nzkZxBtNIwT70uA
         RJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEfHzcEzKlzRhD24huqH+pW0tBmUJkRfOPCyvf1PhCo=;
        b=Ig2m8r0ggXsZxefQ1U8PUd2VaN/iewSf+63lUSiyBmtqUVnGfjVV95lNxUmGE1diE2
         dyf7PZS+bdrAPyE8dfc7nMJ9rtEIa+kTe7uBhoOgGVyzSBMo9clOHyKVGDCeYJGM8LWG
         2pHipr62YCBeYhhSTmWPBcQbhIr4I8sTht9CZJ2Ymi0r87MpRLEfwO0ZEh8G39e87/vB
         GNAmLufV9e8BY5WVuiN8n6u0+KJtg36a2jBKXVFaNL7lZXbOrRK0FGvw43RCZPsFixB1
         4esqwFlSKpqnBoilJQt60DLdUax0X+HedDjzwF/SC+JIaFH7NVqprLZ53aBtjiF8FsH8
         G4SA==
X-Gm-Message-State: ACrzQf3yBFGbiAD4BgLEmdk7s+vkGy8XxRJXnB7I05rXl1xsBE3CnNuK
        LvSdADTZRK+ZqLzrUTUKJUo=
X-Google-Smtp-Source: AMsMyM6er5d3pWwxKd0mOfr9K8HeWoDTvtOeFyYvdcCnkD0HQbMh3eZ4Y1/W4b0gjOyHFs1MYy5BYg==
X-Received: by 2002:a17:903:292:b0:186:f931:ec29 with SMTP id j18-20020a170903029200b00186f931ec29mr52141782plr.144.1667849370914;
        Mon, 07 Nov 2022 11:29:30 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:626:eb80:9eb9:1fd7])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b001754cfb5e21sm5364139plg.96.2022.11.07.11.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:29:30 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:29:27 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Job Noorman <job@noorman.info>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH RESEND v6 2/3] Input: add driver for Himax hx83112b
 touchscreen devices
Message-ID: <Y2lcl5Ylg9J8EJOD@google.com>
References: <20221107105604.26541-1-job@noorman.info>
 <20221107105604.26541-3-job@noorman.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107105604.26541-3-job@noorman.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 11:56:03AM +0100, Job Noorman wrote:
> This patch adds support for Himax hx83112b touchscreen devices. As there
> are no publicly available data sheets for these devices, the
> implementation is based on the driver of the downstream Android kernel
> used in the Fairphone 3. This patch is a complete rewrite, though, and
> the code bears no resemblence to the original implementation.
> 
> The driver has been tested on the aforementioned phone.
> 
> Signed-off-by: Job Noorman <job@noorman.info>
> Reviewed-by: Jeff LaBundy <jeff@labundy.com>

Applied, thank you.

-- 
Dmitry
