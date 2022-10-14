Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203995FE7BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJNDvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJNDvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:51:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49764194FBC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:51:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so3655658pjo.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWjApJI4JNZHfO1wqUfGnv95cKpErXJAS+55629c2bk=;
        b=VmIWPcPiCZxqcoGXdnuXZxm7e6pChtGwH318SS+1jTPr1oHT253K8dZfRKlVFeam3G
         DuirwBgHQOSvqa1lI75zGZ5VOJnVhbdDnVq9+0OJ2BUC5EWC1rOsiOYzJIzRBFIjhuyr
         Grpp6ZXinhVmbYXbDedkHZqaM9E/Y3AgryHmHL7R7ylMX5Up1Lgl7/erw7KJrr1QWXmU
         MhdkvR63JRaNCIlDHzR8iPobMghm5CiRDfqULimL7g/vAeJ5BZp1APKeqcSMKu2BBMtl
         nAglz67ABSV0nhPG5ymGwJf/mBauu7rNWUeuIyGngmKJAvvixr0jlWfl55fKyIWIatxf
         2ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWjApJI4JNZHfO1wqUfGnv95cKpErXJAS+55629c2bk=;
        b=p0a39pJ7T4ylHWwlO80Cvky+rmHibiXfTWwACse+Qj3TxLmIE4CanxnXFvPDLpXrMl
         Kxhg72oEo22Bkl4996gjXj+nrbWtgy4b/FuDvfUaDwOU29h3bC4XAmUmkqm7P/qRL+yA
         xQIJFLpxtaapAivkm3NFVD+LFcR2EgxSsSo9ZzCClIUAvB3p6vMlOpIHdQgO1p4MlEnm
         TpaEFeziZsL0TZEssEDximrBe53ccZEq0D9rIuBw2vxPCJ4vubTkK7fD5YVbb0DBSdBp
         nLqzXSG3FRAzAGisRNnc75N5aRudfFEdO68Y53Iycqql1QefXRB19peM+bfGKWXIxmPB
         zz7A==
X-Gm-Message-State: ACrzQf3Xs39rrDuTtiU2GEHsBpmUTVN9hv+Inz5d/lDNkfWzEmQAEWOI
        +Z4lO/GTb/u+ytZyGXVSw2acxg==
X-Google-Smtp-Source: AMsMyM4QEKu6EX27zxV8ipxn0Nw4QotfysUbIy6UNphO0CD1wv9aOtTylIXONBPVqnGgGSu22a6LuA==
X-Received: by 2002:a17:902:c7ca:b0:181:927a:9449 with SMTP id r10-20020a170902c7ca00b00181927a9449mr3329473pla.11.1665719473699;
        Thu, 13 Oct 2022 20:51:13 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b00177efb56475sm596122plb.85.2022.10.13.20.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:51:13 -0700 (PDT)
Date:   Thu, 13 Oct 2022 20:51:13 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Oct 2022 19:58:43 PDT (-0700)
Subject:     Re: [PATCH] MAINTAINERS: update the 'T:' entry for xtensa
In-Reply-To: <20221014004150.2470359-1-jcmvbkbc@gmail.com>
CC:     linux-xtensa@linux-xtensa.org, chris@zankel.net,
        linux-kernel@vger.kernel.org, jcmvbkbc@gmail.com,
        Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     jcmvbkbc@gmail.com
Message-ID: <mhng-60ebc2fe-ff0c-4ad1-a24b-7f5368345b1a@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 17:41:50 PDT (-0700), jcmvbkbc@gmail.com wrote:
> All development activity for xtensa architecture have been routed
> through the github.com/jcmvbkbc/linux-xtensa tree for the last few
> years. Update the 'T:' entry in the MAINTAINERS file to reflect that.
>
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 72b9654f764c..98cf4476d135 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20097,7 +20097,7 @@ M:	Chris Zankel <chris@zankel.net>
>  M:	Max Filippov <jcmvbkbc@gmail.com>
>  L:	linux-xtensa@linux-xtensa.org
>  S:	Maintained
> -T:	git git://github.com/czankel/xtensa-linux.git
> +T:	git https://github.com/jcmvbkbc/linux-xtensa.git
>  F:	arch/xtensa/
>  F:	drivers/irqchip/irq-xtensa-*

I'm assuming this means you're taking it through your tree?  That's 
great on my end, just trying to be explicit on these as I've blasted 
~30 repos and this is going to be a tracking mess on my end.
