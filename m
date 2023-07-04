Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69EE7477B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGDRWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjGDRWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:22:17 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15BD10C1;
        Tue,  4 Jul 2023 10:22:16 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1b078b34df5so5722037fac.2;
        Tue, 04 Jul 2023 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688491336; x=1691083336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=z7FZLomDWDbjdWX61WSlseufijU603RigLg7aNYHBJY=;
        b=K1fe2Rcalt7NRZxlZdobMv7vh0ZEDnCcEUDgWPJy+StZMldSwPBP6fMT+fkU0vOvP2
         /QYZmJ5+ZSn06Pt+4JNEso0RD0R522NQ/9YRYC26ACWTmMkhJHBCOTbEShktgPqw5MGH
         OEGF9gfqo+YX1TAySIYzMRU6AyNAdSLKPvw7AWDW9VqCAAAnX8rfAC3xHQPb3PSQK0ZN
         XYloU27NjWZqY/JqVpg71EzuXlsBBIXMlfBo0BrbRTjBdfwbTuuJX1+AwH9Zu36a7zOc
         9OD+81RRk7fgUNFxRDIIJCnNWlnMdLyLZrGL8n8Q4ppfZ4B3IXmrHUOZo3VpxvqhSfes
         ECrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688491336; x=1691083336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7FZLomDWDbjdWX61WSlseufijU603RigLg7aNYHBJY=;
        b=Mk8Ay2JHXW5NSxpS41Z6rp5MVuRXSoEwXLP6mY4I85FzudC/3lBBRWbXHHo9ywA80R
         +Pd8gMhcOmNoFC+x2EYSEQeqTHmQBZSUKdWHNnya5rwvphGsdgsuWHx4oMFSK/CDbaqf
         lvDVoln0LWsjjlHMAge/gxiY9ZGzTN+Oe2TaIGpZnx3gYVO45GGJtORsH5J5sJS81aES
         49kfgqO26g571nBuUKt+sy+O372swlrSORFnR2rct+G4xDsGt+xFTCzHTKe2PKHPD5ZJ
         weOxRVXpNu0NrdXpiMHwdt3BGqYBi7ICm89xhwEBUSkRWDdmcb67hrJyn1vbLqHQvZCt
         tDzw==
X-Gm-Message-State: ABy/qLbrKcNt0R5EwRn8Kf/5m4QLqVolWuEEVymmQtopocpKFfz8/xc6
        9BRrzeYeNW12MEeiEqiRONU=
X-Google-Smtp-Source: ACHHUZ6VEkTnut83c2dLjWl3PWRuAfEErbUOknHJwrNB91eQi5DvHdrZEnrnqA9zB6XzgUSOcEOjbA==
X-Received: by 2002:a05:6870:ac0d:b0:191:f657:13ee with SMTP id kw13-20020a056870ac0d00b00191f65713eemr15602832oab.11.1688491336194;
        Tue, 04 Jul 2023 10:22:16 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id z11-20020a9d65cb000000b006b884bbb4f3sm6045994oth.26.2023.07.04.10.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 10:22:15 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <9ccf927e-7e68-91c4-3cfc-0ff535abe0a6@lwfinger.net>
Date:   Tue, 4 Jul 2023 12:22:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] wifi: rtw89: debug: fix error code in
 rtw89_debug_priv_send_h2c_set()
To:     Zhang Shurong <zhang_shurong@foxmail.com>, pkshih@realtek.com
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <tencent_54814178D4285CA3D64B8CDC90D49A6CB10A@qq.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <tencent_54814178D4285CA3D64B8CDC90D49A6CB10A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/23 11:55, Zhang Shurong wrote:
> If there is a failure during rtw89_fw_h2c_raw() rtw89_debug_priv_send_h2c
> should return negative error code instead of a positive value count.
> 
> Fix this bug by returning correct error code.
> 
> The changes in this version:
> - fix some compile error
> 
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>

I have two comments on the patch itself:

1) Whenever you have a fix for the code, you need to annotate it using the 
"Fixes: tag". See file Documentation/process/submitting-patches.rst in your 
source tree.

2) The version change stuff should be in the following order:

Signed-off-by: ....
---
v2 - fixed compile error
---
Body of patch.

Placing it where you did would cause the details of "making the sausage" be 
saved in the commit log. The reviewer and maintainer need to see it, but not the 
end user.

Larry

