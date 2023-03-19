Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320436C02CB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCSP34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjCSP3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:29:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4F72069E;
        Sun, 19 Mar 2023 08:29:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v25so4784408wra.12;
        Sun, 19 Mar 2023 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679239775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hY0EMECb+dmHokMSURdlM32Gpn5JP+u/N1FKwGkEAts=;
        b=n+RrVyd6fFMRA8UWI6XgR07YalEDm8YOV8wjZH57rsH8i1Ur32E1gfOgMZDELQSHUG
         aCxPUeVWYOEXqd9rmcWfhrkI5cAyEKlEx48VmUR1oH6F1jWeiSigKlN+ELFegI+rjOAV
         oTgmjGxOzj0SBY4Km2lBwa3BK6ilqJtG2OlJxuEzY0prIOWfLgxY8Zi5CTe6ZYXqi6FS
         JUZPbv93P1gAN9oHA4C0t97sRvbsGyuxOojQm+K+7fM+S9f1U96l+f23mudrPYfnzZdd
         0bCloJqXEmzZukpuatbkyuYILLs/iklj4Zyk+wDg0Q3ivE7kZtyvopDzJFiVZSw8zeCO
         akLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679239775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY0EMECb+dmHokMSURdlM32Gpn5JP+u/N1FKwGkEAts=;
        b=6gd3sXhl2IcoVjsqaLLzV8rGSHOwC/k9PQqCHt9QfRz/W5xD5hLJgC5KI12o+ygT1u
         Vt2Rdw9byJGK1Zz87gSIxOjxYvavlnU21Wc92/ThTQZK5UE37IxQH/JxdXR244gTKlEb
         DfBQLawpQjpUEjR+EoafKRJ3jE+AUSpm5IZ4VBT2SU+GQdihdPAZLsggGjECOrJe1QWN
         SzgX8EaQmwfFNABNv5jl6nqe4kXsyS7TGibmwtCEnyvtm5CqAqaZUF/0UFMpuCIlMBXn
         HUPqNJx8An9bxBW8aALC8Mdd4taM8/JTbU6U8CCnLtd92ZohrtD+XyDOqAT/v87R4aAI
         kkqg==
X-Gm-Message-State: AO0yUKWX6+mZRutv+JPxKc8lkcn8BuyZZTDbs2B8Oqfwz9r5IbV5ON0C
        L1CT+Uh8sKyyWnHsVea8oV8=
X-Google-Smtp-Source: AK7set8S1Vod1tIE8cPVn3SyfEVRAD8G8vUWe/KOsvJs1QxJeMX3QZCU+N2sMvMSuvhsr0hLGcoOAA==
X-Received: by 2002:adf:edc7:0:b0:2c8:9cfe:9e29 with SMTP id v7-20020adfedc7000000b002c89cfe9e29mr11183394wro.38.1679239775100;
        Sun, 19 Mar 2023 08:29:35 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id m23-20020a056000181700b002c5694aef92sm6740489wrh.21.2023.03.19.08.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 08:29:34 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 19 Mar 2023 16:29:30 +0100
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org
Subject: Re: [PATCH 4/7] ftrace: Rename _ftrace_direct_multi APIs to
 _ftrace_direct APIs
Message-ID: <ZBcqWqWyq0uW/wj7@krava>
References: <20230316173811.1223508-1-revest@chromium.org>
 <20230316173811.1223508-5-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316173811.1223508-5-revest@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 06:38:08PM +0100, Florent Revest wrote:

SNIP

> diff --git a/samples/Kconfig b/samples/Kconfig
> index 30ef8bd48ba3..fd24daa99f34 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -38,7 +38,7 @@ config SAMPLE_FTRACE_DIRECT
>  	  that hooks to wake_up_process and prints the parameters.
>  
>  config SAMPLE_FTRACE_DIRECT_MULTI

nit, we could perhaps remove this config option as well
and use SAMPLE_FTRACE_DIRECT_MULTI

jirka

> -	tristate "Build register_ftrace_direct_multi() example"
> +	tristate "Build register_ftrace_direct() on multiple ips example"
>  	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS && m
>  	depends on HAVE_SAMPLE_FTRACE_DIRECT_MULTI
>  	help
