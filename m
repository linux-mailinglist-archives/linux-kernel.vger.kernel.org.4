Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A1A64DE2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLOQGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:06:28 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642E32F01F;
        Thu, 15 Dec 2022 08:06:27 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gh17so53396125ejb.6;
        Thu, 15 Dec 2022 08:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VX4tYAPYLAMSU6fO3spNXqyMkb66pqQTAjpl3aq1zuQ=;
        b=GWBnyoHAA4uuPna3v/35bGgAJvbIxWQFhSwiaoRJaPyUyyyYqPJwYGDoI1S3sFvgxK
         j+7LAeFy10FMq6c63BYBFsfHrifTgk9B9EXOevUjiO160b7y+sZiskKGYbuP4h519Xmp
         zOPWoAcoUaROHPOVxxdG8mpTvNwgRBQgK/8gSCVTfcBosdPLdA6I+qDPK3IRuQ3SUadr
         IunoZWtkKPwcWolvlS3VPWxJJJTd23j4SZKp1Ydgl+SVgyks/E6crRAaxHlx05tuT3Ry
         0RpRuSzxBv2pEKcP0WknB3mfSVGi75E/UC2lDd4Datw8wpp8Wg2s2HeBjALa9wc0LNHb
         hgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VX4tYAPYLAMSU6fO3spNXqyMkb66pqQTAjpl3aq1zuQ=;
        b=IDgq64hbWDxeRZV4l7p6sqtOcVcL57FLe2wABH6xskQFRvzVoJU/2FtD3/kbqAN2Pd
         6B4iHozJYxdkUnNZCozJuM6RprVBaPieYr6UidfuadrIrmCn4dDQBrYUkuRsuvVbnRiZ
         YaI4unEomkxz35AOYcTwQQ6RmaOzxl1JrHBKzbBeV8dTRSTrTqeXtP1+xq98cDPmedx4
         57XkyEEXzrjdD3cDBNeIpyOyjPHTnTJMouOBrjPtRfPdNb2GB6eV+QfaTJoi5UlQcZws
         WO6g61FdDluWdjSFqcgtHC5ttxL6b8mo5rEgwVVF95R0G40t7unRs4japuhA3iATV4Ve
         83DA==
X-Gm-Message-State: ANoB5pnzEh0Z0LSw2/wifx5mar9sshQy/0pCI/mxtDDbutKvqXnR9Szn
        hTxp34KFDovjEp09NtLNX5Q=
X-Google-Smtp-Source: AA0mqf5EEV2czRxfkopfAWcm9WKOBOg+Eq4ctkV9J11cqBj5ap/VWx8Y5GVDB1hQCFT5rOYU9q+v/w==
X-Received: by 2002:a17:906:2bd7:b0:7c1:4c46:30a0 with SMTP id n23-20020a1709062bd700b007c14c4630a0mr20392793ejg.65.1671120385883;
        Thu, 15 Dec 2022 08:06:25 -0800 (PST)
Received: from ?IPV6:2003:c5:871f:9993:b1c0:fc77:1081:c93c? (p200300c5871f9993b1c0fc771081c93c.dip0.t-ipconnect.de. [2003:c5:871f:9993:b1c0:fc77:1081:c93c])
        by smtp.gmail.com with ESMTPSA id k18-20020a17090632d200b0073de0506745sm7156471ejk.197.2022.12.15.08.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 08:06:25 -0800 (PST)
Message-ID: <9dd400a9-272d-caa0-13d0-20a47745da22@gmail.com>
Date:   Thu, 15 Dec 2022 17:06:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 1/4] ufs: core: Remove redundant wb check
Content-Language: en-US
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1671011427-26184-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1671011427-26184-2-git-send-email-Arthur.Simchaev@wdc.com>
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <1671011427-26184-2-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arthur,

You forgot to add Stanley's reviewed tag:

Reviewed-by: Stanley Chu<stanley.chu@mediatek.com>

On 14.12.22 10:50 AM, Arthur Simchaev wrote:
> We used to use the extended-feature field in the device descriptor,
> as an indication that the device supports ufs2.2 or later.
> Remove that as this check is specifically done few lines above.
>
> Reviewed-by: Bart Van Assche<bvanassche@acm.org>
> Reviewed-by: Bean Huo<beanhuo@micron.com>
> Signed-off-by: Arthur Simchaev<Arthur.Simchaev@wdc.com>
