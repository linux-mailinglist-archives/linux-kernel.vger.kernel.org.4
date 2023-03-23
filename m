Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA196C70D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjCWTPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCWTPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:15:37 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEBC9001
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:15:27 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 31so6873765qvc.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679598927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqRCAEE7Ga0rL8a78rFY8PhrE0MOGxxeV4bDOfZzVMc=;
        b=S6k0i2TM5bAtIS7AvbpLJbYQzCyiIVaB+BZkzZnP/XTAawaYa4ctKj6S1bSOB/qHey
         mvmb2sscDcePb9cGO3P4o/5UtMjX8Fm30pkkA4pIXs84VNhDy/XAG+5mO8wuNohS0XHx
         p9ejcRm4b0cYwOZjpm6bBlgZ+3xUVDUbL4Gd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679598927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqRCAEE7Ga0rL8a78rFY8PhrE0MOGxxeV4bDOfZzVMc=;
        b=qq5b7klnO4XsnvfGOEt2vhugMOqjSnLFWDP26XwAQk42WdRp6VfjMG14RWToq8qA9G
         SwH6gPL7nvrbci5pu2XnjiwuxUjv5s/cbUjaFDevd/6Qp75jxwoedf/bmSpz0nprzKSx
         i3KVEo/+33/iiK6REDHiGH/bS/9mPm64pYcbgxvlkQiVAREMZHjiOJ1upuFqDNjQnGZg
         HvyrcNffPePZMZO/Sy4RrWFV301A1HktCb9iIKJqCDT1RXBcBn+HMBmqQZ7E7aniKAtA
         sSBY+kx2QVCy6ajoIimfhhnOAPRekh0Iyr0FhxjE7w8aEHZVU5LFNS3+q3fe4op1/lKZ
         hJDg==
X-Gm-Message-State: AO0yUKXYjBTQwZTR/ymjCkGSrt1zOVKH6v3qj42wexEaJORLvT8ddvYq
        Xs1y0sP4+ug64wZPv9eeRjFwaXejDiiseZ+zDUQ=
X-Google-Smtp-Source: AK7set9Hf1zvg985ro2+Jiybh+qJfGNnuRk4LhnOMOXjoW4PV/wct8oFIcPyAiY02FuUqU0ZoTZLYQ==
X-Received: by 2002:a05:6214:20a6:b0:5c2:7de9:ec97 with SMTP id 6-20020a05621420a600b005c27de9ec97mr10254822qvd.13.1679598927031;
        Thu, 23 Mar 2023 12:15:27 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id oj9-20020a056214440900b005dd8b9345bbsm80603qvb.83.2023.03.23.12.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 12:15:26 -0700 (PDT)
Date:   Thu, 23 Mar 2023 19:15:26 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Zqiang as a RCU reviewer
Message-ID: <20230323191526.GA628693@google.com>
References: <20230323040729.145154-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323040729.145154-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:07:29PM +0800, Zqiang wrote:
> I have spent about two years studying and contributing to RCU,
> and sharing RCU-related knowledge within my team, if possible,
> please consider me as R ;-).
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

I am pulling this and the one adding Boqun for 6.4 based on discussion with Paul.

Congrats. ;-)

thanks,

 - Joel


> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d5bc223f305..b304d3c7b45b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17642,6 +17642,7 @@ R:	Steven Rostedt <rostedt@goodmis.org>
>  R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  R:	Lai Jiangshan <jiangshanlai@gmail.com>
>  R:	Joel Fernandes <joel@joelfernandes.org>
> +R:	Zqiang <qiang1.zhang@intel.com>
>  L:	rcu@vger.kernel.org
>  S:	Supported
>  W:	http://www.rdrop.com/users/paulmck/RCU/
> -- 
> 2.25.1
> 
