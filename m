Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79AF69CFCB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjBTPAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjBTPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:00:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737D6FF1E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:00:28 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c5so2211836wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTfZYHe/X6zZag4f7TPYxf3JfRu+8rYIA0Cjw4xepRo=;
        b=mel5rf3A3XU3JSS6gx8VOtZhSb1dzQUKg4n4P3oru6IvEnW88L56DC8eVsJZ7/BkGw
         pPTDlSeEz1EC7Hx6QLUpdU+NaRkgRPhBBx7HmKg+p9U9nP7pwo+tVvXrauSlyEpzjFjd
         oH9J4aRZOKFdmJ2nSoS6K8nUOYpmxGCbz43/jnkHze8fqtcUka7QqrqStKKOTHW5Z+se
         viRbPC1IxkxKFzyqn+aocouqokepdnu/HD1FTyNB/0zC/0m3gubmRJA/q2lWR+0/F7NF
         GzgFDY8IWJ8hpShKhl1hP+3xF+zbdViTYnWEi5m1cJTFKAT1IffF8UkuLy4hIKhkeQJk
         DxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTfZYHe/X6zZag4f7TPYxf3JfRu+8rYIA0Cjw4xepRo=;
        b=uJDhzhQhm+yaDx9VRLTbGARoxnx5BFw7SXWNXuk5sSkQNa+FOuvi9MdONeqYTqG65y
         JF7kdQY9QED6mT8PYxNaOD3JvsX0x8fHUfqVsK5RUcfyVmjeKRJqLq5z7vrOPFsa4f27
         zsUiAlSszQGFobyr1ufXvUpEONQD5xlUYiCZX7tLf26cvj7aBOg6FBTHsigBgG34CYts
         +WRjQyAztOede/RXSkMabmJCA3t+hss+ef3WcfaO2KP9RRM3Sl6v1twIRUYwVOBvdBAx
         /2Xiczm1f4FD1IS1Pr52hx4o4VcpJ7XQTq4Q49ircHdsd96SdOXTBazR7eeDlp6kKw0h
         B/xg==
X-Gm-Message-State: AO0yUKUiHud3802YiMzXTMiIzCge7Vud5jyMqf6sWnUfhgJG5NsYHPnl
        I410Wd4XkJzMNJgHx3ZZn1w=
X-Google-Smtp-Source: AK7set9Xzw1ZL/YOJtkbC+dfvfNWbTdb2GX3nLV1ccierTsJ7OLDuuEPYxtpYgBZ2rwrRS7NQCK/PA==
X-Received: by 2002:adf:dd43:0:b0:2c6:e893:6f3a with SMTP id u3-20020adfdd43000000b002c6e8936f3amr2205115wrm.16.1676905226761;
        Mon, 20 Feb 2023 07:00:26 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x8-20020a1c7c08000000b003dc4480df80sm528893wmc.34.2023.02.20.07.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 07:00:26 -0800 (PST)
Date:   Mon, 20 Feb 2023 18:00:23 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Shibo Li <zzutcyha@163.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fix multiple line dereference
Message-ID: <Y/OLBzn6sCzcMwgj@kadam>
References: <20230220084050.18459-1-zzutcyha@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220084050.18459-1-zzutcyha@163.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 08:40:50AM +0000, Shibo Li wrote:
> This patch fixes the following warning in rtl871x_mlme.c
> 
> WARNING: Avoid multiple line dereference - prefer 'adapter->securitypriv.PrivacyAlgrthm'
> 
> Signed-off-by: Shibo Li <zzutcyha@163.com>

This one is fine.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

