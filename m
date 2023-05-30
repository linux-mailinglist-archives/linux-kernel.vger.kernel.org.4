Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703AA7162D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjE3N66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjE3N6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:58:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A0EF7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:58:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-307d20548adso2884186f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685455128; x=1688047128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdOFQT9QGCau59bHLPd6rRMxmv8ze550SRwO31KCFbo=;
        b=Iw12FCXYG1FQW82rir6GYU2Dvz+V0iqVcnckCSMnorc8/fyHEnADPJt0uMF+tsA2Bw
         PV10FSCNiCghM7VXk5jiW5gPopcSOKTjs/oL5iW4teAyWvIbw6zIP+1Ya4U734gYm4Ao
         MSA40u+vrMUHaRKZXPldVj8KJX9SZhs/2W6uXkwub0cNNBZWK76jenBXWYZZ87Zx3GA7
         vts3S7rT3tvldCOkDzUUgE0SfN4kQCNVB0Q5Kzfc2JhGGfGf84LG9C025dNVlhq2y5bI
         XRACWMYnBtwkWzb3P3/vG6pCASVBOS0JzGyiap6LWu/x646yADOFnkRmyh/Qtm01Krzy
         +1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685455128; x=1688047128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdOFQT9QGCau59bHLPd6rRMxmv8ze550SRwO31KCFbo=;
        b=ATMy2AY0HQnJYjPRKNAcGId7jHwlcuJVEAH1RWfSJL8QQx1SoKDboBqGXP0BlK2Ht8
         1rQoJLpoZpvcjJrGyRKxUThCfp272S9wKBnWFUsXJf/Vn5bESGCXq0ECqUuDDrwKHnrT
         Z+nToQLjDY04P+oT8WEWGy5Gwh0Lw0/bRAZGlyrQ5L7NmlTzYIVXjr9+suPwfE+K15FS
         X7zmIEAGmvMPOSCuaFbio0XdVzfkWN6q8KlXZ6m6/470vj0/ZvwMnclrC3GOh5YFjhD1
         ybEZrTAR5BhHvfTkMR5fkHgYa8vb1yf+SCRp2qGOl0J4T18Wpez3LSG3gMBGf/rYlQqp
         5e3g==
X-Gm-Message-State: AC+VfDyVCZDeQPZu6HoycxXg3EWJ4EXxDcrvmW+DsrYtxTOb4Ip5UeQN
        GLKwuFikpS8QH8+jP7Qip8RgtA==
X-Google-Smtp-Source: ACHHUZ7gClGW/RNlcSsPPzcfPDQ3QOTjtpXfK0sB7K+aNfqLKFeOMTI5q1cV7i8/4WpYumWm9WbuKA==
X-Received: by 2002:a5d:408e:0:b0:2ef:ba4f:c821 with SMTP id o14-20020a5d408e000000b002efba4fc821mr1579352wrp.36.1685455128679;
        Tue, 30 May 2023 06:58:48 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d490b000000b003063a92bbf5sm3361859wrq.70.2023.05.30.06.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 06:58:46 -0700 (PDT)
Date:   Tue, 30 May 2023 16:58:43 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Deepanshu Kartikey <kartikey406@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Staging: rts5208: rtsx: Removed new line in else and
 else if
Message-ID: <7acfc70d-c136-4493-bfc0-9419fe13e3a6@kili.mountain>
References: <20230530135120.37637-1-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530135120.37637-1-kartikey406@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 07:21:20PM +0530, Deepanshu Kartikey wrote:
> Removed new line in else and else if,
> this warning was given by checkpatch.pl
> 
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> 
> ---
> Changes in V5
> 	- Moved else and else if to the same line
> 	- Moved comment on else and else if statement to inside of it

LGTM.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

