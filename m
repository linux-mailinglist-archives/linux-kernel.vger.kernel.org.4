Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31A26DB5AB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjDGVCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjDGVC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:02:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09541A276
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:02:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-947a47eb908so89715166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 14:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680901328; x=1683493328;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPcKdBRSdTG+FoVQj+kLiPvFB7VrPFru5LsqZmAmx20=;
        b=l4F/ErgZZ6pMP8I8zZc3yQHipp9CKB7I6l//amZdnTi84bFTdEUpePK+nAZnoJaHto
         UJhhWFDiuAXIaRrUy/NIlHF5V+JYyNjuRo5irbhxvTIPbo+kJB+5iKce2VKMAhSf/5Ij
         hKnIdNnBPw6IJU+xwM264fRHWIrOO0KirRGIyvDYyklVvbdVnHM7dVk0KiyHhc/9WRUH
         sJqoAPmrFe7mFgUMfkEzycqRDfLE/JAijMXKMenueVZ81YCRkL2zwNsdBSE+yB8rM1ga
         0TerRYP+/lp96gMaFWbz7yT3TGsXmzmz2f/A13SgyNFw1gDZck9Tid7+VeUvRHKRyvgY
         dlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680901328; x=1683493328;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPcKdBRSdTG+FoVQj+kLiPvFB7VrPFru5LsqZmAmx20=;
        b=0ssf+XgrXF/a/U1gYilCsoLtAc4mGnfSn9ZHrtcPBZPuTevQXxP9sE59JIvs9teOr/
         kF7zzso4knhdG69RIz2RL0xK54OEY8SJ/ggVDw2/WTk6nXQH9lPAmmvJ08taQ1EEm+AS
         f8AMAQsgvbvUqT1hvxY1HDQ0Nd/Cbpzdmsk2R9ct5EPzx0UA29+LIy68tkGcvDtMxSDo
         rjAskmfOq/OIDRrocZhdYOYyoN6KsADLMMm0RriDf0XGkTiw+OhghiI6vnoqlwd1Gu7b
         ZnKlmNkMStkOl1kkl5vkgd7gjR+B153JeoT2H/8tqXDLjC0sE0BJs+k/YCZi4AP233Hi
         vGOA==
X-Gm-Message-State: AAQBX9cmPKp2pOVQJZMQNtH/l6dro9BIF0Urq/f0qWe2cGUsN1HKRcRX
        k1n8ziP+XDgGjJ3GXKrMdtc=
X-Google-Smtp-Source: AKy350YrQLmUc4IVssaOzvjGV2ceDC4ifXsiXlT8LRI7cfgURUDQWMNpPVC1cttXrVeZZq5SPi5PRQ==
X-Received: by 2002:a05:6402:4413:b0:502:465:28d4 with SMTP id y19-20020a056402441300b00502046528d4mr763142eda.1.1680901328081;
        Fri, 07 Apr 2023 14:02:08 -0700 (PDT)
Received: from [192.168.0.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id ek14-20020a056402370e00b005028e87068fsm2228219edb.73.2023.04.07.14.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 14:02:06 -0700 (PDT)
Message-ID: <248ec330-b4c3-aa7b-61eb-69ce8d333b69@gmail.com>
Date:   Fri, 7 Apr 2023 23:02:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: [BUG] staging: rtl8192e: W_DISABLE# does not work after stop/start
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <39dc735c-fd6d-e405-856c-788a52704d63@gmail.com>
In-Reply-To: <39dc735c-fd6d-e405-856c-788a52704d63@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When loading the driver for rtl8192e, the W_DISABLE# switch is working 
as intended. But when the WLAN is turned off in software and then turned 
on again the W_DISABLE# does not work anymore.

Reason for this is that in the function _rtl92e_dm_check_rf_ctrl_gpio()
checking this every two seconds is an conditional return.

	if (priv->bfirst_after_down) {
		priv->bfirst_after_down = true; // PH: useless line
		return;
	}

	tmp1byte = rtl92e_readb(dev, GPI); // PH: GPI for W_DISABLE#

bfirst_after_down is set true when switching the WLAN off in software. 
But it is not set to false again when WLAN is turned on again.

Thanks for your support.

Bye Philipp

