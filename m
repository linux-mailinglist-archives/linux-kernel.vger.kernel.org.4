Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215CC6C8C33
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjCYH2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCYH16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:27:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3E41166A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 00:27:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ew6so16118536edb.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 00:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679729276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl1PuHlEkrI0wqx6ZTM2HfHVZPCcP/xvjlX781kpYaw=;
        b=g6jl5PILobZbrpLZeaCrQQYPWhMUNkxCGxE2uRQTxMSJlrAFnk8eJju+aFCM/bC1p9
         smzFx7ox8xobLoNIb9bE45odI56shl4P4BZAb//4EviF9kfqsNB/Yuu6Xdy5G2HpRfX1
         Xz89MZJXHVu4f18kGfIgoFol5h00byvDhfunGQhXPVspihmwH8udlXO3ksXhIgYHBz1n
         ji6AIrGPk4B5ZRwhndvSaJjSHqUBgM1XJDIRButWorFaj3AmupsU387YKo+OEyEQaxrF
         nnEy/rkGkZndoo8emE3kAGnl9Vcxuot5Apovd+I4mj47nBm8TGfDtWXCfeihu4sEreIJ
         gC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679729276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl1PuHlEkrI0wqx6ZTM2HfHVZPCcP/xvjlX781kpYaw=;
        b=DTnRhjdAw+I5FRN6Ir2cXazhMeXIjcfwSw5QEN8CL3JvUDRQtP8i+mSoS7418574fU
         TfA13T9Sgk1XiPQCH6yLF3b64rTNlEguXnykdofagBsPofcT3T/5qI7Y0s5j8ZWR9Xd6
         nRvPyl03Sb7BELA/XMyd5XuAcQgkHPoZ9J8zezlyOiB3b9+GDR+sGO8WPYKrMSirpq7D
         FxtlQe0pAijd3pmXPH6bhbluIMVk2lxEjEA+Xuc38neGU764jTmvX2Qb0wCXHtzEpAOR
         RpD9tG+izb4oVPRPU60XDL08KphDmSgxJVx61FEaK3g/3U+SGJ+ok+E1p5NZdN4BHrYR
         LyEQ==
X-Gm-Message-State: AAQBX9c2gNJZt0rRl4G1QqEzbyYYSY/wMcueMLmWBdarrwwuXahiZ7S4
        JtT9+64WJBqLhTR+CDqzjBw=
X-Google-Smtp-Source: AKy350azekAWDgK8X/LXuBdtAzvVG5JhxS2oIcG2tqcQbqiJbRlqdIlfLiNl2TzKIPuHGQHzGakiRg==
X-Received: by 2002:a17:907:a64a:b0:92e:e9c2:7b9c with SMTP id vu10-20020a170907a64a00b0092ee9c27b9cmr6299333ejc.77.1679729275893;
        Sat, 25 Mar 2023 00:27:55 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id hy16-20020a1709068a7000b00931d3509af1sm11296338ejc.222.2023.03.25.00.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:27:55 -0700 (PDT)
Date:   Sat, 25 Mar 2023 10:27:52 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: staging: wlan-ng: Remove unnecessary Parentheses
Message-ID: <addce339-7653-405b-8d1d-ef29da74a8f3@kili.mountain>
References: <20230325002225.GA109622@koolguy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325002225.GA109622@koolguy>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject has an extra : after the "[PATCH]:".

On Sat, Mar 25, 2023 at 01:22:25AM +0100, Dalvin-Ehinoma Noah Aiguobas wrote:
> Clean up Checkpatch issues by removing unnecessary Parentheses.
> 

Just ignore checkpatch on this.  Greg likes parentheses.

> @@ -478,7 +478,7 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
>  
>  			result = prism2_domibset_uint32(wlandev,
>  							DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> -				sme->key_idx);
> +							sme->key_idx);

Don't mix unrelated changes into the patch.

regards,
dan carpenter

