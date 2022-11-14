Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EE6628456
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbiKNPtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbiKNPtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:49:11 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840301E715
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:49:09 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bs21so19032321wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ywjhlDr3qfSyUxeJZo0qqvUEFKwVEcvvAGR/9wCuiFo=;
        b=EMlfXctXb6UH4qvddvDUSBU9aGzxsh0rX7JsphvAl3seKmu/4es6TR6hfgD3amF13V
         I2Og48ux6Mr0TL320f3Pu3QS+dPILmXcefzpwfLN6DgoUmts9gWsOX6SFB1N418wP37/
         dOFATnxYOCNk0ZUKzfK7mHrT/A0mLDnY6gTHD0ViL1ESKG3i2chU/f1uBAcaedi1JjPt
         RWr2KcoEGb+uB99BJabp7hHp+CML2xRHIToP8QSBfXSM2k0L+Vk9ESj9YktIykK6kFCF
         gZ/MfMrtYXTDB8dIWjS9Doc358bOw7vxjvFUaL5LI/Ec+punGnMNB7RkHETkEYd7MFGr
         /HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywjhlDr3qfSyUxeJZo0qqvUEFKwVEcvvAGR/9wCuiFo=;
        b=sQOhbvvOv8sh6eokE3dX+QYxeT3Hl5LCMskwwTgvBgKEy0Y75f4OvWsEIP8Piez9E8
         w6wtb22OfEKqy8xt28MMAJ9gXlYTpM6ecivQTkTcIr53iahFd/muXbqGltwcdlY/mL85
         usK/0BBzyLKnpsJzHims8FucXfISk3hxM0OeN6ikDhPD4HG8zYN6DBrzlIMjU4HdDXKF
         dBK/a8MmRlusAvGaqxFskU+Zx0Z9/1CRRZvqoUWN3m6asFr36Yn3pvQOIu9o2ew+cOPC
         I79/2hbFVyzCh4pJ+HDIy6gwE3MZT0MrHUNea2KloJ2s1cpfyQER0ha4smSKzkSDOsE2
         4IbQ==
X-Gm-Message-State: ANoB5pmdbwagTlQjLpyDacyup1nl8lMAX8hK0+xXlhWhomIT5CgRxfSn
        Ym1IGQ28/1gh4xyztgAaxeIkqA==
X-Google-Smtp-Source: AA0mqf7GTPVsskyrC0ob8SZncUMQxrPW6gbYd/2tEK7bso2W0kN5SljB7f1nR9F9AEtEjkO3IOxdPQ==
X-Received: by 2002:a05:6000:12d0:b0:22e:2c8b:993d with SMTP id l16-20020a05600012d000b0022e2c8b993dmr7676620wrx.523.1668440948030;
        Mon, 14 Nov 2022 07:49:08 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id o3-20020a5d58c3000000b00241727795c4sm11069871wrf.63.2022.11.14.07.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 07:49:07 -0800 (PST)
Date:   Mon, 14 Nov 2022 16:49:05 +0100
From:   Corentin LABBE <clabbe@baylibre.com>
To:     linusw@kernel.org, kaloz@openwrt.org, khalasa@piap.pl
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add related dts to IXP4xx
Message-ID: <Y3JjcUol46DTb/7S@Red>
References: <20221005105734.3513581-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221005105734.3513581-1-clabbe@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Oct 05, 2022 at 10:57:34AM +0000, Corentin Labbe a écrit :
> get_maintainer.pl currently give no maintainer on all IXP4xx DTS files.
> Add them to the set of files handled by IXP4xx maintainers.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---

Hello

Gentle ping

Regards
