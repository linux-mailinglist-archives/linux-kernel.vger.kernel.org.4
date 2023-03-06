Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C6F6AC48E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjCFPN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCFPN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:13:56 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D90C17CEA;
        Mon,  6 Mar 2023 07:13:55 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u5so10683777plq.7;
        Mon, 06 Mar 2023 07:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678115635;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+nNvkpchLnkczpLTpflAGsHRqbPoVTogqo6z26wUpc=;
        b=ZAGV4qjoYCFHUsT/wTse6RdqonU9M5Y3OySZtLssotwpHfww6fM4l99wINL+U4KJYb
         32aHGMQDZtywW0NcrYAE3XBshXsrv/9Y46O7bomQbuIY2NaY6HaHa/OI2DkEXzsdZXAZ
         p8iKNF3TAvUxJWRJs1zkgyGjQBHGkXYBK3eRPCRGSR36n5Pv2sXyiMcvZHMz1PmVaL69
         zQq5hmNcDyse24S7gMuQmQ29A421Lv5DQlKAflqg6hXEaius6udaqPhW42AtjJIWfFb3
         BwPgZeUubbWbQTWWm80CHkr+WVqMAh9gLRbPnaJo/R42PXXuuR9+eGoSQiTe42B5ITKs
         bkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678115635;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+nNvkpchLnkczpLTpflAGsHRqbPoVTogqo6z26wUpc=;
        b=hWecRgKowKnSK8lk2Ku9MUtQR2t5mIBQfJWqv8tkCvSqItJvCzQiKJZgqQk8M3hRch
         WQUg9h0JnZTaa3UbHML7oyefBs3naxYEl0wFQQ6ccj7g9vaNWZGGNHOu0SmtQOTEXQl0
         GDivK0HzcPdlvfPolv5/pSD7cgE4bKGS0XqtEQV7x/X+D9Lgv5/DkMQHj87V+6nI2HQW
         L4IqiYVYGcGmE6xcxhJ19v7QGHqPJ+/YN8R6lMkzqkXy3Eb0hPMHa1m9FogiclRvuZnL
         yvoVMHOIjRgnw7c1ENdpe0YjRyB2Mi3pnNwmCM6pbcFjXEREg6KX1WSGLPHcvakR8qSH
         Dd9A==
X-Gm-Message-State: AO0yUKUSzpXdv2W+UPnSi9cqDIU78zio0TEQKe5kx3gANWBoxd79v58V
        /FjKJrSU0pXZ14bJvMvK6SI=
X-Google-Smtp-Source: AK7set/pABW2A3R+yvmnZ+uVbbg7070C3b+GZe8dZfCUVbk0PnIwHWKumbiX+5I9+Y03RK/sa9ifsQ==
X-Received: by 2002:a05:6a21:3385:b0:cd:238f:4f4b with SMTP id yy5-20020a056a21338500b000cd238f4f4bmr12367948pzb.23.1678115634642;
        Mon, 06 Mar 2023 07:13:54 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id e14-20020a63d94e000000b0050362744b63sm6211900pgj.90.2023.03.06.07.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 07:13:54 -0800 (PST)
Message-ID: <38cb9f23-a56a-f420-5942-0bfeb620306e@gmail.com>
Date:   Tue, 7 Mar 2023 00:13:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To:     carlos.bilbao@amd.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sergio.collado@gmail.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <20230306134420.30210-1-carlos.bilbao@amd.com>
Subject: Re: [PATCH] docs/sp_SP: Add process deprecated translation
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20230306134420.30210-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Carlos,

Minor nits in the Subject and Sob area.

On Mon, 6 Mar 2023 07:44:20 -0600, Carlos Bilbao wrote:
> Subject: [PATCH] docs/sp_SP: Add process deprecated translation

This summary looks ambiguous to me.

Maybe

   docs/sp_SP: Add translation of process/deprecated 

??

> Translate Documentation/process/deprecated.rst into Spanish.
> 
> Co-developed-by: Carlos Bilbao <carlos.bilbao@amd.com>
> Signed-off-by: Sergio Gonzalez <sergio.collado@gmail.com>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>

To me, Co-developed-by: from the author of the patch looks
strange, because it is obvious the author did some development on
the patch.

Which is your intent:

   Author: Carlos
   Co-developer: Sergio

, or

   Author: Sergio
   Co-developer: Carlos

???

        Thanks, Akira

> ---
>  .../translations/sp_SP/process/deprecated.rst | 381 ++++++++++++++++++
>  .../translations/sp_SP/process/index.rst      |   1 +
>  2 files changed, 382 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/process/deprecated.rst
[...]
