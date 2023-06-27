Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E687474025B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjF0Rjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjF0Rje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:39:34 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ABC26BC;
        Tue, 27 Jun 2023 10:39:33 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5704fce0f23so50849747b3.3;
        Tue, 27 Jun 2023 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687887572; x=1690479572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UddukGzDr9cqXnJjft2zN096RunUMBPk1ZP9zcIRksY=;
        b=NgRmv9FKdh5Q+LNSTdST/2o2OBuExWiOV8h02pIHQ/TrBIRto31DTPVqzaHbOuAsj0
         SigrQYjoDDwOLdfvubbp4rFjQsAmm0oZeWk4tdBYYNHR01RLWC+zEPnroDaKA97lkCFC
         292d9HSAO79xpLaCBIEWs+1lfQquYvrBBBPsGXgI0JwwQrBOqceB5V2gsrzW39HeuYHY
         VleOiow6bINTkSCr5qbRxnx+2dEQniSPs5MPSOZjGv7E/DRO3zyFJl9BXZCCyWrQTLFP
         7J2U4G0YPfTMyPc0lxmRf3MsbyF0Kh7MpyCzOKp+tCcsjmGl7ZZu+fSzZFK/nL/i+6Es
         +Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687887572; x=1690479572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UddukGzDr9cqXnJjft2zN096RunUMBPk1ZP9zcIRksY=;
        b=PQ5zhkhhZL4T2vYgqUU6F2On/FtIaj4xLaHbGuzs1Xc/d+SEOig+H40ccUJ+OsuKyW
         rh/vgeuSwu0lMeFOBOBIfFvPyoHtRAFNw9G0Xfl8S9dq8XBiVxLnmVRWpVOr3ZjV4UCW
         EOZHT8RmsLxSqt7Wg9vMakkV+vPtKEQalqlHwpsNg6krxTagiY7hm/QjW0AYSe9SU1Je
         qEhjAQcwsmMRGpZtqJdTCESn2brRulK5GvhcPXxRVloim3648e1NKesoggk39RvScpOJ
         MDfAKhn2pMbqtYeLyDbGGjyVe40OIoSUyxXGLiajCh9yoi5veinzAG+OmSgBBDyGV9nl
         id3w==
X-Gm-Message-State: AC+VfDygU7h4mMhXT/QWNr6LS9WLBJj9eqMEieQaOs2kzDaUqnw8LmbX
        80dnry8ud8ONhX/zSdiyqGU=
X-Google-Smtp-Source: ACHHUZ7RqicAy+xU4YzAKnqkrLd8/3esr8uvdkSWjgbxlKpZtkxz1LLt+F7Lrrle6B/c/WGm4426CA==
X-Received: by 2002:a0d:c081:0:b0:565:cef7:92d2 with SMTP id b123-20020a0dc081000000b00565cef792d2mr33492414ywd.21.1687887572372;
        Tue, 27 Jun 2023 10:39:32 -0700 (PDT)
Received: from wintermute.localhost.fail ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id d13-20020a81ab4d000000b0056cff012ee3sm1898763ywk.121.2023.06.27.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 10:39:31 -0700 (PDT)
Date:   Tue, 27 Jun 2023 12:39:29 -0500
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-rockchip@lists.infradead.org, stable@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: rk817: Add missing module alias
Message-ID: <ZJse0Z7OMeh+tuur@wintermute.localhost.fail>
References: <20230612143651.959646-2-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612143651.959646-2-frattaroli.nicolas@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 04:36:52PM +0200, Nicolas Frattaroli wrote:
> Similar to the rk817 codec alias that was missing, the rk817 charger
> driver is missing a module alias as well. This absence prevents the
> driver from autoprobing on OF systems when it is built as a module.
> 
> Add the right MODULE_ALIAS to fix this.
> 

Good catch, thank you.

Reviewed-by: Chris Morgan <macromorgan@hotmail.com>

> Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  drivers/power/supply/rk817_charger.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
> index 1a2143641e66..76b991e112da 100644
> --- a/drivers/power/supply/rk817_charger.c
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -1211,3 +1211,4 @@ MODULE_DESCRIPTION("Battery power supply driver for RK817 PMIC");
>  MODULE_AUTHOR("Maya Matuszczyk <maccraft123mc@gmail.com>");
>  MODULE_AUTHOR("Chris Morgan <macromorgan@hotmail.com>");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:rk817-charger");
> -- 
> 2.41.0
> 
