Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C0967473F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjASXbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjASXba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:31:30 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA24D367E2;
        Thu, 19 Jan 2023 15:31:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso287255wmb.0;
        Thu, 19 Jan 2023 15:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ezoMouCrKxN4+hC09aQCsVRt36siV05JqIOGZbWNQRU=;
        b=btGyoBdXiWG3DqyDFEK9RVcWkizaGuwvn2PeDbboPaiGF862dbDGbjXNrwisNX/zx/
         YAInkdd9Agq9+8/Nr/9y8UO9XEan73Z1D3PCuxGtf3hG9xCLA6lVTk6GphGd3FO7MreW
         b0m5Cy4vyXF81ug+d1guxip6Ci4Z0k7yji9kXHUuU+ELHcbyHB6ScUTUUm7Dt073a3u2
         T8yJK1mY2NWWE3muTnEBhSGBoqAnHyG1eimDuo7POyGF9LXM3kiaVKZwZpEY7YbIVXDj
         ZfZl/Ux/lKumKuU7IL8XmDI9P2JC9tJ5BqI6bfdbFlSdqmmPoS+VI/07M5vREPIDp7I5
         oElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezoMouCrKxN4+hC09aQCsVRt36siV05JqIOGZbWNQRU=;
        b=nnu1ci0IZciLpcqmMAbjbf7b8z7u2HHeeW8ZNAcn+XC7/Hq/r6ka5TJD8AFU9vs++H
         Kj6UFa2k1fMDPyil9Pf4hasfCkK/Gdi/UcRVWd8le8Avf6LYHmqc05HsCnJo+1KCnGp7
         mkg5xuE1EzUKLVYHv+uUr6iv6hx3iBcd7pVg/0frAaX1nrwMsX8tWiYgXiM/md+QelDH
         Yrr91tcukWXm/4LVjbHfMABmRYdPXJjudxrhJsubxOlpGKui3rbnk+qWxe0xvHdHqDwK
         du4Zt6QXuB9saObAicgKPFrIyXO3qB6LX8GjHgY2jxNc7sp8gs9JjkClJ3H8u4j8p0ho
         uUxQ==
X-Gm-Message-State: AFqh2kqMdQvkBJ3ZJQ+Lar4aw0bSZQdo9/zWtDYRJsG2VHjZpR4Z8r/C
        2Kz6ntQ/tUjbAcc4OhO9SxU=
X-Google-Smtp-Source: AMrXdXvyKpwLXDKTyfszH3LHONdiwNNvToDyaMbTuv9Fr0BtB+sDZhcPzM1bniwh2nat6fDBbeiZlQ==
X-Received: by 2002:a05:600c:3b29:b0:3da:f7a9:50ca with SMTP id m41-20020a05600c3b2900b003daf7a950camr3128955wms.0.1674171088155;
        Thu, 19 Jan 2023 15:31:28 -0800 (PST)
Received: from [192.168.1.100] (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id f18-20020a7bcd12000000b003db0659c454sm598599wmj.32.2023.01.19.15.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 15:31:27 -0800 (PST)
Message-ID: <750e22fd-ff90-0005-ce14-85c55824b261@gmail.com>
Date:   Fri, 20 Jan 2023 00:31:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] staging: r8188eu: Fix some endian problems
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Gaurav Pathak <gauravpathak129@gmail.com>
References: <20230119191219.12080-1-Larry.Finger@lwfinger.net>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230119191219.12080-1-Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 20:12, Larry Finger wrote:
> Sparse lists the following warnings:
> 
>    CHECK   drivers/staging/r8188eu/core/rtw_mlme.c
> drivers/staging/r8188eu/core/rtw_mlme.c:1197:49: warning: incorrect type in
> 					 argument 2 (different base types)
> drivers/staging/r8188eu/core/rtw_mlme.c:1197:49:    expected restricted
> 					 __le16 [usertype] mstatus_rpt
> drivers/staging/r8188eu/core/rtw_mlme.c:1197:49:    got unsigned short
> 					 [assigned] [usertype] media_status_rpt
> drivers/staging/r8188eu/core/rtw_mlme.c:1275:57: warning: incorrect type in
> 					 argument 2 (different base types)
> drivers/staging/r8188eu/core/rtw_mlme.c:1275:57:    expected restricted
> 					 __le16 [usertype] mstatus_rpt
> drivers/staging/r8188eu/core/rtw_mlme.c:1275:57:    got unsigned short
> 					 [assigned] [usertype] media_status
>    CHECK   drivers/staging/r8188eu/core/rtw_mlme_ext.c
> drivers/staging/r8188eu/core/rtw_mlme_ext.c:6842:58: warning: incorrect type
> 					 in argument 2 (different base types)
> drivers/staging/r8188eu/core/rtw_mlme_ext.c:6842:58:    expected restricted
> 					 __le16 [usertype] mstatus_rpt
> drivers/staging/r8188eu/core/rtw_mlme_ext.c:6842:58:    got unsigned short
> 					 [assigned] [usertype] media_status
> 
> The second argument of rtl8188e_set_FwMediaStatus_cmd() needs to be in CPU
> order, not little-endian; however, when it uses that value to call
> FillH2CCmd_88E() the parameter must be in little-endian order as that
> value will be sent to the firmware. Note that the conversion from LE to CPU
> order was le16_to_cpu() rather than the correct cpu_to_le16.
> 
> The definition of FillH2CCmd_88E() is revised, and the proper conversion
> routine is used.
> 
> Note that the original code performed one byte swap on the secong argument
> of FillH2CCmd_88E(), and got the correct answer even though the semantics
> were very wrong.
> 
> Signed-off-by: Larry Finger<Larry.Finger@lwfinger.net>
> Reportewd-by: Gaurav Pathak<gauravpathak129@gmail.com>


Checkpatch does not like the "w" in "Reportewd-by:".

Tested on x86_64
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150



